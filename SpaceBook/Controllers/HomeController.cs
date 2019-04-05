﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SpaceBook.Models;
using SpaceBook.ViewModels;
using SpaceBook.Models.MetaData;
using System.IO;
using System.Data.Entity;
using System.Net;
using System.Net.Mail;

namespace SpaceBook.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            using (var context = new SpaceBookEntities1())
            {
                List<TagType> list = context.TagTypes.ToList();
                return View(list);
            }
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        [HttpPost]
        public ActionResult SearchResultsName()
        {
            using (var context = new SpaceBookEntities1())
            {
                var results = new List<Facility>();
                var nameString = Request.Form["nameInput"];
                foreach (var item in context.Facilities.Where(x => x.ActiveFlag == true).ToList())
                {
                    if (item.Name.ToUpper().Contains(nameString.ToUpper()))
                        results.Add(item);
                }
                return View("SearchResults", results);
            }
        }

        [HttpPost]
        public ActionResult SearchResultsTags()
        {
            using (var context = new SpaceBookEntities1())
            {
                var results = new List<Facility>();
                var tagName = Request.Form["tagInput"];
                var tag = context.TagTypes.Where(x => x.Name == tagName).FirstOrDefault();
                if (tag == null)
                    return View("SearchResults", results);

                var tagAssignments = context.TagAssignments.Where(x => x.TagId == tag.Id).ToList();

                foreach (var item in tagAssignments)
                {
                    results.Add(context.Facilities.Where(x => x.Id == item.FacilityId).FirstOrDefault());
                }

                return View("SearchResults", results);
            }
        }

        public ActionResult ViewFacility(Int32 id)
        {
            using (var context = new SpaceBookEntities1())
            {
                var facility = context.Facilities.Include(x => x.Reviews).Where(x => x.Id == id).FirstOrDefault();
                foreach (var review in facility.Reviews)
                {
                    review.User.FirstName.First();
                    review.User.LastName.First();
                }
                return View(facility);
            }
        }

        [HttpGet]
        public ActionResult ViewFacilityAvailability(Int32 facilityId, string dateMondayString)
        {
            using (var context = new SpaceBookEntities1())
            {
                //gets the monday of the currently selected week
                DateTime date = DateTime.Parse(dateMondayString);

                //need to only pass in bookings from the same week
                //gets the beginning and end of the weeks the user has selected
                DateTime selectedWeekDateTime = date;
                DateTime selectedWeekNext = date.AddDays(7);

                //checks the following:
                //booking is for the currently selcted facility
                //booking is active
                //booking is in the same year as the week the user has selected
                //booking is during the week the user has selected
                var bookings = context.Bookings.Where(b => b.FacilityId == facilityId && b.Cancelled == false
                && b.StartDateTime.Value.Year.ToString() == selectedWeekDateTime.Year.ToString()
                && b.StartDateTime.Value >= selectedWeekDateTime
                && b.StartDateTime.Value <= selectedWeekNext
                ).ToList().OrderBy(b => b.Id).ToList();

                var times = context.FacilityTimes.Where(x => x.FacilityId == facilityId).ToList().OrderBy(x => x.StartTime).ToList();
                //passes relevant time slots and bookings to the view
                var viewModel = new facilityTimesAndBookingsViewModel(times, bookings);
                viewModel.selectedDateMonday = date;

                if (times.Count > 0)
                {
                    foreach (FacilityTime time in times)
                    {
                        time.Facility.Name.FirstOrDefault();
                    }
                }

                return View(viewModel);
            }
        }

        [HttpGet]
        public ActionResult PartialViewTimes(int day, int facilityId, string dateMondayString)
        {
            using (var context = new SpaceBookEntities1())
            {
                //gets the currently selected week
                DateTime date = DateTime.Parse(dateMondayString);

                //need to only pass in bookings from the same week
                DateTime selectedWeekDateTime = date;
                DateTime selectedWeekNext = selectedWeekDateTime.AddDays(7);

                //checks the following:
                //booking is for the currently selcted facility
                //booking is active
                //booking is in the same year as the week the user has selected
                //booking is during the week the user has selected
                var bookings = context.Bookings.Where(b => b.FacilityId == facilityId && b.Cancelled == false
                && b.StartDateTime.Value.Year.ToString() == selectedWeekDateTime.Year.ToString()
                && b.StartDateTime.Value >= selectedWeekDateTime
                && b.StartDateTime.Value <= selectedWeekNext
                ).ToList().OrderBy(b => b.Id).ToList();

                //passes relevant time slots and bookings to the view
                var times = context.FacilityTimes.Where(x => ((x.Day == day) && (x.FacilityId == facilityId))).ToList().OrderBy(x => x.StartTime).ToList();
                var viewModel = new facilityTimesAndBookingsViewModel(times, bookings);
                viewModel.selectedDateMonday = date;

                if (times.Count > 0)
                {
                    foreach (FacilityTime time in times)
                    {
                        time.Facility.Name.FirstOrDefault();
                    }
                }
                return PartialView(viewModel);
            }

        }

        //checks for an intersection bewtween time slots and bookings
        //It should have already been ensured that the time slot and booking occur in the same week
        public string getIntersection(Booking booking, FacilityTime time, string dateMondayString, int day_of_week)
        {
            //gets the currently selected week
            DateTime date = DateTime.Parse(dateMondayString);

            //finds the the day of the week of the booking and the date for the time slot
            int booking_day_of_week = (int)booking.StartDateTime.Value.DayOfWeek == 0 ? 7 : (int)booking.StartDateTime.Value.DayOfWeek;
            //checks if the booking and time slot are on the same day between a booking and time slot
            if (day_of_week != booking_day_of_week)
                return "0";

            TimeSpan timeSlotStartTime = time.StartTime.Value;
            //sets the end time of a time slot to 29m 59s after the start of the time slot
            TimeSpan timeSlotEndTime = time.StartTime.Value.Add(new TimeSpan(0, 29, 59));

            TimeSpan bookingStartTime = booking.StartDateTime.Value.TimeOfDay;
            TimeSpan bookingEndTime = booking.EndDateTime.Value.TimeOfDay;

            //Compare = 0 -> equal, Compare < 0 -> t1 is earlier than t2, Compare > 0 -> t1 is later than t2
            int bookingStartBeforeTimeSlotEnd = TimeSpan.Compare(bookingStartTime, timeSlotEndTime);
            int bookingEndAfterTimeSlotStart = TimeSpan.Compare(timeSlotStartTime, bookingEndTime);

            //returns whether the time slot and booking are intersecting as indicated by the above comparisons
            if (bookingStartBeforeTimeSlotEnd <= 0 && bookingEndAfterTimeSlotStart <= 0)
                return "1";
            else
                return "0";
        }

        //checks to see if a given timeslot is before today's date and time
        public string isBeforeCurrentDayTime(FacilityTime time, string dateMondayString, int day_of_week)
        {
            //gets the currently selected week
            DateTime date = DateTime.Parse(dateMondayString);

            //gets today's day of the week
            int day_of_week_now = (int)DateTime.Now.DayOfWeek == 0 ? 7 : (int)DateTime.Now.DayOfWeek;
            //Gets reference monday using DateTime.Now
            DateTime refMonday = DateTime.Now.AddDays((Convert.ToInt32(DayOfWeek.Monday) - day_of_week_now));
            refMonday = new DateTime(refMonday.Year, refMonday.Month, refMonday.Day, 0, 0, 0);

            //Compare = 0 -> equal, Compare < 0 -> t1 is earlier than t2, Compare > 0 -> t1 is later than t2
            //If todays date and the selected date are not in the same week or earlier, return false
            var isWeekEarlier = DateTime.Compare(refMonday, date);
            if (isWeekEarlier < 0)
                return "0";
            else if (isWeekEarlier > 0)
                return "1";

            //gets day of current timeslot
            int day = time.Day.Value;
            //Compare = 0 -> equal, Compare < 0 -> t1 is earlier than t2, Compare > 0 -> t1 is later than t2
            int timeBefore = TimeSpan.Compare(DateTime.Now.TimeOfDay, time.StartTime.Value);

            //checks if the selected day of the week is before today's day of the week
            //OR checks today's day is the current day and that the timeslot is earlier than(or at the same time as) the current time
            if (day < day_of_week_now || (day == day_of_week_now && timeBefore >= 0))
                return "1";

            return "0";
        }

        [HttpPost]
        public bool makeBooking(String StartTime, String EndTime, String cost, string dateMondayString, int day_of_week, int facilityID)
        {

            using (var context = new SpaceBookEntities1())
            {
                //gets the currently selected week
                DateTime date = DateTime.Parse(dateMondayString);

                Booking newBooking = new Booking();
                if (ModelState.IsValid)
                {

                    //we are keeping track of user id so the value can be pulled from the session
                    var uID = Convert.ToInt32(Session["UserID"]);
                    var FacID = facilityID;

                    newBooking.UserId = uID;
                    newBooking.FacilityId = FacID;
                    newBooking.Cancelled = false;

                    //gets the date of the booking
                    DateTime currentDate = date;
                    currentDate = currentDate.AddDays(day_of_week - 1);

                    //adds the time to the booking
                    DateTime StartTimeBooking = currentDate.Add(TimeSpan.Parse(StartTime));
                    DateTime EndTimeBooking = currentDate.Add(TimeSpan.Parse(EndTime));

                    newBooking.StartDateTime = StartTimeBooking;
                    newBooking.EndDateTime = EndTimeBooking;

                    //sets cost of the booking according to the value passed in
                    Decimal bookingCost = Convert.ToDecimal(cost);

                    newBooking.Cost = bookingCost;

                    context.Bookings.Add(newBooking);
                    

                    //sends notification to the facility owner
                    Notification notification = new Notification();
                    notification.UserId = context.Facilities.Where(x => x.Id == FacID).FirstOrDefault().OwnerId.Value;
                    notification.Message = context.Users.Where(x => x.Id == uID).FirstOrDefault().FirstName.ToString() + " has made a booking at the facility: " + context.Facilities.Where(x => x.Id == FacID).FirstOrDefault().Name.ToString()
                        + ", scheduled for " + AdjustTime(newBooking.StartDateTime.Value.TimeOfDay).ToString() + " to " + AdjustTime(newBooking.EndDateTime.Value.TimeOfDay).ToString(); ;
                    notification.ActiveFlag = true;
                    notification.IsReadFlag = false;
                    notification.DateTime = DateTime.Now;
                    notification.Type = 1; //facilityOwner_venueBooked
                    context.Notifications.Add(notification);

                    context.SaveChanges();
                    return true;
                }
                return false;
            }
        }

        //returns a timespan in 12 hour format as a string with AM/PM indicator
        public string AdjustTime(TimeSpan time)
        {
            string modifiedTime = " ";

            //if the hour is midnight 12 hours are added, assign AM to the time
            if (time.Hours == 0)
            {
                time = time.Add(new TimeSpan(12, 0, 0));
                modifiedTime = time.ToString("hh':'mm' AM'");
            }
            //if the hour is noon, assign PM to the time
            else if (time.Hours == 12)
            {
                modifiedTime = time.ToString("hh':'mm' PM'");
            }
            //If the time is after noon, adjust by 12 hours and assign PM to the time
            else if (time.Hours > 12)
            {
                time = time.Subtract(new TimeSpan(12, 0, 0));
                modifiedTime = time.ToString("hh':'mm' PM'");
            }
            //If the time is before noon, use AM
            else
            {
                modifiedTime = time.ToString("hh':'mm' AM'");
            }

            return modifiedTime;
        }

        //used to parse manually entered dates
        [HttpPost]
        public ActionResult parseDateString(int month = 0, int day = 0, int year = 0, int facId = 0)
        {
            string dateString = month.ToString("00") + "-" + day.ToString("00") + "-" + year.ToString("0000"); //date in format MM-dd-yyyy
            DateTime dt;
            bool valid = DateTime.TryParse(dateString, out dt);

            int day_of_week_now = (int)DateTime.Now.DayOfWeek == 0 ? 7 : (int)DateTime.Now.DayOfWeek;
            //Gets reference monday using DateTime.Now
            DateTime refMonday = DateTime.Now.AddDays((Convert.ToInt32(DayOfWeek.Monday) - day_of_week_now));
            refMonday = new DateTime(refMonday.Year, refMonday.Month, refMonday.Day, 0, 0, 0);

            var isWeekEarlier = -1;

            //if the date string is valid, check when it is relative to the current week
            if (valid)
            {
                int dt_day_of_week = (int)dt.DayOfWeek == 0 ? 7 : (int)dt.DayOfWeek;
                dt = dt.AddDays(Convert.ToInt32(DayOfWeek.Monday) - dt_day_of_week);
                dt = new DateTime(dt.Year, dt.Month, dt.Day, 0, 0, 0);

                //Compare = 0 -> equal, Compare < 0 -> t1 is earlier than t2, Compare > 0 -> t1 is later than t2
                //If todays date and the selected date are not in the same week or earlier, return false
                isWeekEarlier = DateTime.Compare(refMonday, dt);
            }

            //if the date string is invalid or if it is earlier than or in the same week as the current week, load the view with the current week
            if (!valid || isWeekEarlier >= 0)
            {
                return RedirectToAction("ViewFacilityAvailability", new { facilityId = facId, dateMondayString = refMonday.ToString() });
            }
            else
            {
                return RedirectToAction("ViewFacilityAvailability", new { facilityId = facId, dateMondayString = dt.ToString() });
            }
        }

        [HttpGet]
        public ActionResult Login()
        {
            if (Session["UserID"] != null)
                return RedirectToAction("Index");
            return View();
        }

        [HttpPost]
        public ActionResult Login(LoginViewModel userParam)
        {
            using (var context = new SpaceBookEntities1())
            {
                if (ModelState.IsValid)
                {
                    var user = context.Users.Where(u => u.Email == userParam.Email).FirstOrDefault();
                    if (user != null)
                    {
                        if (user.Password == userParam.Password)
                        {
                            Session["UserID"] = user.Id.ToString();
                            return RedirectToAction("Index");
                        }
                    }
                    TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-danger", Message = "You have entered an invalid email or password. Please try again" };
                    return RedirectToAction("Login");
                }
                return RedirectToAction("Login");
            }
        }

        public ActionResult Logout()
        {
            Session.Abandon();
            return RedirectToAction("Login");
        }

        [HttpGet]
        public ActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ForgotPassword(string email)
        {
            using (var context = new SpaceBookEntities1())
            {
                //if the email passed in is not null, find a user with corresponding 
                if (!string.IsNullOrEmpty(email))
                {
                    //gets a user with the corresponding email
                    var user = context.Users.Where(u => u.Email == email).FirstOrDefault();

                    //if user with corresponding email exists
                    if (user != null)
                    {
                        var sender_address = new MailAddress("spacebookapp@gmail.com", "SpaceBook"); //sets up the address the email will be sent from (spacebook address, spacebook name)
                        string sender_password = "xdhvRxTVcxOt"; //sender password

                        var receiver_address = new MailAddress(user.Email, user.FirstName); //sets up the address the email will be sent to (user address, user first name)

                        string subject = "SpaceBook: Forgotten Password"; //subject of the email
                        string body = ""; //Body of the message

                        //temporary password
                        string tempPassword = "";
                        int pwd_length = 8;
                        Random rand = new Random(); //random number genrator

                        //generates random alphanumeric password
                        for (int i = 0; i < pwd_length; i++)
                        {
                            //20% chance charcter is a number
                            if (rand.Next(5) == 1)
                            {
                                tempPassword += (char)(rand.Next('9' - '0' + 1) + '0');
                            }
                            //otherwise, character is a letter
                            else
                            {
                                //50% chance character is uppercase
                                if (rand.Next(2) == 1)
                                {
                                    tempPassword += (char)(rand.Next('Z' - 'A' + 1) + 'A');
                                }
                                //otherwise, character is lowercase
                                else
                                {
                                    tempPassword += (char)(rand.Next('z' - 'a' + 1) + 'a');
                                }
                            }
                        }

                        var path = Server.MapPath(@"~/Content/Email_Templates/forgotPassword.txt"); //need this so the project root folder is used
                        try
                        {
                            using (StreamReader sr = new StreamReader(path, true))
                            {
                                body = "Hello " + user.FirstName + "," + '\n' + '\n'; //email greeting

                                //reads the email template until the end of the file
                                while (!sr.EndOfStream)
                                {
                                    body += sr.ReadLine() + '\n';
                                }

                                body += '\n' + "Temporary Password: " + tempPassword + '\n' + '\n'; //provides randomly generated temp password to the user

                                //email end tag
                                body += "Regards, " + '\n' + '\n';
                                body += "SpaceBook Team" + '\n';
                            }
                        }
                        //if the file cannot be opened, return to login
                        catch
                        {
                            return RedirectToAction("Login");
                        }

                        try
                        {
                            //settings for using gmail smtp
                            var smtp = new SmtpClient
                            {
                                Host = "smtp.gmail.com", //gmail smtp server
                                Port = 587, //gmail smtp port
                                EnableSsl = true, //uses SSL
                                DeliveryMethod = SmtpDeliveryMethod.Network, //uses the network to deliver the message
                                UseDefaultCredentials = false, //not using default credentials, using spacebookapp gmail account
                                Credentials = new NetworkCredential(sender_address.Address, sender_password) //authenticates the sender
                            };

                            //composes message with the previously determined subject and body and sends it
                            using (var message = new MailMessage(sender_address, receiver_address)
                            {
                                Subject = subject,
                                Body = body
                            })
                            {
                                smtp.Send(message); //sends email from sender to user
                            }
                        }
                        //if the email cannot be sent, retunr to login
                        catch
                        {
                            return RedirectToAction("Login");
                        }

                        //changes user password to the temporary password
                        user.Password = tempPassword;

                        context.SaveChanges();

                    }

                }
            }

            return RedirectToAction("Login");
        }

        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }

        [HttpGet]
        public ActionResult UserRegistration()
        {
            ViewBag.Message = "User registration page";

            return View();
        }

        [HttpPost]
        public ActionResult UserRegistration(User userParam, HttpPostedFileBase ProfilePicFile)
        {
            //checks if ProfilePicFile is null
            //if ProfilePicFile is null, it will explicity request the file and assign it to ProfilePicFile
            ProfilePicFile = ProfilePicFile ?? Request.Files["ProfilePicFileName"];

            using (var context = new SpaceBookEntities1())
            {
                User newUser = new User();
                if (ModelState.IsValid)
                {
                    //Checks to see if all parameters have been filled out
                    if (!string.IsNullOrEmpty(userParam.FirstName) &&
                        !string.IsNullOrEmpty(userParam.LastName) &&
                        !string.IsNullOrEmpty(userParam.Email) &&
                        !string.IsNullOrEmpty(userParam.Phone) &&
                        !string.IsNullOrEmpty(userParam.Password))
                    {

                        //assigns form values to the user fields
                        //User ID is autoincremented so no need to assign that
                        newUser.FirstName = userParam.FirstName;
                        newUser.LastName = userParam.LastName;
                        newUser.Email = userParam.Email;
                        newUser.Phone = userParam.Phone;
                        newUser.Password = userParam.Password;
                        //Sets the user to active and default type (1)
                        newUser.Type = 1;
                        newUser.ActiveFlag = true;

                        var ProfilePicFileName = "";
                        var ProfilePicFilePath = "";
                        var ProfilePicFolderPath = "~/Content/ProfilePics";

                        //If a file was selected, save the file to the specified folder
                        if (ProfilePicFile != null && ProfilePicFile.ContentLength > 0)
                        {
                            //gets the name of the file
                            ProfilePicFileName = Path.GetFileName(ProfilePicFile.FileName);
                            //Saves the uploaded picture to the specified folder
                            ProfilePicFilePath = Path.Combine(Server.MapPath(ProfilePicFolderPath), ProfilePicFileName);
                            ProfilePicFile.SaveAs(ProfilePicFilePath);
                            newUser.ProfilePicFilename = ProfilePicFileName;
                        }
                        else
                        {
                            //if no file was selected, use the default profile picture
                            newUser.ProfilePicFilename = "default.jpg";
                        }

                        //Adds the user to the User table in the database
                        context.Users.Add(newUser);
                        context.SaveChanges();
                        TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-success", Message = "Your account has been created." };
                        //Redirects the user to the login page when the "Create" button is pressed
                        return RedirectToAction("Login");
                    }
                }
            }

            /*
             * Triggered if the user fails to fill out all the fields before pressing the "Create" button.
             * This returns the user to the UserRegistration page to try again.
            */
            TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-danger", Message = "You have not entered a value for all fields. Please try again" };
            return RedirectToAction("UserRegistration");
        }

        [HttpGet]
        public ActionResult ViewUserProfile()
        {
            using (var context = new SpaceBookEntities1())
            {
                //ensures user is logged in
                if (Session["UserID"] != null)
                {
                    //gets the logged in user's UserID
                    var sessionID = Convert.ToInt32(Session["UserID"]);

                    //gets the user corresponding to the sessionID
                    var user = context.Users.Where(u => u.Id == sessionID && u.ActiveFlag == true).FirstOrDefault();

                    //if a matching user is found, go to the User profile view
                    if (user != null)
                    {
                        //passes the matching user to the view
                        return View(user);
                    }
                }

                //if the user is not logged in, return them to the login view
                return RedirectToAction("Login");
            }
        }


        [HttpGet]
        public ActionResult EditUserProfile(int id)
        {
            ViewBag.Message = "Edit User Profile Page";
            using (var context = new SpaceBookEntities1())
            {
                User user = context.Users.Where(u => u.Id == id).FirstOrDefault();
                return View(user);
            }
        }

        [HttpPost]
        public ActionResult EditUserProfile(User userParam, HttpPostedFileBase ProfilePicFile)
        {
            //checks if ProfilePicFile is null
            //if ProfilePicFile is null, it will explicity request the file and assign it to ProfilePicFile
            ProfilePicFile = ProfilePicFile ?? Request.Files["ProfilePicFileName"];

            using (var context = new SpaceBookEntities1())
            {
                var userID = Convert.ToInt32(Session["UserID"]);
                User myUser = context.Users.Where(u => u.Id == userID).FirstOrDefault();
                if (ModelState.IsValid)
                {
                    //assigns form values to the user fields
                    //User ID is autoincremented so no need to assign that
                    if (userParam.FirstName != null)
                        myUser.FirstName = userParam.FirstName;

                    if (userParam.LastName != null)
                        myUser.LastName = userParam.LastName;

                    if (userParam.Email != null)
                        myUser.Email = userParam.Email;

                    if (userParam.Phone != null)
                        myUser.Phone = userParam.Phone;

                    if (userParam.Password != null)
                        myUser.Password = userParam.Password;

                    var ProfilePicFileName = "";
                    var ProfilePicFilePath = "";
                    var ProfilePicFolderPath = "~/Content/ProfilePics";

                    //If a file was selected, save the file to the specified folder
                    if (ProfilePicFile != null && ProfilePicFile.ContentLength > 0)
                    {
                        //gets the name of the file
                        ProfilePicFileName = Path.GetFileName(ProfilePicFile.FileName);
                        //Saves the uploaded picture to the specified folder
                        ProfilePicFilePath = Path.Combine(Server.MapPath(ProfilePicFolderPath), ProfilePicFileName);
                        ProfilePicFile.SaveAs(ProfilePicFilePath);
                        myUser.ProfilePicFilename = ProfilePicFileName;
                    }
                    /*else
                    {
                        //if no file was selected, use the default profile picture
                        myUser.ProfilePicFilename = "default.jpg";
                    }*/

                    //Adds the user to the User table in the database
                    context.SaveChanges();

                    //Redirects the user to the login page when the "Create" button is pressed
                    return RedirectToAction("ViewUserProfile");
                }
                //}
            }

            /*
             * Triggered if the user fails to fill out all the fields before pressing the "Create" button.
             * This returns the user to the UserRegistration page to try again.
            */
            return RedirectToAction("ViewUserProfile");
        }

        [HttpGet]
        public ActionResult RegisterFacility()
        {
            return View("~/Views/Home/RegisterFacility/Info.cshtml");
        }

        public ActionResult RegisterFacilityInfo(RegisterFacilityViewModel facilityParam)
        {
            if (ModelState.IsValidField("Name") && ModelState.IsValidField("Description") && ModelState.IsValidField("Email") && ModelState.IsValidField("Phone") && ModelState.IsValidField("DefaultHourlyRate"))
            {
                ModelState.Clear();
                return View("~/Views/Home/RegisterFacility/Address.cshtml", facilityParam);
            }
            else
            {
                return View("~/Views/Home/RegisterFacility/Info.cshtml", facilityParam);
            }
        }

        public ActionResult RegisterFacilityAddress(RegisterFacilityViewModel facilityParam)
        {
            if (ModelState.IsValidField("Address") && ModelState.IsValidField("City") && ModelState.IsValidField("PostalCode") && ModelState.IsValidField("Province") && ModelState.IsValidField("Country"))
            {
                ModelState.Clear();
                return View("~/Views/Home/RegisterFacility/Hours.cshtml", facilityParam);
            }
            else
            {
                return View("~/Views/Home/RegisterFacility/Address.cshtml", facilityParam);
            }
        }

        public ActionResult RegisterFacilityAddressBack(RegisterFacilityViewModel facilityParam)
        {
            return View("~/Views/Home/RegisterFacility/Info.cshtml", facilityParam);
        }


        [HttpPost]
        public ActionResult RegisterFacilityComplete(RegisterFacilityViewModel facilityParam)
        {
            using (var context = new SpaceBookEntities1())
            {
                Facility newFacility = new Facility();
                newFacility.OwnerId = Convert.ToInt32(Session["UserID"]);

                List<string> monList = Request.Form["monStart"].Split(',').ToList<string>();
                monList.AddRange(Request.Form["monEnd"].Split(',').ToList<string>());
                List<string> monRates = Request.Form["monRate"].Split(',').ToList<string>();

                List<string> tueList = Request.Form["tueStart"].Split(',').ToList<string>();
                tueList.AddRange(Request.Form["tueEnd"].Split(',').ToList<string>());
                List<string> tueRates = Request.Form["tueRate"].Split(',').ToList<string>();

                List<string> wedList = Request.Form["wedStart"].Split(',').ToList<string>();
                wedList.AddRange(Request.Form["wedEnd"].Split(',').ToList<string>());
                List<string> wedRates = Request.Form["wedRate"].Split(',').ToList<string>();

                List<string> thuList = Request.Form["thuStart"].Split(',').ToList<string>();
                thuList.AddRange(Request.Form["thuEnd"].Split(',').ToList<string>());
                List<string> thuRates = Request.Form["thuRate"].Split(',').ToList<string>();

                List<string> friList = Request.Form["friStart"].Split(',').ToList<string>();
                friList.AddRange(Request.Form["friEnd"].Split(',').ToList<string>());
                List<string> friRates = Request.Form["friRate"].Split(',').ToList<string>();

                List<string> satList = Request.Form["satStart"].Split(',').ToList<string>();
                satList.AddRange(Request.Form["satEnd"].Split(',').ToList<string>());
                List<string> satRates = Request.Form["satRate"].Split(',').ToList<string>();

                List<string> sunList = Request.Form["sunStart"].Split(',').ToList<string>();
                sunList.AddRange(Request.Form["sunEnd"].Split(',').ToList<string>());
                List<string> sunRates = Request.Form["sunRate"].Split(',').ToList<string>();

                List<List<string>> dayList = new List<List<string>>();
                dayList.Add(monList);
                dayList.Add(tueList);
                dayList.Add(wedList);
                dayList.Add(thuList);
                dayList.Add(friList);
                dayList.Add(satList);
                dayList.Add(sunList);

                List<List<string>> rateList = new List<List<string>>();
                rateList.Add(monRates);
                rateList.Add(tueRates);
                rateList.Add(wedRates);
                rateList.Add(thuRates);
                rateList.Add(friRates);
                rateList.Add(satRates);
                rateList.Add(sunRates);


                if (ModelState.IsValid)
                {
                    newFacility.Name = facilityParam.Name;
                    newFacility.Description = facilityParam.Description;
                    newFacility.Email = facilityParam.Email;
                    newFacility.Phone = facilityParam.Phone;
                    newFacility.Address = facilityParam.Address;
                    newFacility.PostalCode = facilityParam.PostalCode;
                    newFacility.City = facilityParam.City;
                    newFacility.Province = facilityParam.Province;
                    newFacility.Country = facilityParam.Country;
                    newFacility.ActiveFlag = true;
                    newFacility.Type = 1; //
                    newFacility.HourlyRate = (decimal)facilityParam.DefaultHourlyRate;
                    newFacility.FacilityPhotoFileName = "defaultFacilityPhoto.jpg";


                    context.Facilities.Add(newFacility);
                    CreateTimeSlots(newFacility, dayList, rateList); //Creation of time slots
                    context.SaveChanges();

                    Session["FacilityId"] = newFacility.Id;

                    List<TagType> viewTypes = context.TagTypes.ToList();
                    return View("~/Views/Home/RegisterFacility/AddTags.cshtml", viewTypes);
                }

                return RedirectToAction("index");
            }
        }

        public void CreateTimeSlots(Facility newFacility, List<List<string>> dayList, List<List<string>> rateList)
        {
            using (var context = new SpaceBookEntities1())
            {
                for (int day = 1; day < 8; day++)
                {
                    List<string> currDay = dayList[day - 1];
                    List<string> currDayRate = rateList[day - 1];

                    TimeSpan interval = new TimeSpan(0, 0, 0);
                    for (int y = 0; y < 48; y++)  //y = number of time slots to create per day
                    {
                        FacilityTime newFacilityTime = new FacilityTime();
                        newFacilityTime.Facility = newFacility;
                        newFacilityTime.FacilityId = newFacility.Id;
                        newFacilityTime.StartTime = interval;
                        newFacilityTime.Day = day;
                        newFacilityTime.Rate = 0;
                        newFacilityTime.IsAvailable = false;

                        for (int i = 0; i < currDay.Count / 2; i++)
                        {
                            if (currDay[i] == "")
                                continue;

                            string startString = currDay[i].Remove(currDay[i].Length - 2, 2) + " " + currDay[i].Substring(currDay[i].Length - 2).ToUpper();
                            string endString = currDay[currDay.Count / 2 + i].Remove(currDay[currDay.Count / 2 + i].Length - 2, 2) + " " + currDay[currDay.Count / 2 + i].Substring(currDay[currDay.Count / 2 + i].Length - 2).ToUpper();

                            TimeSpan start = DateTime.ParseExact(startString, "h:mm tt", System.Globalization.CultureInfo.InvariantCulture).TimeOfDay;
                            TimeSpan end = DateTime.ParseExact(endString, "h:mm tt", System.Globalization.CultureInfo.InvariantCulture).TimeOfDay;

                            double rate = 0;
                            double halfRate = 0;
                            if (currDayRate[i] != null && currDayRate[i] != "")
                            {
                                rate = Math.Round(Convert.ToDouble(currDayRate[i]), 3);
                                halfRate = Math.Round(rate / 2, 3);
                            }


                            if ((interval >= start) && (interval < end))
                            {
                                newFacilityTime.IsAvailable = true;
                                if (rate != 0)
                                    newFacilityTime.Rate = (decimal)halfRate;

                                break;
                            }
                        }

                        context.FacilityTimes.Add(newFacilityTime);
                        interval = interval.Add(new TimeSpan(0, 30, 0));
                    }
                }
            }
            return;
        }

        [HttpPost]
        public ActionResult RegisterFacilityAddTags()
        {
            using (var context = new SpaceBookEntities1())
            {
                var facilityId = Convert.ToInt32(Session["FacilityId"]);
                List<string> tagIsCheckedList = Request.Form["checkedTags"].Split(',').ToList<string>();
                List<TagType> Tags = context.TagTypes.ToList();

                for (int i = 0; i < tagIsCheckedList.Count; i++)
                {
                    if (tagIsCheckedList[i] == "true")
                    {
                        TagAssignment newTagAssignment = new TagAssignment();
                        newTagAssignment.FacilityId = facilityId;
                        newTagAssignment.TagId = Tags[i].Id;

                        context.TagAssignments.Add(newTagAssignment);
                    }
                }

                context.SaveChanges();
                FacilityPhotoViewModel model = new FacilityPhotoViewModel();
                model.FacilityId = facilityId;
                return View("UploadFacilityPhoto", model);
            }
        }

        public ActionResult EditFacilityInfo(Int32 id)
        {
            if (Session["UserID"] != null)
            {
                using (var context = new SpaceBookEntities1())
                {
                    RegisterFacilityViewModel facViewModel = new RegisterFacilityViewModel();
                    Facility fac = context.Facilities.Where(x => x.Id == id).FirstOrDefault();
                    if (fac != null)
                    {
                        facViewModel.Name = fac.Name;
                        facViewModel.Description = fac.Description;
                        facViewModel.Email = fac.Email;
                        facViewModel.Phone = fac.Phone;
                        facViewModel.DefaultHourlyRate = (double)fac.HourlyRate;

                        facViewModel.Address = fac.Address;
                        facViewModel.City = fac.City;
                        facViewModel.Province = fac.Province;
                        facViewModel.PostalCode = fac.PostalCode;
                        facViewModel.Country = fac.Country;
                        facViewModel.Id = id;

                        return View("EditFacilityInfo", facViewModel);
                    }

                }
            }
            return RedirectToAction("Login");
        }

        public ActionResult EditFacilityAddress(RegisterFacilityViewModel facilityParam)
        {
            if (ModelState.IsValidField("Name") && ModelState.IsValidField("Description") && ModelState.IsValidField("Email") && ModelState.IsValidField("Phone") && ModelState.IsValidField("DefaultHourlyRate"))
            {
                ModelState.Clear();
                return View("EditFacilityAddress", facilityParam);
            }
            else
            {
                return View("~/Views/Home/EditFacility/Info.cshtml", facilityParam);
            }
        }


        public ActionResult EditFacilityComplete(RegisterFacilityViewModel facilityParam)
        {
            using (var context = new SpaceBookEntities1())
            {
                Facility record = context.Facilities.Where(x => x.Id == facilityParam.Id).FirstOrDefault();
                record.Name = facilityParam.Name;
                record.Description = facilityParam.Description;
                record.Email = facilityParam.Email;
                record.Phone = facilityParam.Phone;
                record.HourlyRate = (decimal)facilityParam.DefaultHourlyRate;

                record.Address = facilityParam.Address;
                record.City = facilityParam.City;
                record.Province = facilityParam.Province;
                record.PostalCode = facilityParam.PostalCode;
                record.Country = facilityParam.Country;

                context.SaveChanges();

                var userID = Convert.ToInt32(Session["UserID"]);
                List<Facility> ownersFacilities = context.Facilities.Where(x => x.OwnerId == userID && x.ActiveFlag == true).ToList();
                return View("OwnerFacilities", ownersFacilities);
            }
        }

        public ActionResult EditFacilityAddressBack(RegisterFacilityViewModel facilityParam)
        {
            return View("EditFacilityInfo", facilityParam);
        }

        public ActionResult EditFacilityHours(Int32 id)
        {
            using (var context = new SpaceBookEntities1())
            {
                RegisterFacilityViewModel facilityParam = new RegisterFacilityViewModel();
                facilityParam.DefaultHourlyRate = (double)context.Facilities.Where(x => x.Id == id).FirstOrDefault().HourlyRate;
                facilityParam.Id = context.Facilities.Where(x => x.Id == id).FirstOrDefault().Id;
                return View("EditFacilityHours", facilityParam);
            }

        }

        [HttpPost]
        public ActionResult EditFacilityHoursComplete(RegisterFacilityViewModel facilityParam)
        {
            using (var context = new SpaceBookEntities1())
            {

                List<string> monList = Request.Form["monStart"].Split(',').ToList<string>();
                monList.AddRange(Request.Form["monEnd"].Split(',').ToList<string>());
                List<string> monRates = Request.Form["monRate"].Split(',').ToList<string>();

                List<string> tueList = Request.Form["tueStart"].Split(',').ToList<string>();
                tueList.AddRange(Request.Form["tueEnd"].Split(',').ToList<string>());
                List<string> tueRates = Request.Form["tueRate"].Split(',').ToList<string>();

                List<string> wedList = Request.Form["wedStart"].Split(',').ToList<string>();
                wedList.AddRange(Request.Form["wedEnd"].Split(',').ToList<string>());
                List<string> wedRates = Request.Form["wedRate"].Split(',').ToList<string>();

                List<string> thuList = Request.Form["thuStart"].Split(',').ToList<string>();
                thuList.AddRange(Request.Form["thuEnd"].Split(',').ToList<string>());
                List<string> thuRates = Request.Form["thuRate"].Split(',').ToList<string>();

                List<string> friList = Request.Form["friStart"].Split(',').ToList<string>();
                friList.AddRange(Request.Form["friEnd"].Split(',').ToList<string>());
                List<string> friRates = Request.Form["friRate"].Split(',').ToList<string>();

                List<string> satList = Request.Form["satStart"].Split(',').ToList<string>();
                satList.AddRange(Request.Form["satEnd"].Split(',').ToList<string>());
                List<string> satRates = Request.Form["satRate"].Split(',').ToList<string>();

                List<string> sunList = Request.Form["sunStart"].Split(',').ToList<string>();
                sunList.AddRange(Request.Form["sunEnd"].Split(',').ToList<string>());
                List<string> sunRates = Request.Form["sunRate"].Split(',').ToList<string>();

                List<List<string>> dayList = new List<List<string>>();
                dayList.Add(monList);
                dayList.Add(tueList);
                dayList.Add(wedList);
                dayList.Add(thuList);
                dayList.Add(friList);
                dayList.Add(satList);
                dayList.Add(sunList);

                List<List<string>> rateList = new List<List<string>>();
                rateList.Add(monRates);
                rateList.Add(tueRates);
                rateList.Add(wedRates);
                rateList.Add(thuRates);
                rateList.Add(friRates);
                rateList.Add(satRates);
                rateList.Add(sunRates);

                EditTimeSlots(facilityParam.Id, dayList, rateList);

                var userID = Convert.ToInt32(Session["UserID"]);
                List<Facility> ownersFacilities = context.Facilities.Where(x => x.OwnerId == userID && x.ActiveFlag == true).ToList();
                return View("OwnerFacilities", ownersFacilities);
            }
        }

        public void EditTimeSlots(int id, List<List<string>> dayList, List<List<string>> rateList)
        {
            using (var context = new SpaceBookEntities1())
            {
                List<FacilityTime> FacilityTimeList = context.FacilityTimes.Where(x => x.FacilityId == id).ToList();

                if (FacilityTimeList.Count > 0)
                {
                    int iterator = 0;

                    for (int day = 1; day < 8; day++)
                    {
                        List<string> currDay = dayList[day - 1];
                        List<string> currDayRate = rateList[day - 1];

                        TimeSpan interval = new TimeSpan(0, 0, 0);
                        for (int y = 0; y < 48; y++)  //y = number of time slots to create per day
                        {
                            //FacilityTimeList[iterator].StartTime = interval;
                            //FacilityTimeList[iterator].Day = day;
                            FacilityTimeList[iterator].Rate = 0;
                            FacilityTimeList[iterator].IsAvailable = false;

                            for (int i = 0; i < currDay.Count / 2; i++)
                            {
                                if (currDay[i] == "")
                                    continue;

                                string startString = currDay[i].Remove(currDay[i].Length - 2, 2) + " " + currDay[i].Substring(currDay[i].Length - 2).ToUpper();
                                string endString = currDay[currDay.Count / 2 + i].Remove(currDay[currDay.Count / 2 + i].Length - 2, 2) + " " + currDay[currDay.Count / 2 + i].Substring(currDay[currDay.Count / 2 + i].Length - 2).ToUpper();

                                TimeSpan start = DateTime.ParseExact(startString, "h:mm tt", System.Globalization.CultureInfo.InvariantCulture).TimeOfDay;
                                TimeSpan end = DateTime.ParseExact(endString, "h:mm tt", System.Globalization.CultureInfo.InvariantCulture).TimeOfDay;

                                double rate = 0;
                                double halfRate = 0;
                                if (currDayRate[i] != null && currDayRate[i] != "")
                                {
                                    rate = Math.Round(Convert.ToDouble(currDayRate[i]), 3);
                                    halfRate = Math.Round(rate / 2, 3);
                                }


                                if ((interval >= start) && (interval < end))
                                {
                                    FacilityTimeList[iterator].IsAvailable = true;

                                    if (rate != 0)
                                        FacilityTimeList[iterator].Rate = (decimal)halfRate;

                                    break;
                                }
                            }

                            iterator++;
                            interval = interval.Add(new TimeSpan(0, 30, 0));
                        }
                    }
                    context.SaveChanges();
                }
                return;
            }
        }

        public ActionResult UnactivateFacility(bool confirm, Int32 id)
        {
            using (var context = new SpaceBookEntities1())
            {
                Facility fac = context.Facilities.Where(x => x.Id == id).FirstOrDefault();
                if (fac != null)
                {
                    fac.ActiveFlag = false;
                    context.SaveChanges();
                }

                var userID = Convert.ToInt32(Session["UserID"]);
                List<Facility> ownersFacilities = context.Facilities.Where(x => x.OwnerId == userID && x.ActiveFlag == true).ToList();
                return View("OwnerFacilities", ownersFacilities);
            }
        }

        public ActionResult ViewOwnerFacilities()
        {
            if (Session["UserID"] != null)
            {
                using (var context = new SpaceBookEntities1())
                {
                    var userID = Convert.ToInt32(Session["UserID"]);
                    List<Facility> ownersFacilities = context.Facilities.Where(x => x.OwnerId == userID && x.ActiveFlag == true).ToList();
                    return View("OwnerFacilities", ownersFacilities);
                }
            }
            return RedirectToAction("Login");
        }

        public ActionResult ViewBookings(string filter)
        {
            using (var context = new SpaceBookEntities1())
            {
                if (Session["UserID"] != null)
                {
                    var sessionID = Convert.ToInt32(Session["UserID"]);
                    var user = context.Users.Where(u => u.Id == sessionID && u.ActiveFlag == true).FirstOrDefault();
                    //var bookings = context.Bookings.Where(x => x.UserId == sessionID && x.Cancelled == false).ToList();
                    var bookings = context.Bookings.Include(b => b.Reviews).Where(x => x.UserId == sessionID && x.Cancelled == false).ToList();
                    if (bookings.Count > 0)
                        foreach (var booking in bookings)
                        {
                            booking.Facility.Name.FirstOrDefault();
                            booking.EndDateTime = booking.EndDateTime.Value.AddMinutes(30);
                        }
                    if (user != null)
                    {
                        if (filter == "upcoming")
                            foreach (Booking item in bookings.ToList())
                            {
                                if (item.EndDateTime <= DateTime.Now)
                                {
                                    bookings.Remove(item);
                                }
                            }

                        else if (filter == "completed")
                            foreach (Booking item in bookings.ToList())
                            {
                                if (item.EndDateTime > DateTime.Now)
                                {
                                    bookings.Remove(item);
                                }
                            }

                        return View("ViewBookings", bookings);
                    }
                }
                //if the user is not logged in, return to the login view
                return RedirectToAction("Login");
            }
        }

        public ActionResult OwnerViewBookings(string filter)
        {
            using (var context = new SpaceBookEntities1())
            {
                if (Session["UserID"] != null)
                {
                    var userId = Convert.ToInt32(Session["UserID"]);
                    var user = context.Users.Where(u => u.Id == userId && u.ActiveFlag == true).FirstOrDefault();
                    List<Facility> fac = context.Facilities.Where(x => x.OwnerId == userId && x.ActiveFlag == true).ToList();
                    var bookings = new List<Booking>();

                    for (int i = 0; i < fac.Count; i++)
                    {
                        var tempId = fac[i].Id;
                        List <Booking> tempBookings = context.Bookings.Include(b => b.Reviews).Include(b => b.User).Where(x => x.FacilityId == tempId).ToList();
                        for (int j = 0; j < tempBookings.Count; j++) {
                            //var tempId = fac[i].Id;
                            //Booking owners = context.Bookings.Include(b => b.Reviews).Include(b => b.User).Where(x => x.FacilityId == tempId).FirstOrDefault();
                            Booking owners = tempBookings[j];
                            if (owners != null)
                                bookings.Add(owners);
                        }
                    }

                    if (bookings.Count > 0)
                        foreach (var booking in bookings)
                        {
                            booking.Facility.Name.FirstOrDefault();
                            booking.EndDateTime = booking.EndDateTime.Value.AddMinutes(30);
                        }

                    if (user != null)
                    {
                        if (filter == "upcoming")
                            foreach (Booking item in bookings.ToList())
                            {
                                if (item.EndDateTime <= DateTime.Now)
                                {
                                    bookings.Remove(item);
                                }
                            }

                        else if (filter == "completed")
                            foreach (Booking item in bookings.ToList())
                            {
                                if (item.EndDateTime > DateTime.Now)
                                {
                                    bookings.Remove(item);
                                }
                            }

                        return View("OwnerViewBookings", bookings);
                    }
                }
                //if the user is not logged in, return to the login view
                return RedirectToAction("Login");
            }
        }

        public ActionResult LeaveReview(Int32 id)
        {
            using (var context = new SpaceBookEntities1())
            {
                ReviewViewModel model = new ReviewViewModel();
                Booking booking = context.Bookings.Where(b => b.Id == id).FirstOrDefault();
                model.FacilityID = booking.FacilityId;
                model.UserID = booking.UserId;
                model.BookingID = booking.Id;
                return View(model);
            }
        }

        [HttpPost]
        public ActionResult LeaveReview(ReviewViewModel reviewParam)
        {
            using (var context = new SpaceBookEntities1())
            {
                Review review = new Review();
                review.Rating = reviewParam.Rating;
                review.Comment = reviewParam.Review;
                review.BookingId = reviewParam.BookingID;
                review.FacilityId = reviewParam.FacilityID;
                review.UserId = reviewParam.UserID;
                review.ActiveFlag = true;
                context.Reviews.Add(review);

                //sends notification to the facility owner
                Notification notification = new Notification();
                notification.UserId = context.Facilities.Where(x => x.Id == review.FacilityId).FirstOrDefault().OwnerId.Value;
                notification.Message = context.Users.Where(x => x.Id == review.UserId).FirstOrDefault().FirstName.ToString() + " has sumitted a review for your facility: " +
                    context.Facilities.Where(x => x.Id == review.FacilityId).FirstOrDefault().Name.ToString();
                notification.ActiveFlag = true;
                notification.IsReadFlag = false;
                notification.DateTime = DateTime.Now;
                notification.Type = 6; //facilityOwner_ReviewReceived
                context.Notifications.Add(notification);

                context.SaveChanges();

                context.SaveChanges();
                TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-success", Message = "Your review has been submitted." };
                return RedirectToAction("Index");
            }
        }

        public ActionResult ViewReview(int id)
        {
            using (var context = new SpaceBookEntities1())
            {
                ReviewViewModel model = new ReviewViewModel();
                var review = context.Reviews.Where(u => u.Id == id && u.ActiveFlag == true).FirstOrDefault();
                model.Rating = review.Rating.Value;
                model.Review = review.Comment;
                model.UserID = review.UserId;
                return View(model);
            }
        }

        //user initiated cancellling of a booking
        public ActionResult userCancelBooking(int Id)
        {
            using (var context = new SpaceBookEntities1())
            {
                Booking booking = context.Bookings.Where(b => b.Id == Id).FirstOrDefault();
                booking.Cancelled = true;
                
                //sends notification to the facility owner
                Notification notification = new Notification();
                notification.UserId = context.Facilities.Where(x => x.Id == booking.FacilityId).FirstOrDefault().OwnerId.Value;
                notification.Message = context.Users.Where(x => x.Id == booking.UserId).FirstOrDefault().FirstName.ToString() + " has cancelled a booking at the facility: " + 
                    context.Facilities.Where(x => x.Id == booking.FacilityId).FirstOrDefault().Name.ToString() + ", scheduled for " +  booking.StartDateTime.Value.ToString("D") +  " from " + 
                    AdjustTime(booking.StartDateTime.Value.TimeOfDay).ToString() + " to " + AdjustTime(booking.EndDateTime.Value.TimeOfDay).ToString();
                notification.ActiveFlag = true;
                notification.IsReadFlag = false;
                notification.DateTime = DateTime.Now;
                notification.Type = 2; //facilityOwner_UserCancelledBooking
                context.Notifications.Add(notification);

                context.SaveChanges();

            }
            return RedirectToAction("ViewBookings", new { filter = "upcoming" });
        }

        //owner initiated cancellling of a booking
        public ActionResult ownerCancelBooking(int Id)
        {
            using (var context = new SpaceBookEntities1())
            {
                Booking booking = context.Bookings.Where(b => b.Id == Id).FirstOrDefault();
                booking.Cancelled = true;
                
                //sends notification to the user
                Notification notification = new Notification();
                notification.UserId = context.Users.Where(x => x.Id == booking.UserId).FirstOrDefault().Id;
                notification.Message = "The facility manager of " + context.Facilities.Where(x => x.Id == booking.FacilityId).FirstOrDefault().Name.ToString() + " has cancelled your booking at the facility on "
                    + booking.StartDateTime.Value.ToString("D") + ", scheduled for " +
                    AdjustTime(booking.StartDateTime.Value.TimeOfDay).ToString() + " to " + AdjustTime(booking.EndDateTime.Value.TimeOfDay).ToString();
                notification.ActiveFlag = true;
                notification.IsReadFlag = false;
                notification.DateTime = DateTime.Now;
                notification.Type = 5; //user_FacilityOwnerCancelledBooking
                context.Notifications.Add(notification);

                context.SaveChanges();
            }
            return RedirectToAction("OwnerViewBookings", new { filter = "upcoming" });
        }

        public ActionResult Notifications()
        {
            using (var context = new SpaceBookEntities1())
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    var notifictaions = context.Notifications.Where(x => x.UserId == userId).ToList();
                    return View(notifictaions);
                }
                else
                {
                    return RedirectToAction("Login");
                }
            }
        }

        public ActionResult GetNotificationCount()
        {
            using (var context = new SpaceBookEntities1())
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                var count = context.Notifications.Where(x => x.UserId == userId).Count();
                return PartialView(count);
            }
        }

        public ActionResult DismissNotification(int id)
        {
            using (var context = new SpaceBookEntities1())
            {

                var notification = context.Notifications.Where(x => x.Id == id).FirstOrDefault();
                if (notification != null)
                {
                    context.Notifications.Remove(notification);
                    context.SaveChanges();
                }
                return RedirectToAction("Notifications");
            }
        }

        [HttpGet]
        public ActionResult UploadFacilityPhoto(int facilityId)
        {
            FacilityPhotoViewModel model = new FacilityPhotoViewModel();
            model.FacilityId = facilityId;
            return View(model);
        }

        [HttpPost]
        public ActionResult UploadFacilityPhoto(FacilityPhotoViewModel param, HttpPostedFileBase FacilityPhotoFile)
        {
            FacilityPhotoFile = FacilityPhotoFile ?? Request.Files["FacilityPhotoFile"];

            using (var context = new SpaceBookEntities1())
            {

                var facility = context.Facilities.Where(x => x.Id == param.FacilityId).First();

                var FacilityPhotoFileName = "";
                var FacilityPhotoFilePath = "";
                var ProfilePicFolderPath = "~/Content/FacilityPhotos";

                //If a file was selected, save the file to the specified folder
                if (FacilityPhotoFile != null && FacilityPhotoFile.ContentLength > 0)
                {
                    //gets the name of the file
                    FacilityPhotoFileName = Path.GetFileName(FacilityPhotoFile.FileName);
                    //Saves the uploaded picture to the specified folder
                    FacilityPhotoFilePath = Path.Combine(Server.MapPath(ProfilePicFolderPath), FacilityPhotoFileName);
                    FacilityPhotoFile.SaveAs(FacilityPhotoFilePath);
                    facility.FacilityPhotoFileName = FacilityPhotoFileName;
                }
                else
                {
                    //if no file was selected, use the default profile picture
                    facility.FacilityPhotoFileName = "defaultFacilityPhoto.jpg";
                }

                //Adds the user to the User table in the database
                context.SaveChanges();
                //TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-success", Message = "Your account has been created." };
                //Redirects the user to the login page when the "Create" button is pressed
                return RedirectToAction("Index");
            }
            return View("Index");
        }

    }
}
