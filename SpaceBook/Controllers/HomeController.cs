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
                var facility = context.Facilities.Where(x => x.Id == id).ToList().FirstOrDefault();
                return View(facility);
            }
        }

        public ActionResult ViewFacilityAvailability(int id) 
        {
            using (var context = new SpaceBookEntities1()) 
            {
                var times = context.FacilityTimes.Where(x => x.FacilityId == id).ToList();

                if (times.Count > 0)
                {
                    foreach (FacilityTime time in times)
                    {
                        time.Facility.Name.FirstOrDefault();
                        //time.Booking.Id.ToString().FirstOrDefault();
                    }
                }
                return View(times);
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

        public ActionResult PostVenue()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }
    }
}
