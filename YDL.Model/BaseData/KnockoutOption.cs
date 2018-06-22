using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YDL.Model
{
    /// <summary>
    /// 晋级方式
    /// </summary>
    public class KnockoutOption
    {
        /// <summary>
        /// 组信息
        /// </summary>
        public static readonly BaseData GROUP = new BaseData { Id = "014", Name = "晋级方式" };

        /// <summary>
        /// 单淘汰
        /// </summary>
        public static readonly BaseData KNOCKOUT = new BaseData { Id = "014001", Name = "单淘汰", GroupId = GROUP.Id };

        /// <summary>
        /// 单循环
        /// </summary>
        public static readonly BaseData ROUND = new BaseData { Id = "014002", Name = "单循环", GroupId = GROUP.Id };

        /// <summary>
        /// 小组循环后淘汰
        /// </summary>
        public static readonly BaseData ROUND_KNOCKOUT = new BaseData { Id = "014003", Name = "小组循环后淘汰", GroupId = GROUP.Id };


        /// <summary>
        /// 获取所有项目
        /// </summary>
        /// <param name="containAllItem"></param>
        /// <returns></returns>
        public static List<BaseData> GetItems(bool containAllItem)
        {
            var result = new List<BaseData> { KNOCKOUT, ROUND_KNOCKOUT };
            if (containAllItem)
            {
                result.Insert(0, BaseData.ALL_ITEM);
            }
            return result;
        }
    }
}
