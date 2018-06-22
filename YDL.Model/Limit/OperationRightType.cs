using System;
using System.ComponentModel;

namespace YDL.Model
{
    /// <summary>
    /// 操作权限的动作类型
    /// </summary>
    [Flags]
    public enum OperationRightType : int
    {
        /// <summary>
        /// 新增
        /// </summary>
        [Description("新增")]
        Add = 1,
        /// <summary>
        /// 修改自己
        /// </summary>
        [Description("修改自己")]
        EditSelf = 2,
        /// <summary>
        /// 修改全部
        /// </summary>
        [Description("修改全部")]
        EditAll = 4,
        /// <summary>
        /// 删除自己
        /// </summary>
        [Description("删除自己")]
        DelSelf = 8,
        /// <summary>
        /// 删除全部
        /// </summary>
        [Description("删除全部")]
        DelAll = 16,
        /// <summary>
        /// 移交自己创建的
        /// </summary>
        [Description("移交自己")]
        ChangeOwnerSelf = 32,
        /// <summary>
        /// 移交全部创建的
        /// </summary>
        [Description("移交全部")]
        ChangeOwnerAll = 64,
        /// <summary>
        /// 审核
        /// </summary>
        [Description("审核")]
        Audit = 128,
        /// <summary>
        /// 取消自己创建的
        /// </summary>
        [Description("取消自己")]
        CancelSelf = 256,
        /// <summary>
        /// 取消全部创建的
        /// </summary>
        [Description("取消全部")]
        CancelAll = 512,
        /// <summary>
        /// 停用自己创建的
        /// </summary>
        [Description("停用自己")]
        StopSelf = 1024,
        /// <summary>
        /// 停用全部的
        /// </summary>
        [Description("停用全部")]
        StopAll = 2048,
        /// <summary>
        /// 结束自己创建的
        /// </summary>
        [Description("结束自己")]
        EndSelf = 4096,
        /// <summary>
        /// 结束全部的
        /// </summary>
        [Description("结束全部")]
        EndAll = 8192,
        /// <summary>
        /// 置顶
        /// </summary>
        [Description("置顶")]
        SetTop = 16384
    }
}
