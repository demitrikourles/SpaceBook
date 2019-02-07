using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace SpaceBook.Models.MetaData
{
    public class UserMetaData
    {
        [Required(ErrorMessage = "Please enter your email")]
        public string Email;

        [Required(ErrorMessage = "Please enter your password")]
        public string Password;
    }
}