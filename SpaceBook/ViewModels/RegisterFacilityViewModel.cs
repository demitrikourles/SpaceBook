using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SpaceBook.ViewModels
{
    public class RegisterFacilityViewModel
    {
        [Required(ErrorMessage = "Please enter a facility name.")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Please enter a facility description.")]
        public string Description { get; set; }

        [Required(ErrorMessage = "Please enter the address of your facility.")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Please enter a facility email.")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Please enter a facility phone number.")]
        public string Phone { get; set; }

        [Required(ErrorMessage = "Please enter the city that your facilitiy is located in.")]
        public string City { get; set; }

        [Required(ErrorMessage = "Please enter the postal code of your facility.")]
        public string PostalCode { get; set; }

        [Required(ErrorMessage = "Please enter the province that your facility is located in.")]
        public string Province { get; set; }

        [Required(ErrorMessage = "Please enter the country which your facility is located in.")]
        public string Country { get; set; }
    }
}