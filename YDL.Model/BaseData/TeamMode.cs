using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 团体比赛对阵方式
    /// </summary>
    public class TeamMode
    {
        /// <summary>
        /// 方式1
        /// </summary>
        public static readonly BaseData AX_BY_ACXZ_BZ_CY = new BaseData { Id = "021001", Name = "①A-X②B-Y③AC/BC-XZ/YZ④A/B-Z⑤C-X/Y" };

        /// <summary>
        /// 方式2
        /// </summary>
        public static readonly BaseData AX_BY_CZ_AY_BX = new BaseData { Id = "021002", Name = "①A-X②B-Y③C-Z④A-Y⑤B-X" };

        /// <summary>
        /// 方式3
        /// </summary>
        public static readonly BaseData AA_BCBC_DD = new BaseData { Id = "021003", Name = "①A-A②BC-BC③D-D" };

        /// <summary>
        /// 方式4
        /// </summary>
        public static readonly BaseData AX_BY_DOUBLE_AY_CZ = new BaseData { Id = "021004", Name = "乒超①A-X②B-Y③BC/BD/CD-XZ/XW/ZW④A-Y⑤C-Z" };

        /// <summary>
        /// 方式5
        /// </summary>
        public static readonly BaseData AA_BB_CC_DD_DOUBLE = new BaseData { Id = "021005", Name = "①A-A②B-B③C-C④D-D⑤AD/BD/CD" };

        /// <summary>
        /// 方式6
        /// </summary>
        public static readonly BaseData AX_BY_DOUBLE_AY_CDZW = new BaseData { Id = "021006", Name = "①A-X②B-Y③BC/BD/CD-XZ/XW/ZW④A-Y⑤C/D-Z/W" };

        /// <summary>
        /// 方式7
        /// </summary>
        public static readonly BaseData AX_BY_ACXZ_BZ_CY2 = new BaseData { Id = "021007", Name = "①A-X②B-Y③AC-XZ④B-Z⑤C-Y" };

        /// <summary>
        /// 方式8
        /// </summary>
        public static readonly BaseData CDYZ_AW_BX_CY_DZ = new BaseData { Id = "021008", Name = "①CD-YZ②A-W③B-X④C-Y⑤D-Z" };

        /// <summary>
        /// 最新赛制
        /// </summary>
        public static readonly BaseData BCYZ_AX_CZ_AY_BX = new BaseData { Id = "021009", Name = "①BC-YZ②A-X③C-Z④A-Y⑤B-X" };
    }
}
