using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 结算单状态
    /// </summary>
    public class VipBillState
    {
        public static readonly BaseData SUBMIT = new BaseData { Id = "026001", Name = "未确认" };

        public static readonly BaseData PASS = new BaseData { Id = "026002", Name = "已确认" };

        public static readonly BaseData FINISH = new BaseData { Id = "026003", Name = "已完成" };

    }
}
