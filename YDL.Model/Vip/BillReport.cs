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
    /// 收入报表
    /// </summary>
    [Table]
    public class BillReport : EntityBase
    {
        /// <summary>
        /// 机构编号
        /// </summary>
        [Field(isUpdate: false)]
        public string CompanyId { get; set; }

        /// <summary>
        /// 场馆编号
        /// </summary>
        [Field(isUpdate: false)]
        public string VenueId { get; set; }

        /// <summary>
        /// 费用类型
        /// </summary>
        [Field(isUpdate: false)]
        public string CostTypeId { get; set; }

        /// <summary>
        /// YDL收入
        /// </summary>
        [Field(dataType: DataType.Decimal, isUpdate: false)]
        public decimal YdlAmount { get; set; }

        /// <summary>
        /// 机构收入
        /// </summary>
        [Field(dataType: DataType.Decimal, isUpdate: false)]
        public decimal CompanyAmount { get; set; }

        /// <summary>
        /// 场馆收入
        /// </summary>
        [Field(dataType: DataType.Decimal, isUpdate: false)]
        public decimal VenueAmount { get; set; }

        /// <summary>
        /// 合计收入
        /// </summary>
        [Field(dataType: DataType.Decimal, isUpdate: false)]
        public decimal Total { get; set; }
    }
}
