using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using YDL.Core;
using YDL.Utility;

namespace YDL.Model
{
    /// <summary>
    /// 用户联系人列表
    /// </summary>
    [Table]
    public class UserContactList : EntityBase
    {
        /// <summary>
        ///我的教练
        /// </summary>
        [Field(isUpdate: false)]
        public List<Coach> MyCoach { get; set; }

        /// <summary>
        ///我的学员
        /// </summary>
        [Field(isUpdate: false)]
        public List<CoachStudent> MyStudent { get; set; }

        /// <summary>
        ///关注的场馆
        /// </summary>
        [Field(isUpdate: false)]
        public List<Venue> FavoriteVenue { get; set; }

        /// <summary>
        /// 是否为教练
        /// </summary>
        public bool IsCoach { get; set; }

    }
}