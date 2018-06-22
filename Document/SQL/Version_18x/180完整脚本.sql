--�߳������û�
DELETE FROM dbo.OnlineUser

IF COL_LENGTH('GameGroup','LeaderId') IS NULL
 BEGIN
	ALTER TABLE dbo.GameGroup ADD LeaderId NVARCHAR(50) 
 END
 IF COL_LENGTH('GameGroup','TableNo') IS NULL
 BEGIN
	ALTER TABLE dbo.GameGroup ADD TableNo NVARCHAR(50) 
 END

/****** Object:  Table [dbo].[QRCode]    Script Date: 2017/3/15 10:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--��ά���
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

-- ������
IF OBJECT_ID('Coach', 'U') IS  NULL 
BEGIN 
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
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Coach_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_Coach_OrganizationId]    Script Date: 2017/4/26 17:38:06 ******/
CREATE NONCLUSTERED INDEX [IX_Coach_OrganizationId] ON [dbo].[Coach]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END
GO 

--���������
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
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CoachApply_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END 

--�������۱�
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
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CoachComment_Id] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IXC_CoachComment_CoacherUserId]    Script Date: 2017/4/26 17:40:08 ******/
CREATE CLUSTERED INDEX [IXC_CoachComment_CoacherUserId] ON [dbo].[CoachComment]
(
	[CoacherUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_CoachComment_CourseId]    Script Date: 2017/4/26 17:40:08 ******/
CREATE NONCLUSTERED INDEX [IX_CoachComment_CourseId] ON [dbo].[CoachComment]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END 

--�������۱�
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
	[HeadUrl] [nvarchar](200) NULL,
 CONSTRAINT [PK_CoachCourse_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_CoachCourse_BeginTime]    Script Date: 2017/4/26 17:42:48 ******/
CREATE NONCLUSTERED INDEX [IX_CoachCourse_BeginTime] ON [dbo].[CoachCourse]
(
	[BeginTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_CoachCourse_CoachId]    Script Date: 2017/4/26 17:42:48 ******/
CREATE NONCLUSTERED INDEX [IX_CoachCourse_CoachId] ON [dbo].[CoachCourse]
(
	[CoachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_CoachCourse_EndTime]    Script Date: 2017/4/26 17:42:48 ******/
CREATE NONCLUSTERED INDEX [IX_CoachCourse_EndTime] ON [dbo].[CoachCourse]
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
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CoachCourseJoin_Id] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IXC_CoachCourseJoin_CourseId]    Script Date: 2017/4/26 17:44:08 ******/
CREATE CLUSTERED INDEX [IXC_CoachCourseJoin_CourseId] ON [dbo].[CoachCourseJoin]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_CoachCourseJoin_CoachId]    Script Date: 2017/4/26 17:44:08 ******/
CREATE NONCLUSTERED INDEX [IX_CoachCourseJoin_CoachId] ON [dbo].[CoachCourseJoin]
(
	[CoachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_CoachCourseJoin_StudentId]    Script Date: 2017/4/26 17:44:08 ******/
CREATE NONCLUSTERED INDEX [IX_CoachCourseJoin_StudentId] ON [dbo].[CoachCourseJoin]
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
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CoachIncome_Id] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IXC_CoachIncome_CoachId]    Script Date: 2017/4/26 17:45:03 ******/
CREATE CLUSTERED INDEX [IXC_CoachIncome_CoachId] ON [dbo].[CoachIncome]
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
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_CoachOrderTrialCourse] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IXC_CoachOrderTrialCourse_StudentId]    Script Date: 2017/4/26 17:47:25 ******/
CREATE CLUSTERED INDEX [IXC_CoachOrderTrialCourse_StudentId] ON [dbo].[CoachOrderTrialCourse]
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
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_CoachOrganization_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END 

IF OBJECT_ID('CoachPrice', 'U') IS  NULL 
BEGIN 
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CoachPrice](
	[Id] [nvarchar](50) NOT NULL,
	[CityCode] [nvarchar](50) NULL,
	[BigCourse] [decimal](18, 2) NOT NULL,
	[AGrade] [decimal](18, 2) NOT NULL,
	[BGrade] [decimal](18, 2) NOT NULL,
	[CGrade] [decimal](18, 2) NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IXC_CoachPrice_CityCode]    Script Date: 2017/4/26 17:52:46 ******/
CREATE UNIQUE CLUSTERED INDEX [IXC_CoachPrice_CityCode] ON [dbo].[CoachPrice]
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
	[HeadUrl] [nvarchar](500) NULL,
 CONSTRAINT [PK_CoachStudentMoney_Id] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IXC_CoachStudentMoney_StudentUserId]    Script Date: 2017/4/26 17:53:29 ******/
CREATE CLUSTERED INDEX [IXC_CoachStudentMoney_StudentUserId] ON [dbo].[CoachStudentMoney]
(
	[StudentUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_CoachStudentMoney_CoachId]    Script Date: 2017/4/26 17:53:29 ******/
CREATE NONCLUSTERED INDEX [IX_CoachStudentMoney_CoachId] ON [dbo].[CoachStudentMoney]
(
	[CoachId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
CREATE UNIQUE CLUSTERED INDEX [IXC_CoachStudentMoneyNotPay_Id] ON [dbo].[CoachStudentMoneyNotPay]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[CoachStudentMoneyNotPay] ADD  CONSTRAINT [DF_CoachStudentMoneyNotPay_IsPay]  DEFAULT ((0)) FOR [IsPay]
ALTER TABLE [dbo].[CoachStudentMoneyNotPay] ADD  CONSTRAINT [DF_CoachStudentMoneyNotPay_Money]  DEFAULT ((0)) FOR [ThenMoney]

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
CREATE CLUSTERED INDEX [IXC_CoachStudentRemark_StudentId] ON [dbo].[CoachStudentRemark]
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [CoachStudentRemark_CourseId]    Script Date: 2017/4/25 13:56:54 ******/
CREATE NONCLUSTERED INDEX [IX_CoachStudentRemark_CourseId] ON [dbo].[CoachStudentRemark]
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
	CREATE CLUSTERED INDEX [IXC_CoachTeachingPointCoaches_VenueId] ON [dbo].[CoachTeachingPointCoaches]
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
	CREATE CLUSTERED INDEX [IXC_CoachUserFavorite_UserId] ON [dbo].[CoachUserFavorite]
	(
		[UserId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	SET ANSI_PADDING ON

	/****** Object:  Index [CoachUserFavorite_Favorite]    Script Date: 2017/4/25 13:59:56 ******/
	CREATE NONCLUSTERED INDEX [IX_CoachUserFavorite_Favorite] ON [dbo].[CoachUserFavorite]
	(
		[FavoriteId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END 

----------------------���޸�

-- �ֵ��� Id , CreateDate �ֶ�
IF COL_LENGTH('SysDic','Id') IS NULL
 BEGIN
	ALTER TABLE dbo.SysDic ADD Id NVARCHAR(50) 
 END
 IF COL_LENGTH('SysDic','NameIndex') IS NULL
 BEGIN
	ALTER TABLE dbo.SysDic ADD  NameIndex INT 
 END
  IF COL_LENGTH('SysDic','CreateDate') IS NULL
 BEGIN
	ALTER TABLE dbo.SysDic ADD  CreateDate DATETIME
 END
--���ӿγ̹���Ա�ֶ�
  IF COL_LENGTH('Venue','CourseManagerId') IS NULL
 BEGIN
	ALTER TABLE dbo.Venue ADD CourseManagerId NVARCHAR(50)  
 END
  IF COL_LENGTH('Venue','IsEnableTeachingPoint') IS NULL
 BEGIN
	ALTER TABLE dbo.Venue ADD  IsEnableTeachingPoint BIT
 END

 --�����Ч�� 90��
   IF COL_LENGTH('Config','BigCourseValidDays') IS NULL
 BEGIN
	ALTER TABLE dbo.Config ADD BigCourseValidDays INT DEFAULT 90 WITH VALUES   
 END
 --���ӽ�ѧ�����ֶ�
   IF COL_LENGTH('UserLimit','IsTeachManage') IS NULL
 BEGIN
	ALTER TABLE dbo.UserLimit ADD IsTeachManage BIT DEFAULT 0 WITH VALUES
 END

 --MsgReg �� RegId �ֶγ��� �ĳ��� 500
ALTER TABLE MsgReg
ALTER COLUMN RegId NVARCHAR(500)


-----Ԥ��
IF	(NOT EXISTS(SELECT * FROM CoachOrganization WHERE Id='ydl'))
BEGIN

INSERT INTO [dbo].[CoachOrganization]
           ([Id]
           ,[HeadUrl]
           ,[Name]
           ,[Address]
           ,[CommissionPercentage]
           ,[ManagerId]
           ,[CreateDate])
     VALUES
           ('ydl','','�ɶ��ö�������Ƽ����޹�˾','�츮���',100,'001001',GETDATE())
END

GO

---����Ǩ��


IF NOT	EXISTS(SELECT * FROM dbo.Coach WHERE Id='2ff52433316b486285d2a72600bc8cd7')
BEGIN
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)
VALUES ( N'2ff52433316b486285d2a72600bc8cd7', N'010002', '2010-01-01 00:00:00.000', 3, N'20170303/e6ae92d2-94cb-4001-b13f-576fcdc16116.png', N'20170303/d26a1693-357b-49ed-a5f3-ba1f2355dea6.jpg', N'20170303/bcdf9363-3ce0-42bd-b8d7-b529b6c3d366.jpg', CAST(0x0000A72B0107B952 AS DateTime), N'Ů������һ���˶�Ա���μӹ���������Ӽ�ѵ����Ч��ɽ��³��ƹ������ֲ���2007����2010����̨��ִ�̣�����7����Ա����̨��μӹ��ʱ�����2012�������ִ��2013���ڳ����Ӿ��ֲ�ִ�̣����Ŷ���������顣 
�񽱾���
2000���ɽ��ʡ�˶��ᵥ��ھ���
2003���ȫ�����ޱ��ھ��� 
2004���ϣ����ǰ8����
2005���ȫ����B�����ھ��� 
2015��2017����������ϽѲμ�ȫ���Ĵ����׾Ʊ�����', NULL, N'250bee59415d45a1941ca6f1010f3878',
100,'ydl',1,GETDATE())
END
GO


IF NOT	EXISTS(SELECT * FROM dbo.Coach WHERE Id='3320be93-6039-41d9-b6cc-a5d6015cb8ae')
BEGIN
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)

VALUES ( N'3320be93-6039-41d9-b6cc-a5d6015cb8ae', N'010002', '2014-01-01 00:00:00.000', 3, N'20170331/37780d8b-58d7-4747-a07a-67d11b1db8e6.jpg', N'20170331/2ba5ad24-e4bd-47ef-9a75-33ef854bbdfe.jpg', N'20170331/3d18c769-24b1-4b01-8291-f3426de6811c.jpg', CAST(0x0000A74700F28783 AS DateTime), N'���Ҷ����˶�Ա����С��ʼѧϰƹ���򣬾����μӸ������͵�ƹ�������£����ŷḻ��ʵս���飬���ڴ���������ƹ�����ѧ��ѵ�������ܸ���ѧԱ�Ĳ�ͬ�ص��ƶ�����Ľ�ѧ��ѵ�ƻ������ᡢ�л����Ľ�ѧ��ʽ���ܺ����ǵ�ϲ����

�񽱾�����

������ƹ�����������ھ�
2015.7�»�����������ó�Ǳ���ƹ���򵥴������
2016.4�»�ɶ�����ѧ��ƹЭ����ƹ���������һ��
2016.4�»�ɶ����ߡ���֮�����ֵ��������ھ�
2016��4�»��ʮ����ɶ���������ƹ������������ھ�
2016.7�»�ɶ���˹����ҵ��ƹ��������վ�Ǿ�
2016.8�»񡰻����츮 �˶���������ط���ڶ���ȫ��ƹ���������������鵥��ھ�
2016.11�»��һ�조Ե�����ˡ�����ѧ����Уƹ�����������ڶ���
2016.12�»��˫ϲ�����ͼ��콡��ƹ�����������ھ�', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())
END
GO

IF NOT	EXISTS(SELECT * FROM dbo.Coach WHERE Id='48c878f489a34bd5b86ca6ff012c98d1')
BEGIN
INSERT [dbo].[Coach] ([Id],  [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)
VALUES ( N'48c878f489a34bd5b86ca6ff012c98d1', N'010002', '2015-01-01 00:00:00.000',3, N'~/Annexs/Temp/20170119/0e4dbd67-1736-4827-957a-201e814d60e7.jpg', N'20170119/7d4dc4aa-e835-4c32-a770-32577093cdb9.jpg', N'20170119/2c1da44e-3767-42bd-881e-57f98ca474d6.jpg', CAST(0x0000A700010026C3 AS DateTime), N'�ɶ�����ѧԺƹ����רҵ��ƹ����ʵս������졢����ḻ����ѧˮƽ��', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())
END
GO

IF NOT	EXISTS(SELECT * FROM dbo.Coach WHERE Id='7180eef59d0c4ca7a73da72600b5c0c0')
BEGIN
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)
VALUES ( N'7180eef59d0c4ca7a73da72600b5c0c0', N'010002', '2012-01-01 00:00:00.000', 3, N'20170303/df1458c9-14cb-4fdb-ad58-bfa207f55468.jpg', N'20170303/0ef55e91-0f78-468e-9fe2-5fc5e91b909d.jpg', N'20170303/9cd910eb-5c78-4142-aaef-ec6de1b8a325.jpg', CAST(0x0000A72B010694BD AS DateTime), N'�У����Ҷ����˶�Ա��ԭ����ʡרҵ�Ӷ�Ա��������ʡ�μ�ȫ����D������2012���ڳ���87�о��ֲ�ִ�̣�2013��2016��������ִ�̣��������Ա�μ�ʡ��һ������ȡ������ɼ������ŷḻ��ִ�̾��顣
�񽱾�����
2007���ü���ʡ�������ٶ�ƹЭ����������ھ�����ڶ�����
2010��μӼ���ʡ������ƹ������������ӵ����������
���ڲμ�˹�ٿ���ȫ�����ֲ�Ѳ��������Ǿ���', NULL, N'250bee59415d45a1941ca6f1010f3878',
100,'ydl',1,GETDATE())
END
GO

IF NOT	EXISTS(SELECT * FROM dbo.Coach WHERE Id='a6d465c6-6401-4350-afaf-a6d200958764')
BEGIN
INSERT [dbo].[Coach] ([Id],  [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)

VALUES ( N'a6d465c6-6401-4350-afaf-a6d200958764', N'010002',  '2002-01-01 00:00:00.000', 3, N'20170421/c0c824a4-bab7-477c-af52-f9e757382f64.jpg', N'20170421/1d3335ce-7e68-4bba-9629-49cc1e76e3b9.png', N'20170421/d1a34013-c1dc-46b1-bd71-b4d9a0147e5a.png', CAST(0x0000A75C00F1FE50 AS DateTime), N'�У�����רҵ�����˶�Ա, ����ҵ�ཡ���˶�Ա, ���Ĵ�ҵ��ƹ��������š����񵶡��ĳƺš�2000�������ڳɶ�����������ƹ�ҽ�ѧ��ѵ���������ŷḻ��ִ�̾��顣���ڸ���ѧԱʵ��������ƶ�����Ľ�ѧ�ƻ���������רҵ�����Ŷ���ʵ��ѵ�ƻ�����ÿһλѧԱ����ƹ������˶����ܺ���ϰ������

�񽱾���
2001-2004������������Ĵ�ʡ��Уƹ�����������ӵ���ھ�
2005�����ɶ�����ƹ����Կ�������ھ�
2006�����Ĵ�ʡ��ʮ���˶���ƹ�����������塢����ھ�
2007����ȫ����SDK����������������ھ��������Ǿ�
2008�����񣬶�βμ��Ĵ�ʡ����ҵ���£���ȡ�����ӵ���ھ�
2016�����Ĵ�ʡSPPAƹ�������������������弰����ھ����ܾ������򼾾�', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())
END
GO

IF NOT	EXISTS(SELECT * FROM dbo.Coach WHERE Id='b144d99abc294ff98288a72f008bc4c7')
BEGIN
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)

VALUES ( N'b144d99abc294ff98288a72f008bc4c7', N'010002', '2010-01-01 00:00:00.000', 3, N'20170309/5ff83ed0-ea9d-49ef-ad90-54bf866f0b1e.png', N'20170309/7a5cd0f4-baad-421c-b8b9-13951ae3b21e.jpg', N'20170309/a1c8a4c0-e3f5-4bc5-a61d-f179af5ef7d0.jpg', CAST(0x0000A73100A23AAF AS DateTime), N'����רҵ�����˶�Ա���ڽ���רҵ��Ů�ӽ������Ĵ�ʡҵ��ѵ������Ա��2010���������ƹ�����ѧ�������ó��������ѧ�������Ĵ���ѧͯ����ֲ����ſ��˶��ǵ�ƹ������ֲ���ְ�����������ʩ�̣�ͨ�����Ĺ۲�͹�ͨ��Ϊѧ���ҵ����ʺϵĽ�ѧ��ʽ��

�񽱾�����

2002��8���Ĵ�ʡ�ھŽ����˻�ƹ������������������
2004��8���Ĵ�ʡƹ�������������ڰ���
2006��8���Ĵ�ʡ��ʮ�����˻�ƹ��������������������˫�������
2007��3���Ĵ�ʡ��ѧ��ƹ�����������˫���һ��', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())
END
GO

IF NOT	EXISTS(SELECT * FROM dbo.Coach WHERE Id='b1ca6678-f060-47a6-bb32-a5d300e9240e')
BEGIN
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)

VALUES (N'b1ca6678-f060-47a6-bb32-a5d300e9240e', N'010002', '2007-01-01 00:00:00.000', 3, N'20170223/85e29aaa-d1b9-4b85-a89a-246b1e3e3f18.jpg', N'20170223/5a83fb38-dd6a-4609-99c8-cf222f1eb350.jpg', N'20170223/d38f12f6-bb2c-4989-bead-569cbec77c4c.jpg', CAST(0x0000A72300EEB9FE AS DateTime), N'�У�����һ���˶�Ա��ԭ�Ĵ�ʡרҵ�Ӷ�Ա�����¶���ƹ����ѵ��������2008����̨����¼��������ͽ���������2010������Ա����������Ҷ�ѡ�����ڶ������ٻ������ѽ����ƺţ����ŷḻ��ƹ�ҽ�ѧ���顣�ó��ٶ���������ѵ���ܿ������ѧԱƹ��������

�񽱾���
1999��ȫ��ƹ�����������������е�ǰ8��
2001��ȫ��ƹ��������������������
2002��ȫ��ƹ�����B�����ܾ����������
2003��ȫ�������˶�������ŵ�����
2004��ӡ��������ȫ�����ֲ��������һ��
2006���������ݹ��������е��ھ�
2011���Ĵ�ʡְ��ƹ����������е��ھ�', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())
END
GO

IF NOT	EXISTS(SELECT * FROM dbo.Coach WHERE Id='f053d11cc1fc4bcf8c40a7200104faca')
BEGIN
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)

VALUES (N'f053d11cc1fc4bcf8c40a7200104faca', N'010002',  '2015-01-01 00:00:00.000',3, N'~/Annexs/Temp/20170227/004e975a-2c18-4b08-aa0b-c4febcf97dc8.jpg', N'20170227/f532b8f2-86fc-402f-bb86-f92bca8c5b4e.jpg', N'20170227/175e6d03-549f-4931-be4b-dff9d5bc2ec7.jpg', CAST(0x0000A7270143E7AB AS DateTime), N'�̽�����С��ʼѧϰƹ���򣬾��зḻ��ʵս�ͽ�ѧ���顣������ϳ��������ظ���������ڶ������Ĵ�ʡ�ϳ������ӵ�����������ϳ����������������ڶ�������ִ���ڼ䣬������ɶ�������ĳ���ֲ����ó�һ��һ��С���ѧ����Ҫ��ѧ����5-15�������ꡣ', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())

END
GO

IF NOT	EXISTS(SELECT * FROM dbo.Coach WHERE Id='9e516c99e92c43959f1ca75f00d88258')
BEGIN
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)

VALUES (N'9e516c99e92c43959f1ca75f00d88258', N'010002',  '2010-01-01 00:00:00.000',3, N'20170424/827e8420-d6c0-4819-a344-2dd4ac5019c3.jpg', N'20170425/c2b94c18-7ee5-457c-9143-9bbf1f271386.jpg', N'20170425/430f117b-e0ce-4eae-883e-c33caf1c7557.jpg', '2017-04-25 11:22:01.273', N'Ů�����Ҷ����˶�Ա��2008��ʼ���ڸ���ʡȪ���������깬ִ�̣�רҵ����ƹ�����ѧ���������ŷḻ��ƹ�����ѧ���顣

�񽱾�����
1997���ɶ��к����걭Ů���ھ�
1998���������ʡ�˶���Ů�ŵ�����
1999���ҵ����Уƹ�����ѧŮ���ھ�
1999������Ͻ����99�����ٶ������籭ƹ��������һ��
2000����׽�ҵ��ȼ���Ů��������
2000���ɶ��еھŽ��˶���Ů���ڶ���Ů�ŵڶ���Ů˫���ġ���˫����
2002���ɶ�����ѧ������Ů�Źھ�', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())

END
GO


IF NOT	EXISTS(SELECT * FROM dbo.[CoachStudentMoney] WHERE Id='6c506c28129046b3a906a75d012b2ede')
BEGIN
INSERT [dbo].[CoachStudentMoney] ([Id], [StudentUserId], [CoachId], [Amount], 
[IsPay], [ThenMoney], [CourseTypeId], [CourseTypeName], [Deadline], [CreateDate], [HeadUrl],ThenTotalAmount,CityId) 
VALUES (N'6c506c28129046b3a906a75d012b2ede', N'067268413c3941dfb8dea75d012afacc', N'a6d465c6-6401-4350-afaf-a6d200958764', 10,1, CAST(1500.00 AS Decimal(18, 2)), N'027003', N'˽�̿�', 
'9999-12-31 23:59:59.997', CAST(0x0000A75D012B2EDD AS DateTime), NULL,10,'75')
END
GO

IF NOT	EXISTS(SELECT * FROM dbo.[CoachStudentMoney] WHERE Id='1a0881e8f7df484f8ae9a72e0111cee1')
BEGIN
INSERT [dbo].[CoachStudentMoney] ([Id], [StudentUserId], [CoachId], [Amount], [IsPay], [ThenMoney], [CourseTypeId], [CourseTypeName], [Deadline], [CreateDate]
, [HeadUrl],ThenTotalAmount,CityId)  
VALUES (N'1a0881e8f7df484f8ae9a72e0111cee1', N'49d59b709b3d430b9118a72e011076cc', N'2ff52433316b486285d2a72600bc8cd7', 10, 1, CAST(1500.00 AS Decimal(18, 2)), N'027003', N'˽�̿�', CAST(0x000639E80111CEDF AS DateTime), '9999-12-31 23:59:59.997', NULL
,10,'75')
END
GO

IF NOT	EXISTS(SELECT * FROM dbo.[CoachStudentMoney] WHERE Id='66dfd08d6ddc42f986b9a72e01115851')
BEGIN
INSERT [dbo].[CoachStudentMoney] ([Id], [StudentUserId], [CoachId], [Amount], [IsPay], [ThenMoney], [CourseTypeId], [CourseTypeName], [Deadline], [CreateDate], [HeadUrl],ThenTotalAmount,CityId)  
VALUES (N'66dfd08d6ddc42f986b9a72e01115851', N'65057fb0-055c-4adc-ba62-a5b400b0ce2b', N'2ff52433316b486285d2a72600bc8cd7', 10, 1, CAST(1500.00 AS Decimal(18, 2)), N'027003', N'˽�̿�', CAST(0x000639E801115850 AS DateTime), '9999-12-31 23:59:59.997', NULL,
10,'75')
END
GO

IF NOT	EXISTS(SELECT * FROM dbo.[CoachStudentMoney] WHERE Id='4abf333352a24f30899da74501510724')
BEGIN
INSERT [dbo].[CoachStudentMoney] ([Id], [StudentUserId], [CoachId], [Amount], [IsPay], [ThenMoney], [CourseTypeId], [CourseTypeName], [Deadline], [CreateDate], [HeadUrl],ThenTotalAmount,CityId)  
VALUES (N'4abf333352a24f30899da74501510724', N'c0758234e4884d22be22a745014fb899', N'b1ca6678-f060-47a6-bb32-a5d300e9240e', 10, 1, CAST(1000.00 AS Decimal(18, 2)), N'027001', N'���', '2017-12-31 23:59:59.997', '2017-12-31 23:59:59.997', NULL,
10,'75')
END
GO

 -------�洢���̺ͺ���
 
/****** Object:  UserDefinedFunction [dbo].[fn_Trim]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_Trim]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Split]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_Split]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_SimpleContent]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_SimpleContent]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_SamePart]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_SamePart]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_NewId]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_NewId]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Link]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_Link]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetVenueUserUseCount]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetVenueUserUseCount]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetVenueNameString]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetVenueNameString]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserPetName]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetUserPetName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserNameString]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetUserNameString]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserName]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetUserName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkPetName]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetUserLinkPetName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkName]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetUserLinkName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkCardName]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetUserLinkCardName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetTeachingPointCoachNames]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetTeachingPointCoachNames]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetTeachingPointCoachIds]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetTeachingPointCoachIds]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetSignCount]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetSignCount]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetReplyCount]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetReplyCount]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetLinkVenueName]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetLinkVenueName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetGameTeamScore]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetGameTeamScore]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetFinalRank]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetFinalRank]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetDistance]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetDistance]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetDate]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetDate]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoacherScore]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetCoacherScore]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoachAVGScore]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetCoachAVGScore]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoachAge]    Script Date: 2017/4/26 10:08:22 ******/
DROP FUNCTION [dbo].[fn_GetCoachAge]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateUserSign]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_ValidateUserSign]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateUser]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_ValidateUser]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateGameTeam]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_ValidateGameTeam]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateClubActivity]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_ValidateClubActivity]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateValCode]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_UpdateValCode]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTransferCreatorId]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_UpdateTransferCreatorId]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePassword]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_UpdatePassword]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateGameSportScore]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_UpdateGameSportScore]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateGameClubScore]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_UpdateGameClubScore]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetVenueVip]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SetVenueVip]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetVenueReleased]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SetVenueReleased]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetStudentReleased]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SetStudentReleased]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetGameTopState]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SetGameTopState]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetGameState]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SetGameState]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetGameLoopState]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SetGameLoopState]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetCompanyIsStop]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SetCompanyIsStop]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetActivityState]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SetActivityState]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipUsePay]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveVipUsePay]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipUse]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveVipUse]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipRefund]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveVipRefund]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipInnerDiscount]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveVipInnerDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipDiscount]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveVipDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipCostScale]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveVipCostScale]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipBuyPay]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveVipBuyPay]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVenueDiscount]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveVenueDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVenueBillPay]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveVenueBillPay]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveUserSport]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveUserSport]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveQuickUser]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveQuickUser]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveNoteSupport]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveNoteSupport]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveMsgReg]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveMsgReg]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveGameGroupLeader]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveGameGroupLeader]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveCourseAutoBookSettings]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveCourseAutoBookSettings]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveCoachCourseJoin]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveCoachCourseJoin]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveClubRequest]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveClubRequest]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveCity]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_SaveCity]
GO
/****** Object:  StoredProcedure [dbo].[sp_ResetGameLoop]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_ResetGameLoop]
GO
/****** Object:  StoredProcedure [dbo].[sp_RemoveVenueTimetables]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_RemoveVenueTimetables]
GO
/****** Object:  StoredProcedure [dbo].[sp_QueryRechargeReport]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_QueryRechargeReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_QueryBillReport]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_QueryBillReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBillList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipVenueBillList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBillDetailList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipVenueBillDetailList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBill]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipVenueBill]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipUseList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipUseList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipUse]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipUse]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipRefundList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipRefundList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipRefund]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipRefund]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipInnerDiscountList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipInnerDiscountList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipInnerDiscount]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipInnerDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipDiscountList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipDiscountList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipDiscount]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipDayBook]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipDayBook]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipCostScaleList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipCostScaleList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipCityDiscount]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipCityDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipBuyList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipBuyList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipBuy]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipBuy]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipAccountList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipAccountList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipAccount]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVipAccount]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueTimetablesList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVenueTimetablesList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueSignList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVenueSignList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListForGraph]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVenueListForGraph]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListForAudit]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVenueListForAudit]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListAllForCoacher]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVenueListAllForCoacher]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVenueList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueDiscountList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVenueDiscountList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenue]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetVenue]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserSportList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetUserSportList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserSignList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetUserSignList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserScoreHistoryList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetUserScoreHistoryList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetUserList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserLimitRequestList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetUserLimitRequestList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserLimitList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetUserLimitList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUser]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetUser]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTeachingPointList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetTeachingPointList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTeachingPointCoachList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetTeachingPointCoachList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSyllabusTeachingPointList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetSyllabusTeachingPointList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentTimesStatistics]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetStudentTimesStatistics]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentTimesBalance]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetStudentTimesBalance]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentsOfBookCourse]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetStudentsOfBookCourse]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMyCourse]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetStudentMyCourse]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMonthStatistics]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetStudentMonthStatistics]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMonthPayListByYear]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetStudentMonthPayListByYear]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetStudentList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentBookList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetStudentBookList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSerialNo1]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetSerialNo1]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSerialNo]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetSerialNo]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrganizationList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetOrganizationList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrderTrialCourseList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetOrderTrialCourseList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOnlineUser]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetOnlineUser]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNoteSupportList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetNoteSupportList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNoteReplyList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetNoteReplyList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNoteList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetNoteList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNote]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetNote]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNearbyTeachingPointList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetNearbyTeachingPointList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetMsgList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetMsgList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGeneralUserList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGeneralUserList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTopList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameTopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeamListForKnock]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameTeamListForKnock]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeamList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameTeamList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeam]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameTeam]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTableList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameTableList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameRankList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameRankList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameProgress]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameProgress]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameOrderLoopList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameOrderLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameOrderList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameOrderList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameMyLoopList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameMyLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopMapList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameLoopMapList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopDetailList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameLoopDetailList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameKnockLoopList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameKnockLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameJudgeLoopList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameJudgeLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameJudgeList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameJudgeList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupRankList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameGroupRankList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupMemberList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameGroupMemberList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupLoopList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameGroupLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGameGroupList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGame]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetGame]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDynamicVenueBill]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetDynamicVenueBill]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetContactCategoryList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetContactCategoryList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompanyList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCompanyList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompany]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCompany]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachTeachingCourseList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoachTeachingCourseList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachPriceList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoachPriceList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoachList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherMyStudentList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherMyStudentList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherListForSelect]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherListForSelect]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherListForGradeUpgrade]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherListForGradeUpgrade]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherCourseVenueList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherCourseVenueList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherCourseStudentList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherCourseStudentList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherApply]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherApply]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacher]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoacher]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachCommentList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoachCommentList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachAuditList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCoachAuditList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubUserList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetClubUserList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubRequestList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetClubRequestList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubMyList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetClubMyList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetClubList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubAddressList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetClubAddressList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClub]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetClub]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCityList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetCityList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetActivityUserList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetActivityUserList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetActivityList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetActivityList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetActivity]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_GetActivity]
GO
/****** Object:  StoredProcedure [dbo].[sp_FinishGameOrder]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_FinishGameOrder]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteOnlineUser]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_DeleteOnlineUser]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameTeamById]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_DeleteGameTeamById]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameTeam]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_DeleteGameTeam]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameGroup]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_DeleteGameGroup]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameAllDetail]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_DeleteGameAllDetail]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateVipVenueBill]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_CreateVipVenueBill]
GO
/****** Object:  StoredProcedure [dbo].[sp_CoachAuditPass]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_CoachAuditPass]
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckGameSign]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_CheckGameSign]
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckGameGroupState]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_CheckGameGroupState]
GO
/****** Object:  StoredProcedure [dbo].[sp_CancelVipUse]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_CancelVipUse]
GO
/****** Object:  StoredProcedure [dbo].[sp_CancelVipRefund]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_CancelVipRefund]
GO
/****** Object:  StoredProcedure [dbo].[sp_CancelVenueBill]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_CancelVenueBill]
GO
/****** Object:  StoredProcedure [dbo].[sp_CancelCourseAutoBook]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_CancelCourseAutoBook]
GO
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateTestGameTeam]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_AutoCreateTestGameTeam]
GO
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateCourseBookByMonth]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_AutoCreateCourseBookByMonth]
GO
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateCourseBook]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_AutoCreateCourseBook]
GO
/****** Object:  StoredProcedure [dbo].[sp_AuditClubRequest]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[sp_AuditClubRequest]
GO
/****** Object:  StoredProcedure [dbo].[GetStudentJoinCourseList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[GetStudentJoinCourseList]
GO
/****** Object:  StoredProcedure [dbo].[GetStudentCourseRemarkList]    Script Date: 2017/4/26 10:08:22 ******/
DROP PROCEDURE [dbo].[GetStudentCourseRemarkList]
GO
/****** Object:  StoredProcedure [dbo].[GetStudentCourseRemarkList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[GetStudentCourseRemarkList]
	@StudentId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        --IF ISNULL(@Name, '') != ''
        --    SET @filter = @filter + ' AND b.CardName = @Name'

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
					 SELECT 
						@rowCount=COUNT(*)
					 FROM dbo.CoachCourseJoin a
					 LEFT JOIN dbo.CoachCourse e ON a.CourseId=e.Id
					 WHERE a.StudentId = @StudentId AND e.State=''Finished''
					' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@StudentId NVARCHAR(50),@rowCount INT OUTPUT',
                    @StudentId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
					 
				 SELECT 
					a.Id,
					c.Id AS Type,
					c.Name AS TypeName,
					b.CardName AS CoachName,
					e.BeginTime,
					e.EndTime,
					d.Address AS VenueAddress,
					f.Remark AS StudentRemark,
					a.StudentId,
					e.State
				 FROM dbo.CoachCourseJoin a
				 INNER JOIN dbo.UserAccount b ON a.CoachId=b.Id
				 LEFT JOIN dbo.CoachCourse e ON a.CourseId=e.Id
				 LEFT JOIN dbo.BaseData c ON e.Type=c.Id 
				 LEFT JOIN dbo.Venue d ON e.VenueId=d.Id
				 LEFT JOIN dbo.CoachStudentRemark f ON a.StudentId=f.StudentId AND a.CourseId=f.CourseId
				 WHERE a.StudentId = @StudentId AND e.State=''Finished''
				'+@filter+'
				ORDER BY a.CreateDate DESC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@StudentId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @StudentId ,@pageIndex, @pageSize

		
		
    END

GO
/****** Object:  StoredProcedure [dbo].[GetStudentJoinCourseList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[GetStudentJoinCourseList] 
	@StudentId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        --IF ISNULL(@Name, '') != ''
        --    SET @filter = @filter + ' AND b.CardName = @Name'

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
					 SELECT 
						@rowCount=COUNT(*)
					 FROM dbo.CoachCourseJoin a
					 WHERE a.StudentId = @StudentId
					' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@StudentId NVARCHAR(50),@rowCount INT OUTPUT',
                    @StudentId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
					 
				SELECT 
					e.Id,
					c.Id AS Type,
					c.Name AS TypeName,
					b.CardName AS CoachName,
					e.BeginTime,
					e.EndTime,
					d.Address AS VenueAddress,
					f.Remark AS StudentRemark,
					e.Id AS CourseId,
					e.State
				 FROM dbo.CoachCourseJoin a
				 INNER JOIN dbo.UserAccount b ON a.CoachId=b.Id
				 LEFT JOIN dbo.CoachCourse e ON a.CourseId=e.Id
				 LEFT JOIN dbo.BaseData c ON e.Type=c.Id 
				 LEFT JOIN dbo.Venue d ON e.VenueId=d.Id
				 LEFT JOIN dbo.CoachStudentRemark f ON a.StudentId=f.StudentId AND a.CourseId=f.CourseId
				 WHERE a.StudentId = @StudentId
				'+@filter+'
				ORDER BY e.State DESC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@StudentId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @StudentId ,@pageIndex, @pageSize

		
		
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_AuditClubRequest]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AuditClubRequest]
    @requestId NVARCHAR(50) ,
    @level INT ,
    @state NVARCHAR(50) ,
    @auditorId NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        DECLARE @userId NVARCHAR(50)
        DECLARE @clubId NVARCHAR(50)

		--����δ��˵���Ⱥ����
        SELECT  @userId = CreatorId ,
                @clubId = ClubId
        FROM    dbo.ClubRequest
        WHERE   Id = @requestId
                AND State = '003001'

        IF ISNULL(@userId, '') != ''
            BEGIN

				--��������״̬,�����
                UPDATE  dbo.ClubRequest
                SET     State = @state ,
                        AuditorId = @auditorId
                WHERE   Id = @requestId
                        AND State = '003001'

				--������ͨ�������Լ���ȺԱ
                IF @state = '003002'
                    AND NOT EXISTS ( SELECT *
                                     FROM   dbo.ClubUser
                                     WHERE  UserId = @userId
                                            AND ClubId = @clubId )
                    INSERT  dbo.ClubUser
                            ( Id ,
                              ClubId ,
                              UserId ,
                              IsCreator ,
                              IsAdmin ,
                              PetName ,
                              LevelValue ,
                              Score ,
                              CreateDate
				            )
                    VALUES  ( dbo.fn_NewId(NEWID()) , -- Id - nvarchar(50)
                              @clubId , -- ClubId - nvarchar(50)
                              @userId , -- UserId - nvarchar(50)
                              0 , -- IsCreator - bit
                              0 , -- IsAdmin - bit
                              N'' , -- PetName - nvarchar(50)
                              @level , -- LevelValue - int
                              0 , -- Score - int
                              GETDATE()  -- CreateDate - datetime
				            )
            END
        ELSE
            SET @message = '��������Ա�Ѵ���'
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateCourseBook]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AutoCreateCourseBook]
	@userId	NVARCHAR(50),
	@venueId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

		--ָ��ѧԱ��ָ�������Ƿ��������Զ�ԤԼ
		IF EXISTS(SELECT 1 FROM CoachAutoBookSettings a 
					INNER JOIN VenueStudents c ON a.UserId=c.UserId AND a.VenueId=c.VenueId
					WHERE a.UserId=@userId AND a.VenueId=@venueId AND c.IsCourseAutoBook=1)
		BEGIN

			DECLARE @payId NVARCHAR(50)

			DECLARE cursor_monthPay CURSOR FOR
			SELECT a.Id FROM CoachStudentPay a INNER JOIN CoachStudentBalance b ON b.Id=a.BalanceId
						WHERE b.UserId=@userId AND b.VenueId=@venueId AND b.[Month]>0
						AND a.Ispay=1
						AND (CONVERT(VARCHAR,b.[Year])+ '-'+CONVERT(VARCHAR,b.[Month]))>=CONVERT(VARCHAR(7),GETDATE())
						AND b.Balance>0

			OPEN cursor_monthPay
			FETCH NEXT FROM cursor_monthPay 
			INTO @payId

			WHILE @@FETCH_STATUS=0
			BEGIN
				
				EXEC sp_AutoCreateCourseBookByMonth @payId

				FETCH NEXT FROM cursor_monthPay INTO @payId
			END

			CLOSE cursor_monthPay
			DEALLOCATE cursor_monthPay
		END

    END


GO
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateCourseBookByMonth]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AutoCreateCourseBookByMonth]
	@payId	NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

		DECLARE @now DATETIME
		SET @now = GETDATE()

		--����ÿ�ܵ�һ������һ(Ĭ��������)
		SET DATEFIRST 1

		--�����Ҫ����
		DECLARE @userId NVARCHAR(50),@venueId NVARCHAR(50),@balanceId NVARCHAR(50),@balance INT,@month INT,@year INT
		SELECT @userId=b.UserId,@venueId=b.VenueId,@balanceId=a.BalanceId,@balance=b.Balance,@year=b.[Year],@month=b.[Month] 
		FROM CoachStudentPay a INNER JOIN CoachStudentBalance b ON b.Id=a.BalanceId WHERE a.Id=@payId


		DECLARE @tempTab TABLE(BeginTime DATETIME,EndTime DATETIME,TimeTableId NVARCHAR(50))
		DECLARE @i INT
		DECLARE @monthFirstDay DATETIME,@beginTime DATETIME,@endTime DATETIME,@timeTableId NVARCHAR(50)

		--���µ�һ��
		SET @monthFirstDay = CONVERT(VARCHAR,@year)+ '-'+CONVERT(VARCHAR,@month)+'-01'

		--������ǰ7������ݲ�����ʱ��
		INSERT INTO @tempTab( BeginTime, EndTime, TimeTableId )
		SELECT DATEADD(MINUTE,a.BeginMinute, DATEADD(HOUR,a.BeginHour,DATEADD(dd,a.daySpan,dbo.fn_GetDate(@monthFirstDay)))),
				DATEADD(MINUTE,a.EndMinute, DATEADD(HOUR,a.EndHour,DATEADD(dd,a.daySpan,dbo.fn_GetDate(@monthFirstDay)))),
				a.TimeTableId
		FROM
		(
			SELECT daySpan=CASE WHEN a.[WeekDay]>=DATEPART(dw,@monthFirstDay) THEN a.[WeekDay]-DATEPART(dw,@monthFirstDay) ELSE a.[WeekDay]-DATEPART(dw,@monthFirstDay)+7 END,
			b.BeginHour,b.BeginMinute,b.EndHour,b.EndMinute,a.TimeTableId
			FROM CoachAutoBookSettings a 
			INNER JOIN CoachVenueTimetables b ON a.TimeTableId=b.Id 
			INNER JOIN VenueStudents c ON a.UserId=c.UserId AND a.VenueId=c.VenueId 
			WHERE a.UserId=@userId AND a.VenueId=@venueId AND c.IsCourseAutoBook=1
		) a
		ORDER BY a.daySpan,a.BeginHour

		--ѭ��5�Σ��ų�������������
		SET @i=0
		WHILE @i<5 AND @balance>0
		BEGIN
			DECLARE cursor_timedata CURSOR FOR
			SELECT DATEADD(dd,@i*7,BeginTime),DATEADD(dd,@i*7,EndTime),TimeTableId FROM @tempTab WHERE DATEADD(dd,@i*7,BeginTime)>@now AND DATEPART(MONTH,DATEADD(dd,@i*7,BeginTime))=@month

			OPEN cursor_timedata
			FETCH NEXT FROM cursor_timedata 
			INTO @beginTime,@endTime,@timeTableId

			WHILE @@FETCH_STATUS=0 AND @balance>0
			BEGIN
				--����ʱ����Ƿ��Ѿ�ԤԼ��
				IF NOT EXISTS(SELECT 1 FROM CoachCourseBook WHERE UserId=@userId AND TimeTableId=@timeTableId AND dbo.fn_GetDate(BeginTime)=dbo.fn_GetDate(@beginTime))
				BEGIN
					INSERT INTO CoachCourseBook(Id,StudentPayId,TimeTableId,UserId,BeginTime,EndTime,IsMonth,CreateDate)
					VALUES(NEWID(),@payId,@timeTableId,@userId,@beginTime,@endTime,1,@now)

					SET @balance=@balance-1
				END


				FETCH NEXT FROM cursor_timedata INTO @beginTime,@endTime,@timeTableId
			END

			CLOSE cursor_timedata
			DEALLOCATE cursor_timedata


			SET @i=@i+1
		END


		UPDATE CoachStudentBalance SET Balance=@balance WHERE Id=@balanceId
		UPDATE CoachStudentPay SET UsedTimes=Times-@balance WHERE Id=@payId

    END


GO
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateTestGameTeam]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AutoCreateTestGameTeam] 
	-- Add the parameters for the stored procedure here
    @gameId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @isTeam BIT
        DECLARE @nameOption NVARCHAR(50)
        SELECT  @isTeam = IsTeam ,
                @nameOption = NameOption
        FROM    dbo.Game
        WHERE   Id = @gameId

		--ɾ��ԭ��������
        DELETE  FROM GameTeam
        WHERE   GameId = @gameId

        DECLARE user_cur CURSOR
        FOR
            SELECT  Id ,
                    CASE WHEN @nameOption = '020001' THEN PetName
                         ELSE CardName
                    END
            FROM    dbo.UserAccount
            WHERE   Code LIKE 'admin%'
                    AND LEN(Code) <= 7
        OPEN user_cur

        DECLARE @id NVARCHAR(50)
        DECLARE @name NVARCHAR(50)

        FETCH NEXT FROM user_cur INTO @id, @name
        WHILE @@FETCH_STATUS = 0
            BEGIN
                IF @isTeam = 0
                    BEGIN
                        INSERT  INTO dbo.GameTeam
                                ( Id ,
                                  HeadUrl ,
                                  GameId ,
                                  IsTeam ,
                                  TeamName ,
                                  TeamUserId ,
                                  TeamUserName ,
                                  Cost ,
                                  IsPayCost ,
                                  Remark ,
                                  State ,
                                  AuditorId ,
                                  AuditRemark ,
                                  AuditDate ,
                                  IsSeed ,
                                  SeedNo ,
                                  MobilePhone ,
                                  IsJoined ,
                                  CreatorId ,
                                  CreateDate
		                        )
                        VALUES  ( dbo.fn_NewId(NEWID()) , -- Id - nvarchar(50)
                                  N'' , -- HeadUrl - nvarchar(200)
                                  @gameId , -- GameId - nvarchar(50)
                                  @isTeam , -- IsTeam - bit
                                  @name , -- TeamName - nvarchar(500)
                                  @id , -- TeamUserId - nvarchar(500)
                                  @name , -- TeamUserName - nvarchar(500)
                                  0 , -- Cost - int
                                  0 , -- IsPayCost - bit
                                  N'' , -- Remark - nvarchar(500)
                                  N'012002' , -- State - nvarchar(50)
                                  N'' , -- AuditorId - nvarchar(50)
                                  N'' , -- AuditRemark - nvarchar(500)
                                  N'' , -- AuditDate - nvarchar(50)
                                  0 , -- IsSeed - bit
                                  0 , -- SeedNo - int
                                  N'' , -- MobilePhone - nvarchar(50)
                                  0 , -- IsJoined - bit
                                  @id , -- CreatorId - nvarchar(50)
                                  GETDATE()  -- CreateDate - datetime
		                        )
                        
                    END 
					
                ELSE
                    IF @id <= '001016'
                        BEGIN
                            DECLARE @i INT 
                            SET @i = CAST(RIGHT(@id, 2) AS INT) * 2 + 15

                            DECLARE @id2 NVARCHAR(50)
                            DECLARE @id3 NVARCHAR(50)
                            DECLARE @name2 NVARCHAR(50)
                            DECLARE @name3 NVARCHAR(50)

                            SET @id2 = '0010' + RIGHT('00'
                                                      + CAST(@i AS NVARCHAR(2)),
                                                      2)
                            SET @id3 = '0010' + RIGHT('00'
                                                      + CAST(@i + 1 AS NVARCHAR(2)),
                                                      2)

                            SET @name2 = CASE WHEN @nameOption = '020001' THEN 'admin' ELSE '����Ա' END  + CAST(@i AS NVARCHAR(2))
                            SET @name3 = CASE WHEN @nameOption = '020001' THEN 'admin' ELSE '����Ա' END + CAST(@i + 1 AS NVARCHAR(2))


                            INSERT  INTO dbo.GameTeam
                                    ( Id ,
                                      HeadUrl ,
                                      GameId ,
                                      IsTeam ,
                                      TeamName ,
                                      TeamUserId ,
                                      TeamUserName ,
                                      Cost ,
                                      IsPayCost ,
                                      Remark ,
                                      State ,
                                      AuditorId ,
                                      AuditRemark ,
                                      AuditDate ,
                                      IsSeed ,
                                      SeedNo ,
                                      MobilePhone ,
                                      IsJoined ,
                                      CreatorId ,
                                      CreateDate
		                            )
                            VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                                      N'' , -- HeadUrl - nvarchar(200)
                                      @gameId , -- GameId - nvarchar(50)
                                      @isTeam , -- IsTeam - bit
                                      @name + '����' , -- TeamName - nvarchar(500)
                                      @id + ',' + @id2 + ',' + @id3 , -- TeamUserId - nvarchar(500)
                                      @name + ',' + @name2 + ',' + @name3 , -- TeamUserName - nvarchar(500)
                                      0 , -- Cost - int
                                      0 , -- IsPayCost - bit
                                      N'' , -- Remark - nvarchar(500)
                                      N'012002' , -- State - nvarchar(50)
                                      N'' , -- AuditorId - nvarchar(50)
                                      N'' , -- AuditRemark - nvarchar(500)
                                      N'' , -- AuditDate - nvarchar(50)
                                      0 , -- IsSeed - bit
                                      0 , -- SeedNo - int
                                      N'' , -- MobilePhone - nvarchar(50)
                                      0 , -- IsJoined - bit
                                      @id , -- CreatorId - nvarchar(50)
                                      GETDATE()  -- CreateDate - datetime
		                            )
                        END
                    ELSE
                        BREAK

                FETCH NEXT FROM user_cur INTO @id, @name
            END

        CLOSE user_cur
        DEALLOCATE user_cur
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_CancelCourseAutoBook]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CancelCourseAutoBook] 
    @userId			NVARCHAR(50),
	@venueId		NVARCHAR(50)
AS
    BEGIN
		Set XACT_ABORT ON
		BEGIN  TRAN

		UPDATE VenueStudents SET IsCourseAutoBook=0 WHERE UserId=@userId AND VenueId=@venueId

		DELETE FROM CoachAutoBookSettings WHERE UserId=@userId AND VenueId=@venueId

		COMMIT TRAN
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_CancelVenueBill]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CancelVenueBill]
    @id NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        IF ISNULL(@id, '') = ''
            BEGIN
                SET @message = '�����õ��ݺ���.'
                RETURN
            END

        DECLARE @state NVARCHAR(50)
        SELECT  @state = State
        FROM    dbo.VenueBill
        WHERE   Id = @id
        IF @state IS NULL
            BEGIN
                SET @message = '���ݲ����ڣ������ѱ�ɾ��.'
                RETURN
            END
        ELSE
            IF @state = '026001'
                DELETE  FROM dbo.VenueBill
                WHERE   Id = @id
            ELSE
                BEGIN
                    SET @message = '������ȷ�ϣ��޷�ȡ��.'
                    RETURN
                END
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_CancelVipRefund]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CancelVipRefund]
    @Id NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        DECLARE @state NVARCHAR(50)
        SELECT  @state = a.State
        FROM    dbo.VipRefund a
        WHERE   id = @Id

        IF @state = '025001'
            DELETE  FROM dbo.VipRefund
            WHERE   id = @Id
        ELSE
            SET @message = '�����ڴ����У��޷�ȡ������ˢ��״̬��'

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_CancelVipUse]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CancelVipUse]
    @id NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN  
        DECLARE @payState NVARCHAR(50) 

        SELECT  @payState = PayState
        FROM    dbo.VipUse
        WHERE   Id = @id

        IF ISNULL(@payState, '') = '024001'
            DELETE  FROM dbo.VipUse
            WHERE   Id = @id AND PayState='024001'
        ELSE
            SET @message = '������֧��������ȡ����';
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_CheckGameGroupState]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CheckGameGroupState]
    @gameId NVARCHAR(50) ,
    @knockOutAB NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN

        BEGIN TRY
            SET NOCOUNT ON;

		    --��֤С�����Ƿ����--
            SET @message = '';
            IF EXISTS ( SELECT  *
                        FROM    dbo.GameGroupMember
                        WHERE   GameId = @gameId
                                AND Rank = 0 )
                RAISERROR (N'������С��δ�����������޷���ǩ��',11,1)

			--��֤�Ƿ��Ѿ���ǩ--
            DECLARE @isKnockOutAB BIT
            SELECT  @isKnockOutAB = ISNULL(IsKnockOutAB, 0)
            FROM    dbo.Game
            WHERE   Id = @gameId

            IF EXISTS ( SELECT  *
                        FROM    dbo.GameLoop a
                                JOIN dbo.GameOrder b ON b.Id = a.OrderId
                        WHERE   a.GameId = @gameId
                                AND KnockoutOption = '014001'
                                AND ( @isKnockOutAB = 0
                                      OR @isKnockOutAB = 1 AND b.KnockOutAB = @knockOutAB
                                    )
                                AND ( ISNULL(Team1Id, '') != ''
                                      OR ISNULL(Team2Id, '') != ''
                                    ) )
                IF @isKnockOutAB = 0
                    RAISERROR (N'�Ѿ��������̭����ǩ�������ظ�������',11,1)
                ELSE
                    RAISERROR (N'�Ѿ�����˱�����̭����ǩ�������ظ�������',11,1)
        END TRY

        BEGIN CATCH
            SET @message = ERROR_MESSAGE() 
        END CATCH 
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_CheckGameSign]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CheckGameSign]
    @userId NVARCHAR(200) ,
    @teamId NVARCHAR(50) ,
    @password NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        IF ISNULL(@userId, '') != ''
            SELECT  COUNT(*)
            FROM    dbo.UserAccount
            WHERE   Id IN ( SELECT  *
                            FROM    dbo.fn_Split(@userId) )
                    AND Password = @password
        ELSE
            SELECT  COUNT(*)
            FROM    dbo.UserAccount
            WHERE   Id IN ( SELECT  TeamUserId
                            FROM    GameTeam
                            WHERE   Id = @teamId )
                    AND Password = @password
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_CoachAuditPass]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--�������ͨ��
CREATE PROCEDURE [dbo].[sp_CoachAuditPass]
	@Id NVARCHAR(50) --����Id
AS
    BEGIN
        SET NOCOUNT ON;
		--�����ھ� ���(�״���˵����)  ----------��ʼ
		IF	(NOT EXISTS(SELECT * FROM Coach WHERE Id=@Id))
		BEGIN
			--��������Ϣ��ȡ����ʽ������	
			INSERT INTO Coach 
			(
				Id,
				CommissionPercentage,
				HeadUrl,
				IdCardFrontUrl,
				IdCardBackUrl,
				VenueId,
				BeginTeachingDate,
				Qualification,
				State,
				Grade,
				AuditOpinion,
				OrganizationId,
				IsEnabled,
				FileId,
				AuditDateTime,
				CreateDate
			) 
			SELECT 
				Id,
				CommissionPercentage,
				HeadUrl,
				IdCardFrontUrl,
				IdCardBackUrl,
				VenueId,
				BeginTeachingDate,
				Qualification,
				'010002' ,
				Grade,
				AuditOpinion,
				OrganizationId,
				IsEnabled,
				FileId,
				GETDATE(),
				CreateDate
			FROM CoachApply WHERE Id=@Id; 
		END
		--�����ھ� ���  ----------����
		ELSE	
		--���ھ� ����(������˵����) ----------��ʼ
		BEGIN	
			--������ʽ�� (��b���һ����¼����a��)
		
				 UPDATE a
				 SET 
					a.IdCardFrontUrl=b.IdCardFrontUrl,
					a.IdCardBackUrl=b.IdCardBackUrl,
					a.VenueId=b.VenueId,
					a.BeginTeachingDate=b.BeginTeachingDate,
					a.Qualification=b.Qualification,
					a.AuditOpinion=b.AuditOpinion,
					a.Grade=b.Grade,
					a.AuditDateTime=GETDATE()
				 FROM  dbo.Coach a
				 INNER JOIN dbo.CoachApply b ON a.Id=b.Id  
				 WHERE a.Id=@Id
			

		END
		--���ھ� ���� ----------����
		------------�������� ------------------
		--���¸�����Ϣ�� UserAccount
		UPDATE c
		SET 
			c.CardName=d.Name,
			c.Mobile=d.Mobile,
			c.CardId=d.CardId,
			c.HeadUrl=d.HeadUrl 
		FROM  dbo.UserAccount c
		INNER JOIN dbo.CoachApply d ON c.Id=d.Id  
		WHERE c.Id=@Id
		--����������ʱ��FileInfo��Ϣ, �ض�����ʽ������  -----��ʼ
		--��ɾ����ǰ����ʽ�ļ���Ϣ
		DELETE FROM dbo.FileInfo  WHERE MasterType='CoachFormal' AND MasterId=@Id
		--�ٽ�������ļ���Ϣ �޸ĳ���ʽ���ļ���Ϣ
		UPDATE dbo.FileInfo SET MasterType='CoachFormal' WHERE MasterType='CoachApply' AND MasterId=@Id
		--����������ʱ��FileInfo��Ϣ, �ض�����ʽ������  -----����

		--ɾ��������Ϣ
		DELETE FROM CoachApply WHERE Id=@Id;

    END



GO
/****** Object:  StoredProcedure [dbo].[sp_CreateVipVenueBill]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- ��֧������ʱ��Σ����ɳ��ݽ����˵�
-- =============================================
CREATE PROCEDURE [dbo].[sp_CreateVipVenueBill]
    @cityId NVARCHAR(50) ,--��ѡ����
    @venueId NVARCHAR(50) ,--��ѡ����
	@userId NVARCHAR(50) ,
    @beginDate DATETIME ,
    @endDate DATETIME
AS
    BEGIN
        DECLARE @tempVenueId NVARCHAR(50)

		--���ҷ��������ĳ���
        DECLARE cur_venue CURSOR
        FOR
            SELECT  Id
            FROM    dbo.Venue
            WHERE   IsUseVip = 1
                    AND ( ISNULL(@venueId, '') = ''
                          OR Id = @venueId
                        )
                    AND ( ISNULL(@cityId, '') = ''
                          OR CityId = @cityId
                        )

        OPEN cur_venue
        FETCH NEXT FROM cur_venue INTO @tempVenueId

        WHILE @@FETCH_STATUS = 0
            BEGIN
				--��֤�Ƿ����ɹ��������֧������������δ֧������Ľ�δ����������
                DECLARE @payState NVARCHAR(50) 
                DECLARE @id NVARCHAR(50)

				--��ȡ�ѽ����������
                DECLARE @maxDate DATETIME
                SELECT  @maxDate = MAX(EndDate)
                FROM    dbo.VenueBill
                WHERE   VenueId = @tempVenueId

				--����δ����ļ�¼
                IF @maxDate IS  NULL
                    OR CONVERT(NVARCHAR(10), @beginDate, 120) > CONVERT(NVARCHAR(10), @maxDate, 120)
                    BEGIN
						--ͳ����֧�����
                        DECLARE @amount FLOAT
                        DECLARE @discount FLOAT

                        SELECT  @amount = SUM(Amount)
                        FROM    dbo.VipUse
                        WHERE   VenueId = @tempVenueId
                                AND PayState = '024002'--��֧��
                                AND CONVERT(NVARCHAR(10), PayDate, 120) BETWEEN CONVERT(NVARCHAR(10), @beginDate, 120) AND CONVERT(NVARCHAR(10), @endDate, 120)

						--���ҽ����ۿ�
                        SELECT  @discount = Discount
                        FROM    dbo.VipInnerDiscount
                        WHERE   VenueId = @tempVenueId

						--�����ۿۺ���
                        IF @discount IS NOT NULL
                            SET @amount = @amount * @discount

                        DECLARE @orderNo NVARCHAR(50)
                        EXEC dbo.sp_GetSerialNo1 N'VenueBill', @orderNo OUTPUT
							

						--�����˵�
                        INSERT  dbo.VenueBill
                                ( Id ,
                                  OrderNo ,
                                  BeginDate ,
                                  EndDate ,
                                  VenueId ,
                                  TotalAmount ,
                                  Discount ,
                                  Amount ,
                                  PayOption ,
                                  PayId ,
                                  PayState ,
                                  PayDate ,
                                  PayRemark ,
                                  Remark ,
								  State,
                                  CreatorId ,
                                  CreateDate
				                )
                        VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                                  @orderNo ,
                                  @beginDate , -- BeginDate - datetime
                                  @endDate , -- EndDate - datetime
                                  @tempVenueId , -- VenueId - nvarchar(50)
                                  @amount ,
                                  ISNULL(@discount, 1) ,
                                  @amount , -- Amount - float
                                  NULL , -- PayOption - nvarchar(50)
                                  NULL , -- PayId - nvarchar(50)
                                  N'024001' , -- δ֧�� PayState - nvarchar(50)
                                  NULL , -- PayDate - datetime
                                  NULL , -- PayRemark - nvarchar(500)
                                  NULL , -- Remark - nvarchar(500)
								  N'026001',
                                  @userId , -- CreatorId - nvarchar(50)
                                  GETDATE()  -- CreateDate - datetime
				                )
                    END
                FETCH NEXT FROM cur_venue INTO @tempVenueId
            END

        CLOSE cur_venue
        DEALLOCATE cur_venue
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameAllDetail]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteGameAllDetail] 
	@gameId NVARCHAR(50)
AS
BEGIN
	--ɾ��������Ϣ
	DELETE FROM GameGroup WHERE GameId=@gameId 
	DELETE FROM GameGroupMember WHERE GameId=@gameId 

	--ɾ��������Ϣ
	DELETE FROM dbo.GameLoopMap WHERE LoopId IN (SELECT Id FROM dbo.GameLoop WHERE GameId=@gameId)
	DELETE FROM dbo.GameLoopDetail WHERE LoopId IN (SELECT Id FROM dbo.GameLoop WHERE GameId=@gameId)
	DELETE FROM GameLoop WHERE GameId=@gameId 
	DELETE FROM GameOrder WHERE GameId=@gameId

END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameGroup]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteGameGroup]
    @gameId NVARCHAR(50) ,
    @groupIdString NVARCHAR(2000)
AS
    BEGIN
        IF ISNULL(@groupIdString, '') != ''
            BEGIN
                DELETE  FROM dbo.GameLoop
                WHERE   GameId = @gameId
                        AND GroupId IN ( SELECT Id
                                         FROM   dbo.fn_Split(@groupIdString) )

                DELETE  FROM dbo.GameGroupMember
                WHERE   GameId = @gameId
                        AND GroupId IN ( SELECT Id
                                         FROM   dbo.fn_Split(@groupIdString) )
            END
        ELSE
            BEGIN
                DELETE  FROM dbo.GameLoop
                WHERE   GameId = @gameId

                DELETE  FROM dbo.GameGroupMember
                WHERE   GameId = @gameId
            END
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameTeam]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteGameTeam]
    @gameId NVARCHAR(50) ,
    @creatorId NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        SET @message = ''

        DECLARE @state NVARCHAR(50)
        SELECT  @state = State
        FROM    dbo.GameTeam
        WHERE   GameId = @gameId
                AND CreatorId = @creatorId

        IF @state = '012001'
            DELETE  FROM dbo.GameTeam
            WHERE   GameId = @gameId
                    AND CreatorId = @creatorId
        ELSE
            SET @message = '�����Ѿ����ͨ��������ϵ���¹���Աȡ��������'

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameTeamById]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteGameTeamById]
    @gameId NVARCHAR(50) ,
    @teamId NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        SET @message = ''

        IF EXISTS ( SELECT  *
                    FROM    dbo.GameLoop
                    WHERE   GameId = @gameId
                            AND ( Team1Id = @teamId
                                  OR Team2Id = @teamId
                                ) )
            SET @message = '�ö����Ѿ������˱���������ȡ����'
        ELSE
            DELETE  FROM dbo.GameTeam
            WHERE   Id = @teamId AND GameId=@gameId
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteOnlineUser]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteOnlineUser]
    @userId NVARCHAR(50) 
AS
    BEGIN
        DELETE  FROM dbo.OnlineUser
        WHERE   UserId = @userId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_FinishGameOrder]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_FinishGameOrder] @orderId NVARCHAR(50)
AS
    BEGIN

        DECLARE @count INT;

        SELECT  @count = COUNT(*)
        FROM    dbo.GameLoop
        WHERE   OrderId = @orderId
                AND State != '011003'

        IF @count = 0
            UPDATE  dbo.GameOrder
            SET     State = '013003'

        SELECT  @count;
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetActivity]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetActivity]
    @userId NVARCHAR(50) ,
    @activityId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                a.Name ,
                a.Introduce ,
                a.HeadUrl ,
                a.SportId ,
                dbo.fn_Link(b.Id, b.Name) AS ClubId ,
                ( CASE WHEN e.Id IS NULL THEN CAST(0 AS BIT)
                       ELSE CAST(1 AS BIT)
                  END ) AS IsClubMember ,
                a.BeginTime ,
                a.EndTime ,
                dbo.fn_Link(c.Id, c.Name) AS VenueId ,
				c.Lng,
				c.Lat,
				c.Address AS VenueAddress,
                dbo.fn_GetUserLinkPetName(a.CreatorId, a.ClubId) CreatorId ,
                a.CreateDate ,
                a.State ,
                a.Type ,
                dbo.fn_Link(f.Id, f.Name) AS BattleStyle ,
                dbo.fn_Link(t.Id, t.Name) AS CityId ,
                dbo.fn_Link(g.Id, g.Name) AS State ,
                dbo.fn_GetReplyCount(a.Id) AS ReplyCount ,
                u.Mobile
        FROM    Activity a
                LEFT JOIN dbo.UserAccount u ON u.Id = a.CreatorId
                LEFT JOIN Club b ON a.ClubId = b.Id
                LEFT JOIN Venue c ON a.VenueId = c.Id
                LEFT JOIN ClubUser e ON a.ClubId = e.ClubId
                                        AND e.UserId = @userId
                LEFT JOIN BaseData f ON a.BattleStyle = f.Id
                LEFT JOIN BaseData g ON a.[State] = g.Id
                LEFT JOIN dbo.City t ON a.CityId = t.Id
        WHERE   a.Id = @activityId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetActivityList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetActivityList]
    @clubId NVARCHAR(50) ,
    @cityId NVARCHAR(50) ,
    @type NVARCHAR(50) ,
    @name NVARCHAR(50) ,
	@isClubActivity BIT,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @sql NVARCHAR(MAX)

		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(Id) FROM Activity WHERE State!=''005009'' '

                IF ISNULL(@clubId, '') != ''
                    SET @sql = @sql + ' AND ClubId = @clubId'

                IF ISNULL(@cityId, '') != ''
                    SET @sql = @sql + ' AND CityId = @cityId'

                IF ISNULL(@type, '') != ''
                    SET @sql = @sql + ' AND [Type] = @type'       

                IF ISNULL(@name, '') != ''
                    SET @sql = @sql + ' AND Name LIKE ''%' + @name + '%'''    
                IF	@isClubActivity =1
					SET @sql = @sql + ' AND ISNULL(ClubId, '''') != '''' '	 --�����ֲ��
				ELSE		
					SET @sql = @sql + ' AND ISNULL(ClubId, '''') = '''' '	--���Ǿ��ֲ��

                EXEC SP_EXECUTESQL @sql,
                    N'@ClubId NVARCHAR(50),@cityId NVARCHAR(50),@type NVARCHAR(50),@rowCount INT OUTPUT',
                    @clubId, @cityId, @type, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
					SELECT 
						a.Id,a.SportId,a.HeadUrl,a.Name,dbo.fn_Link(b.Id,b.Name) AS ClubId,
		                dbo.fn_GetReplyCount(a.Id) AS ReplyCount,
						a.BeginTime,a.EndTime,dbo.fn_Link(c.Id,c.Name) AS VenueId,a.Type,dbo.fn_Link(d.Id , d.Name) AS [State],
						c.Address AS VenueAddress,
						(SELECT COUNT(1) FROM ActivityUser WHERE ActivityId=a.Id) AS UserCount ,
						dbo.fn_Link(f.Id, f.Name) AS BattleStyle 
					FROM 
						(
							SELECT 
								ROW_NUMBER() OVER(ORDER BY BeginTime DESC) AS RowNumber,Id,HeadUrl,[Name],ClubId,BeginTime,EndTime,VenueId,[Type],[State],SportId,
								 BattleStyle
							FROM Activity WHERE State!=''005009'' '

        IF ISNULL(@clubId, '') != ''
            SET @sql = @sql + ' AND ClubId = @clubId'

        IF ISNULL(@cityId, '') != ''
            SET @sql = @sql + ' AND CityId = @cityId'

        IF ISNULL(@type, '') != ''
            SET @sql = @sql + ' AND [Type] = @type'	

        IF ISNULL(@name, '') != ''
            SET @sql = @sql + ' AND Name LIKE ''%' + @name + '%'''    
        IF	@isClubActivity =1
            SET @sql = @sql + ' AND ISNULL(ClubId, '''') != '''' '	 --�����ֲ��
		ELSE		
		    SET @sql = @sql + ' AND ISNULL(ClubId, '''') = '''' '	--���Ǿ��ֲ��


        SET @sql = @sql
					+ ' ) a 
				LEFT JOIN Club b ON a.ClubId=b.Id
				LEFT JOIN Venue c ON a.VenueId=c.Id
				LEFT JOIN BaseData d ON a.[State] = d.Id
				LEFT JOIN BaseData f ON a.BattleStyle = f.Id
				WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize  
				ORDER BY BeginTime DESC'

		PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@clubId NVARCHAR(50),@cityId NVARCHAR(50),@type NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @clubId, @cityId, @type, @pageIndex, @pageSize

		
		
    END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetActivityUserList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetActivityUserList]
    @activityId NVARCHAR(50),
    @petName NVARCHAR(50) ,
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		--��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@petName, '') != ''
            SET @filter = @filter
                + ' AND (b.Code+b.PetName+b.CardName+b.Mobile+ISNULL(a.PetName,'''') LIKE ''%'
                + @petName + '%'')' 

		DECLARE @sql NVARCHAR(MAX)
		--������һҳ  ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
					SELECT @rowCount=COUNT(*) 
					FROM ActivityUser a 
					LEFT JOIN UserAccount b ON b.Id=a.UserId 
					WHERE a.ActivityId=@activityId'
                    + @filter
					 	
                EXEC SP_EXECUTESQL @sql,
                    N'@activityId NVARCHAR(50),@rowCount INT OUTPUT', @activityId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0

		--��ҳȡ����
		SET @sql='
			SELECT *  
			FROM (
					SELECT
							ROW_NUMBER() OVER (ORDER BY A.CreateDate ) AS RowNumber, 
							a.Id ,
							a.ActivityId ,
							b.HeadUrl,
							b.Sex,
							dbo.fn_GetUserLinkPetName(a.UserId, c.ClubId) UserId ,
							a.IsJoined ,
							a.Remark ,
							a.CreateDate
					FROM    dbo.ActivityUser a
							JOIN dbo.UserAccount b ON a.UserId = b.Id
							JOIN dbo.Activity c ON a.ActivityId = c.Id
					WHERE   a.ActivityId = @activityId' 
		 
			+ @filter
            + ' ) c 
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize '

			EXEC SP_EXECUTESQL @sql,
            N'@activityId NVARCHAR(50),@pageIndex INT,@pageSize INT', @activityId,
            @pageIndex, @pageSize

			PRINT(@sql)
    END
    

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCityList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<��ȡ���ֲ��б�>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCityList]
	-- Add the parameters for the stored procedure here
    @name NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM City WHERE 1=1'

                IF ISNULL(@name, '') != ''
                    SET @sql = @sql + ' AND Name LIKE ''%' + @name + '%'''    
			
                EXEC SP_EXECUTESQL @sql,
                    N'@rowCount INT OUTPUT',
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = 'SELECT RowNumber,Id,CityCode,Name,ParentId,Lat,Lng,CreateDate  
			FROM (SELECT ROW_NUMBER() OVER(ORDER BY IsCommon DESC,Name) AS RowNumber,Id,CityCode,Name,ParentId,Lat,Lng,CreateDate 
			FROM City WHERE 1=1'

        IF ISNULL(@name, '') != ''
            SET @sql = @sql + ' AND Name LIKE ''%' + @name + '%'''    
		
        SET @sql = @sql
            + ') a 
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize  '
	
        EXEC SP_EXECUTESQL @sql,
            N'@pageIndex INT,@pageSize INT',
            @pageIndex, @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetClub]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClub]
    @clubId NVARCHAR(50) ,
    @userId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                a.HeadUrl ,
                a.Name ,
                dbo.fn_Link(c.Id, c.Name) AS CityId ,
                Introduce ,
                a.SignName ,
                dbo.fn_Link(b.Id, b.Name) AS SportId ,
                dbo.fn_GetUserLinkPetName(a.CreatorId,a.Id) AS CreatorId ,
                a.Remark ,
                a.CreateDate ,
				a.LevelValue,
                d.IsCreator ,
                d.IsAdmin ,
                ( SELECT    COUNT(*)
                  FROM      ClubUser
                  WHERE     ClubId = a.Id
                ) AS UserCount ,
				CASE WHEN d.Id IS NULL THEN 0
                     ELSE 1
                END AS JoinedState,				
				u.Mobile,
				(SELECT    COUNT(*)
                  FROM      ClubRequest 
                  WHERE    ClubId=@clubId AND State='003001' /*�����е�*/
				 ) AS RequestCount
        FROM    Club a
                INNER JOIN SportType b ON a.SportId = b.Id
                INNER JOIN City c ON a.CityId = c.Id
				INNER JOIN dbo.UserAccount u ON u.Id=a.CreatorId
                LEFT JOIN ClubUser d ON d.ClubId = a.Id
                                        AND d.UserId = @userId

        WHERE   a.Id = @clubId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubAddressList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClubAddressList]
    @clubId NVARCHAR(50) 
AS
    BEGIN
        SET NOCOUNT ON;
        
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = 'SELECT  a.Id ,
                a.ClubId ,
                b.HeadUrl ,
                dbo.fn_Link(b.Id,b.Name) AS VenueId ,
                a.Remark,
				b.Lng,
				b.Lat,
				b.Address 
        FROM    ClubAddress a
                INNER JOIN Venue b ON a.VenueId = b.Id
        WHERE   a.ClubId = @clubId'
            
        EXEC SP_EXECUTESQL @sql,
            N'@clubId NVARCHAR(50)', @clubId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<��ȡ���ֲ��б�>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClubList]
	-- Add the parameters for the stored procedure here
    @sportTypeId NVARCHAR(50) ,
    @cityId NVARCHAR(50) ,
    @userId NVARCHAR(50) ,
    @name NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Club WHERE 1=1'
		
                IF ISNULL(@sportTypeId, '') != ''
                    SET @sql = @sql + ' AND SportTypeId=@SportTypeId '
			
                IF ISNULL(@cityId, '') != ''
                    SET @sql = @sql + ' AND CityId=@CityId '

                IF ISNULL(@name, '') != ''
                    SET @sql = @sql + ' AND Name LIKE ''%' + @name + '%'''    
			
                EXEC SP_EXECUTESQL @sql,
                    N'@SportTypeId NVARCHAR(50),@CityId NVARCHAR(50),@rowCount INT OUTPUT',
                    @sportTypeId, @cityId, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = 'SELECT a.Id,a.Name,A.HeadUrl,A.SignName,a.CreateDate,dbo.fn_Link(b.Id,b.Name) AS SportId,
			dbo.fn_Link(d.Id,d.Name) AS CityId,
			(CASE WHEN c.Id IS NULL THEN 0 ELSE 1 END) AS JoinedState ,
			(SELECT COUNT(*) FROM ClubUser WHERE ClubId=a.Id) AS UserCount 
			FROM (SELECT ROW_NUMBER() OVER(ORDER BY CreateDate) AS RowNumber,Id,HeadUrl,SportId,Name,SignName,CreateDate ,CityId
			FROM Club WHERE 1=1'
			
        IF ISNULL(@sportTypeId, '') != ''
            SET @sql = @sql + ' AND SportTypeId=@SportTypeId '
		
        IF ISNULL(@cityId, '') != ''
            SET @sql = @sql + ' AND CityId=@CityId '

        IF ISNULL(@name, '') != ''
            SET @sql = @sql + ' AND Name LIKE ''%' + @name + '%'''    
		
        SET @sql = @sql
            + ') a 
			LEFT JOIN SportType b ON a.SportId=b.Id
			LEFT JOIN ClubUser c ON a.Id=c.ClubId AND c.UserId=@userId
			LEFT JOIN City d ON d.Id=a.CityId
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'
	
        EXEC SP_EXECUTESQL @sql,
            N'@sportTypeId NVARCHAR(50),@CityId NVARCHAR(50),@userId NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @sportTypeId, @cityId, @userId, @pageIndex, @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubMyList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClubMyList] @userId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;
	
        SELECT  a.Id ,
                a.Name ,
                a.HeadUrl ,
                Introduce ,
                a.LevelValue ,
                SignName ,
                HeadUrl ,
                dbo.fn_Link(b.Id, b.Name) AS SportId ,
				dbo.fn_Link(d.Id, d.Name) AS CityId ,
                CreatorId ,
                Remark ,
                a.CreateDate ,
                C.IsCreator ,
                C.IsAdmin,
                ( SELECT    COUNT(*)
                  FROM      ClubUser
                  WHERE     ClubId = a.Id
                ) AS UserCount ,
                ( SELECT    COUNT(*)
                  FROM      ClubRequest
                  WHERE     ClubId = a.Id
                            AND State = '003001'
                ) AS RequestCount
        FROM    Club a
                LEFT JOIN SportType b ON a.SportId = b.Id
				LEFT JOIN dbo.City d ON d.Id=a.CityId
                INNER JOIN ClubUser c ON c.ClubId = a.Id
                                         AND c.UserId = @userId
        ORDER BY c.CreateDate DESC
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubRequestList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClubRequestList]
    @clubId NVARCHAR(50) ,
    @state NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;
        
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = 'SELECT  a.Id ,
                a.ClubId ,
                b.HeadUrl ,
                dbo.fn_Link(b.Id,b.PetName) AS CreatorId ,
                a.Remark ,
                a.CreateDate ,
				CAST(RowVersion AS INT) AS RowVersion,
                a.State
        FROM    ClubRequest a
                INNER JOIN UserAccount b ON a.CreatorId = b.Id
        WHERE   a.ClubId = @clubId'
        
        IF ISNULL(@state, '') != ''
            SET @sql = @sql + ' AND a.State = @state'
            
        EXEC SP_EXECUTESQL @sql,
            N'@clubId NVARCHAR(50),@state NVARCHAR(50)', @clubId, @state
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubUserList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClubUserList] 
	-- Add the parameters for the stored procedure here
    @clubId NVARCHAR(50) ,
    @petName NVARCHAR(50) ,
    @isAdmin BIT ,--�Ƿ�ֻ��ѯ����Ա
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@petName, '') != ''
            SET @filter = @filter
                + ' AND (b.Code+b.PetName+b.CardName+b.Mobile+ISNULL(a.PetName,'''') LIKE ''%'
                + @petName + '%'')' 

        IF @isAdmin = 1
            SET @filter = @filter + ' AND a.IsAdmin=1 '

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ͬʱ��ֻ��ѯ����Ա��ʱ�� ȡ����
        IF @pageIndex = 1
            AND @isAdmin = 0
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM ClubUser a LEFT JOIN UserAccount b ON b.Id=a.UserId WHERE a.ClubId=@ClubId'
                    + @filter
					 	
                EXEC SP_EXECUTESQL @sql,
                    N'@ClubId NVARCHAR(50),@rowCount INT OUTPUT', @clubId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
	    --���������ѯ����Ա�����ֶ�����@pageIndex,@pageSize���൱�ڲ���ҳ
        IF @isAdmin = 1
            BEGIN
                SET @pageIndex = 1
                SET @pageSize = 100
            END
            
        --��ҳȡ����
        
        SET @sql = '
			SELECT *  
			FROM (
				SELECT ROW_NUMBER() OVER(ORDER BY a.IsAdmin DESC) AS RowNumber,
				a.Id,
				a.ClubId,
				a.UserId,
				dbo.fn_GetUserLinkPetName(a.UserId,a.ClubId) AS PetName, 
				a.IsCreator,
				a.IsAdmin,
				a.Score,
				a.LevelValue,
				b.Code,
				b.HeadUrl,
				b.CardName,
				b.Sex,
				(SELECT TOP 1 Name FROM ClubHonor d WHERE d.ClubId=a.ClubId AND (a.Score BETWEEN BeginScore AND EndScore)) AS HonorName 

				FROM ClubUser a LEFT JOIN UserAccount b ON b.Id=a.UserId WHERE a.ClubId=@ClubId '
            + @filter
            + ' ) c 
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize '
	
        EXEC SP_EXECUTESQL @sql,
            N'@ClubId NVARCHAR(50),@pageIndex INT,@pageSize INT', @clubId,
            @pageIndex, @pageSize
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachAuditList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetCoachAuditList]
	@Name NVARCHAR(50),
	@State NVARCHAR(50),
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
   AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        --IF ISNULL(@Name, '') != ''
        --    SET @filter = @filter + ' AND b.CardName = @Name'

		--���ò�ѯ��
		DECLARE @tableName NVARCHAR(100)
		IF	@State='010001' OR @State ='010003' --����� �� �Ѿܾ�
				SET	@tableName='CoachApply' --�����
			ELSE 
				SET	@tableName='Coach' --��ʽ��
        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1  
            BEGIN
					
                SET @sql = '
						SELECT 
							@rowCount=COUNT(*)
						FROM dbo.'+@tableName+'  a
						WHERE a.State=@State   ' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@State NVARCHAR(50),@rowCount INT OUTPUT',
                    @State,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ��ʽ�� ����	
		IF	@tableName='Coach'  
		BEGIN
			SET @sql = '
					 
				SELECT 
					a.[Id]
					,a.[CommissionPercentage]
					,a.[IdCardFrontUrl]
					,a.[IdCardBackUrl]
					,a.[VenueId]
					,a.[BeginTeachingDate]
					,a.[Qualification]
					,a.[State]
					,a.[Grade]
					,a.[AuditOpinion]
					,a.[OrganizationId]
					,a.[IsEnabled]
					,a.[FileId]
					,a.[CreateDate],
					 a.AuditDateTime,
					 b.HeadUrl,
					 b.Sex,
					 dbo.fn_GetUserName(b.Id) AS Name,
					 b.Code
				FROM dbo.Coach  a
				INNER JOIN UserAccount b ON a.Id=b.Id
				WHERE a.State=@State   ' +@filter+'
				ORDER BY a.CreateDate
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'
		END
        ELSE IF  @tableName='CoachApply'  
		BEGIN
			SET @sql = '
					 
				SELECT 
					a.[Id]
					,a.[CommissionPercentage]
					,a.[IdCardFrontUrl]
					,a.[IdCardBackUrl]
					,a.[VenueId]
					,a.[BeginTeachingDate]
					,a.[Qualification]
					,a.[State]
					,a.[Grade]
					,a.[AuditOpinion]
					,a.[OrganizationId]
					,a.[IsEnabled]
					,a.[FileId]
					,a.[CreateDate],
					 a.AuditDateTime,
					 a.HeadUrl,
					 b.Sex,
					 a.Name AS Name,
					 b.Code
				FROM dbo.CoachApply  a
				INNER JOIN UserAccount b ON a.Id=b.Id
				WHERE a.State=@State   ' +@filter+'
				ORDER BY a.CreateDate
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'
		END
        
		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@State NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @State ,@pageIndex, @pageSize

		
		
    END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachCommentList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetCoachCommentList]
	@coacherUserId NVARCHAR(50),
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' a.CoacherUserId=@coacherUserId'
    

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount= COUNT(a.Id)
						FROM dbo.CoachComment a
						INNER JOIN dbo.UserAccount b ON a.CommentatorId=b.Id
						WHERE 1=1 AND
						 	 '+@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@coacherUserId NVARCHAR(50),@rowCount INT OUTPUT',
                     @coacherUserId ,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
				SELECT 
					*
				FROM 
					(
						SELECT 
							ROW_NUMBER() OVER (ORDER BY a.CreateDate DESC) AS RowNumber,
							b.HeadUrl,
							b.Sex,
							CommentatorName=CASE WHEN a.IsShareName=1 THEN b.CardName ELSE ''�����û�'' END,
							a.Id,
							a.CoacherUserId,
							a.Score,
							a.Comment,
							a.CommentatorId,
							a.IsShareName,
							a.CreateDate
						FROM dbo.CoachComment a
						INNER JOIN dbo.UserAccount b ON a.CommentatorId=b.Id
						WHERE 1=1 AND
						 	 '+@filter+'
					   ) a 
				 
				WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize  
				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@coacherUserId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @coacherUserId ,@pageIndex, @pageSize

		
		
    END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacher]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetCoacher]
	@UserId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;
	 
        DECLARE @sql NVARCHAR(MAX)
	 
        SET @sql = '
						SELECT 
							 b.HeadUrl,
							 b.CardName AS Name,
							 b.Mobile,
							 b.Sex,
							 ResidentAddressAuditState=(
							 SELECT 
								CASE WHEN State=''010002'' THEN ''true'' ELSE ''false'' END 
							 FROM dbo.Venue WHERE Id=a.VenueId
							 ),
							 a.*
						 FROM dbo.Coacher  a
						 INNER JOIN dbo.UserAccount b  ON a.userId=b.Id
						 WHERE 1=1  AND a.UserId='''+@UserId +''''

		--PRINT (@sql)

        EXEC(@sql)

    END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherApply]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetCoacherApply]
	@UserId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;
	 
        DECLARE @sql NVARCHAR(MAX)
	 
        SET @sql = '
						--���ûͨ����
						SELECT 
							 a.Id,
							 a.UserId,
							 a.State,
							 a.CoachAge,
							 a.Grade,
							 a.HeadUrl,
							 a.IdCardFrontUrl,
							 a.IdCardBackUrl,
							 a.CreateDate,
							 a.Qualification,
							 a.AuditOpinion,
							 a.VenueId,
							 b.HeadUrl,
							 b.CardName AS Name,
							 b.Mobile,
							 b.Sex,
							 b.CardId,
							 ResidentAddressAuditState=(
								 SELECT 
									CASE WHEN State=''010002'' THEN 1 ELSE 0 END 
								 FROM dbo.Venue WHERE Id=a.VenueId
							 ),
							 c.Address AS VenueAddress,
							 c.Name AS VenueName
						 FROM dbo.CoacherApply  a
						 INNER JOIN dbo.UserAccount b  ON a.userId=b.Id
						 LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
						 WHERE 1=1  AND a.UserId='''+@UserId +'''
						 UNION ALL 
						 --���ͨ����
						 SELECT 
							  a.Id,
							 a.UserId,
							 a.State,
							 a.CoachAge,
							 a.Grade,
							 a.HeadUrl,
							 a.IdCardFrontUrl,
							 a.IdCardBackUrl,
							 a.CreateDate,
							 a.Qualification,
							 a.AuditOpinion,
							 a.VenueId,
							 b.HeadUrl,
							 b.CardName AS Name,
							 b.Mobile,
							 b.Sex,
							 b.CardId,
							 ResidentAddressAuditState=(
								 SELECT 
									CASE WHEN State=''010002'' THEN 1 ELSE 0 END 
								 FROM dbo.Venue WHERE Id=a.VenueId
							 ),
							 c.Address AS VenueAddress,
							 c.Name AS VenueName
						 FROM dbo.Coacher  a
						 INNER JOIN dbo.UserAccount b  ON a.userId=b.Id
						 LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
						 WHERE 1=1  AND a.UserId='''+@UserId +''''

		PRINT (@sql)

        EXEC(@sql)

    END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherCourseStudentList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_GetCoacherCourseStudentList] 
	@CoacherUserId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        --IF ISNULL(@Name, '') != ''
        --    SET @filter = @filter + ' AND b.CardName = @Name'

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(
									DISTINCT
									b.StudentUserId 
								) 
						FROM dbo.CoacherCourse a
						INNER JOIN dbo.CoacherCourseJoin b ON a.Id=b.CourseId
						WHERE a.CoacherUserId=@CoacherUserId   ' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@CoacherUserId NVARCHAR(50),@rowCount INT OUTPUT',
                    @CoacherUserId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
					 
				SELECT 
						DISTINCT
						b.StudentUserId as UserId,
						c.CardName  as Name, 
						c.HeadUrl
				FROM dbo.CoacherCourse a
				INNER JOIN dbo.CoacherCourseJoin b ON a.Id=b.CourseId
				LEFT JOIN dbo.UserAccount c ON b.StudentUserId=c.Id
				WHERE a.CoacherUserId=@CoacherUserId '+@filter+'
				ORDER BY 1
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@CoacherUserId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @CoacherUserId ,@pageIndex, @pageSize

		
		
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherCourseVenueList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_GetCoacherCourseVenueList] 
	@CoacherUserId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        --IF ISNULL(@Name, '') != ''
        --    SET @filter = @filter + ' AND b.CardName = @Name'

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(
									DISTINCT
									a.VenueId 
								) 
						FROM dbo.CoacherCourse a
						INNER JOIN dbo.Venue b ON a.VenueId=b.Id
						WHERE CoacherUserId=@CoacherUserId   ' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@CoacherUserId NVARCHAR(50),@rowCount INT OUTPUT',
                    @CoacherUserId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
					 
				SELECT 
					DISTINCT
					a.VenueId AS Id,
					b.Address AS Address,
					b.Name,
					b.HeadUrl
				FROM dbo.CoacherCourse a
				INNER JOIN dbo.Venue b ON a.VenueId=b.Id
				WHERE CoacherUserId=@CoacherUserId '+@filter+'
				ORDER BY 1
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@CoacherUserId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @CoacherUserId ,@pageIndex, @pageSize

		
		
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherListForGradeUpgrade]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_GetCoacherListForGradeUpgrade]
    @cityId NVARCHAR(50) ,
    @coacherName NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		--����Filter
		DECLARE @filter NVARCHAR(MAX)
		SET @filter=''
		IF ISNULL(@cityId, '') != ''
            SET @filter = @filter + ' AND c.CityId=@CityId '

        IF ISNULL(@coacherName, '') != ''
            SET @filter = @filter + ' AND b.CardName LIKE ''%' + @coacherName + '%'''    
			
        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
				SELECT 
					@rowCount=COUNT(a.Id)
				FROM  dbo.Coacher a
				INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
				INNER JOIN dbo.Venue c ON a.VenueId=c.Id
				WHERE 1=1 ' +@filter
        
		   
                EXEC SP_EXECUTESQL @sql,
                    N'@CityId NVARCHAR(50),@rowCount INT OUTPUT',
                    @cityId, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
			SELECT 
				*
			FROM
			 (
						SELECT 
							a.Grade,
							a.CreateDate,
							a.Id,
							a.Qualification,
							a.UserId,
							a.VenueId,
							a.CoachAge,
							b.HeadUrl,
							b.CardName AS Name,
							Score=dbo.[fn_GetCoacherAVGScore] (a.UserId)
						FROM  dbo.Coacher a
						INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
						INNER JOIN dbo.Venue c ON a.VenueId=c.Id
						WHERE 1=1 '+@filter+'
						
	         ) a 
			ORDER BY a.CreateDate 
			OFFSET (@pageIndex-1)*@pageSize ROWS
			FETCH NEXT @pageSize ROWS ONLY 
			'
		
		--PRINT @sql
			
        EXEC SP_EXECUTESQL @sql,
            N'@CityId NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @cityId, @pageIndex, @pageSize

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherListForSelect]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCoacherListForSelect]
    @keywords NVARCHAR(50) ,--�ʺţ��ǳƣ��������ֻ�
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' WHERE 1=1'  
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
                + ' AND (b.Code+b.PetName+b.CardName+ISNULL(b.Mobile,'''') LIKE ''%''+@keywords+''%'')'         

        DECLARE @sql NVARCHAR(MAX)

		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
				 SELECT @rowCount=COUNT(a.Id) 
				 FROM dbo.Coach a
				 INNER JOIN dbo.UserAccount b ON  a.Id= b.Id '   
                 + @filter              
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@keywords NVARCHAR(50),@rowCount INT OUTPUT', @keywords,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
				 SELECT
						 b.HeadUrl,
						 b.Sex,
						 b.CardName,
						 b.PetName,
						 b.Code,
						 a.Id,
						 b.Id AS UserId
				 FROM dbo.Coach a
				 INNER JOIN dbo.UserAccount b ON  a.Id= b.Id  ' 
				+ @filter +' 
				ORDER BY a.CreateDate
				OFFSET (@pageIndex-1)*@pageSize ROWS 
				FETCH NEXT @pageSize ROWS ONLY 
				'

        EXEC SP_EXECUTESQL @sql,
            N'@keywords NVARCHAR(50),@pageIndex INT,@pageSize INT', @keywords,
            @pageIndex, @pageSize

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherMyStudentList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCoacherMyStudentList] 
    @CoacherUserId NVARCHAR(50),
	@StudentName NVARCHAR(50)='',
	@OrderColumn NVARCHAR(50),
	@OrderType NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
  BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@StudentName, '') != ''
            SET @filter = @filter + ' AND b.CardName LIKE ''%'+@StudentName+'%'''

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
				 SELECT 
					@rowCount=COUNT(*)
				 FROM dbo.CoacherStudentMoney a
				 INNER JOIN dbo.UserAccount b ON a.StudentUserId=b.Id
 				 WHERE a.CoacherUserId=@CoacherUserId    ' 
				 +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@CoacherUserId NVARCHAR(50),@StudentName NVARCHAR(50),@rowCount INT OUTPUT',
                    @CoacherUserId,@StudentName,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
					 SELECT 
							a.StudentUserId,
							SUM(CASE WHEN a.Deadline <= GETDATE() THEN 0  ELSE a.Amount END ) AS AmountSum,
							LastCourseJoin = ( 
												SELECT   MAX(CreateDate)
												FROM     CoacherCourseJoin
												WHERE    StudentUserId = a.StudentUserId 
													AND  CoacherUserId=@CoacherUserId
                                             ) ,
							b.CardName AS StudentName,
							b.HeadUrl,
							b.Sex
					 FROM dbo.CoacherStudentMoney a
					 INNER JOIN dbo.UserAccount b ON a.StudentUserId=b.Id
					 WHERE a.CoacherUserId=@CoacherUserId   '
					 +@filter+'
					 GROUP BY a.StudentUserId,b.CardName, b.HeadUrl,b.Sex 
					 ORDER BY 
					 '+@OrderColumn+' '+@OrderType+
					 '
					 OFFSET (@pageIndex-1)*@pageSize ROWS
					 FETCH NEXT @pageSize ROWS ONLY
				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@CoacherUserId NVARCHAR(50),@StudentName NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @CoacherUserId,@StudentName,@pageIndex, @pageSize

		
		
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_GetCoachList]
	@orderColumn NVARCHAR(100), 
	@orderType NVARCHAR(4), --�������� asc ����, desc ����
    @cityId NVARCHAR(50) ,
    @coacherName NVARCHAR(50) ,
	@curUserLng FLOAT,
	@curUserLat FLOAT,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT,
	@distance DECIMAL(18,2)=0
AS
    BEGIN
        SET NOCOUNT ON;
		--����Filter
		DECLARE @filter NVARCHAR(MAX)
		SET @filter=''
		IF ISNULL(@cityId, '') != ''
            SET @filter = @filter + ' AND c.CityId=@CityId '

        IF ISNULL(@coacherName, '') != ''
            SET @filter = @filter + ' AND b.CardName LIKE ''%' + @coacherName + '%'''    
		--���� DistanceFilter
		DECLARE @DistanceFilter NVARCHAR(MAX)
		SET @DistanceFilter=''
		IF	@distance>0
			SET @DistanceFilter=@DistanceFilter+' AND Distance < @distance ';
			
        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
				SELECT 
					@rowCount=COUNT(*)
				FROM (
					SELECT 
						Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,c.Lat,c.Lng)
					FROM  dbo.Coach a
					INNER JOIN dbo.UserAccount b ON a.Id=b.Id
					INNER JOIN dbo.Venue c ON a.VenueId=c.Id
					WHERE 1=1 AND a.IsEnabled=1 ' +@filter+'
					) a
				WHERE 1=1 '+ @DistanceFilter

                EXEC SP_EXECUTESQL @sql,
                    N'@curUserLat FLOAT,@curUserLng FLOAT,
					@CityId NVARCHAR(50),@rowCount INT OUTPUT, @distance DECIMAL(18,2)',
					@curUserLat, @curUserLng,
                    @cityId, @rowCount OUTPUT,@distance

            END
        ELSE
            SET @rowCount = 0
		--����
		DECLARE @orderSql NVARCHAR(MAX)
		SET @orderSql=''
		IF	@orderColumn='Distance'
			SET  @orderSql='Distance'
		IF	@orderColumn='Grade'
			SET  @orderSql='Grade'
		IF	@orderColumn='Score'
			SET  @orderSql='Score'
		IF	@orderColumn='CoachAge'
			SET  @orderSql='CoachAge'
		--��ҳȡ����	
        SET @sql = '
			SELECT 
				*
			FROM
			 (
						SELECT 
							a.Grade,
							a.CreateDate,
							a.Id,
							a.Qualification,
							a.VenueId,
							b.HeadUrl,
							b.CardName AS Name,
							Score=dbo.[fn_GetCoachAVGScore] (a.Id),
							VenueAddress=(SELECT Address FROM dbo.Venue WHERE Id=a.VenueId),
							c.Lat AS VenueLat ,
							c.Lng AS VenueLng,
							Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,c.Lat,c.Lng),
							CoachAge=[dbo].[fn_GetCoachAge](a.BeginTeachingDate),
							b.Sex
						FROM  dbo.Coach a
						INNER JOIN dbo.UserAccount b ON a.Id=b.Id
						INNER JOIN dbo.Venue c ON a.VenueId=c.Id
						WHERE 1=1 AND a.IsEnabled=1 '+@filter+'
						
	         ) a 
			 WHERE 1=1 '+@DistanceFilter+'
			ORDER BY '+@orderColumn+' '+@orderType+'
			OFFSET (@pageIndex-1)*@pageSize ROWS
			FETCH NEXT @pageSize ROWS ONLY 
			'
		
		--PRINT @sql
			
        EXEC SP_EXECUTESQL @sql,
            N'@curUserLat FLOAT,@curUserLng FLOAT,@CityId NVARCHAR(50),@pageIndex INT,@pageSize INT,
			@distance DECIMAL(18,2)',
            @curUserLat, @curUserLng, @cityId, @pageIndex, @pageSize,
			@distance

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachPriceList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_GetCoachPriceList] 
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
      
        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = ' 
				SELECT  @rowCount= COUNT(*) 
				FROM dbo.CoachPrice 
				' 
                EXEC SP_EXECUTESQL @sql,
                    N'@rowCount INT OUTPUT',
                   @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
				 SELECT 
						a.*,
						b.Name AS CityName
				FROM dbo.CoachPrice a
				INNER JOIN dbo.City b ON a.CityCode=b.CityCode
				ORDER BY a.CreateDate ASC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@pageIndex INT,@pageSize INT',
             @pageIndex, @pageSize
		
		
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachTeachingCourseList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetCoachTeachingCourseList]
	@CoachId NVARCHAR(50),
	@BeginTime NVARCHAR(50)='',
	@EndTime NVARCHAR(50)='',
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        DECLARE @sql NVARCHAR(MAX)

        SET @filter = ''
        IF ISNULL(@CoachId, '') != ''
			SET @filter = @filter + ' AND a.CoachId = @CoachId '
		IF ISNULL(@BeginTime, '') != '' AND  ISNULL(@EndTime, '') != ''
			SET @filter = @filter + ' AND a.BeginTime> '''+@BeginTime+ ''' AND a.EndTime< '''+@EndTime +''''
 
		

		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
									SELECT 
										@rowCount=COUNT(*)
									FROM dbo.CoachCourse a
 									WHERE 1=1  '+@filter
					

                EXEC SP_EXECUTESQL @sql,
                    N'@CoachId NVARCHAR(50),@rowCount INT OUTPUT',
                    @CoachId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
					--û���ڵĿγ�
					SELECT 
						a.*,
						b.Name AS TypeName,
						c.Address AS VenueAddress,
						d.CardName AS CoachName
					INTO #NotExpiredCourseList
					FROM dbo.CoachCourse a '
		SET @sql+='
					 INNER JOIN dbo.UserAccount d ON a.CoachId=d.Id
					LEFT JOIN dbo.BaseData b ON a.Type=b.Id
					LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
					WHERE 1=1 AND a.EndTime > GETDATE() '+@filter+'
					--����û���������ж���ҳ
					DECLARE @NotExpiredPageCount INT
					SELECT @NotExpiredPageCount=(COUNT(*)+@pageSize-1)/@pageSize FROM #NotExpiredCourseList
					--��ʼȡ����,  û���ڵ�ȡ���˲�ȡ���ڵĿγ�
					IF @pageIndex <=@NotExpiredPageCount
					BEGIN
							--��û����������ȡ
							SELECT 
								*
							FROM #NotExpiredCourseList
							ORDER BY  EndTime ASC
							OFFSET (@pageIndex-1)*@pageSize ROWS
							FETCH NEXT @pageSize ROWS ONLY
					END
					ELSE	
					BEGIN
						--�ӹ���������ȡ
 						SET @pageIndex=(@pageIndex-@NotExpiredPageCount); --����pageIndex
					 
						SELECT 
							a.*,
							b.Name AS TypeName,
							c.Address AS VenueAddress,
							d.CardName AS CoachName
						FROM dbo.CoachCourse a'
			SET @sql+='
						INNER JOIN dbo.UserAccount d ON a.CoachId=d.Id
						LEFT JOIN dbo.BaseData b ON a.Type=b.Id
						LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
						WHERE 1=1 AND  a.EndTime < GETDATE() '+@filter+'
						ORDER BY  EndTime DESC
						OFFSET (@pageIndex-1)*@pageSize ROWS
						FETCH NEXT @pageSize ROWS ONLY
					END

					DROP TABLE #NotExpiredCourseList
				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@CoachId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @CoachId,@pageIndex, @pageSize

	 
    END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompany]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCompany] @id NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                a.Name ,
                a.HeadUrl ,
                a.Introduce ,
                a.SiteUrl ,
                a.Phone ,
                a.Address ,
				a.IsStop,
                dbo.fn_Link(b.Id, b.CardName) CreatorId ,
                a.CreateDate,
				a.WeiXin,
				dbo.fn_Link(C.Id, C.CardName) AdminId,
				a.AlipayId,
				a.IsManage,
				a.IsYDL
        FROM    Company A
                JOIN dbo.UserAccount B ON B.Id = A.CreatorId
				LEFT JOIN dbo.UserAccount C ON C.Id = A.AdminId
        WHERE   A.Id = @id
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompanyList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCompanyList]
    @name NVARCHAR(50) ,
    @IsManage BIT ,
	@showAll BIT ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
        
        DECLARE @sql NVARCHAR(MAX),@whereSql NVARCHAR(500)

		--û��������������ʱȡ���������
		--SET @whereSql=' WHERE IsManage=@IsManage'
		SET @whereSql=' WHERE 1=1'

		IF ISNULL(@showAll,0)=0
			SET @whereSql=@whereSql+' AND ISNULL(IsStop,0)!=1'

		IF ISNULL(@name, '') != ''
			SET @whereSql = @whereSql + ' AND name LIKE ''%''+@name+''%'''

		--��ȡ������ 
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Company'+@whereSql

                EXEC SP_EXECUTESQL @sql,
                    N'@name NVARCHAR(50),@IsManage BIT,@rowCount INT OUTPUT',
                    @name, @IsManage, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
            
        --��ȡÿҳ����
        SET @sql = 'SELECT a.*
		FROM (SELECT ROW_NUMBER() OVER(ORDER BY IsYDL DESC,Name) AS RowNumber, 
			Id,
			Name ,
			HeadUrl ,
			Introduce,
			SiteUrl,
			Phone ,
			Address,
			CreatorId,
			CreateDate,
			IsStop,
			WeiXin,
			AdminId,
			AlipayId,
			IsManage ,
			IsYDL
		FROM Company'+@whereSql
			

        SET @sql = @sql
            + ') a 
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'
	
        EXEC SP_EXECUTESQL @sql,
            N'@name NVARCHAR(50),@IsManage BIT,@pageIndex INT,@pageSize INT',
            @name, @IsManage, @pageIndex, @pageSize
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetContactCategoryList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetContactCategoryList] @userId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  '016002' AS Id ,
                '�ҵľ��ֲ�' AS Name ,
                ( SELECT    COUNT(*)
                  FROM      dbo.Club b
                  WHERE     EXISTS ( SELECT *
                                     FROM   dbo.ClubUser c
                                     WHERE  c.ClubId = b.Id
                                            AND UserId = @userId )
                ) AS Number

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetDynamicVenueBill]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- ���������ڣ���̬ͳ�Ʋ鿴���ݵ�δ�����ѣ��Ѹ�����
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetDynamicVenueBill]
    @cityId NVARCHAR(50) ,--��ѡ����
    @venueId NVARCHAR(50) ,--��ѡ����
    @beginDate DATETIME ,
    @endDate DATETIME
AS
    BEGIN
        SET NOCOUNT ON

        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
        SELECT  b.Id AS Id ,
                @beginDate AS BeginDate ,
                @endDate AS EndDate ,
                dbo.fn_Link(B.Id, B.Name) AS VenueId ,
                NoPayAmount ,
                PayAmount
        FROM    ( SELECT    VenueId ,
                            SUM(CASE WHEN PayState = ''024001'' THEN TotalAmount
                                     ELSE 0
                                END) AS NoPayAmount ,
                            SUM(CASE WHEN PayState = ''024002'' THEN Amount
                                     ELSE 0
                                END) AS PayAmount
                  FROM      dbo.VipUse WHERE 1=1 '
        IF ISNULL(@cityId, '') != ''
            SET @sql = @sql + ' AND CityId = @cityId'

        IF ISNULL(@venueId, '') != ''
            SET @sql = @sql + ' AND VenueId = @venueId'

        SET @sql = @sql
            + ' AND CONVERT(NVARCHAR(10),CreateDate,120) BETWEEN CONVERT(NVARCHAR(10),@beginDate,120) AND CONVERT(NVARCHAR(10),@endDate,120)
                  GROUP BY  VenueId
                ) a
                JOIN dbo.Venue b ON b.Id = A.VenueId'

        EXEC SP_EXECUTESQL @sql,
            N'@cityId NVARCHAR(50),@venueId NVARCHAR(50),@beginDate DATETIME,@endDate DATETIME',
            @cityId, @venueId, @beginDate, @endDate
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetGame]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetGame]
    @userId NVARCHAR(50) ,
    @gameId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                a.Name ,
                a.HeadUrl ,
                a.Introduce ,
                a.SportId ,
                a.Prize ,
                a.isTop ,
                a.GameRule ,
                a.IsTeam ,
                dbo.fn_Link(m.Id, m.Name) AS TeamMode ,
                a.IsLevelGame ,
                a.LevelValue ,
                B.LevelValue AS ClubLevelValue ,
                dbo.fn_Link(b.Id, b.Name) AS ClubId ,
                dbo.fn_Link(n.Id, n.Name) AS NameOption ,
                dbo.fn_Link(bat.Id, bat.Name) AS BattleStyle ,
                a.BattleStyleCount ,
                dbo.fn_Link(K.Id, K.Name) AS KnockoutOption ,
                a.IsKnockOutAB ,
                dbo.fn_Link(e.Id, e.Name) AS VenueId ,
                e.Address AS VenueAddress ,
                a.Cost ,
                a.RegBeginTime ,
                a.RegEndTime ,
                a.PlayBeginTime ,
                a.PlayEndTime ,
                dbo.fn_GetUserLinkName(a.NameOption, A.CreatorId,
                                       dbo.fn_GetUserPetName(a.CreatorId,
                                                             a.ClubId),
                                       g.CardName) AS CreatorId ,
                g.Mobile AS CreatorMobile ,
                a.CreateDate ,
                dbo.fn_Link(h.Id, h.Name) AS [State] ,
                dbo.fn_Link(j.Id, j.Name) AS CityId ,
                a.IsScoreGame ,
                a.BeginScore ,
                a.EndScore ,
                Organizer ,
                SecondOrganizer ,
                CASE WHEN i.Id IS NULL THEN 0
                     ELSE 1
                END AS IsGameJoined ,
                ( SELECT    COUNT(*)
                  FROM      GameTeam g
                  WHERE     g.GameId = a.Id
                ) AS TeamCount ,
                ( SELECT    COUNT(*)
                  FROM      dbo.ClubUser m
                  WHERE     m.ClubId = a.ClubId
                            AND m.UserId = @userId
                ) AS IsClubJoined ,
                dbo.fn_GetUserPetName(@userId, a.ClubId) AS CurrentPetName ,
                dbo.fn_GetReplyCount(a.Id) AS ReplyCount ,
                dbo.fn_Link(l.Id, l.Name) AS [State]
        FROM    Game a
                LEFT JOIN Club b ON a.ClubId = b.Id
                LEFT JOIN Venue e ON a.VenueId = e.Id
                LEFT JOIN UserAccount g ON a.CreatorId = g.Id
                LEFT JOIN BaseData h ON a.[State] = h.Id
                LEFT JOIN BaseData bat ON a.BattleStyle = bat.Id
                LEFT JOIN BaseData k ON a.KnockoutOption = K.Id
                LEFT JOIN BaseData n ON a.NameOption = n.Id
                LEFT JOIN BaseData m ON m.Id = a.TeamMode
                LEFT JOIN GameTeam i ON a.Id = i.GameId
                                        AND i.CreatorId = @userId
                LEFT JOIN City j ON a.CityId = j.Id
                LEFT JOIN BaseData l ON a.[State] = l.Id
        WHERE   a.Id = @gameId
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameGroupList]
    @gameId NVARCHAR(50) ,
    @groupId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@gameId, '') != ''
            SET @filter = @filter + ' AND a.GameId = @gameId'

        IF ISNULL(@groupId, '') != ''
            SET @filter = @filter + ' AND a.Id = @groupId'
              
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = 'SELECT  a.Id ,
                a.GameId ,
                a.OrderId ,
                a.IsTeam ,
                a.OrderNo ,
                a.Name ,
                dbo.fn_Link(b.Id, b.PetName) AS LeaderId ,
                a.TableNo ,
                a.CreateDate
        FROM    dbo.GameGroup a
                LEFT JOIN dbo.UserAccount b ON b.Id = a.LeaderId
        WHERE   1 = 1 ' + @filter + ' ORDER BY a.OrderNo'                  
                    
        EXEC SP_EXECUTESQL @sql,
            N'@gameId NVARCHAR(50),@groupId NVARCHAR(50) OUTPUT', @gameId,
            @groupId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupLoopList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameGroupLoopList]
    @groupId NVARCHAR(50) 
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT  a.Id ,
                a.GroupId ,
                dbo.fn_Link(b1.Id, b1.TeamName) AS Team1Id ,
                dbo.fn_Link(b2.Id, b2.TeamName) AS Team2Id ,
                b1.HeadUrl AS Team1HeadUrl ,
                b2.HeadUrl AS Team2HeadUrl ,
                a.IsTeam ,
                dbo.fn_GetGameTeamScore(a.Id, 1) AS Team1 ,
                dbo.fn_GetGameTeamScore(a.Id, 0) AS Team2 ,
                Game1 ,
                Game2 ,
                a.WinSign ,
                a.JudgeSign ,
                dbo.fn_Link(c.Id, c.Name) AS State ,
                a.WaiverOption ,
                o.WinTeam ,
                a.IsKnock ,
                a.KnockLoopId ,
                o.WinGame
        FROM    dbo.GameLoop a
                INNER JOIN dbo.GameOrder o ON o.Id = a.OrderId
                LEFT JOIN dbo.GameTeam b1 ON Team1Id = b1.Id
                LEFT JOIN dbo.GameTeam b2 ON Team2Id = b2.Id
                LEFT JOIN dbo.BaseData c ON a.State = c.Id
        WHERE   a.GroupId = @groupId
        ORDER BY a.GroupId ,
                a.OrderNo ,
                a.LoopOrderNo
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupMemberList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameGroupMemberList]
    @gameId NVARCHAR(50) ,
    @groupId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
        SET @sql = 'SELECT  a.Id ,
                a.GameId ,
				a.OrderNo,
                a.GroupId ,
                dbo.fn_Link(b.Id , b.TeamName) AS TeamId,
				b.IsSeed,
				b.SeedNo,
                a.IsTeam ,
                a.GroupScore ,
				a.Rate,
				a.RateRemark,
                a.Rank ,
                a.Remark ,
				b.HeadUrl AS TeamHeadUrl,
				c.LevelValue,
				g.ClubId,
                a.CreateDate,
				b.TeamUserId,
				b.TeamUserName
        FROM    GameGroupMember a
                INNER JOIN dbo.GameTeam b ON a.TeamId = b.Id 
				INNER JOIN Game g ON a.GameId = g.Id
			    LEFT JOIN ClubUser c ON c.ClubId=g.ClubId AND c.UserId=b.TeamUserId 
		WHERE a.GameId=@gameId'

        IF ISNULL(@groupId, '') != ''
            SET @sql = @sql + ' AND a.GroupId = @groupId'

        SET @sql = @sql + ' ORDER BY a.OrderNo,a.CreateDate'

        EXEC SP_EXECUTESQL @sql, N'@gameId NVARCHAR(50),@groupId NVARCHAR(50)',
            @gameId, @groupId
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupRankList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameGroupRankList]
    @gameId NVARCHAR(50) ,
    @beginRank INT ,
    @endRank INT
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                dbo.fn_Link(b.Id, B.Name) AS GroupId ,
                dbo.fn_Link(c.Id, c.TeamName) AS TeamId ,
                a.Rank
        FROM    dbo.GameGroupMember a
                JOIN dbo.GameGroup b ON b.Id = a.GroupId
                JOIN dbo.GameTeam c ON c.Id = a.TeamId
        WHERE   a.GameId = @gameId
                AND a.Rank BETWEEN @beginRank AND @endRank
        ORDER BY b.OrderNo ,
                a.Rank

    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameJudgeList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameJudgeList] @gameId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                a.GameId ,
				b.HeadUrl,
				dbo.fn_GetUserLinkName(g.NameOption, a.UserId,
                                       dbo.fn_GetUserPetName(a.UserId,
                                                             g.ClubId),
                                       b.CardName) AS UserId ,
                b.Mobile
        FROM    GameJudge a
		        INNER JOIN dbo.Game g ON g.Id=a.GameId
                INNER JOIN dbo.UserAccount b ON b.Id = a.UserId
        WHERE   a.GameId = @gameId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameJudgeLoopList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameJudgeLoopList]
    @gameId NVARCHAR(50) ,
    @orderId NVARCHAR(50) ,
    @judgeId NVARCHAR(50) ,
    @isNotFinish BIT
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
        SELECT  a.Id ,
                dbo.fn_Link(b1.Id, b1.TeamName) AS Team1Id ,
                dbo.fn_Link(b2.Id, b2.TeamName) AS Team2Id ,
				b1.HeadUrl AS Team1HeadUrl,
				b2.HeadUrl AS Team2HeadUrl,
                a.OrderNo ,
                a.IsTeam ,
                Team1 ,
                Team2 ,
                Game1 ,
                Game2 ,
                a.IsExtra ,
                a.Remark ,
                o.Name AS OrderName ,
                g.Name AS GroupName ,
                dbo.fn_Link(c.Id, c.Name) AS State ,
                a.WaiverOption ,
				a.WinSign,
				a.JudgeSign,
                a.BeginTime ,
                a.TableNo ,
                dbo.fn_Link(u.Id, u.CardName) AS JudgeId,
				dbo.fn_Link(u1.Id, u1.CardName) AS MasterJudgeId,
				o.WinTeam,
				o.WinGame,
				a.IsKnock,
				a.KnockLoopId,
				ISNULL(x.TeamMode,''021001'') AS TeamMode
        FROM    dbo.GameLoop a
				INNER JOIN dbo.Game x ON x.Id = a.GameId
                INNER JOIN dbo.GameOrder o ON o.Id = a.OrderId
                LEFT JOIN dbo.GameTeam b1 ON Team1Id = b1.Id
                LEFT JOIN dbo.GameTeam b2 ON Team2Id = b2.Id
                LEFT JOIN dbo.BaseData c ON a.State = c.Id
                LEFT JOIN dbo.GameGroup g ON g.Id = a.GroupId
                LEFT JOIN dbo.UserAccount u ON u.Id = a.JudgeId
				LEFT JOIN dbo.UserAccount u1 ON u1.Id = a.MasterJudgeId
        WHERE   a.GameId = @gameId
                AND a.JudgeId = @judgeId
				--�ų�С���ֿյı�������̭���ֿ��ɲ��д���
                AND ( o.KnockoutOption = ''014002''
                      AND a.IsBye = 0
                      OR o.KnockoutOption = ''014001''
                    )'

        IF @isNotFinish = 1
            SET @sql = @sql + ' AND a.State!=''011003'' '

        IF ISNULL(@orderId, '') != ''
            SET @sql = @sql + ' AND a.OrderId=@orderId '

        SET @sql = @sql + ' ORDER BY a.BeginTime,o.OrderNo ,
                g.OrderNo ,
                a.IsExtra ,
                a.OrderNo,a.LoopOrderNo'

        EXEC SP_EXECUTESQL @sql,
            N'@gameId NVARCHAR(50),@orderId NVARCHAR(50),@judgeId NVARCHAR(50)',
            @gameId, @orderId, @judgeId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameKnockLoopList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameKnockLoopList]
    @gameId NVARCHAR(50) ,
    @knockOutAB NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;
        
        SELECT  a.Id ,
                a.OrderNo ,
                a.GameId ,
                a.OrderId ,
                b.KnockOutAB ,
                a.IsTeam ,
                a.IsKnock ,
                a.KnockLoopId ,
                dbo.fn_Link(b1.Id, b1.TeamName) AS Team1Id ,
                dbo.fn_Link(b2.Id, b2.TeamName) AS Team2Id ,
                CASE WHEN a.IsTeam = 1 THEN Team1
                     ELSE Game1
                END AS Game1 ,
                CASE WHEN a.IsTeam = 1 THEN Team2
                     ELSE Game2
                END AS Game2 ,
                IsBye ,
                WaiverOption ,
                a.State
        FROM    dbo.GameLoop a
                JOIN dbo.GameOrder b ON b.Id = a.OrderId
                LEFT JOIN dbo.GameTeam b1 ON b1.Id = A.Team1Id
                LEFT JOIN dbo.GameTeam b2 ON b2.Id = A.Team2Id
        WHERE   a.GameId = @gameId
		        AND b.KnockOutAB=@knockOutAB
                AND KnockoutOption = '014001'
                AND ISNULL(GroupId, '') = ''
                AND a.IsExtra = 0
        ORDER BY b.OrderNo ,
                a.OrderNo
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_GetGameList]
    @gameName NVARCHAR(200) ,
    @clubId NVARCHAR(50) ,
    @cityId NVARCHAR(50) ,
    @isOnlySelf BIT ,
    @userId NVARCHAR(50) ,
    @state NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@clubId, '') != ''
            SET @filter = @filter + ' AND a.ClubId = @clubId'

        IF ISNULL(@cityId, '') != ''
            SET @filter = @filter + ' AND a.CityId = @cityId'
                    
        IF ISNULL(@gameName, '') != ''
            SET @filter = @filter + ' AND a.Name LIKE ''%''+@gameName+''%'''

        IF ISNULL(@state, '') != ''
            SET @filter = @filter + ' AND CHARINDEX(a.State,@state)>0'
                        
        IF @isOnlySelf = 1
            SET @filter = @filter
                + ' AND EXISTS(SELECT * FROM GameTeam u WHERE u.GameId=a.Id AND (u.CreatorId=@userId OR CHARINDEX(@userId,TeamUserId)>0))'

		--�Ǿ��ֲ���Ա���ܿ���δ������ֲ�����
        SET @filter = @filter
            + ' AND (ISNULL(a.ClubId,'''')='''' OR ISNULL(a.ClubId,'''')!='''' AND EXISTS(SELECT * FROM dbo.ClubUser x WHERE x.ClubId=a.ClubId AND x.UserId=@userId))'

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(Id) FROM Game a WHERE a.State!=''015009'''
                    + @filter                    
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@ClubId NVARCHAR(50),@cityId NVARCHAR(50),@gameName NVARCHAR(50),@state NVARCHAR(50),@userId NVARCHAR(50),@rowCount INT OUTPUT',
                    @clubId, @cityId, @gameName, @state,@userId, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = 'SELECT a.Id,a.Name,dbo.fn_Link(e.Id,e.Name) AS BattleStyle,IsTeam,a.SportId,dbo.fn_Link(b.Id,b.Name) AS ClubId,IsScoreGame,
						a.HeadUrl,a.RegBeginTime,a.RegEndTime,a.PlayBeginTime,a.PlayEndTime,dbo.fn_Link(c.Id,c.Name) AS VenueId,a.CreatorId,
						dbo.fn_Link(d.Id,d.Name) AS State,Cost,KnockoutOption,NameOption,IsKnockOutAB,
						dbo.fn_GetReplyCount(a.Id) AS ReplyCount,
						dbo.fn_Link(g.Id,g.Name) AS CityId,a.Organizer
					FROM Game a
						LEFT JOIN Club b ON a.ClubId=b.Id
						LEFT JOIN City g ON a.CityId=g.Id
						LEFT JOIN Venue c ON a.VenueId=c.Id
						LEFT JOIN BaseData d ON a.State = d.Id
						LEFT JOIN BaseData e ON a.BattleStyle = e.Id
					WHERE a.State!=''015009'' '+@filter+'
					ORDER BY PlayBeginTime DESC 
						OFFSET (@pageIndex-1)*@pageSize ROWS FETCH NEXT @pageSize ROWS ONLY '
	
        EXEC SP_EXECUTESQL @sql,
            N'@clubId NVARCHAR(50),@cityId NVARCHAR(50),@gameName NVARCHAR(50),@state NVARCHAR(50),@userId NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @clubId, @cityId, @gameName, @state,@userId, @pageIndex, @pageSize

		
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopDetailList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameLoopDetailList]
    @loopId NVARCHAR(50) ,
    @mapId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
        SET @sql = 'SELECT * FROM GameLoopDetail WHERE LoopId=@loopId '

        IF ISNULL(@mapId, '') != ''
            SET @sql = @sql + ' AND MapId=@mapId '
		
        SET @sql = @sql + ' ORDER BY OrderNo'
	
        EXEC SP_EXECUTESQL @sql, N'@loopId NVARCHAR(50),@mapId NVARCHAR(50)',
            @loopId, @mapId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_GetGameLoopList]
    @gameId NVARCHAR(200) ,
    @teamName NVARCHAR(50) ,
    @tableNo INT ,
    @state NVARCHAR(50) ,
    @beginTime NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@gameId, '') != ''
            SET @filter = @filter + ' AND a.GameId = @gameId'

        IF ISNULL(@tableNo, 0) != 0
            SET @filter = @filter + ' AND a.TableNo = @tableNo'
                    
        IF ISNULL(@teamName, '') != ''
            SET @filter = @filter
                + ' AND b.TeamName+c.TeamName LIKE ''%''+@teamName+''%'''

        IF ISNULL(@state, '') != ''
            SET @filter = @filter + ' AND CHARINDEX(a.State,@state)>0'

        IF ISNULL(@beginTime, '') != ''
            SET @filter = @filter + ' AND a.BeginTime<=@beginTime'

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) 
				FROM  dbo.GameLoop a
				JOIN dbo.GameTeam b ON b.Id = a.Team1Id
				JOIN dbo.GameTeam c ON c.Id = a.Team2Id
				WHERE   1 = 1 ' + @filter                    
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@gameId NVARCHAR(50),@beginTime NVARCHAR(50),@teamName NVARCHAR(50),@tableNo INT,@state NVARCHAR(50),@rowCount INT OUTPUT',
                    @gameId, @beginTime, @teamName, @tableNo, @state,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = 'SELECT  a.Id ,
						dbo.fn_Link(b.Id, b.TeamName) AS Team1Id ,
						dbo.fn_Link(c.Id, c.TeamName) AS Team2Id ,
						TableNo ,
						dbo.fn_Link(d.Id, d.CardName) AS JudgeId ,
						dbo.fn_Link(e.Id, e.CardName) AS MasterJudgeId,
						BeginTime,
						a.Game1 ,
						a.Game2 ,
						a.IsTeam,
						a.IsBye,
						dbo.fn_Link(f.Id,f.Name) AS State,
						a.BeginTime
					FROM    dbo.GameLoop a
						JOIN dbo.GameTeam b ON b.Id = a.Team1Id
						JOIN dbo.GameTeam c ON c.Id = a.Team2Id
						LEFT JOIN dbo.UserAccount d ON d.Id = a.JudgeId
						LEFT JOIN dbo.UserAccount e ON e.Id = a.MasterJudgeId
						LEFT JOIN dbo.BaseData f ON f.Id = a.State 
					WHERE   1 = 1 ' + @filter
            + ' ORDER BY a.BeginTime,a.OrderNo 
				 OFFSET (@pageIndex-1)*@pageSize ROWS FETCH NEXT @pageSize ROWS ONLY '
	
        EXEC SP_EXECUTESQL @sql,
            N'@gameId NVARCHAR(50),@beginTime NVARCHAR(50),@teamName NVARCHAR(50),@tableNo INT,@state NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @gameId, @beginTime, @teamName, @tableNo, @state, @pageIndex,
            @pageSize

		
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopMapList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameLoopMapList] @loopId NVARCHAR(50)
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT  A.Id ,
                A.LoopId ,
                A.OrderNo ,
                A.IsTeam ,
                A.Team1Id ,
                A.User1Id ,
                A.User1Name ,
                A.Team2Id ,
                A.User2Id ,
                A.User2Name ,
                A.Game1 ,
                A.Game2 ,
                A.Fen1 ,
                A.Fen2 ,
                A.CreateDate ,
                A.WaiverOption ,
                a.JudgeSign ,
                a.WinSign ,
                C.WinTeam ,
                CASE WHEN A.WinGame > 0 THEN A.WinGame
                     ELSE C.WinGame
                END AS WinGame
        FROM    GameLoopMap A
                JOIN dbo.GameLoop B ON A.LoopId = B.Id
                JOIN dbo.GameOrder C ON B.OrderId = C.Id
        WHERE   LoopId = @loopId
        ORDER BY OrderNo

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameMyLoopList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameMyLoopList]
    @gameId NVARCHAR(50) ,
    @userId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @gameState NVARCHAR(50)
        SELECT  @gameState = State
        FROM    dbo.Game
        WHERE   Id = @gameId
		--���б��������������׶Σ������Լ���صı���
        IF @gameState IN ( '015004', '015005' )
            SELECT  a.Id ,
                    dbo.fn_Link(b1.Id, b1.TeamName) AS Team1Id ,
                    dbo.fn_Link(b2.Id, b2.TeamName) AS Team2Id ,
                    b1.HeadUrl AS Team1HeadUrl ,
                    b2.HeadUrl AS Team2HeadUrl ,
                    a.IsTeam ,
                    a.IsExtra ,
                    dbo.fn_GetGameTeamScore(a.Id,1) AS  Team1 ,
                    dbo.fn_GetGameTeamScore(a.Id,0) AS  Team2 ,
                    Game1 ,
                    Game2 ,
                    o.Name AS OrderName ,
                    g.Name AS GroupName ,
                    dbo.fn_Link(c.Id, c.Name) AS State ,
                    a.WaiverOption ,
                    a.WinSign ,
                    a.JudgeSign ,
                    a.BeginTime ,
                    a.TableNo ,
                    dbo.fn_Link(u.Id, u.CardName) AS JudgeId ,
                    dbo.fn_Link(u1.Id, u1.CardName) AS MasterJudgeId ,
                    b1.CreatorId AS Team1CreatorId ,
                    b2.CreatorId AS Team2CreatorId ,
                    a.IsKnock ,
                    a.KnockLoopId ,
                    o.WinGame ,
                    o.WinTeam
            FROM    dbo.GameLoop a
                    LEFT JOIN dbo.GameOrder o ON o.Id = a.OrderId
                    LEFT JOIN dbo.GameTeam b1 ON Team1Id = b1.Id
                    LEFT JOIN dbo.GameTeam b2 ON Team2Id = b2.Id
                    LEFT JOIN dbo.BaseData c ON a.State = c.Id
                    LEFT JOIN dbo.GameGroup g ON g.Id = a.GroupId
                    LEFT JOIN dbo.UserAccount u ON u.Id = a.JudgeId
                    LEFT JOIN dbo.UserAccount u1 ON u1.Id = a.MasterJudgeId
            WHERE   a.GameId = @gameId
                    AND ( CHARINDEX(@userId, b1.TeamUserId) > 0
                          OR CHARINDEX(@userId, b2.TeamUserId) > 0
                        )
            ORDER BY o.OrderNo ,
                    g.OrderNo ,
                    a.IsExtra ,
                    a.OrderNo ,
                    a.LoopOrderNo
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameOrderList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameOrderList] @gameId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                a.GameId ,
                a.BeginRank ,
                a.EndRank ,
                a.PreOrderId ,
                a.NextOrderId ,
				a.NextOrderBId,
                a.OrderNo ,
                a.Name ,
                a.IsTeam ,
				dbo.fn_Link(b.Id,b.Name) AS TeamScoreMode,
				a.KnockOutAB,
                a.KnockoutOption ,
                a.KnockoutCount ,
                a.KnockoutTotal ,
                a.GroupCount ,
                a.CreateDate ,
                a.State ,
                a.IsExtra ,
                a.WinTeam ,
                a.WinGame
        FROM    GameOrder a LEFT JOIN dbo.BaseData b ON b.Id = a.TeamScoreMode
        WHERE   a.GameId = @gameId
        ORDER BY OrderNo
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameOrderLoopList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameOrderLoopList]
    @gameId NVARCHAR(50) ,
    @knockOutAB NVARCHAR(50) ,
    @orderId NVARCHAR(50) ,
    @groupId NVARCHAR(50) ,
    @isExtra NVARCHAR(50) ,
    @groupOrderNo INT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)

        SET @sql = 'SELECT  a.Id ,
                a.GameId ,
				dbo.fn_Link(b.Id,b.Name) AS GroupId,
                a.OrderId ,
                a.OrderNo ,
				dbo.fn_Link(t1.Id,t1.TeamName) AS Team1Id,
				dbo.fn_Link(t2.Id,t2.TeamName) AS Team2Id,
				t1.HeadUrl AS Team1HeadUrl,
				t2.HeadUrl AS Team2HeadUrl,
                dbo.fn_GetGameTeamScore(a.Id,1) AS  Team1 ,
                dbo.fn_GetGameTeamScore(a.Id,0) AS  Team2 ,
                a.Game1 ,
                a.Game2 ,
				a.IsTeam,
				dbo.fn_Link(c.Id,c.Name) AS State,
                a.IsBye,
				a.Remark,
				a.IsExtra,
				a.WaiverOption,
				a.WinSign,
				a.JudgeSign,
			    a.BeginTime,
				a.TableNo,
				dbo.fn_Link(u.Id,u.CardName) AS JudgeId,
				dbo.fn_Link(u1.Id,u1.CardName) AS MasterJudgeId,
				o.WinTeam,
				o.WinGame,
				a.IsKnock,
				a.KnockLoopId,
				ISNULL(x.TeamMode,''021001'') AS TeamMode
        FROM    dbo.GameLoop a
		        INNER JOIN dbo.Game x ON x.Id = a.GameId
				INNER JOIN dbo.GameOrder o ON o.Id = a.OrderId
                LEFT JOIN dbo.GameGroup b ON b.Id = a.GroupId
                LEFT JOIN dbo.GameTeam t1 ON t1.Id = a.Team1Id
                LEFT JOIN dbo.GameTeam t2 ON t2.Id = a.Team2Id
                LEFT JOIN dbo.BaseData c ON c.Id = a.State 
				LEFT JOIN dbo.UserAccount u ON u.Id = a.JudgeId 
				LEFT JOIN dbo.UserAccount u1 ON u1.Id = a.MasterJudgeId 
		WHERE   1=1 '

        IF ISNULL(@gameId, '') != ''
            SET @sql = @sql + ' AND a.GameId=@gameId'

        IF @groupOrderNo > 0
            SET @sql = @sql + ' AND b.OrderNo=@groupOrderNo'

        IF ISNULL(@groupId, '') != ''
            SET @sql = @sql + ' AND a.GroupId=@groupId'

        IF ISNULL(@knockOutAB, '') != ''
            SET @sql = @sql + ' AND o.KnockOutAB=@knockOutAB'

        IF ISNULL(@orderId, '') != ''
            SET @sql = @sql + ' AND a.OrderId = @orderId'

        IF ISNULL(@isExtra, '') != ''
            SET @sql = @sql + ' AND a.IsExtra = ' + @isExtra

        SET @sql = @sql
            + ' ORDER BY a.IsExtra,a.ExtraOrder, a.OrderId , b.OrderNo,a.OrderNo,a.LoopOrderNo'

        EXEC SP_EXECUTESQL @sql,
            N'@orderId NVARCHAR(50),@knockOutAB NVARCHAR(50),@gameId NVARCHAR(50),@groupId NVARCHAR(50),@groupOrderNo INT',
            @orderId, @knockOutAB,@gameId, @groupId, @groupOrderNo
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameProgress]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameProgress] @id NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  @id AS Id ,
                d.KnockOutAB ,
                d.Name AS OrderName ,
                e.Name AS GroupName ,
                c.OrderId ,
                c.GroupId ,
                c.Finish ,
                c.Total ,
                c.Total - c.Finish AS NotFinish
        FROM    ( SELECT    a.OrderId ,
                            a.GroupId ,
                            COUNT(*) AS Total ,
                            SUM(CASE WHEN a.State = '011003' THEN 1
                                     ELSE 0
                                END) AS Finish
                  FROM      dbo.GameLoop a
                  WHERE     GameId = @id
                  GROUP BY  OrderId ,
                            GroupId
                ) c
                JOIN dbo.GameOrder d ON d.Id = c.OrderId
                LEFT JOIN dbo.GameGroup e ON e.Id = c.GroupId
        ORDER BY d.OrderNo ,
                e.OrderNo
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameRankList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		sxd
-- Create date: 2015-11-18
-- Description:	��ȡ�����������б�
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameRankList]
    @gameId NVARCHAR(50) ,
    @knockOutAB NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
        
        DECLARE @sql NVARCHAR(MAX)
		
		--ȫ��������������ʾ����
        DECLARE @notFinishCount INT
        SELECT  @notFinishCount = COUNT(*)
        FROM    dbo.GameLoop a
                JOIN dbo.GameOrder b ON b.Id = a.OrderId
        WHERE   a.GameId = @gameId
                AND ISNULL(a.State, '') != '011003'
                AND ISNULL(b.KnockOutAB, 'A') = @knockOutAB
		--��ȡ����
        IF @notFinishCount = 0
            BEGIN
				DECLARE @gameKnockout NVARCHAR(50)
				SELECT @gameKnockout=KnockoutOption FROM dbo.Game WHERE Id=@gameId

                SELECT  Id ,
                        TeamName ,
                        dbo.fn_GetFinalRank(@gameId, a.Id,@gameKnockout) AS FinalRank
                FROM    dbo.GameTeam a
                WHERE   EXISTS ( SELECT *
                                 FROM   dbo.GameLoop b
                                        JOIN dbo.GameOrder c ON c.Id = b.OrderId
                                 WHERE  b.GameId = @gameId
                                        AND ISNULL(c.KnockOutAB, 'A') = @knockOutAB
                                        AND ISNULL(b.GroupId, '') = ''
                                        AND ( b.Team1Id = a.Id
                                              OR b.Team2Id = a.Id
                                            ) )
                ORDER BY dbo.fn_GetFinalRank(@gameId, a.Id,@gameKnockout)
            END	
        ELSE
            SET @message = '������δ�������޷�������';
        
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTableList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetGameTableList]
    @gameId NVARCHAR(50) ,
    @beginTime DATETIME
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.GameId AS Id ,
                a.TableNo AS No ,
                CASE WHEN EXISTS ( SELECT   *
                                   FROM     dbo.GameLoop b
                                   WHERE    b.GameId = a.GameId
                                            AND State != '011003'
                                            AND BeginTime <= @beginTime
                                            AND b.TableNo = a.TableNo )
                     THEN CAST(0 AS BIT)
                     ELSE CAST(1 AS BIT)
                END AS IsEmpty
        FROM    dbo.GameLoop a
        WHERE   a.GameId = @gameId
                AND a.TableNo > 0
        GROUP BY a.GameId ,
                a.TableNo

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeam]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		sxd
-- Create date: 2015-11-18
-- Description:	��ȡ������������������Ϣ
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameTeam] @TeamId NVARCHAR(500)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                a.GameId ,
                a.HeadUrl ,
                a.IsTeam ,
                a.TeamName ,
                a.TeamUserId ,
                a.TeamUserName ,
                a.Remark ,
                g.Cost ,
                dbo.fn_Link(d.Id, d.Name) AS State ,
                dbo.fn_Link(b.Id, b.CardName) AS CreatorId ,
				dbo.fn_Link(C.Id, C.Name) AS CompanyId ,
                a.MobilePhone ,
                a.CorpTeamId ,
                a.CorpTeamName ,
                a.CreateDate
        FROM    GameTeam a
                INNER JOIN dbo.Game g ON g.Id = a.GameId
                INNER JOIN UserAccount b ON a.CreatorId = b.Id
                INNER JOIN BaseData d ON a.State = d.Id
				LEFT JOIN dbo.Company c ON c.Id = a.CompanyId
        WHERE   CHARINDEX(a.Id, @TeamId) > 0
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeamList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		sxd
-- Create date: 2015-11-18
-- Description:	��ȡ�����������б�
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameTeamList]
    @gameId NVARCHAR(50) ,
    @state NVARCHAR(50) ,
    @teamName NVARCHAR(50) ,
    @onlyNotGroup BIT ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
        
        DECLARE @sql NVARCHAR(MAX)

        --������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM GameTeam a WHERE GameId=@gameId'
                
                IF ISNULL(@state, '') != ''
                    SET @sql = @sql + ' AND State = @state'   
					
                IF ISNULL(@teamName, '') != ''
                    SET @sql = @sql + ' AND TeamName LIKE ''%' + @teamName
                        + '%'''

                IF @onlyNotGroup = 1
                    SET @sql = @sql
                        + ' AND NOT EXISTS(SELECT * FROM GameGroupMember b WHERE b.GameId=@gameId AND b.TeamId=a.Id)'                  
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@gameId NVARCHAR(50),@state NVARCHAR(50),@teamName NVARCHAR(50),@rowCount INT OUTPUT',
                    @gameId, @state, @teamName, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--ȫ��������������ʾ����
        DECLARE @notFinishCount INT
        SELECT  @notFinishCount = COUNT(*)
        FROM    dbo.GameLoop
        WHERE   GameId = @gameId
                AND ISNULL(State, '') != '011003'
		--��ҳȡ����	
        SET @sql = 'SELECT a.RowNumber,
		                a.HeadUrl,
						a.SeedNo,
						a.Id,
						a.GameId,
						a.IsSeed,
						a.IsJoined,
						a.IsTeam,
						a.TeamName,
						a.TeamUserId,
						a.TeamUserName,
						a.Remark,
						a.CorpTeamId,
						a.CorpTeamName,
						c.LevelValue,
						x.Score AS SportScore,
						g.ClubId,
						dbo.fn_Link(d.Id, d.Name) AS State,
						dbo.fn_GetUserLinkName(g.NameOption,a.CreatorId,dbo.fn_GetUserPetName(a.CreatorId,g.ClubId),b.CardName) AS CreatorId,
						dbo.fn_Link(m.Id, m.Name) AS CompanyId ,
						a.CreateDate,
						a.MobilePhone
					FROM (SELECT ROW_NUMBER() OVER(ORDER BY State,CreateDate,TeamName) AS RowNumber,
								Id,
								HeadUrl,
								GameId,
								IsSeed,
								IsTeam,
								TeamName,
								TeamUserId,
								TeamUserName,
								Remark,
								IsJoined,
								State,
								CreatorId,
								CreateDate,
								MobilePhone,
								CorpTeamId,
								CorpTeamName,
								CompanyId,
								e.SeedNo	
							FROM GameTeam e WHERE GameId=@gameId'
			
        IF ISNULL(@state, '') != ''
            SET @sql = @sql + ' AND State = @state'   

        IF ISNULL(@teamName, '') != ''
            SET @sql = @sql + ' AND TeamName LIKE ''%' + @teamName + '%'''

        IF @onlyNotGroup = 1
            SET @sql = @sql
                + ' AND NOT EXISTS(SELECT * FROM GameGroupMember f WHERE f.GameId=@gameId AND f.TeamId=e.Id)'  
            	
        SET @sql = @sql
            + ' ) a 
			INNER JOIN UserAccount b ON a.CreatorId=b.Id
			INNER JOIN BaseData d ON a.State = d.Id
			INNER JOIN Game g ON a.GameId = g.Id
			LEFT JOIN ClubUser c ON c.ClubId=g.ClubId AND c.UserId=a.TeamUserId
			LEFT JOIN dbo.Company m ON m.Id = a.CompanyId
			LEFT JOIN UserSport x ON x.UserId=a.TeamUserId AND x.SportId=g.SportId
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize '

        EXEC SP_EXECUTESQL @sql,
            N'@gameId NVARCHAR(50),@state NVARCHAR(50),@teamName NVARCHAR(50),@notFinishCount INT,@pageIndex INT,@pageSize INT',
            @gameId, @state, @teamName, @notFinishCount, @pageIndex, @pageSize
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeamListForKnock]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		sxd
-- Create date: 2015-11-18
-- Description:	��ȡ�����������б�
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameTeamListForKnock] @gameId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;
        
        SELECT  Id ,
                TeamName ,
                IsSeed ,
                SeedNo
        FROM    dbo.GameTeam
        WHERE   GameId = @gameId
                AND State = '012002'
        ORDER BY IsSeed DESC ,
                SeedNo ,
                TeamName
		
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTopList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_GetGameTopList] @cityId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT TOP 5
                Id ,
                Name ,
                HeadUrl
        FROM    dbo.Game
        WHERE   CityId = @cityId
                AND IsTop = 1
        ORDER BY PlayBeginTime DESC

    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGeneralUserList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--��ȡһ���û� (�޳�����)
 CREATE PROCEDURE [dbo].[sp_GetGeneralUserList]
    @keywords NVARCHAR(50) ,--�ʺţ��ǳƣ��������ֻ�
    @isAdmin NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' AND IsAdmin=' + @isAdmin
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
                + ' AND (a.Code+a.PetName+a.CardName+ISNULL(a.Mobile,'''') LIKE ''%''+@keywords+''%'')'         

        DECLARE @sql NVARCHAR(MAX)

		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
				SELECT @rowCount=COUNT(a.Id) 
				FROM UserAccount a
				WHERE NOT EXISTS(SELECT * FROM dbo.Coach WHERE a.Id= Id)/*�޳�����*/

				'
                    + @filter              
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@keywords NVARCHAR(50),@rowCount INT OUTPUT', @keywords,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
					SELECT 
						Id,
						Code,
						PetName,
						CardName,
						HeadUrl,
						Sex,
						Mobile,
						Id AS userId
					FROM UserAccount a
					WHERE NOT EXISTS(SELECT * FROM dbo.Coach WHERE a.Id= Id)/*�޳�����*/
					' 
					+ @filter +' 
					ORDER BY PetName
					OFFSET (@pageIndex-1)*@pageSize ROWS 
					FETCH NEXT @pageSize ROWS ONLY 
					'

        EXEC SP_EXECUTESQL @sql,
            N'@keywords NVARCHAR(50),@pageIndex INT,@pageSize INT', @keywords,
            @pageIndex, @pageSize
		--PRINT @sql
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetMsgList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<��ȡ�ʼ��б�>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetMsgList]
    @userId NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Msg WHERE ReceiverId=@userId'			
                EXEC SP_EXECUTESQL @sql,
                    N'@userId NVARCHAR(50),@rowCount INT OUTPUT', @userId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = 'SELECT *
			FROM (
			SELECT  ROW_NUMBER() OVER ( ORDER BY n.CreateDate DESC ) AS RowNumber ,
				n.Title ,
				n.Content ,
				n.CreateDate
			FROM  Msg n
			WHERE n.ReceiverId=@userId '		
        SET @sql = @sql
            + ') a 
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize 
			ORDER BY CreateDate DESC'
	
        EXEC SP_EXECUTESQL @sql,
            N'@userId NVARCHAR(50),@pageIndex INT,@pageSize INT', @userId,
            @pageIndex, @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetNearbyTeachingPointList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetNearbyTeachingPointList]
    @userId NVARCHAR(50) ,
    @isOnlySelf NVARCHAR(50) ,
    @isUseVip NVARCHAR(50) ,
    @name NVARCHAR(50) ,
    @cityCode NVARCHAR(50) ,
	@curUserLng FLOAT,
	@curUserLat FLOAT,
	@isAll BIT , --�Ƿ񷵻�ȫ��, ��������˺�δ��˵�
	@state NVARCHAR(50)='',
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--ȡ�û�����Ա��־
        DECLARE @isAdmin BIT
        SELECT  @isAdmin = IsAdmin
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        IF @isAdmin IS NULL
            SET @isAdmin = 0

        --��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@name, '') != ''
            SET @filter = @filter + ' AND name LIKE ''%''+@name+''%'''
                        
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'  

        IF ISNULL(@isUseVip, '') != ''
            SET @filter = @filter + ' AND IsUseVip=1'  
		SET @filter = @filter + ' AND IsEnableTeachingPoint=1'  

        --�鿴�Լ�������ȫ�����ݻ�������ͨ����˵ĳ��ݣ�����Ա�鿴����   
        IF @isAdmin = 0
            BEGIN
                IF ISNULL(@isOnlySelf, '') = '1'
                    SET @filter = @filter
                        + ' AND (CreatorId=@userId OR AdminId=@userId 
						OR Id IN ( --���ѹ��ĳ���
									SELECT VenueId FROM VipUse WHERE PayState=''024002'' AND UserId=@userId)) '  
                ELSE IF @isAll !=1 --������ȫ��
				BEGIN
						IF  ISNULL(@state, '') != ''
							SET @filter = @filter + '  AND State='''+@state+''''  
						ELSE	
							SET @filter = @filter + '  AND State=''010002'''  --������ȫ��, Ĭ�Ϸ�������˵�

				END
			 
            END

		--��ȡ������
        DECLARE @sql NVARCHAR(MAX);
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(*) 
						FROM Venue WHERE 1=1'
                    + @filter
                EXEC SP_EXECUTESQL @sql,
                    N'@name NVARCHAR(50),@cityCode NVARCHAR(50),@userId NVARCHAR(50),@rowCount INT OUTPUT',
                    @name, @cityCode, @userId, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
            
        --��ȡÿҳ����
        SET @sql = '
			SELECT a.Id,a.Name,A.HeadUrl,
						dbo.fn_Link(b.Id,b.Name) AS CityId,
						a.Address,
						dbo.fn_GetReplyCount(a.Id) AS ReplyCount,
						dbo.fn_GetSignCount(a.Id) AS SignCount,
						a.IsUseVip,
						a.Balance,
						a.CreditLine,
						dbo.fn_Link(c.Id,c.Name) AS State ,
						dbo.fn_Link(s.Id, s.Name) AS SportId,
						AdminId,
						CreatorId,
						a.TableCount,
						a.UnitPrice,
						a.UnitType,
 						a.Distance,
						a.Lng,
						a.Lat,
						a.IsEnableTeachingPoint
			FROM (
					SELECT ROW_NUMBER() OVER(ORDER BY Distance) AS RowNumber,
						Id,
						CityId,
						Name,
						HeadUrl,
						Address,
						State,
						SportId,
						IsUseVip,
						CreditLine ,
						Balance,
						AdminId,
						CreatorId,
						TableCount,
						UnitPrice,
						UnitType,
						Distance,
						ISNULL(Lat,0) Lat,
						ISNULL(Lng,0) Lng,
						IsEnableTeachingPoint
					FROM (
								SELECT *,Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,ISNULL(Lat,0),ISNULL(Lng,0)) 
								FROM Venue WHERE 1=1' + @filter +'
							) z
					
            ) a 
			INNER JOIN City b ON a.CityId=b.Id
			INNER JOIN BaseData c ON a.State=c.Id
			INNER JOIN SportType s ON s.Id = a.SportId
 			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize
			ORDER BY a.State
			'
	
        EXEC SP_EXECUTESQL @sql,
            N'@name NVARCHAR(50),@cityCode NVARCHAR(50),@userId NVARCHAR(50),@curUserLat FLOAT,@curUserLng FLOAT,@pageIndex INT,@pageSize INT',
            @name, @cityCode, @userId, @curUserLat, @curUserLng, @pageIndex, @pageSize

		--PRINT @sql

    END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetNote]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<��ȡ�ʼ��б�>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetNote] 
(
	@noteId NVARCHAR(50),
	@userId NVARCHAR(50)
)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  n.Id ,
                n.MasterId ,
                n.MasterType ,
                n.IsShare ,
                n.Title ,
                n.Content ,
                n.Lat ,
                n.Lng ,
                n.Address ,
                dbo.fn_Link(u.Id, u.PetName) AS CreatorId ,
                n.CreateDate ,
                u.HeadUrl,
				u.Sex,
				HasSupport= (CASE WHEN s.Id IS NULL THEN 0 ELSE 1 END),
				n.CourseId
        FROM    Note n
                INNER JOIN dbo.UserAccount u ON u.Id = n.CreatorId
				LEFT JOIN dbo.NoteSupport s ON n.Id=s.NoteId AND s.UserId=@userId
        WHERE   n.Id = @noteId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetNoteList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<��ȡ�ʼ��б�>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetNoteList]
    @noteCreatorId NVARCHAR(50) ,
    @userId NVARCHAR(50) ,
	@isAll BIT ,
	@isSelf BIT,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		--��������
		DECLARE @filter NVARCHAR(MAX)
		IF	@isAll=1
			SET @filter='AND n.IsShare=1' --��ѯ�����˵ıʼ�
		ELSE IF @isSelf =1
			SET @filter= 'AND n.CreatorId=@noteCreatorId ' --��ѯ�Լ��ıʼ�
		ELSE
			SET @filter= 'AND n.CreatorId=@noteCreatorId AND n.IsShare=1 ' --��ѯ���˵ıʼǲ����ǹ�����
			
        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����  
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Note n WHERE 1=1  ' +@filter			
                EXEC SP_EXECUTESQL @sql,
                    N'@noteCreatorId NVARCHAR(50),@rowCount INT OUTPUT', @noteCreatorId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
			SELECT a.*,
		         (SELECT COUNT(*) FROM NoteSupport WHERE NoteId=a.Id) AS SupportCount,
				 (SELECT COUNT(*) FROM NoteSupport WHERE NoteId=a.Id AND UserId=@userId) AS HasSupport,
			     (SELECT COUNT(*) FROM NoteReply WHERE NoteId=a.Id) AS ReplyCount
			FROM (
							SELECT  ROW_NUMBER() OVER ( ORDER BY n.CreateDate DESC ) AS RowNumber ,
								n.Id ,
								n.MasterId ,
								n.MasterType ,
								n.Title ,
								n.Content,
								n.Address ,
								dbo.fn_Link(u.Id, u.PetName) AS CreatorId ,
								n.CreateDate,
								u.HeadUrl,
								u.Sex,
								n.CourseId
							FROM  Note n
								INNER JOIN dbo.UserAccount u ON u.Id = n.CreatorId
							WHERE 1=1 '+@filter		
						SET @sql = @sql
            + ') a 
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize 
			ORDER BY CreateDate DESC'
	
        EXEC SP_EXECUTESQL @sql,
            N'@noteCreatorId NVARCHAR(50),@userId NVARCHAR(50),@pageIndex INT,@pageSize INT', 
			@noteCreatorId,@userId,
            @pageIndex, @pageSize

		--PRINT @sql
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetNoteReplyList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<��ȡ�ʼ��б�>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetNoteReplyList]
    @noteId NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM NoteReply WHERE NoteId=@noteId'			
                EXEC SP_EXECUTESQL @sql,
                    N'@noteId NVARCHAR(50),@rowCount INT OUTPUT', @noteId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = 'SELECT *
			FROM (
			SELECT  ROW_NUMBER() OVER ( ORDER BY n.CreateDate DESC ) AS RowNumber ,
				n.Id ,
				n.NoteId ,
				n.Content,
				n.Address ,
				dbo.fn_Link(u.Id, u.PetName) AS UserId ,
				n.CreateDate,
				u.HeadUrl,
				u.Sex
			FROM  NoteReply n
				INNER JOIN dbo.UserAccount u ON u.Id = n.UserId
			WHERE n.NoteId=@noteId'		
        SET @sql = @sql
            + ') a 
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize 
			ORDER BY CreateDate DESC'
	
        EXEC SP_EXECUTESQL @sql,
            N'@noteId NVARCHAR(50),@pageIndex INT,@pageSize INT', @noteId,
            @pageIndex, @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetNoteSupportList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetNoteSupportList] 
(
	@noteId NVARCHAR(50),
	@rowCount INT OUTPUT
)
AS
    BEGIN
		--��ȡ��������
		SELECT @rowCount=COUNT(*) 
		FROM  dbo.NoteSupport 
        WHERE   NoteId = @noteId

		--��������
        SELECT
				TOP 10  
				a.Id ,
                a.NoteId ,
                dbo.fn_Link(b.Id, b.PetName) AS UserId ,
                a.CreateDate
        FROM    dbo.NoteSupport a
                JOIN dbo.UserAccount b ON a.UserId = b.Id
        WHERE   NoteId = @noteId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetOnlineUser]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetOnlineUser]
    @userId NVARCHAR(50) ,
    @token NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
        SET @sql = 'SELECT  a.Id,a.IsAdmin,a.PetName,a.CardName,a.Code,a.HeadUrl ,
                    b.DeviceType , b.Token , g.RegId
                    FROM dbo.UserAccount a
                    INNER JOIN dbo.OnlineUser b ON b.UserId = a.Id 
					LEFT JOIN MsgReg g ON g.Id=a.Id
					WHERE  1=1'

        IF ISNULL(@userId, '') != ''
            SET @sql = @sql
                + ' AND b.UserId = @userId '

        IF ISNULL(@token, '') != ''
            SET @sql = @sql + ' AND b.Token = @token'

        EXEC SP_EXECUTESQL @sql,
            N'@userId NVARCHAR(50),@token NVARCHAR(50)',
            @userId, @token 
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrderTrialCourseList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetOrderTrialCourseList]
	@IsContact BIT,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
   AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@IsContact, '') IS NOT NULL
				SET @filter = @filter + ' AND a.IsContact = @IsContact'

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1  
            BEGIN
					
                SET @sql = '
						SELECT 
							@rowCount=COUNT(*)
						FROM dbo.CoachOrderTrialCourse  a
						WHERE 1=1   ' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@IsContact BIT,@rowCount INT OUTPUT',
                    @IsContact,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
					 
			SELECT 
				a.*,
				a.CreateDate AS ApplyTime,
				b.HeadUrl,
				b.Sex 
			FROM dbo.CoachOrderTrialCourse a
			INNER JOIN dbo.UserAccount b ON a.StudentId =b.Id
			WHERE 1=1
			 '+@filter+'
			ORDER BY a.CreateDate
			OFFSET (@pageIndex-1)*@pageSize ROWS
			FETCH NEXT @pageSize ROWS ONLY
			 '

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@IsContact BIT,@pageIndex INT,@pageSize INT',
             @IsContact ,@pageIndex, @pageSize

		
		
    END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrganizationList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_GetOrganizationList] 
	@OrganizationName NVARCHAR(200),
	@CurrentUserId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF @CurrentUserId!='001001' 
			SET @filter=@filter+' AND ManagerId=@CurrentUserId '
		IF ISNULL(@OrganizationName, '') != ''
            SET @filter = @filter + ' AND  Name LIKE ''%'+@OrganizationName+'%'' '

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(*) 
						FROM dbo.CoachOrganization  
						WHERE 1=1   ' +@filter
				
                EXEC SP_EXECUTESQL @sql,
                    N'@CurrentUserId NVARCHAR(50),@rowCount INT OUTPUT',
                    @CurrentUserId ,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
					 
				SELECT 
							*
				FROM dbo.CoachOrganization  
				WHERE 1=1   ' +@filter+ '
				ORDER BY CreateDate Desc 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@CurrentUserId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @CurrentUserId ,@pageIndex, @pageSize

		
		
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetSerialNo]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<��ȡ�ʼ��б�>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetSerialNo] @id NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;
		
        DECLARE @day NVARCHAR(8)
        SET @day = CONVERT(NVARCHAR(8), GETDATE(), 112)

        IF EXISTS ( SELECT  *
                    FROM    SerialNo
                    WHERE   Id = @id )
            UPDATE  SerialNo
            SET     Today = @day ,
                    MaxValue = CASE WHEN Today = @day THEN MaxValue + 1
                                    ELSE 1
                               END
            WHERE   Id = @id



        ELSE
            INSERT  dbo.SerialNo
                    ( Id, Today, MaxValue )
            VALUES  ( @id, -- Id - nvarchar(50)
                      @day, -- Today - nvarchar(50)
                      1  -- MaxValue - int
                      )


        SELECT  Prefix + Today + RIGHT('000000'
                                       + CAST(MaxValue AS NVARCHAR(6)), 6)
        FROM    dbo.SerialNo
        WHERE   Id = @id
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetSerialNo1]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<��ȡ�ʼ��б�>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetSerialNo1]
    @id NVARCHAR(50) ,
    @orderNo NVARCHAR(50) OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		
        DECLARE @day NVARCHAR(8)
        SET @day = CONVERT(NVARCHAR(8), GETDATE(), 112)

        IF EXISTS ( SELECT  *
                    FROM    SerialNo
                    WHERE   Id = @id )
            UPDATE  SerialNo
            SET     Today = @day ,
                    MaxValue = CASE WHEN Today = @day THEN MaxValue + 1
                                    ELSE 1
                               END
            WHERE   Id = @id



        ELSE
            INSERT  dbo.SerialNo
                    ( Id, Today, MaxValue )
            VALUES  ( @id, -- Id - nvarchar(50)
                      @day, -- Today - nvarchar(50)
                      1  -- MaxValue - int
                      )


        SELECT  @orderNo = Prefix + Today + RIGHT('000000'
                                                  + CAST(MaxValue AS NVARCHAR(6)),
                                                  6)
        FROM    dbo.SerialNo
        WHERE   Id = @id
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentBookList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetStudentBookList]
    @userId NVARCHAR(50) ,
	@venueId NVARCHAR(50),
	@beginDate DATETIME,
	@endDate DATETIME
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT a.Id,a.TimeTableId,a.UserId,a.BeginTime,a.EndTime,a.IsMonth,a.CreateDate 
		FROM CoachCourseBook a INNER JOIN CoachVenueTimetables b ON a.TimeTableId=b.Id 
		WHERE a.UserId=@userId AND b.VenueId=@venueId
		AND dbo.fn_GetDate(a.BeginTime)>=dbo.fn_GetDate(@beginDate)
		AND dbo.fn_GetDate(a.BeginTime)<=dbo.fn_GetDate(@endDate)
		ORDER BY a.BeginTime
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetStudentList]
    @keywords NVARCHAR(50) ,
	@venueId NVARCHAR(50),
	@isSign NVARCHAR(5), -- 1:ǩԼ��0:δǩԼ
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX),@whereSql NVARCHAR(500),@selFields NVARCHAR(500),@joinSql NVARCHAR(500)
		SET @whereSql=' WHERE IsAdmin=0'
		SET @selFields=''
		SET @joinSql=''

		IF ISNULL(@keywords, '') != ''
			SET @whereSql = @whereSql + ' AND (PetName+CardName LIKE ''%''+@keywords+''%'')' 
		
		IF ISNULL(@venueId, '') != '' AND @isSign<>'0'
			SET @whereSql = @whereSql + ' AND VenueId=@venueId'

		IF ISNULL(@isSign, '') != ''
		BEGIN
			IF @isSign='0'
			BEGIN
				SET @whereSql = @whereSql + ' AND ISNULL(VenueId, '''')='''''
				SET @selFields = ',RequestState=CASE WHEN b.[State]='''' THEN ''1'' WHEN b.[State] IS NULL THEN ''0'' ELSE b.[State] END
								  ,RequestReMsg=b.ReMsg'
				SET @joinSql = 'LEFT JOIN (
									SELECT x.* FROM CoachMsg x INNER JOIN
									(SELECT SenderId,ReceiverId,MAX(CreateDate) CreateDate FROM CoachMsg 
									WHERE SenderId=@senderId AND ReceiverType=''016010''
									GROUP BY SenderId,ReceiverId) y 
									ON x.SenderId = y.SenderId AND x.ReceiverId=y.ReceiverId AND x.CreateDate=y.CreateDate
								) b ON a.Id = b.ReceiverId'
			END
		END

		--�ų�����
		SET @whereSql = @whereSql + ' AND a.Id NOT IN(SELECT UserId FROM Coach WHERE [State]=''010002'')'


		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(1) FROM UserAccount a LEFT JOIN VenueStudents b ON a.Id=b.UserId' + @whereSql

                EXEC SP_EXECUTESQL @sql,
                    N'@keywords NVARCHAR(50),@venueId NVARCHAR(50),@senderId NVARCHAR(50),@rowCount INT OUTPUT', 
					@keywords,@venueId,@venueId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = 'SELECT a.Id,a.Code,a.PetName,a.CardName,a.HeadUrl,a.Mobile,Sex = CASE Sex WHEN ''1'' THEN ''1,��'' ELSE ''0,Ů'' END
					' + @selFields + '
					FROM (SELECT ROW_NUMBER() OVER(ORDER BY PetName) AS RowNumber,a.Id,Code,PetName,CardName,HeadUrl,Mobile,Sex
					FROM UserAccount a LEFT JOIN VenueStudents b ON a.Id=b.UserId' + @whereSql
			
            	
        SET @sql = @sql
            + ' ) a 
			' + @joinSql + '
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'

        EXEC SP_EXECUTESQL @sql,
            N'@keywords NVARCHAR(50),@venueId NVARCHAR(50),@senderId NVARCHAR(50),@pageIndex INT,@pageSize INT', @keywords,@venueId,@venueId,
            @pageIndex, @pageSize

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMonthPayListByYear]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetStudentMonthPayListByYear]
	@year INT,
	@userId NVARCHAR(50),
	@venueId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON

		SELECT a.Id,
		a.UserId,
		a.VenueId,
		a.[Year],
		a.[Month],
		a.TotalTimes,
		a.Balance,
		a.CreateDate,
		ISNULL(b.Ispay,0) Ispay,
		Price=CASE ISNULL(b.Ispay,0) WHEN 0 THEN e.MonthPrice ELSE b.Price END
		FROM CoachStudentBalance a
		LEFT JOIN CoachStudentPay b ON a.Id=b.BalanceId
		LEFT JOIN Venue c ON a.VenueId=c.Id
		LEFT JOIN CompanyVenues d ON c.Id=d.VenueId
		LEFT JOIN CoachTrainPrice e ON c.CityId=e.CityId AND d.CompanyId=e.CompanyId
		WHERE a.UserId=@userId AND a.VenueId=@venueId AND a.[Year]=@year
		ORDER BY a.[Month] DESC
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMonthStatistics]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetStudentMonthStatistics]
    @venueId NVARCHAR(50),
    @beginDate DATE,
    @endDate DATE
AS
    BEGIN
        SET NOCOUNT ON;

		--����
        SELECT dbo.fn_Link(b.UserId,c.CardName) UserId,SUM(a.Price) MonthsPrice FROM CoachStudentPay a 
		INNER JOIN CoachStudentBalance b ON a.BalanceId=b.Id 
		INNER JOIN UserAccount c ON b.UserId=c.Id
		WHERE a.Ispay=1 AND b.VenueId=@venueId AND b.[Month]>0 
		AND (CONVERT(VARCHAR,b.[Year])+ '-'+REPLICATE('0',2-len(CAST(b.[Month] AS VARCHAR(2))))+CAST(b.[Month] AS VARCHAR(2)))>=CONVERT(VARCHAR(7),@beginDate)
		AND (CONVERT(VARCHAR,b.[Year])+ '-'+REPLICATE('0',2-len(CAST(b.[Month] AS VARCHAR(2))))+CAST(b.[Month] AS VARCHAR(2)))<=CONVERT(VARCHAR(7),@endDate)
		GROUP BY b.UserId,c.CardName
		ORDER BY MonthsPrice DESC
    END




GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMyCourse]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_GetStudentMyCourse] 
	@StudentUserId NVARCHAR(50),
	@CoacherName NVARCHAR(20),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@CoacherName, '') != ''
            SET @filter = @filter + 'AND b.CardName LiKe ''%'+@CoacherName+'%'''

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT
							@rowCount=COUNT(*)
						FROM CoacherCourseJoin a
						INNER JOIN dbo.UserAccount b ON a.CoacherUserId=b.Id
						WHERE a.StudentUserId=@StudentUserId  ' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@StudentUserId NVARCHAR(50),@rowCount INT OUTPUT',
                    @StudentUserId,@rowCount OUTPUT
            END
        ELSE 
            SET @rowCount = 0
		
		--��ҳȡ���� --��ȡû�й��ڵ�����,û���ڵ�ȡ���˲�ȡ���ڵĿγ�	
        SET @sql = '
				--��ȡ����û���ڵ����� ������ʱ��	 
				SELECT
						a.CoacherUserId , 
						b.CardName AS CoacherName ,
						b.Sex AS CoacherSex,
						b.HeadUrl AS CoacherHeadUrl,
						c.Id,
						c.Id AS CourseId,
						c.BeginTime,
						c.EndTime,
						e.Name AS TypeName,
						e.Id AS Type,
						d.Address AS VenueAddress,
						IsComment=(
							SELECT COUNT(Id) 
							FROM dbo.CoacherComment 
							WHERE CourseId=a.CourseId AND CommentatorId=@StudentUserId
						),
						a.CreateDate
				INTO	#NotExpiredCourseJoin
				FROM CoacherCourseJoin a
				INNER JOIN dbo.UserAccount b ON a.CoacherUserId=b.Id
				INNER JOIN dbo.CoacherCourse c ON a.CourseId=c.Id
				INNER JOIN dbo.BaseData e ON e.Id=c.Type
				LEFT JOIN dbo.Venue d ON c.VenueId=d.Id
				WHERE c.EndTime > GETDATE() AND a.StudentUserId=@StudentUserId '+@filter+'
				--���Դ���--��ʼ
				--SELECT * FROM #NotExpiredCourseJoin
				--���Դ���--����

				--����û���������ж���ҳ
				DECLARE @NotExpiredPageCount INT 
				SELECT @NotExpiredPageCount=(COUNT(*)+@pageSize-1)/@pageSize FROM #NotExpiredCourseJoin
				
				--��ʼȡ����,  û���ڵ�ȡ���˲�ȡ���ڵĿγ�
				IF @pageIndex <=@NotExpiredPageCount
				BEGIN
						--��û����������ȡ
						SELECT 
							*
						FROM #NotExpiredCourseJoin
						ORDER BY  EndTime ASC --���γ�ʱ��������
						OFFSET (@pageIndex-1)*@pageSize ROWS
						FETCH NEXT @pageSize ROWS ONLY
				END
				ELSE	
				BEGIN
					--�ӹ���������ȡ
					SET @pageIndex=(@pageIndex-@NotExpiredPageCount); --����pageIndex

					SELECT
							a.CoacherUserId , 
							b.CardName AS CoacherName ,
							b.Sex AS CoacherSex,
							b.HeadUrl AS CoacherHeadUrl,
							c.Id,
							c.Id AS CourseId,
							c.BeginTime,
							c.EndTime,
							e.Name AS TypeName,
							e.Id AS Type,
							d.Address AS VenueAddress,
							IsComment=(
								SELECT COUNT(Id) 
								FROM dbo.CoacherComment 
								WHERE CourseId=a.CourseId AND CommentatorId=@StudentUserId
							),
							a.CreateDate
					FROM CoacherCourseJoin a
					INNER JOIN dbo.UserAccount b ON a.CoacherUserId=b.Id
					INNER JOIN dbo.CoacherCourse c ON a.CourseId=c.Id
					INNER JOIN dbo.BaseData e ON e.Id=c.Type
					LEFT JOIN dbo.Venue d ON c.VenueId=d.Id
					WHERE c.EndTime<=GETDATE() AND a.StudentUserId=@StudentUserId '+@filter+'
					ORDER BY  c.EndTime DESC -- ���γ�ʱ�䵹����
					OFFSET (@pageIndex-1)*@pageSize ROWS
					FETCH NEXT @pageSize ROWS ONLY
				END

				DROP TABLE #NotExpiredCourseJoin
				'

		PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@StudentUserId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @StudentUserId ,@pageIndex, @pageSize

		
		
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentsOfBookCourse]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetStudentsOfBookCourse] 
	@timeTableId			NVARCHAR(50),
	@curDate				DATETIME,
	@courseId				NVARCHAR(50),
	@incStudentsOfCourse	BIT--�����γ��е�ѧԱ
AS
    BEGIN
        SET NOCOUNT ON;

		DECLARE @sql NVARCHAR(MAX),@joinSql NVARCHAR(500),@whereSql NVARCHAR(500),@fieldSql NVARCHAR(500)

		--0��1���ص������У��޷��Զ�ת���ɲ������ͣ���˶���һ��������������ֵ
		SET @sql='
		DECLARE @IsJoinCourse BIT
		SET @IsJoinCourse=1
		'


		IF @incStudentsOfCourse=1
		BEGIN
			SET @joinSql='LEFT JOIN(
							SELECT b.UserId FROM CoachCourse a INNER JOIN CoachCourseStudents b ON a.Id=b.CourseId
							WHERE a.TimeTableId=@timeTableId AND dbo.fn_GetDate(@curDate)=dbo.fn_GetDate(a.BeginTime)
							) c ON a.UserId=c.UserId'
			SET @whereSql=''
			SET @fieldSql=',IsJoinCourse=CASE WHEN c.UserId IS NULL THEN ~@IsJoinCourse ELSE @IsJoinCourse END'
		END
		ELSE
		BEGIN
			SET @joinSql=''
			SET @whereSql='AND a.UserId NOT IN(
								SELECT y.UserId FROM CoachCourse x 
								INNER JOIN CoachCourseStudents y ON x.Id=y.CourseId 
								WHERE x.TimeTableId=@timeTableId 
								AND dbo.fn_GetDate(x.BeginTime)=dbo.fn_GetDate(@curDate)
								AND x.Id<>ISNULL(@courseId,'''')
							)'
			SET @fieldSql=',IsJoinCourse=~@IsJoinCourse'
		END


        SET @sql=@sql + '
		SELECT a.Id,dbo.fn_Link(a.UserId,b.CardName) UserId'+@fieldSql+' FROM CoachCourseBook a 
        INNER JOIN UserAccount b ON a.UserId=b.Id 
		'+@joinSql+' 
        WHERE TimeTableId=@timeTableId AND dbo.fn_GetDate(BeginTime)=dbo.fn_GetDate(@curDate) '+@whereSql
        

		--PRINT @sql
		EXEC SP_EXECUTESQL @sql,
            N'@timeTableId NVARCHAR(50),@curDate DATETIME,@courseId NVARCHAR(50)',
            @timeTableId,@curDate,@courseId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentTimesBalance]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetStudentTimesBalance] 
	@userId NVARCHAR(50),
	@venueId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @totalTimes INT,@balance INT
		SELECT @totalTimes=TotalTimes,@balance=Balance FROM CoachStudentBalance WHERE UserId=@userId AND VenueId=@venueId AND [Month]=0
		SELECT ISNULL(@totalTimes,0) TotalTimes,ISNULL(@balance,0) Balance
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentTimesStatistics]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetStudentTimesStatistics]
    @venueId NVARCHAR(50),
    @beginDate DATE,
    @endDate DATE
AS
    BEGIN
        SET NOCOUNT ON;

		--����
        SELECT dbo.fn_Link(b.UserId,d.CardName) UserId,
		COUNT(a.Times) TotalTimes,
		SUM(a.Price/a.Times) TimesPrice 
		FROM CoachStudentPay a 
		INNER JOIN CoachStudentBalance b ON a.BalanceId=b.Id
		INNER JOIN CoachCourseBook c ON a.Id=c.StudentPayId
		INNER JOIN UserAccount d ON b.UserId=d.Id
		WHERE a.Ispay=1 AND b.VenueId=@venueId AND b.[Month]=0 AND c.IsMonth=0
		AND CONVERT(VARCHAR(7),dbo.fn_GetDate(c.BeginTime))>=CONVERT(VARCHAR(7),@beginDate)
		AND CONVERT(VARCHAR(7),dbo.fn_GetDate(c.BeginTime))<=CONVERT(VARCHAR(7),@endDate) 
		GROUP BY b.UserId,d.CardName
		ORDER BY TimesPrice DESC
    END




GO
/****** Object:  StoredProcedure [dbo].[sp_GetSyllabusTeachingPointList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetSyllabusTeachingPointList]
    @cityCode NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        --��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'
                        
         
		--��ȡ������
        DECLARE @sql NVARCHAR(MAX);
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(*) 
						FROM Venue WHERE IsEnableTeachingPoint=1 '
                    + @filter
                EXEC SP_EXECUTESQL @sql,
                    N'@cityCode NVARCHAR(50),@rowCount INT OUTPUT',
                    @cityCode, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
            
        --��ȡÿҳ����
        SET @sql = '
				 SELECT 
						a.Id,
						a.HeadUrl,
						a.Name,
						a.TableCount,
						b.Name AS SportName,
						a.Address
				FROM Venue a
				LEFT JOIN dbo.SportType b ON a.SportId=b.Id
				WHERE IsEnableTeachingPoint=1 '+ @filter+
                '
				ORDER BY 1
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY
				'
				
	
        EXEC SP_EXECUTESQL @sql,
            N'@cityCode NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @cityCode, @pageIndex, @pageSize

		--PRINT @sql

    END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetTeachingPointCoachList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetTeachingPointCoachList]
    @keywords NVARCHAR(50) ,--�ʺţ��ǳƣ��������ֻ�
	@VenueId NVARCHAR(50),
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' WHERE 1=1 AND c.IsEnabled=1'  
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
                + ' AND (b.Code+b.PetName+b.CardName+ISNULL(b.Mobile,'''') LIKE ''%''+@keywords+''%'')'         

		IF ISNULL(@VenueId, '') != ''
            SET @filter = @filter+ ' AND a.VenueId=@VenueId '
                
        DECLARE @sql NVARCHAR(MAX)

		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
					SELECT 
						@rowCount=COUNT(a.Id) 
					FROM dbo.CoachTeachingPointCoaches a
					INNER JOIN dbo.UserAccount b ON a.CoacherId=b.Id 
					INNER JOIN dbo.Coach c ON a.CoacherId=c.Id 
					
					'   
                 + @filter              
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@VenueId NVARCHAR(50),@keywords NVARCHAR(50),@rowCount INT OUTPUT',
                    @VenueId , @keywords, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
				 SELECT 
							b.HeadUrl,
							b.Sex,
							b.CardName,
							b.PetName,
							b.Code,
							b.Id,
							b.Id AS UserId 
				FROM dbo.CoachTeachingPointCoaches a
				INNER JOIN dbo.UserAccount b ON a.CoacherId=b.Id
				INNER JOIN dbo.Coach c ON a.CoacherId=c.Id 
				' 
				+ @filter +' 
				ORDER BY a.CreateDate
				OFFSET (@pageIndex-1)*@pageSize ROWS 
				FETCH NEXT @pageSize ROWS ONLY 
				'

        EXEC SP_EXECUTESQL @sql,
            N'@VenueId NVARCHAR(50),@keywords NVARCHAR(50),@pageIndex INT,@pageSize INT', 
			@VenueId,@keywords, @pageIndex, @pageSize
            

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetTeachingPointList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_GetTeachingPointList] 
	@venueName NVARCHAR(200),
	@isOnlyTeachingPoint BIT,
	@CityId NVARCHAR(50)='',
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@venueName, '') != ''
            SET @filter = @filter + ' AND a.Name LIKE ''%'+@venueName+'%'' '
		SET @filter=@filter+' AND a.State=''010002'' '
		
		IF	ISNULL(@CityId,'')!=''
			SET @filter=@filter+' AND a.CityId=@CityId'
		
		IF	ISNULL(@isOnlyTeachingPoint,0)=1
			SET @filter=@filter+' AND a.IsEnableTeachingPoint=1'


        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = ' 
				SELECT  @rowCount= COUNT(*) 
				FROM dbo.Venue a
				WHERE 1=1 
				' +@filter
                EXEC SP_EXECUTESQL @sql,
                    N'@venueName NVARCHAR(200),@rowCount INT OUTPUT',
                   @venueName ,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
				SELECT 
					a.HeadUrl,
					a.Id AS VenueId,
					a.Name AS VenueName,
					ISNULL(a.IsEnableTeachingPoint,0) AS IsEnableTeachingPoint ,
					c.Id AS CourseManagerId,
					c.CardName AS CourseManagerName,
					CoacherIds=dbo.fn_GetTeachingPointCoachIds(a.Id),
					CoacherNames=dbo.fn_GetTeachingPointCoachNames(a.Id),
					a.TableCount,
					d.Name AS SportName
				FROM dbo.Venue a
				LEFT JOIN dbo.UserAccount c ON a.CourseManagerId=c.Id
				LEFT JOIN dbo.SportType d ON a.SportId=d.Id
				
				WHERE 1=1  '+@filter+'
				ORDER BY IsEnableTeachingPoint DESC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@venueName NVARCHAR(200),@pageIndex INT,@pageSize INT',
             @venueName ,@pageIndex, @pageSize
		
		
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetUser]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUser] @userId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                dbo.fn_Link(b.Id,b.Name) AS CityId ,
                a.Code ,
                a.Password ,
				a.PayNoPwdAmount,
                a.CardId ,
                a.CardName ,
                a.Sex ,
                a.QQ ,
                a.PetName ,
                a.Weixin ,
                a.CompanyId ,
                a.IsAdmin ,
                a.IsStop ,
                a.Birthday ,
                a.Mobile ,
                a.Address ,
                a.Lat ,
                a.Lng ,
                a.SignName ,
                a.HeadUrl ,
                a.Remark ,
                a.CreateDate,
				IsCoacher=CONVERT(BIT, 
						(SELECT COUNT(Id) FROM dbo.Coach WHERE a.id=Id)
				)/*�Ƿ�Ϊ����*/
        FROM    dbo.UserAccount a
        LEFT JOIN dbo.City b ON a.CityId=b.Id
        WHERE a.Id=@userId
        
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserLimitList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<��ȡ�ʼ��б�>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserLimitList]
    @userId NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM UserLimit WHERE 1=1 '	
                IF ISNULL(@userId, '') != ''
                    SET @sql = @sql + ' AND UserId=@userId'		
                EXEC SP_EXECUTESQL @sql,
                    N'@userId NVARCHAR(50),@rowCount INT OUTPUT', @userId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = 'SELECT *
			FROM (
			SELECT  ROW_NUMBER() OVER ( ORDER BY n.CreateDate DESC ) AS RowNumber ,
			    n.Id,
				n.IsClub ,
				n.IsVenue ,
				n.IsGame ,
				n.IsScoreGame ,
				n.IsActivity ,
				n.IsNote,
				dbo.fn_Link(u.Id, u.CardName) AS UserId 
			FROM  UserLimit n
				INNER JOIN dbo.UserAccount u ON u.Id = n.UserId
			WHERE 1=1'	
        IF ISNULL(@userId, '') != ''
            SET @sql = @sql + ' AND n.UserId=@userId'			
        SET @sql = @sql
            + ') a 
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize 
			ORDER BY CreateDate DESC'
	
        EXEC SP_EXECUTESQL @sql,
            N'@userId NVARCHAR(50),@pageIndex INT,@pageSize INT', @userId,
            @pageIndex, @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserLimitRequestList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<��ȡ�ʼ��б�>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserLimitRequestList]
    @userId NVARCHAR(50) ,
    @isProcessed NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM UserLimitRequest WHERE 1=1 '	
                IF ISNULL(@userId, '') != ''
                    SET @sql = @sql + ' AND UserId=@userId'		
                IF ISNULL(@isProcessed, '') != ''
                    SET @sql = @sql + ' AND IsProcessed=' + @isProcessed	
                EXEC SP_EXECUTESQL @sql,
                    N'@userId NVARCHAR(50),@rowCount INT OUTPUT', @userId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = 'SELECT *
			FROM (
			SELECT  ROW_NUMBER() OVER ( ORDER BY n.CreateDate DESC ) AS RowNumber ,
			    n.Id,
				n.IsClub ,
				n.IsVenue ,
				n.IsGame ,
				n.IsActivity ,
				n.IsNote,
				dbo.fn_Link(u.Id, u.CardName) AS UserId 
			FROM  UserLimitRequest n
				INNER JOIN dbo.UserAccount u ON u.Id = n.UserId
			WHERE 1=1'	
			
        IF ISNULL(@userId, '') != ''
            SET @sql = @sql + ' AND UserId=@userId'		
        IF ISNULL(@isProcessed, '') != ''
            SET @sql = @sql + ' AND IsProcessed=' + @isProcessed		
        SET @sql = @sql
            + ') a 
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize 
			ORDER BY CreateDate DESC'
	
        EXEC SP_EXECUTESQL @sql,
            N'@userId NVARCHAR(50),@pageIndex INT,@pageSize INT', @userId,
            @pageIndex, @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserList]
    @keywords NVARCHAR(50) ,--�ʺţ��ǳƣ��������ֻ�
    @isAdmin NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' WHERE IsAdmin=' + @isAdmin
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
                + ' AND (Code+PetName+CardName+ISNULL(Mobile,'''') LIKE ''%''+@keywords+''%'')'         

        DECLARE @sql NVARCHAR(MAX)

		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(Id) FROM UserAccount '
                    + @filter              
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@keywords NVARCHAR(50),@rowCount INT OUTPUT', @keywords,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = '
					SELECT 
						Id,
						Code,
						PetName,
						CardName,
						HeadUrl,
						Sex,
						Mobile,
						Id AS userId
					FROM UserAccount ' 
					+ @filter +' 
					ORDER BY PetName
					OFFSET (@pageIndex-1)*@pageSize ROWS 
					FETCH NEXT @pageSize ROWS ONLY 
					'

        EXEC SP_EXECUTESQL @sql,
            N'@keywords NVARCHAR(50),@pageIndex INT,@pageSize INT', @keywords,
            @pageIndex, @pageSize

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserScoreHistoryList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserScoreHistoryList]
    @userId NVARCHAR(50) ,
    @sportId NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' WHERE a.UserId=@userId AND a.SportId=@sportId'   

        DECLARE @sql NVARCHAR(MAX)

		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(Id) FROM UserScoreHistory a '
                    + @filter              
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@userId NVARCHAR(50),@sportId NVARCHAR(50),@rowCount INT OUTPUT',
                    @userId, @sportId, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = 'SELECT * FROM (SELECT  a.Id ,
        a.UserId ,
        a.SportId ,
        CASE WHEN ISNULL(a.GameId, '''') != '''' 
			THEN dbo.fn_Link(b.Id, b.Name) 
			ELSE ''admin,����Ա����'' 
		END AS GameId,
		dbo.fn_Link(d.Id, d.TeamName) AS User1Id ,
		dbo.fn_Link(e.Id, e.TeamName) AS User2Id ,
        a.LoopId ,
        CASE WHEN ISNULL(a.GameId, '''') != ''''
             THEN ( CASE WHEN a.Score > 0
                         THEN ''+'' + CAST(a.Score AS NVARCHAR(50))
                         WHEN a.Score < 0
                         THEN CAST(a.Score AS NVARCHAR(50))
                         ELSE ''0''
                    END )
             ELSE CAST(a.Score AS NVARCHAR(50))
        END AS Score , 
        a.CreateDate,
		ROW_NUMBER() OVER(ORDER BY a.CreateDate) AS RowNumber
FROM    UserScoreHistory a
        LEFT JOIN dbo.Game b ON b.Id = a.GameId
        LEFT JOIN dbo.GameLoop c ON c.Id = a.LoopId
        LEFT JOIN dbo.GameTeam d ON d.Id = c.Team1Id
        LEFT JOIN dbo.GameTeam e ON e.Id = c.Team2Id '
			 + @filter
             + ' ) a WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'

        EXEC SP_EXECUTESQL @sql,
            N'@userId NVARCHAR(50),@sportId NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @userId, @sportId, @pageIndex, @pageSize

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserSignList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserSignList]
    @masterType NVARCHAR(50) ,
    @masterId NVARCHAR(50) ,
    @userId NVARCHAR(50) ,
    @signDate NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		
        DECLARE @sql NVARCHAR(MAX);
		--��ȡ������
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM UserSign a WHERE 1=1 '
		
                IF ISNULL(@masterType, '') != ''
                    SET @sql = @sql + ' AND a.MasterType=@masterType '
        
                IF ISNULL(@masterId, '') != ''
                    SET @sql = @sql + ' AND a.MasterId=@masterId '

                IF ISNULL(@userId, '') != ''
                    SET @sql = @sql + ' AND a.CreatorId=@userId '

                IF ISNULL(@signDate, '') != ''
                    SET @sql = @sql
                        + ' AND CONVERT(NVARCHAR(10),a.CreateDate,120)=@signDate '
								
                EXEC SP_EXECUTESQL @sql,
                    N'@masterType NVARCHAR(50),@masterId NVARCHAR(50),@userId NVARCHAR(50),@signDate NVARCHAR(50),@rowCount INT OUTPUT',
                    @masterType, @masterId, @userId, @signDate,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0

        --��ȡÿҳ����
        SET @sql = 'SELECT * FROM (
		SELECT  a.Id ,
		    CASE WHEN MasterType=''016003'' THEN dbo.fn_GetLinkVenueName(MasterId) ELSE NULL END AS MasterId,
			CASE WHEN MasterType=''016003'' THEN dbo.fn_GetVenueUserUseCount(MasterId,a.CreatorId,a.CreateDate) ELSE NULL END AS VenueUseCount,
			a.Remark ,
			a.Lat ,
			a.Lng ,
			a.Address ,
			dbo.fn_Link(c.Id, c.PetName) AS CreatorId ,
			c.HeadUrl,
			c.Sex,
			ROW_NUMBER() OVER(ORDER BY a.CreateDate DESC) AS RowNumber,
			a.CreateDate
		FROM    UserSign a
			JOIN dbo.UserAccount c ON c.Id = a.CreatorId
		WHERE   1 = 1'

        IF ISNULL(@masterType, '') != ''
            SET @sql = @sql + ' AND a.MasterType=@masterType '
        
        IF ISNULL(@masterId, '') != ''
            SET @sql = @sql + ' AND a.MasterId=@masterId '

        IF ISNULL(@userId, '') != ''
            SET @sql = @sql + ' AND a.CreatorId=@userId '

        IF ISNULL(@signDate, '') != ''
            SET @sql = @sql
                + ' AND CONVERT(NVARCHAR(10),a.CreateDate,120)=@signDate '

        SET @sql = @sql
            + ' ) AS temp WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'
	
        EXEC SP_EXECUTESQL @sql,
            N'@masterType NVARCHAR(50),@masterId NVARCHAR(50),@userId NVARCHAR(50),@signDate NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @masterType, @masterId, @userId, @signDate, @pageIndex, @pageSize
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserSportList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserSportList]
    @userId NVARCHAR(50) ,
    @sportId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
        SELECT  a.Id ,
                dbo.fn_Link(b.Id, b.Name) AS SportId ,
                dbo.fn_Link(c.Id, c.Name) AS ProType ,
                dbo.fn_Link(d.Id, d.Name) AS GripOption ,
                IsActive ,
                Score ,
                a.CreateDate ,
                a.UserId
        FROM    UserSport a 
                JOIN SportType b ON a.SportId = b.Id
                JOIN BaseData c ON a.ProType = c.Id
                JOIN BaseData d ON a.GripOption = d.Id
        WHERE   UserId = @userId '

        IF ISNULL(@sportId, '') != ''
            SET @sql = @sql + ' AND a.SportId=@sportId'

        EXEC SP_EXECUTESQL @sql, N'@userId NVARCHAR(50),@sportId NVARCHAR(50)',
            @userId, @sportId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenue]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVenue]
    @venueId NVARCHAR(50) ,
    @isGetMyRole BIT ,
    @curUser NVARCHAR(50),
	@curUserLng FLOAT,
	@curUserLat FLOAT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @isStudent BIT 
        SET @isStudent = 0

        IF ISNULL(@isGetMyRole, 0) = 1
            BEGIN
                IF EXISTS ( SELECT  1
                            FROM    VenueStudents
                            WHERE   VenueId = @venueId
                                    AND UserId = @curUser )
                    SET @isStudent = 1
            
            END


        SELECT  A.Id ,
                A.Name ,
                A.Introduce ,
                A.HeadUrl ,
                A.Address ,
                dbo.fn_Link(b.Id, b.Name) AS CityId ,
                A.Lng ,
                a.AlipayId ,
                A.Lat ,
                A.Mobile ,
                A.QQ ,
                A.WeiXin ,
                dbo.fn_Link(d.Id, d.CardName) AS CreatorId ,
                dbo.fn_Link(e.Id, e.CardName) AS AdminId ,
                A.CreateDate ,
                dbo.fn_Link(C.Id, C.Name) AS State ,
                a.IsUseVip ,
                a.CreditLine ,
                a.Balance ,
                dbo.fn_GetReplyCount(a.Id) AS ReplyCount ,
                dbo.fn_Link(s.Id, s.Name) AS SportId ,
                @isStudent IsStudent ,
                dbo.fn_Link(g.Id, g.Name) AS CompanyId,
				a.TableCount,
				a.UnitPrice,
				a.UnitType,
				Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,a.Lat,a.Lng)
        FROM    Venue A
                INNER JOIN City b ON A.CityId = b.Id
                INNER JOIN BaseData c ON A.State = c.Id
                INNER JOIN UserAccount d ON A.CreatorId = d.Id
                INNER JOIN SportType s ON s.Id = A.SportId
                LEFT JOIN UserAccount e ON e.Id = A.AdminId
                LEFT JOIN CompanyVenues f ON f.VenueId = a.Id
                LEFT JOIN dbo.Company g ON g.Id = f.CompanyId
        WHERE   A.Id = @venueId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueDiscountList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetVenueDiscountList]
    @venueId NVARCHAR(50) ,
    @today NVARCHAR(10) ,
    @costTypeId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
        SET @sql = 'SELECT 
			A.Id
			,A.VenueId
			,dbo.fn_Link(b.Id,b.Name) AS CostTypeId
			,A.Discount
			,A.BeginDate
			,A.EndDate
			,A.CreatorId
			,A.CreateDate
		FROM VenueDiscount a
		LEFT JOIN dbo.CostType b ON b.Id = a.CostTypeId WHERE 1=1 '

        IF ISNULL(@venueId, '') != ''
            SET @sql = @sql + ' AND a.VenueId=@venueId'

        IF ISNULL(@costTypeId, '') != ''
            SET @sql = @sql + ' AND a.CostTypeId=@costTypeId'

        IF ISNULL(@today, '') != ''
            SET @sql = @sql
                + ' AND (@today BETWEEN CONVERT(NVARCHAR(10),A.BeginDate,120) AND CONVERT(NVARCHAR(10),A.EndDate,120))'

        SET @sql = @sql + ' ORDER BY BeginDate DESC,CostTypeId'

        EXEC SP_EXECUTESQL @sql,
            N'@venueId NVARCHAR(50),@today NVARCHAR(50),@costTypeId NVARCHAR(50)',
            @venueId, @today, @costTypeId
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetVenueList]
    @userId NVARCHAR(50) ,
    @isOnlySelf NVARCHAR(50) ,
    @isUseVip NVARCHAR(50) ,
    @name NVARCHAR(50) ,
    @cityCode NVARCHAR(50) ,
	@curUserLng FLOAT,
	@curUserLat FLOAT,
	@isAll BIT , --�Ƿ񷵻�ȫ��, ��������˺�δ��˵�
	@state NVARCHAR(50)='',
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--ȡ�û�����Ա��־
        DECLARE @isAdmin BIT
        SELECT  @isAdmin = IsAdmin
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        IF @isAdmin IS NULL
            SET @isAdmin = 0

        --��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@name, '') != ''
            SET @filter = @filter + ' AND name LIKE ''%''+@name+''%'''
                        
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'  

        IF ISNULL(@isUseVip, '') != ''
            SET @filter = @filter + ' AND IsUseVip=1'  

        --�鿴�Լ�������ȫ�����ݻ�������ͨ����˵ĳ��ݣ�����Ա�鿴����   
        IF @isAdmin = 0
            BEGIN
                IF ISNULL(@isOnlySelf, '') = '1'
                    SET @filter = @filter
                        + ' AND (CreatorId=@userId OR AdminId=@userId 
						OR Id IN ( --���ѹ��ĳ���
									SELECT VenueId FROM VipUse WHERE PayState=''024002'' AND UserId=@userId)) '  
                ELSE IF @isAll !=1 --������ȫ��
				BEGIN
						IF  ISNULL(@state, '') != ''
							SET @filter = @filter + '  AND State='''+@state+''''  
						ELSE	
							SET @filter = @filter + '  AND State=''010002'''  --������ȫ��, Ĭ�Ϸ�������˵�

				END
			 
            END

		--��ȡ������
        DECLARE @sql NVARCHAR(MAX);
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Venue WHERE 1=1'
                    + @filter
                EXEC SP_EXECUTESQL @sql,
                    N'@name NVARCHAR(50),@cityCode NVARCHAR(50),@userId NVARCHAR(50),@rowCount INT OUTPUT',
                    @name, @cityCode, @userId, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
            
        --��ȡÿҳ����
        SET @sql = '
			SELECT a.Id,a.Name,A.HeadUrl,
						dbo.fn_Link(b.Id,b.Name) AS CityId,
						a.Address,
						dbo.fn_GetReplyCount(a.Id) AS ReplyCount,
						dbo.fn_GetSignCount(a.Id) AS SignCount,
						a.IsUseVip,
						a.Balance,
						a.CreditLine,
						dbo.fn_Link(c.Id,c.Name) AS State ,
						dbo.fn_Link(s.Id, s.Name) AS SportId,
						AdminId,
						CreatorId,
						a.TableCount,
						a.UnitPrice,
						a.UnitType,
 						a.Distance,
						a.Lng,
						a.Lat
			FROM (
					SELECT ROW_NUMBER() OVER(ORDER BY Distance) AS RowNumber,
						Id,
						CityId,
						Name,
						HeadUrl,
						Address,
						State,
						SportId,
						IsUseVip,
						CreditLine ,
						Balance,
						AdminId,
						CreatorId,
						TableCount,
						UnitPrice,
						UnitType,
						Distance,
						ISNULL(Lat,0) Lat,
						ISNULL(Lng,0) Lng
					FROM (
								SELECT *,Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,ISNULL(Lat,0),ISNULL(Lng,0)) 
								FROM Venue WHERE 1=1' + @filter +'
							) z
					
            ) a 
			INNER JOIN City b ON a.CityId=b.Id
			INNER JOIN BaseData c ON a.State=c.Id
			INNER JOIN SportType s ON s.Id = a.SportId
 			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize
			ORDER BY a.State
			'
	
        EXEC SP_EXECUTESQL @sql,
            N'@name NVARCHAR(50),@cityCode NVARCHAR(50),@userId NVARCHAR(50),@curUserLat FLOAT,@curUserLng FLOAT,@pageIndex INT,@pageSize INT',
            @name, @cityCode, @userId, @curUserLat, @curUserLng, @pageIndex, @pageSize

		--PRINT @sql

    END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListAllForCoacher]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- ҵ���߼�:  ��ȡ���г����б�(������˵ĺ�δ��˵�), �����Լ�����������ǰ��, ���ڽ����������
-- ע��: ���Ĵ���, ��ͬ������ҵ���߼�ע��
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVenueListAllForCoacher]
    @userId NVARCHAR(50) ,
	@creatorId NVARCHAR(50)='',
    @isOnlySelf NVARCHAR(50) ,
    @isUseVip NVARCHAR(50) ,
    @name NVARCHAR(50) ,
    @cityCode NVARCHAR(50) ,
	@curUserLng FLOAT,
	@curUserLat FLOAT,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT,
	@Distance INT
AS
    BEGIN
        SET NOCOUNT ON;
		 
		--ȡ�û�����Ա��־
        DECLARE @isAdmin BIT
        SELECT  @isAdmin = IsAdmin
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        IF @isAdmin IS NULL
            SET @isAdmin = 0

        --��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@name, '') != ''
            SET @filter = @filter + ' AND name LIKE ''%''+@name+''%'''
                        
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'  

        IF ISNULL(@isUseVip, '') != ''
            SET @filter = @filter + ' AND IsUseVip=1'  
		--���� ��������
		DECLARE @distanceFilter NVARCHAR(MAX)
		SET @distanceFilter=''
		IF ISNULL(@Distance, 0) != 0
            SET @distanceFilter = @distanceFilter + ' AND Distance<@Distance'  
	
        --�鿴�Լ�������ȫ�����ݻ�������ͨ����˵ĳ��ݣ�����Ա�鿴����   
        IF @isAdmin = 0
            BEGIN
                IF ISNULL(@isOnlySelf, '') = '1'
                    SET @filter = @filter
                        + ' AND (CreatorId=@userId OR AdminId=@userId 
						OR Id IN ( --���ѹ��ĳ���
									SELECT VenueId FROM VipUse WHERE PayState=''024002'' AND UserId=@userId)) '  
               
            END

		--��ȡ������
        DECLARE @sql NVARCHAR(MAX);
        IF @pageIndex = 1
            BEGIN
                SET @sql = '	
				SELECT  
					@rowCount=COUNT(*)  
				FROM (
					SELECT Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,ISNULL(Lat,0),ISNULL(Lng,0))  
					FROM Venue 
					WHERE 1=1  ' + @filter +'
				) a
				WHERE  1=1 '+@distanceFilter
                  
                EXEC SP_EXECUTESQL @sql,
                    N'@name NVARCHAR(50),@cityCode NVARCHAR(50),@userId NVARCHAR(50),@rowCount INT OUTPUT,
					@curUserLat FLOAT,@curUserLng FLOAT,@Distance INT',
                    @name, @cityCode, @userId, @rowCount OUTPUT,
					@curUserLat, @curUserLng,@Distance
				--PRINT @sql
            END
        ELSE
            SET @rowCount = 0

        --����--���ݲ�ѯ������ȡ��ҳ����, �������ݷŵ� #VenueList ��ʱ��---��ʼ
        SET @sql ='
			SELECT a.Id,a.Name,A.HeadUrl,
						dbo.fn_Link(b.Id,b.Name) AS CityId,
						a.Address,
						dbo.fn_GetReplyCount(a.Id) AS ReplyCount,
						dbo.fn_GetSignCount(a.Id) AS SignCount,
						a.IsUseVip,
						a.Balance,
						a.CreditLine,
						dbo.fn_Link(c.Id,c.Name) AS State ,
						dbo.fn_Link(s.Id, s.Name) AS SportId,
						AdminId,
						CreatorId,
						a.TableCount,
						a.UnitPrice,
						a.UnitType,
 						a.Distance,
						a.Lng,
						a.Lat,
						IsMyVenue=(CASE WHEN a.CreatorId=@userId THEN 1 ELSE 0 END)
			INTO #VenueList /*���ݲ�ѯ��������һҳ���ݷŵ���ʱ��*/
			FROM 
			(
					SELECT ROW_NUMBER() OVER(ORDER BY Distance) AS RowNumber,
						Id,
						CityId,
						Name,
						HeadUrl,
						Address,
						State,
						SportId,
						IsUseVip,
						CreditLine ,
						Balance,
						AdminId,
						CreatorId,
						TableCount,
						UnitPrice,
						UnitType,
						Distance,
						ISNULL(Lat,0) Lat,
						ISNULL(Lng,0) Lng
					FROM (
								SELECT 
									*,
									Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,ISNULL(Lat,0),ISNULL(Lng,0)) 
								FROM Venue 
								WHERE 1=1 AND CreatorId !=@creatorId /*���޳����ҵĳ���,�����ٻ�ȡ*/ ' + @filter +'
							) z
					WHERE  1=1  '  +@distanceFilter+ 
			'
            ) a 
			INNER JOIN City b ON a.CityId=b.Id
			INNER JOIN BaseData c ON a.State=c.Id
			INNER JOIN SportType s ON s.Id = a.SportId
 			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize
			--����SQL
			--SELECT * FROM #VenueList
			'
	    --����--���ݲ�ѯ������ȡ��ҳ����, �������ݷŵ� #VenueList ��ʱ��-------����

        	 
		--Ȼ��--����ǵ�һҳ,��ƴ��һ���Լ������ĳ�������, ���ҷ�����ǰ��-------��ʼ
		IF	@pageIndex=1
		BEGIN
			SET @sql+='
			INSERT INTO #VenueList  /*׷���Ҵ����ĳ��ص���ʱ��, ��֮ǰ��ʱ����������һҳ����*/
			SELECT a.Id,a.Name,A.HeadUrl,
						dbo.fn_Link(b.Id,b.Name) AS CityId,
						a.Address,
						dbo.fn_GetReplyCount(a.Id) AS ReplyCount,
						dbo.fn_GetSignCount(a.Id) AS SignCount,
						a.IsUseVip,
						a.Balance,
						a.CreditLine,
						dbo.fn_Link(c.Id,c.Name) AS State ,
						dbo.fn_Link(s.Id, s.Name) AS SportId,
						AdminId,
						CreatorId,
						a.TableCount,
						a.UnitPrice,
						a.UnitType,
						0 AS Distance,
						a.Lng,
						a.Lat,
						IsMyVenue=(CASE WHEN a.CreatorId=@creatorId THEN 1 ELSE 0 END)

			FROM 
			(
					SELECT 
						Id,
						CityId,
						Name,
						HeadUrl,
						Address,
						State,
						SportId,
						IsUseVip,
						CreditLine ,
						Balance,
						AdminId,
						CreatorId,
						TableCount,
						UnitPrice,
						UnitType,
						0 AS Distance,
						ISNULL(Lat,0) Lat,
						ISNULL(Lng,0) Lng
					FROM Venue
					WHERE CreatorId=@creatorId
					
            ) a 
			INNER JOIN City b ON a.CityId=b.Id
			INNER JOIN BaseData c ON a.State=c.Id
			INNER JOIN SportType s ON s.Id = a.SportId
			
			'
		END
		--Ȼ��--����ǵ�һҳ,��ƴ��һ���Լ������ĳ�������, ���ҷ�����ǰ��-------����

		--���--��ʼ������,���Ҵ����ĳ���order by ����ǰ��
		SET @sql+='
			SELECT * FROM #VenueList ORDER BY IsMyVenue DESC 
			DROP TABLE #VenueList
		'

		EXEC SP_EXECUTESQL @sql,
            N'@name NVARCHAR(50),@cityCode NVARCHAR(50),@userId NVARCHAR(50),
			@curUserLat FLOAT,@curUserLng FLOAT,@creatorId NVARCHAR(50),
			@pageIndex INT,@pageSize INT,@Distance INT',
            @name, @cityCode, @userId, 
			@curUserLat, @curUserLng,@creatorId, 
			@pageIndex, @pageSize,@Distance

		--PRINT @sql
		

    END




GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListForAudit]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetVenueListForAudit]
    @userId NVARCHAR(50) ,
    @isOnlySelf NVARCHAR(50) ,
    @isUseVip NVARCHAR(50) ,
    @name NVARCHAR(50) ,
    @cityCode NVARCHAR(50) ,
	@curUserLng FLOAT,
	@curUserLat FLOAT,
	@isAll BIT , --�Ƿ񷵻�ȫ��, ��������˺�δ��˵�
	@state NVARCHAR(50)='',
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--ȡ�û�����Ա��־
        DECLARE @isAdmin BIT
        SELECT  @isAdmin = IsAdmin
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        IF @isAdmin IS NULL
            SET @isAdmin = 0

        --��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@name, '') != ''
            SET @filter = @filter + ' AND name LIKE ''%''+@name+''%'''
                        
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'  

        IF ISNULL(@isUseVip, '') != ''
            SET @filter = @filter + ' AND IsUseVip=1'  

      
        IF ISNULL(@isOnlySelf, '') = '1'
            SET @filter = @filter
                + ' AND (CreatorId=@userId OR AdminId=@userId 
				OR Id IN ( --���ѹ��ĳ���
							SELECT VenueId FROM VipUse WHERE PayState=''024002'' AND UserId=@userId)) '  
        ELSE IF @isAll !=1 --������ȫ��
		BEGIN
				IF  ISNULL(@state, '') != ''
					SET @filter = @filter + '  AND State='''+@state+''''  
				ELSE	
					SET @filter = @filter + '  AND State=''010002'''  --������ȫ��, Ĭ�Ϸ�������˵�

		END
			 
       

		--��ȡ������
        DECLARE @sql NVARCHAR(MAX);
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Venue WHERE 1=1'
                    + @filter
                EXEC SP_EXECUTESQL @sql,
                    N'@name NVARCHAR(50),@cityCode NVARCHAR(50),@userId NVARCHAR(50),@rowCount INT OUTPUT',
                    @name, @cityCode, @userId, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
            
        --��ȡÿҳ����
        SET @sql = '
			SELECT a.Id,a.Name,A.HeadUrl,
						dbo.fn_Link(b.Id,b.Name) AS CityId,
						a.Address,
						dbo.fn_GetReplyCount(a.Id) AS ReplyCount,
						dbo.fn_GetSignCount(a.Id) AS SignCount,
						a.IsUseVip,
						a.Balance,
						a.CreditLine,
						dbo.fn_Link(c.Id,c.Name) AS State ,
						dbo.fn_Link(s.Id, s.Name) AS SportId,
						AdminId,
						CreatorId,
						a.TableCount,
						a.UnitPrice,
						a.UnitType,
 						a.Distance,
						a.Lng,
						a.Lat
			FROM (
					SELECT ROW_NUMBER() OVER(ORDER BY Distance) AS RowNumber,
						Id,
						CityId,
						Name,
						HeadUrl,
						Address,
						State,
						SportId,
						IsUseVip,
						CreditLine ,
						Balance,
						AdminId,
						CreatorId,
						TableCount,
						UnitPrice,
						UnitType,
						Distance,
						ISNULL(Lat,0) Lat,
						ISNULL(Lng,0) Lng
					FROM (
								SELECT *,Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,ISNULL(Lat,0),ISNULL(Lng,0)) 
								FROM Venue WHERE 1=1' + @filter +'
							) z
					
            ) a 
			INNER JOIN City b ON a.CityId=b.Id
			INNER JOIN BaseData c ON a.State=c.Id
			INNER JOIN SportType s ON s.Id = a.SportId
 			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize
			ORDER BY a.State
			'
	
        EXEC SP_EXECUTESQL @sql,
            N'@name NVARCHAR(50),@cityCode NVARCHAR(50),@userId NVARCHAR(50),@curUserLat FLOAT,@curUserLng FLOAT,@pageIndex INT,@pageSize INT',
            @name, @cityCode, @userId, @curUserLat, @curUserLng, @pageIndex, @pageSize

		--PRINT @sql

    END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListForGraph]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE PROCEDURE [dbo].[sp_GetVenueListForGraph]
    @userId NVARCHAR(50) ,
	@creatorId NVARCHAR(50)='',
    @isOnlySelf NVARCHAR(50) ,
    @isUseVip NVARCHAR(50) ,
    @name NVARCHAR(50) ,
    @cityCode NVARCHAR(50) ,
	@curUserLng FLOAT,
	@curUserLat FLOAT,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT,
	@Distance INT
AS
    BEGIN
        SET NOCOUNT ON;
		 
		--ȡ�û�����Ա��־
        DECLARE @isAdmin BIT
        SELECT  @isAdmin = IsAdmin
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        IF @isAdmin IS NULL
            SET @isAdmin = 0

        --��������
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
		SET @filter=@filter+' AND State=''010002'' '
        IF ISNULL(@name, '') != ''
            SET @filter = @filter + ' AND name LIKE ''%''+@name+''%'''
                        
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'  

        IF ISNULL(@isUseVip, '') != ''
            SET @filter = @filter + ' AND IsUseVip=1'  
		--���� ��������
		DECLARE @distanceFilter NVARCHAR(MAX)
		SET @distanceFilter=''
		IF ISNULL(@Distance, 0) != 0
            SET @distanceFilter = @distanceFilter + ' AND Distance<@Distance'  
	
        --�鿴�Լ�������ȫ�����ݻ�������ͨ����˵ĳ��ݣ�����Ա�鿴����   
        IF @isAdmin = 0
            BEGIN
                IF ISNULL(@isOnlySelf, '') = '1'
                    SET @filter = @filter
                        + ' AND (CreatorId=@userId OR AdminId=@userId 
						OR Id IN ( --���ѹ��ĳ���
									SELECT VenueId FROM VipUse WHERE PayState=''024002'' AND UserId=@userId)) '  
               
            END

		--��ȡ������
        DECLARE @sql NVARCHAR(MAX);
        IF @pageIndex = 1
            BEGIN
                SET @sql = '	
				SELECT  
					@rowCount=COUNT(*)  
				FROM (
					SELECT Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,ISNULL(Lat,0),ISNULL(Lng,0))  
					FROM Venue 
					WHERE 1=1  ' + @filter +'
				) a
				WHERE  1=1 '+@distanceFilter
                  
                EXEC SP_EXECUTESQL @sql,
                    N'@name NVARCHAR(50),@cityCode NVARCHAR(50),@userId NVARCHAR(50),@rowCount INT OUTPUT,
					@curUserLat FLOAT,@curUserLng FLOAT,@Distance INT',
                    @name, @cityCode, @userId, @rowCount OUTPUT,
					@curUserLat, @curUserLng,@Distance

            END
        ELSE
            SET @rowCount = 0
            
        --��ȡÿҳ����
        SET @sql ='
			SELECT a.Id,a.Name,A.HeadUrl,
						dbo.fn_Link(b.Id,b.Name) AS CityId,
						a.Address,
						dbo.fn_GetReplyCount(a.Id) AS ReplyCount,
						dbo.fn_GetSignCount(a.Id) AS SignCount,
						a.IsUseVip,
						a.Balance,
						a.CreditLine,
						dbo.fn_Link(c.Id,c.Name) AS State ,
						dbo.fn_Link(s.Id, s.Name) AS SportId,
						AdminId,
						CreatorId,
						a.TableCount,
						a.UnitPrice,
						a.UnitType,
 						a.Distance,
						a.Lng,
						a.Lat 
			 
			FROM 
			(
					SELECT ROW_NUMBER() OVER(ORDER BY Distance) AS RowNumber,
						Id,
						CityId,
						Name,
						HeadUrl,
						Address,
						State,
						SportId,
						IsUseVip,
						CreditLine ,
						Balance,
						AdminId,
						CreatorId,
						TableCount,
						UnitPrice,
						UnitType,
						Distance,
						ISNULL(Lat,0) Lat,
						ISNULL(Lng,0) Lng
					FROM (
								SELECT 
									*,
									Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,ISNULL(Lat,0),ISNULL(Lng,0)) 
								FROM Venue 
								WHERE 1=1 ' + @filter +'
							) z
					WHERE  1=1  '  +@distanceFilter+ 
			'
            ) a 
			INNER JOIN City b ON a.CityId=b.Id
			INNER JOIN BaseData c ON a.State=c.Id
			INNER JOIN SportType s ON s.Id = a.SportId
 			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize
			--����SQL
			--SELECT * FROM #VenueList
			'
	
 
		EXEC SP_EXECUTESQL @sql,
            N'@name NVARCHAR(50),@cityCode NVARCHAR(50),@userId NVARCHAR(50),
			@curUserLat FLOAT,@curUserLng FLOAT,@creatorId NVARCHAR(50),
			@pageIndex INT,@pageSize INT,@Distance INT',
            @name, @cityCode, @userId, 
			@curUserLat, @curUserLng,@creatorId, 
			@pageIndex, @pageSize,@Distance

		--PRINT @sql
		

    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueSignList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--ָ��������ǩԼ��δǩԼ����
CREATE PROCEDURE [dbo].[sp_GetVenueSignList]
	@isSign BIT,
	@companyId NVARCHAR(50) ,
    @name NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX),@whereSql NVARCHAR(500),@selFields NVARCHAR(500),@joinSql NVARCHAR(500)
		SET @whereSql=''
		SET @selFields=''
		SET @joinSql=''

		IF @isSign = 1
			SET @whereSql = @whereSql + ' AND b.CompanyId=@companyId'
		ELSE
		BEGIN
			SET @whereSql = @whereSql + ' AND ISNULL(b.CompanyId, '''')='''''
			SET @selFields = ',RequestState=CASE WHEN d.[State]='''' THEN ''1'' WHEN d.[State] IS NULL THEN ''0'' ELSE d.[State] END
							  ,RequestReMsg=d.ReMsg'
			SET @joinSql = 'LEFT JOIN (
								SELECT x.* FROM CoachMsg x INNER JOIN
								(SELECT SenderId,ReceiverId,MAX(CreateDate) CreateDate FROM CoachMsg 
								WHERE SenderId=@senderId AND ReceiverType=''016003''
								GROUP BY SenderId,ReceiverId) y 
								ON x.SenderId = y.SenderId AND x.ReceiverId=y.ReceiverId AND x.CreateDate=y.CreateDate
							) d ON a.Id = d.ReceiverId'
		END

        IF ISNULL(@name, '') != ''
            SET @whereSql = @whereSql + ' AND name LIKE ''%''+@name+''%'''

		--��ȡ������
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Venue a LEFT JOIN CompanyVenues b ON a.Id=b.VenueId WHERE a.State=''010002''' + @whereSql       

                EXEC SP_EXECUTESQL @sql,
                    N'@companyId NVARCHAR(50),@name NVARCHAR(50),@rowCount INT OUTPUT',
                    @companyId,@name,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
           



		

        --��ȡÿҳ����
        SET @sql = 'SELECT a.Id,a.Name,A.HeadUrl,a.Address,a.IsUseVip,a.Mobile,a.CreatorId,
						dbo.fn_Link(b.Id,b.CardName) AS AdminId
						' + @selFields + ' 
			FROM (SELECT ROW_NUMBER() OVER(ORDER BY Name) AS RowNumber,a.Id,Name,HeadUrl,Address,IsUseVip,Mobile,AdminId,CreatorId
			FROM Venue a LEFT JOIN CompanyVenues b ON a.Id=b.VenueId WHERE a.State=''010002''' + @whereSql


        SET @sql = @sql
            + ') a 
			LEFT JOIN UserAccount b ON a.AdminId=b.Id 
			' + @joinSql + ' 
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'
	
        EXEC SP_EXECUTESQL @sql,
            N'@companyId NVARCHAR(50),@name NVARCHAR(50),@senderId NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @companyId, @name, @companyId, @pageIndex, @pageSize
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueTimetablesList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetVenueTimetablesList]
	@venueId		NVARCHAR(50),
	@includeCourse	BIT,
	@courseDate		DATETIME
AS
    BEGIN
        SET NOCOUNT ON;

		IF ISNULL(@includeCourse,0)=1
			SELECT Id,VenueId,BeginHour,BeginMinute,EndHour,EndMinute,ISNULL(b.StudentCount,0) StudentCount FROM CoachVenueTimetables a
			LEFT JOIN(SELECT a.TimeTableId,COUNT(a.UserId) StudentCount 
					FROM CoachCourseBook a 
					INNER JOIN CoachVenueTimetables b ON a.TimeTableId=b.Id 
					WHERE VenueId=@venueId AND dbo.fn_GetDate(a.BeginTime)=dbo.fn_GetDate(ISNULL(@courseDate,GETDATE()))
					GROUP BY a.TimeTableId
					) b ON a.Id=b.TimeTableId
			WHERE VenueId=@venueId
			ORDER BY BeginHour
		ELSE
			SELECT Id,VenueId,BeginHour,BeginMinute,EndHour,EndMinute FROM CoachVenueTimetables WHERE VenueId=@venueId
			ORDER BY BeginHour
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipAccount]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipAccount] @userId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  b.Id ,
                b.Code AS UserCode ,
                b.CardName AS UserName ,
                ISNULL(a.Amount, 0) AS Amount ,
                ISNULL(a.UsedAmount, 0) AS UsedAmount ,
				ISNULL(a.Balance, 0) AS Balance ,
				ISNULL(a.Refund, 0) AS Refund ,
                ISNULL(a.Score, 0) AS Score ,
                ISNULL(a.UsedScore, 0) AS UsedScore ,
				ISNULL(a.BalanceScore, 0) AS BalanceScore ,
                ( SELECT    COUNT(*)
                  FROM      dbo.VipBuy
                  WHERE     CreatorId = b.Id
                            AND ( PayState = '024001'
                                  OR PayState = '024003'--��֧������֧��ʧ�ܵ�
                                )
                ) AS PayCount,
				( SELECT    COUNT(*)
                  FROM      dbo.VipUse
                  WHERE     CreatorId = b.Id
                            AND ( PayState = '024001'
                                  OR PayState = '024003'--��֧������֧��ʧ�ܵ�
                                )
                ) AS PayUseCount
        FROM    dbo.UserAccount b
                LEFT JOIN VipAccount a ON b.Id = a.Id
        WHERE   b.Id = @userId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipAccountList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipAccountList]
    @userName NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)

		--��ȡ������
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM VipAccount a JOIN UserAccount b ON b.Id=a.UserId'
		
                IF ISNULL(@userName, '') != ''
                    SET @sql = @sql + ' WHERE b.CardName LIKE ''%' + @userName
                        + '%'''
			
                EXEC SP_EXECUTESQL @sql, N'@rowCount INT OUTPUT',
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0

		--��ȡÿҳ����
        SET @sql = ' SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY b.CardName) AS RowNumber, 
		                                a.Id ,
										b.Code AS UserCode,
										b.CardName AS UserName ,
										a.Amount ,
                                        a.UsedAmount ,
										a.Balance,
										a.Refund,
                                        a.Score ,
                                        a.UsedScore ,
										a.BalanceScore,
										a.CreateDate		
									FROM  VipAccount a
										INNER JOIN dbo.UserAccount b ON b.Id=a.Id'

        IF ISNULL(@userName, '') != ''
            SET @sql = @sql + ' WHERE b.CardName LIKE ''%' + @userName + '%'''

        SET @sql = @sql
            + ' ) AS temp WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'

        EXEC SP_EXECUTESQL @sql, N'@pageIndex INT,@pageSize INT', @pageIndex,
            @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipBuy]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipBuy]
    @id NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                a.OrderNo ,
                a.Amount ,
                A.GiveScale ,
                a.GiveAmount ,
                dbo.fn_Link(c.Id, c.Name) AS PayOption ,
                a.PayId ,
                dbo.fn_Link(d.Id, d.Name) AS PayState ,
                a.PayDate ,
                a.PayRemark ,
                a.Remark ,
                dbo.fn_Link(b.Id, b.CardName) AS CreatorId ,
                dbo.fn_Link(e.Id, e.CardName) AS UserId ,
                a.CreateDate
        FROM    VipBuy a
                LEFT JOIN UserAccount b ON b.Id = a.CreatorId
                LEFT JOIN UserAccount e ON e.Id = a.UserId
                LEFT JOIN BaseData c ON c.Id = a.PayOption
                LEFT JOIN BaseData d ON d.Id = a.PayState
        WHERE   a.Id = @id 
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipBuyList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipBuyList]
    @userId NVARCHAR(50) ,
    @userName NVARCHAR(50) ,
    @payState NVARCHAR(50) ,
    @beginDate DATE ,
    @endDate DATE ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--��������
        DECLARE @sqlFilter NVARCHAR(MAX);
        SET @sqlFilter = ''
        IF ISNULL(@userId, '') != ''
            SET @sqlFilter = @sqlFilter
                + ' AND (a.CreatorId = @userId OR a.UserId = @userId AND a.PayState=''024002'') '

        IF ISNULL(@payState, '') != ''
            SET @sqlFilter = @sqlFilter + ' AND a.PayState = @payState '

        IF ISNULL(@userName, '') != ''
            SET @sqlFilter = @sqlFilter + ' AND b.CardName LIKE ''%'
                + @userName + '%'' '

        IF ISNULL(@beginDate, '') != ''
            SET @sqlFilter = @sqlFilter
                + ' AND a.CreateDate1 BETWEEN  @beginDate AND @endDate '

        DECLARE @sql NVARCHAR(MAX);

		--��ȡ������
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM VipBuy a JOIN UserAccount b ON b.Id=a.CreatorId WHERE 1=1 '
                    + @sqlFilter
			
                EXEC SP_EXECUTESQL @sql,
                    N'@userId NVARCHAR(50),@payState NVARCHAR(50),@beginDate DATE ,@endDate DATE ,@rowCount INT OUTPUT',
                    @userId, @payState, @beginDate, @endDate, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0

		--��ȡÿҳ����
        SET @sql = 'SELECT * FROM ( SELECT a.Id,
						a.OrderNo,	
						a.Amount,A.GiveScale,A.GiveAmount,
						dbo.fn_Link(c.Id,c.Name) AS PayOption,
						a.PayId,
						dbo.fn_Link(d.Id,d.Name) AS PayState,
						a.PayDate,
						a.PayRemark,
						a.Remark,
						dbo.fn_Link(b.Id,b.CardName) AS CreatorId,
						a.CreateDate ,
						dbo.fn_Link(e.Id,e.CardName) AS UserId,
						ROW_NUMBER() OVER(ORDER BY a.CreateDate DESC) AS RowNumber
					FROM VipBuy a
						JOIN UserAccount b ON b.Id=a.CreatorId
						LEFT JOIN UserAccount e ON e.Id=a.UserId
						LEFT JOIN BaseData c ON c.Id=a.PayOption
						LEFT JOIN BaseData d ON d.Id=a.PayState
					WHERE 1=1 ' + @sqlFilter
            + ' ) AS temp WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'

        EXEC SP_EXECUTESQL @sql,
            N'@userId NVARCHAR(50),@payState NVARCHAR(50),@beginDate DATE ,@endDate DATE ,@pageIndex INT,@pageSize INT',
            @userId, @payState, @beginDate, @endDate, @pageIndex, @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipCityDiscount]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipCityDiscount] @cityId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX);
		
        SET @sql = 'SELECT A.Id
			,dbo.fn_Link(B.Id,B.Name) AS CityId
			,dbo.fn_Link(C.Id,C.Name) AS CategoryId
			,A.Discount
			,A.Common
			,A.CreatorId
			,A.CreateDate
			,A.LastDate
        FROM VipDiscount A
		JOIN dbo.City B ON B.Id = A.CityId
		JOIN dbo.BaseData C ON C.Id = A.CategoryId
		WHERE A.CityId= @cityId'

        EXEC SP_EXECUTESQL @sql, N'@cityId NVARCHAR(50)', @cityId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipCostScaleList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipCostScaleList]
    @companyId NVARCHAR(50) ,
    @costTypeId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
        SELECT  a.Id ,
                dbo.fn_Link(b.Id, b.Name) AS CompanyId ,
                dbo.fn_Link(c.Id, c.Name) AS CostTypeId ,
                a.YdlScale ,
                a.CompanyScale ,
                a.VenueScale ,
                a.Remark ,
                dbo.fn_Link(d.Id, d.CardName) AS CreatorId ,
				dbo.fn_Link(e.Id, e.Name) AS CityId ,
                a.CreateDate ,
                a.LastDate
        FROM    VipCostScale a
                JOIN dbo.Company b ON b.Id = a.CompanyId
                JOIN dbo.CostType c ON c.Id = a.CostTypeId
                JOIN dbo.UserAccount d ON d.Id = a.CreatorId
				JOIN dbo.City e ON e.Id = a.CityId
        WHERE   a.CompanyId = @companyId'

        IF ISNULL(@costTypeId, '') != ''
            SET @sql = @sql + ' AND a.CostTypeId=@costTypeId '

        SET @sql = @sql + ' ORDER BY a.CostTypeId '

        EXEC SP_EXECUTESQL @sql,
            N'@companyId NVARCHAR(50),@costTypeId NVARCHAR(50)', @companyId,
            @costTypeId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipDayBook]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetVipDayBook]
    @userId NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @sql NVARCHAR(MAX)

		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SELECT  @rowCount = ISNULL(@rowCount, 0) + COUNT(*)
                FROM    dbo.VipBuy
                WHERE   UserId = @userId--��ʵ�˻���
                        AND PayState = '024002'

                SELECT  @rowCount = ISNULL(@rowCount, 0) + COUNT(*)
                FROM    dbo.VipUse
                WHERE   CreatorId = @userId--֧����
                        AND PayState = '024002'

                SELECT  @rowCount = ISNULL(@rowCount, 0) + COUNT(*)
                FROM    dbo.VipRefund
                WHERE   UserId = @userId --�˿���
            END
        ELSE
            SET @rowCount = 0
		
		--��ҳȡ����	
        SET @sql = 'SELECT b.Id,b.MasterType,b.Amount,b.OtherAmount,b.PayDate,
						dbo.fn_link(c.Id,c.CardName) AS UserId,
						dbo.fn_link(d.Id,d.Name) AS PayOption 
			FROM (SELECT  a.*,ROW_NUMBER() OVER(ORDER BY PayDate DESC) AS RowNumber
			FROM    ( SELECT    Id ,
                    ''016011,��ֵ'' AS MasterType ,
					PayOption,
                    Amount + ISNULL(GiveAmount, 0)  AS Amount,
                    ISNULL(GiveAmount, 0) AS OtherAmount ,
                    UserId ,
                    PayDate
            FROM      dbo.VipBuy
            WHERE     PayState = ''024002'' AND UserId=@userId

            UNION ALL

            SELECT    Id ,
                    ''016007,����'' ,
					PayOption,
                    Amount ,
                    0 ,
                    CreatorId ,
                    PayDate
            FROM      dbo.VipUse
            WHERE     PayState = ''024002'' AND CreatorId=@userId

            UNION ALL

            SELECT    Id ,
                    ''016006,�˿�'' ,
					'''',
                    AppliedAmount ,
                    Amount ,
                    UserId ,
                    CreateDate
            FROM      dbo.VipRefund 
			WHERE UserId=@userId 

			) a ) b JOIN UserAccount c ON c.Id=b.UserId 
			LEFT JOIN BaseData d ON d.Id=b.PayOption
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'

        EXEC SP_EXECUTESQL @sql,
            N'@userId NVARCHAR(50),@pageIndex INT,@pageSize INT', @userId,
            @pageIndex, @pageSize

		
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipDiscount]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipDiscount] @id NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                dbo.fn_Link(d.Id, d.Name) AS CityId ,
                dbo.fn_Link(c.Id, c.Name) AS CategoryId ,
                a.Discount ,
                a.Common ,
                a.CreatorId ,
                a.CreateDate ,
                a.LastDate
        FROM    VipDiscount a
                LEFT JOIN dbo.BaseData c ON c.Id = a.CategoryId
                LEFT JOIN dbo.City d ON d.Id = a.CityId
        WHERE   a.Id = @id
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipDiscountList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipDiscountList]
    @cityId NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX);
		--��ȡ������
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM VipDiscount a WHERE 1=1 '
		
                IF ISNULL(@cityId, '') != ''
                    SET @sql = @sql + ' AND a.CityId = @cityId'
								
                EXEC SP_EXECUTESQL @sql,
                    N'@cityId NVARCHAR(50),@rowCount INT OUTPUT', @cityId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0

		--��ȡÿҳ����
        SET @sql = 'SELECT * FROM(SELECT a.Id
						,dbo.fn_Link(d.Id,d.Name) AS CityId
						,dbo.fn_Link(c.Id,c.Name) AS CategoryId
						,a.Discount
						,a.Common
						,a.CreatorId
						,a.CreateDate
						,a.LastDate
						,ROW_NUMBER() OVER(ORDER BY d.Name DESC) AS RowNumber
						FROM VipDiscount a
						LEFT JOIN dbo.BaseData c ON c.Id=a.CategoryId
						LEFT JOIN dbo.City d ON d.Id=a.CityId
					 WHERE 1=1 '

        IF ISNULL(@cityId, '') != ''
            SET @sql = @sql + ' AND a.CityId = @cityId'

        SET @sql = @sql
            + ' ) AS temp WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'

        EXEC SP_EXECUTESQL @sql,
            N'@cityId NVARCHAR(50),@pageIndex INT,@pageSize INT', @cityId,
            @pageIndex, @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipInnerDiscount]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipInnerDiscount] @id NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  a.Id ,
                dbo.fn_Link(b.Id, b.Name) AS VenueId ,
                dbo.fn_Link(c.Id, c.Name) AS CategoryId ,
                a.Discount ,
                a.CreatorId ,
                a.CreateDate ,
                a.LastDate
        FROM    VipInnerDiscount a
                JOIN dbo.Venue b ON b.Id = a.VenueId
                JOIN dbo.BaseData c ON c.Id = a.CategoryId
        WHERE   a.Id = @id
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipInnerDiscountList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipInnerDiscountList]
    @cityId NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX);
		--��ȡ������
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM VipInnerDiscount a JOIN dbo.Venue b ON b.Id = a.VenueId WHERE 1=1 '
		
                IF ISNULL(@cityId, '') != ''
                    SET @sql = @sql + ' AND b.CityId = @cityId'
								
                EXEC SP_EXECUTESQL @sql,
                    N'@cityId NVARCHAR(50),@rowCount INT OUTPUT', @cityId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0

		--��ȡÿҳ����
        SET @sql = 'SELECT * FROM (
						SELECT ROW_NUMBER() OVER(ORDER BY b.Name) AS RowNumber ,
		                a.Id ,
						dbo.fn_Link(b.Id, b.Name) AS VenueId ,
						dbo.fn_Link(c.Id, c.Name) AS CategoryId ,
						a.Discount ,
						a.CreatorId ,
						a.CreateDate ,
						a.LastDate
					FROM    VipInnerDiscount a
						JOIN dbo.Venue b ON b.Id = a.VenueId
						JOIN dbo.BaseData c ON c.Id = a.CategoryId 
					WHERE 1=1 '

        IF ISNULL(@cityId, '') != ''
            SET @sql = @sql + ' AND B.CityId = @cityId'

        SET @sql = @sql
            + ' ) AS temp WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'

        EXEC SP_EXECUTESQL @sql,
            N'@cityId NVARCHAR(50),@pageIndex INT,@pageSize INT', @cityId,
            @pageIndex, @pageSize
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipRefund]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipRefund] @id NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  A.Id ,
                A.OrderNo ,
                A.AppliedAmount ,
                A.Amount ,
                A.Remark ,
                dbo.fn_Link(D.Id, D.CardName) AS UserId ,
                dbo.fn_Link(b.Id, b.CardName) AS CreatorId ,
                A.CreateDate
        FROM    VipRefund A
                JOIN dbo.UserAccount D ON D.Id = A.UserId
                JOIN dbo.UserAccount b ON b.Id = A.CreatorId
        WHERE   A.Id = @id
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipRefundList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- ��ȡ�˿���б�
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipRefundList]
    @userId NVARCHAR(50) ,
    @beginDate NVARCHAR(50) ,
    @endDate NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sqlFilter NVARCHAR(MAX);
		--��������
        SET @sqlFilter = ' WHERE 1=1 '
        IF ISNULL(@userId, '') != ''
            SET @sqlFilter = @sqlFilter + ' AND a.UserId = @userId'

        IF ISNULL(@beginDate, '') != ''
            SET @sqlFilter = @sqlFilter
                + ' AND CONVERT(NVARCHAR(10),a.CreateDate,120) >= @beginDate'

        IF ISNULL(@endDate, '') != ''
            SET @sqlFilter = @sqlFilter
                + ' AND CONVERT(NVARCHAR(10),a.CreateDate,120) <= @endDate'

		DECLARE @sql NVARCHAR(MAX);
		--��ȡ������
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM VipRefund a '
                    + @sqlFilter				
                EXEC SP_EXECUTESQL @sql,
                    N'@userId NVARCHAR(50),@beginDate NVARCHAR(50),@endDate NVARCHAR(50),@rowCount INT OUTPUT',
                    @userId, @beginDate, @endDate, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0

		--��ȡÿҳ����
        SET @sql = 'SELECT * FROM (SELECT  A.Id ,
                A.OrderNo ,
                A.AppliedAmount ,
                A.Amount ,
                A.Remark ,
                dbo.fn_Link(D.Id, D.CardName) AS UserId ,
				dbo.fn_Link(b.Id, b.CardName) AS CreatorId,
                A.CreateDate,
				ROW_NUMBER() OVER(ORDER BY a.CreateDate DESC) AS RowNumber 
        FROM    VipRefund A 
		JOIN dbo.UserAccount D ON D.Id = A.UserId 
		JOIN dbo.UserAccount b ON b.Id = A.CreatorId'
            + @sqlFilter
            + ' ) AS temp WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'

        EXEC SP_EXECUTESQL @sql,
            N'@userId NVARCHAR(50),@beginDate NVARCHAR(50),@endDate NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @userId, @beginDate, @endDate, @pageIndex, @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipUse]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipUse]
    @id NVARCHAR(50) ,
    @isLiveUpdate BIT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @discount NVARCHAR(50)
        IF @isLiveUpdate = 1
            BEGIN
                DECLARE @venueId NVARCHAR(50)
                DECLARE @costTypeId NVARCHAR(50)
                SELECT  @venueId = VenueId ,
                        @costTypeId = CostTypeId
                FROM    dbo.VipUse
                WHERE   Id = @id

                
                SELECT  @discount = Discount
                FROM    dbo.VenueDiscount
                WHERE   VenueId = @venueId
                        AND CostTypeId = @costTypeId
                        AND CONVERT(NVARCHAR(10), GETDATE(), 120) BETWEEN CONVERT(NVARCHAR(10), BeginDate, 120)
                                                              AND
                                                              CONVERT(NVARCHAR(10), EndDate, 120)
            END
        SELECT  a.Id ,
                a.MasterId ,
                a.MasterType ,
                A.OrderNo ,
                a.CityId ,
                dbo.fn_Link(b.Id, b.Name) AS VenueId ,
                dbo.fn_Link(c.Id, c.Name) AS CostTypeId ,
                a.TotalAmount ,
                a.Discount ,
                CASE WHEN @isLiveUpdate = 0 THEN Amount
                     ELSE a.TotalAmount * ISNULL(@discount, 1)
                END AS Amount ,
                dbo.fn_Link(d.Id, d.Name) AS PayOption ,
                a.PayId ,
                dbo.fn_Link(e.Id, e.Name) AS PayState ,
                a.PayDate ,
                a.PayRemark ,
                a.Remark ,
				a.IsOwnCreate,
                f.PayNoPwdAmount ,
                CASE WHEN ISNULL(f.PayPassword, '') = '' THEN NULL
                     ELSE LEFT(a.Id, 6)
                END AS PayPassword ,
                dbo.fn_Link(f.Id, f.CardName) AS CreatorId ,
                dbo.fn_Link(h.Id, h.CardName) AS UserId ,
                a.CreateDate ,
                a.Lng ,
                a.Lat ,
                a.Address
        FROM    VipUse a
                LEFT JOIN dbo.Venue B ON B.Id = a.VenueId
                LEFT JOIN dbo.CostType c ON c.Id = a.CostTypeId
                LEFT JOIN dbo.BaseData d ON d.Id = a.PayOption
                LEFT JOIN dbo.BaseData e ON e.Id = a.PayState
                LEFT JOIN dbo.UserAccount f ON f.Id = a.CreatorId
                LEFT JOIN dbo.UserAccount h ON h.Id = a.UserId
        WHERE   a.Id = @id 
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipUseList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipUseList]
    @userId NVARCHAR(50) ,
    @userName NVARCHAR(50) ,
    @venueId NVARCHAR(50) ,
    @payState NVARCHAR(50) ,
    @beginDate DATE ,
    @endDate DATE ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX);
        DECLARE @sqlFilter NVARCHAR(MAX);
		--��������
        SET @sqlFilter = ''
        IF ISNULL(@userId, '') != ''
            SET @sqlFilter = @sqlFilter
                + ' AND (a.CreatorId = @userId OR a.UserId = @userId AND a.PayState=''024002'')'

        IF ISNULL(@payState, '') != ''
            SET @sqlFilter = @sqlFilter + ' AND a.PayState = @payState'

        IF ISNULL(@venueId, '') != ''
            SET @sqlFilter = @sqlFilter + ' AND a.VenueId = @venueId'

        IF ISNULL(@userName, '') != ''
            SET @sqlFilter = @sqlFilter + ' AND b.CardName LIKE ''%'
                + @userName + '%'''

        IF ISNULL(@beginDate, '') != ''
            SET @sqlFilter = @sqlFilter
                + ' AND a.CreateDate1 BETWEEN  @beginDate AND @endDate '
		--��ȡ������
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM VipUse a JOIN UserAccount b ON b.Id=a.CreatorId WHERE 1=1 '
                    + @sqlFilter
                EXEC SP_EXECUTESQL @sql,
                    N'@userId NVARCHAR(50),@payState NVARCHAR(50),@venueId NVARCHAR(50),@beginDate DATE ,@endDate DATE ,@rowCount INT OUTPUT',
                    @userId, @payState, @venueId, @beginDate, @endDate,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0

		--��ȡÿҳ����
        SET @sql = 'SELECT * FROM(SELECT a.Id
					,A.OrderNo
					,a.MasterId
					,a.MasterType
					,a.CityId
					,dbo.fn_Link(b.Id,b.Name) AS VenueId
					,dbo.fn_Link(c.Id,c.Name) AS CostTypeId
					,a.TotalAmount
					,a.Discount
					,a.Amount
					,dbo.fn_Link(d.Id,d.Name) AS PayOption
					,a.PayId
					,dbo.fn_Link(e.Id,e.Name) AS PayState
					,a.PayDate
					,a.PayRemark
					,a.Remark
					,a.IsOwnCreate
					,dbo.fn_Link(f.Id,f.CardName) AS CreatorId
					,dbo.fn_Link(h.Id, h.CardName) AS UserId 
					,a.CreateDate
					,a.Lng
					,a.Lat
					,a.Address
					,ROW_NUMBER() OVER(ORDER BY a.CreateDate DESC) AS RowNumber
					FROM VipUse a
					LEFT JOIN dbo.Venue B ON B.Id=a.VenueId
					LEFT JOIN dbo.CostType c ON c.Id=a.CostTypeId
					LEFT JOIN dbo.BaseData d ON d.Id=a.PayOption
					LEFT JOIN dbo.BaseData e ON e.Id=a.PayState
					LEFT JOIN dbo.UserAccount f ON f.Id=a.CreatorId
					LEFT JOIN dbo.UserAccount h ON h.Id = a.UserId
					WHERE 1=1 ' + @sqlFilter
            + ' ) AS temp WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'

        EXEC SP_EXECUTESQL @sql,
            N'@userId NVARCHAR(50),@payState NVARCHAR(50),@venueId NVARCHAR(50),@beginDate DATE ,@endDate DATE ,@pageIndex INT,@pageSize INT',
            @userId, @payState, @venueId, @beginDate, @endDate, @pageIndex,
            @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBill]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipVenueBill] @id NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT  a.Id ,
                a.BeginDate ,
                a.OrderNo ,
                a.EndDate ,
                dbo.fn_Link(b.Id, b.Name) AS VenueId ,
                a.TotalAmount ,
                a.Discount ,
                a.Amount ,
                dbo.fn_Link(c.Id, c.Name) AS PayOption ,
                a.PayId ,
                dbo.fn_Link(d.Id, d.Name) AS PayState ,
                a.PayDate ,
                a.PayRemark ,
                a.Remark ,
                dbo.fn_Link(e.Id, e.Name) AS State ,
                b.AlipayId ,
                a.CreatorId ,
                a.CreateDate
        FROM    VenueBill a
                JOIN Venue b ON b.Id = A.VenueId
                LEFT JOIN dbo.BaseData c ON c.Id = A.PayOption
                LEFT JOIN dbo.BaseData d ON d.Id = A.PayState
                LEFT JOIN dbo.BaseData e ON e.Id = A.State
        WHERE   a.Id = @id
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBillDetailList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipVenueBillDetailList]
    @isPayDate BIT ,
    @venueId NVARCHAR(50) ,
    @payState NVARCHAR(50) ,
    @beginDate DATETIME ,
    @endDate DATETIME ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX);
		--��ȡ������
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM VipUse a WHERE '
                SET @sql = @sql
                    + CASE WHEN @isPayDate = 1
                           THEN ' CONVERT(NVARCHAR(10),a.PayDate,120) '
                           ELSE ' CONVERT(NVARCHAR(10),a.CreateDate,120) '
                      END
                    + ' BETWEEN CONVERT(NVARCHAR(10),@beginDate,120) AND CONVERT(NVARCHAR(10),@endDate,120)'

                IF ISNULL(@payState, '') != ''
                    SET @sql = @sql + ' AND a.PayState = @payState'

                IF ISNULL(@venueId, '') != ''
                    SET @sql = @sql + ' AND a.VenueId = @venueId'

                EXEC SP_EXECUTESQL @sql,
                    N'@payState NVARCHAR(50),@venueId NVARCHAR(50),@beginDate DATETIME,@endDate DATETIME,@rowCount INT OUTPUT',
                    @payState, @venueId, @beginDate, @endDate,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0

		--��ȡÿҳ����
        SET @sql = 'SELECT * FROM(SELECT a.Id,A.OrderNo
		,a.CityId
      ,dbo.fn_Link(b.Id,b.Name) AS VenueId
      ,dbo.fn_Link(c.Id,c.Name) AS CategoryId
      ,a.TotalAmount
      ,a.Discount
      ,a.Amount
      ,dbo.fn_Link(d.Id,d.Name) AS PayOption
      ,a.PayId
      ,dbo.fn_Link(e.Id,e.Name) AS PayState
      ,a.PayDate
      ,a.PayRemark
      ,a.Remark
      ,dbo.fn_Link(f.Id,f.CardName) AS CreatorId
	  ,dbo.fn_Link(h.Id, h.CardName) AS UserId 
      ,a.CreateDate
      ,a.Lng
      ,a.Lat
      ,a.Address
	  ,ROW_NUMBER() OVER(ORDER BY a.CreateDate DESC) AS RowNumber
  FROM VipUse a
  LEFT JOIN dbo.Venue B ON B.Id=a.VenueId
  LEFT JOIN dbo.BaseData c ON c.Id=a.CategoryId
  LEFT JOIN dbo.BaseData d ON d.Id=a.PayOption
  LEFT JOIN dbo.BaseData e ON e.Id=a.PayState
  LEFT JOIN dbo.UserAccount f ON f.Id=a.CreatorId
  LEFT JOIN dbo.UserAccount h ON h.Id = a.UserId
  WHERE '

        SET @sql = @sql
            + CASE WHEN @isPayDate = 1
                   THEN ' CONVERT(NVARCHAR(10),a.PayDate,120) '
                   ELSE ' CONVERT(NVARCHAR(10),a.CreateDate,120) '
              END
            + ' BETWEEN CONVERT(NVARCHAR(10),@beginDate,120) AND CONVERT(NVARCHAR(10),@endDate,120)'

        IF ISNULL(@payState, '') != ''
            SET @sql = @sql + ' AND a.PayState = @payState'

        IF ISNULL(@venueId, '') != ''
            SET @sql = @sql + ' AND a.VenueId = @venueId'

        SET @sql = @sql
            + ' ) AS temp WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'

        EXEC SP_EXECUTESQL @sql,
            N'@payState NVARCHAR(50),@venueId NVARCHAR(50),@beginDate DATETIME,@endDate DATETIME,@pageIndex INT,@pageSize INT',
            @payState, @venueId, @beginDate, @endDate, @pageIndex, @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBillList]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- ��ȡ�ڲ����ݽ��㵥���б�
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVipVenueBillList]
    @cityId NVARCHAR(50) ,
    @venueId NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX);
		--��ȡ������
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM VenueBill a JOIN Venue b ON b.Id=A.VenueId WHERE 1=1 '
		
                IF ISNULL(@cityId, '') != ''
                    SET @sql = @sql + ' AND b.CityId = @cityId'

                IF ISNULL(@venueId, '') != ''
                    SET @sql = @sql + ' AND A.VenueId = @venueId'
								
                EXEC SP_EXECUTESQL @sql,
                    N'@cityId NVARCHAR(50),@venueId NVARCHAR(50),@rowCount INT OUTPUT', @cityId,@venueId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0

		--��ȡÿҳ����
        SET @sql = 'SELECT * FROM (SELECT  a.Id ,
			a.BeginDate ,
			a.EndDate ,
			a.OrderNo,
			dbo.fn_Link(b.Id, b.Name) AS VenueId ,
			a.TotalAmount ,
			a.Discount ,
			a.Amount ,
			dbo.fn_Link(c.Id, c.Name) AS PayOption ,
			a.PayId ,
			dbo.fn_Link(d.Id, d.Name) AS PayState ,
			a.PayDate ,
			a.PayRemark ,
			a.Remark ,
			dbo.fn_Link(e.Id, e.Name) AS State ,
			a.CreatorId ,
			a.CreateDate,
			ROW_NUMBER() OVER(ORDER BY a.CreateDate DESC) AS RowNumber 
		FROM    VenueBill a
			JOIN Venue b ON b.Id = A.VenueId
			LEFT JOIN dbo.BaseData c ON c.Id = A.PayOption
			LEFT JOIN dbo.BaseData d ON d.Id = A.PayState
			LEFT JOIN dbo.BaseData e ON e.Id = A.State
		WHERE 1=1 '

        IF ISNULL(@cityId, '') != ''
            SET @sql = @sql + ' AND b.CityId = @cityId'

        IF ISNULL(@venueId, '') != ''
            SET @sql = @sql + ' AND A.VenueId = @venueId'

        SET @sql = @sql
            + ' ) AS temp WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize'

        EXEC SP_EXECUTESQL @sql,
            N'@cityId NVARCHAR(50),@venueId NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @cityId, @venueId, @pageIndex, @pageSize
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_QueryBillReport]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_QueryBillReport]
    @isPayDate BIT ,--�Ƿ񸶿�����
    @hasNoPay BIT ,--�Ƿ����δ����
    @beginDate DATE ,--��ʼ����
    @endDate DATE ,--��������
    @companyId NVARCHAR(50) ,--��˾���
    @venueId NVARCHAR(50)--���ݱ��
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
        SELECT  CASE WHEN c.Id IS NULL THEN A.CompanyId
                     ELSE dbo.fn_Link(c.Id, c.Name)
                END AS CompanyId ,
                CASE WHEN b.Id IS NULL THEN A.VenueId
                     ELSE dbo.fn_Link(b.Id, b.Name)
                END AS VenueId ,
                CASE WHEN d.Id IS NULL THEN A.CostTypeId
                     ELSE dbo.fn_Link(d.Id, d.Name)
                END AS CostTypeId ,
                YdlAmount ,
                CompanyAmount ,
                VenueAmount ,
                Total
        FROM    ( SELECT    CASE WHEN GROUPING(x.CompanyId) = 0
                                 THEN x.CompanyId
                                 ELSE ''�ܼ�''
                            END AS CompanyId ,
                            CASE WHEN GROUPING(b.Id) = 0 THEN b.Id
                                 WHEN GROUPING(x.CompanyId) = 1 THEN ''''
                                 ELSE ''�ϼ�''
                            END AS VenueId ,
                            CASE WHEN GROUPING(a.CostTypeId) = 0
                                 THEN a.CostTypeId
                                 WHEN GROUPING(b.Id) = 1 THEN ''''
                                 ELSE ''С��''
                            END AS CostTypeId ,
                            ROUND(SUM(Amount * ISNULL(e.YdlScale, 0)), 2) AS YdlAmount ,
                            ROUND(SUM(Amount * ISNULL(e.CompanyScale, 0)), 2) AS CompanyAmount ,
                            ROUND(SUM(Amount * ISNULL(e.VenueScale, 0)), 2) AS VenueAmount ,
                            ROUND(SUM(Amount), 2) AS Total
                  FROM      dbo.VipUse a
							JOIN CompanyVenues x ON x.VenueId=a.VenueId
							JOIN dbo.Company c ON c.Id = x.CompanyId
                            JOIN dbo.Venue b ON b.Id = a.VenueId
                            LEFT JOIN dbo.VipCostScale e ON e.CompanyId = x.CompanyId
                                                            AND e.CityId = a.CityId
                                                            AND e.CostTypeId = a.CostTypeId 
				  WHERE 1=1 '
        IF ISNULL(@companyId, '') != ''
            SET @sql = @sql + ' AND x.CompanyId=@companyId '

        IF ISNULL(@venueId, '') != ''
            SET @sql = @sql + ' AND a.VenueId=@venueId '
			
        IF @isPayDate = 1
            SET @sql = @sql
                + ' AND a.PayDate1 BETWEEN @beginDate AND @endDate '
        ELSE
            SET @sql = @sql
                + ' AND a.CreateDate1 BETWEEN @beginDate AND @endDate '

        IF @hasNoPay = 1
            SET @sql = @sql + ' AND a.PayState IN (''024001'',''024002'') '
        ELSE
            SET @sql = @sql + ' AND a.PayState=''024002'' '

        SET @sql = @sql + ' GROUP BY  ROLLUP(x.CompanyId, b.Id, a.CostTypeId)
                ) a
                LEFT JOIN dbo.Venue b ON b.Id = a.VenueId
                LEFT JOIN dbo.Company c ON c.Id = a.CompanyId
                LEFT JOIN dbo.CostType d ON d.Id = a.CostTypeId '

        EXEC SP_EXECUTESQL @sql,
            N'@beginDate DATE,@endDate DATE,@companyId NVARCHAR(50),@venueId NVARCHAR(50)',
            @beginDate, @endDate, @companyId, @venueId

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_QueryRechargeReport]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_QueryRechargeReport]
    @year INT ,--���
    @beginMonth INT ,--��ʼ��
    @endMonth INT --������
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
		SELECT  CASE WHEN GROUPING(MONTH(PayDate)) = 1 THEN ''�ϼ�'' ELSE CAST(MONTH(PayDate) AS NVARCHAR(10)) + ''��'' END AS MONTH ,
				SUM(ISNULL(Amount, 0)) AS Amount ,
				SUM(ISNULL(GiveAmount, 0)) AS GiveAmount ,
				SUM(ISNULL(Amount, 0) + ISNULL(GiveAmount, 0)) AS Total
		FROM    dbo.VipBuy
		WHERE   YEAR(PayDate) = @year AND MONTH(PayDate) BETWEEN @beginMonth AND @endMonth
		GROUP BY ROLLUP(MONTH(PayDate)) '

        EXEC SP_EXECUTESQL @sql, N'@year INT,@beginMonth INT,@endMonth INT',
            @year, @beginMonth, @endMonth

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_RemoveVenueTimetables]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RemoveVenueTimetables]
    @Id			NVARCHAR(50),
	@errCode	INT OUTPUT,
	@errMsg		NVARCHAR(200) OUTPUT
AS
    BEGIN
		SET NOCOUNT ON;

		SET @errCode=0
		SET @errMsg=''


		IF EXISTS(SELECT 1 FROM CoachAutoBookSettings WHERE TimeTableId=@Id)
			OR EXISTS(SELECT 1 FROM CoachCourse WHERE TimeTableId=@Id)
			OR EXISTS(SELECT 1 FROM CoachCourseBook WHERE TimeTableId=@Id)
		BEGIN
			SET @errCode=-1
			SET @errMsg='�˿γ�ʱ������ʹ���У��޷�ɾ����'
		END
		ELSE
			DELETE FROM CoachVenueTimetables WHERE Id=@Id

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_ResetGameLoop]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ResetGameLoop] @loopId NVARCHAR(50)
AS
    BEGIN
        IF ISNULL(@loopId, '') != ''
            BEGIN
				--ɾ���������
                DELETE  dbo.GameLoopMap
                WHERE   LoopId = @loopId

				--ɾ���ȷ�
                DELETE  dbo.GameLoopDetail
                WHERE   LoopId = @loopId

				--����Ϊ��ʼ״̬
                UPDATE  dbo.GameLoop
                SET     Score1 = 0 ,
                        Score2 = 0 ,
                        Team1 = 0 ,
                        Team2 = 0 ,
                        Game1 = 0 ,
                        Game2 = 0 ,
                        Fen1 = 0 ,
                        Fen2 = 0 ,
                        IsBye = 0 ,
                        WaiverOption = '' ,
                        WinSign = '' ,
                        JudgeSign = '' ,
                        StartTime = NULL ,
                        EndTime = NULL ,
                        State = '011001'
                WHERE   Id = @loopId
                        AND State = '011003'
            END

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveCity]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveCity] 
    @cityCode NVARCHAR(50) ,
    @cityName NVARCHAR(50)
AS
    BEGIN
        IF NOT EXISTS ( SELECT  *
                        FROM    dbo.City
                        WHERE   Id = CityCode )
            INSERT  INTO dbo.City
                    ( Id ,
                      CityCode ,
                      Name ,
                      ParentId ,
                      Lat ,
                      Lng ,
                      CreateDate
	                )
            VALUES  ( @cityCode , -- Id - nvarchar(50)
                      @cityCode , -- CityCode - nvarchar(50)
                      @cityName , -- Name - nvarchar(50)
                      NULL , -- ParentId - nvarchar(50)
                      NULL , -- Lat - float
                      NULL , -- Lng - float
                      GETDATE()  -- CreateDate - datetime
	                )

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveClubRequest]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveClubRequest]
    @clubId NVARCHAR(50) ,
    @userId NVARCHAR(50) ,
    @remark NVARCHAR(MAX) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        BEGIN TRY
            IF EXISTS ( SELECT  *
                        FROM    ClubRequest
                        WHERE   ClubId = @clubId
                                AND CreatorId = @userId
                                AND State = '003001' )
                RAISERROR('�Ѿ������˼������룬��ȴ����ֲ�����Ա����',11,1)

            IF EXISTS ( SELECT  *
                        FROM    ClubUser
                        WHERE   ClubId = @clubId
                                AND UserId = @userId )
                RAISERROR('�Ѿ��Ǿ��ֲ���Ա����ˢ�½��档',11,1)

            INSERT  dbo.ClubRequest
                    ( Id ,
                      ClubId ,
                      Remark ,
                      State ,
                      CreatorId ,
                      CreateDate
				    )
            VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                      @clubId , -- ClubId - nvarchar(50)
                      @remark , -- Remark - nvarchar(max)
                      N'003001' , -- State - nvarchar(50)
                      @userId , -- CreatorId - nvarchar(50)
                      GETDATE()  -- CreateDate - datetime
				    )

        END TRY

        BEGIN CATCH
            SET @message = ERROR_MESSAGE()
        END CATCH
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveCoachCourseJoin]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_SaveCoachCourseJoin]
    @StudentUserId NVARCHAR(50) ,
	@CoacherUserId NVARCHAR(50) ,
    @CourseId NVARCHAR(50) ,
	@CityId NVARCHAR(50),
	@Type NVARCHAR(10), -- Join Ϊ����, NotJoin Ϊȡ������
    @message NVARCHAR(200) OUTPUT,
	@ThenCourseUnitPrice DECIMAL(18,2) OUTPUT  --ѧԱ���� ��ʱ�Ŀγ̵���

AS
    BEGIN
		DECLARE @Id NVARCHAR(50) ,@sql NVARCHAR(MAX)
		SET @sql=''
        --�ҵ���Ҫ�����Ŀγ�����(��λ���˽��...)
		DECLARE @CourseTypeId NVARCHAR(50)
		SELECT @CourseTypeId=Type FROM dbo.CoachCourse WHERE Id=@CourseId

		--�ҵ��ҵ�����¼
		SET @sql+='
			SELECT * INTO #CoacherStudentMoney
			FROM dbo.CoachStudentMoney 
			WHERE  StudentUserId=@StudentUserId AND CityId=@CityId
		'
		IF	@CourseTypeId='027003'  -- ˽�̲�ȥƥ������ֶ�, ��β���
			SET @sql+='   AND CoachId=@CoacherUserId  '


		
		BEGIN TRY
		IF @Type='Join' 
		----------------------------------------------���� ������һ ------------��ʼ---------------------------------
		BEGIN
			--�ҵ�û���ڵ�, ʣ���������0��, ����ʱ����С����������, ��ǰ���е�, �����п۳�һ��
			SET @sql+='
			SELECT
				TOP 1
				@Id=Id
 			FROM #CoacherStudentMoney 
			WHERE CourseTypeId=@CourseTypeId  AND Amount>0 AND CityId=@CityId
			'
			IF	@CourseTypeId!='027003'  --˽��û�� ��Ч������ , �����
				SET @sql+=' AND Deadline>GETDATE() '
			
			SET @sql+='
		    ORDER BY Deadline
			' 
			SET @sql +=' DROP TABLE #CoacherStudentMoney  '

			 EXEC SP_EXECUTESQL @sql,
            N'@CityId NVARCHAR(50),@CoacherUserId NVARCHAR(50),@StudentUserId NVARCHAR(50),
			@CourseTypeId NVARCHAR(50),@Id NVARCHAR(50) OUTPUT',
             @CityId,@CoacherUserId, @StudentUserId,@CourseTypeId,@Id OUTPUT

			
			IF	ISNULL(@Id,'')!='' --�д���
			BEGIN
				--������һ
				UPDATE dbo.CoachStudentMoney SET Amount=Amount-1 WHERE Id=@Id
				--���㱨����ڿ�ʱ�����ѵ��� =��ʱ�����ܼ�/�ܴ���  , �������������ͳ����  ---��ʼ
				SELECT @ThenCourseUnitPrice=ThenMoney/ThenTotalAmount 
				FROM dbo.CoachStudentMoney WHERE Id=@Id
				----����ʱ�Ŀγ̵��� ���µ�������¼��
				--UPDATE dbo.CoachCourseJoin SET ThenCourseUnitPrice=@ThenCourseUnitPrice 
				--WHERE CourseId=@CourseId AND StudentId=@StudentUserId 
				--���㱨����ڿ�ʱ�����ѵ��� =��ʱ�����ܼ�/�ܴ���  , �������������ͳ����  ---����
			END
			ELSE	--����Ϊ0
			BEGIN
					RAISERROR('���������Ϊ0,���ֵ',11,1)
			END


		----------------------------------------------���� ������һ ------------����---------------------------------
		END
		ELSE 
		----------------------------------------------ȡ������  ������һ ------------��ʼ---------------------------------
		BEGIN
			--�ҵ�û���ڵ�, ����ʱ����С���������� ����һ��
			SET @sql+='
			SELECT
				TOP 1
				@Id=Id
 			FROM #CoacherStudentMoney 
			WHERE CourseTypeId=@CourseTypeId 
					AND Deadline>GETDATE() AND CityId=@CityId
			ORDER BY Deadline 
			'
			SET @sql +=' DROP TABLE #CoacherStudentMoney  '
			EXEC SP_EXECUTESQL @sql,
            N'@CityId NVARCHAR(50),@CoacherUserId NVARCHAR(50),@StudentUserId NVARCHAR(50),
			@CourseTypeId NVARCHAR(50),@Id NVARCHAR(50) OUTPUT',
             @CityId,@CoacherUserId, @StudentUserId,@CourseTypeId,@Id OUTPUT

			IF	ISNULL(@Id,'')!=''
				UPDATE dbo.CoachStudentMoney SET Amount=Amount+1 WHERE Id=@Id
			--ELSE
				--RAISERROR('�������ѹ���,����ȡ����������,���᷵�ش�������Ĺ����˻�',11,1)

			---���Դ���----------��ʼ		
			--SELECT
			--	TOP 1
			-- *
 		--		FROM #CoacherStudentMoney 
			--WHERE CourseTypeId=@CourseTypeId AND Deadline>GETDATE()
			--ORDER BY Deadline  
			---���Դ���----------����
					
		END
		----------------------------------------------ȡ������  ������һ ------------����---------------------------------
 

		END TRY

        BEGIN CATCH
            SET @message = ERROR_MESSAGE()
        END CATCH
		--PRINT @Id

		
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveCourseAutoBookSettings]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaveCourseAutoBookSettings] 
    @userId			NVARCHAR(50),
	@venueId		NVARCHAR(50),
	@itemXML		TEXT--�Զ�ԤԼ�γ�ʱ��
AS
    BEGIN
		Set XACT_ABORT ON
		BEGIN  TRAN

		IF NOT EXISTS(SELECT 1 FROM VenueStudents WHERE UserId=@userId AND VenueId=@venueId)
			INSERT INTO VenueStudents(Id,UserId,VenueId,IsCourseAutoBook,CreateDate)
				VALUES(NEWID(),@userId,@venueId,1,GETDATE())
		ELSE
			UPDATE VenueStudents SET IsCourseAutoBook=1 WHERE UserId=@userId AND VenueId=@venueId



		DELETE FROM CoachAutoBookSettings WHERE UserId=@userId AND VenueId=@venueId

		--����XML
		DECLARE @XMLHANDLER INT
		EXEC SP_XML_PREPAREDOCUMENT @XMLHANDLER OUTPUT,@itemXML


		INSERT INTO dbo.CoachAutoBookSettings
		        ( Id, UserId, VenueId, TimeTableId, [WeekDay] )
		SELECT NEWID(),@userId,@venueId,TimeId,WeekNum FROM OPENXML(@XMLHANDLER,'/AutoBooks/Item',1)
								WITH(TimeId NVARCHAR(50),WeekNum NVARCHAR(20))


		EXEC SP_XML_REMOVEDOCUMENT @XMLHANDLER;

		COMMIT TRAN
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveGameGroupLeader]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveGameGroupLeader]
    @groupId NVARCHAR(50) ,
    @leaderId NVARCHAR(50) ,
    @tableNo NVARCHAR(50)
AS
    BEGIN   
		--����С�鱾���ֶ�
        UPDATE  dbo.GameGroup
        SET     LeaderId = @leaderId ,
                TableNo = @tableNo
        WHERE   Id = @groupId

		--����С���������
        UPDATE  dbo.GameLoop
        SET     JudgeId = @leaderId
        WHERE   GroupId = @groupId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveMsgReg]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveMsgReg]
    @userId NVARCHAR(50) ,
    @regId NVARCHAR(500)
AS
    BEGIN
        IF NOT EXISTS ( SELECT  *
                        FROM    dbo.MsgReg
                        WHERE   Id = @userId )

            INSERT  INTO dbo.MsgReg
                    ( Id, RegId, CreateDate,UpdateDate )
            VALUES  ( @userId, @regId, GETDATE(),GETDATE() )
        ELSE
            BEGIN
                DECLARE @temp NVARCHAR(50)

                SELECT  @temp = RegId
                FROM    dbo.MsgReg
                WHERE   Id = @userId

                IF @regId != @temp
                    UPDATE  dbo.MsgReg
                    SET     RegId = @regId ,
                            UpdateDate = GETDATE()
                    WHERE   Id = @userId
            END
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveNoteSupport]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveNoteSupport]
    @noteId NVARCHAR(50) ,
    @userId NVARCHAR(50)
AS
    BEGIN
        IF EXISTS ( SELECT  *
                    FROM    dbo.NoteSupport
                    WHERE   NoteId = @noteId
                            AND UserId = @userId )
            DELETE  FROM dbo.NoteSupport
            WHERE   NoteId = @noteId
                    AND UserId = @userId
        ELSE
            INSERT  INTO dbo.NoteSupport
                    ( Id ,
                      NoteId ,
                      UserId ,
                      CreateDate
                    )
            VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                      @noteId , -- NoteId - nvarchar(50)
                      @userId , -- UserId - nvarchar(50)
                      GETDATE()  -- CreateDate - datetime
	                )
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveQuickUser]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveQuickUser]
    @userId NVARCHAR(50) ,
	@sex NVARCHAR(50) ,
    @petName NVARCHAR(50) ,
	@cardName NVARCHAR(50) ,
    @mobile NVARCHAR(50) ,
    @cityId NVARCHAR(50) ,
    @password NVARCHAR(50) ,
    @headUrl NVARCHAR(50) ,
    @lat FLOAT ,
    @lng FLOAT ,
    @address NVARCHAR(500) ,
    @userCode NVARCHAR(50) OUTPUT ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
		--����ϵͳ��
        UPDATE  dbo.Config
        SET     MaxID = MaxID + 1

        DECLARE @code NVARCHAR(50)
        SELECT  @code = CAST(MaxID AS NVARCHAR(50))
        FROM    dbo.Config

        SET @userCode = @code
		--�����û���Ϣ
        INSERT  dbo.UserAccount
                ( Id ,
                  CityId ,
                  Code ,
                  Password ,
                  PayPassword ,
                  PayNoPwdAmount ,
                  CardId ,
                  CardName ,
                  AliPayId ,
                  Sex ,
                  QQ ,
                  PetName ,
                  Weixin ,
                  CompanyId ,
                  IsAdmin ,
                  IsStop ,
                  IsJudge ,
                  Birthday ,
                  Mobile ,
                  Address ,
                  Lat ,
                  Lng ,
                  SignName ,
                  HeadUrl ,
                  Remark ,
                  CreateDate
		        )
        VALUES  ( @userId , -- Id - nvarchar(50)
                  @cityId , -- CityId - nvarchar(50)
                  @code , -- Code - nvarchar(50)
                  @password , -- Password - nvarchar(50)
                  N'' , -- PayPassword - nvarchar(50)
                  0 , -- PayNoPwdAmount - int
                  N'' , -- CardId - nvarchar(50)
                  ISNULL(@cardName,@petName) , -- CardName - nvarchar(50)
                  N'' , -- AliPayId - nvarchar(200)
                  @sex , -- Sex - nvarchar(50)
                  N'' , -- QQ - nvarchar(50)
                  @petName , -- PetName - nvarchar(50)
                  N'' , -- Weixin - nvarchar(50)
                  N'' , -- CompanyId - nvarchar(50)
                  0 , -- IsAdmin - bit
                  0 , -- IsStop - bit
                  0 , -- IsJudge - bit
                  NULL , -- Birthday - datetime
                  @mobile , -- Mobile - nvarchar(50)
                  @address , -- Address - nvarchar(50)
                  @lat , -- Lat - float
                  @lng , -- Lng - float
                  N'' , -- SignName - nvarchar(50)
                  @headUrl , -- HeadUrl - nvarchar(200)
                  N'' , -- Remark - nvarchar(max)
                  GETDATE()  -- CreateDate - datetime
		        )
		--����Ĭ��Ȩ��
        INSERT  dbo.UserLimit
                ( Id ,
                  UserId ,
                  IsClub ,
                  IsVenue ,
                  IsGame ,
				  IsScoreGame ,
                  IsActivity ,
                  IsNote ,
                  IsCompany ,
                  CreateDate
				 )
        VALUES  ( @userId , -- Id - nvarchar(50)
                  @userId , -- UserId - nvarchar(50)
                  1 , -- IsClub - bit
                  1 , -- IsVenue - bit
                  1 , -- IsGame - bit
				  0 , -- IsScoreGame
                  1 , -- IsActivity - bit
                  1 , -- IsNote - bit
                  0 , -- IsCompany - bit
                  GETDATE()  -- CreateDate - datetime
				 )
		--����Ĭ���˶�����
        INSERT  dbo.UserSport
                ( Id ,
                  UserId ,
                  SportId ,
                  IsActive ,
                  ProType ,
                  GripOption ,
                  Score ,
                  CreateDate
						
                )
        VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                  @userId , -- UserId - nvarchar(50)
                  N'474C2709-325E-49F7-AB66-A676C40B2EA6' , -- SportId - nvarchar(50)
                  0 , -- IsActive - bit
                  N'001002' , -- ProType - nvarchar(50)
                  N'002001' , -- GripOption - nvarchar(50)
                  1500 , -- Score - int
                  GETDATE()  -- CreateDate - datetime
						
                )

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveUserSport]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveUserSport]
    @Id NVARCHAR(50) ,
    @UserId NVARCHAR(50) ,
    @SportId NVARCHAR(50) ,
    @IsActive BIT ,
    @ProType NVARCHAR(50) ,
    @GripOption NVARCHAR(50) ,
    @Score INT ,
    @actionCode INT ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN   
		--��֤�½����޸�
        IF ( @actionCode = 1
             OR @actionCode = 2
           )
            AND EXISTS ( SELECT *
                         FROM   dbo.UserSport
                         WHERE  Id != ISNULL(@Id, '')
                                AND UserId = @UserId
                                AND SportId = @SportId )
            BEGIN
                SET @message = '�˶������Ѿ����塣'
                RETURN
            END

		--��������
        IF @actionCode = 1
			--�½�--
            INSERT  dbo.UserSport
                    ( Id ,
                      UserId ,
                      SportId ,
                      IsActive ,
                      ProType ,
                      GripOption ,
                      Score ,
                      CreateDate
			        )
            VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                      @UserId , -- UserId - nvarchar(50)
                      @SportId , -- SportId - nvarchar(50)
                      @IsActive , -- IsActive - bit
                      @ProType , -- ProType - nvarchar(50)
                      @GripOption , -- GripOption - nvarchar(50)
                      @Score , -- Score - int
                      GETDATE()  -- CreateDate - datetime
			        )
        ELSE
            IF @actionCode = 2
                BEGIN
			--����--
                    DECLARE @oldScore INT
                    SELECT  @oldScore = Score
                    FROM    dbo.UserSport
                    WHERE   Id = @Id

                    UPDATE  dbo.UserSport
                    SET     UserId = @UserId ,
                            SportId = @SportId ,
                            IsActive = @IsActive ,
                            ProType = @ProType ,
                            GripOption = @GripOption ,
                            Score = @Score
                    WHERE   Id = @Id

					--��¼���ֱ䶯��¼
                    IF @oldScore != @Score
                        INSERT  dbo.UserScoreHistory
                                ( Id ,
                                  UserId ,
                                  SportId ,
                                  GameId ,
                                  LoopId ,
                                  Score ,
                                  CreateDate
								 )
                        VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                                  @UserId , -- UserId - nvarchar(50)
                                  @SportId , -- SportId - nvarchar(50)
                                  N'' , -- GameId - nvarchar(50)
                                  N'' , -- LoopId - nvarchar(50)
                                  @Score , -- Score - int
                                  GETDATE()  -- CreateDate - datetime
								 )
                END
            ELSE
                IF @actionCode = 3
				--ɾ��--
                    DELETE  dbo.UserSport
                    WHERE   Id = @Id
			

    END


GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVenueBillPay]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveVenueBillPay]
    @id NVARCHAR(50) ,
    @orderNo NVARCHAR(50) ,
    @amount FLOAT(50) ,
    @payOption NVARCHAR(50) ,
    @payId NVARCHAR(50) ,
    @payState NVARCHAR(50) ,
    @payRemark NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        DECLARE @state NVARCHAR(50)

        SELECT  @state = PayState 
        FROM    dbo.VenueBill
        WHERE   Id = @id
                OR OrderNo = @orderNo

        IF @state = NULL
            BEGIN
                SET @message = '�����Ѿ������ڡ�'
                RETURN
            END
        ELSE
            IF @state = '024002'
                BEGIN
                    SET @message = '�����Ѿ�֧����'
                    RETURN
                END
            ELSE
                BEGIN
				    --���¶�����¼
                    UPDATE  dbo.VenueBill
                    SET     Amount = @amount ,
                            PayOption = @payOption ,
                            PayId = @payId ,
                            PayState = @payState ,
                            PayDate = GETDATE() ,
                            PayRemark = @payRemark ,
                            State = '026003'
                    WHERE   Id = @id
                            OR OrderNo = @orderNo

					
                END
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVenueDiscount]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveVenueDiscount]
    @Id NVARCHAR(50) ,
    @VenueId NVARCHAR(50) ,
    @CostTypeId NVARCHAR(50) ,
    @Discount DECIMAL(18, 2) ,
    @BeginDate DATETIME ,
    @EndDate DATETIME ,
    @CreatorId NVARCHAR(50) ,
    @actionCode INT ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN   
		--��֤�½����޸�
        IF ( @actionCode = 1
             OR @actionCode = 2
           )
            AND EXISTS ( SELECT *
                         FROM   dbo.VenueDiscount
                         WHERE  Id != ISNULL(@Id,'')
                                AND VenueId = @VenueId
                                AND CostTypeId = @CostTypeId
                                AND (dbo.fn_GetDate(BeginDate) BETWEEN dbo.fn_GetDate(@BeginDate) AND dbo.fn_GetDate(@EndDate)
                                OR dbo.fn_GetDate(EndDate) BETWEEN dbo.fn_GetDate(@BeginDate) AND dbo.fn_GetDate(@EndDate) 
								OR dbo.fn_GetDate(@BeginDate) BETWEEN dbo.fn_GetDate(BeginDate) AND dbo.fn_GetDate(EndDate)
                                OR dbo.fn_GetDate(@EndDate) BETWEEN dbo.fn_GetDate(BeginDate) AND dbo.fn_GetDate(EndDate) 
								))
            BEGIN
                SET @message = '��ʱ������������Ѿ������ۿۡ�'
                RETURN
            END

		--��������
        IF @actionCode = 1
			--�½�--
            INSERT  dbo.VenueDiscount
                    ( Id ,
                      VenueId ,
                      CostTypeId ,
                      Discount ,
                      BeginDate ,
                      EndDate ,
                      CreatorId ,
                      CreateDate
                    )
            VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                      @VenueId , -- VenueId - nvarchar(50)
                      @CostTypeId , -- CostTypeId - nvarchar(50)
                      @Discount , -- Discount - float
                      @BeginDate , -- BeinDate - datetime
                      @EndDate , -- EndDate - datetime
                      @CreatorId , -- CreatorId - nvarchar(50)
                      GETDATE()  -- CreateDate - datetime
                    )
        ELSE
            IF @actionCode = 2
			--����--
                UPDATE  dbo.VenueDiscount
                SET     Discount = @Discount ,
                        BeginDate = @BeginDate ,
                        EndDate = @EndDate
                WHERE   Id = @Id
            ELSE
                IF @actionCode = 3
				--ɾ��--
                    DELETE  dbo.VenueDiscount
                    WHERE   Id = @Id
			

    END


GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipBuyPay]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveVipBuyPay]
    @id NVARCHAR(50) ,
    @orderNo NVARCHAR(50) ,
    @amount DECIMAL(18, 2) ,
    @payOption NVARCHAR(50) ,
    @payId NVARCHAR(50) ,
    @payState NVARCHAR(50) ,
    @payRemark NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        DECLARE @state NVARCHAR(50)
        DECLARE @userId NVARCHAR(50)

        BEGIN TRY
            SELECT  @state = PayState ,
                    @userId = UserId--ʵ�ʳ�ֵ�ʺţ����˴��䣬����ʵ�ĳ�ֵ�ʺţ�
            FROM    dbo.VipBuy
            WHERE   Id = @id
                    OR OrderNo = @orderNo

            IF @state = NULL
                RAISERROR (N'�����Ѿ������ڡ�',11,1)

            IF @state = '024001'
                BEGIN

					--�������ͱ���
                    DECLARE @scale DECIMAL(18, 2)
                    SET @scale = 0
                    SELECT  @scale = Scale
                    FROM    dbo.VipRechargeScale
                    WHERE   @amount >= Min
                            AND @amount <= Max

					--�������ͽ��
                    DECLARE @giveAmount DECIMAL(18, 2)
                    SET @giveAmount = @amount * @scale;

				    --���¶�����¼
                    UPDATE  dbo.VipBuy
                    SET     Amount = ISNULL(@amount, 0) ,
                            GiveScale = @scale ,
                            GiveAmount = @giveAmount ,
                            PayOption = @payOption ,
                            PayId = @payId ,
                            PayState = @payState ,
                            PayDate = GETDATE() ,
                            PayDate1 = GETDATE() ,
                            PayRemark = @payRemark
                    WHERE   Id = @id
                            OR OrderNo = @orderNo

					--�����˻���¼����
                    IF EXISTS ( SELECT  *
                                FROM    dbo.VipAccount
                                WHERE   Id = @userId )
                        UPDATE  dbo.VipAccount
                        SET     Amount = ISNULL(Amount, 0) + ISNULL(@amount, 0)
                                + @giveAmount ,
                                Balance = ISNULL(Balance, 0) + ISNULL(@amount,
                                                              0) + @giveAmount
                        WHERE   Id = @userId
                    ELSE
                        INSERT  INTO dbo.VipAccount
                                ( Id ,
                                  Amount ,
                                  UsedAmount ,
                                  Balance ,
                                  Refund ,
                                  Score ,
                                  UsedScore ,
                                  BalanceScore ,
                                  CreateDate
			                    )
                        VALUES  ( @userId , -- Id - nvarchar(50)
                                  ISNULL(@amount, 0) + @giveAmount , -- Amount - float
                                  0.0 , -- UsedAmount - float
                                  ISNULL(@amount, 0) + @giveAmount ,  --Balance
                                  0.0 ,  -- Refund
                                  0.0 , -- Score - float
                                  0.0 , -- UsedScore - float
                                  0.0 ,  --BalanceScore
                                  GETDATE()  -- CreateDate - datetime
			                    )
                END
        END TRY

        BEGIN CATCH
            SET @message = '����ʧ�ܡ�' + ERROR_MESSAGE() 
        END CATCH 

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipCostScale]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveVipCostScale]
    @Id NVARCHAR(50) ,
    @CompanyId NVARCHAR(50) ,
    @CostTypeId NVARCHAR(50) ,
    @CityId NVARCHAR(50) ,
    @YdlScale DECIMAL(18,2) ,
    @CompanyScale DECIMAL(18,2) ,
    @VenueScale DECIMAL(18,2) ,
    @CreatorId NVARCHAR(50) ,
    @Remark NVARCHAR(MAX) ,
    @actionCode INT ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN   
		--��֤�½����޸�
        IF ( @actionCode = 1
             OR @actionCode = 2
           )
            AND EXISTS ( SELECT *
                         FROM   dbo.VipCostScale
                         WHERE  Id != ISNULL(@Id,'')
                                AND CompanyId = @CompanyId
                                AND CostTypeId = @CostTypeId
                                AND CityId = @CityId )
            BEGIN
                SET @message = '�����������Ѿ����塣'
                RETURN
            END

		--��������
        IF @actionCode = 1
			--�½�--
            INSERT  dbo.VipCostScale
                    ( Id ,
                      CompanyId ,
                      CostTypeId ,
                      CityId ,
                      YdlScale ,
                      CompanyScale ,
                      VenueScale ,
                      Remark ,
                      CreatorId ,
                      CreateDate ,
                      LastDate
	                )
            VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                      @CompanyId , -- CompanyId - nvarchar(50)
                      @CostTypeId , -- CostTypeId - nvarchar(50)
                      @CityId ,
                      @YdlScale , -- YdlScale - float
                      @CompanyScale , -- CompanyScale - float
                      @VenueScale , -- VenueScale - float
                      @Remark , -- Remark - nvarchar(max)
                      @CreatorId , -- CreatorId - nvarchar(50)
                      GETDATE() , -- CreateDate - datetime
                      GETDATE()  -- LastDate - datetime
	                )
        ELSE
            IF @actionCode = 2
			--����--
                UPDATE  dbo.VipCostScale
                SET     YdlScale = @YdlScale ,
                        CompanyScale = @CompanyScale ,
                        VenueScale = @VenueScale ,
                        Remark = @Remark ,
                        LastDate = GETDATE()
                WHERE   CompanyId = @CompanyId
                        AND CostTypeId = @CostTypeId
                        AND CityId = @CityId
            ELSE
                IF @actionCode = 3
				--ɾ��--
                    DELETE  dbo.VipCostScale
                    WHERE   Id = @Id
			

    END


GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipDiscount]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveVipDiscount]
    @id NVARCHAR(50) ,
    @cityId NVARCHAR(50) ,
    @categoryId NVARCHAR(50) ,
    @discount FLOAT ,
    @common FLOAT ,
    @creatorId NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN   
        SET @message = ''
        IF EXISTS ( SELECT  *
                    FROM    dbo.VipDiscount
                    WHERE   CityId = @cityId
                            AND @categoryId = @categoryId
                            AND Id != @id )
            BEGIN
                SET @message = '��ǰ���б���������ۿ��Ѿ����ڡ�'
                RETURN
            END

        IF EXISTS ( SELECT  *
                    FROM    dbo.VipDiscount
                    WHERE   Id = @id )
            UPDATE  dbo.VipDiscount
            SET     Discount = @discount ,
                    Common = @common ,
                    LastDate = GETDATE()
            WHERE   Id = @id
        ELSE
            INSERT  dbo.VipDiscount
                    ( Id ,
                      CityId ,
                      CategoryId ,
                      Discount ,
                      Common ,
                      CreatorId ,
                      CreateDate ,
                      LastDate
			        )
            VALUES  ( @id , -- Id - nvarchar(50)
                      @cityId , -- CityId - nvarchar(50)
                      @categoryId , -- CategoryId - nvarchar(50)
                      @discount , -- Discount - float
                      @common , -- Common - float
                      @creatorId , -- CreatorId - nvarchar(50)
                      GETDATE() , -- CreateDate - datetime
                      GETDATE()  -- LastDate - datetime
			        )

        
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipInnerDiscount]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveVipInnerDiscount]
    @id NVARCHAR(50) ,
    @venueId NVARCHAR(50) ,
    @categoryId NVARCHAR(50) ,
    @discount FLOAT ,
    @creatorId NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN   
        SET @message = ''
        IF EXISTS ( SELECT  *
                    FROM    dbo.VipInnerDiscount
                    WHERE   VenueId = @venueId
                            AND @categoryId = @categoryId
                            AND Id != @id )
            BEGIN
                SET @message = '��ǰ���ݱ���������ۿ��Ѿ����ڡ�'
                RETURN
            END

        IF EXISTS ( SELECT  *
                    FROM    dbo.VipInnerDiscount
                    WHERE   Id = @id )
            UPDATE  dbo.VipInnerDiscount
            SET     Discount = @discount ,
                    LastDate = GETDATE()
            WHERE   Id = @id
        ELSE
            INSERT dbo.VipInnerDiscount
                    ( Id ,
                      VenueId ,
                      CategoryId ,
                      Discount ,
                      CreatorId ,
                      CreateDate ,
                      LastDate
                    )
            VALUES  ( @id , -- Id - nvarchar(50)
                      @venueId , -- VenueId - nvarchar(50)
                      @categoryId , -- CategoryId - nvarchar(50)
                      @discount , -- Discount - float
                      @creatorId , -- CreatorId - nvarchar(50)
                      GETDATE() , -- CreateDate - datetime
                      GETDATE()  -- LastDate - datetime
                    )

        
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipRefund]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveVipRefund]
    @Id NVARCHAR(50) ,
    @OrderNo NVARCHAR(50) ,
    @UserId NVARCHAR(50) ,
    @AppliedAmount DECIMAL(18, 2) ,
    @Amount DECIMAL(18, 2) ,
    @Remark NVARCHAR(MAX) ,
    @CreatorId NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN

        BEGIN TRY
			--��ȡ�û����
            DECLARE @balance FLOAT	
            SELECT  @balance = Balance
            FROM    VipAccount
            WHERE   Id = @UserId

			--ʵʱ�������Ƿ������˿�
            IF ISNULL(@balance, 0) < @AppliedAmount
                RAISERROR (N'�˻��������˿��',11,1)

			--���˻��Ͽ�Ǯ��ʹ�������
            UPDATE  dbo.VipAccount
            SET     Refund = ISNULL(Refund, 0) + ISNULL(@AppliedAmount, 0) ,
                    Balance = ISNULL(Balance, 0) - ISNULL(@AppliedAmount, 0)
            WHERE   Id = @UserId

			--�����˿��¼
            INSERT  dbo.VipRefund
                    ( Id ,
                      OrderNo ,
                      UserId ,
                      AppliedAmount ,
                      Amount ,
                      Remark ,
                      CreatorId ,
                      CreateDate
				    )
            VALUES  ( @Id , -- Id - nvarchar(50)
                      @OrderNo , -- OrderNo - nvarchar(50)
                      @UserId , -- UserId - nvarchar(50)
                      @AppliedAmount , -- AppliedAmount - decimal
                      @Amount , -- Amount - decimal
                      @Remark , -- Remark - nvarchar(500)
                      @CreatorId , -- CreatorId - nvarchar(50)
                      GETDATE()  -- CreateDate - datetime
				    )
        END TRY

        BEGIN CATCH
            SET @message = '����ʧ�ܡ�' + ERROR_MESSAGE() 
        END CATCH 

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipUse]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveVipUse]
    @Id NVARCHAR(50) ,
    @MasterType NVARCHAR(50) ,
    @MasterId NVARCHAR(50) ,
    @OrderNo NVARCHAR(50) ,
    @CityId NVARCHAR(50) ,
    @VenueId NVARCHAR(50) ,
    @CostTypeId NVARCHAR(50) ,
    @TotalAmount DECIMAL(18,2) ,
    @Discount DECIMAL(18,2) ,
    @Amount DECIMAL(18,2) ,
    @PayOption NVARCHAR(50) ,
    @PayId NVARCHAR(50) ,
    @PayState NVARCHAR(50) ,
    @PayDate DATETIME ,
    @PayRemark NVARCHAR(500) ,
    @Remark NVARCHAR(500) ,
    @UserId NVARCHAR(50) ,
	@IsOwnCreate BIT,
    @CreatorId NVARCHAR(50) ,
    @CreateDate DATETIME ,
    @Lng FLOAT ,
    @Lat FLOAT ,
    @Address NVARCHAR(500) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN   
		/*--��ʼ--ע��ԭ��:����δ��ɵ�֧������A ��Ҫ֧��100, �´�����֧��ʱ���ܽ����ĳ��� 80 , ����Ӧ�������µĵ���,��������ԭ���Ļ����Ͻ���֧��*/
		--��֤ԭ�����ظ�����֧������
        --IF ISNULL(@MasterId, '') != ''
        --    AND EXISTS ( SELECT *
        --                 FROM   dbo.VipUse
        --                 WHERE  MasterId = @MasterId )
        --    BEGIN
        --        SET @message = 'ԭ�����Ѿ�����֧������'
        --        RETURN
        --    END
		/*--����--ע��ԭ��:����δ��ɵ�֧������A ��Ҫ֧��100, �´�����֧��ʱ���ܽ����ĳ��� 80 , ����Ӧ�������µĵ���,��������ԭ���Ļ����Ͻ���֧��*/

		--��֧����֤
        IF @PayOption = '023003'
            BEGIN
                DECLARE @venueBalance FLOAT;
                SELECT  @venueBalance = Balance
                FROM    dbo.Venue
                WHERE   Id = @VenueId

                IF ISNULL(@venueBalance, 0) < ISNULL(@Amount, 0)
                    BEGIN
                        SET @message = '��֧��ʧ�ܣ��������㡣'
                        RETURN
                    END
                ELSE
                    UPDATE  dbo.Venue
                    SET     Balance = ISNULL(Balance, 0) - ISNULL(@Amount, 0)
                    WHERE   Id = @VenueId
            END

        INSERT  dbo.VipUse
                ( Id ,
                  MasterType ,
                  MasterId ,
                  OrderNo ,
                  CityId ,
                  VenueId ,
                  CostTypeId ,
                  TotalAmount ,
                  Discount ,
                  Amount ,
                  PayOption ,
                  PayId ,
                  PayState ,
                  PayDate ,
                  PayRemark ,
                  Remark ,
				  IsOwnCreate,
                  UserId ,
                  CreatorId ,
                  CreateDate ,
				  CreateDate1,
                  Lng ,
                  Lat ,
                  Address
                )
        VALUES  ( @Id , -- @Id - nvarchar(50)
                  @MasterType ,
                  @MasterId ,
                  @OrderNo , -- @OrderNo - nvarchar(50)
                  @CityId , -- @CityId - nvarchar(50)
                  @VenueId , -- @VenueId - nvarchar(50)
                  @CostTypeId , -- @CostTypeId - nvarchar(50)
                  @TotalAmount , -- @TotalAmount - float
                  @Discount , -- @Discount - float
                  @Amount , -- @Amount - float
                  @PayOption , -- @PayOption - nvarchar(50)
                  @PayId , -- @PayId - nvarchar(50)
                  @PayState , -- @PayState - nvarchar(50)
                  @PayDate , -- @PayDate - datetime
                  @PayRemark , -- @PayRemark - nvarchar(500)
                  @Remark , -- @Remark - nvarchar(500)
				  @IsOwnCreate,
                  @UserId , -- @UserId - nvarchar(50)
                  @CreatorId , -- @CreatorId - nvarchar(50)
                  @CreateDate , -- @CreateDate - datetime
				  @CreateDate ,
                  @Lng , -- @Lng - float
                  @Lat , -- @Lat - float
                  @Address  -- @Address - nvarchar(500)
                )
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipUsePay]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveVipUsePay]
    @id NVARCHAR(50) ,
    @orderNo NVARCHAR(50) ,
    @amount DECIMAL(18, 2) ,
    @payOption NVARCHAR(50) ,
    @payPassword NVARCHAR(50) ,
    @payId NVARCHAR(50) ,
    @payState NVARCHAR(50) ,
    @payRemark NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        SET @amount = ISNULL(@amount, 0);

        DECLARE @state NVARCHAR(50)
        DECLARE @userId NVARCHAR(50)
        DECLARE @venueId NVARCHAR(50)
        DECLARE @masterType NVARCHAR(50)
        DECLARE @masterId NVARCHAR(50)

        BEGIN TRY
            SELECT  @state = PayState ,
                    @venueId = VenueId ,
                    @masterType = MasterType ,
                    @masterId = MasterId ,
                    @userId = CreatorId--�Ӵ������ʺſ�Ǯ���Լ�֧���������֧����
            FROM    dbo.VipUse
            WHERE   Id = @id
                    OR OrderNo = @orderNo

            IF @state = NULL
                RAISERROR (N'�����Ѿ������ڡ�',11,1)

            IF @state = '024001'
                BEGIN
					--������֧��
                    IF @payOption = '023001'
                        BEGIN
							--���֧�����룬��֧������
                            DECLARE @password NVARCHAR(50)
                            DECLARE @noPwdAmount INT
                            SELECT  @password = PayPassword ,
                                    @noPwdAmount = PayNoPwdAmount
                            FROM    dbo.UserAccount
                            WHERE   Id = @userId

                            IF ISNULL(@password, '') = ''
                                RAISERROR (N'�����ڸ�����Ϣ����֧�����롣',11,1)

                            IF @amount > ISNULL(@noPwdAmount, 0)
                                AND ISNULL(@payPassword, '') != ISNULL(@password,
                                                              '')
                                RAISERROR (N'֧�����벻��ȷ��',11,1)

							--�������
                            DECLARE @balance DECIMAL(18, 2);
                            SELECT  @balance = Balance
                            FROM    dbo.VipAccount
                            WHERE   Id = @userId
                            IF ISNULL(@balance, 0) < ISNULL(@amount, 0)
                                RAISERROR (N'֧��ʧ�ܣ����㡣',11,1)
                            ELSE
								--������ѣ������˻���¼���ˣ�����¼���ѻ���
                                UPDATE  dbo.VipAccount
                                SET     UsedAmount = ISNULL(UsedAmount, 0)
                                        + ISNULL(@amount, 0) ,
                                        Balance = ISNULL(Balance, 0)
                                        - ISNULL(@amount, 0) ,
                                        Score = ISNULL(Score, 0)
                                        + ISNULL(@amount, 0) ,
                                        BalanceScore = ISNULL(BalanceScore, 0)
                                        + ISNULL(@amount, 0)
                                WHERE   Id = @userId
                        END

                    --֧����֧��
                    IF @payOption = '023002'
                        BEGIN
							--��¼���ѻ���
                            UPDATE  dbo.VipAccount
                            SET     Score = ISNULL(Score, 0) + ISNULL(@amount,
                                                              0) ,
                                    BalanceScore = ISNULL(BalanceScore, 0)
                                    + ISNULL(@amount, 0)
                            WHERE   Id = @userId
                        END

					--���ݴ�֧�����û�����üƷ֣�
                    IF @payOption = '023003'
                        BEGIN
                            DECLARE @venueBalance DECIMAL(18, 2);
                            SELECT  @venueBalance = Balance
                            FROM    dbo.Venue
                            WHERE   Id = @venueId

                            IF ISNULL(@venueBalance, 0) < ISNULL(@amount, 0)
                                RAISERROR (N'֧��ʧ�ܣ������������㡣',11,1)
                            ELSE
								--��֧�������³��ݶ��
                                UPDATE  dbo.Venue
                                SET     Balance = ISNULL(Balance, 0)
                                        - ISNULL(@amount, 0)
                                WHERE   Id = @venueId
                        END

				    --���¶�����¼
                    UPDATE  dbo.VipUse
                    SET     Amount = ISNULL(@amount, 0) ,
                            PayOption = @payOption ,
                            PayId = @payId ,
                            PayState = @payState ,
                            PayDate = GETDATE() ,
                            PayDate1 = GETDATE() ,
                            PayRemark = @payRemark
                    WHERE   Id = @id
                            OR OrderNo = @orderNo

					---------------����ԭʼ�����߼���@masterType��@masterId��-----------------------------------
					--ѧԱ�������, ��δ��� ֧���ɹ���, ҵ�����---------------------��ʼ
                    IF @masterType = '016010001'
                        BEGIN
 							BEGIN TRANSACTION
							--������ʽ��
							INSERT INTO CoachStudentMoney	
							SELECT * FROM CoachStudentMoneyNotPay WHERE Id=@masterId
							--�޸�Ϊ��ʽ����
						 	UPDATE dbo.CoachStudentMoney SET  IsPay=1  WHERE Id=@masterId
							--ɾ����Ҫ������
							DELETE FROM CoachStudentMoneyNotPay WHERE Id=@masterId

							IF @@ERROR=0
								COMMIT TRANSACTION
							ELSE
								ROLLBACK TRANSACTION
                        END
					--ѧԱ�������, ��δ��� ֧���ɹ���, ҵ�����---------------------����

					---------------����ԭʼ�����߼���@masterType��@masterId��-----------------------------------
					
                END
        END TRY

        BEGIN CATCH
            SET @message = '����ʧ�ܡ�' + ERROR_MESSAGE() 
        END CATCH 
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetActivityState]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SetActivityState]
    @id NVARCHAR(50) ,
    @state NVARCHAR(50)
AS
    BEGIN

		--���»
        UPDATE  dbo.Activity
        SET     State = @state
        WHERE   Id = @id
		--����ǻ����������Ҫ���»����
        IF @state = '005005'
            BEGIN
				--����Ǿ��ֲ�������¹��������
                DECLARE @clubId NVARCHAR(50)
                SELECT  @clubId = ClubId
                FROM    dbo.Activity
                WHERE   Id = @id
                IF ISNULL(@clubId, '') != ''
                    BEGIN
						--��ȡϵͳ���ֶ���
                        DECLARE @activityScore INT
                        SELECT  @activityScore = ActivityScore
                        FROM    dbo.Config

						--���µ�ǰ����
                        DECLARE cur_sor CURSOR
                        FOR
                            SELECT  UserId
                            FROM    ActivityUser
                            WHERE   ActivityId = @id
                                    AND IsJoined = 1
                        OPEN cur_sor
                        DECLARE @str NVARCHAR(MAX)
                        FETCH NEXT FROM cur_sor INTO @str
                        WHILE ( @@fetch_status = 0 )
                            BEGIN
                                UPDATE  ClubUser
                                SET     Score = ISNULL(Score, 0)
                                        + @activityScore
                                WHERE   ClubId = @clubId
                                        AND UserId = @str
                                FETCH NEXT FROM cur_sor INTO @str
                            END

                        CLOSE cur_sor
                        DEALLOCATE cur_sor

                    END
                
            END		
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetCompanyIsStop]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SetCompanyIsStop]
	@companyId NVARCHAR(50),
	@isStop BIT
AS
    BEGIN
        SET NOCOUNT ON
		Set XACT_ABORT ON
		BEGIN  TRAN
		
		UPDATE Company SET IsStop=@isStop WHERE Id=@companyId
		UPDATE Venue SET IsUseVip=~@isStop FROM Venue a INNER JOIN CompanyVenues b ON a.Id=b.VenueId WHERE b.CompanyId=@companyId


		COMMIT TRAN
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetGameLoopState]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SetGameLoopState]
    @loopId NVARCHAR(50) ,
    @state NVARCHAR(50)
AS
    BEGIN   
        UPDATE  dbo.GameLoop
        SET     State = @state ,
                StartTime = CASE WHEN State = '011001' THEN NULL
                                 WHEN State = '011002' THEN GETDATE()
                                 ELSE StartTime
                            END ,
                EndTime = CASE WHEN State = '011003' THEN GETDATE()
                               ELSE NULL
                          END
        WHERE   Id = @loopId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetGameState]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SetGameState]
    @gameId NVARCHAR(50) ,
    @state NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN   
        SET @message = ''

		--�������Ƿ��Ѿ�����
        DECLARE @curState NVARCHAR(50)
        SELECT  @curState = State
        FROM    dbo.Game
        WHERE   Id = @gameId
        IF @curState = '015005'
            BEGIN
                SET @message = '�����Ѿ�����,�޷�����Ϊδ������'
                RETURN
            END

        IF @state = '015004'--������ʼ�����������ִο�ʼ
            BEGIN
			    --��鴴����������
                IF NOT EXISTS ( SELECT  *
                                FROM    dbo.GameOrder
                                WHERE   GameId = @gameId )
                    BEGIN
                        SET @message = 'û�д����������̣������޷���ʼ��'
                        RETURN
                    END
				--����Ƿ������ִζ�������ʤ��ѡ��
                IF EXISTS ( SELECT  *
                            FROM    dbo.GameOrder
                            WHERE   GameId = @gameId
                                    AND WinGame = 0 )
                    BEGIN
                        SET @message = 'ĳ�ִ�û������ʤ��ѡ������޷���ʼ��'
                        RETURN
                    END

				--����һ�ֳ�ǩ���
                DECLARE @knockOut NVARCHAR(50)
                DECLARE @firstOrderId NVARCHAR(50)
                DECLARE @knockOutCount INT

                SELECT  @knockOut = KnockoutOption ,
                        @knockOutCount = KnockoutCount ,
                        @firstOrderId = Id
                FROM    dbo.GameOrder
                WHERE   GameId = @gameId
                        AND OrderNo = 1

				--��һ��С��ѭ��
                IF @knockOut = '014002'
                    BEGIN
					    --С���Ա2������
                        IF EXISTS ( SELECT  GroupId
                                    FROM    dbo.GameGroupMember
                                    WHERE   GameId = @gameId
                                    GROUP BY GroupId
                                    HAVING  COUNT(*) < 2 )
                            BEGIN
                                SET @message = '����ĳС����������2�ˣ������޷���ʼ��'
                                RETURN
                            END

						--С������������ڵ��ڳ�������
                        IF EXISTS ( SELECT  GroupId
                                    FROM    dbo.GameGroupMember
                                    WHERE   GameId = @gameId
                                    GROUP BY GroupId
                                    HAVING  COUNT(*) < @knockOutCount )
                            BEGIN
                                SET @message = '����ĳС������������������������޷���ʼ��'
                                RETURN
                            END

                        
                    END
				--��һ����̭
                IF @knockOut = '014001'
                    AND NOT EXISTS ( SELECT *
                                     FROM   dbo.GameLoop
                                     WHERE  OrderId = @firstOrderId
                                            AND ( ISNULL(Team1Id, '') != ''
                                                  OR ISNULL(Team2Id, '') != ''
                                                ) )
                    BEGIN
                        SET @message = '��û�н��е�һ�ֳ�ǩ�������޷���ʼ��'
                        RETURN
                    END
				--�����ִ�״̬
                UPDATE  dbo.GameOrder
                SET     State = '013002'
                WHERE   GameId = @gameId
            END
        ELSE
            IF @state = '015005'--�������������������ִν���
                BEGIN
                    IF EXISTS ( SELECT  *
                                FROM    dbo.GameLoop
                                WHERE   GameId = @gameId
                                        AND IsBye = 0
                                        AND State != '011003' )
                        BEGIN
                            SET @message = '������δ�����ı������޷���������.'
                            RETURN
                        END
                    ELSE
                        UPDATE  dbo.GameOrder
                        SET     State = '013003'
                        WHERE   GameId = @gameId
                                AND State != '013003'

					--���ֲ�������Ҫ���¾��ֲ�����֣������൱�ڻ��
                    EXEC dbo.sp_UpdateGameClubScore @gameId
					--�������¸����˶�����
                    EXEC dbo.sp_UpdateGameSportScore @gameId
                END

            ELSE
                IF @state = '015009'--ȡ����������ɾ������
                    BEGIN
						--���泡�α���б�
                        DECLARE @loopList TABLE
                            (
                              Id NVARCHAR(50) PRIMARY KEY
                            )
                        INSERT  INTO @loopList
                                ( Id
                                )
                                SELECT  Id
                                FROM    dbo.GameLoop
                                WHERE   GameId = @gameId
						--��������
                        DELETE  FROM dbo.GameLoopDetail
                        WHERE   LoopId IN ( SELECT  Id
                                            FROM    @loopList )
						--�Ŷ�ӳ��
                        DELETE  FROM dbo.GameLoopMap
                        WHERE   LoopId IN ( SELECT  Id
                                            FROM    @loopList )
						--����
                        DELETE  FROM dbo.GameLoop
                        WHERE   GameId = @gameId

						--��������
                        DELETE  FROM dbo.GameTeam
                        WHERE   GameId = @gameId

						--���������Ա
                        DELETE  FROM dbo.GameGroupMember
                        WHERE   GameId = @gameId

						--С��
                        DELETE  FROM dbo.GameGroup
                        WHERE   GameId = @gameId

						--����
                        DELETE  FROM dbo.GameJudge
                        WHERE   GameId = @gameId

						--�ִ�
                        DELETE  FROM dbo.GameOrder
                        WHERE   GameId = @gameId
                    END
                ELSE
                    IF @state = '015001'--δ����״̬����ɾ��һЩ��ϸ���ݣ�������������
                        BEGIN
                            EXECUTE dbo.sp_DeleteGameAllDetail @gameId
                        END
		--ȡ��ɾ������ȡ������״̬
        IF @state = '015009'
            DELETE  FROM dbo.Game
            WHERE   Id = @gameId
        ELSE
            UPDATE  dbo.Game
            SET     State = @state
            WHERE   Id = @gameId
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_SetGameTopState]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SetGameTopState]
    @gameId NVARCHAR(50) ,
    @isTop BIT
AS
    BEGIN   
        UPDATE  dbo.Game
        SET     IsTop = @isTop
        WHERE   Id = @gameId
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetStudentReleased]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--������ѧԱ��Լ
CREATE PROCEDURE [dbo].[sp_SetStudentReleased]
	@userId NVARCHAR(50),
	@creatorId NVARCHAR(50),
	@errCode INT OUTPUT,
	@errMsg NVARCHAR(200) OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		SET @errCode=0
		SET @errMsg=''

		DECLARE @joinDate DATETIME,@venueId NVARCHAR(50),@id NVARCHAR(50)
		SELECT @id=a.Id,@joinDate=b.CreateDate,@venueId=b.VenueId FROM UserAccount a LEFT JOIN VenueStudents b ON a.Id=b.UserId WHERE a.Id=@userId


		IF ISNULL(@id,'')=''
		BEGIN
			SET @errCode=-1
			SET @errMsg='����ʧ�ܣ�ѧԱ��Ϣ��ɾ����'
		END
		ELSE IF ISNULL(@venueId,'')=''
		BEGIN
			SET @errCode=-1
			SET @errMsg='ѧԱ�ѽ�Լ,�����ٴβ�����'
		END
		ELSE
		BEGIN
			DELETE FROM VenueStudents WHERE UserId=@userId

			INSERT INTO CoachReleasedLog(Id,SenderType,SenderId,ReceiverType,ReceiverId,JoinDate,CreatorId,CreateDate)
			VALUES(NEWID(),'016003',@venueId,'016010',@userId,@joinDate,@creatorId,GETDATE())
		END
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetVenueReleased]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SetVenueReleased]
	@venueId NVARCHAR(50),
	@creatorId NVARCHAR(50),
	@errCode INT OUTPUT,
	@errMsg NVARCHAR(200) OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		SET @errCode=0
		SET @errMsg=''

		DECLARE @joinDate DATETIME,@companyId NVARCHAR(50),@id NVARCHAR(50)
		SELECT @id=a.Id,@joinDate=b.CreateDate,@companyId=b.CompanyId FROM Venue a LEFT JOIN CompanyVenues b ON a.Id=b.VenueId WHERE a.Id=@venueId


		IF ISNULL(@id,'')=''
		BEGIN
			SET @errCode=-1
			SET @errMsg='����ʧ�ܣ�������Ϣ��ɾ����'
		END
		ELSE IF ISNULL(@companyId,'')=''
		BEGIN
			SET @errCode=-1
			SET @errMsg='�����ѽ�Լ,�����ٴβ�����'
		END
		ELSE
		BEGIN
			UPDATE Venue SET IsUseVip=0 WHERE Id=@venueId

			DELETE FROM CompanyVenues WHERE VenueId=@venueId

			INSERT INTO CoachReleasedLog(Id,SenderType,SenderId,ReceiverType,ReceiverId,JoinDate,CreatorId,CreateDate)
			VALUES(NEWID(),'016008',@companyId,'016003',@venueId,@joinDate,@creatorId,GETDATE())
		END
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetVenueVip]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SetVenueVip]
    @id NVARCHAR(50) ,
    @isVip BIT ,
    @creditLine FLOAT ,
    @balance FLOAT ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        UPDATE  dbo.Venue
        SET     CreditLine = @creditLine ,
                IsUseVip = @isVip ,
                Balance = @balance
        WHERE   Id = @id
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateGameClubScore]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateGameClubScore] @gameId NVARCHAR(50)
AS
    BEGIN
        DECLARE @clubId NVARCHAR(50)
        DECLARE @isScoreGame NVARCHAR(50)
        SELECT  @clubId = ClubId ,
                @isScoreGame = IsScoreGame
        FROM    dbo.Game
        WHERE   Id = @gameId
        IF ISNULL(@clubId, '') != ''
            BEGIN
						--��ȡϵͳ���ֶ���
                DECLARE @activityScore INT
                SELECT  @activityScore = ActivityScore
                FROM    dbo.Config

						--���µ�ǰ����
                DECLARE cur_sor CURSOR
                FOR
                    SELECT  CreatorId + ',' + TeamUserId
                    FROM    GameTeam
                    WHERE   gameId = @gameId
                            AND IsJoined = 1 
                OPEN cur_sor
                DECLARE @strs NVARCHAR(MAX)
                FETCH NEXT FROM cur_sor INTO @strs
                WHILE ( @@FETCH_STATUS = 0 )
                    BEGIN
                        UPDATE  ClubUser
                        SET     Score = ISNULL(Score, 0) + @activityScore
                        WHERE   ClubId = @clubId
                                AND CHARINDEX(UserId, @strs) > 0
                        FETCH NEXT FROM cur_sor INTO @strs
                    END

                CLOSE cur_sor
                DEALLOCATE cur_sor
            END
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateGameSportScore]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateGameSportScore] @GameId NVARCHAR(50)
AS
    BEGIN
        DECLARE @isScoreGame BIT
        DECLARE @sportId NVARCHAR(50)

        SELECT  @isScoreGame = IsScoreGame ,
                @sportId = SportId
        FROM    dbo.Game
        WHERE   Id = @GameId

        IF @isScoreGame = 1
            BEGIN
                SELECT  b.TeamUserId AS User1Id ,
                        a.Score1 ,
                        d.Score AS User1Score ,
                        c.TeamUserId AS User2Id ,
                        a.Score2 ,
                        e.Score AS User2Score ,
                        f.High ,
                        f.Low ,
                        a.GameId ,
                        a.Id AS LoopId
                INTO    #temp
                FROM    dbo.GameLoop a
                        JOIN dbo.GameTeam b ON A.Team1Id = b.Id
                        JOIN dbo.GameTeam c ON A.Team2Id = c.Id
                        JOIN dbo.UserSport d ON d.UserId = b.TeamUserId
                                                AND d.SportId = @sportId
                        JOIN dbo.UserSport e ON e.UserId = c.TeamUserId
                                                AND e.SportId = @sportId
                        JOIN dbo.ScoreRange f ON ABS(d.Score - e.Score) >= f.BeginScore
                                                 AND ABS(d.Score - e.Score) <= f.EndScore
                WHERE   a.GameId = @GameId--�ų��ֿգ���Ȩ�ı���
                        AND a.IsBye = 0
                        AND ISNULL(a.WaiverOption, '') = ''

                DECLARE user_cur CURSOR
                FOR
                    SELECT  *
                    FROM    #temp

                OPEN user_cur

                DECLARE @user1Id NVARCHAR(50)
                DECLARE @user1Score INT
                DECLARE @score1 INT

                DECLARE @user2Id NVARCHAR(50)
                DECLARE @user2Score INT
                DECLARE @score2 INT

                DECLARE @high INT
                DECLARE @low INT

                DECLARE @tempGameId NVARCHAR(50)
                DECLARE @LoopId NVARCHAR(50)

                FETCH NEXT FROM user_cur INTO @user1Id, @score1, @user1Score,
                    @user2Id, @score2, @user2Score, @high, @low, @GameId,
                    @LoopId
                WHILE @@FETCH_STATUS = 0
                    BEGIN
                        DECLARE @user1Add INT
                        SET @user1Add = CASE WHEN @user1Score >= @user2Score
                                             THEN ( CASE WHEN @score1 > @score2
                                                         THEN @high
                                                         ELSE -@low
                                                    END )
                                             ELSE ( CASE WHEN @score1 > @score2
                                                         THEN @low
                                                         ELSE -@high
                                                    END )
                                        END
                        UPDATE  dbo.UserSport
                        SET     Score = Score + @user1Add
                        WHERE   UserId = @user1Id
                                AND SportId = @sportId  

                        INSERT  dbo.UserScoreHistory
                                ( Id ,
                                  UserId ,
                                  SportId ,
                                  GameId ,
                                  LoopId ,
                                  Score ,
                                  CreateDate
								 )
                        VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                                  @user1Id , -- UserId - nvarchar(50)
                                  @sportId , -- SportId - nvarchar(50)
                                  @tempGameId , -- GameId - nvarchar(50)
                                  @LoopId , -- LoopId - nvarchar(50)
                                  @user1Add , -- Score - int
                                  GETDATE()  -- CreateDate - datetime
								 )

                        DECLARE @user2Add INT
                        SET @user2Add = CASE WHEN @user2Score >= @user1Score
                                             THEN ( CASE WHEN @score2 > @score1
                                                         THEN @high
                                                         ELSE -@low
                                                    END )
                                             ELSE ( CASE WHEN @score2 > @score1
                                                         THEN @low
                                                         ELSE -@high
                                                    END )
                                        END
                        UPDATE  dbo.UserSport
                        SET     Score = Score + @user2Add
                        WHERE   UserId = @user2Id
                                AND SportId = @sportId

                        INSERT  dbo.UserScoreHistory
                                ( Id ,
                                  UserId ,
                                  SportId ,
                                  GameId ,
                                  LoopId ,
                                  Score ,
                                  CreateDate
								 )
                        VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                                  @user2Id , -- UserId - nvarchar(50)
                                  @sportId , -- SportId - nvarchar(50)
                                  @tempGameId , -- GameId - nvarchar(50)
                                  @LoopId , -- LoopId - nvarchar(50)
                                  @user2Add , -- Score - int
                                  GETDATE()  -- CreateDate - datetime
								 )

                        FETCH NEXT FROM user_cur INTO @user1Id, @score1,
                            @user1Score, @user2Id, @score2, @user2Score, @high,
                            @low, @GameId, @LoopId
                    END

                CLOSE user_cur
                DEALLOCATE user_cur
            END
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePassword]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdatePassword]
    @id NVARCHAR(50) ,
    @password NVARCHAR(50) ,
    @passwordOld NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        DECLARE @old NVARCHAR(50)
        SELECT  @old = Password
        FROM    dbo.UserAccount

        WHERE   Id = @id
        IF @passwordOld = @old
            UPDATE  dbo.UserAccount
            SET     Password = @password
            WHERE   Id = @id
        ELSE
            SET @message = 'ԭ���벻��ȷ��'
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTransferCreatorId]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateTransferCreatorId]
    @masterType NVARCHAR(50) ,
    @masterId NVARCHAR(50) ,
    @targetUserId NVARCHAR(50) ,
    @creatorId NVARCHAR(50)
AS
    BEGIN

        DECLARE @sql NVARCHAR(MAX)
        SET @sql = ' UPDATE '
            + CASE WHEN @masterType = '016001' THEN ' Activity '
                   WHEN @masterType = '016002' THEN ' Club '
                   WHEN @masterType = '016003' THEN ' Venue '
                   WHEN @masterType = '016004' THEN ' Game '
                   WHEN @masterType = '016005' THEN ' Note '
              END
            + ' SET CreatorId = @targetUserId WHERE Id = @masterId AND CreatorId = @creatorId'

        EXEC SP_EXECUTESQL @sql,
            N'@masterId NVARCHAR(50),@targetUserId NVARCHAR(50),@creatorId NVARCHAR(50)',
            @masterId, @targetUserId, @creatorId

		--�ƽ����ֲ�����Ҫ����ClubUser�д���������
        IF @masterType = '016002'
            BEGIN
                UPDATE  dbo.ClubUser
                SET     IsCreator = 0
                WHERE   ClubId = @masterId
                        AND UserId = @creatorId

                IF EXISTS ( SELECT  *
                            FROM    dbo.ClubUser
                            WHERE   ClubId = @masterId
                                    AND UserId = @targetUserId )
                    BEGIN
                        UPDATE  dbo.ClubUser
                        SET     IsCreator = 1 ,
                                IsAdmin = 1
                        WHERE   ClubId = @masterId
                                AND UserId = @targetUserId
                    END
                ELSE
                    INSERT  INTO dbo.ClubUser
                            ( Id ,
                              ClubId ,
                              UserId ,
                              IsCreator ,
                              IsAdmin ,
                              PetName ,
                              LevelValue ,
                              Score ,
                              CreateDate
			                )
                    VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                              @masterId , -- ClubId - nvarchar(50)
                              @targetUserId , -- UserId - nvarchar(50)
                              1 , -- IsCreator - bit
                              1 , -- IsAdmin - bit
                              N'' , -- PetName - nvarchar(50)
                              0 , -- LevelValue - int
                              0 , -- Score - int
                              GETDATE()  -- CreateDate - datetime
			                )
            END

    END


GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateValCode]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateValCode]
    @mobile NVARCHAR(50) ,
    @code NVARCHAR(50)
AS
    BEGIN
        IF EXISTS ( SELECT  *
                    FROM    dbo.MobileValCode
                    WHERE   Id = @mobile )
            UPDATE  dbo.MobileValCode
            SET     Code = @code
            WHERE   Id = @mobile
        ELSE
            INSERT  INTO dbo.MobileValCode
                    ( Id, Code, CreateDate )
            VALUES  ( @mobile, -- Id - datetime
                      @code, -- ValCode - nvarchar(50)
                      GETDATE()  -- CreateDate - datetime
                      )
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateClubActivity]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ValidateClubActivity]
    @clubId NVARCHAR(50) ,
    @date DATETIME
AS
    BEGIN
        SET NOCOUNT ON;

        IF EXISTS ( SELECT  *
                    FROM    Activity
                    WHERE   ClubId = @clubId
                            AND CONVERT(VARCHAR(10), BeginTime, 120) = CONVERT(VARCHAR(10), @date, 120) AND State!='005009')
            SELECT  1
        ELSE
            SELECT  0
    
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateGameTeam]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ValidateGameTeam]
    @gameId NVARCHAR(50) ,
    @teamId NVARCHAR(50) ,
    @userId NVARCHAR(50) ,
    @userList NVARCHAR(500)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  COUNT(*)
        FROM    dbo.GameTeam
        WHERE   GameId = @gameId
                AND Id != @teamId
                AND ( CreatorId = @userId
                      OR dbo.fn_SamePart(@userList, TeamUserId) > 0
                    )
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateUser]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ValidateUser]
    @code NVARCHAR(50) ,
    @password NVARCHAR(50)
AS
    BEGIN

        SET NOCOUNT ON;
        SELECT TOP 1  a.Id ,
                a.IsAdmin ,
                a.IsStop ,
                a.Code ,
                a.PetName ,
                a.CardName ,
                a.HeadUrl ,
				a.Sex ,
                a.Mobile ,
                b.Score AS ScoreTT,
				VenueId=(SELECT TOP 1 Id FROM dbo.Venue WHERE AdminId=a.Id)
        FROM    UserAccount a
                LEFT JOIN dbo.UserSport b ON b.UserId = a.Id
                                             AND SportId = '474C2709-325E-49F7-AB66-A676C40B2EA6'
        WHERE   ( Code = @code
                  OR Mobile = @code
                )
                AND Password = @password
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateUserSign]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ValidateUserSign]
    @userId NVARCHAR(50) ,
    @masterId NVARCHAR(50) ,
    @signDate NVARCHAR(50)
AS
    BEGIN   
        DECLARE @message NVARCHAR(50)

        IF EXISTS ( SELECT  *
                    FROM    dbo.VipUse
                    WHERE   CreatorId = @userId
                            AND PayState = '024001' )
            SET @message = '����δ֧�����Ѷ������޷�ǩ����'
        ELSE
            IF EXISTS ( SELECT  *
                        FROM    UserSign
                        WHERE   CreatorId = @userId
                                AND MasterId = @masterId
                                AND CONVERT(NVARCHAR(10), CreateDate, 120) = @signDate )
                SET @message = '������ǩ����'
            ELSE
                SET @message = ''

        SELECT  @message
        
    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoachAge]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--��ȡ����-- ����
CREATE FUNCTION [dbo].[fn_GetCoachAge] 
(
	@BeginTeachingDate DATETIME
)
RETURNS INT
AS
    BEGIN
		RETURN YEAR(GETDATE())-YEAR(@BeginTeachingDate)
    END



GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoachAVGScore]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--��ȡ������ƽ������ 
CREATE FUNCTION [dbo].[fn_GetCoachAVGScore] 
(
	@CoacherUserId NVARCHAR(50) 
)
RETURNS DECIMAL(18,2)	 
AS
    BEGIN
		DECLARE @score DECIMAL(18,2)	
		SELECT 
			@score=	AVG(Score)
		FROM CoachComment 
		WHERE CoacherUserId=@CoacherUserId
		RETURN @score
    END



GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoacherScore]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetCoacherScore] 
(
	@CoacherUserId NVARCHAR(50) 
)
RETURNS DECIMAL(18,2)	 
AS
    BEGIN
		DECLARE @score DECIMAL(18,2)	
		SELECT 
			@score=	AVG(Score)
		FROM CoacherComment 
		WHERE CoacherUserId=@CoacherUserId
		RETURN @score
    END



GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetDate]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetDate] ( @datetime DATETIME )
RETURNS NVARCHAR(10)
AS
    BEGIN
        DECLARE @result NVARCHAR(10) 
        SET @result = CONVERT(NVARCHAR(10), @datetime, 120)
        RETURN @result

    END



GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetDistance]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetDistance] 

 --LatBegin ��ʼγ�� latitude
 --LngBegin ��ʼ���� longitude
    (
      @LatBegin REAL ,
      @LngBegin REAL ,
      @LatEnd REAL ,
      @LngEnd REAL
    )
RETURNS FLOAT
AS
    BEGIN
		--���㿪ʼ����γ�Ⱥ� ��������γ�� ֮��ľ��� (ǧ��)
        DECLARE @Distance REAL ,
            @EARTH_RADIUS REAL

        SET @EARTH_RADIUS = 6378.137 

        DECLARE @RadLatBegin REAL ,
            @RadLatEnd REAL ,
            @RadLatDiff REAL ,
            @RadLngDiff REAL

        SET @RadLatBegin = @LatBegin * PI() / 180.0 

        SET @RadLatEnd = @LatEnd * PI() / 180.0 

        SET @RadLatDiff = @RadLatBegin - @RadLatEnd 

        SET @RadLngDiff = @LngBegin * PI() / 180.0 - @LngEnd * PI() / 180.0 

        SET @Distance = 2 * ASIN(SQRT(POWER(SIN(@RadLatDiff / 2), 2)
                                      + COS(@RadLatBegin) * COS(@RadLatEnd)
                                      * POWER(SIN(@RadLngDiff / 2), 2)))

        SET @Distance = @Distance * @EARTH_RADIUS 

 	   --@Distance�ĵ�λΪ:ǧ��
        RETURN @Distance

    END



GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetFinalRank]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetFinalRank]
    (
      @gameId NVARCHAR(50) ,
      @teamId NVARCHAR(50) ,
      @gameKnockout NVARCHAR(50)
    )
RETURNS INT
AS
    BEGIN
        DECLARE @finalRank INT
        SET @finalRank = 10000

		--��ѭ����С���Ա���з�������
        IF @gameKnockout = '014002'
            SELECT  @finalRank = CASE WHEN ISNULL(Rank, 0) = 0 THEN 10000
                                      ELSE Rank
                                 END
            FROM    dbo.GameGroupMember a
            WHERE   GameId = @gameId
                    AND TeamId = @teamId
        ELSE
            BEGIN
				--����̭����ѭ������̭����̭���з�������

				--����Ƿ�����˸�����
                DECLARE @maxExtraOrder INT
                SELECT  @maxExtraOrder = MAX(ExtraOrder)
                FROM    dbo.GameLoop
                WHERE   GameId = @gameId
                        AND ( Team1Id = @teamId
                              OR Team2Id = @teamId
                            )
                        AND IsExtra = 1
				--�����˸���������ȡ����������
                IF ISNULL(@maxExtraOrder, 0) > 0
                    SELECT  @finalRank = CASE WHEN BeginRank + 1 = EndRank
                                                   AND Score1 != Score2
                                              THEN ( CASE WHEN Team1Id = @teamId
                                                          THEN ( CASE
                                                              WHEN Score1 > Score2
                                                              THEN BeginRank
                                                              ELSE EndRank
                                                              END )
                                                          ELSE ( CASE
                                                              WHEN Score1 > Score2
                                                              THEN EndRank
                                                              ELSE BeginRank
                                                              END )
                                                     END )
											--�����һ�������������һ��δ������������
                                              ELSE EndRank / 2 + 1
                                         END
                    FROM    dbo.GameLoop
                    WHERE   GameId = @gameId
                            AND ExtraOrder = @maxExtraOrder
                            AND ( Team1Id = @teamId
                                  OR Team2Id = @teamId
                                )
                            AND IsExtra = 1 

                ELSE
                    BEGIN
					--����Ƿ��������̭����
                        DECLARE @maxOrder INT
                        SELECT  @maxOrder = MAX(b.OrderNo)
                        FROM    dbo.GameLoop a
                                JOIN dbo.GameOrder b ON a.OrderId = b.Id
                        WHERE   a.GameId = @gameId
                                AND ( Team1Id = @teamId
                                      OR Team2Id = @teamId
                                    )
                                AND a.IsExtra = 0
                                AND a.OrderNo > 0--�ų���λ��
                                AND b.KnockoutOption = '014001'
						--�����������̭����������ȡ��̭������

                        IF ISNULL(@maxOrder, 0) > 0
                            BEGIN
                                SELECT  @finalRank = CASE WHEN a.BeginRank + 1 = a.EndRank
                                                              AND Score1 != Score2--����
                                                              THEN ( CASE
                                                              WHEN Team1Id = @teamId
                                                              THEN ( CASE
                                                              WHEN Score1 > Score2
                                                              THEN a.BeginRank
                                                              ELSE a.EndRank
                                                              END )
                                                              ELSE ( CASE
                                                              WHEN Score1 > Score2
                                                              THEN a.EndRank
                                                              ELSE a.BeginRank
                                                              END )
                                                              END )
														--�Ǿ����;���δ������������
                                                          ELSE a.EndRank / 2
                                                              + 1
                                                     END
                                FROM    dbo.GameLoop a
                                        JOIN dbo.GameOrder b ON a.OrderId = b.Id
                                WHERE   a.GameId = @gameId
                                        AND b.OrderNo = @maxOrder
                                        AND ( Team1Id = @teamId
                                              OR Team2Id = @teamId
                                            )
                                        AND a.IsExtra = 0
                            END
                    END

					--���û�н��븽��������̭�������򷵻�NULL
            END
        RETURN @finalRank

    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetGameTeamScore]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetGameTeamScore]
    (
      @loopId NVARCHAR(50) ,
      @isTeam1 BIT
    )
RETURNS INT
AS
    BEGIN
        DECLARE @result INT 
        SET @result = 0

        IF @isTeam1 = 1
            SELECT  @result = CASE WHEN a.State != '011002'
                                        OR a.IsTeam = 0 THEN a.Team1
                                   ELSE ( SELECT    COUNT(*)
                                          FROM      dbo.GameLoopMap
                                          WHERE     LoopId = a.Id
                                                    AND Game1 > Game2
                                        )
                              END
            FROM    dbo.GameLoop a
            WHERE   a.Id = @loopId
        ELSE
            SELECT  @result = CASE WHEN a.State != '011002'
                                        OR a.IsTeam = 0 THEN a.Team2
                                   ELSE ( SELECT    COUNT(*)
                                          FROM      dbo.GameLoopMap
                                          WHERE     LoopId = a.Id
                                                    AND Game2 > Game1
                                        )
                              END
            FROM    dbo.GameLoop a
            WHERE   a.Id = @loopId
        RETURN @result

    END



GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetLinkVenueName]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetLinkVenueName] ( @Id NVARCHAR(50) )
RETURNS NVARCHAR(100)
AS
    BEGIN
        DECLARE @result NVARCHAR(100)

        IF ISNULL(@Id, '') != ''
            SELECT  @result = Name
            FROM    dbo.Venue
            WHERE   Id = @Id

        SET @result = dbo.fn_Link(@Id, @result)

        RETURN @result
    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetReplyCount]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetReplyCount] ( @id NVARCHAR(50) )
RETURNS INT
AS
    BEGIN
        DECLARE @replyCount INT
        SELECT  @replyCount = COUNT(*)
        FROM    NoteReply
        WHERE   NoteId = @id
        RETURN @replyCount
    END


GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetSignCount]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetSignCount] ( @id NVARCHAR(50) )
RETURNS INT
AS
    BEGIN
        DECLARE @count INT
        SELECT  @count = COUNT(*)
        FROM    UserSign
        WHERE   MasterId = @id
                AND CONVERT(NVARCHAR(10), CreateDate, 120) = CONVERT(NVARCHAR(10), GETDATE(), 120)
        RETURN @count
    END


GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetTeachingPointCoachIds]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE FUNCTION [dbo].[fn_GetTeachingPointCoachIds]
    (
      @venueId NVARCHAR(50) 
    )
RETURNS NVARCHAR(MAX)
AS
    BEGIN

        DECLARE @sql NVARCHAR(MAX)=''
		SELECT	
			@sql= @sql+','+a.CoacherId
		FROM dbo.CoachTeachingPointCoaches  a
		WHERE VenueId=@venueId
		
        RETURN @sql
    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetTeachingPointCoachNames]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE FUNCTION [dbo].[fn_GetTeachingPointCoachNames]
    (
      @venueId NVARCHAR(50) 
    )
RETURNS NVARCHAR(MAX)
AS
    BEGIN

        DECLARE @sql NVARCHAR(MAX)=''
		SELECT	
			@sql= @sql+'��'+b.CardName 
		FROM dbo.CoachTeachingPointCoaches  a
		INNER JOIN dbo.UserAccount b ON a.CoacherId=b.Id
		WHERE VenueId=@venueId
		
        RETURN @sql
    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkCardName]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetUserLinkCardName] ( @userId NVARCHAR(50) )
RETURNS NVARCHAR(100)
AS
    BEGIN
        DECLARE @result NVARCHAR(100)

        SELECT  @result = CardName
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        SET @result = dbo.fn_Link(@userId, @result)

        RETURN @result
    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkName]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetUserLinkName]
    (
      @option NVARCHAR(50) ,
      @userId NVARCHAR(50) ,
      @petName NVARCHAR(50) ,
      @cardName NVARCHAR(50)
    )
RETURNS NVARCHAR(100)
AS
    BEGIN
        DECLARE @result NVARCHAR(100)

        IF ISNULL(@petName, '') != ''
            BEGIN
                SET @result = CASE WHEN @option = '020001' THEN @petName
                                   WHEN @option = '020002' THEN @cardName
                                   ELSE @cardName
                              END
                SET @result = dbo.fn_Link(@userId, @result)
            END

        RETURN @result
    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkPetName]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetUserLinkPetName]
    (
      @userId NVARCHAR(50) ,
      @clubId NVARCHAR(50)
    )
RETURNS NVARCHAR(100)
AS
    BEGIN
        DECLARE @result NVARCHAR(100)

        IF ISNULL(@clubId, '') != ''
            SELECT  @result = PetName
            FROM    dbo.ClubUser
            WHERE   ClubId = @clubId
                    AND UserId = @userId

        IF ISNULL(@result, '') = ''
            OR dbo.fn_Trim(@result) = ''
            SELECT  @result = PetName
            FROM    dbo.UserAccount
            WHERE   Id = @userId

        SET @result = dbo.fn_Link(@userId, @result)

        RETURN @result
    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserName]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetUserName]
    (
      @userId NVARCHAR(50) 
    )
RETURNS NVARCHAR(100)
AS
    BEGIN
        DECLARE @result NVARCHAR(100)

		SELECT @result=(CASE WHEN ISNULL(CardName,'')='' THEN PetName ELSE CardName END) 
		FROM dbo.UserAccount 
		WHERE Id =@userId

        RETURN @result
    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserNameString]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetUserNameString]
    (
      @userIdString NVARCHAR(500) ,
      @isCardName BIT ,
      @clubId NVARCHAR(50)
    )
RETURNS NVARCHAR(500)
AS
    BEGIN
        DECLARE @result NVARCHAR(500)
        SET @result = ''

        DECLARE cursor_user CURSOR
        FOR
            SELECT  dbo.fn_GetUserLinkPetName(Id, @clubId) AS PetName ,
                    CardName
            FROM    dbo.UserAccount
            WHERE   Id IN ( SELECT  Id
                            FROM    dbo.fn_Split(@userIdString) ) 
        OPEN cursor_user

        DECLARE @PetName NVARCHAR(50)
        DECLARE @CardName NVARCHAR(50)
        FETCH NEXT FROM cursor_user INTO @PetName, @CardName
        WHILE @@FETCH_STATUS = 0
            BEGIN
                IF LEN(@result) > 0
                    SET @result = @result + ','
		
                SET @result = @result
                    + CASE WHEN @isCardName = 1
                           THEN ISNULL(@CardName, @PetName)
                           ELSE @PetName
                      END
                FETCH NEXT FROM cursor_user INTO @PetName, @CardName
            END

        CLOSE cursor_user
        DEALLOCATE cursor_user

        RETURN @result

    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserPetName]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetUserPetName]
    (
      @userId NVARCHAR(50) ,
      @clubId NVARCHAR(50)
    )
RETURNS NVARCHAR(100)
AS
    BEGIN
        DECLARE @result NVARCHAR(100)

        IF ISNULL(@clubId, '') != ''
            SELECT  @result = PetName
            FROM    dbo.ClubUser
            WHERE   ClubId = @clubId
                    AND UserId = @userId

        IF ISNULL(@result, '') = ''
            OR dbo.fn_Trim(@result) = ''
            SELECT  @result = PetName
            FROM    dbo.UserAccount
            WHERE   Id = @userId

        RETURN @result
    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetVenueNameString]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetVenueNameString]
    (
      @venueIdString NVARCHAR(500)
    )
RETURNS NVARCHAR(500)
AS
    BEGIN
        DECLARE @result NVARCHAR(500)
        SET @result = ''

        DECLARE cursor_user CURSOR
        FOR
            SELECT  Name
            FROM    dbo.Venue
            WHERE   Id IN ( SELECT  Id
                            FROM    dbo.fn_Split(@venueIdString) ) 
        OPEN cursor_user

        DECLARE @name NVARCHAR(50)
        FETCH NEXT FROM cursor_user INTO @name
        WHILE @@FETCH_STATUS = 0
            BEGIN
                IF LEN(@result) > 0
                    SET @result = @result + ','
		
                SET @result = @result + @name
                FETCH NEXT FROM cursor_user INTO @name
            END

        CLOSE cursor_user
        DEALLOCATE cursor_user

        RETURN @result

    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetVenueUserUseCount]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetVenueUserUseCount]
    (
      @venueId NVARCHAR(40) ,
      @userId NVARCHAR(50) ,
      @date DATETIME
    )
RETURNS INT
AS
    BEGIN
        DECLARE @count INT
        SELECT  @count = COUNT(*)
        FROM    dbo.VipUse
        WHERE   VenueId = @venueId
                AND UserId = @userId
                AND CONVERT(NVARCHAR(10), CreateDate, 120) = CONVERT(NVARCHAR(10), @date, 120)
        RETURN @count
    END


GO
/****** Object:  UserDefinedFunction [dbo].[fn_Link]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_Link]
    (
      @id NVARCHAR(50) ,
      @name NVARCHAR(200)
    )
RETURNS NVARCHAR(200)
AS
    BEGIN
        RETURN @id + ',' + @name
    END


GO
/****** Object:  UserDefinedFunction [dbo].[fn_NewId]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_NewId]
    (
      @guid UNIQUEIDENTIFIER
    )
RETURNS NVARCHAR(50)
AS
    BEGIN
        DECLARE @s NVARCHAR(50)
        SET @s = REPLACE(CAST(@guid AS NVARCHAR(50)), '-', '')
        RETURN @s

    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_SamePart]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_SamePart]
    (
      @str1 NVARCHAR(500) ,
      @str2 NVARCHAR(500)
    )
RETURNS INT
AS
    BEGIN

        DECLARE @result INT
        SET @result = 0;

		DECLARE @s NVARCHAR(100)

        WHILE LEN(@str1) > 0
            BEGIN
                IF CHARINDEX(',', @str1) > 0
                    BEGIN
                        SET @s = SUBSTRING(@str1, 1, CHARINDEX(',', @str1) - 1)
                        IF CHARINDEX(@s, @str2) > 0
                            BEGIN
                                SET @result = 1
                                BREAK
                            END
                        ELSE
                            SET @str1 = REPLACE(@str1, @s + ',', '')
                    END
                ELSE
                    BEGIN
                        IF CHARINDEX(@str1, @str2) > 0
                            BEGIN
                                SET @result = 1
                            END
                        BREAK
                    END

            END


        RETURN @result

    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_SimpleContent]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_SimpleContent] ( @content NVARCHAR(MAX) )
RETURNS NVARCHAR(100)
AS
    BEGIN
        DECLARE @result NVARCHAR(100)

        IF LEN(@content) > 60
            SET @result = LEFT(@content, 60) + '...'
        ELSE
            SET @result = @content

        RETURN @result

    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_Split]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_Split] ( @str NVARCHAR(MAX) )
RETURNS @result TABLE ( Id NVARCHAR(50) )
AS
    BEGIN
        DECLARE @split NVARCHAR(10) 
        SET @split = ','

        DECLARE @splitlen INT
        SET @splitlen = LEN(@split + 'a') - 2

        WHILE CHARINDEX(@split, @str) > 0
            BEGIN
                INSERT  @result
                VALUES  ( LEFT(@str, CHARINDEX(@split, @str) - 1) )
                SET @str = STUFF(@str, 1, CHARINDEX(@split, @str) + @splitlen,
                                 '')
            END
        INSERT  @result
        VALUES  ( @str )

        RETURN
    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_Trim]    Script Date: 2017/4/26 10:08:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_Trim] ( @value NVARCHAR(100) )
RETURNS NVARCHAR(100)
AS
    BEGIN
        DECLARE @result NVARCHAR(100)

        IF ISNULL(@value, '') != ''
            SET @result = LTRIM(RTRIM(@value))
        ELSE
            SET @result = @value

        RETURN @result

    END

GO


---ɾ����
--IF OBJECT_ID('Coacher', 'U') IS  NOT NULL
--BEGIN
--	DROP TABLE Coacher
--END

--IF OBJECT_ID('CoacherApply', 'U') IS  NOT NULL
--BEGIN
--	DROP TABLE CoacherApply
--END 

--IF OBJECT_ID('CoacherComment', 'U') IS  NOT NULL
--BEGIN
--	DROP TABLE CoacherComment
--END 

--IF OBJECT_ID('CoacherCourse', 'U') IS  NOT NULL
--BEGIN
--	DROP TABLE CoacherCourse
--END 


--IF OBJECT_ID('CoacherCourseBak', 'U') IS  NOT NULL
--BEGIN
--	DROP TABLE CoacherCourseBak
--END 

--IF OBJECT_ID('CoacherCourseJoin', 'U') IS  NOT NULL
--BEGIN
--	DROP TABLE CoacherCourseJoin
--END 

--IF OBJECT_ID('CoacherPrice', 'U') IS  NOT NULL
--BEGIN
--	DROP TABLE CoacherPrice
--END 

--IF OBJECT_ID('CoacherStudentMoney', 'U') IS  NOT NULL
--BEGIN
--	DROP TABLE CoacherStudentMoney
--END 

--IF OBJECT_ID('CoacherStudentMoneyNotPay', 'U') IS  NOT NULL
--BEGIN
--	DROP TABLE CoacherStudentMoneyNotPay
--END 

--�İ汾��
 UPDATE dbo.AppVersion SET 
	AndroidCode='180' ,
	AndroidName='1.8.0',
	IosCode='180',
	IosName='1.8.0',
	CreateDate=GETDATE(),
	IsRelease=1
WHERE Id='BCB89F64-83D3-4FC6-BC29-39D49CD1BD3D'

 


