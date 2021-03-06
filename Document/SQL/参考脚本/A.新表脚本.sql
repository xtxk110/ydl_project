USE [YDL]
GO
/****** Object:  Table [dbo].[QRCode]    Script Date: 2017/3/15 10:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--二维码表
IF OBJECT_ID('QRCode', 'U') IS  NULL 
BEGIN 
	CREATE TABLE [dbo].[QRCode](
			[Id] [nvarchar](50) NOT NULL,
			[MasterId] [nvarchar](50) NOT NULL,
			[ActionType] [nvarchar](100) NOT NULL,
			[BusinessType] [nvarchar](100) NOT NULL,
			[ScanCount] [int] NOT NULL,
			[ScanTime] [datetime] NOT NULL,
			[CreateDate] [datetime] NOT NULL
		) ON [PRIMARY]

		SET ANSI_PADDING ON

		/****** Object:  Index [IX_MatesrID_ActionType_BusinessType]    Script Date: 2017/3/15 10:50:23 ******/
		CREATE UNIQUE CLUSTERED INDEX [IX_MatesrID_ActionType_BusinessType] ON [dbo].[QRCode]
		(
			[MasterId] ASC,
			[ActionType] ASC,
			[BusinessType] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		ALTER TABLE [dbo].[QRCode] ADD  CONSTRAINT [DF__QRCode__MasterId__7BF04F28]  DEFAULT ('') FOR [MasterId]
END
GO 

-- 教练表
IF OBJECT_ID('Coach', 'U') IS  NULL 
BEGIN 
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	
	CREATE TABLE [dbo].[Coach](
		[Id] [nvarchar](50) NOT NULL,
		[CommissionPercentage] [decimal](18, 2) NULL,
		[HeadUrl] [nvarchar](2000) NULL,
		[IdCardFrontUrl] [nvarchar](2000) NULL,
		[IdCardBackUrl] [nvarchar](2000) NULL,
		[VenueId] [nvarchar](50) NULL,
		[BeginTeachingDate] [datetime] NULL,
		[Qualification] [nvarchar](1000) NULL,
		[State] [nvarchar](50) NOT NULL,
		[Grade] [int] NULL,
		[AuditOpinion] [nvarchar](500) NULL,
		[OrganizationId] [nvarchar](50) NULL,
		[IsEnabled] [bit] NULL,
		[FileId] [nvarchar](50) NULL,
		[AuditDateTime] [datetime] NULL,
		[CreateDate] [datetime] NOT NULL
	) ON [PRIMARY]

	SET ANSI_PADDING ON
	/****** Object:  Index [Coach_Id]    Script Date: 2017/4/24 16:15:39 ******/
	CREATE UNIQUE CLUSTERED INDEX [Coach_Id] ON [dbo].[Coach]
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	
	SET ANSI_PADDING ON

	/****** Object:  Index [Coach_OrganizationId]    Script Date: 2017/4/24 16:15:39 ******/
	CREATE NONCLUSTERED INDEX [Coach_OrganizationId] ON [dbo].[Coach]
	(
		[OrganizationId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END
GO 

--教练申请表
IF OBJECT_ID('CoachApply', 'U') IS  NULL 
BEGIN 
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[CoachApply](
		[Id] [nvarchar](50) NOT NULL,
		[CommissionPercentage] [decimal](18, 2) NULL,
		[HeadUrl] [nvarchar](2000) NULL,
		[IdCardFrontUrl] [nvarchar](2000) NULL,
		[IdCardBackUrl] [nvarchar](2000) NULL,
		[VenueId] [nvarchar](50) NULL,
		[BeginTeachingDate] [datetime] NULL,
		[Qualification] [nvarchar](1000) NULL,
		[State] [nvarchar](50) NOT NULL,
		[Grade] [int] NULL,
		[AuditOpinion] [nvarchar](500) NULL,
		[OrganizationId] [nvarchar](50) NULL,
		[IsEnabled] [bit] NULL,
		[FileId] [nvarchar](50) NULL,
		[Name] [nvarchar](50) NULL,
		[Mobile] [nvarchar](20) NULL,
		[CardId] [nvarchar](50) NULL,
		[AuditDateTime] [datetime] NULL,
		[CreateDate] [datetime] NOT NULL
	) ON [PRIMARY]

	SET ANSI_PADDING ON

	/****** Object:  Index [CoachApply_Id]    Script Date: 2017/4/25 13:33:58 ******/
	CREATE UNIQUE CLUSTERED INDEX [CoachApply_Id] ON [dbo].[CoachApply]
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END 

--教练评论表
IF OBJECT_ID('CoachComment', 'U') IS  NULL 
BEGIN 
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[CoachComment](
		[Id] [nvarchar](50) NOT NULL,
		[CoacherUserId] [nvarchar](50) NOT NULL,
		[CourseId] [nvarchar](50) NOT NULL,
		[Score] [decimal](18, 2) NOT NULL,
		[Comment] [nvarchar](500) NOT NULL,
		[CommentatorId] [nvarchar](50) NOT NULL,
		[IsShareName] [bit] NOT NULL,
		[HeadUrl] [nvarchar](500) NULL,
		[CreateDate] [datetime] NOT NULL
	) ON [PRIMARY]

	SET ANSI_PADDING ON

	/****** Object:  Index [CoachComment_CoacherUserId]    Script Date: 2017/4/25 13:42:50 ******/
	CREATE CLUSTERED INDEX [CoachComment_CoacherUserId] ON [dbo].[CoachComment]
	(
		[CoacherUserId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	SET ANSI_PADDING ON

	/****** Object:  Index [CoachComment_CourseId]    Script Date: 2017/4/25 13:42:50 ******/
	CREATE NONCLUSTERED INDEX [CoachComment_CourseId] ON [dbo].[CoachComment]
	(
		[CourseId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END 

--教练评论表
IF OBJECT_ID('CoachCourse', 'U') IS  NULL 
BEGIN 
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[CoachCourse](
		[Id] [nvarchar](50) NOT NULL,
		[CoachId] [nvarchar](50) NOT NULL,
		[State] [nvarchar](50) NOT NULL,
		[BeginTime] [datetime] NOT NULL,
		[EndTime] [datetime] NOT NULL,
		[Type] [nvarchar](20) NOT NULL,
		[VenueId] [nvarchar](50) NOT NULL,
		[CourseGrade] [int] NULL,
		[CourseContent] [nvarchar](1000) NULL,
		[CategoryOfTechnologyId] [nvarchar](50) NULL,
		[CourseSummary] [nvarchar](1000) NULL,
		[CityId] [nvarchar](50) NOT NULL,
		[CreateDate] [datetime] NULL,
		[HeadUrl] [nvarchar](200) NULL
	) ON [PRIMARY]

	SET ANSI_PADDING ON

	/****** Object:  Index [CoachCourse_Id]    Script Date: 2017/4/25 13:45:32 ******/
	CREATE UNIQUE CLUSTERED INDEX [CoachCourse_Id] ON [dbo].[CoachCourse]
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	/****** Object:  Index [CoachCourse_BeginTime]    Script Date: 2017/4/25 13:45:32 ******/
	CREATE NONCLUSTERED INDEX [CoachCourse_BeginTime] ON [dbo].[CoachCourse]
	(
		[BeginTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	SET ANSI_PADDING ON

	/****** Object:  Index [CoachCourse_CoachId]    Script Date: 2017/4/25 13:45:32 ******/
	CREATE NONCLUSTERED INDEX [CoachCourse_CoachId] ON [dbo].[CoachCourse]
	(
		[CoachId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	/****** Object:  Index [CoachCourse_EndTime]    Script Date: 2017/4/25 13:45:32 ******/
	CREATE NONCLUSTERED INDEX [CoachCourse_EndTime] ON [dbo].[CoachCourse]
	(
		[EndTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END 

IF OBJECT_ID('CoachCourseBak', 'U') IS  NULL 
BEGIN 
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[CoachCourseBak](
		[Id] [nvarchar](50) NOT NULL,
		[CoachId] [nvarchar](50) NOT NULL,
		[State] [nvarchar](50) NULL,
		[BeginTime] [datetime] NULL,
		[EndTime] [datetime] NOT NULL,
		[Type] [nvarchar](20) NOT NULL,
		[VenueId] [nvarchar](50) NOT NULL,
		[CourseGrade] [int] NULL,
		[CourseContent] [nvarchar](1000) NULL,
		[CategoryOfTechnologyId] [nvarchar](50) NULL,
		[CourseSummary] [nvarchar](1000) NULL,
		[CreateDate] [datetime] NULL,
		[HeadUrl] [nvarchar](200) NULL
	) ON [PRIMARY]

END 

IF OBJECT_ID('CoachCourseJoin', 'U') IS  NULL 
BEGIN 
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[CoachCourseJoin](
		[Id] [nvarchar](50) NOT NULL,
		[StudentId] [nvarchar](50) NOT NULL,
		[CourseId] [nvarchar](50) NOT NULL,
		[CoachId] [nvarchar](50) NOT NULL,
		[ThenCourseUnitPrice] [decimal](18, 2) NULL,
		[CreateDate] [datetime] NOT NULL
	) ON [PRIMARY]

	SET ANSI_PADDING ON

	/****** Object:  Index [CoachCourseJoin_CourseId]    Script Date: 2017/4/25 13:48:45 ******/
	CREATE CLUSTERED INDEX [CoachCourseJoin_CourseId] ON [dbo].[CoachCourseJoin]
	(
		[CourseId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	SET ANSI_PADDING ON

	/****** Object:  Index [CoachCourseJoin_CoachId]    Script Date: 2017/4/25 13:48:45 ******/
	CREATE NONCLUSTERED INDEX [CoachCourseJoin_CoachId] ON [dbo].[CoachCourseJoin]
	(
		[CoachId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	SET ANSI_PADDING ON

	/****** Object:  Index [CoachCourseJoin_StudentId]    Script Date: 2017/4/25 13:48:45 ******/
	CREATE NONCLUSTERED INDEX [CoachCourseJoin_StudentId] ON [dbo].[CoachCourseJoin]
	(
		[StudentId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END 

IF OBJECT_ID('CoachIncome', 'U') IS  NULL 
BEGIN 
		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON
		CREATE TABLE [dbo].[CoachIncome](
			[Id] [nvarchar](50) NOT NULL,
			[CoachId] [nvarchar](50) NOT NULL,
			[StudentId] [nchar](10) NULL,
			[CourseId] [nvarchar](50) NULL,
			[CourseType] [nvarchar](50) NOT NULL,
			[OriginalMoney] [decimal](18, 2) NOT NULL,
			[CoachCommissionPercentage] [decimal](18, 2) NOT NULL,
			[CoachRealIncome] [decimal](18, 2) NULL,
			[OrganizationCommissionPercentage] [decimal](18, 2) NULL,
			[OrganizationRealIncome] [decimal](18, 2) NULL,
			[CreateDate] [datetime] NOT NULL
		) ON [PRIMARY]

		SET ANSI_PADDING ON

		/****** Object:  Index [CoachIncome_CoachId]    Script Date: 2017/4/25 13:50:10 ******/
		CREATE CLUSTERED INDEX [CoachIncome_CoachId] ON [dbo].[CoachIncome]
		(
			[CoachId] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END 

IF OBJECT_ID('CoachOrderTrialCourse', 'U') IS  NULL 
BEGIN 
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[CoachOrderTrialCourse](
		[Id] [nvarchar](50) NOT NULL,
		[StudentId] [nvarchar](50) NULL,
		[Name] [nvarchar](50) NULL,
		[Mobile] [nvarchar](20) NULL,
		[CityCode] [nvarchar](10) NULL,
		[Address] [nvarchar](300) NULL,
		[Remark] [nvarchar](500) NULL,
		[IsContact] [bit] NULL,
		[ContactSituation] [nvarchar](500) NULL,
		[CreateDate] [datetime] NULL
	) ON [PRIMARY]

	SET ANSI_PADDING ON

	/****** Object:  Index [CoachOrderTrialCourse_StudentId]    Script Date: 2017/4/25 13:51:16 ******/
	CREATE CLUSTERED INDEX [CoachOrderTrialCourse_StudentId] ON [dbo].[CoachOrderTrialCourse]
	(
		[StudentId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	ALTER TABLE [dbo].[CoachOrderTrialCourse] ADD  CONSTRAINT [DF_CoachOrderTrialCourse_IsContact]  DEFAULT ((0)) FOR [IsContact]
END 

IF OBJECT_ID('CoachOrganization', 'U') IS  NULL 
BEGIN 
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[CoachOrganization](
		[Id] [nvarchar](50) NOT NULL,
		[HeadUrl] [nvarchar](500) NULL,
		[Name] [nvarchar](100) NOT NULL,
		[Address] [nvarchar](500) NULL,
		[CommissionPercentage] [decimal](18, 2) NULL,
		[ManagerId] [nvarchar](50) NULL,
		[CreateDate] [datetime] NULL
	) ON [PRIMARY]

	SET ANSI_PADDING ON

	/****** Object:  Index [CoachOrganization_Id]    Script Date: 2017/4/25 13:52:28 ******/
	CREATE UNIQUE CLUSTERED INDEX [CoachOrganization_Id] ON [dbo].[CoachOrganization]
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END 

IF OBJECT_ID('CoachOrganization', 'U') IS  NULL 
BEGIN 
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CoachPrice](
	[Id] [nvarchar](50) NOT NULL,
	[CityCode] [nchar](10) NOT NULL,
	[BigCourse] [decimal](18, 2) NOT NULL,
	[AGrade] [decimal](18, 2) NOT NULL,
	[BGrade] [decimal](18, 2) NOT NULL,
	[CGrade] [decimal](18, 2) NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [CoachPrice_CityCode]    Script Date: 2017/4/25 13:53:37 ******/
CREATE UNIQUE CLUSTERED INDEX [CoachPrice_CityCode] ON [dbo].[CoachPrice]
(
	[CityCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[CoachPrice] ADD  CONSTRAINT [DF_CoachPrice_IsEnabled]  DEFAULT ((0)) FOR [IsEnabled]

END 

IF OBJECT_ID('CoachStudentMoney', 'U') IS  NULL 
BEGIN 
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CoachStudentMoney](
	[Id] [nvarchar](50) NOT NULL,
	[StudentUserId] [nvarchar](50) NOT NULL,
	[CoachId] [nvarchar](50) NULL,
	[Amount] [int] NOT NULL,
	[ThenTotalAmount] [int] NULL,
	[IsPay] [bit] NOT NULL,
	[ThenMoney] [decimal](18, 2) NOT NULL,
	[CourseTypeId] [nvarchar](50) NOT NULL,
	[CourseTypeName] [nvarchar](50) NOT NULL,
	[Deadline] [datetime] NULL,
	[CityId] [nvarchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[HeadUrl] [nvarchar](500) NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [CoachStudentMoney_StudentUserId]    Script Date: 2017/4/25 13:54:39 ******/
CREATE CLUSTERED INDEX [CoachStudentMoney_StudentUserId] ON [dbo].[CoachStudentMoney]
(
	[StudentUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [CoachStudentMoney_CoachId]    Script Date: 2017/4/25 13:54:39 ******/
CREATE NONCLUSTERED INDEX [CoachStudentMoney_CoachId] ON [dbo].[CoachStudentMoney]
(
	[CoachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [CoachStudentMoney_Id]    Script Date: 2017/4/25 13:54:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [CoachStudentMoney_Id] ON [dbo].[CoachStudentMoney]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[CoachStudentMoney] ADD  CONSTRAINT [DF_CoacherStudentMoney_IsPay]  DEFAULT ((0)) FOR [IsPay]
ALTER TABLE [dbo].[CoachStudentMoney] ADD  CONSTRAINT [DF_CoacherStudentMoney_Money]  DEFAULT ((0)) FOR [ThenMoney]
END 

IF OBJECT_ID('CoachStudentMoneyNotPay', 'U') IS  NULL 
BEGIN 
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CoachStudentMoneyNotPay](
	[Id] [nvarchar](50) NOT NULL,
	[StudentUserId] [nvarchar](50) NOT NULL,
	[CoachId] [nvarchar](50) NULL,
	[Amount] [int] NOT NULL,
	[ThenTotalAmount] [int] NULL,
	[IsPay] [bit] NOT NULL,
	[ThenMoney] [decimal](18, 2) NOT NULL,
	[CourseTypeId] [nvarchar](50) NOT NULL,
	[CourseTypeName] [nvarchar](50) NOT NULL,
	[Deadline] [datetime] NULL,
	[CityId] [nvarchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[HeadUrl] [nvarchar](500) NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [CoachStudentMoneyNotPay_Id]    Script Date: 2017/4/25 13:55:50 ******/
CREATE UNIQUE CLUSTERED INDEX [CoachStudentMoneyNotPay_Id] ON [dbo].[CoachStudentMoneyNotPay]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[CoachStudentMoneyNotPay] ADD  CONSTRAINT [DF_CoacherStudentMoneyNotPay_IsPay]  DEFAULT ((0)) FOR [IsPay]
ALTER TABLE [dbo].[CoachStudentMoneyNotPay] ADD  CONSTRAINT [DF_CoacherStudentMoneyNotPay_Money]  DEFAULT ((0)) FOR [ThenMoney]

END 

IF OBJECT_ID('CoachStudentRemark', 'U') IS  NULL 
BEGIN 

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CoachStudentRemark](
	[Id] [nvarchar](50) NULL,
	[CourseId] [nvarchar](50) NULL,
	[StudentId] [nvarchar](50) NULL,
	[Remark] [nvarchar](500) NULL,
	[RemarkUserId] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [CoachStudentRemark_StudentId]    Script Date: 2017/4/25 13:56:54 ******/
CREATE CLUSTERED INDEX [CoachStudentRemark_StudentId] ON [dbo].[CoachStudentRemark]
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [CoachStudentRemark_CourseId]    Script Date: 2017/4/25 13:56:54 ******/
CREATE NONCLUSTERED INDEX [CoachStudentRemark_CourseId] ON [dbo].[CoachStudentRemark]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END 

IF OBJECT_ID('CoachTeachingPointCoaches', 'U') IS  NULL 
BEGIN 
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[CoachTeachingPointCoaches](
		[Id] [nvarchar](50) NOT NULL,
		[VenueId] [nvarchar](50) NOT NULL,
		[CoacherId] [nvarchar](50) NOT NULL,
		[CreateDate] [datetime] NULL
	) ON [PRIMARY]

	SET ANSI_PADDING ON

	/****** Object:  Index [CoachTeachingPointCoaches_VenueId]    Script Date: 2017/4/25 13:58:12 ******/
	CREATE CLUSTERED INDEX [CoachTeachingPointCoaches_VenueId] ON [dbo].[CoachTeachingPointCoaches]
	(
		[VenueId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END 

IF OBJECT_ID('CoachUserFavorite', 'U') IS  NULL 
BEGIN 
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[CoachUserFavorite](
		[Id] [nvarchar](50) NULL,
		[UserId] [nvarchar](50) NULL,
		[FavoriteId] [nvarchar](50) NULL,
		[FavoriteType] [nvarchar](100) NULL,
		[CreateDate] [datetime] NULL
	) ON [PRIMARY]

	SET ANSI_PADDING ON

	/****** Object:  Index [CoachUserFavorite_UserId]    Script Date: 2017/4/25 13:59:56 ******/
	CREATE CLUSTERED INDEX [CoachUserFavorite_UserId] ON [dbo].[CoachUserFavorite]
	(
		[UserId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	SET ANSI_PADDING ON

	/****** Object:  Index [CoachUserFavorite_Favorite]    Script Date: 2017/4/25 13:59:56 ******/
	CREATE NONCLUSTERED INDEX [CoachUserFavorite_Favorite] ON [dbo].[CoachUserFavorite]
	(
		[FavoriteId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END 