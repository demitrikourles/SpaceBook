using Microsoft.VisualStudio.TestTools.UnitTesting;
using SpaceBook.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using SpaceBook.ViewModels;

namespace SpaceBook.Controllers.Tests
{
    [TestClass()]
    public class HomeControllerTests
    {
        [TestMethod()]
        public void TestAboutView()
        {
            var controller = new HomeController();
            var result = controller.About() as ViewResult;
            Assert.AreEqual("About", result.ViewName);
        }

        [TestMethod()]
        public void TestContactView()
        {
            var controller = new HomeController();
            var result = controller.Contact() as ViewResult;
            Assert.AreEqual("Contact", result.ViewName);
        }


        //[TestMethod()]
        //public void TestSearchResultsNameView()
        //{
        //    var controller = new HomeController();
        //    var result = controller.SearchResultsName() as ViewResult;
        //    Assert.AreEqual("SearchResults", result.ViewName);
        //}

        //[TestMethod()]
        //public void TestSearchResultsTagsView()
        //{
        //    var controller = new HomeController();
        //    var result = controller.SearchResultsTags() as ViewResult;
        //    Assert.AreEqual("SearchResults", result.ViewName);
        //}

        [TestMethod()]
        public void TestForgotPasswordView()
        {
            var controller = new HomeController();
            var result = controller.ForgotPassword() as ViewResult;
            Assert.AreEqual("ForgotPassword", result.ViewName);
        }

        [TestMethod()]
        public void TestUserRegistrationView()
        {
            var controller = new HomeController();
            var result = controller.UserRegistration() as ViewResult;
            Assert.AreEqual("UserRegistration", result.ViewName);
        }

        [TestMethod()]
        public void TestRegisterFacilityView()
        {
            var controller = new HomeController();
            var result = controller.RegisterFacility() as ViewResult;
            Assert.AreEqual("~/Views/Home/RegisterFacility/Info.cshtml", result.ViewName);
        }

        [TestMethod()]
        public void TestEditFacilityAddressView()
        {
            var controller = new HomeController();
            RegisterFacilityViewModel param = new RegisterFacilityViewModel();
            param.Name = "test";
            param.Description = "test";
            param.Email = "test@mail.com";
            param.Phone = "1234567891";
            param.DefaultHourlyRate = 50;

            var result = controller.EditFacilityAddress(param) as ViewResult;
            Assert.AreEqual("EditFacilityAddress", result.ViewName);
        }

        [TestMethod()]
        public void TestViewFacilityView()
        {
            var controller = new HomeController();
            var result = controller.ViewFacility(29) as ViewResult; //just make sure that the parameter is the id of a valid facility
            Assert.AreEqual("ViewFacility", result.ViewName);
        }

        [TestMethod()]
        public void TestViewFacilityViewData()
        {
            var controller = new HomeController();
            var result = controller.ViewFacility(29) as ViewResult; //just make sure that the parameter is the id of a valid facility
            var facility = (Models.Facility)result.ViewData.Model;
            Assert.AreEqual("Mosaic Stadium", facility.Name);
        }

        //[TestMethod()]
        //public void TestLogoutRedirect()
        //{
        //    var controller = new HomeController();
        //    controller.Session.Add("UserID", "1");
        //    var result = (RedirectToRouteResult)controller.Logout(); //just make sure that the parameter is the id of a valid facility
        //    Assert.AreEqual("Login", result.RouteValues["action"]);
        //}


    }
}