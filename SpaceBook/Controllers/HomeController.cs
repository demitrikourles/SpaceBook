using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SpaceBook.Models;
using SpaceBook.ViewModels;
using SpaceBook.Models.MetaData;
using System.IO;

namespace SpaceBook.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            using (var context = new SpaceBookEntities1())
            {
                return View();
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

        public ActionResult SearchResults()
        {
            using (var context = new SpaceBookEntities1())
            {
                var results = context.Facilities.Where(x => x.ActiveFlag == true).ToList();
                if (results != null && results.Count > 0)
                {
                    //return View(results);
                }
                return View(results);

                //else 
                //{
                //    return View();
                //}  
            }
        }

        public ActionResult ViewFacility(Int32 id)
        {
            using (var context = new SpaceBookEntities1())
            {
                var facility = context.Facilities.Where(x => x.Id == id).FirstOrDefault();

                return View(facility);
            }
        }
        
        [HttpGet]
        //Week increment is 0 (new booking attempt), 1(load next week on current booking attempt), or -1(load previous week on current booking attempt)
        public ActionResult ViewFacilityAvailability(Int32 facilityId, int weekIncr)
        {
           

            using (var context = new SpaceBookEntities1())
            {
                //Sets the current week's monday using DateTime.Now as reference
                int day_of_week_now = (int)DateTime.Now.DayOfWeek == 0 ? 7 : (int)DateTime.Now.DayOfWeek;
                DateTime refMonday = DateTime.Now.AddDays((Convert.ToInt32(DayOfWeek.Monday) - day_of_week_now));
                refMonday = new DateTime(refMonday.Year, refMonday.Month, refMonday.Day, 0, 0, 0);
                Session["TodayWeekMonday"] = refMonday.ToString();

                //resets the day of the week to monday each time the page is reloaded
                Session["DayofWeek"] = "1";

                //Resets sessions if weekIncr = 0 because that means a new booking attempt has loaded
                if (weekIncr == 0)
                {
                    //sets the currently selected week to the actual current week
                    Session["SelectedWeekMonday"] = refMonday.ToString();
                    Session["FacilityID"] = facilityId.ToString();
                }

                //Checks if only the week is being changed (facilityId = -1)
                if (weekIncr != 0)
                {
                    //sets facility Id to current value stored in session["FacilityID"]
                    facilityId = Convert.ToInt32(Session["FacilityID"].ToString());

                    //weekIncr will either be 1 or -1
                    //This will change the current week DateTime by +/- 7 days
                    var selectedWeek = Session["SelectedWeekMonday"].ToString();
                    selectedWeek = DateTime.Parse(selectedWeek).AddDays(weekIncr * 7).ToString();
                    Session["SelectedWeekMonday"] = selectedWeek;
                }

                //need to only pass in bookings from the same week
                //gets the beginning and end of the weeks the user has selected
                DateTime selectedWeekDateTime = DateTime.Parse(Session["SelectedWeekMonday"].ToString());
                DateTime selectedWeekNext = selectedWeekDateTime.AddDays(6);

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
                viewModel.selectedWeek = DateTime.Parse(Session["SelectedWeekMonday"].ToString());

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

        public ActionResult PartialViewTimes(int day, int facilityId)
        {

            //updates the day of the week session according to which day button was pressed
            Session["DayofWeek"] = day.ToString();

            using (var context = new SpaceBookEntities1())
            {

                //need to only pass in bookings from the same week
                DateTime selectedWeekDateTime = DateTime.Parse(Session["SelectedWeekMonday"].ToString());
                DateTime selectedWeekNext = selectedWeekDateTime.AddDays(6);

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
                viewModel.selectedWeek = DateTime.Parse(Session["SelectedWeekMonday"].ToString());

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
        public string getIntersection(Booking booking, FacilityTime time)
        {
            //finds the the day of the week of the booking and the date for the time slot
            int day_of_week = Convert.ToInt32(Session["DayOfWeek"].ToString());
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
        public string isBeforeCurrentDayTime(FacilityTime time)
        {
            //gets today's day of the week
            int day_of_week_now = (int)DateTime.Now.DayOfWeek == 0 ? 7 : (int)DateTime.Now.DayOfWeek;
            //Gets reference monday using DateTime.Now
            DateTime refMonday = DateTime.Now.AddDays((Convert.ToInt32(DayOfWeek.Monday) - day_of_week_now));
            refMonday = new DateTime(refMonday.Year, refMonday.Month, refMonday.Day, 0, 0, 0);
            //Gets the currently selected week monday
            DateTime selectedWeekMonday = DateTime.Parse(Session["SelectedWeekMonday"].ToString());
            
            //Compare = 0 -> equal, Compare < 0 -> t1 is earlier than t2, Compare > 0 -> t1 is later than t2
            //If todays date and the selected date are not in the same week or earlier, return false
            var isWeekEarlier = DateTime.Compare(refMonday, selectedWeekMonday);
            if (isWeekEarlier < 0)
                return "0";
            else if(isWeekEarlier > 0)
                return "1";
            
            //gets day of current timeslot
            int day = time.Day.Value;
            //Compare = 0 -> equal, Compare < 0 -> t1 is earlier than t2, Compare > 0 -> t1 is later than t2
            int timeBefore = TimeSpan.Compare(DateTime.Now.TimeOfDay, time.StartTime.Value);

            //checks if the selected day of the week is before today's day of the week
            //OR checks today's day is the current day and that the timeslot is earlier than(or at the same time as) the current time
            if (day < day_of_week_now || (day == day_of_week_now && timeBefore >= 0) )
                return "1";

            return "0";
        }

        [HttpPost]
        public bool makeBooking(String StartTime, String EndTime, String cost)
        {

            using (var context = new SpaceBookEntities1())
            {
                Booking newBooking = new Booking();
                if (ModelState.IsValid)
                {

                    //we are keeping track of facility and user id during the booking process so the values can be pulled from the sessions
                    var uID = Convert.ToInt32(Session["UserID"]);
                    var FacID = Convert.ToInt32(Session["FacilityID"]);

                    newBooking.UserId = uID;
                    newBooking.FacilityId = FacID;
                    newBooking.Cancelled = false;

                    //gets the date of the booking
                    DateTime currentDate = DateTime.Parse(Session["SelectedWeekMonday"].ToString());
                    currentDate = currentDate.AddDays(Convert.ToInt32(Session["DayofWeek"].ToString()) - Convert.ToInt32(DayOfWeek.Monday));

                    //adds the time to the booking
                    DateTime StartTimeBooking = currentDate.Add(TimeSpan.Parse(StartTime));
                    DateTime EndTimeBooking = currentDate.Add(TimeSpan.Parse(EndTime));

                    newBooking.StartDateTime = StartTimeBooking;
                    newBooking.EndDateTime = EndTimeBooking;

                    //sets cost of the booking according to the value passed in
                    Decimal bookingCost = Convert.ToDecimal(cost);

                    newBooking.Cost = bookingCost;

                    context.Bookings.Add(newBooking);
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
            else if(time.Hours == 12)
            {
                modifiedTime = time.ToString("hh':'mm' PM'");
            }
            //If the time is after noon, adjust by 12 hours and assign PM to the time
            else if(time.Hours > 12)
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

        [HttpGet]
        public ActionResult PostVenue()
        {
            return View();
        }

        [HttpPost]
        public ActionResult PostVenue(Facility facilityParam)
        {
            using (var context = new SpaceBookEntities1())
            {
                var errors = ModelState.Where(x => x.Value.Errors.Any())
                .Select(x => new { x.Key, x.Value.Errors });
                Facility newFacility = new Facility();
                if (ModelState.IsValid)
                {
                    newFacility.Name = facilityParam.Name;
                    newFacility.StartTime = facilityParam.StartTime;
                    newFacility.EndTime = facilityParam.EndTime;
                    newFacility.HourlyRate = facilityParam.HourlyRate;
                    newFacility.Description = facilityParam.Description; //Not on postVenue form yet
                    newFacility.Email = facilityParam.Email;
                    newFacility.Phone = facilityParam.Phone;
                    newFacility.Address = facilityParam.Address;
                    newFacility.PostalCode = facilityParam.PostalCode; //Not on postVenue form yet
                    newFacility.City = facilityParam.City;
                    newFacility.Province = facilityParam.Province;
                    newFacility.Country = facilityParam.Country;
                    newFacility.ActiveFlag = true;
                    newFacility.Type = 1; //Need to set up types

                    context.Facilities.Add(newFacility);
                    context.SaveChanges();
                }

                //Creation of time slots
                for (int x = 1; x < 8; x++) //x = day number
                {
                    TimeSpan interval = new TimeSpan(0, 0, 0);
                    for (int y = 0; y < 48; y++)  //y = number of time slots to create per day
                    {
                        FacilityTime newFacilityTime = new FacilityTime();
                        newFacilityTime.Facility = newFacility;
                        newFacilityTime.FacilityId = newFacility.Id;
                        newFacilityTime.StartTime = interval;
                        newFacilityTime.Day = x;
                        newFacilityTime.Rate = facilityParam.HourlyRate;
                        newFacilityTime.IsAvailable = true;

                        if ((interval < newFacility.StartTime) || (interval >= newFacility.EndTime))
                        {
                            newFacilityTime.IsAvailable = false;
                        }

                        context.FacilityTimes.Add(newFacilityTime);
                        context.SaveChanges();
                        interval = interval.Add(new TimeSpan(0, 30, 0));
                    }
                }
                return RedirectToAction("index");
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
        public ActionResult Login(User userParam)
        {
            using (var context = new SpaceBookEntities1())
            {
                if (!string.IsNullOrEmpty(userParam.Email) && !string.IsNullOrEmpty(userParam.Password))
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
                }
                TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-danger", Message = "You have entered an invalid username or password. Please try again" };
                return RedirectToAction("Login");
            }
        }

        public ActionResult Logout()
        {
            Session.Abandon();
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
        public ActionResult EditUserProfile()
        {
            ViewBag.Message = "Edit User Profile Page";

            return View();
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
                    //Checks to see if all parameters have been filled out
                    /*if (!string.IsNullOrEmpty(userParam.FirstName) &&
                        !string.IsNullOrEmpty(userParam.LastName) &&
                        !string.IsNullOrEmpty(userParam.Email) &&
                        !string.IsNullOrEmpty(userParam.Phone) &&
                        !string.IsNullOrEmpty(userParam.Password))
                    {*/

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
            //TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-danger", Message = "You have not entered a value for all fields. Please try again" };
            return RedirectToAction("ViewUserProfile");
        }

        [HttpGet]
        public ActionResult RegisterFacility()
        {
            return View("~/Views/Home/RegisterFacility/Info.cshtml");
        }

        public ActionResult RegisterFacilityInfo(RegisterFacilityViewModel facilityParam)
        {
            if (ModelState.IsValidField("Name") && ModelState.IsValidField("Description") && ModelState.IsValidField("Email") && ModelState.IsValidField("Phone"))
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

                List<string> monList = Request.Form["monStart"].Split(',').ToList<string>();
                monList.AddRange(Request.Form["monEnd"].Split(',').ToList<string>());

                List<string> tueList = Request.Form["tueStart"].Split(',').ToList<string>();
                tueList.AddRange(Request.Form["tueEnd"].Split(',').ToList<string>());

                List<string> wedList = Request.Form["wedStart"].Split(',').ToList<string>();
                wedList.AddRange(Request.Form["wedEnd"].Split(',').ToList<string>());

                List<string> thuList = Request.Form["thuStart"].Split(',').ToList<string>();
                thuList.AddRange(Request.Form["thuEnd"].Split(',').ToList<string>());

                List<string> friList = Request.Form["friStart"].Split(',').ToList<string>();
                friList.AddRange(Request.Form["friEnd"].Split(',').ToList<string>());

                List<string> satList = Request.Form["satStart"].Split(',').ToList<string>();
                satList.AddRange(Request.Form["satEnd"].Split(',').ToList<string>());

                List<string> sunList = Request.Form["sunStart"].Split(',').ToList<string>();
                sunList.AddRange(Request.Form["sunEnd"].Split(',').ToList<string>());

                List<List<string>> dayList = new List<List<string>>();
                dayList.Add(monList);
                dayList.Add(tueList);
                dayList.Add(wedList);
                dayList.Add(thuList);
                dayList.Add(friList);
                dayList.Add(satList);
                dayList.Add(sunList);

                if (ModelState.IsValid)
                {
                    newFacility.Name = facilityParam.Name;
                    //newFacility.StartTime = facilityParam.StartTime;
                    //newFacility.EndTime = facilityParam.EndTime;
                    //newFacility.HourlyRate = facilityParam.HourlyRate;
                    newFacility.Description = facilityParam.Description;
                    newFacility.Email = facilityParam.Email;
                    newFacility.Phone = facilityParam.Phone;
                    newFacility.Address = facilityParam.Address;
                    newFacility.PostalCode = facilityParam.PostalCode;
                    newFacility.City = facilityParam.City;
                    newFacility.Province = facilityParam.Province;
                    newFacility.Country = facilityParam.Country;
                    newFacility.ActiveFlag = true;
                    newFacility.Type = 1; //Need to set up types
                    

                    context.Facilities.Add(newFacility);
                    //CreateTimeSlots(newFacility, dayList); //Creation of time slots
                    context.SaveChanges();

                    Session["FacilityId"] = newFacility.Id;

                    List <TagType> viewTypes = context.TagTypes.ToList();
                    return View("~/Views/Home/RegisterFacility/AddTags.cshtml", viewTypes);
                }

                return RedirectToAction("index");
            }
        }

        public ActionResult RegisterFacilityAddTags() 
        {
            using (var context = new SpaceBookEntities1()) 
            {
                var facilityId = Convert.ToInt32(Session["FacilityId"]);
                List<string> tagIsCheckedList = Request.Form["checkedTags"].Split(',').ToList<string>();
                List<TagType> Tags = context.TagTypes.ToList();

                for (int i = 0; i < tagIsCheckedList.Count; i++) 
                {
                    if (tagIsCheckedList[i] == "true") {
                        TagAssignment newTagAssignment = new TagAssignment();
                        newTagAssignment.FacilityId = facilityId;
                        newTagAssignment.TagId = Tags[i].Id;

                        context.TagAssignments.Add(newTagAssignment);
                    }
                }

                context.SaveChanges();
                return RedirectToAction("index");
            }
        }

        public void CreateTimeSlots(Facility newFacility, List<List<string>> dayList)
        {
            using (var context = new SpaceBookEntities1())
            {
                for (int day = 1; day < 8; day++)
                {
                    List<string> currDay = dayList[day - 1];

                    TimeSpan interval = new TimeSpan(0, 0, 0);
                    for (int y = 0; y < 48; y++)  //y = number of time slots to create per day
                    {
                        FacilityTime newFacilityTime = new FacilityTime();
                        newFacilityTime.Facility = newFacility;
                        newFacilityTime.FacilityId = newFacility.Id;
                        newFacilityTime.StartTime = interval;
                        newFacilityTime.Day = day;
                        //newFacilityTime.Rate = newFacility.HourlyRate;
                        newFacilityTime.IsAvailable = false;

                        for (int i = 0; i < currDay.Count / 2; i++)
                        {
                            string startString = currDay[i].Remove(currDay[i].Length - 2, 2) + " " + currDay[i].Substring(currDay[i].Length - 2).ToUpper();
                            string endString = currDay[currDay.Count / 2 + i].Remove(currDay[currDay.Count / 2 + i].Length - 2, 2) + " " + currDay[currDay.Count / 2 + i].Substring(currDay[currDay.Count / 2 + i].Length - 2).ToUpper();

                            TimeSpan start = DateTime.ParseExact(startString, "h:mm tt", System.Globalization.CultureInfo.InvariantCulture).TimeOfDay;
                            TimeSpan end = DateTime.ParseExact(endString, "h:mm tt", System.Globalization.CultureInfo.InvariantCulture).TimeOfDay;

                            if ((interval >= start) && (interval < end))
                            {
                                newFacilityTime.IsAvailable = true;
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

        public ActionResult ViewBookings(string greaterOrLess)
        {
            using (var context = new SpaceBookEntities1())
            {
                if (Session["UserID"] != null)
                {
                    var sessionID = Convert.ToInt32(Session["UserID"]);
                    var user = context.Users.Where(u => u.Id == sessionID && u.ActiveFlag == true).FirstOrDefault();
                    var bookings = context.Bookings.Where(x => x.UserId == sessionID && x.Cancelled == false).ToList();
                    if (bookings.Count > 0)
                        foreach (var booking in bookings)
                            booking.Facility.Name.FirstOrDefault();

                    if (user != null)
                    {
                        if (greaterOrLess == ">")
                            foreach (Booking item in bookings.ToList())
                            {
                                //confirm this logic 
                                if (((TimeSpan)(DateTime.Today - item.StartDateTime)).Days > 30)
                                {
                                    bookings.Remove(item);
                                }
                            }

                        else if (greaterOrLess == "<")
                            foreach (Booking item in bookings.ToList())
                            {
                                //confirm this logic 
                                if (((TimeSpan)(DateTime.Today - item.StartDateTime)).Days < 30)
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


    }
}
