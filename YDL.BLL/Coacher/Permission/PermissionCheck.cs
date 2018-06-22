using System;
using System.Linq;
using Newtonsoft.Json;
using YDL.Map;
using YDL.Model;
using YDL.Core;
using YDL.Utility;
using System.Collections.Generic;

namespace YDL.BLL
{
    /// <summary>
    /// 权限检查
    /// </summary>
    public class PermissionCheck 
    { 
        public static PermissionCheck Instance =new PermissionCheck();

        /// <summary>
        /// 是否为系统管理员(悦动力最高权限)
        /// </summary>
        /// <param name="currentUserId"></param>
        /// <returns></returns>
        public bool IsSystemManager(string currentUserId)
        {
            if (currentUserId == "001001")
            {
                return true;
            }
            else
            {
                return false;
            }

        }


        /// <summary>
        /// 是否为教练管理员(又名总教头, 管理教练的请假, 分配场馆的教练等等)
        /// </summary>
        /// <param name="currentUserId"></param>
        /// <returns></returns>
        public bool IsCoachManager(string currentUserId)
        {
            #region 这三个人比较特殊, 暂时不具备教练管理员权限, 乒校集训需求所致, 集训过了后删除此代码,此代码编写时间 20180125, 大概几个月后就可以删除此代码
            if (currentUserId == "92a363f697c346d48338a7de015ebd73"
              || currentUserId == "b7a929ba887d46ddad2fa86a00d0cc3a"
              || currentUserId == "24c9658771e24213b25ca86a00a639fd")
            {
                return false;   
            }
            #endregion


            var limit = UserHelper.GetUserLimit(currentUserId);
            if (limit != null)
            {
                return limit.IsTeachManage;
            }
            else
                return false;
        }



        /// <summary>
        /// 是否为封闭机构管理员
        /// </summary>
        /// <param name="currentUserId"></param>
        /// <returns></returns>
        public bool IsSealedOrganizationManager(string currentUserId)
        {
            var sql = @"
SELECT Id 
FROM dbo.CoachOrganization 
WHERE ManagerId LIKE '%"+ currentUserId+ @"%' AND OrgType='Sealed'
";
            var cmd = CommandHelper.CreateText<CoachOrganization>(FetchType.Fetch, sql);
            cmd.Params.Add("@ManagerId", currentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// 是否为教练模块学员
        /// </summary>
        /// <param name="currentUserId"></param>
        /// <returns></returns>
        public bool IsCoachModuleStudent(string currentUserId)
        {
            var sql = @"
     SELECT Id FROM dbo.CoachStudentMoney  WHERE StudentUserId=@StudentUserId
";
            var cmd = CommandHelper.CreateText<CoachStudentMoney>(FetchType.Fetch, sql);
            cmd.Params.Add("@StudentUserId", currentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            if (result.Entities.Count > 0)
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// 是否处于教练审核中
        /// </summary>
        /// <param name="currentUserId"></param>
        /// <returns></returns>
        public bool IsInCoachAuditingOrRefuse(string currentUserId)
        {
            var sql = @"
 SELECT State FROM dbo.CoachApply WHERE Id=@Id
";
            var cmd = CommandHelper.CreateText<Coach>(FetchType.Fetch, sql);
            cmd.Params.Add("@Id", currentUserId);
            var result = DbContext.GetInstance().Execute(cmd);
            var obj = result.FirstEntity<Coach>();
            if (obj != null)
            {
                if (obj.State == AuditState.PROCESSING.Id || obj.State == AuditState.REFUSE.Id)
                {
                    return true;
                }
            }

            return false;

        }

    }
}
