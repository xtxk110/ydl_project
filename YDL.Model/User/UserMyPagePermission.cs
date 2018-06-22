using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 用户我的界面--权限
    /// </summary>
    public class UserMyPagePermission : EntityBase
    {
        /// <summary>
        /// 是否显示--教练信息
        /// </summary>
        public bool IsShowCoachInfo { get; set; }

        /// <summary>
        /// 是否显示--申请教练
        /// </summary>
        public bool IsShowCoachApply { get; set; }


        /// <summary>
        /// 是否显示--我的机构
        /// </summary>
        public bool IsShowMyOrganization { get; set; }

        /// <summary>
        /// 是否显示--系统管理
        /// </summary>
        public bool IsShowSysManage { get; set; }

        /// <summary>
        /// 是否显示--教学管理
        /// </summary>
        public bool IsShowTeachManage { get; set; }

        /// <summary>
        /// 是否显示--课程表
        /// </summary>
        public bool IsShowSyllabus { get; set; }


        /// <summary>
        /// 是否显示--我的课程
        /// </summary>
        public bool IsShowMyCourse { get; set; }

        /// <summary>
        /// 是否显示--我的赛事活动
        /// </summary>
        public bool IsShowMyGameActivity { get; set; }

        /// <summary>
        /// 是否为教练
        /// </summary>
        public bool IsCoach { get; set; }

        /// <summary>
        /// 是否显示--我的权限
        /// </summary>
        public bool IsShowMyPermission { get; set; }

        /// <summary>
        /// 是否显示--设置
        /// </summary>
        public bool IsShowSetting { get; set; }
        /// <summary>
        /// 我的界面,我的团体模板数量
        /// </summary>
        public int TempletCount { get; set; }
    }
}
