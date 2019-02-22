using Microsoft.VisualStudio.TestTools.UnitTesting;
using SpaceBook.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace SpaceBook.Controllers.Tests
{
    [TestClass()]
    public class HomeControllerTests
    {
        [TestMethod()]
        public void TestIndexView()
        {
            var controller = new HomeController();
            var result = controller.Index() as ViewResult;
            Assert.AreEqual("Index", result.ViewName);

        }

        [TestMethod()]
        public void TestViewFacilityView()
        {
            var controller = new HomeController();
            var result = controller.ViewFacility(1) as ViewResult;
            Assert.AreEqual("ViewFacility", result.ViewName);

        }

        [TestMethod]
        public void TestViewFacilityViewData()
        {
            var controller = new HomeController();
            var result = controller.ViewFacility(1) as ViewResult;
            var facility = (Models.Facility)result.ViewData.Model;
            Assert.AreEqual("Mosaic Stadium", facility.Name);
        }

        [TestMethod]
        public void TestViewFacilityRedirect()
        {
            var controller = new HomeController();
            var result = (RedirectToRouteResult)controller.ViewFacility(-1);
            Assert.AreEqual("Index", result.RouteValues["action"]);
        }
    }
}