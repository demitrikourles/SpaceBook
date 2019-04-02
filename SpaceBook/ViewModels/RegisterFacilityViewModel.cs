using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SpaceBook.ViewModels
{
    public class RegisterFacilityViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Please enter a facility name.")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Please enter a facility description.")]
        public string Description { get; set; }

        [Required(ErrorMessage = "Please enter the address of your facility.")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Please enter a facility email.")]
        [EmailAddress(ErrorMessage = "Invalid Email Address")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Please enter a facility phone number.")]
        [DataType(DataType.PhoneNumber, ErrorMessage = "Invalid Phone Number")]
        [RegularExpression(@"^([0-9]{10})$", ErrorMessage = "Invalid Phone Number.")]
        public string Phone { get; set; }

        [Required(ErrorMessage = "Please enter a default hourly rate.")]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[0-9]+(\.[0-9]{1,2})?$", ErrorMessage = "Invalid amount.")]
        public double DefaultHourlyRate { get; set; }

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