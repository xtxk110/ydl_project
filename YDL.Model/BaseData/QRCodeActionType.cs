using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 二维码类型
    /// </summary>
    public static class QRCodeActionType
    {
        public static readonly BaseData DETAIL = new BaseData { Id = "Detail", Name = "详情" };

        public static readonly BaseData PAY = new BaseData { Id = "Pay", Name = "支付" };

    }
}
