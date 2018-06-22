using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 退款单状态
    /// </summary>
    public class VipRefundState
    {
        public static readonly BaseData SUBMIT = new BaseData { Id = "025001", Name = "处理中" };

        public static readonly BaseData PASS = new BaseData { Id = "025002", Name = "退款中" };

        public static readonly BaseData FINISH = new BaseData { Id = "025003", Name = "已完成" };

        public static readonly BaseData REFUSE = new BaseData { Id = "025006", Name = "已拒绝" };

        public static readonly BaseData CANCEL = new BaseData { Id = "025009", Name = "已取消" };
    }
}
