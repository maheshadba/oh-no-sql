﻿using System.ComponentModel.DataAnnotations;

namespace IdentityManagement.Entities
{
    public class JobInfo
    {
        public string Id { get; set; }
        public string CompanyId { get; set; }
        [Required]
        public string Title { get; set; }
        [Required]
        public string Description { get; set; }
    }
}
