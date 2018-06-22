using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// IM群 
    /// </summary>
    [Table]
    public class IMGroup : EntityBase
    {
        public IMGroup()
        {
            MemberList = new List<IMGroupMember>();
            Members_Account = new List<string>();
            MemberToDel_Account = new List<string>();
        }
        [Field(IsUpdate = false)]
        public string Owner_Account { get; set; }
        [Field(IsUpdate = false)]
        public string Type { get; set; }

        [Field(IsUpdate = false)]
        public string Name { get; set; }
        [Field(IsUpdate = false)]
        public string Introduction { get; set; }
        [Field(IsUpdate = false)]
        public string Notification { get; set; }
        [Field(IsUpdate = false)]
        public string FaceUrl { get; set; }

        [Field(IsUpdate = false)]
        public string ApplyJoinOption { get; set; }
        [Field(IsUpdate = false)]

        public List<IMGroupMember> MemberList { get; set; }

        [Field(IsUpdate = false)]
        public string GroupId { get; set; }

        /// <summary>
        /// 要删除的群成员列表，最多500个
        /// </summary>
        public List<string> MemberToDel_Account { get; set; }
        /// <summary>
        /// 是否静默删除（不会给任何人下发系统通知）
        /// </summary>
        public int Silence { get; set; }

        /// <summary>
        /// 新群主ID 
        /// </summary>
        public string NewOwner_Account { get; set; }

        /// <summary>
        /// 禁言或取消禁言 成员
        /// </summary>
        public List<string> Members_Account { get; set; }

        /// <summary>
        /// 禁言时间，单位为秒
        /// </summary>
        public long ShutUpTime { get; set; }


        public string Set_Account { get; set; }

        public long GroupmsgNospeakingTime { get; set; }

        public string Member_Account { get; set; }

        public string Role { get; set; }

        public string NameCard { get; set; }
        
    }


}


