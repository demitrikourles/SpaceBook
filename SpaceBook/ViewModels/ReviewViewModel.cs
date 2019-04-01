using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SpaceBook.Models;

namespace SpaceBook.ViewModels
{
    public class ReviewViewModel
    { 
        public string Review { get; set; }
        public int Rating { get; set; }
        public int UserID { get; set; }
        public int FacilityID { get; set; }
        public int BookingID { get; set; }
    }
}