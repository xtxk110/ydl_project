namespace YDL.Model
{
    /// <summary>
    /// 自定义异常类型
    /// </summary>
    public enum CustomExceptionType
    {
        /// <summary>
        /// 业务异常
        /// </summary>
        BusinessException = 0,
        /// <summary>
        /// 程序异常
        /// </summary>
        ProgramException = 1,
        /// <summary>
        /// 权限异常
        /// </summary>
        RightException = 2,
        /// <summary>
        /// 未知类型
        /// </summary>
        Unkonw = 100
    }
}
