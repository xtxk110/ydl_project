using System;
using System.Runtime.Serialization;
using YDL.Utility;

namespace YDL.Core
{
    /// <summary>
    /// 实体基类
    /// </summary>
    public abstract class EntityBase : ICloneable
    {
        /// <summary>
        /// 主键
        /// </summary>
        [Field(isKey: true, onlyInsert: true)]
        public string Id { get; set; }

        /// <summary>
        /// 行状态
        /// </summary>
      
        public RowState RowState { get; set; }

        /// <summary>
        /// 行版本管理
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int RowVersion { get; set; }

        /// <summary>
        /// 创建日期
        /// </summary>
        [Field(dataType: DataType.DateTime, onlyInsert: true)]
        public DateTime? CreateDate { get; set; }

        /// <summary>
        /// 缓存属性
        /// </summary>
        public Object Tag;

       
    
        public void SetNewId()
        {
            Id = Ext.NewId();
        }

        public void SetCreateDate()
        {
            CreateDate = DateTime.Now;
        }

        public void SetRowAdded()
        {
            RowState = RowState.Added;
        }

        public void SetRowDeleted()
        {
            RowState = RowState.Deleted;
        }

        public void SetRowModified()
        {
            RowState = RowState.Modified;
        }

        public void SetRowUnchanged()
        {
            RowState = RowState.Unchanged;
        }

        public override string ToString()
        {
            return Id == null ? base.ToString() : Id;
        }

        public override int GetHashCode()
        {
            return base.GetHashCode();
        }

        public object Clone()
        {
            return this.DeepClone();
        }

        public bool TrySetNewEntity()
        {
            if (RowState == RowState.Added)
            {
                SetNewId();
                SetCreateDate();
                return true;
            }
            return false;
        }

        public void SetNewEntity()
        {
            SetNewId();
            SetCreateDate();
            SetRowAdded();
        }
    }
}
