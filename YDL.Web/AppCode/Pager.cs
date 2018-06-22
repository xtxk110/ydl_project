namespace YDL.Web
{
    public class Pager
    {
        /// <summary>
        /// 总数据数
        /// </summary>
        public int TotalCount { get; set; }
        /// <summary>
        /// 当前页数
        /// </summary>
        public int PageIndex { get; set; }
        /// <summary>
        /// 每页数量
        /// </summary>
        public int PageSize { get; set; }
        /// <summary>
        /// 最大页数
        /// </summary>
        public int MaxPageIndex
        {
            get
            {
                return (TotalCount % PageSize == 0) ? (TotalCount / PageSize) : (TotalCount / PageSize + 1);
            }
        }

    }
}