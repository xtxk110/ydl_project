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
    /// 笔记
    /// </summary>
    [Table]
    public class Note : HeadBase
    {
        /// <summary>
        /// 重写头像字段
        /// </summary>
        [Field(isUpdate: false)]
        public new string HeadUrl { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        [Field(isUpdate: false)]
        public string Sex { get; set; }

        /// <summary>
        /// 参与人显示名称选项
        /// </summary>
        public string NameOption { get; set; }

        /// <summary>
        /// 来源类型
        /// </summary>
        [Field]
        public string MasterType { get; set; }

        /// <summary>
        /// 来源编号
        /// </summary>
        [Field]
        public string MasterId { get; set; }

        /// <summary>
        /// 是否共享
        /// </summary>
        [Field(dataType: DataType.Boolean)]
        public bool IsShare { get; set; }

        /// <summary>
        /// 标题
        /// </summary>
        [Field]
        public string Title { get; set; }

        /// <summary>
        /// 内容
        /// </summary>
        [Field]
        public string Content { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Field]
        public string CreatorId { get; set; }

        /// <summary>
        /// 地址
        /// </summary>
        [Field]
        public string Address { get; set; }

        /// <summary>
        /// 经度
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Lng { get; set; }

        /// <summary>
        /// 纬度
        /// </summary>
        [Field(dataType: DataType.Double)]
        public double Lat { get; set; }

        /// <summary>
        /// 赞数
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int SupportCount { get; set; }

        /// <summary>
        /// 回复数
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int ReplyCount { get; set; }

        /// <summary>
        /// 是否已赞
        /// </summary>
        [Field(dataType: DataType.Int32, isUpdate: false)]
        public int HasSupport { get; set; }

        /// <summary>
        /// 点赞列表
        /// </summary>
        public List<NoteSupport> SupportList { get; set; }

        /// <summary>
        /// 分享课程Id 
        /// </summary>
        [Field]
        public string CourseId { get; set; }

        /// <summary>
        /// 分享课程内容摘要
        /// </summary>
        public CoachCourse CourseSummary { get; set; }
    }
}
