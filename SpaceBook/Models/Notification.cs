//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SpaceBook.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Notification
    {
        public int id { get; set; }
        public string type { get; set; }
        public int userId { get; set; }
        public string message { get; set; }
        public Nullable<System.DateTime> dateTime { get; set; }
        public string isRead { get; set; }
    
        public virtual User User { get; set; }
    }
}
