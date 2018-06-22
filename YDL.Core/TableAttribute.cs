using System;
using YDL.Utility;

namespace YDL.Core
{
    /// <summary>
    /// 表特性
    /// </summary>
    [AttributeUsage(AttributeTargets.Class)]
    public class TableAttribute : Attribute
    {
        /// <summary>
        /// 表名
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// 插入存储过程
        /// </summary>
        public string InsertSP { get; set; }

        /// <summary>
        /// 更新存储过程
        /// </summary>
        public string UpdateSP { get; set; }

        /// <summary>
        /// 删除存储过程
        /// </summary>
        public string DeleteSP { get; set; }

        /// <summary>
        /// 启用版本管理
        /// </summary>
        public bool IsRowVersion { get; set; }

        public TableAttribute(string name = null, string insertSP = Constant.Str_Empty, string updateSP = Constant.Str_Empty, string deleteSP = Constant.Str_Empty, bool isRowVersion = false)
        {
            Name = name;
            InsertSP = insertSP;
            UpdateSP = updateSP;
            DeleteSP = deleteSP;
            IsRowVersion = isRowVersion;
        }
    }
}
