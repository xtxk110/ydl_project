namespace YDL.Model
{
    /// <summary>
    /// 文件类型
    /// (主要区分视频文件与其他文件，因视频文件存腾讯云)
    /// </summary>
    public static class FileType
    {
        public static readonly BaseData GROUP = new BaseData { Id = "029", Name = "文件类型" };

        public static readonly BaseData COMMON = new BaseData { Id = "029001", Name = "普通文件", GroupId = GROUP.Id };
        public static readonly BaseData VIDEO = new BaseData { Id = "029002", Name = "视频文件", GroupId = GROUP.Id };
        public static readonly BaseData PICTURE = new BaseData { Id = "029003", Name = "图片文件", GroupId = GROUP.Id };
    }
}
