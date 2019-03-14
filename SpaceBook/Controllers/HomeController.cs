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

        public ActionResult ViewFacility(int id)
        {
            using (var context = new SpaceBookEntities1()) 
            {
                var facility = context.Facilities.Where(x => x.Id == id).FirstOrDefault();
                return View(facility);
            }
        }

        public ActionResult ViewFacilityAvailability(int id) 
        {
            using (var context = new SpaceBookEntities1()) 
            {
                var times = context.FacilityTimes.Where(x => x.FacilityId == id).ToList().OrderBy(x => x.StartTime).ToList();
                
                if (times.Count > 0) {
                    foreach (FacilityTime time in times) {
                        time.Facility.Name.FirstOrDefault();
                        //time.Booking.Id.ToString().FirstOrDefault();
                    }
                }
                //times.Facility.Name.FirstOrDefault();
                return View(times);
            }
        }

        public ActionResult PartialViewTimes(int day, int facilityId) {
            using (var context = new SpaceBookEntities1()) 
            {
                var times = context.FacilityTimes.Where(x => ((x.Day == day) && (x.FacilityId == facilityId))).ToList().OrderBy(x => x.StartTime).ToList();
                if (times.Count > 0) {
                    foreach (FacilityTime time in times) {
                        time.Facility.Name.FirstOrDefault();
                    }
                }
                return PartialView(times);
            }
                
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
                for (int x=1; x<8; x++) //x = day number
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
        public ActionResult RegisterFacility(Facility facilityParam)
        {
            return View("~/Views/Home/RegisterFacility/Info.cshtml", facilityParam);
        }

        public ActionResult RegisterFacilityInfo(Facility facilityParam)
        {
            //be sure to validate contact info here in the future
            return View("~/Views/Home/RegisterFacility/Address.cshtml", facilityParam);
        }

        public ActionResult RegisterFacilityAddress(Facility facilityParam)
        {
            //be sure to validate contact info here in the future
            return View("~/Views/Home/RegisterFacility/Hours.cshtml", facilityParam);
        }

        [HttpPost]
        public ActionResult RegisterFacilityComplete(Facility facilityParam)
        {
            using (var context = new SpaceBookEntities1())
            {
                Facility newFacility = new Facility();

                var monStart = Request.Form["monStart"];
                var monEnd = Request.Form["monEnd"];
                List<string> monList = monStart.Split(',').ToList<string>();
                monList.AddRange(monEnd.Split(',').ToList<string>()); //pass this list when creating time slots

                var tueStart = Request.Form["tueStart"];
                var tueEnd = Request.Form["tueEnd"];
                List<string> tueList = tueStart.Split(',').ToList<string>();
                tueList.AddRange(tueEnd.Split(',').ToList<string>()); //pass this list when creating time slots

                var wedStart = Request.Form["wedStart"];
                var wedEnd = Request.Form["wedEnd"];
                List<string> wedList = wedStart.Split(',').ToList<string>();
                wedList.AddRange(wedEnd.Split(',').ToList<string>()); //pass this list when creating time slots

                var thuStart = Request.Form["thuStart"];
                var thuEnd = Request.Form["thuEnd"];
                List<string> thuList = thuStart.Split(',').ToList<string>();
                thuList.AddRange(thuEnd.Split(',').ToList<string>()); //pass this list when creating time slots

                var friStart = Request.Form["friStart"];
                var friEnd = Request.Form["friEnd"];
                List<string> friList = friStart.Split(',').ToList<string>();
                friList.AddRange(friEnd.Split(',').ToList<string>()); //pass this list when creating time slots

                var satStart = Request.Form["satStart"];
                var satEnd = Request.Form["satEnd"];
                List<string> satList = satStart.Split(',').ToList<string>();
                satList.AddRange(satEnd.Split(',').ToList<string>()); //pass this list when creating time slots

                var sunStart = Request.Form["sunStart"];
                var sunEnd = Request.Form["sunEnd"];
                List<string> sunList = sunStart.Split(',').ToList<string>();
                sunList.AddRange(sunEnd.Split(',').ToList<string>()); //pass this list when creating time slots

                //var tueTimeSpanList = tueList.Select(x => {TimeSpan result;
                //    if (TimeSpan.TryParse(x, out result))
                //        return new Nullable<TimeSpan>(result);
                //    return null;
                //}).Where(x => x.HasValue).ToList();
                //List<TimeSpan> tueList = new List<TimeSpan>();

                //return RedirectToAction("index");

                if (ModelState.IsValid)
                {
                    newFacility.Name = facilityParam.Name;
                    newFacility.StartTime = facilityParam.StartTime;
                    newFacility.EndTime = facilityParam.EndTime;
                    newFacility.HourlyRate = facilityParam.HourlyRate;
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
                    context.SaveChanges();
                }

                //CreateTimeSlots(newFacility, [start and end time list parameters]); //Creation of time slots

                return RedirectToAction("index");
            }
        }

        public void CreateTimeSlots(Facility newFacility)
        {
            using (var context = new SpaceBookEntities1()) 
            {
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
                        newFacilityTime.Rate = newFacility.HourlyRate;
                        newFacilityTime.IsAvailable = true;

                        if ((interval < newFacility.StartTime) || (interval >= newFacility.EndTime)) {
                            newFacilityTime.IsAvailable = false;
                        }

                        context.FacilityTimes.Add(newFacilityTime);
                        context.SaveChanges();
                        interval = interval.Add(new TimeSpan(0, 30, 0));
                    }
                }
            }

            return;
        }


    }
}
