using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections;

using cn.jpush.api;
using cn.jpush.api.push;
using cn.jpush.api.report;
using cn.jpush.api.common;
using cn.jpush.api.util;
using cn.jpush.api.push.mode;
using cn.jpush.api.push.notification;
using cn.jpush.api.common.resp;

using Newtonsoft.Json;
using YDL.Core;
using YDL.Map;
using YDL.Model;
using YDL.Utility;

namespace YDL.BLL
{
    /// <summary>
    /// 极光推送
    /// </summary>
    class JPushHelper
    {
        private static String app_key = "bda31b3e434ed12620cc2553";
        private static String master_secret = "c1841998fd6bec494df3212d";

        public static void SendNotify(string masterType, string masterId, string msg, List<string> userIds, Message message = null)
        {
            try
            {
                Push(masterType, masterId, msg, userIds, message);
            }
            catch (Exception ex)
            {
            }
        }

        private static void Push(string masterType, string masterId, string msg, List<string> userIds, Message message = null)
        {
            //发送消息
            Task<bool> send = Task.Factory.StartNew<bool>(() =>
            {
                try
                {
                    JPushClient client = new JPushClient(app_key, master_secret);
                    PushPayload payload = CreatePushObject(msg, userIds, message);
                    if (payload != null)
                    {
                        return client.SendPush(payload).isResultOK();
                    }
                }
                catch (Exception)
                {
                }
                return false;
            });

            //服务器保存消息
            Task task = Task.Factory.StartNew(() =>
            {
                try
                {
                    List<EntityBase> entities = new List<EntityBase>();
                    foreach (var id in userIds)
                    {
                        Msg obj = new Msg();
                        obj.SetNewEntity();

                        obj.MasterId = masterId;
                        obj.MasterType = masterType;
                        obj.Title = msg;
                        obj.Content = msg;
                        obj.ReceiverId = id;
                        obj.ReceiverType = UserType.USER.Id;
                        obj.SenderId = Globals.ADMIN_ID;
                        obj.SenderType = UserType.SYSTEM.Id;
                        obj.IsRead = false;
                    }
                    var cmd = CommandHelper.CreateSave(entities);
                    DbContext.GetInstance().Execute(cmd);
                }
                catch (Exception)
                {
                }
            });
        }

        /// <summary>
        /// 发送课程模块的系统消息
        /// </summary>
        /// <param name="extras"></param>
        /// <param name="userId"></param>
        /// <param name="msg"></param>
        public static void SendCourseSystemMessage(Dictionary<string, object> extras, string userId, string msg = "")
        {
            var userIds = new List<string>();
            userIds.Add(userId);
            extras.Add("Id",Ext.NewId());
            extras.Add("TypeName", "课程消息");
            extras.Add("CreateDate", Ext.ToDateTimeString(DateTime.Now));

            SendNotification(extras, userIds, msg);
        }
        public static void SendNotification(Dictionary<string, object> extras, List<string> userIds, string msg = "")
        {
            //发送消息
            Task<bool> send = Task.Factory.StartNew<bool>(() =>
            {
                try
                {
                    JPushClient client = new JPushClient(app_key, master_secret);
                    PushPayload payload = CreateNotificationObject(msg, extras, userIds);
                    if (payload != null)
                    {
                        return client.SendPush(payload).isResultOK();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                return false;
            });

        }

        private static PushPayload CreatePushObject(string msg, List<string> userIds, Message message = null)
        {
            var result = GetRegIdList(userIds);
            if (result.IsSuccess && result.Entities.IsNotNullOrEmpty())
            {
                HashSet<string> hash = new HashSet<string>();
                foreach (var obj in result.Entities)
                {
                    var user = obj as MsgReg;
                    hash.Add(user.RegId);
                }

                PushPayload pushPayload = new PushPayload();
                pushPayload.platform = Platform.android_ios();
                pushPayload.audience = Audience.s_registrationId(hash);
                if (!string.IsNullOrEmpty(msg))
                {
                    pushPayload.notification = new Notification().setAlert(msg);
                }
                if (message != null)
                {
                    pushPayload.message = message;
                }
                return pushPayload;
            }

            return null;
        }

        private static PushPayload CreateNotificationObject(string msg, Dictionary<string, object> extras, List<string> userIds)
        {
            var result = GetRegIdList(userIds);
            if (result.IsSuccess && result.Entities.IsNotNullOrEmpty())
            {
                HashSet<string> hash = new HashSet<string>();
                foreach (var obj in result.Entities)
                {
                    var user = obj as MsgReg;
                    hash.Add(user.RegId);
                }

                PushPayload pushPayload = new PushPayload();
                pushPayload.platform = Platform.android_ios();
                pushPayload.audience = Audience.s_registrationId(hash);
                Notification notification = new Notification();
                notification.AndroidNotification = new AndroidNotification();
                notification.IosNotification = new IosNotification();
                notification.AndroidNotification.setAlert(msg);
                notification.IosNotification.setAlert(msg);
                notification.IosNotification.setContentAvailable(true);
                foreach (var item in extras)
                {
                    notification.AndroidNotification.AddExtra(item.Key, item.Value.ToString());
                    notification.IosNotification.AddExtra(item.Key, item.Value.ToString());
                }

                pushPayload.notification = notification;

                return pushPayload;
            }

            return null;
        }

        private static Response GetRegIdList(List<string> userIds)
        {
            var cmd = CommandHelper.CreateText<MsgReg>();
            if (userIds.IsNotNullOrEmpty())
            {
                cmd.Text = "SELECT Id,RegId FROM MsgReg WHERE Id IN (SELECT Id FROM dbo.fn_Split(@userIds))";
                cmd.Params.Add("@userIds", userIds.ToIdString());
            }
            else
            {
                cmd.Text = "SELECT Id,RegId FROM MsgReg";
            }

            var result = DbContext.GetInstance().Execute(cmd);
            return result;
        }
    }
}
