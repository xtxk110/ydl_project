using YDL.Core;

namespace YDL.Model
{
    /// <summary>
    /// 用户收藏表
    /// </summary>
    [Table]
    public class CoachUserFavorite : EntityBase
    {
        /// <summary>
        /// 用户编号
        /// </summary>
        [Field]
        public string UserId { get; set; }

        /// <summary>
        /// 收藏对象Id
        /// </summary>
        [Field]
        public string FavoriteId { get; set; }


        /// <summary>
        /// 收藏对象类型
        /// </summary>
        [Field]
        public string FavoriteType { get; set; }

     

    }
}
