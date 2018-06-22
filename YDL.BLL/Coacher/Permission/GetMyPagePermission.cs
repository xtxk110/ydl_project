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
    /// 获取我的界面--权限
    /// 请注意按照此思路去编码:  每个角色在给 UserMyPagePermission 模型赋值时, 只赋值有权限的字段, 没有权限的字段不要去操作
    ///     这样最后拿到的就是, 所有角色的权限集合. (这样如果用户有多个角色,就可以拿到此用户的所有权限了)
    /// </summary>
    public class GetMyPagePermission : IServiceBase
    {
        public Response Execute(User currentUser, string request)
        {

            var req = JsonConvert.DeserializeObject<Request<GetCoachRelatedFilter>>(request);
            UserMyPagePermission permission = new UserMyPagePermission();
            var currentUserId = req.Filter.CurrentUserId;

            //一般用户(简单说就是所有用户)权限设置
            SetGeneralUserPermission(permission);

            //教练权限设置
            if (CoachHelper.Instance.IsCoach(currentUserId))
            {
                SetCoachPermission(permission);
            }

            //教练管理员权限设置
            if (PermissionCheck.Instance.IsCoachManager(currentUserId))
            {
                SetCoachManagerPermission(permission);
            }

            //系统管理员权限设置
            if (PermissionCheck.Instance.IsSystemManager(currentUserId))
            {
                SetSystemManagerPermission(permission);
            }

            //封闭机构管理员权限设置
            if (PermissionCheck.Instance.IsSealedOrganizationManager(currentUserId))
            {
                SetOrganizationManagerPermission(permission);
            }

            //封闭机构教练权限设置
            if (CoachHelper.Instance.IsSealedCoach(currentUserId))
            {
                SetSealedCoachPermission(permission, currentUserId);
            }

            //特殊权限处理
            SetSpecialPermission(permission, currentUserId);
            //默认所有用户都有的权限
            permission.IsShowMyPermission = true;
            permission.IsShowSetting = true;
            //处理有冲突的权限
            SetConflictPermission(permission);
            //最后返回
            Response rsp = new Response();
            rsp.IsSuccess = true;
            rsp.Entities = new List<EntityBase>();
            ///////////////获取我的团体模板能使用的总数
            var res = GameLoopTempletHelper.GetTempletList(currentUser.Id, "", 2);
            res.SetRowCount();
            permission.TempletCount = res.RowCount;
            res = null;
            ///////////////

            rsp.Entities.Add(permission);
            

            return rsp;

        }

        /// <summary>
        /// 特殊权限处理
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="currentUserId"></param>
        public void SetSpecialPermission(UserMyPagePermission obj, string currentUserId)
        {
            //教练申请中或者是拒绝中的显示教练信息
            if (PermissionCheck.Instance.IsInCoachAuditingOrRefuse(currentUserId))
            {
                obj.IsShowCoachInfo = true;//显示教练信息
                obj.IsShowCoachApply = false;//隐藏教练申请
            }

            //写死的权限
            //186版本需求, 暂时关闭如下权限
            obj.IsShowSyllabus = false;

        }

        /// <summary>
        /// 处理冲突的权限(即如果有a,b 两个权限,但是在业务上是冲突的, 就只能保留一个)
        /// </summary>
        /// <param name="obj"></param>
        public void SetConflictPermission(UserMyPagePermission obj)
        {
            //如果有教练信息的权限了, 就表示已经是教练, 不能再有教练申请的权限
            if (obj.IsShowCoachInfo)
            {
                obj.IsShowCoachApply = false;
            }
        }

        /// <summary>
        /// 设置普通用户的权限(包括学员)
        /// </summary>
        /// <param name="obj"></param>
        public void SetGeneralUserPermission(UserMyPagePermission obj)
        {
            obj.IsShowMyCourse = true;
            obj.IsShowMyGameActivity = true;
            obj.IsShowCoachApply = true;
        }


        /// <summary>
        /// 设置教练的权限
        /// </summary>
        /// <param name="obj"></param>
        public void SetCoachPermission(UserMyPagePermission obj)
        {
            obj.IsShowMyCourse = true;
            obj.IsShowMyGameActivity = true;
            obj.IsShowCoachInfo = true;
            obj.IsCoach = true;
        }

        /// <summary>
        /// 设置教练管理员的权限(又名总教头, 管理教练的请假, 分配场馆的教练等等)
        /// </summary>
        /// <param name="obj"></param>
        public void SetCoachManagerPermission(UserMyPagePermission obj)
        {
            obj.IsShowMyCourse = true;
            obj.IsShowMyGameActivity = true;
            obj.IsShowTeachManage = true;

        }

        /// <summary>
        /// 设置系统管理员的权限(拥有所有)
        /// </summary>
        public void SetSystemManagerPermission(UserMyPagePermission obj)
        {
            obj.IsShowMyCourse = true;
            obj.IsShowMyGameActivity = true;
            obj.IsShowCoachApply = true;
            obj.IsShowCoachInfo = true;
            obj.IsShowTeachManage = true;
            obj.IsShowSysManage = true;
        }


        public void SetOrganizationManagerPermission(UserMyPagePermission obj)
        {
            obj.IsShowMyOrganization = true;
        }


        /// <summary>
        /// 设置封闭机构教练权限
        /// </summary>
        /// <param name="obj"></param>
        public void SetSealedCoachPermission(UserMyPagePermission obj, string currentUserId)
        {
            //是封闭教练, 但不是悦动力教练
            if (!CoachHelper.Instance.IsYDLCoach(currentUserId))
            {
                //就隐藏教练信息, 放出申请教练功能(因为封闭机构教练可以申请成为悦动力教练, 呵呵)
                obj.IsShowCoachApply = true;
                obj.IsShowCoachInfo = false;
            }
        }

    }
}
