using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    public class GetClubUserListFilter : FilterBase
    {
        public string ClubId { get; set; }
        public string PetName { get; set; }
        public bool IsAdmin { get; set; }
    }
}
