using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SpaceBook.Models;
using SpaceBook.ViewModels;
using SpaceBook.Models.MetaData;


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

                //Facility Times table binding and creation of time slots
                    //Need to change/add code to unactivate time slots based on open/close times
                for (int x=1; x<8; x++) //x = day number
                {
                    TimeSpan interval = new TimeSpan(0, 0, 0);
                    for (int y = 0; y < 48; y++)  //y = number of time slots to create
                    {
                        FacilityTime newFacilityTime = new FacilityTime();
                        newFacilityTime.Facility = newFacility;
                        newFacilityTime.FacilityId = newFacility.Id;
                        newFacilityTime.StartTime = interval;
                        newFacilityTime.Day = x;
                        newFacilityTime.Rate = facilityParam.HourlyRate;
                        newFacilityTime.IsAvailable = true;

                        context.FacilityTimes.Add(newFacilityTime);
                        context.SaveChanges();

                        interval = interval.Add(new TimeSpan(0, 30, 0));
                    }
                }
                
                return View();
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
    }
}
