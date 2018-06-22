using System;
using YDL.Utility;

namespace YDL.Core
{
    /// <summary>
    /// 字段特性
    /// </summary>
    [AttributeUsage(AttributeTargets.Property)]
    public class FieldAttribute : Attribute
    {
        /// <summary>
        /// 字段名称
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// 数据类型
        /// </summary>
        public DataType DataType { get; set; }

        /// <summary>
        /// 主键
        /// </summary>
        public bool IsKey { get; set; }

        /// <summary>
        /// 启用更新
        /// </summary>
        public bool IsUpdate { get; set; }

        /// <summary>
        /// 仅插入时更新
        /// </summary>
        public bool OnlyInsert { get; set; }

        /// <summary>
        /// 仅插入时更新
        /// </summary>
        public bool IsLink { get; set; }

        public FieldAttribute(string name = null, DataType dataType = DataType.String, bool isKey = false, bool isUpdate = true, bool onlyInsert = false, bool isLink = false)
        {
            Name = name;
            DataType = dataType;
            IsKey = isKey;
            IsUpdate = isUpdate;
            OnlyInsert = onlyInsert;
            IsLink = isLink;
        }
    }
}
