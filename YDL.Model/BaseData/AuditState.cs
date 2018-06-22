using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 审核通用3个状态
    /// </summary>
    public static class AuditState
    {
        public static readonly BaseData NOTSUBMIT = new BaseData { Id = "010000", Name = "未提交" };

        public static readonly BaseData PROCESSING = new BaseData { Id = "010001", Name = "审核中" };

        public static readonly BaseData PASS = new BaseData { Id = "010002", Name = "已通过" };

        public static readonly BaseData REFUSE = new BaseData { Id = "010003", Name = "已拒绝" };

        public static readonly BaseData CANCEL = new BaseData { Id = "010009", Name = "已取消" };

        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { PROCESSING, PASS, CANCEL };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
