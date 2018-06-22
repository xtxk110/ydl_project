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
    /// 运动类型
    /// </summary>
    [Table]
    public class SportType : EntityBase
    {
        /// <summary>
        /// 乒乓球编号
        /// </summary>
        public static readonly String TT_ID = "474C2709-325E-49F7-AB66-A676C40B2EA6";

        /// <summary>
        /// 乒乓球默认积分
        /// </summary>
        public static readonly int TT_DEFAULT_SCORE = 1500;
        
        /// <summary>
        /// 名称
        /// </summary>
        [Field]
        public string Name { get; set; }

        /// <summary>
        /// 启用
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsEnable { get; set; }

        /// <summary>
        /// 启用俱乐部功能
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsEnableClub { get; set; }

        /// <summary>
        /// 启用赛事功能
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsEnableGame { get; set; }
    }
}
