using System;
using System.Collections.Generic;
using SpaceBook.Models;
using System.Linq;
using System.Web;

namespace SpaceBook.ViewModels
{
    public class facilityTimesAndBookingsViewModel
    {
        public List <FacilityTime> times;
        public List <Booking> bookings;
        public DateTime selectedWeek;

        public facilityTimesAndBookingsViewModel(List<FacilityTime> times, List<Booking> bookings)
        {
            this.times = times;
            this.bookings = bookings;
        }
    }
}