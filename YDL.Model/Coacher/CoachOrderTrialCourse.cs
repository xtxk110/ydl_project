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
    /// 预约体验课
    /// </summary>
    [Table]
    public class CoachOrderTrialCourse : EntityBase
    {
        /// <summary>
        /// 预约人Id
        /// </summary>
        [Field]
        public string StudentId { get; set; }

        // <summary>
        /// 名字
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 手机
        /// </summary>
        [Field]
        public string Mobile { get; set; }

        /// <summary>
        /// 城市
        /// </summary>
        [Field]
        public string CityCode { get; set; }

        /// <summary>
        /// 地址
        /// </summary>
        [Field]
        public string Address { get; set; }


        /// <summary>
        /// 备注
        /// </summary>
        [Field]
        public string Remark { get; set; }

        /// <summary>
        /// 联系情况
        /// </summary>
        [Field]
        public string ContactSituation { get; set; }

        /// <summary>
        /// 是否联系
        /// </summary>
        [Field]
        public bool IsContact { get; set; }

        /// <summary>
        /// 申请时间
        /// </summary>
        [Field(IsUpdate = false)]
        public DateTime ApplyTime { get; set; }

        /// <summary>
        /// 联系人登陆账号
        /// </summary>
        [Field(IsUpdate = false)]
        public string Code { get; set; }
        
        /// <summary>
        /// 城市名称
        /// </summary>
        [Field(IsUpdate = false)]
        public string CityName { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        [Field(IsUpdate = false)]
        public string Sex { get; set; }

    }
}