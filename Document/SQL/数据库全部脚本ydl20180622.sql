/*
Navicat SQL Server Data Transfer

Source Server         : 192.168.0.3
Source Server Version : 110000
Source Host           : 192.168.0.3\ydlmserver:1433
Source Database       : YDL
Source Schema         : dbo

Target Server Type    : SQL Server
Target Server Version : 110000
File Encoding         : 65001

Date: 2018-06-22 15:40:57
*/


-- ----------------------------
-- Table structure for Activity
-- ----------------------------
DROP TABLE [dbo].[Activity]
GO
CREATE TABLE [dbo].[Activity] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NULL ,
[Type] nvarchar(50) NULL ,
[SportId] nvarchar(50) NULL ,
[BattleStyle] nvarchar(50) NULL ,
[HeadUrl] nvarchar(200) NULL ,
[Introduce] nvarchar(MAX) NULL ,
[ClubId] nvarchar(50) NULL ,
[BeginTime] datetime NULL ,
[EndTime] datetime NULL ,
[State] nvarchar(50) NULL ,
[CityId] nvarchar(50) NULL ,
[VenueId] nvarchar(50) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for ActivityUser
-- ----------------------------
DROP TABLE [dbo].[ActivityUser]
GO
CREATE TABLE [dbo].[ActivityUser] (
[Id] nvarchar(50) NOT NULL ,
[ActivityId] nvarchar(50) NULL ,
[UserId] nvarchar(50) NULL ,
[IsJoined] bit NULL ,
[Remark] nvarchar(MAX) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for AppVersion
-- ----------------------------
DROP TABLE [dbo].[AppVersion]
GO
CREATE TABLE [dbo].[AppVersion] (
[Id] nvarchar(50) NOT NULL ,
[PcCode] int NULL ,
[PcName] nvarchar(50) NULL ,
[PcRemark] nvarchar(MAX) NULL ,
[AndroidCode] int NULL ,
[AndroidName] nvarchar(50) NULL ,
[AndroidRemark] nvarchar(MAX) NULL ,
[IosCode] int NULL ,
[IosName] nvarchar(50) NULL ,
[IosRemark] nvarchar(MAX) NULL ,
[CreateDate] datetime NULL ,
[IsRelease] bit NULL ,
[AndroidIsUpdate] bit NULL DEFAULT ((0)) ,
[IosIsUpdate] bit NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Table structure for BaseData
-- ----------------------------
DROP TABLE [dbo].[BaseData]
GO
CREATE TABLE [dbo].[BaseData] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NULL ,
[GroupId] nvarchar(50) NULL ,
[SortIndex] int NULL ,
[IsEnable] bit NULL ,
[MapName] nvarchar(50) NULL 
)


GO

-- ----------------------------
-- Table structure for City
-- ----------------------------
DROP TABLE [dbo].[City]
GO
CREATE TABLE [dbo].[City] (
[Id] nvarchar(50) NOT NULL ,
[CityCode] nvarchar(50) NULL ,
[Name] nvarchar(50) NULL ,
[ParentId] nvarchar(50) NULL ,
[Lat] float(53) NULL ,
[Lng] float(53) NULL ,
[CreateDate] datetime NULL ,
[IsCommon] bit NULL 
)


GO

-- ----------------------------
-- Table structure for Club
-- ----------------------------
DROP TABLE [dbo].[Club]
GO
CREATE TABLE [dbo].[Club] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NULL ,
[CityId] nvarchar(50) NULL ,
[Introduce] nvarchar(MAX) NULL ,
[SignName] nvarchar(50) NULL ,
[HeadUrl] nvarchar(200) NULL ,
[SportId] nvarchar(50) NULL ,
[Remark] nvarchar(MAX) NULL ,
[LevelValue] int NULL ,
[IsStop] bit NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for ClubAddress
-- ----------------------------
DROP TABLE [dbo].[ClubAddress]
GO
CREATE TABLE [dbo].[ClubAddress] (
[Id] nvarchar(50) NULL ,
[ClubId] nvarchar(50) NULL ,
[VenueId] nvarchar(50) NULL ,
[Remark] nvarchar(MAX) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for ClubHonor
-- ----------------------------
DROP TABLE [dbo].[ClubHonor]
GO
CREATE TABLE [dbo].[ClubHonor] (
[Id] nvarchar(50) NOT NULL ,
[SortIndex] int NULL ,
[Name] nvarchar(50) NULL ,
[ClubId] nvarchar(50) NULL ,
[BeginScore] int NULL ,
[EndScore] int NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for ClubRequest
-- ----------------------------
DROP TABLE [dbo].[ClubRequest]
GO
CREATE TABLE [dbo].[ClubRequest] (
[Id] nvarchar(50) NOT NULL ,
[ClubId] nvarchar(50) NULL ,
[Remark] nvarchar(MAX) NULL ,
[State] nvarchar(50) NULL ,
[AuditorId] nvarchar(50) NULL ,
[RowVersion] timestamp NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for ClubUser
-- ----------------------------
DROP TABLE [dbo].[ClubUser]
GO
CREATE TABLE [dbo].[ClubUser] (
[Id] nvarchar(50) NOT NULL ,
[ClubId] nvarchar(50) NULL ,
[UserId] nvarchar(50) NULL ,
[IsCreator] bit NULL ,
[IsAdmin] bit NULL ,
[PetName] nvarchar(50) NULL ,
[LevelValue] int NULL ,
[Score] int NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for Coach
-- ----------------------------
DROP TABLE [dbo].[Coach]
GO
CREATE TABLE [dbo].[Coach] (
[Id] nvarchar(50) NOT NULL ,
[CommissionPercentage] decimal(18,2) NULL ,
[HeadUrl] nvarchar(2000) NULL ,
[IdCardFrontUrl] nvarchar(2000) NULL ,
[IdCardBackUrl] nvarchar(2000) NULL ,
[VenueId] nvarchar(50) NULL ,
[BeginTeachingDate] datetime NULL ,
[Qualification] nvarchar(1000) NULL ,
[State] nvarchar(50) NOT NULL ,
[Grade] int NULL ,
[AuditOpinion] nvarchar(500) NULL ,
[OrganizationId] nvarchar(50) NULL ,
[IsEnabled] bit NULL ,
[FileId] nvarchar(50) NULL ,
[AuditDateTime] datetime NULL ,
[CreateDate] datetime NOT NULL ,
[SealedOrganizationId] nvarchar(50) NULL DEFAULT '' 
)


GO

-- ----------------------------
-- Table structure for CoachApply
-- ----------------------------
DROP TABLE [dbo].[CoachApply]
GO
CREATE TABLE [dbo].[CoachApply] (
[Id] nvarchar(50) NOT NULL ,
[CommissionPercentage] decimal(18,2) NULL ,
[HeadUrl] nvarchar(2000) NULL ,
[IdCardFrontUrl] nvarchar(2000) NULL ,
[IdCardBackUrl] nvarchar(2000) NULL ,
[VenueId] nvarchar(50) NULL ,
[BeginTeachingDate] datetime NULL ,
[Qualification] nvarchar(1000) NULL ,
[State] nvarchar(50) NOT NULL ,
[Grade] int NULL ,
[AuditOpinion] nvarchar(500) NULL ,
[OrganizationId] nvarchar(50) NULL ,
[IsEnabled] bit NULL ,
[FileId] nvarchar(50) NULL ,
[Name] nvarchar(50) NULL ,
[Mobile] nvarchar(20) NULL ,
[CardId] nvarchar(50) NULL ,
[AuditDateTime] datetime NULL ,
[CreateDate] datetime NOT NULL ,
[SealedOrganizationId] nvarchar(50) NULL DEFAULT '' 
)


GO

-- ----------------------------
-- Table structure for CoachBigCourseInfo
-- ----------------------------
DROP TABLE [dbo].[CoachBigCourseInfo]
GO
CREATE TABLE [dbo].[CoachBigCourseInfo] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[Price] decimal(18,2) NOT NULL ,
[Content] nvarchar(2000) NOT NULL ,
[HeadUrl] nvarchar(500) NULL ,
[CreateDate] datetime NOT NULL ,
[CourseContent] nvarchar(2000) NULL DEFAULT '' ,
[CoachPriceId] nvarchar(50) NULL DEFAULT '' 
)


GO

-- ----------------------------
-- Table structure for CoachBootcamp
-- ----------------------------
DROP TABLE [dbo].[CoachBootcamp]
GO
CREATE TABLE [dbo].[CoachBootcamp] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(100) NULL ,
[State] nvarchar(50) NULL ,
[Price] numeric(18,2) NULL ,
[DiscountPrice] numeric(18,2) NULL ,
[BeginTime] datetime NULL ,
[EndTime] datetime NULL ,
[JoinDeadline] datetime NULL ,
[VenueId] nvarchar(50) NULL ,
[Remark] nvarchar(4000) NULL ,
[HeadUrl] nvarchar(200) NULL ,
[UpdateDate] datetime NULL ,
[CreateDate] datetime NULL ,
[CourseCount] int NULL ,
[CourseContent] nvarchar(2000) NULL DEFAULT '' ,
[SealedOrganizationId] nvarchar(50) NULL DEFAULT ('ydl') 
)


GO

-- ----------------------------
-- Table structure for CoachBootcampCourse
-- ----------------------------
DROP TABLE [dbo].[CoachBootcampCourse]
GO
CREATE TABLE [dbo].[CoachBootcampCourse] (
[Id] nvarchar(50) NOT NULL ,
[CoachBootcampId] nvarchar(50) NULL ,
[BeginTime] datetime NULL ,
[EndTime] datetime NULL ,
[CourseContent] nvarchar(2000) NULL ,
[CreateDate] datetime NULL ,
[SealedOrganizationId] nvarchar(50) NULL DEFAULT '' 
)


GO

-- ----------------------------
-- Table structure for CoachBootcampCourseJoin
-- ----------------------------
DROP TABLE [dbo].[CoachBootcampCourseJoin]
GO
CREATE TABLE [dbo].[CoachBootcampCourseJoin] (
[Id] nvarchar(50) NOT NULL ,
[StudentId] nvarchar(50) NOT NULL ,
[BootcampCourseId] nvarchar(50) NOT NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for CoachBootcampStudent
-- ----------------------------
DROP TABLE [dbo].[CoachBootcampStudent]
GO
CREATE TABLE [dbo].[CoachBootcampStudent] (
[Id] nvarchar(50) NOT NULL ,
[CoachBootcampId] nvarchar(50) NOT NULL ,
[StudentId] nvarchar(50) NOT NULL ,
[SealedOrganizationId] nvarchar(50) NOT NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for CoachComment
-- ----------------------------
DROP TABLE [dbo].[CoachComment]
GO
CREATE TABLE [dbo].[CoachComment] (
[Id] nvarchar(50) NOT NULL ,
[CoacherUserId] nvarchar(50) NOT NULL ,
[CourseId] nvarchar(50) NOT NULL ,
[Score] decimal(18,2) NOT NULL ,
[Comment] nvarchar(500) NOT NULL ,
[CommentatorId] nvarchar(50) NOT NULL ,
[IsShareName] bit NOT NULL ,
[HeadUrl] nvarchar(500) NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for CoachCommentStudent
-- ----------------------------
DROP TABLE [dbo].[CoachCommentStudent]
GO
CREATE TABLE [dbo].[CoachCommentStudent] (
[Id] nvarchar(50) NOT NULL ,
[CoursePersonInfoId] nvarchar(50) NULL ,
[YdlUserId] nvarchar(50) NULL ,
[CourseSummary] nvarchar(500) NULL ,
[TeachTypeId] nvarchar(200) NULL ,
[HeadUrl] nvarchar(200) NULL ,
[CommentatorId] nvarchar(500) NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for CoachCourse
-- ----------------------------
DROP TABLE [dbo].[CoachCourse]
GO
CREATE TABLE [dbo].[CoachCourse] (
[Id] nvarchar(50) NOT NULL ,
[CoachId] nvarchar(50) NOT NULL ,
[State] nvarchar(50) NOT NULL ,
[BeginTime] datetime NOT NULL ,
[EndTime] datetime NOT NULL ,
[Type] nvarchar(20) NOT NULL ,
[VenueId] nvarchar(50) NOT NULL ,
[CourseGrade] int NULL ,
[CourseContent] nvarchar(1000) NULL ,
[CategoryOfTechnologyId] nvarchar(50) NULL ,
[CourseSummary] nvarchar(1000) NULL ,
[CityId] nvarchar(50) NOT NULL ,
[CreateDate] datetime NULL ,
[HeadUrl] nvarchar(200) NULL ,
[CoachBootcampCourseId] nvarchar(50) NULL ,
[CreatorId] nvarchar(50) NULL ,
[BigCourseId] nvarchar(50) NULL DEFAULT '' ,
[ReservedPersonId] nvarchar(50) NULL DEFAULT '' ,
[CourseGoalCode] nvarchar(50) NULL DEFAULT '' ,
[Remark] nvarchar(50) NULL DEFAULT '' ,
[CourseNameId] nvarchar(50) NULL DEFAULT '' ,
[StartCardAddress] nvarchar(200) NULL DEFAULT '' ,
[EndCardAddress] nvarchar(200) NULL DEFAULT '' ,
[StartCardTime] datetime NULL ,
[EndCardTime] datetime NULL ,
[CoachBootcampId] nvarchar(50) NULL DEFAULT '' 
)


GO

-- ----------------------------
-- Table structure for CoachCourseBak
-- ----------------------------
DROP TABLE [dbo].[CoachCourseBak]
GO
CREATE TABLE [dbo].[CoachCourseBak] (
[Id] nvarchar(50) NOT NULL ,
[CoachId] nvarchar(50) NOT NULL ,
[State] nvarchar(50) NULL ,
[BeginTime] datetime NULL ,
[EndTime] datetime NOT NULL ,
[Type] nvarchar(20) NOT NULL ,
[VenueId] nvarchar(50) NOT NULL ,
[CourseGrade] int NULL ,
[CourseContent] nvarchar(1000) NULL ,
[CategoryOfTechnologyId] nvarchar(50) NULL ,
[CourseSummary] nvarchar(1000) NULL ,
[CreateDate] datetime NULL ,
[HeadUrl] nvarchar(200) NULL 
)


GO

-- ----------------------------
-- Table structure for CoachCourseJoin
-- ----------------------------
DROP TABLE [dbo].[CoachCourseJoin]
GO
CREATE TABLE [dbo].[CoachCourseJoin] (
[Id] nvarchar(50) NOT NULL ,
[StudentId] nvarchar(50) NOT NULL ,
[CourseId] nvarchar(50) NOT NULL ,
[CoachId] nvarchar(50) NOT NULL ,
[ThenCourseUnitPrice] decimal(18,2) NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for CoachCoursePersonInfo
-- ----------------------------
DROP TABLE [dbo].[CoachCoursePersonInfo]
GO
CREATE TABLE [dbo].[CoachCoursePersonInfo] (
[Id] nvarchar(50) NOT NULL ,
[CourseId] nvarchar(50) NULL ,
[StudentName] nvarchar(20) NULL ,
[StudentMobile] nvarchar(20) NULL ,
[StudentRemark] nvarchar(1000) NULL ,
[CourseGoalCode] nvarchar(20) NULL ,
[HeadUrl] nvarchar(200) NULL ,
[IsSignIn] bit NULL ,
[CreateDate] datetime NOT NULL ,
[YdlUserId] nvarchar(50) NULL DEFAULT '' ,
[FrequentStudentId] nvarchar(50) NULL DEFAULT '' 
)


GO

-- ----------------------------
-- Table structure for CoachFrequentStudent
-- ----------------------------
DROP TABLE [dbo].[CoachFrequentStudent]
GO
CREATE TABLE [dbo].[CoachFrequentStudent] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(20) NULL ,
[Mobile] nvarchar(20) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for CoachIncome
-- ----------------------------
DROP TABLE [dbo].[CoachIncome]
GO
CREATE TABLE [dbo].[CoachIncome] (
[Id] nvarchar(50) NOT NULL ,
[CoachId] nvarchar(50) NOT NULL ,
[StudentId] nchar(10) NULL ,
[CourseId] nvarchar(50) NULL ,
[CourseType] nvarchar(50) NOT NULL ,
[OriginalMoney] decimal(18,2) NOT NULL ,
[CoachCommissionPercentage] decimal(18,2) NOT NULL ,
[CoachRealIncome] decimal(18,2) NULL ,
[OrganizationCommissionPercentage] decimal(18,2) NULL ,
[OrganizationRealIncome] decimal(18,2) NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for CoachLeave
-- ----------------------------
DROP TABLE [dbo].[CoachLeave]
GO
CREATE TABLE [dbo].[CoachLeave] (
[Id] nvarchar(50) NOT NULL ,
[HeadUrl] nvarchar(500) NULL ,
[CoachId] nvarchar(50) NOT NULL ,
[LeaveType] nvarchar(100) NULL ,
[State] nvarchar(50) NOT NULL ,
[BeginTime] datetime NOT NULL ,
[EndTime] datetime NOT NULL ,
[LeaveDays] decimal(18,2) NULL ,
[LeaveReason] nvarchar(1000) NULL ,
[AuditPersonId] nvarchar(50) NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for CoachOrderTrialCourse
-- ----------------------------
DROP TABLE [dbo].[CoachOrderTrialCourse]
GO
CREATE TABLE [dbo].[CoachOrderTrialCourse] (
[Id] nvarchar(50) NOT NULL ,
[StudentId] nvarchar(50) NULL ,
[Name] nvarchar(50) NULL ,
[Mobile] nvarchar(20) NULL ,
[CityCode] nvarchar(10) NULL ,
[Address] nvarchar(300) NULL ,
[Remark] nvarchar(500) NULL ,
[IsContact] bit NULL DEFAULT ((0)) ,
[ContactSituation] nvarchar(500) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for CoachOrganization
-- ----------------------------
DROP TABLE [dbo].[CoachOrganization]
GO
CREATE TABLE [dbo].[CoachOrganization] (
[Id] nvarchar(50) NOT NULL ,
[HeadUrl] nvarchar(500) NULL ,
[Name] nvarchar(100) NOT NULL ,
[Address] nvarchar(500) NULL ,
[CommissionPercentage] decimal(18,2) NULL ,
[ManagerId] nvarchar(1000) NULL ,
[CreateDate] datetime NULL ,
[OrgType] nvarchar(100) NULL DEFAULT '' 
)


GO

-- ----------------------------
-- Table structure for CoachPrice
-- ----------------------------
DROP TABLE [dbo].[CoachPrice]
GO
CREATE TABLE [dbo].[CoachPrice] (
[Id] nvarchar(50) NOT NULL ,
[CityCode] nvarchar(50) NULL ,
[BigCourse] decimal(18,2) NOT NULL ,
[AGrade] decimal(18,2) NOT NULL ,
[BGrade] decimal(18,2) NOT NULL ,
[CGrade] decimal(18,2) NOT NULL ,
[IsEnabled] bit NOT NULL DEFAULT ((0)) ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for CoachStudentMoney
-- ----------------------------
DROP TABLE [dbo].[CoachStudentMoney]
GO
CREATE TABLE [dbo].[CoachStudentMoney] (
[Id] nvarchar(50) NOT NULL ,
[StudentUserId] nvarchar(50) NOT NULL ,
[CoachId] nvarchar(50) NULL ,
[Amount] int NOT NULL ,
[ThenTotalAmount] int NULL ,
[IsPay] bit NOT NULL DEFAULT ((0)) ,
[ThenMoney] decimal(18,2) NOT NULL DEFAULT ((0)) ,
[CourseTypeId] nvarchar(50) NOT NULL ,
[CourseTypeName] nvarchar(50) NOT NULL ,
[Deadline] datetime NULL ,
[CityId] nvarchar(50) NULL ,
[CreateDate] datetime NOT NULL ,
[HeadUrl] nvarchar(500) NULL ,
[CoachBootcampId] nvarchar(50) NULL ,
[VenueId] nvarchar(100) NULL DEFAULT '' ,
[StudentRemark] nvarchar(1000) NULL DEFAULT '' ,
[CourseGoalCode] nvarchar(50) NULL DEFAULT '' ,
[BigCourseInfoId] nvarchar(50) NULL DEFAULT '' ,
[FrequentStudentId] nvarchar(50) NULL DEFAULT '' 
)


GO

-- ----------------------------
-- Table structure for CoachStudentMoneyNotPay
-- ----------------------------
DROP TABLE [dbo].[CoachStudentMoneyNotPay]
GO
CREATE TABLE [dbo].[CoachStudentMoneyNotPay] (
[Id] nvarchar(50) NOT NULL ,
[StudentUserId] nvarchar(50) NOT NULL ,
[CoachId] nvarchar(50) NULL ,
[Amount] int NOT NULL ,
[ThenTotalAmount] int NULL ,
[IsPay] bit NOT NULL DEFAULT ((0)) ,
[ThenMoney] decimal(18,2) NOT NULL DEFAULT ((0)) ,
[CourseTypeId] nvarchar(50) NOT NULL ,
[CourseTypeName] nvarchar(50) NOT NULL ,
[Deadline] datetime NULL ,
[CityId] nvarchar(50) NULL ,
[CreateDate] datetime NOT NULL ,
[HeadUrl] nvarchar(500) NULL ,
[CoachBootcampId] nvarchar(50) NULL ,
[VenueId] nvarchar(100) NULL DEFAULT '' ,
[StudentRemark] nvarchar(1000) NULL DEFAULT '' ,
[CourseGoalCode] nvarchar(50) NULL DEFAULT '' ,
[BigCourseInfoId] nvarchar(50) NULL DEFAULT '' ,
[FrequentStudentId] nvarchar(50) NULL DEFAULT '' 
)


GO

-- ----------------------------
-- Table structure for CoachStudentRemark
-- ----------------------------
DROP TABLE [dbo].[CoachStudentRemark]
GO
CREATE TABLE [dbo].[CoachStudentRemark] (
[Id] nvarchar(50) NOT NULL ,
[CourseId] nvarchar(50) NULL ,
[StudentId] nvarchar(50) NULL ,
[Remark] nvarchar(500) NULL ,
[RemarkUserId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for CoachTeachingPointCoaches
-- ----------------------------
DROP TABLE [dbo].[CoachTeachingPointCoaches]
GO
CREATE TABLE [dbo].[CoachTeachingPointCoaches] (
[Id] nvarchar(50) NOT NULL ,
[VenueId] nvarchar(50) NOT NULL ,
[CoacherId] nvarchar(50) NOT NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for CoachTrainingPlan
-- ----------------------------
DROP TABLE [dbo].[CoachTrainingPlan]
GO
CREATE TABLE [dbo].[CoachTrainingPlan] (
[Id] nvarchar(50) NOT NULL ,
[StudentId] nvarchar(50) NULL ,
[CoachId] nvarchar(50) NULL ,
[TrainingPlanContent] nvarchar(2000) NULL ,
[CreateDate] datetime NOT NULL ,
[HeadUrl] nvarchar(200) NULL 
)


GO

-- ----------------------------
-- Table structure for CoachUserFavorite
-- ----------------------------
DROP TABLE [dbo].[CoachUserFavorite]
GO
CREATE TABLE [dbo].[CoachUserFavorite] (
[Id] nvarchar(50) NULL ,
[UserId] nvarchar(50) NULL ,
[FavoriteId] nvarchar(50) NULL ,
[FavoriteType] nvarchar(100) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for Company
-- ----------------------------
DROP TABLE [dbo].[Company]
GO
CREATE TABLE [dbo].[Company] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NULL ,
[HeadUrl] nvarchar(200) NULL ,
[Introduce] nvarchar(MAX) NULL ,
[SiteUrl] nvarchar(50) NULL ,
[Phone] nvarchar(50) NULL ,
[Address] nvarchar(MAX) NULL ,
[IsStop] bit NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL ,
[WeiXin] nvarchar(50) NULL ,
[AdminId] nvarchar(50) NULL ,
[AlipayId] nvarchar(100) NULL ,
[IsManage] bit NOT NULL DEFAULT ((0)) ,
[IsYDL] bit NOT NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Table structure for CompanyVenues
-- ----------------------------
DROP TABLE [dbo].[CompanyVenues]
GO
CREATE TABLE [dbo].[CompanyVenues] (
[Id] nvarchar(50) NOT NULL ,
[CompanyId] nvarchar(50) NULL ,
[VenueId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for Config
-- ----------------------------
DROP TABLE [dbo].[Config]
GO
CREATE TABLE [dbo].[Config] (
[Id] nvarchar(50) NOT NULL ,
[AliPayId] nvarchar(50) NULL ,
[ActivityScore] int NULL ,
[SkillScore] int NULL ,
[RefundDiscount] float(53) NULL ,
[MaxID] decimal(18) NULL ,
[CreateDate] datetime NULL ,
[IsMainTain] bit NULL ,
[MainTainTip] nvarchar(500) NULL ,
[BigCourseValidDays] int NULL ,
[YueDouConvertibleProportion] int NULL DEFAULT ((10)) ,
[GuessServiceCharge] decimal(18) NULL DEFAULT ((10)) ,
[SocketIpAndPort] nvarchar(20) NULL DEFAULT '' ,
[IntranetHttpIpAndPort] nvarchar(20) NULL DEFAULT '' ,
[IntranetSocketIpAndPort] nvarchar(20) NULL DEFAULT '' 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'Config', 
'COLUMN', N'SocketIpAndPort')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'云服务SOCKET地址'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Config'
, @level2type = 'COLUMN', @level2name = N'SocketIpAndPort'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'云服务SOCKET地址'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Config'
, @level2type = 'COLUMN', @level2name = N'SocketIpAndPort'
GO

-- ----------------------------
-- Table structure for CostType
-- ----------------------------
DROP TABLE [dbo].[CostType]
GO
CREATE TABLE [dbo].[CostType] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NULL ,
[Type] nvarchar(50) NULL 
)


GO

-- ----------------------------
-- Table structure for FileInfo
-- ----------------------------
DROP TABLE [dbo].[FileInfo]
GO
CREATE TABLE [dbo].[FileInfo] (
[Id] nvarchar(50) NOT NULL ,
[MasterType] nvarchar(50) NULL ,
[MasterId] nvarchar(50) NULL ,
[FileName] nvarchar(500) NULL ,
[FilePath] nvarchar(500) NULL ,
[Size] int NULL ,
[CreateDate] datetime NULL ,
[FileType] nvarchar(50) NULL DEFAULT ('029001') ,
[MasterType2] nvarchar(50) NULL ,
[MasterId2] nvarchar(50) NULL ,
[FileCloudId] nvarchar(50) NULL ,
[CoverPath] nvarchar(2000) NULL DEFAULT '' 
)


GO

-- ----------------------------
-- Table structure for Game
-- ----------------------------
DROP TABLE [dbo].[Game]
GO
CREATE TABLE [dbo].[Game] (
[Id] nvarchar(50) NOT NULL ,
[IsTop] bit NULL ,
[HeadUrl] nvarchar(200) NULL ,
[SportId] nvarchar(50) NULL ,
[ActivityId] nvarchar(50) NULL ,
[Name] nvarchar(500) NULL ,
[NameOption] nvarchar(50) NULL ,
[Introduce] nvarchar(MAX) NULL ,
[Prize] nvarchar(MAX) NULL ,
[GameRule] nvarchar(MAX) NULL ,
[ClubId] nvarchar(50) NULL ,
[KnockoutOption] nvarchar(50) NULL ,
[IsKnockOutAB] bit NULL ,
[BattleStyle] nvarchar(50) NULL ,
[BattleStyleCount] int NULL ,
[TeamMode] nvarchar(50) NULL ,
[IsTeam] bit NULL ,
[IsLevelGame] bit NULL ,
[LevelValue] int NULL ,
[CityId] nvarchar(50) NULL ,
[VenueId] nvarchar(50) NULL ,
[Cost] int NULL ,
[Organizer] nvarchar(200) NULL ,
[SecondOrganizer] nvarchar(200) NULL ,
[RegBeginTime] datetime NULL ,
[RegEndTime] datetime NULL ,
[PlayBeginTime] datetime NULL ,
[PlayEndTime] datetime NULL ,
[IsScoreGame] bit NULL ,
[BeginScore] int NULL ,
[EndScore] int NULL ,
[State] nvarchar(50) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL ,
[IsEnableTV] bit NULL DEFAULT ((0)) ,
[IsConcessionScore] bit NOT NULL DEFAULT ((0)) ,
[IsEnableLiveScore] bit NULL DEFAULT ((0)) ,
[AuditId] nvarchar(MAX) NULL ,
[ManageId] nvarchar(MAX) NULL ,
[IsLeague] bit NULL DEFAULT ((0)) 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'Game', 
'COLUMN', N'CreatorId')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'创建者用户 ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Game'
, @level2type = 'COLUMN', @level2name = N'CreatorId'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'创建者用户 ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Game'
, @level2type = 'COLUMN', @level2name = N'CreatorId'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'Game', 
'COLUMN', N'IsEnableLiveScore')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'是否启用APP直播比分显示'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Game'
, @level2type = 'COLUMN', @level2name = N'IsEnableLiveScore'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'是否启用APP直播比分显示'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Game'
, @level2type = 'COLUMN', @level2name = N'IsEnableLiveScore'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'Game', 
'COLUMN', N'AuditId')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'赛事审核员用户ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Game'
, @level2type = 'COLUMN', @level2name = N'AuditId'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'赛事审核员用户ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Game'
, @level2type = 'COLUMN', @level2name = N'AuditId'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'Game', 
'COLUMN', N'ManageId')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'赛事管理员用户ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Game'
, @level2type = 'COLUMN', @level2name = N'ManageId'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'赛事管理员用户ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Game'
, @level2type = 'COLUMN', @level2name = N'ManageId'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'Game', 
'COLUMN', N'IsLeague')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'是否启用联赛模式(单循环才此操作)'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Game'
, @level2type = 'COLUMN', @level2name = N'IsLeague'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'是否启用联赛模式(单循环才此操作)'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Game'
, @level2type = 'COLUMN', @level2name = N'IsLeague'
GO

-- ----------------------------
-- Table structure for GameGroup
-- ----------------------------
DROP TABLE [dbo].[GameGroup]
GO
CREATE TABLE [dbo].[GameGroup] (
[Id] nvarchar(50) NOT NULL ,
[GameId] nvarchar(50) NULL ,
[OrderId] nvarchar(50) NULL ,
[IsTeam] bit NULL ,
[OrderNo] int NULL ,
[Name] nvarchar(50) NULL ,
[LeaderId] nvarchar(50) NULL ,
[TableNo] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for GameGroupMember
-- ----------------------------
DROP TABLE [dbo].[GameGroupMember]
GO
CREATE TABLE [dbo].[GameGroupMember] (
[Id] nvarchar(50) NOT NULL ,
[GameId] nvarchar(50) NULL ,
[GroupId] nvarchar(50) NULL ,
[OrderNo] int NULL ,
[TeamId] nvarchar(50) NULL ,
[IsTeam] bit NULL ,
[GroupScore] int NULL ,
[Rate] float(53) NULL ,
[RateRemark] nvarchar(500) NULL ,
[Rank] int NULL ,
[Remark] nvarchar(500) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for GameJudge
-- ----------------------------
DROP TABLE [dbo].[GameJudge]
GO
CREATE TABLE [dbo].[GameJudge] (
[Id] nvarchar(50) NOT NULL ,
[GameId] nvarchar(50) NULL ,
[UserId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for GameLoop
-- ----------------------------
DROP TABLE [dbo].[GameLoop]
GO
CREATE TABLE [dbo].[GameLoop] (
[Id] nvarchar(50) NOT NULL ,
[GameId] nvarchar(50) NULL ,
[GroupId] nvarchar(50) NULL ,
[OrderId] nvarchar(50) NULL ,
[OrderNo] int NULL ,
[LoopOrderNo] int NULL ,
[BeginRank] int NULL ,
[EndRank] int NULL ,
[IsExtra] bit NULL ,
[ExtraOrder] int NULL ,
[ExtraWinOrder] int NULL ,
[ExtraFailOrder] int NULL ,
[Team1Id] nvarchar(50) NULL ,
[Team2Id] nvarchar(50) NULL ,
[TableNo] int NULL ,
[BeginTime] datetime NULL ,
[StartTime] datetime NULL ,
[EndTime] datetime NULL ,
[MasterJudgeId] nvarchar(50) NULL ,
[JudgeId] nvarchar(50) NULL ,
[IsTeam] bit NULL ,
[Score1] int NULL ,
[Score2] int NULL ,
[Team1] int NULL ,
[Team2] int NULL ,
[Game1] int NULL ,
[Game2] int NULL ,
[Fen1] int NULL ,
[Fen2] int NULL ,
[State] nvarchar(50) NULL ,
[CreateDate] datetime NULL ,
[IsBye] bit NULL ,
[WaiverOption] nvarchar(50) NULL ,
[WinSign] nvarchar(50) NULL ,
[JudgeSign] nvarchar(50) NULL ,
[IsKnock] bit NULL ,
[KnockLoopId] nvarchar(50) NULL ,
[Remark] nvarchar(500) NULL 
)


GO

-- ----------------------------
-- Table structure for GameLoopDetail
-- ----------------------------
DROP TABLE [dbo].[GameLoopDetail]
GO
CREATE TABLE [dbo].[GameLoopDetail] (
[Id] nvarchar(50) NOT NULL ,
[LoopId] nvarchar(50) NULL ,
[MapId] nvarchar(50) NULL ,
[IsTeam] bit NULL ,
[Team1Id] nvarchar(50) NULL ,
[User1Id] nvarchar(200) NULL ,
[Team2Id] nvarchar(50) NULL ,
[User2Id] nvarchar(200) NULL ,
[OrderNo] int NULL ,
[Fen1] int NULL ,
[Fen2] int NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for GameLoopMap
-- ----------------------------
DROP TABLE [dbo].[GameLoopMap]
GO
CREATE TABLE [dbo].[GameLoopMap] (
[Id] nvarchar(50) NOT NULL ,
[LoopId] nvarchar(50) NULL ,
[OrderNo] int NULL ,
[IsTeam] bit NULL ,
[Team1Id] nvarchar(50) NULL ,
[User1Id] nvarchar(200) NULL ,
[User1Name] nvarchar(200) NULL ,
[Team2Id] nvarchar(50) NULL ,
[User2Id] nvarchar(200) NULL ,
[User2Name] nvarchar(200) NULL ,
[Game1] int NULL ,
[Game2] int NULL ,
[Fen1] int NULL ,
[Fen2] int NULL ,
[WaiverOption] nvarchar(50) NULL ,
[WinGame] int NULL ,
[WinSign] nvarchar(50) NULL ,
[JudgeSign] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for GameOrder
-- ----------------------------
DROP TABLE [dbo].[GameOrder]
GO
CREATE TABLE [dbo].[GameOrder] (
[Id] nvarchar(50) NOT NULL ,
[GameId] nvarchar(50) NULL ,
[PreOrderId] nvarchar(50) NULL ,
[NextOrderId] nvarchar(50) NULL ,
[NextOrderBId] nvarchar(50) NULL ,
[OrderNo] int NULL ,
[Name] nvarchar(50) NULL ,
[IsTeam] bit NULL ,
[TeamScoreMode] nvarchar(50) NULL ,
[KnockoutOption] nvarchar(50) NULL ,
[KnockoutCount] int NULL ,
[KnockoutTotal] int NULL ,
[BeginRank] int NULL ,
[EndRank] int NULL ,
[GroupCount] int NULL ,
[CreateDate] datetime NULL ,
[State] nvarchar(50) NULL ,
[IsExtra] bit NULL ,
[WinTeam] int NULL ,
[WinGame] int NULL ,
[KnockOutAB] nvarchar(50) NULL 
)


GO

-- ----------------------------
-- Table structure for GameTeam
-- ----------------------------
DROP TABLE [dbo].[GameTeam]
GO
CREATE TABLE [dbo].[GameTeam] (
[Id] nvarchar(50) NOT NULL ,
[HeadUrl] nvarchar(200) NULL ,
[GameId] nvarchar(50) NULL ,
[IsTeam] bit NULL ,
[TeamName] nvarchar(500) NULL ,
[TeamUserId] nvarchar(500) NULL ,
[TeamUserName] nvarchar(500) NULL ,
[Cost] int NULL ,
[IsPayCost] bit NULL ,
[Remark] nvarchar(500) NULL ,
[State] nvarchar(50) NULL ,
[AuditorId] nvarchar(50) NULL ,
[AuditRemark] nvarchar(500) NULL ,
[AuditDate] nvarchar(50) NULL ,
[IsSeed] bit NULL ,
[SeedNo] int NULL ,
[MobilePhone] nvarchar(50) NULL ,
[IsJoined] bit NULL ,
[CompanyId] nvarchar(50) NULL ,
[CorpTeamId] nvarchar(500) NULL ,
[CorpTeamName] nvarchar(500) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL ,
[NationalId] nvarchar(100) NOT NULL DEFAULT ('flag_china@2x') 
)


GO

-- ----------------------------
-- Table structure for GameTeamLoopTemplet
-- ----------------------------
DROP TABLE [dbo].[GameTeamLoopTemplet]
GO
CREATE TABLE [dbo].[GameTeamLoopTemplet] (
[Id] nvarchar(50) NOT NULL ,
[HeadUrl] nvarchar(500) NULL ,
[Name] nvarchar(100) NULL ,
[RuleCode] nvarchar(200) NULL ,
[PersonCount] int NULL DEFAULT ((0)) ,
[LoopCount] int NULL DEFAULT ((0)) ,
[UseCount] int NULL DEFAULT ((0)) ,
[Description] nvarchar(500) NULL ,
[SharePersonId] nvarchar(50) NULL ,
[IsGuest] bit NULL DEFAULT ((0)) ,
[IsShared] bit NULL DEFAULT ((0)) ,
[IsEnable] bit NULL DEFAULT ((0)) ,
[IsDefault] bit NULL DEFAULT ((0)) ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTemplet', 
'COLUMN', N'PersonCount')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'上场人数'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'PersonCount'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'上场人数'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'PersonCount'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTemplet', 
'COLUMN', N'LoopCount')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'对阵总场数'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'LoopCount'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'对阵总场数'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'LoopCount'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTemplet', 
'COLUMN', N'UseCount')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'模板使用的次数'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'UseCount'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'模板使用的次数'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'UseCount'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTemplet', 
'COLUMN', N'Description')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'模板的说明文字'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'Description'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'模板的说明文字'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'Description'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTemplet', 
'COLUMN', N'SharePersonId')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'此模板的分享人ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'SharePersonId'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'此模板的分享人ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'SharePersonId'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTemplet', 
'COLUMN', N'IsGuest')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'是否启用主客队模式'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'IsGuest'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'是否启用主客队模式'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'IsGuest'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTemplet', 
'COLUMN', N'IsShared')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'此模板是否被分享'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'IsShared'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'此模板是否被分享'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'IsShared'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTemplet', 
'COLUMN', N'IsEnable')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'此模板是否启用'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'IsEnable'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'此模板是否启用'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'IsEnable'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTemplet', 
'COLUMN', N'IsDefault')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'是否是默认模板'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'IsDefault'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'是否是默认模板'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'IsDefault'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTemplet', 
'COLUMN', N'CreatorId')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'创建者用户 ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'CreatorId'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'创建者用户 ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTemplet'
, @level2type = 'COLUMN', @level2name = N'CreatorId'
GO

-- ----------------------------
-- Table structure for GameTeamLoopTempletDetail
-- ----------------------------
DROP TABLE [dbo].[GameTeamLoopTempletDetail]
GO
CREATE TABLE [dbo].[GameTeamLoopTempletDetail] (
[Id] nvarchar(50) NOT NULL ,
[TempletId] nvarchar(50) NOT NULL ,
[OrderNo] int NULL DEFAULT ((0)) ,
[Code1] nvarchar(5) NULL ,
[Code2] nvarchar(5) NULL ,
[IsDouble] bit NULL DEFAULT ((0)) ,
[CreateDate] datetime NULL 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletDetail', 
'COLUMN', N'TempletId')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'团体对阵模板ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletDetail'
, @level2type = 'COLUMN', @level2name = N'TempletId'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'团体对阵模板ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletDetail'
, @level2type = 'COLUMN', @level2name = N'TempletId'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletDetail', 
'COLUMN', N'OrderNo')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'对阵模板出场次序'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletDetail'
, @level2type = 'COLUMN', @level2name = N'OrderNo'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'对阵模板出场次序'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletDetail'
, @level2type = 'COLUMN', @level2name = N'OrderNo'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletDetail', 
'COLUMN', N'Code1')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'队伍1对阵编码(启用了主客队,则为客队对阵编码)'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletDetail'
, @level2type = 'COLUMN', @level2name = N'Code1'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'队伍1对阵编码(启用了主客队,则为客队对阵编码)'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletDetail'
, @level2type = 'COLUMN', @level2name = N'Code1'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletDetail', 
'COLUMN', N'Code2')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'队伍2对阵编码(启用了主客队,则为客队对阵编码)'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletDetail'
, @level2type = 'COLUMN', @level2name = N'Code2'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'队伍2对阵编码(启用了主客队,则为客队对阵编码)'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletDetail'
, @level2type = 'COLUMN', @level2name = N'Code2'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletDetail', 
'COLUMN', N'IsDouble')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'是否是双打'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletDetail'
, @level2type = 'COLUMN', @level2name = N'IsDouble'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'是否是双打'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletDetail'
, @level2type = 'COLUMN', @level2name = N'IsDouble'
GO

-- ----------------------------
-- Table structure for GameTeamLoopTempletMap
-- ----------------------------
DROP TABLE [dbo].[GameTeamLoopTempletMap]
GO
CREATE TABLE [dbo].[GameTeamLoopTempletMap] (
[Id] nvarchar(50) NOT NULL ,
[TempletId] nvarchar(50) NOT NULL ,
[GameId] nvarchar(50) NOT NULL ,
[LoopId] nvarchar(50) NOT NULL ,
[TeamId] nvarchar(50) NOT NULL ,
[Code] nvarchar(5) NULL ,
[CodeUserId] nvarchar(50) NULL ,
[CodeUserName] nvarchar(20) NULL ,
[CreateDate] datetime NULL ,
[IsHost] bit NULL DEFAULT ((0)) 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletMap', 
'COLUMN', N'TempletId')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'团体对阵模板ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'TempletId'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'团体对阵模板ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'TempletId'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletMap', 
'COLUMN', N'GameId')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'赛事ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'GameId'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'赛事ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'GameId'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletMap', 
'COLUMN', N'LoopId')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'对阵ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'LoopId'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'对阵ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'LoopId'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletMap', 
'COLUMN', N'TeamId')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'对阵的队伍ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'TeamId'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'对阵的队伍ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'TeamId'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletMap', 
'COLUMN', N'Code')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'规则编码字符'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'Code'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'规则编码字符'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'Code'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletMap', 
'COLUMN', N'CodeUserId')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'规则编码字符对应的队员ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'CodeUserId'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'规则编码字符对应的队员ID'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'CodeUserId'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletMap', 
'COLUMN', N'CodeUserName')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'规则编码字符对应的队员姓名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'CodeUserName'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'规则编码字符对应的队员姓名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'CodeUserName'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'GameTeamLoopTempletMap', 
'COLUMN', N'IsHost')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'是否是主队(队伍1)'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'IsHost'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'是否是主队(队伍1)'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'GameTeamLoopTempletMap'
, @level2type = 'COLUMN', @level2name = N'IsHost'
GO

-- ----------------------------
-- Table structure for Guess
-- ----------------------------
DROP TABLE [dbo].[Guess]
GO
CREATE TABLE [dbo].[Guess] (
[Id] nvarchar(50) NOT NULL ,
[GuessName] nvarchar(200) NOT NULL ,
[State] nvarchar(50) NULL ,
[VsGameLoopId] nvarchar(50) NULL ,
[VsOrderId] nvarchar(50) NULL ,
[VsOrderNo] int NULL ,
[GuessType] nvarchar(50) NOT NULL ,
[VSLeftId] nvarchar(50) NULL ,
[VSLeftOdds] decimal(18,2) NULL ,
[VsRightId] nvarchar(50) NULL ,
[VsRightOdds] decimal(18,2) NULL ,
[BeginTime] datetime NOT NULL ,
[EndTime] datetime NOT NULL ,
[VictoryDefeatDeclarerDeposit] decimal(18,2) NULL ,
[ScoreDeclarerDeposit] decimal(18,2) NULL ,
[CreateDate] datetime NOT NULL ,
[GameId] nvarchar(50) NULL ,
[CreatorId] nvarchar(50) NULL 
)


GO

-- ----------------------------
-- Table structure for GuessBet
-- ----------------------------
DROP TABLE [dbo].[GuessBet]
GO
CREATE TABLE [dbo].[GuessBet] (
[Id] nvarchar(50) NOT NULL ,
[GuessId] nvarchar(50) NOT NULL ,
[UserId] nvarchar(50) NOT NULL ,
[BetType] nvarchar(50) NULL ,
[Amount] int NOT NULL ,
[BetVSId] nvarchar(50) NULL ,
[LeftScore] int NULL ,
[RightScore] int NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for GuessScore
-- ----------------------------
DROP TABLE [dbo].[GuessScore]
GO
CREATE TABLE [dbo].[GuessScore] (
[Id] nvarchar(50) NOT NULL ,
[GuessId] nvarchar(50) NOT NULL ,
[LeftScore] int NOT NULL ,
[RightScore] int NOT NULL ,
[Odds] decimal(18,2) NOT NULL ,
[IsOddsAuto] bit NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for Limit
-- ----------------------------
DROP TABLE [dbo].[Limit]
GO
CREATE TABLE [dbo].[Limit] (
[Id] nvarchar(50) NOT NULL ,
[RoleId] nvarchar(50) NULL ,
[LimitName] varchar(30) NOT NULL ,
[LimitDetail] int NOT NULL DEFAULT ((0)) ,
[Type] int NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for LimitName
-- ----------------------------
DROP TABLE [dbo].[LimitName]
GO
CREATE TABLE [dbo].[LimitName] (
[Id] nvarchar(50) NOT NULL ,
[Name] varchar(50) NULL ,
[LimitDisplayName] nvarchar(50) NULL ,
[Type] int NULL ,
[Range] int NULL ,
[CreateDate] datetime NULL 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'LimitName', 
'COLUMN', N'Type')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'权限类型，1操作2参看3特殊'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LimitName'
, @level2type = 'COLUMN', @level2name = N'Type'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'权限类型，1操作2参看3特殊'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LimitName'
, @level2type = 'COLUMN', @level2name = N'Type'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'LimitName', 
'COLUMN', N'Range')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'权限包含哪些动作（位运算结果）'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LimitName'
, @level2type = 'COLUMN', @level2name = N'Range'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'权限包含哪些动作（位运算结果）'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LimitName'
, @level2type = 'COLUMN', @level2name = N'Range'
GO

-- ----------------------------
-- Table structure for LimitRole
-- ----------------------------
DROP TABLE [dbo].[LimitRole]
GO
CREATE TABLE [dbo].[LimitRole] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NULL ,
[IsDefault] bit NOT NULL DEFAULT ((0)) ,
[CreateDate] datetime NULL 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'LimitRole', 
'COLUMN', N'IsDefault')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'是否是系统默认的角色，系统默认的不可修改删除'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LimitRole'
, @level2type = 'COLUMN', @level2name = N'IsDefault'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'是否是系统默认的角色，系统默认的不可修改删除'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LimitRole'
, @level2type = 'COLUMN', @level2name = N'IsDefault'
GO

-- ----------------------------
-- Table structure for LimitRoleUserMap
-- ----------------------------
DROP TABLE [dbo].[LimitRoleUserMap]
GO
CREATE TABLE [dbo].[LimitRoleUserMap] (
[Id] nvarchar(50) NULL ,
[RoleId] nvarchar(50) NOT NULL ,
[UserId] nvarchar(50) NOT NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for LiveRoom
-- ----------------------------
DROP TABLE [dbo].[LiveRoom]
GO
CREATE TABLE [dbo].[LiveRoom] (
[Id] nvarchar(50) NOT NULL ,
[LiveTitle] nvarchar(200) NOT NULL ,
[AnchorId] nvarchar(50) NOT NULL ,
[State] nvarchar(50) NOT NULL ,
[GameId] nvarchar(50) NULL ,
[HeadUrl] nvarchar(1000) NULL ,
[VsOrderId] nvarchar(50) NULL ,
[VsGameLoopId] nvarchar(50) NULL ,
[CreateDate] datetime NOT NULL ,
[NotPushCount] int NULL DEFAULT ((0)) ,
[IsThirdparty] bit NOT NULL DEFAULT ((0)) ,
[IsVod] bit NULL DEFAULT ((0)) ,
[VodPlayUrl] nvarchar(255) NULL 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'LiveRoom', 
'COLUMN', N'LiveTitle')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'直播标题'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LiveRoom'
, @level2type = 'COLUMN', @level2name = N'LiveTitle'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'直播标题'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LiveRoom'
, @level2type = 'COLUMN', @level2name = N'LiveTitle'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'LiveRoom', 
'COLUMN', N'IsVod')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'是否是点播'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LiveRoom'
, @level2type = 'COLUMN', @level2name = N'IsVod'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'是否是点播'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LiveRoom'
, @level2type = 'COLUMN', @level2name = N'IsVod'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'LiveRoom', 
'COLUMN', N'VodPlayUrl')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'点播视频地址'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LiveRoom'
, @level2type = 'COLUMN', @level2name = N'VodPlayUrl'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'点播视频地址'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LiveRoom'
, @level2type = 'COLUMN', @level2name = N'VodPlayUrl'
GO

-- ----------------------------
-- Table structure for MobileValCode
-- ----------------------------
DROP TABLE [dbo].[MobileValCode]
GO
CREATE TABLE [dbo].[MobileValCode] (
[Id] nvarchar(50) NOT NULL ,
[Code] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for Msg
-- ----------------------------
DROP TABLE [dbo].[Msg]
GO
CREATE TABLE [dbo].[Msg] (
[Id] nvarchar(50) NOT NULL ,
[MasterType] nvarchar(50) NULL ,
[MasterId] nvarchar(50) NULL ,
[Title] nvarchar(200) NULL ,
[Content] nvarchar(2000) NULL ,
[Data] nvarchar(200) NULL ,
[SenderType] nvarchar(50) NULL ,
[SenderId] nvarchar(50) NULL ,
[ReceiverType] nvarchar(50) NULL ,
[ReceiverId] nvarchar(50) NULL ,
[IsRead] bit NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for MsgReg
-- ----------------------------
DROP TABLE [dbo].[MsgReg]
GO
CREATE TABLE [dbo].[MsgReg] (
[Id] nvarchar(50) NOT NULL ,
[RegId] nvarchar(500) NULL ,
[CreateDate] datetime NULL ,
[UpdateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for NationalFlag
-- ----------------------------
DROP TABLE [dbo].[NationalFlag]
GO
CREATE TABLE [dbo].[NationalFlag] (
[Id] nvarchar(100) NOT NULL ,
[Name] nvarchar(100) NOT NULL ,
[ImageUrl] nvarchar(200) NOT NULL 
)


GO

-- ----------------------------
-- Table structure for Note
-- ----------------------------
DROP TABLE [dbo].[Note]
GO
CREATE TABLE [dbo].[Note] (
[Id] nvarchar(50) NOT NULL ,
[NameOption] nvarchar(50) NULL ,
[MasterId] nvarchar(50) NULL ,
[MasterType] nvarchar(50) NULL ,
[IsShare] bit NULL ,
[Title] nvarchar(200) NULL ,
[Content] nvarchar(MAX) NULL ,
[Lat] float(53) NULL ,
[Lng] float(53) NULL ,
[Address] nvarchar(200) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL ,
[CourseId] nvarchar(50) NULL 
)


GO

-- ----------------------------
-- Table structure for NoteCreatorHide
-- ----------------------------
DROP TABLE [dbo].[NoteCreatorHide]
GO
CREATE TABLE [dbo].[NoteCreatorHide] (
[Id] nvarchar(50) NOT NULL ,
[WantHideUserId] nvarchar(50) NOT NULL ,
[HideCreatorId] nvarchar(50) NOT NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for NoteHide
-- ----------------------------
DROP TABLE [dbo].[NoteHide]
GO
CREATE TABLE [dbo].[NoteHide] (
[Id] nvarchar(50) NOT NULL ,
[WantHideUserId] nvarchar(50) NOT NULL ,
[HideNoteId] nvarchar(50) NOT NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for NoteReply
-- ----------------------------
DROP TABLE [dbo].[NoteReply]
GO
CREATE TABLE [dbo].[NoteReply] (
[Id] nvarchar(50) NOT NULL ,
[MasterType] nvarchar(50) NULL ,
[NoteId] nvarchar(50) NULL ,
[UserId] nvarchar(50) NULL ,
[Content] nvarchar(MAX) NULL ,
[CreateDate] datetime NULL ,
[Lat] float(53) NULL ,
[Lng] float(53) NULL ,
[Address] nvarchar(200) NULL ,
[Stars] int NULL ,
[ShareType] int NULL 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'NoteReply', 
'COLUMN', N'ShareType')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'共享类型：0私密 1公开 2教练可看'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'NoteReply'
, @level2type = 'COLUMN', @level2name = N'ShareType'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'共享类型：0私密 1公开 2教练可看'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'NoteReply'
, @level2type = 'COLUMN', @level2name = N'ShareType'
GO

-- ----------------------------
-- Table structure for NoteSupport
-- ----------------------------
DROP TABLE [dbo].[NoteSupport]
GO
CREATE TABLE [dbo].[NoteSupport] (
[Id] nvarchar(50) NOT NULL ,
[NoteId] nvarchar(50) NULL ,
[UserId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for OnlineUser
-- ----------------------------
DROP TABLE [dbo].[OnlineUser]
GO
CREATE TABLE [dbo].[OnlineUser] (
[Id] nvarchar(50) NOT NULL ,
[UserId] nvarchar(50) NULL ,
[Token] nvarchar(50) NULL ,
[DeviceType] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for Organization
-- ----------------------------
DROP TABLE [dbo].[Organization]
GO
CREATE TABLE [dbo].[Organization] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NOT NULL ,
[TypeId] varchar(50) NOT NULL ,
[ParentTypeId] varchar(50) NOT NULL ,
[IsDefault] bit NOT NULL DEFAULT ((0)) ,
[SonCounter] int NOT NULL DEFAULT ((0)) ,
[SonAmount] int NOT NULL DEFAULT ((0)) ,
[CreateDate] datetime NULL 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'Organization', 
'COLUMN', N'SonCounter')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'下级计数器，便于生成下级的TypeId'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Organization'
, @level2type = 'COLUMN', @level2name = N'SonCounter'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'下级计数器，便于生成下级的TypeId'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'Organization'
, @level2type = 'COLUMN', @level2name = N'SonCounter'
GO

-- ----------------------------
-- Table structure for QRCode
-- ----------------------------
DROP TABLE [dbo].[QRCode]
GO
CREATE TABLE [dbo].[QRCode] (
[Id] nvarchar(50) NOT NULL ,
[MasterId] nvarchar(50) NOT NULL DEFAULT '' ,
[ActionType] nvarchar(100) NOT NULL ,
[BusinessType] nvarchar(100) NOT NULL ,
[ScanCount] int NOT NULL ,
[ScanTime] datetime NOT NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for ScoreGrade
-- ----------------------------
DROP TABLE [dbo].[ScoreGrade]
GO
CREATE TABLE [dbo].[ScoreGrade] (
[Id] nvarchar(50) NOT NULL ,
[LeftScore] decimal(18,2) NOT NULL ,
[RightScore] decimal(18,2) NOT NULL ,
[GradeName] nvarchar(50) NOT NULL ,
[GradeIndex] int NOT NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for ScoreRange
-- ----------------------------
DROP TABLE [dbo].[ScoreRange]
GO
CREATE TABLE [dbo].[ScoreRange] (
[Id] nvarchar(50) NOT NULL ,
[BeginScore] int NULL ,
[EndScore] int NULL ,
[High] int NULL ,
[Low] int NULL 
)


GO

-- ----------------------------
-- Table structure for SerialNo
-- ----------------------------
DROP TABLE [dbo].[SerialNo]
GO
CREATE TABLE [dbo].[SerialNo] (
[Id] nvarchar(50) NOT NULL ,
[Prefix] nvarchar(50) NULL ,
[Today] nvarchar(50) NULL ,
[MaxValue] int NULL 
)


GO

-- ----------------------------
-- Table structure for SportType
-- ----------------------------
DROP TABLE [dbo].[SportType]
GO
CREATE TABLE [dbo].[SportType] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(50) NULL ,
[IsEnable] bit NULL ,
[IsEnableClub] bit NULL ,
[IsEnableGame] bit NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for SysDic
-- ----------------------------
DROP TABLE [dbo].[SysDic]
GO
CREATE TABLE [dbo].[SysDic] (
[Id] nvarchar(50) NULL ,
[Code] nvarchar(100) NOT NULL ,
[NameIndex] int NULL ,
[Name] nvarchar(100) NOT NULL ,
[Type] nvarchar(50) NULL ,
[SortIndex] int NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for SysLog
-- ----------------------------
DROP TABLE [dbo].[SysLog]
GO
CREATE TABLE [dbo].[SysLog] (
[Id] nvarchar(50) NOT NULL ,
[Title] nvarchar(200) NULL ,
[SourceId] nvarchar(50) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for TestInfo
-- ----------------------------
DROP TABLE [dbo].[TestInfo]
GO
CREATE TABLE [dbo].[TestInfo] (
[Id] nvarchar(50) NOT NULL ,
[Name] nvarchar(20) NULL ,
[Sex] nvarchar(50) NULL ,
[Comment] nvarchar(100) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for TrainActivity
-- ----------------------------
DROP TABLE [dbo].[TrainActivity]
GO
CREATE TABLE [dbo].[TrainActivity] (
[Id] nvarchar(50) NOT NULL ,
[Grade] nvarchar(50) NULL ,
[Student] nvarchar(20) NULL ,
[Contact] nvarchar(20) NULL ,
[CreateDate] datetime NULL 
)


GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'TrainActivity', 
'COLUMN', N'Grade')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'年级名称'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'TrainActivity'
, @level2type = 'COLUMN', @level2name = N'Grade'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'年级名称'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'TrainActivity'
, @level2type = 'COLUMN', @level2name = N'Grade'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'TrainActivity', 
'COLUMN', N'Student')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'学生姓名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'TrainActivity'
, @level2type = 'COLUMN', @level2name = N'Student'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'学生姓名'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'TrainActivity'
, @level2type = 'COLUMN', @level2name = N'Student'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'TrainActivity', 
'COLUMN', N'Contact')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'联系方式'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'TrainActivity'
, @level2type = 'COLUMN', @level2name = N'Contact'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'联系方式'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'TrainActivity'
, @level2type = 'COLUMN', @level2name = N'Contact'
GO

-- ----------------------------
-- Table structure for Transfer
-- ----------------------------
DROP TABLE [dbo].[Transfer]
GO
CREATE TABLE [dbo].[Transfer] (
[Id] nvarchar(50) NOT NULL ,
[MasterType] nvarchar(50) NULL ,
[MasterId] nvarchar(50) NULL ,
[TargetUserId] nvarchar(50) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for TVConfig
-- ----------------------------
DROP TABLE [dbo].[TVConfig]
GO
CREATE TABLE [dbo].[TVConfig] (
[Id] nvarchar(50) NOT NULL ,
[UserCode] nvarchar(50) NOT NULL ,
[TVCode] nvarchar(50) NOT NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for UserAccount
-- ----------------------------
DROP TABLE [dbo].[UserAccount]
GO
CREATE TABLE [dbo].[UserAccount] (
[Id] nvarchar(50) NOT NULL ,
[CityId] nvarchar(50) NULL ,
[Code] nvarchar(50) NULL ,
[Password] nvarchar(50) NULL ,
[PayPassword] nvarchar(50) NULL ,
[PayNoPwdAmount] int NULL ,
[CardId] nvarchar(50) NULL ,
[CardName] nvarchar(50) NULL ,
[AliPayId] nvarchar(200) NULL ,
[Sex] nvarchar(50) NULL ,
[QQ] nvarchar(50) NULL ,
[PetName] nvarchar(50) NULL ,
[Weixin] nvarchar(50) NULL ,
[CompanyId] nvarchar(50) NULL ,
[IsAdmin] bit NULL ,
[IsStop] bit NULL ,
[IsJudge] bit NULL ,
[Birthday] datetime NULL ,
[Mobile] nvarchar(50) NULL ,
[Address] nvarchar(50) NULL ,
[Lat] float(53) NULL ,
[Lng] float(53) NULL ,
[SignName] nvarchar(50) NULL ,
[HeadUrl] nvarchar(200) NULL ,
[Remark] nvarchar(MAX) NULL ,
[CreateDate] datetime NULL ,
[WeiXinUnionId] nvarchar(200) NULL DEFAULT '' ,
[QQOpenId] nvarchar(200) NULL DEFAULT '' ,
[OrganTypeId] varchar(50) NULL 
)


GO

-- ----------------------------
-- Table structure for UserFriend
-- ----------------------------
DROP TABLE [dbo].[UserFriend]
GO
CREATE TABLE [dbo].[UserFriend] (
[Id] nvarchar(50) NOT NULL ,
[UserId] nvarchar(50) NULL ,
[FriendId] nvarchar(50) NULL ,
[Remark] nvarchar(MAX) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for UserLimit
-- ----------------------------
DROP TABLE [dbo].[UserLimit]
GO
CREATE TABLE [dbo].[UserLimit] (
[Id] nvarchar(50) NOT NULL ,
[UserId] nvarchar(50) NULL ,
[IsClub] bit NULL ,
[IsVenue] bit NULL ,
[IsGame] bit NULL ,
[IsScoreGame] bit NULL ,
[IsActivity] bit NULL ,
[IsNote] bit NULL ,
[IsCompany] bit NULL ,
[CreateDate] datetime NULL ,
[IsTeachManage] bit NULL DEFAULT ((0)) 
)


GO

-- ----------------------------
-- Table structure for UserLimitRequest
-- ----------------------------
DROP TABLE [dbo].[UserLimitRequest]
GO
CREATE TABLE [dbo].[UserLimitRequest] (
[Id] nvarchar(50) NOT NULL ,
[UserId] nchar(10) NULL ,
[IsClub] bit NULL ,
[IsVenue] bit NULL ,
[IsGame] bit NULL ,
[IsActivity] bit NULL ,
[IsNote] bit NULL ,
[Remark] nvarchar(MAX) NULL ,
[CreateDate] datetime NULL ,
[IsProcessed] bit NULL 
)


GO

-- ----------------------------
-- Table structure for UserScoreHistory
-- ----------------------------
DROP TABLE [dbo].[UserScoreHistory]
GO
CREATE TABLE [dbo].[UserScoreHistory] (
[Id] nvarchar(50) NOT NULL ,
[UserId] nvarchar(50) NULL ,
[SportId] nvarchar(50) NULL ,
[GameId] nvarchar(50) NULL ,
[LoopId] nvarchar(50) NULL ,
[Score] int NULL ,
[CreateDate] datetime NULL ,
[MapId] nvarchar(50) NULL ,
[Editor] nvarchar(50) NULL ,
[IsEdit] bit NOT NULL DEFAULT ((0)) ,
[OldScore] int NULL 
)


GO

-- ----------------------------
-- Table structure for UserSign
-- ----------------------------
DROP TABLE [dbo].[UserSign]
GO
CREATE TABLE [dbo].[UserSign] (
[Id] nvarchar(50) NOT NULL ,
[MasterType] nvarchar(50) NULL ,
[MasterId] nvarchar(50) NULL ,
[Remark] nvarchar(MAX) NULL ,
[Lat] float(53) NULL ,
[Lng] float(53) NULL ,
[Address] nvarchar(200) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for UserSport
-- ----------------------------
DROP TABLE [dbo].[UserSport]
GO
CREATE TABLE [dbo].[UserSport] (
[Id] nvarchar(50) NOT NULL ,
[UserId] nvarchar(50) NULL ,
[SportId] nvarchar(50) NULL ,
[IsActive] bit NULL ,
[ProType] nvarchar(50) NULL ,
[GripOption] nvarchar(50) NULL ,
[Score] int NULL ,
[DefaultScore] int NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for Venue
-- ----------------------------
DROP TABLE [dbo].[Venue]
GO
CREATE TABLE [dbo].[Venue] (
[Id] nvarchar(50) NOT NULL ,
[SportId] nvarchar(50) NULL ,
[HeadUrl] nvarchar(200) NULL ,
[Name] nvarchar(200) NULL ,
[Introduce] nvarchar(1000) NULL ,
[CityId] nvarchar(50) NULL ,
[Address] nvarchar(200) NULL ,
[Lng] float(53) NULL ,
[Lat] float(53) NULL ,
[Mobile] nvarchar(50) NULL ,
[QQ] nvarchar(50) NULL ,
[WeiXin] nvarchar(50) NULL ,
[State] nvarchar(50) NULL ,
[IsUseVip] bit NULL ,
[CreditLine] float(53) NULL ,
[Used] float(53) NULL ,
[Balance] float(53) NULL ,
[AdminId] nvarchar(50) NULL ,
[AlipayId] nvarchar(100) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL ,
[TableCount] int NULL ,
[UnitPrice] decimal(4) NULL ,
[UnitType] nvarchar(10) NULL ,
[CourseManagerId] nvarchar(50) NULL ,
[IsEnableTeachingPoint] bit NULL DEFAULT ((0)) ,
[IsEnabled] bit NULL DEFAULT ((1)) 
)


GO

-- ----------------------------
-- Table structure for VenueDiscount
-- ----------------------------
DROP TABLE [dbo].[VenueDiscount]
GO
CREATE TABLE [dbo].[VenueDiscount] (
[Id] nvarchar(50) NOT NULL ,
[VenueId] nvarchar(50) NULL ,
[CostTypeId] nvarchar(50) NULL ,
[Discount] decimal(18,2) NULL ,
[BeginDate] datetime NULL ,
[EndDate] datetime NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for VenueSignInOut
-- ----------------------------
DROP TABLE [dbo].[VenueSignInOut]
GO
CREATE TABLE [dbo].[VenueSignInOut] (
[Id] nvarchar(50) NOT NULL ,
[VenueId] nvarchar(50) NOT NULL ,
[CoacherUserId] nvarchar(50) NOT NULL ,
[SignInTime] datetime NOT NULL ,
[SignOutTime] datetime NOT NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for VenueStudents
-- ----------------------------
DROP TABLE [dbo].[VenueStudents]
GO
CREATE TABLE [dbo].[VenueStudents] (
[Id] nvarchar(50) NOT NULL ,
[UserId] nvarchar(50) NULL ,
[VenueId] nvarchar(50) NULL ,
[IsCourseAutoBook] bit NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for VipAccount
-- ----------------------------
DROP TABLE [dbo].[VipAccount]
GO
CREATE TABLE [dbo].[VipAccount] (
[Id] nvarchar(50) NOT NULL ,
[Amount] decimal(18,2) NULL ,
[UsedAmount] decimal(18,2) NULL ,
[Balance] decimal(18,2) NULL ,
[Refund] decimal(18,2) NULL ,
[Score] decimal(18,2) NULL ,
[UsedScore] decimal(18,2) NULL ,
[BalanceScore] decimal(18,2) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for VipBill
-- ----------------------------
DROP TABLE [dbo].[VipBill]
GO
CREATE TABLE [dbo].[VipBill] (
[Id] nvarchar(50) NOT NULL ,
[Title] nvarchar(500) NULL ,
[CompanyId] nvarchar(50) NULL ,
[VenueId] nvarchar(50) NULL ,
[BeginDate] datetime NULL ,
[EndDate] datetime NULL ,
[Amount] decimal(18,2) NULL ,
[ConfirmerId] nvarchar(50) NULL ,
[ConfirmDate] datetime NULL ,
[Remark] nvarchar(500) NULL ,
[PayDate] datetime NULL ,
[PayRemark] nvarchar(500) NULL ,
[State] nvarchar(50) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for VipBillDetail
-- ----------------------------
DROP TABLE [dbo].[VipBillDetail]
GO
CREATE TABLE [dbo].[VipBillDetail] (
[Id] nvarchar(50) NOT NULL ,
[BillId] nvarchar(50) NULL ,
[CostTypeId] nvarchar(50) NULL ,
[Amount] numeric(18,2) NULL 
)


GO

-- ----------------------------
-- Table structure for VipBuy
-- ----------------------------
DROP TABLE [dbo].[VipBuy]
GO
CREATE TABLE [dbo].[VipBuy] (
[Id] nvarchar(50) NOT NULL ,
[OrderNo] nvarchar(50) NULL ,
[Amount] decimal(18,2) NULL ,
[GiveScale] decimal(18,2) NULL ,
[GiveAmount] decimal(18,2) NULL ,
[PayOption] nvarchar(50) NULL ,
[PayId] nvarchar(50) NULL ,
[PayState] nvarchar(50) NULL ,
[PayDate] datetime NULL ,
[PayDate1] date NULL ,
[PayRemark] nvarchar(500) NULL ,
[Remark] nvarchar(500) NULL ,
[UserId] nvarchar(50) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL ,
[CreateDate1] date NULL 
)


GO

-- ----------------------------
-- Table structure for VipCostScale
-- ----------------------------
DROP TABLE [dbo].[VipCostScale]
GO
CREATE TABLE [dbo].[VipCostScale] (
[Id] nvarchar(50) NOT NULL ,
[CompanyId] nvarchar(50) NULL ,
[CostTypeId] nvarchar(50) NULL ,
[CityId] nvarchar(50) NULL ,
[YdlScale] decimal(18,2) NULL ,
[CompanyScale] decimal(18,2) NULL ,
[VenueScale] decimal(18,2) NULL ,
[Remark] nvarchar(MAX) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL ,
[LastDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for VipRechargeScale
-- ----------------------------
DROP TABLE [dbo].[VipRechargeScale]
GO
CREATE TABLE [dbo].[VipRechargeScale] (
[Id] nvarchar(50) NOT NULL ,
[Min] int NULL ,
[Max] int NULL ,
[Scale] decimal(18,2) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL ,
[LastDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for VipRefund
-- ----------------------------
DROP TABLE [dbo].[VipRefund]
GO
CREATE TABLE [dbo].[VipRefund] (
[Id] nvarchar(50) NOT NULL ,
[OrderNo] nvarchar(50) NULL ,
[UserId] nvarchar(50) NULL ,
[AppliedAmount] decimal(18,2) NULL ,
[Amount] decimal(18,2) NULL ,
[Remark] nvarchar(MAX) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL ,
[State] nvarchar(50) NULL 
)


GO

-- ----------------------------
-- Table structure for VipUse
-- ----------------------------
DROP TABLE [dbo].[VipUse]
GO
CREATE TABLE [dbo].[VipUse] (
[Id] nvarchar(50) NOT NULL ,
[MasterType] nvarchar(50) NULL ,
[MasterId] nvarchar(50) NULL ,
[OrderNo] nvarchar(50) NULL ,
[CityId] nvarchar(50) NULL ,
[VenueId] nvarchar(50) NULL ,
[CostTypeId] nvarchar(50) NULL ,
[TotalAmount] decimal(18,2) NULL ,
[Discount] decimal(18,2) NULL ,
[Amount] decimal(18,2) NULL ,
[PayOption] nvarchar(50) NULL ,
[PayId] nvarchar(50) NULL ,
[PayState] nvarchar(50) NULL ,
[PayDate] datetime NULL ,
[PayDate1] date NULL ,
[PayRemark] nvarchar(500) NULL ,
[Remark] nvarchar(500) NULL ,
[IsOwnCreate] bit NULL ,
[UserId] nvarchar(50) NULL ,
[CreatorId] nvarchar(50) NULL ,
[CreateDate] datetime NULL ,
[CreateDate1] date NULL ,
[Lng] float(53) NULL ,
[Lat] float(53) NULL ,
[Address] nvarchar(500) NULL 
)


GO

-- ----------------------------
-- Table structure for WhistleBlowing
-- ----------------------------
DROP TABLE [dbo].[WhistleBlowing]
GO
CREATE TABLE [dbo].[WhistleBlowing] (
[Id] nvarchar(50) NOT NULL ,
[ContentId] nvarchar(50) NOT NULL ,
[WhistleBlowingType] nvarchar(50) NOT NULL ,
[Remark] nvarchar(500) NULL ,
[WhistleBlowingUserId] nvarchar(50) NOT NULL ,
[CreateDate] datetime NULL 
)


GO

-- ----------------------------
-- Table structure for YueDou
-- ----------------------------
DROP TABLE [dbo].[YueDou]
GO
CREATE TABLE [dbo].[YueDou] (
[Id] nvarchar(50) NULL ,
[UserId] nvarchar(50) NOT NULL ,
[Balance] int NOT NULL DEFAULT ((0)) ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Table structure for YueDouFlow
-- ----------------------------
DROP TABLE [dbo].[YueDouFlow]
GO
CREATE TABLE [dbo].[YueDouFlow] (
[Id] nvarchar(50) NOT NULL ,
[UserId] nvarchar(50) NOT NULL ,
[FlowType] nvarchar(100) NULL ,
[Amount] int NOT NULL DEFAULT ((0)) ,
[ServiceCharge] decimal(18,2) NULL ,
[GameId] nvarchar(50) NULL ,
[GuessBetType] nvarchar(50) NULL ,
[GuessId] nvarchar(50) NULL ,
[CreateDate] datetime NOT NULL 
)


GO

-- ----------------------------
-- Procedure structure for GenerateBootcampCourse
-- ----------------------------
DROP PROCEDURE [dbo].[GenerateBootcampCourse]
GO
 
CREATE PROCEDURE [dbo].[GenerateBootcampCourse] 
	@CoachBootcampId NVARCHAR(50),
	@BeginTime NVARCHAR(90),
	@EndTime NVARCHAR(90),
	@CourseContent NVARCHAR(MAX)
AS
    BEGIN
        SET NOCOUNT ON;
 
        DECLARE @sql NVARCHAR(MAX)
		
		DECLARE @dayDiff INT,@i INT;
		SET @dayDiff = DATEDIFF ( day ,@BeginTime ,@EndTime) ;     
		SET @i=0;
		DECLARE @day DATETIME
		SET @day=CONVERT(DATETIME,@BeginTime,120)
		WHILE @i <= @dayDiff
			BEGIN
				INSERT INTO [dbo].[CoachBootcampCourse]
						   ([Id]
						   ,[CoachBootcampId]
						   ,[BeginTime]
						   ,[EndTime]
						   ,[CourseContent]
						   ,[CreateDate])
					 VALUES
						   (REPLACE(NEWID(),'-','') ,
						   @CoachBootcampId,
						   convert(char(10),@day,120)+' 10:30:00', 
						   convert(char(10),@day,120)+' 11:30:00', 
						   @CourseContent,
						  GETDATE()
						  )
 
				 INSERT INTO [dbo].[CoachBootcampCourse]
						   ([Id]
						   ,[CoachBootcampId]
						   ,[BeginTime]
						   ,[EndTime]
						   ,[CourseContent]
						   ,[CreateDate])
					 VALUES
						   (REPLACE(NEWID(),'-','') ,
						   @CoachBootcampId,
						   convert(char(10),@day,120)+' 14:30:00', 
						   convert(char(10),@day,120)+' 15:30:00', 
						   @CourseContent,
						  GETDATE()
						  )
 
				INSERT INTO [dbo].[CoachBootcampCourse]
						   ([Id]
						   ,[CoachBootcampId]
						   ,[BeginTime]
						   ,[EndTime]
						   ,[CourseContent]
						   ,[CreateDate])
					 VALUES
						   (REPLACE(NEWID(),'-','') ,
						   @CoachBootcampId,
						   convert(char(10),@day,120)+' 15:30:00', 
						   convert(char(10),@day,120)+' 16:30:00', 
						   @CourseContent,
						  GETDATE()
						  )
				INSERT INTO [dbo].[CoachBootcampCourse]
						   ([Id]
						   ,[CoachBootcampId]
						   ,[BeginTime]
						   ,[EndTime]
						   ,[CourseContent]
						   ,[CreateDate])
					 VALUES
						   (REPLACE(NEWID(),'-','') ,
						   @CoachBootcampId,
						   convert(char(10),@day,120)+' 19:00:00', 
						   convert(char(10),@day,120)+' 20:00:00', 
						   @CourseContent,
						  GETDATE()
						  )
				
			
				SET @i = @i + 1;
				SET @day=DATEADD(DAY,1,@day)
			END;



			 



 
		
    END

GO

-- ----------------------------
-- Procedure structure for GetAppIncomeStatisticsList
-- ----------------------------
DROP PROCEDURE [dbo].[GetAppIncomeStatisticsList]
GO
 
CREATE PROCEDURE [dbo].[GetAppIncomeStatisticsList] 
	@BeginTime NVARCHAR(50),
	@EndTime NVARCHAR(50),
	@PayOption NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@PayOption, '') != ''
            SET @filter = @filter + ' AND a.PayOption = @PayOption'
		IF ISNULL(@BeginTime, '') != '' AND ISNULL(@EndTime, '') != ''
            SET @filter = @filter + ' AND a.CreateDate >= @BeginTime AND a.CreateDate <= @EndTime '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT @rowCount=COUNT(*) FROM(   
							SELECT  
								a.CreateDate,
								a.PayOption
							FROM dbo.VipBuy a
							INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
							WHERE PayState=''024002''   
							UNION ALL
							SELECT  
								a.CreateDate,
								a.PayOption
							FROM dbo.VipUse a
							INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
							WHERE PayState=''024002''  AND (a.PayOption=''023002'' OR a.PayOption=''023004'')
					 ) a
					 WHERE  1=1
					 ' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@BeginTime NVARCHAR(50),@EndTime NVARCHAR(50),@PayOption NVARCHAR(50),@rowCount INT OUTPUT',
                    @BeginTime,@EndTime,@PayOption, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
				SELECT * FROM(   
						SELECT  
								a.OrderNo,
								a.CreateDate,
								a.Amount ,
								CardName=dbo.fn_GetUserName(a.UserId),
								a.PayOption,
								a.PayState,
								a.Remark
						FROM dbo.VipBuy a
						INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
						WHERE PayState=''024002''   
						UNION ALL
						SELECT  
								a.OrderNo,
								a.CreateDate,
								a.Amount ,
								CardName=dbo.fn_GetUserName(a.UserId),
								a.PayOption,
								a.PayState,
								a.Remark
						FROM dbo.VipUse a
						INNER JOIN dbo.UserAccount b ON a.UserId=b.Id
						WHERE PayState=''024002''  AND (a.PayOption=''023002'' OR a.PayOption=''023004'')
					) a
					WHERE  1=1 '+@filter+'
					ORDER BY a.CreateDate DESC
					OFFSET (@pageIndex-1)*@pageSize ROWS
					FETCH NEXT @pageSize ROWS ONLY
				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@BeginTime NVARCHAR(50),@EndTime NVARCHAR(50),@PayOption NVARCHAR(50), @pageIndex INT,@pageSize INT',
             @BeginTime,@EndTime,@PayOption,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for GetBootcampHaveBeenCourseList
-- ----------------------------
DROP PROCEDURE [dbo].[GetBootcampHaveBeenCourseList]
GO
 
CREATE PROCEDURE [dbo].[GetBootcampHaveBeenCourseList] 
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
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
					SELECT 
						@rowCount=COUNT(a.Id) 
					FROM dbo.CoachCourse a 
					INNER JOIN dbo.CoachCoursePersonInfo b ON a.Id=b.CourseId
					LEFT JOIN dbo.CoachComment c ON c.CourseId=a.Id AND c.CommentatorId=b.YdlUserId
					WHERE 
						b.YdlUserId=@StudentId
						AND a.Type=''027005'' AND a.State=''Finished''
					' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@StudentId NVARCHAR(50),@rowCount INT OUTPUT',
                    @StudentId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
				SELECT 
					a.*,
					c.Score,
					d.Address AS VenueAddress 
				FROM dbo.CoachCourse a 
				INNER JOIN dbo.CoachCoursePersonInfo b ON a.Id=b.CourseId
				LEFT JOIN dbo.CoachComment c ON c.CourseId=a.Id AND c.CommentatorId=b.YdlUserId
				LEFT JOIN dbo.Venue d ON a.VenueId =d.Id
				WHERE 
					b.YdlUserId=@StudentId
					AND a.Type=''027005'' AND a.State=''Finished''
				'+@filter+'
				ORDER BY a.CreateDate DESC 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@StudentId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @StudentId,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for GetCoachLeaveAuditList
-- ----------------------------
DROP PROCEDURE [dbo].[GetCoachLeaveAuditList]
GO
 
CREATE PROCEDURE [dbo].[GetCoachLeaveAuditList] 
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

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(
									*
								) 
						FROM dbo.CoachLeave
						WHERE State=@State 
				' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@State NVARCHAR(50),@rowCount INT OUTPUT',
                    @State,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
				SELECT 
					a.*,
					b.HeadUrl,
					b.Sex,
					b.Code AS CoachCode,
					dbo.fn_GetUserName(b.Id) AS CoachName
				FROM dbo.CoachLeave a
				INNER JOIN dbo.UserAccount b ON a.CoachId=b.Id
				WHERE a.State=@State
			 '+@filter+'
				ORDER BY CreateDate DESC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@State NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @State ,@pageIndex, @pageSize
		
		
    END

GO

-- ----------------------------
-- Procedure structure for GetCoachLeaveList
-- ----------------------------
DROP PROCEDURE [dbo].[GetCoachLeaveList]
GO
 
CREATE PROCEDURE [dbo].[GetCoachLeaveList] 
	@CoachId NVARCHAR(50),
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
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(
									*
								) 
						FROM dbo.CoachLeave
						WHERE CoachId=@CoachId 
				' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@CoachId NVARCHAR(50),@rowCount INT OUTPUT',
                    @CoachId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
				SELECT 
					a.*,
					b.Name AS LeaveTypeName
				FROM dbo.CoachLeave a
				LEFT JOIN dbo.SysDic b ON a.LeaveType=b.Code
				WHERE a.CoachId=@CoachId '+@filter+'
				ORDER BY CreateDate DESC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@CoachId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @CoachId ,@pageIndex, @pageSize
		
		
    END

GO

-- ----------------------------
-- Procedure structure for GetCoachStudentList
-- ----------------------------
DROP PROCEDURE [dbo].[GetCoachStudentList]
GO
 
CREATE PROCEDURE [dbo].[GetCoachStudentList] 
	@CoachId NVARCHAR(50),
	@Name NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		--普通filter
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@Name, '') != ''
            SET @filter = @filter + ' AND dbo.fn_GetUserName(a.Id) LIKE ''%' +@Name + '%'''
		--过滤学员filter
		DECLARE @studentFilter NVARCHAR(max)
		SET @studentFilter = ''
		IF	 ISNULL(@CoachId, '') != ''
			    SET @studentFilter = @studentFilter + '  AND a.CoachId=@CoachId  '

        DECLARE @sql NVARCHAR(MAX)
		DECLARE @JoinSql NVARCHAR(MAX)
		SET @JoinSql=''
		SET @JoinSql='
				--私教学员id
					SELECT
						DISTINCT 
						a.StudentUserId 
					FROM dbo.CoachStudentMoney a
					WHERE 1=1
					'
					+@studentFilter+
					'
					UNION
					--大课学员id
					SELECT 
						DISTINCT
						a.ReservedPersonId AS StudentUserId
					 FROM dbo.CoachCourse a
					 WHERE Type=''027001''
						 '+@studentFilter+
						 '
					UNION
					-- 集训课学员id
				     SELECT 
						DISTINCT
						b.YdlUserId AS StudentUserId
					 FROM dbo.CoachCourse a
					 LEFT JOIN dbo.CoachCoursePersonInfo b ON a.Id=b.CourseId
					 WHERE a.Type=''027005''
								 
					'+@studentFilter 

		SET @sql=''
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
SELECT	
	@rowCount=COUNT(b.StudentUserId) 	
 FROM dbo.UserAccount a
 INNER JOIN('
 + @JoinSql+
 '
) b ON a.Id=b.StudentUserId
WHERE 1=1
					' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@CoachId NVARCHAR(50),@rowCount INT OUTPUT',
                    @CoachId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
			  SELECT	
					b.StudentUserId
				 FROM dbo.UserAccount a
				 INNER JOIN(
					'
				 + @JoinSql+
				 '
				) b ON a.Id=b.StudentUserId
				WHERE 1=1
				'+@filter+'
				ORDER BY 1
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@CoachId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @CoachId,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for GetCourseList
-- ----------------------------
DROP PROCEDURE [dbo].[GetCourseList]
GO
 
CREATE PROCEDURE [dbo].[GetCourseList] 
	@ReservedPersonId NVARCHAR(50),
	@CourseType NVARCHAR(50),
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
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
					SELECT 
						@rowCount=COUNT(a.Id) 
					FROM dbo.CoachCourse a
					WHERE a.ReservedPersonId=@ReservedPersonId
						AND a.Type=@CourseType AND a.State=''Finished''
					' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@ReservedPersonId NVARCHAR(50),@CourseType NVARCHAR(100),@rowCount INT OUTPUT',
                    @ReservedPersonId,@CourseType,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
				SELECT 
					a.*,
					b.Score,
					c.Address AS VenueAddress 
				FROM dbo.CoachCourse a
				LEFT JOIN dbo.CoachComment b ON a.Id=b.CourseId
				LEFT JOIN dbo.Venue c ON a.VenueId =c.Id
				WHERE a.ReservedPersonId=@ReservedPersonId
					AND a.Type=@CourseType AND a.State=''Finished''
				'+@filter+'
				ORDER BY a.CreateDate DESC 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@ReservedPersonId NVARCHAR(50),@CourseType NVARCHAR(100),@pageIndex INT,@pageSize INT',
             @ReservedPersonId,@CourseType,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for GetGuessBetList
-- ----------------------------
DROP PROCEDURE [dbo].[GetGuessBetList]
GO
 
CREATE PROCEDURE [dbo].[GetGuessBetList] 
	@UserId NVARCHAR(50),
	@GameId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@GameId, '') != ''
			SET @filter = @filter + ' AND c.GameId = @GameId '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(a.Id)
						 FROM dbo.GuessBet a
						 LEFT JOIN dbo.Guess b ON a.GuessId=b.Id
						 LEFT JOIN dbo.GameLoop c ON b.VsGameLoopId=c.Id
						 WHERE a.UserId=@UserId   ' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@GameId NVARCHAR(50),@UserId NVARCHAR(50),@rowCount INT OUTPUT',
                    @GameId,@UserId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
				 SELECT
							a.*
				FROM dbo.GuessBet a
				LEFT JOIN dbo.Guess b ON a.GuessId=b.Id
				LEFT JOIN dbo.GameLoop c ON b.VsGameLoopId=c.Id
				WHERE a.UserId=@UserId  '+@filter+'
				ORDER BY a.Createdate DESC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@GameId NVARCHAR(50),@UserId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @GameId,@UserId,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for GetGuessList
-- ----------------------------
DROP PROCEDURE [dbo].[GetGuessList]
GO
 
CREATE PROCEDURE [dbo].[GetGuessList] 
	@GuessName NVARCHAR(200),
	@CreatorId NVARCHAR(50),
	@State NVARCHAR(50),
	@CurrentTime DATETIME,
	@GameId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@GuessName, '') != ''
            SET @filter = @filter + ' AND a.GuessName LIKE ''%'+ @GuessName+'%'''
        IF ISNULL(@CreatorId, '') != ''
			SET @filter = @filter + ' AND a.CreatorId= @CreatorId '
        IF ISNULL(@State, '') = 'Processing'
			SET @filter = @filter + ' AND @CurrentTime BETWEEN a.BeginTime AND a.EndTime '
        IF ISNULL(@State, '') = 'Finished'
			SET @filter = @filter + ' AND @CurrentTime > a.EndTime AND a.State != ''AlreadySettlement''  '
		IF ISNULL(@State, '') = 'AlreadySettlement'
			SET @filter = @filter + ' AND a.State = ''AlreadySettlement'' '
		IF ISNULL(@GameId, '') !=''
			SET @filter = @filter + ' AND b.GameId =@GameId '
        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(*)
						FROM dbo.Guess a 
						INNER JOIN dbo.GameLoop b ON a.VsGameLoopId=b.Id
						WHERE 1=1 
						' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@GuessName NVARCHAR(200),@CreatorId NVARCHAR(50) ,@State NVARCHAR(50)
					,@CurrentTime DATETIME,@GameId  NVARCHAR(50)
					,@rowCount INT OUTPUT',
                    @GuessName,@CreatorId,@State
					,@CurrentTime,@GameId
					,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
				 SELECT 
					a.*,
					CreatorName=dbo.fn_GetUserName(a.CreatorId) 
				 FROM dbo.Guess a
				 INNER JOIN dbo.GameLoop b ON a.VsGameLoopId=b.Id
				 WHERE 1=1
				'+@filter+'
				ORDER BY a.CreateDate DESC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)
            EXEC SP_EXECUTESQL @sql,
                N'@GuessName NVARCHAR(200),@CreatorId NVARCHAR(50) ,@State NVARCHAR(50)
				,@CurrentTime DATETIME,@GameId  NVARCHAR(50)
				,@pageIndex INT,@pageSize INT',
                @GuessName,@CreatorId,@State,@CurrentTime,@GameId 
				,@pageIndex, @pageSize
		
		
    END

GO

-- ----------------------------
-- Procedure structure for GetMyGuessList
-- ----------------------------
DROP PROCEDURE [dbo].[GetMyGuessList]
GO
 
CREATE PROCEDURE [dbo].[GetMyGuessList] 
	@UserId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        --IF ISNULL(@GuessName, '') != ''
        --    SET @filter = @filter + ' AND a.GuessName LIKE ''%'+ @GuessName+'%'''
        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(*) 
						FROM 
						(
							 SELECT 
								a.Id
							 FROM dbo.Guess a
							 WHERE a.CreatorId=@UserId
							 UNION ALL
							 SELECT 
									DISTINCT
									a.Id
							 FROM dbo.GuessBet a
							 WHERE a.UserId=@UserId
						 ) a
						' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N' 
					@UserId  NVARCHAR(50)
					,@rowCount INT OUTPUT',
                    @UserId 
					,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
					SELECT 
						b.*,
						CreatorName=dbo.fn_GetUserName(b.CreatorId) 
					FROM 
					(
						 SELECT 
							a.Id
						 FROM dbo.Guess a
						 WHERE a.CreatorId=@UserId
						 UNION 
						 SELECT 
								DISTINCT
								a.GuessId
						 FROM dbo.GuessBet a
						 WHERE a.UserId=@UserId
					 ) a
					 INNER JOIN dbo.Guess b ON a.Id=b.Id
					 INNER JOIN dbo.GameLoop c ON b.VsGameLoopId=c.Id
					 WHERE 1=1
					'+@filter+'
					ORDER BY b.CreateDate DESC
					OFFSET (@pageIndex-1)*@pageSize ROWS
					FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)
            EXEC SP_EXECUTESQL @sql,
                N'@UserId  NVARCHAR(50)
				,@pageIndex INT,@pageSize INT',
                 @UserId
				,@pageIndex, @pageSize
		
		
    END

GO

-- ----------------------------
-- Procedure structure for GetNationalFlagList
-- ----------------------------
DROP PROCEDURE [dbo].[GetNationalFlagList]
GO
 
CREATE PROCEDURE [dbo].[GetNationalFlagList] 
	@NationalName NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@NationalName, '') != ''
          SET @filter = @filter + ' AND Name = @NationalName '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(
									Id 
								) 
						FROM dbo.NationalFlag  
						WHERE	1=1 
						' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@NationalName NVARCHAR(50),@rowCount INT OUTPUT',
                    @NationalName,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
				SELECT 
					*
				FROM dbo.NationalFlag 
				WHERE	1=1 
				 '+@filter+'
				ORDER BY Name
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'
		--PRINT (@sql)
        EXEC SP_EXECUTESQL @sql,
            N'@NationalName NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @NationalName ,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for GetStudentCourseRemarkList
-- ----------------------------
DROP PROCEDURE [dbo].[GetStudentCourseRemarkList]
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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
				 LEFT JOIN dbo.UserAccount b ON a.CoachId=b.Id
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

-- ----------------------------
-- Procedure structure for GetStudentJoinCourseList
-- ----------------------------
DROP PROCEDURE [dbo].[GetStudentJoinCourseList]
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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
				 LEFT JOIN dbo.UserAccount b ON a.CoachId=b.Id
				 LEFT JOIN dbo.CoachCourse e ON a.CourseId=e.Id
				 LEFT JOIN dbo.BaseData c ON e.Type=c.Id 
				 LEFT JOIN dbo.Venue d ON e.VenueId=d.Id
				 LEFT JOIN dbo.CoachStudentRemark f ON a.StudentId=f.StudentId AND a.CourseId=f.CourseId
				 WHERE a.StudentId = @StudentId
				'+@filter+'
				ORDER BY e.EndTime DESC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@StudentId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @StudentId ,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for GetYueDouFlowList
-- ----------------------------
DROP PROCEDURE [dbo].[GetYueDouFlowList]
GO
 
CREATE PROCEDURE [dbo].[GetYueDouFlowList] 
	@UserId NVARCHAR(50),
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
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(*)
						 FROM dbo.YueDouFlow 
						 WHERE UserId=@UserId   ' +@filter

                EXEC SP_EXECUTESQL @sql,
                    N'@UserId NVARCHAR(50),@rowCount INT OUTPUT',
                    @UserId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
				 SELECT 
							*
				FROM dbo.YueDouFlow 
				WHERE UserId=@UserId  '+@filter+'
				ORDER BY Createdate DESC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@UserId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @UserId,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for GP_InsertAccountBatch
-- ----------------------------
DROP PROCEDURE [dbo].[GP_InsertAccountBatch]
GO
CREATE PROCEDURE [dbo].[GP_InsertAccountBatch] 
	@names nvarchar(4000)
AS
BEGIN
	SET NOCOUNT ON;
declare @insertname NVARCHAR(50)
declare @err   int
declare @sql varchar(200)
  
create table #process(username NVARCHAR(50) not null)
insert into #process   SELECT * FROM  [dbo].[fn_Split](@names)
 

declare cursortable cursor    for select username from #process 
open cursortable
	fetch next from cursortable into @insertname
		
while @@FETCH_STATUS=0
begin
   
	
	IF	ISNULL(@insertname,'') !=''
	BEGIN
		--PRINT @insertname
	 
		IF NOT EXISTS(SELECT * FROM dbo.UserAccount WHERE PetName=@insertname )
		BEGIN
			DECLARE @id nvarchar(50),@p11 nvarchar(50),@p15 nvarchar(50),@name  nvarchar(50)
			SET @name=@insertname
			SET @id=NEWID()
			exec sp_SaveQuickUser @userId=@id,@sex=N'1',
			@petName=@name,@cardName=@name
			,@mobile=N''
			,@cityId=N'75',@password=N'e10adc3949ba59abbe56e057f20f883e'
			,@headUrl=NULL,@lat=0,@lng=0
			,@userCode=@p11 output,@address=NULL,@WeiXinUnionId=N''
			,@QQOpenId=NULL,
			 @message=@p15 OUTPUT
         END

	END 
	fetch next from cursortable
		into @insertname
end
close cursortable
deallocate cursortable
drop table #process

END

GO

-- ----------------------------
-- Procedure structure for sp_AuditClubRequest
-- ----------------------------
DROP PROCEDURE [dbo].[sp_AuditClubRequest]
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

		--查找未审核的入群申请
        SELECT  @userId = CreatorId ,
                @clubId = ClubId
        FROM    dbo.ClubRequest
        WHERE   Id = @requestId
                AND State = '003001'

        IF ISNULL(@userId, '') != ''
            BEGIN

				--更新申请状态,审核人
                UPDATE  dbo.ClubRequest
                SET     State = @state ,
                        AuditorId = @auditorId
                WHERE   Id = @requestId
                        AND State = '003001'

				--如果审核通过，则尝试加入群员
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
            SET @message = '其他管理员已处理。'
    END

GO

-- ----------------------------
-- Procedure structure for sp_AutoCreateCourseBook
-- ----------------------------
DROP PROCEDURE [dbo].[sp_AutoCreateCourseBook]
GO
CREATE PROCEDURE [dbo].[sp_AutoCreateCourseBook]
	@userId	NVARCHAR(50),
	@venueId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

		--指定学员在指定场馆是否设置了自动预约
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

-- ----------------------------
-- Procedure structure for sp_AutoCreateCourseBookByMonth
-- ----------------------------
DROP PROCEDURE [dbo].[sp_AutoCreateCourseBookByMonth]
GO
CREATE PROCEDURE [dbo].[sp_AutoCreateCourseBookByMonth]
	@payId	NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

		DECLARE @now DATETIME
		SET @now = GETDATE()

		--设置每周第一天是周一(默认是周日)
		SET DATEFIRST 1

		--相关主要参数
		DECLARE @userId NVARCHAR(50),@venueId NVARCHAR(50),@balanceId NVARCHAR(50),@balance INT,@month INT,@year INT
		SELECT @userId=b.UserId,@venueId=b.VenueId,@balanceId=a.BalanceId,@balance=b.Balance,@year=b.[Year],@month=b.[Month] 
		FROM CoachStudentPay a INNER JOIN CoachStudentBalance b ON b.Id=a.BalanceId WHERE a.Id=@payId


		DECLARE @tempTab TABLE(BeginTime DATETIME,EndTime DATETIME,TimeTableId NVARCHAR(50))
		DECLARE @i INT
		DECLARE @monthFirstDay DATETIME,@beginTime DATETIME,@endTime DATETIME,@timeTableId NVARCHAR(50)

		--此月第一天
		SET @monthFirstDay = CONVERT(VARCHAR,@year)+ '-'+CONVERT(VARCHAR,@month)+'-01'

		--此月中前7天的数据插入临时表
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

		--循环5次，排除少量次月数据
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
				--检查此时间点是否已经预约过
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

-- ----------------------------
-- Procedure structure for sp_AutoCreateTestGameTeam
-- ----------------------------
DROP PROCEDURE [dbo].[sp_AutoCreateTestGameTeam]
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

		--删除原来参赛者
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

                            SET @name2 = CASE WHEN @nameOption = '020001' THEN 'admin' ELSE '管理员' END  + CAST(@i AS NVARCHAR(2))
                            SET @name3 = CASE WHEN @nameOption = '020001' THEN 'admin' ELSE '管理员' END + CAST(@i + 1 AS NVARCHAR(2))


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
                                      @name + '队伍' , -- TeamName - nvarchar(500)
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

-- ----------------------------
-- Procedure structure for sp_CancelCourseAutoBook
-- ----------------------------
DROP PROCEDURE [dbo].[sp_CancelCourseAutoBook]
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

-- ----------------------------
-- Procedure structure for sp_CancelVenueBill
-- ----------------------------
DROP PROCEDURE [dbo].[sp_CancelVenueBill]
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
                SET @message = '请设置单据号码.'
                RETURN
            END

        DECLARE @state NVARCHAR(50)
        SELECT  @state = State
        FROM    dbo.VenueBill
        WHERE   Id = @id
        IF @state IS NULL
            BEGIN
                SET @message = '单据不存在，可能已被删除.'
                RETURN
            END
        ELSE
            IF @state = '026001'
                DELETE  FROM dbo.VenueBill
                WHERE   Id = @id
            ELSE
                BEGIN
                    SET @message = '单据已确认，无法取消.'
                    RETURN
                END
    END

GO

-- ----------------------------
-- Procedure structure for sp_CancelVipRefund
-- ----------------------------
DROP PROCEDURE [dbo].[sp_CancelVipRefund]
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
            SET @message = '单据在处理中，无法取消，请刷新状态。'

    END

GO

-- ----------------------------
-- Procedure structure for sp_CancelVipUse
-- ----------------------------
DROP PROCEDURE [dbo].[sp_CancelVipUse]
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
            SET @message = '单据已支付，不能取消。';
    END

GO

-- ----------------------------
-- Procedure structure for sp_CheckGameGroupState
-- ----------------------------
DROP PROCEDURE [dbo].[sp_CheckGameGroupState]
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

		    --验证小组赛是否结束--
            SET @message = '';
            IF EXISTS ( SELECT  *
                        FROM    dbo.GameGroupMember
                        WHERE   GameId = @gameId
                                AND Rank = 0 )
                RAISERROR (N'还存在小组未计算排名，无法抽签。',11,1)

			--验证是否已经抽签--
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
                    RAISERROR (N'已经完成了淘汰赛抽签，不能重复操作。',11,1)
                ELSE
                    RAISERROR (N'已经完成了本组淘汰赛抽签，不能重复操作。',11,1)
        END TRY

        BEGIN CATCH
            SET @message = ERROR_MESSAGE() 
        END CATCH 
    END

GO

-- ----------------------------
-- Procedure structure for sp_CheckGameSign
-- ----------------------------
DROP PROCEDURE [dbo].[sp_CheckGameSign]
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

-- ----------------------------
-- Procedure structure for sp_CoachAuditPass
-- ----------------------------
DROP PROCEDURE [dbo].[sp_CoachAuditPass]
GO
--教练审核通过
CREATE PROCEDURE [dbo].[sp_CoachAuditPass]
	@Id NVARCHAR(50) --教练Id
AS
    BEGIN
        SET NOCOUNT ON;
		--不存在就 添加(首次审核的情况)  ----------开始
		IF	(NOT EXISTS(SELECT * FROM Coach WHERE Id=@Id))
		BEGIN
			--将申请信息提取到正式教练表	
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
		--不存在就 添加  ----------结束
		ELSE	
		--存在就 更新(反复审核的情况) ----------开始
		BEGIN	
			--更新正式表 (用b表的一条记录更新a表)
		
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
		--存在就 更新 ----------结束
		------------公共操作 ------------------
		--更新个人信息表 UserAccount
		UPDATE c
		SET 
			c.CardName=d.Name,
			c.Mobile=d.Mobile,
			c.CardId=d.CardId,
			c.HeadUrl=d.HeadUrl 
		FROM  dbo.UserAccount c
		INNER JOIN dbo.CoachApply d ON c.Id=d.Id  
		WHERE c.Id=@Id
		--将教练申请时的FileInfo信息, 重定向到正式教练上  -----开始
		--先删除以前的正式文件信息
		DELETE FROM dbo.FileInfo  WHERE MasterType='CoachFormal' AND MasterId=@Id
		--再将申请的文件信息 修改成正式的文件信息
		UPDATE dbo.FileInfo SET MasterType='CoachFormal' WHERE MasterType='CoachApply' AND MasterId=@Id
		--将教练申请时的FileInfo信息, 重定向到正式教练上  -----结束

		--删除申请信息
		DELETE FROM CoachApply WHERE Id=@Id;

    END



GO

-- ----------------------------
-- Procedure structure for sp_CreateVipVenueBill
-- ----------------------------
DROP PROCEDURE [dbo].[sp_CreateVipVenueBill]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- 按支付日期时间段，生成场馆结算账单
-- =============================================
CREATE PROCEDURE [dbo].[sp_CreateVipVenueBill]
    @cityId NVARCHAR(50) ,--可选条件
    @venueId NVARCHAR(50) ,--可选条件
	@userId NVARCHAR(50) ,
    @beginDate DATETIME ,
    @endDate DATETIME
AS
    BEGIN
        DECLARE @tempVenueId NVARCHAR(50)

		--查找符合条件的场馆
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
				--验证是否生成过，如果已支付，则跳过；未支付则更改金额；未生成则生成
                DECLARE @payState NVARCHAR(50) 
                DECLARE @id NVARCHAR(50)

				--获取已结算最大日期
                DECLARE @maxDate DATETIME
                SELECT  @maxDate = MAX(EndDate)
                FROM    dbo.VenueBill
                WHERE   VenueId = @tempVenueId

				--生成未结算的记录
                IF @maxDate IS  NULL
                    OR CONVERT(NVARCHAR(10), @beginDate, 120) > CONVERT(NVARCHAR(10), @maxDate, 120)
                    BEGIN
						--统计已支付金额
                        DECLARE @amount FLOAT
                        DECLARE @discount FLOAT

                        SELECT  @amount = SUM(Amount)
                        FROM    dbo.VipUse
                        WHERE   VenueId = @tempVenueId
                                AND PayState = '024002'--已支付
                                AND CONVERT(NVARCHAR(10), PayDate, 120) BETWEEN CONVERT(NVARCHAR(10), @beginDate, 120) AND CONVERT(NVARCHAR(10), @endDate, 120)

						--查找结算折扣
                        SELECT  @discount = Discount
                        FROM    dbo.VipInnerDiscount
                        WHERE   VenueId = @tempVenueId

						--计算折扣后金额
                        IF @discount IS NOT NULL
                            SET @amount = @amount * @discount

                        DECLARE @orderNo NVARCHAR(50)
                        EXEC dbo.sp_GetSerialNo1 N'VenueBill', @orderNo OUTPUT
							

						--生成账单
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
                                  N'024001' , -- 未支付 PayState - nvarchar(50)
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

-- ----------------------------
-- Procedure structure for sp_DeleteGameAllDetail
-- ----------------------------
DROP PROCEDURE [dbo].[sp_DeleteGameAllDetail]
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
	--删除分组信息
	DELETE FROM GameGroup WHERE GameId=@gameId 
	DELETE FROM GameGroupMember WHERE GameId=@gameId 

	--删除其他信息
	DELETE FROM dbo.GameLoopMap WHERE LoopId IN (SELECT Id FROM dbo.GameLoop WHERE GameId=@gameId)
	DELETE FROM dbo.GameLoopDetail WHERE LoopId IN (SELECT Id FROM dbo.GameLoop WHERE GameId=@gameId)
	DELETE FROM GameLoop WHERE GameId=@gameId 
	DELETE FROM GameOrder WHERE GameId=@gameId

END

GO

-- ----------------------------
-- Procedure structure for sp_DeleteGameGroup
-- ----------------------------
DROP PROCEDURE [dbo].[sp_DeleteGameGroup]
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

-- ----------------------------
-- Procedure structure for sp_DeleteGameTeam
-- ----------------------------
DROP PROCEDURE [dbo].[sp_DeleteGameTeam]
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
            SET @message = '报名已经审核通过，请联系赛事管理员取消报名。'

    END

GO

-- ----------------------------
-- Procedure structure for sp_DeleteGameTeamById
-- ----------------------------
DROP PROCEDURE [dbo].[sp_DeleteGameTeamById]
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
            SET @message = '该队伍已经分配了比赛，不能取消。'
        ELSE
            DELETE  FROM dbo.GameTeam
            WHERE   Id = @teamId AND GameId=@gameId
    END


GO

-- ----------------------------
-- Procedure structure for sp_DeleteOnlineUser
-- ----------------------------
DROP PROCEDURE [dbo].[sp_DeleteOnlineUser]
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

-- ----------------------------
-- Procedure structure for sp_DeleteOrg
-- ----------------------------
DROP PROCEDURE [dbo].[sp_DeleteOrg]
GO
 
CREATE PROCEDURE [dbo].[sp_DeleteOrg] 
	@typeId NVARCHAR(50),
    @parenetTypeId NVARCHAR(50)
	
AS
	
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = '  '

        DECLARE @sql NVARCHAR(MAX)
		---删除机构
		DELETE FROM dbo.Organization WHERE TypeId=@typeId

		---修改上级的子级数量
		UPDATE dbo.Organization SET SonAmount=SonAmount-1 WHERE TypeId=@parenetTypeId

    END

GO

-- ----------------------------
-- Procedure structure for sp_FinishGameOrder
-- ----------------------------
DROP PROCEDURE [dbo].[sp_FinishGameOrder]
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

-- ----------------------------
-- Procedure structure for sp_GetActivity
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetActivity]
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

-- ----------------------------
-- Procedure structure for sp_GetActivityList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetActivityList]
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

		--仅仅第一页的时候取行数
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
					SET @sql = @sql + ' AND ISNULL(ClubId, '''') != '''' '	 --出俱乐部活动
				ELSE		
					SET @sql = @sql + ' AND ISNULL(ClubId, '''') = '''' '	--出非俱乐部活动

                EXEC SP_EXECUTESQL @sql,
                    N'@ClubId NVARCHAR(50),@cityId NVARCHAR(50),@type NVARCHAR(50),@rowCount INT OUTPUT',
                    @clubId, @cityId, @type, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
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
            SET @sql = @sql + ' AND ISNULL(ClubId, '''') != '''' '	 --出俱乐部活动
		ELSE		
		    SET @sql = @sql + ' AND ISNULL(ClubId, '''') = '''' '	--出非俱乐部活动


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

-- ----------------------------
-- Procedure structure for sp_GetActivityUserList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetActivityUserList]
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
		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@petName, '') != ''
            SET @filter = @filter
                + ' AND (b.Code+b.PetName+b.CardName+b.Mobile+ISNULL(a.PetName,'''') LIKE ''%'
                + @petName + '%'')' 

		DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页  取行数
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

		--分页取数据
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

-- ----------------------------
-- Procedure structure for sp_GetBootcampAddStudentList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetBootcampAddStudentList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetBootcampAddStudentList]
    @keywords NVARCHAR(50) ,--帐号，昵称，姓名，手机
	@CoachBootcampId NVARCHAR(50),
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' '  
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
                + ' AND (b.Code+b.PetName+b.CardName+ISNULL(b.Mobile,'''') LIKE ''%''+@keywords+''%'')'         
   
        DECLARE @sql NVARCHAR(MAX)

		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
SELECT 
	 @rowCount =COUNT(a.Id)
FROM dbo.CoachBootcampStudent a
INNER JOIN dbo.UserAccount b ON a.StudentId =b.Id
WHERE a.CoachBootcampId=@CoachBootcampId

					'   
                 + @filter              
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@CoachBootcampId NVARCHAR(50),@keywords NVARCHAR(50),@rowCount INT OUTPUT',
                    @CoachBootcampId , @keywords, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
				  SELECT 
							b.HeadUrl,
							b.Sex,
							CardName =dbo.fn_GetUserName(b.Id),
							b.PetName,
							b.Code,
							b.Id,
							b.Id AS UserId 
			FROM dbo.CoachBootcampStudent a
			INNER JOIN dbo.UserAccount b ON a.StudentId =b.Id
			WHERE a.CoachBootcampId=@CoachBootcampId
				' 
				+ @filter +' 
				ORDER BY a.CreateDate 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY
				'

        EXEC SP_EXECUTESQL @sql,
            N'@CoachBootcampId NVARCHAR(50),@keywords NVARCHAR(50),@pageIndex INT,@pageSize INT', 
			@CoachBootcampId,@keywords, @pageIndex, @pageSize
            

    END

GO

-- ----------------------------
-- Procedure structure for sp_GetBootcampAddStudentSelectList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetBootcampAddStudentSelectList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetBootcampAddStudentSelectList]
    @keywords NVARCHAR(50) ,--帐号，昵称，姓名，手机
	@CoachBootcampId NVARCHAR(50),
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' '  
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
                + ' AND (b.Code+b.PetName+b.CardName+ISNULL(b.Mobile,'''') LIKE ''%''+@keywords+''%'')'         
   
        DECLARE @sql NVARCHAR(MAX)

		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
SELECT 
	 @rowCount =COUNT(a.Id)
FROM dbo.CoachBootcampStudent a
INNER JOIN dbo.UserAccount b ON a.StudentId =b.Id
WHERE a.CoachBootcampId=@CoachBootcampId

					'   
                 + @filter              
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@CoachBootcampId NVARCHAR(50),@keywords NVARCHAR(50),@rowCount INT OUTPUT',
                    @CoachBootcampId , @keywords, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
				  SELECT 
							b.HeadUrl,
							b.Sex,
							CardName =dbo.fn_GetUserName(b.Id),
							b.PetName,
							b.Code,
							b.Id,
							b.Id AS UserId 
			FROM dbo.CoachBootcampStudent a
			INNER JOIN dbo.UserAccount b ON a.StudentId =b.Id
			WHERE a.CoachBootcampId=@CoachBootcampId
				' 
				+ @filter +' 
				ORDER BY a.CreateDate 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY
				'

        EXEC SP_EXECUTESQL @sql,
            N'@CoachBootcampId NVARCHAR(50),@keywords NVARCHAR(50),@pageIndex INT,@pageSize INT', 
			@CoachBootcampId,@keywords, @pageIndex, @pageSize
            

    END

GO

-- ----------------------------
-- Procedure structure for sp_GetBootcampAppointmentStudentList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetBootcampAppointmentStudentList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetBootcampAppointmentStudentList]
    @keywords NVARCHAR(50) ,--帐号，昵称，姓名，手机
	@BootcampCourseId NVARCHAR(50),
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' '  
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
                + ' AND (b.Code+b.PetName+b.CardName+ISNULL(b.Mobile,'''') LIKE ''%''+@keywords+''%'')'         
   
        DECLARE @sql NVARCHAR(MAX)

		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
SELECT 
	 @rowCount =COUNT(Id)
FROM dbo.CoachBootcampCourseJoin 
WHERE BootcampCourseId=@BootcampCourseId
					'   
                 + @filter              
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@BootcampCourseId NVARCHAR(50),@keywords NVARCHAR(50),@rowCount INT OUTPUT',
                    @BootcampCourseId , @keywords, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
				  SELECT 
							b.HeadUrl,
							b.Sex,
							CardName =dbo.fn_GetUserName(b.Id),
							b.PetName,
							b.Code,
							b.Id,
							b.Id AS UserId 
				FROM dbo.CoachBootcampCourseJoin a
				INNER JOIN dbo.UserAccount b ON a.StudentId=b.Id
				WHERE a.BootcampCourseId=@BootcampCourseId
				' 
				+ @filter +' 
				ORDER BY a.CreateDate 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY
				'

        EXEC SP_EXECUTESQL @sql,
            N'@BootcampCourseId NVARCHAR(50),@keywords NVARCHAR(50),@pageIndex INT,@pageSize INT', 
			@BootcampCourseId,@keywords, @pageIndex, @pageSize
            

    END

GO

-- ----------------------------
-- Procedure structure for sp_GetBootcampCourseAppointmentStudentList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetBootcampCourseAppointmentStudentList]
GO

CREATE PROCEDURE [dbo].[sp_GetBootcampCourseAppointmentStudentList]
    @BootcampCourseId NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
			
SELECT 
	 @rowCount =COUNT(Id)
FROM dbo.CoachBootcampCourseJoin 
WHERE BootcampCourseId=@BootcampCourseId
 
'
			
                EXEC SP_EXECUTESQL @sql,
                    N'@BootcampCourseId NVARCHAR(50), @rowCount INT OUTPUT',
                    @BootcampCourseId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
      	--分页取数据	
        SET @sql = '
				 SELECT 
					b.Id,
					b.Code,
					b.PetName,
					CardName =dbo.fn_GetUserName(b.Id),
					b.HeadUrl,
					b.Sex,
					b.Mobile
				FROM dbo.CoachBootcampCourseJoin a
				INNER JOIN dbo.UserAccount b ON a.StudentId=b.Id
				WHERE a.BootcampCourseId=@BootcampCourseId
				ORDER BY a.CreateDate 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@BootcampCourseId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @BootcampCourseId ,@pageIndex, @pageSize

		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetBootcampJoinedStudentList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetBootcampJoinedStudentList]
GO

CREATE PROCEDURE [dbo].[sp_GetBootcampJoinedStudentList]
    @CoachBootcampId NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
				SELECT 
					@rowCount=COUNT(*) 
				FROM dbo.CoachStudentMoney 
				WHERE CoachBootcampId=@CoachBootcampId
'
			
                EXEC SP_EXECUTESQL @sql,
                    N'@CoachBootcampId NVARCHAR(50), @rowCount INT OUTPUT',
                    @CoachBootcampId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
      	--分页取数据	
        SET @sql = '
				SELECT 
					b.Id,
					b.Code,
					b.PetName,
					CardName =dbo.fn_GetUserName(b.Id),
					b.HeadUrl,
					b.Sex,
					b.Mobile
				FROM dbo.CoachStudentMoney a
				INNER JOIN dbo.UserAccount b ON a.StudentUserId=b.Id
				WHERE CoachBootcampId=@CoachBootcampId
				ORDER BY a.CreateDate 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@CoachBootcampId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @CoachBootcampId ,@pageIndex, @pageSize

		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetCityList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCityList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<获取俱乐部列表>
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetClub
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetClub]
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
                  WHERE    ClubId=@clubId AND State='003001' /*申请中的*/
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

-- ----------------------------
-- Procedure structure for sp_GetClubAddressList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetClubAddressList]
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

-- ----------------------------
-- Procedure structure for sp_GetClubList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetClubList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<获取俱乐部列表>
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetClubMyList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetClubMyList]
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

-- ----------------------------
-- Procedure structure for sp_GetClubRequestList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetClubRequestList]
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

-- ----------------------------
-- Procedure structure for sp_GetClubUserList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetClubUserList]
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
    @isAdmin BIT ,--是否只查询管理员
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@petName, '') != ''
            SET @filter = @filter
                + ' AND (b.Code+b.PetName+b.CardName+b.Mobile+ISNULL(a.PetName,'''') LIKE ''%'
                + @petName + '%'')' 

        IF @isAdmin = 1
            SET @filter = @filter + ' AND a.IsAdmin=1 '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页，同时不只查询管理员的时候 取行数
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
		
	    --如果仅仅查询管理员，则手动设置@pageIndex,@pageSize，相当于不分页
        IF @isAdmin = 1
            BEGIN
                SET @pageIndex = 1
                SET @pageSize = 100
            END
            
        --分页取数据
        
        SET @sql = '
			SELECT *  
			FROM (
				SELECT ROW_NUMBER() OVER(ORDER BY  a.IsCreator DESC, a.IsAdmin DESC ) AS RowNumber,
					a.Id,
					a.ClubId,
					a.UserId,
					dbo.fn_GetUserLinkPetName(a.UserId,a.ClubId) AS PetName, 
					a.IsCreator,
					a.IsAdmin,
					a.Score,
					a.LevelValue,
					b.Code,
					b.Code AS UserCode,
					b.HeadUrl,
					b.CardName,
					b.Sex,
					HonorName=(SELECT TOP 1 Name FROM ClubHonor d WHERE d.ClubId=a.ClubId AND (a.Score BETWEEN BeginScore AND EndScore))
				FROM ClubUser a LEFT JOIN UserAccount b ON b.Id=a.UserId WHERE a.ClubId=@ClubId '
            + @filter
            + '  
			) c 
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize '
	
        EXEC SP_EXECUTESQL @sql,
            N'@ClubId NVARCHAR(50),@pageIndex INT,@pageSize INT', @clubId,
            @pageIndex, @pageSize
    END


GO

-- ----------------------------
-- Procedure structure for sp_GetCoachAuditList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoachAuditList]
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

		--设置查询表
		DECLARE @tableName NVARCHAR(100)
		IF	@State='010001' OR @State ='010003' --审核中 和 已拒绝
				SET	@tableName='CoachApply' --申请表
			ELSE 
				SET	@tableName='Coach' --正式表
        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
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
		
		--分页取正式表 数据	
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

-- ----------------------------
-- Procedure structure for sp_GetCoachBootcampCourseDetailList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoachBootcampCourseDetailList]
GO

CREATE PROCEDURE [dbo].[sp_GetCoachBootcampCourseDetailList]
	@CoachBootcampCourseId NVARCHAR(50),
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        DECLARE @sql NVARCHAR(MAX)

        SET @filter = ''
       

		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
									SELECT 
										@rowCount=COUNT(*)
									FROM dbo.CoachCourse a
 									WHERE a.CoachBootcampCourseId=@CoachBootcampCourseId ' 
                EXEC SP_EXECUTESQL @sql,
                    N'@CoachBootcampCourseId NVARCHAR(50),@rowCount INT OUTPUT',
                    @CoachBootcampCourseId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
			SELECT 
				a.*,
				b.Name AS TypeName,
				c.Address AS VenueAddress,
				c.Name AS VenueName,
				d.CardName AS CoachName
			FROM dbo.CoachCourse a 
			INNER JOIN dbo.UserAccount d ON a.CoachId=d.Id
			LEFT JOIN dbo.BaseData b ON a.Type=b.Id
			LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
			WHERE a.CoachBootcampCourseId=@CoachBootcampCourseId
			ORDER BY a.CreateDate DESC
			OFFSET (@pageIndex-1)*@pageSize ROWS
			FETCH NEXT @pageSize ROWS ONLY		 
				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@CoachBootcampCourseId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @CoachBootcampCourseId,@pageIndex, @pageSize

	 
    END



GO

-- ----------------------------
-- Procedure structure for sp_GetCoachBootcampCourseList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoachBootcampCourseList]
GO

CREATE PROCEDURE [dbo].[sp_GetCoachBootcampCourseList]
    @CoachBootcampId NVARCHAR(50) ,
	@CurrentUserId NVARCHAR(50) ,
	@BeginTime VARCHAR(100)='',
	@EndTime VARCHAR(100)='',
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		DECLARE @filter NVARCHAR(MAX)
		SET @filter=''
		IF	ISNULL(@BeginTime,'')!='' AND ISNULL(@EndTime,'')!=''
			SET @filter=@filter+'		AND   (@BeginTime<= BeginTime AND EndTime <=@EndTime )  '
		--仅仅第一页的时候取行数
        
		SET @sql = '
		SELECT 
			@rowCount=COUNT(*) 
		FROM CoachBootcampCourse 
		WHERE CoachBootcampId=@CoachBootcampId
		'+ @filter
			
		--PRINT (@sql)
		EXEC SP_EXECUTESQL @sql,
			N'@BeginTime NVARCHAR(100),@EndTime NVARCHAR(100), @CoachBootcampId NVARCHAR(50), @rowCount INT OUTPUT',
			@BeginTime,@EndTime,@CoachBootcampId,@rowCount OUTPUT
         
		
      	--分页取数据	
        SET @sql = '
					 
				SELECT 
					 * 
				FROM CoachBootcampCourse a
				WHERE  CoachBootcampId=@CoachBootcampId
				'+ @filter +'
				ORDER BY BeginTime 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		 --PRINT (@sql)

       
			 EXEC SP_EXECUTESQL @sql,
			N'@BeginTime NVARCHAR(100),@EndTime NVARCHAR(100), @CoachBootcampId NVARCHAR(50)
			,@pageIndex INT,@pageSize INT',
			@BeginTime,@EndTime,@CoachBootcampId
			,@pageIndex, @pageSize

		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetCoachBootcampList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoachBootcampList]
GO

CREATE PROCEDURE [dbo].[sp_GetCoachBootcampList]
    @IsForSyllabus BIT,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		DECLARE @filter NVARCHAR(max)
		SET @filter=''
		IF	@IsForSyllabus=1
			SET @filter=@filter+' AND (a.State=''Join'' OR a.State=''Finished'') '
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
				SELECT 
					@rowCount=COUNT(*) 
				FROM CoachBootcamp a
				WHERE 1=1'
				+@filter
			
                EXEC SP_EXECUTESQL @sql,
                    N'@rowCount INT OUTPUT',
                   @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
      	--分页取数据	
        SET @sql = '
				 SELECT 
					a.*,
					b.Address AS VenueAddress
				 FROM dbo.CoachBootcamp  a
				 LEFT JOIN dbo.Venue b ON a.VenueId=b.Id
				 WHERE 1=1 
				 '+@filter+'
				ORDER BY a.State DESC,a.CreateDate DESC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@pageIndex INT,@pageSize INT',
             @pageIndex, @pageSize

		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetCoachBootcampListForStudent
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoachBootcampListForStudent]
GO

CREATE PROCEDURE [dbo].[sp_GetCoachBootcampListForStudent]
    @StudentUserId NVARCHAR(50),
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		DECLARE @filter NVARCHAR(max)
		SET @filter=''
		 
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
				  SELECT 
					 @rowCount=Count(*)
				  FROM dbo.CoachStudentMoney 
				  WHERE StudentUserId=@StudentUserId  AND CourseTypeId=''027005'' 
 '
				+@filter
			
                EXEC SP_EXECUTESQL @sql,
                    N'@StudentUserId NVARCHAR(50),@rowCount INT OUTPUT',
                   @StudentUserId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
      	--分页取数据	
        SET @sql = '
				SELECT 
					b.*,
					c.Address AS VenueAddress
				 FROM dbo.CoachStudentMoney a
				 INNER JOIN dbo.CoachBootcamp b ON a.CoachBootcampId=b.Id
				 LEFT JOIN dbo.Venue c ON b.VenueId=c.Id
				 WHERE StudentUserId=@StudentUserId  AND CourseTypeId=''027005'' 
				 '+@filter+'
				ORDER BY b.State DESC,b.CreateDate DESC
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@StudentUserId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @StudentUserId,@pageIndex, @pageSize

		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetCoachCommentList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoachCommentList]
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
        SET @sql = '
				SELECT 
					*
				FROM 
					(
						SELECT 
							ROW_NUMBER() OVER (ORDER BY a.CreateDate DESC) AS RowNumber,
							b.HeadUrl,
							b.Sex,
							CommentatorName=CASE WHEN a.IsShareName=1 THEN b.CardName ELSE ''匿名用户'' END,
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

-- ----------------------------
-- Procedure structure for sp_GetCoacher
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoacher]
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

-- ----------------------------
-- Procedure structure for sp_GetCoacherApply
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoacherApply]
GO

CREATE PROCEDURE [dbo].[sp_GetCoacherApply]
	@UserId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;
	 
        DECLARE @sql NVARCHAR(MAX)
	 
        SET @sql = '
						--审核没通过的
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
						 --审核通过的
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

-- ----------------------------
-- Procedure structure for sp_GetCoacherCourseStudentList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoacherCourseStudentList]
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetCoacherCourseVenueList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoacherCourseVenueList]
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetCoacherListForGradeUpgrade
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoacherListForGradeUpgrade]
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
		--定义Filter
		DECLARE @filter NVARCHAR(MAX)
		SET @filter=''
		IF ISNULL(@cityId, '') != ''
            SET @filter = @filter + ' AND c.CityId=@CityId '

        IF ISNULL(@coacherName, '') != ''
            SET @filter = @filter + ' AND b.CardName LIKE ''%' + @coacherName + '%'''    
			
        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetCoacherListForSelect
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoacherListForSelect]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCoacherListForSelect]
    @keywords NVARCHAR(50) ,--帐号，昵称，姓名，手机
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' WHERE 1=1 AND a.IsEnabled=1 '  
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
                + ' AND (b.Code+b.PetName+b.CardName+ISNULL(b.Mobile,'''') LIKE ''%''+@keywords+''%'')'         

        DECLARE @sql NVARCHAR(MAX)

		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetCoacherMyStudentList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoacherMyStudentList]
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetCoachList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoachList]
GO
 
CREATE PROCEDURE [dbo].[sp_GetCoachList]
	@orderColumn NVARCHAR(100), 
	@orderType NVARCHAR(4), --排序类型 asc 升序, desc 降序
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
		--定义Filter
		DECLARE @filter NVARCHAR(MAX)
		SET @filter=''
		IF ISNULL(@cityId, '') != ''
            SET @filter = @filter + ' AND c.CityId=@CityId '

        IF ISNULL(@coacherName, '') != ''
            SET @filter = @filter + ' AND b.CardName LIKE ''%' + @coacherName + '%'''    
		--设置 DistanceFilter
		DECLARE @DistanceFilter NVARCHAR(MAX)
		SET @DistanceFilter=''
		IF	@distance>0
			SET @DistanceFilter=@DistanceFilter+' AND Distance < @distance ';
			
        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
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
					WHERE 1=1 AND a.IsEnabled=1 
						AND a.OrganizationId=''ydl''
					' +@filter+'
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
		--排序
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
		--分页取数据	
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
						WHERE 1=1 AND a.IsEnabled=1
							AND a.OrganizationId=''ydl''
						 '+@filter+'
						
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

-- ----------------------------
-- Procedure structure for sp_GetCoachPriceList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoachPriceList]
GO
 
CREATE PROCEDURE [dbo].[sp_GetCoachPriceList] 
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
      
        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetCoachTeachingCourseList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCoachTeachingCourseList]
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
 
		

		--仅仅第一页的时候取行数
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
		
		--分页取数据	
        SET @sql = '
					--没过期的课程
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
					--计算没过期数据有多少页
					DECLARE @NotExpiredPageCount INT
					SELECT @NotExpiredPageCount=(COUNT(*)+@pageSize-1)/@pageSize FROM #NotExpiredCourseList
					--开始取数据,  没过期的取完了才取过期的课程
					IF @pageIndex <=@NotExpiredPageCount
					BEGIN
							--从没过期数据中取
							SELECT 
								*
							FROM #NotExpiredCourseList
							ORDER BY  EndTime ASC
							OFFSET (@pageIndex-1)*@pageSize ROWS
							FETCH NEXT @pageSize ROWS ONLY
					END
					ELSE	
					BEGIN
						--从过期数据中取
 						SET @pageIndex=(@pageIndex-@NotExpiredPageCount); --重置pageIndex
					 
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

-- ----------------------------
-- Procedure structure for sp_GetCompany
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCompany]
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

-- ----------------------------
-- Procedure structure for sp_GetCompanyList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetCompanyList]
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

		--没有其他机构，暂时取消这个条件
		--SET @whereSql=' WHERE IsManage=@IsManage'
		SET @whereSql=' WHERE 1=1'

		IF ISNULL(@showAll,0)=0
			SET @whereSql=@whereSql+' AND ISNULL(IsStop,0)!=1'

		IF ISNULL(@name, '') != ''
			SET @whereSql = @whereSql + ' AND name LIKE ''%''+@name+''%'''

		--获取总行数 
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Company'+@whereSql

                EXEC SP_EXECUTESQL @sql,
                    N'@name NVARCHAR(50),@IsManage BIT,@rowCount INT OUTPUT',
                    @name, @IsManage, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
            
        --获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetContactCategoryList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetContactCategoryList]
GO

CREATE PROCEDURE [dbo].[sp_GetContactCategoryList] @userId NVARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT  '016002' AS Id ,
                '我的俱乐部' AS Name ,
                ( SELECT    COUNT(*)
                  FROM      dbo.Club b
                  WHERE     EXISTS ( SELECT *
                                     FROM   dbo.ClubUser c
                                     WHERE  c.ClubId = b.Id
                                            AND UserId = @userId )
                ) AS Number

    END

GO

-- ----------------------------
-- Procedure structure for sp_GetDynamicVenueBill
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetDynamicVenueBill]
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- 按创建日期，动态统计查看场馆的未付消费，已付消费
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetDynamicVenueBill]
    @cityId NVARCHAR(50) ,--可选条件
    @venueId NVARCHAR(50) ,--可选条件
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

-- ----------------------------
-- Procedure structure for sp_GetGame
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGame]
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
                --dbo.fn_Link(m.Id, m.Name) AS TeamMode ,--原对阵模板表
								dbo.fn_Link(z.Id, z.RuleCode) AS TeamMode ,
                a.IsLevelGame ,a.IsLeague,
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
                --dbo.fn_Link(h.Id, h.Name) AS [State] ,
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
                dbo.fn_Link(l.Id, l.Name) AS [State],
				a.IsEnableTV,
				a.IsConcessionScore,
				a.IsEnableLiveScore,
				a.AuditId,
				a.ManageId,
				CASE WHEN ISNULL(z.LoopCount, 0)=0 THEN 0 ELSE z.LoopCount/2+1 END AS WinLoopCount 
        FROM    Game a
                LEFT JOIN Club b ON a.ClubId = b.Id
                LEFT JOIN Venue e ON a.VenueId = e.Id
                LEFT JOIN UserAccount g ON a.CreatorId = g.Id
               -- LEFT JOIN BaseData h ON a.[State] = h.Id
                LEFT JOIN BaseData bat ON a.BattleStyle = bat.Id
                LEFT JOIN BaseData k ON a.KnockoutOption = K.Id
                LEFT JOIN BaseData n ON a.NameOption = n.Id
                --LEFT JOIN BaseData m ON m.Id = a.TeamMode  --原对阵模板表
								LEFT JOIN GameTeamLoopTemplet z ON z.Id=a.TeamMode 
                LEFT JOIN GameTeam i ON a.Id = i.GameId
                                        AND i.CreatorId = @userId
                LEFT JOIN City j ON a.CityId = j.Id
                LEFT JOIN BaseData l ON a.[State] = l.Id
        WHERE   a.Id = @gameId
    END
GO

-- ----------------------------
-- Procedure structure for sp_GetGameGroupList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameGroupList]
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

-- ----------------------------
-- Procedure structure for sp_GetGameGroupLoopList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameGroupLoopList]
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

-- ----------------------------
-- Procedure structure for sp_GetGameGroupMemberList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameGroupMemberList]
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

-- ----------------------------
-- Procedure structure for sp_GetGameGroupRankList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameGroupRankList]
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

-- ----------------------------
-- Procedure structure for sp_GetGameJudgeList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameJudgeList]
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

-- ----------------------------
-- Procedure structure for sp_GetGameJudgeLoopList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameJudgeLoopList]
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
				a.GameId,
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
				ISNULL(x.TeamMode,''021001'') AS TeamMode,
				n1.ImageUrl AS Team1FlagUrl,
				n2.ImageUrl AS Team2FlagUrl
        FROM    dbo.GameLoop a
				INNER JOIN dbo.Game x ON x.Id = a.GameId
                INNER JOIN dbo.GameOrder o ON o.Id = a.OrderId
                LEFT JOIN dbo.GameTeam b1 ON Team1Id = b1.Id
                LEFT JOIN dbo.GameTeam b2 ON Team2Id = b2.Id
				LEFT JOIN dbo.NationalFlag n1 ON b1.NationalId = n1.Id
                LEFT JOIN dbo.NationalFlag n2 ON b2.NationalId = n2.Id

                LEFT JOIN dbo.BaseData c ON a.State = c.Id
                LEFT JOIN dbo.GameGroup g ON g.Id = a.GroupId
                LEFT JOIN dbo.UserAccount u ON u.Id = a.JudgeId
				LEFT JOIN dbo.UserAccount u1 ON u1.Id = a.MasterJudgeId
        WHERE   a.JudgeId = @judgeId AND x.State=''015004''
				--排除小组轮空的比赛，淘汰赛轮空由裁判处理
                AND ( o.KnockoutOption = ''014002''
                      AND a.IsBye = 0
                      OR o.KnockoutOption = ''014001''
                    )'

        IF @isNotFinish = 1
            SET @sql = @sql + ' AND a.State!=''011003'' '
		
		IF ISNULL(@gameId, '') != ''
            SET @sql = @sql + ' AND a.GameId=@gameId '

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

-- ----------------------------
-- Procedure structure for sp_GetGameKnockLoopList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameKnockLoopList]
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
                a.State,
								b.EndRank
        FROM    dbo.GameLoop a
                JOIN dbo.GameOrder b ON b.Id = a.OrderId
                LEFT JOIN dbo.GameTeam b1 ON b1.Id = A.Team1Id
                LEFT JOIN dbo.GameTeam b2 ON b2.Id = A.Team2Id
        WHERE   a.GameId = @gameId
		        AND b.KnockOutAB=@knockOutAB
                AND b.KnockoutOption = '014001'
                AND ISNULL(GroupId, '') = ''
                AND a.IsExtra = 0
        ORDER BY b.OrderNo ,
                a.OrderNo
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetGameList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameList]
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

			/*
        IF ISNULL(@cityId, '') != ''
            SET @filter = @filter + ' AND a.CityId = @cityId'*/
                    
        IF ISNULL(@gameName, '') != ''
            SET @filter = @filter + ' AND a.Name LIKE ''%''+@gameName+''%'''

        IF ISNULL(@state, '') != ''
            SET @filter = @filter + ' AND CHARINDEX(a.State,@state)>0'
                        
        IF @isOnlySelf = 1
            SET @filter = @filter
                + ' AND EXISTS(SELECT 1 FROM GameTeam u WHERE u.GameId=a.Id AND (u.CreatorId=@userId OR CHARINDEX(@userId,TeamUserId)>0))'

		--非俱乐部成员不能看见未加入俱乐部赛事
        --SET @filter = @filter
        --    + ' AND (ISNULL(a.ClubId,'''')='''' OR ISNULL(a.ClubId,'''')!='''' AND EXISTS(SELECT * FROM dbo.ClubUser x WHERE x.ClubId=a.ClubId AND x.UserId=@userId))'

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
        SET @sql = 'SELECT a.Id,a.Name,dbo.fn_Link(e.Id,e.Name) AS BattleStyle,IsTeam,a.SportId,dbo.fn_Link(b.Id,b.Name) AS ClubId,IsScoreGame,
						a.HeadUrl,a.RegBeginTime,a.RegEndTime,a.PlayBeginTime,a.PlayEndTime,dbo.fn_Link(c.Id,c.Name) AS VenueId,a.CreatorId,a.IsLeague,
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
					ORDER BY IsTop Desc, PlayBeginTime DESC 
						OFFSET (@pageIndex-1)*@pageSize ROWS FETCH NEXT @pageSize ROWS ONLY 
						'
	
        EXEC SP_EXECUTESQL @sql,
            N'@clubId NVARCHAR(50),@cityId NVARCHAR(50),@gameName NVARCHAR(50),@state NVARCHAR(50),@userId NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @clubId, @cityId, @gameName, @state,@userId, @pageIndex, @pageSize

		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetGameLoopDetailList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameLoopDetailList]
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

-- ----------------------------
-- Procedure structure for sp_GetGameLoopList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameLoopList]
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetGameLoopMapList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameLoopMapList]
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
								---INNER JOIN dbo.Game D ON B.GameId=D.Id
        WHERE LoopId = @loopId  --D.State='015004' AND 
        ORDER BY OrderNo

    END

GO

-- ----------------------------
-- Procedure structure for sp_GetGameMyLoopList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameMyLoopList]
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
		--进行比赛，比赛结束阶段，返回自己相关的比赛
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

-- ----------------------------
-- Procedure structure for sp_GetGameOrderList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameOrderList]
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
                --CONCAT(a.Name,'-',ISNULL(a.KnockOutAB,'')) Name ,
				a.Name,
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

-- ----------------------------
-- Procedure structure for sp_GetGameOrderLoopList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameOrderLoopList]
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
    @groupOrderNo INT,
	@orderNo INT,
	@startTime NVARCHAR(50),
	@endTime NVARCHAR(50),
	@team1Id NVARCHAR(50),
	@team2Id NVARCHAR(50),
	@tableNo INT
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
                a.Game1,
                a.Game2,
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
				ISNULL(x.TeamMode,''021001'') AS TeamMode,
				g1.OrderNo AS Team1OrderNo,
				g2.OrderNo AS Team2OrderNo,
				a.BeginRank,a.EndRank
        FROM    dbo.GameLoop a
		        INNER JOIN dbo.Game x ON x.Id = a.GameId
				INNER JOIN dbo.GameOrder o ON o.Id = a.OrderId
                LEFT JOIN dbo.GameGroup b ON b.Id = a.GroupId
                LEFT JOIN dbo.GameTeam t1 ON t1.Id = a.Team1Id
                LEFT JOIN dbo.GameTeam t2 ON t2.Id = a.Team2Id
				LEFT JOIN GameGroupMember g1 ON b.Id=g1.GroupId AND g1.TeamId=a.Team1Id
				LEFT JOIN GameGroupMember g2 ON b.Id=g2.GroupId AND g2.TeamId=a.Team2Id
                LEFT JOIN dbo.BaseData c ON c.Id = a.State 
				LEFT JOIN dbo.UserAccount u ON u.Id = a.JudgeId 
				LEFT JOIN dbo.UserAccount u1 ON u1.Id = a.MasterJudgeId 
		WHERE   1=1 '
		IF ISNULL(@startTime,'') !=''
			SET @sql=@sql+' AND a.BeginTime >=@startTime'

		IF ISNULL(@endTime,'') !=''
			SET @sql=@sql+' AND a.BeginTime <=@endTime'
		
		IF ISNULL(@team1Id,'') !=''
			SET @sql=@sql+' AND (a.Team1Id=@team1Id OR a.Team2Id=@team1Id) '

		IF ISNULL(@team2Id,'') !=''
			SET @sql=@sql+' AND (a.Team1Id=@team2Id OR a.Team2Id=@team2Id) '

		IF @tableNo >0
			SET @sql=@sql+' AND a.TableNo=@tableNo'

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

		IF @orderNo > 0
            SET @sql = @sql + ' AND a.OrderNo=@orderNo'

        SET @sql = @sql
            + ' ORDER BY o.OrderNo,a.IsExtra,a.ExtraOrder,a.OrderNo,b.OrderNo,a.LoopOrderNo '

        EXEC SP_EXECUTESQL @sql,
            N'@orderId NVARCHAR(50),@knockOutAB NVARCHAR(50),@gameId NVARCHAR(50),@groupId NVARCHAR(50),@groupOrderNo INT,@orderNo INT,@startTime NVARCHAR(50),@endTime NVARCHAR(50),@team1Id NVARCHAR(50),@team2Id NVARCHAR(50),@tableNo INT',
            @orderId, @knockOutAB,@gameId, @groupId, @groupOrderNo, @orderNo,@startTime,@endTime,@team1Id,@team2Id,@tableNo
    END
GO

-- ----------------------------
-- Procedure structure for sp_GetGameOrderLoopListPage
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameOrderLoopListPage]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameOrderLoopListPage]
    @gameId NVARCHAR(50) ,
    @knockOutAB NVARCHAR(50) ,
    @orderId NVARCHAR(50) ,
    @groupId NVARCHAR(50) ,
    @isExtra NVARCHAR(50) ,
    @groupOrderNo INT,
	@orderNo INT,
	@startTime NVARCHAR(50),
	@endTime NVARCHAR(50),
	@team1Id NVARCHAR(50),
	@team2Id NVARCHAR(50),
	@tableNo INT,
	@pageSize INT,
	@pageIndex INT,
	@rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
		DECLARE @filter NVARCHAR(MAX)
		SET @filter=' WHERE   1=1 '
		DECLARE @gameOption NVARCHAR(10)--
		DECLARE @orderBy NVARCHAR(MAX)
		DECLARE @gameOrderNo INT--用于保存小组赛的大轮次序号
		SET @orderBy=' ORDER BY o.OrderNo,a.IsExtra,a.ExtraOrder,a.OrderNo,b.OrderNo,a.LoopOrderNo '

		IF ISNULL(@startTime,'') !=''
			SET @filter=@filter+' AND a.BeginTime >=@startTime'

		IF ISNULL(@endTime,'') !=''
			SET @filter=@filter+' AND a.BeginTime <=@endTime'
		
		IF ISNULL(@team1Id,'') !=''
			SET @filter=@filter+' AND (a.Team1Id=@team1Id OR a.Team2Id=@team1Id) '

		IF ISNULL(@team2Id,'') !=''
			SET @filter=@filter+' AND (a.Team1Id=@team2Id OR a.Team2Id=@team2Id) '

		IF @tableNo >0
			SET @filter=@filter+' AND a.TableNo=@tableNo'

        IF ISNULL(@gameId, '') != ''
            SET @filter = @filter + ' AND a.GameId=@gameId'

        IF @groupOrderNo > 0
            SET @filter = @filter + ' AND b.OrderNo=@groupOrderNo'

        IF ISNULL(@groupId, '') != ''
            SET @filter = @filter + ' AND a.GroupId=@groupId'

        IF ISNULL(@knockOutAB, '') != ''
            SET @filter = @filter + ' AND o.KnockOutAB=@knockOutAB'

        IF ISNULL(@orderId, '') != ''
			BEGIN
				SET @filter = @filter + ' AND a.OrderId = @orderId'
				SELECT TOP 1 @gameOption=b.KnockoutOption,@gameOrderNo=a.OrderNo FROM GameOrder AS a INNER JOIN Game AS b ON a.GameId=b.Id WHERE GameId=@gameId AND a.Id=@orderId ORDER BY a.OrderNo
				IF(@gameOption='014003' AND @gameOrderNo=1)
					SET @orderBy=' ORDER BY b.OrderNo,o.OrderNo,a.OrderNo,a.LoopOrderNo,a.IsExtra,a.ExtraOrder '
			END
            

        IF ISNULL(@isExtra, '') != ''
            SET @filter = @filter + ' AND a.IsExtra = ' + @isExtra

		IF @orderNo > 0
            SET @filter = @filter + ' AND a.OrderNo=@orderNo'
-----------------------------------------------------------------------------
		IF @pageIndex=1
		BEGIN 
			SET @sql='SELECT @rowCount= COUNT(a.Id)  FROM    dbo.GameLoop a
		        INNER JOIN dbo.Game x ON x.Id = a.GameId
				INNER JOIN dbo.GameOrder o ON o.Id = a.OrderId
                LEFT JOIN dbo.GameGroup b ON b.Id = a.GroupId
                LEFT JOIN dbo.GameTeam t1 ON t1.Id = a.Team1Id
                LEFT JOIN dbo.GameTeam t2 ON t2.Id = a.Team2Id
				LEFT JOIN GameGroupMember g1 ON b.Id=g1.GroupId AND g1.TeamId=a.Team1Id
				LEFT JOIN GameGroupMember g2 ON b.Id=g2.GroupId AND g2.TeamId=a.Team2Id
                LEFT JOIN dbo.BaseData c ON c.Id = a.State 
				LEFT JOIN dbo.UserAccount u ON u.Id = a.JudgeId 
				LEFT JOIN dbo.UserAccount u1 ON u1.Id = a.MasterJudgeId '+@filter

				EXEC SP_EXECUTESQL @sql,
            N'@orderId NVARCHAR(50),@knockOutAB NVARCHAR(50),@gameId NVARCHAR(50),@groupId NVARCHAR(50),@groupOrderNo INT,@orderNo INT,@startTime NVARCHAR(50),@endTime NVARCHAR(50),@team1Id NVARCHAR(50),@team2Id NVARCHAR(50),@tableNo INT,@rowCount INT OUTPUT',
            @orderId, @knockOutAB,@gameId, @groupId, @groupOrderNo, @orderNo,@startTime,@endTime,@team1Id,@team2Id,@tableNo,@rowCount OUTPUT
		END
		ELSE
		BEGIN
			SET @rowCount=0
		END
-------------------------------------------------------------------------------------
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
                a.Game1,
                a.Game2,
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
				ISNULL(x.TeamMode,''021001'') AS TeamMode,
				g1.OrderNo AS Team1OrderNo,
				g2.OrderNo AS Team2OrderNo,
				a.BeginRank,a.EndRank
        FROM    dbo.GameLoop a
		        INNER JOIN dbo.Game x ON x.Id = a.GameId
				INNER JOIN dbo.GameOrder o ON o.Id = a.OrderId
                LEFT JOIN dbo.GameGroup b ON b.Id = a.GroupId
                LEFT JOIN dbo.GameTeam t1 ON t1.Id = a.Team1Id
                LEFT JOIN dbo.GameTeam t2 ON t2.Id = a.Team2Id
				LEFT JOIN GameGroupMember g1 ON b.Id=g1.GroupId AND g1.TeamId=a.Team1Id
				LEFT JOIN GameGroupMember g2 ON b.Id=g2.GroupId AND g2.TeamId=a.Team2Id
                LEFT JOIN dbo.BaseData c ON c.Id = a.State 
				LEFT JOIN dbo.UserAccount u ON u.Id = a.JudgeId 
				LEFT JOIN dbo.UserAccount u1 ON u1.Id = a.MasterJudgeId '
		+@filter + @orderBy
		+' OFFSET (@pageIndex-1)*@pageSize ROWS FETCH NEXT @pageSize ROWS ONLY '
        EXEC SP_EXECUTESQL @sql,
            N'@orderId NVARCHAR(50),@knockOutAB NVARCHAR(50),@gameId NVARCHAR(50),@groupId NVARCHAR(50),@groupOrderNo INT,@orderNo INT,@startTime NVARCHAR(50),@endTime NVARCHAR(50),@team1Id NVARCHAR(50),@team2Id NVARCHAR(50),@tableNo INT,@pageIndex INT,@pageSize INT',
            @orderId, @knockOutAB,@gameId, @groupId, @groupOrderNo, @orderNo,@startTime,@endTime,@team1Id,@team2Id,@tableNo,@pageIndex,@pageSize
    END
GO

-- ----------------------------
-- Procedure structure for sp_GetGameOrderVSDetail
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameOrderVSDetail]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameOrderVSDetail]
    @gameId NVARCHAR(50) ,
    @knockOutAB NVARCHAR(50) ,
    @orderId NVARCHAR(50) ,
    @groupId NVARCHAR(50) ,
    @isExtra NVARCHAR(50) ,
	@GameLoopId NVARCHAR(50),
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
                a.Game1,
                a.Game2,
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
		
        IF ISNULL(@GameLoopId, '') != ''
            SET @sql = @sql + ' AND a.Id=@GameLoopId'

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
            N'@orderId NVARCHAR(50),@knockOutAB NVARCHAR(50),@gameId NVARCHAR(50)
			,@groupId NVARCHAR(50),@groupOrderNo INT
			,@GameLoopId NVARCHAR(50)',
            @orderId, @knockOutAB,@gameId, @groupId, @groupOrderNo,@GameLoopId
		PRINT @sql
    END
GO

-- ----------------------------
-- Procedure structure for sp_GetGameProgress
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameProgress]
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

-- ----------------------------
-- Procedure structure for sp_GetGameRankList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameRankList]
GO

-- =============================================
-- Author:		sxd
-- Create date: 2015-11-18
-- Description:	获取比赛报名队列表
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameRankList]
    @gameId NVARCHAR(50) ,
    @knockOutAB NVARCHAR(50) ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
        
		/*
		--全部比赛结束才显示排名
        DECLARE @notFinishCount INT
        SELECT  @notFinishCount = COUNT(*)
        FROM    dbo.GameLoop a
                JOIN dbo.GameOrder b ON b.Id = a.OrderId
        WHERE   a.GameId = @gameId
                AND ISNULL(a.State, '') != '011003'
                AND ISNULL(b.KnockOutAB, 'A') = @knockOutAB
		--获取排名
        IF @notFinishCount = 0
            BEGIN*/
				DECLARE @IsScore BIT
				DECLARE @IsTeam BIT
				DECLARE @gameKnockout NVARCHAR(50)
				DECLARE @GameState NVARCHAR(10)
				DECLARE @sql NVARCHAR(MAX)
				DECLARE @field NVARCHAR(MAX)
				SELECT @gameKnockout=KnockoutOption,@IsScore=ISNULL(IsScoreGame,0),@IsTeam=ISNULL(IsTeam,0),@GameState=State FROM dbo.Game WHERE Id=@gameId
				--DECLARE @teamId NVARCHAR(50)--用作判断此比赛是否是正在进行小组赛
				IF (@gameKnockout='014002')
					BEGIN
						
						IF @IsScore=1
							BEGIN
								SET @sql='SELECT T.*,RANK() OVER(ORDER BY T.Score DESC) AS FinalRank FROM ('
							END
						ELSE
							BEGIN
								SET @sql='SELECT T.*,RANK() OVER(ORDER BY T.Game DESC) AS FinalRank FROM ('
							END
							SET @sql=@sql+'SELECT  a.Id,a.HeadUrl,
									a.TeamName,
									a.TeamUserId,
									a.TeamUserName,
									a.MobilePhone,
									a.Remark,
									a.CreateDate,
									dbo.fn_Link(b.Id, b.CardName) AS CreatorId,
									--dbo.fn_GetFinalRank(@gameId, a.Id,@gameKnockout) AS FinalRank,
									dbo.fn_GetGameLoopCount(@gameId,a.Id) AS LoopCount,
									ISNULL(dbo.fn_GetTeamScore(@gameId,a.Id,0,0), 0) AS Score,
									(SELECT ISNULL(SUM(T1.Game), 0)  FROM (
									SELECT (CASE WHEN @IsTeam=1 THEN ISNULL(Team1, 0) ELSE ISNULL(Game1, 0) END) AS Game FROM GameLoop WHERE GameId=@gameId AND Team1Id=a.Id
									UNION ALL
									SELECT (CASE WHEN @IsTeam=1 THEN ISNULL(Team2, 0) ELSE ISNULL(Game2, 0) END) AS Game FROM GameLoop WHERE GameId=@gameId AND Team2Id=a.Id) T1) AS Game 
									FROM    GameTeam a
									INNER JOIN UserAccount b ON a.CreatorId = b.Id
							WHERE a.State=''012002'' AND  a.GameId=@gameId
														) T'
								/*EXISTS ( SELECT *
											 FROM   dbo.GameLoop b
													JOIN dbo.GameOrder c ON c.Id = b.OrderId
											 WHERE  b.GameId = @gameId
													AND ISNULL(c.KnockOutAB, ''A'') = @knockOutAB
													AND (@gameKnockout=''014002'' OR ISNULL(b.GroupId, '''') = '''')--不是单循环，队伍需是淘汰赛阶段的队伍
													AND ( b.Team1Id = a.Id
														  OR b.Team2Id = a.Id
														) )*/
								EXEC  SP_EXECUTESQL @sql,N'@gameId NVARCHAR(50),@gameKnockout NVARCHAR(50),@knockOutAB NVARCHAR(50),@IsTeam BIT',@gameId,@gameKnockout,@knockOutAB,@IsTeam
						END
					ELSE
						BEGIN
							IF(@GameState !='015005')
								BEGIN
									IF(@knockOutAB !='B')
										BEGIN
											SELECT  a.Id,a.HeadUrl,
											a.TeamName,
											a.TeamUserId,
											a.TeamUserName,
											a.MobilePhone,
											a.Remark,
											a.CreateDate,
											dbo.fn_Link(b.Id, b.CardName) AS CreatorId
											FROM    GameTeam a INNER JOIN UserAccount b ON a.CreatorId = b.Id
											WHERE a.GameId=@gameId AND a.State='012002'
										END
								END
                            ELSE
								BEGIN
									SELECT  a.Id,a.HeadUrl,
									a.TeamName,
									a.TeamUserId,
									a.TeamUserName,
									a.MobilePhone,
									a.Remark,
									a.CreateDate,
									dbo.fn_Link(b.Id, b.CardName) AS CreatorId,
									dbo.fn_GetFinalRank(@gameId, a.Id,@gameKnockout) AS FinalRank,
									ISNULL(dbo.fn_GetTeamScore(@gameId,a.Id,0,0), 0) AS Score,
									dbo.fn_GetGameLoopCount(@gameId,a.Id) AS LoopCount
									FROM    GameTeam a
									INNER JOIN UserAccount b ON a.CreatorId = b.Id
							WHERE a.State='012002' AND   EXISTS (
								SELECT * FROM   dbo.GameLoop b INNER JOIN dbo.GameOrder c ON c.Id = b.OrderId
								WHERE  b.GameId = @gameId AND ISNULL(c.KnockOutAB, 'A') = @knockOutAB
													AND (@gameKnockout='014002' OR ISNULL(b.GroupId, '') = '')--不是单循环，队伍需是淘汰赛阶段的队伍
													AND ( b.Team1Id = a.Id
														  OR b.Team2Id = a.Id
														))  
									ORDER BY FinalRank
								END    
                            
						END
                        
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetGameRankListByOrder
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameRankListByOrder]
GO

-- =============================================
-- Author:		zq
-- Create date: 2018-05-08
-- Description:	获取比赛报名队列表排名,针对单循环积分赛
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGameRankListByOrder]
    @gameId NVARCHAR(50) ,
    @startOrderNo INT,
    @endOrderNo INT
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @sql NVARCHAR(MAX)
		DECLARE @filter NVARCHAR(MAX)
		DECLARE @scoreFilter NVARCHAR(MAX)
		SET @filter=' WHERE a.GameId=@gameId ';
		SET @scoreFilter=' ISNULL(dbo.fn_GetTeamScore(@gameId,a.Id,0,0), 0) AS Score '
		IF @startOrderNo >0
		BEGIN
			SET @filter=@filter+' AND a.OrderNo>=@startOrderNo AND a.OrderNo<=@endOrderNo '
			SET @scoreFilter=' ISNULL(dbo.fn_GetTeamScore(@gameId,a.Id,@startOrderNo,@endOrderNo),0) AS Score '
		END
			
		
		SET @sql=
               ' SELECT T.*,RANK() OVER(ORDER BY T.Score DESC) AS FinalRank FROM (SELECT  a.Id,a.HeadUrl,
                        a.TeamName,
						a.TeamUserId,
						a.TeamUserName,
						a.CreateDate,'
                        --dbo.fn_GetFinalRankByOrder(@gameId, a.Id) AS FinalRank,'
						+@scoreFilter+
						
                'FROM    GameTeam a
						INNER JOIN UserAccount b ON a.CreatorId = b.Id
                WHERE   a.Id IN (
								 SELECT a.Team1Id AS TeamId FROM GameLoop AS a  '
							+@filter+
								' UNION
								SELECT a.Team2Id AS TeamId FROM GameLoop AS a  '
								 +@filter+')) T 
                '
PRINT @sql
		EXEC SP_EXECUTESQL @sql,N'@gameId NVARCHAR(50) ,@startOrderNo INT,@endOrderNo INT',@gameId,@startOrderNo,@endOrderNo

    END

GO

-- ----------------------------
-- Procedure structure for sp_GetGameTableList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameTableList]
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

-- ----------------------------
-- Procedure structure for sp_GetGameTeam
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameTeam]
GO
-- =============================================
-- Author:		sxd
-- Create date: 2015-11-18
-- Description:	获取比赛报名单个队伍信息
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
                a.CreateDate,
								a.NationalId,
								e.ImageUrl AS NationalFlagUrl
        FROM    GameTeam a
                INNER JOIN dbo.Game g ON g.Id = a.GameId
                INNER JOIN UserAccount b ON a.CreatorId = b.Id
                INNER JOIN BaseData d ON a.State = d.Id
				LEFT JOIN dbo.Company c ON c.Id = a.CompanyId
        LEFT JOIN dbo.NationalFlag e ON a.NationalId=e.Id 
        WHERE   CHARINDEX(a.Id, @TeamId) > 0
    END
GO

-- ----------------------------
-- Procedure structure for sp_GetGameTeamList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameTeamList]
GO
-- =============================================
-- Author:		sxd
-- Create date: 2015-11-18
-- Description:	获取比赛报名队列表
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

        --仅仅第一页的时候取行数
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
		
		--全部比赛结束才显示排名
        DECLARE @notFinishCount INT
        SELECT  @notFinishCount = COUNT(*)
        FROM    dbo.GameLoop
        WHERE   GameId = @gameId
                AND ISNULL(State, '') != '011003'
		--分页取数据	
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
						(SELECT TOP 1 Score FROM UserSport WHERE UserId=a.CreatorId) AS SportScore,
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
			
			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize '

        EXEC SP_EXECUTESQL @sql,
            N'@gameId NVARCHAR(50),@state NVARCHAR(50),@teamName NVARCHAR(50),@notFinishCount INT,@pageIndex INT,@pageSize INT',
            @gameId, @state, @teamName, @notFinishCount, @pageIndex, @pageSize
    END
GO

-- ----------------------------
-- Procedure structure for sp_GetGameTeamList1
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameTeamList1]
GO
--队伍列表分比赛类型及状态,带排名,积分
CREATE PROCEDURE [dbo].[sp_GetGameTeamList1]
    @gameId NVARCHAR(50) ,
    @teamName NVARCHAR(50) 
    --@pageIndex INT ,
    --@pageSize INT ,
    --@rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
        
        DECLARE @sql NVARCHAR(MAX)
		SET @sql=''
		DECLARE @orderby NVARCHAR(MAX)
		SET @orderby=''
		DECLARE @field NVARCHAR(MAX)
		SET @field=''
		DECLARE @filter NVARCHAR(MAX)
		SET @filter=' AND a.State !=''012003'' '
		DECLARE @IsScore BIT
		DECLARE @IsTeam BIT
		DECLARE @IsKnockOutAB BIT
		DECLARE @gameKnockout NVARCHAR(50)
		DECLARE @GameState NVARCHAR(10)
		DECLARE @NotGroupFinishCount  INT
		DECLARE @GroupTableRank NVARCHAR(MAX)--用于保存小组淘汰赛名次查询字符串(包括A,B组)
		SET @GroupTableRank=''
		DECLARE @ClubId NVARCHAR(50)
		SELECT @gameKnockout=KnockoutOption,@IsScore=ISNULL(IsScoreGame,0),@IsTeam=ISNULL(IsTeam,0),@GameState=State,@IsKnockOutAB=ISNULL(IsKnockOutAB,0),@ClubId=ClubId FROM dbo.Game WHERE Id=@gameId
		
		IF(@IsTeam=0 )--针对非团体赛显示档位或段位
			BEGIN
				IF(ISNULL(@ClubId,0)=0)
					SET @field=@field+',q.GradeName AS GradeStr '
				ELSE
					SET @field=@field+',CASE WHEN ISNULL(C.LevelValue,0)=0 THEN  q.GradeName ELSE CONCAT(C.LevelValue,''档'') END AS GradeStr '
			END

		IF (@GameState IN ('015002','015003','015001','015009'))--判断比赛未进行或未结束
			SET @orderby=@orderby+' ORDER BY a.State,a.CreateDate '
		ELSE
			BEGIN
				IF (@gameKnockout ='014002')--判断单循环
					BEGIN
						SET @field=@field+',dbo.fn_GetGameLoopCount(@gameId,a.Id) AS LoopCount,ISNULL(dbo.fn_GetTeamScore(@gameId,a.Id,0,0), 0) AS Score,
						(SELECT ISNULL(SUM(T1.Game), 0)  FROM (
									SELECT (CASE WHEN @IsTeam=1 THEN ISNULL(Team1, 0) ELSE ISNULL(Game1, 0) END) AS Game FROM GameLoop WHERE GameId=@gameId AND State=''011003'' AND Team1Id=a.Id
									UNION ALL
									SELECT (CASE WHEN @IsTeam=1 THEN ISNULL(Team2, 0) ELSE ISNULL(Game2, 0) END) AS Game FROM GameLoop WHERE GameId=@gameId AND State=''011003'' AND Team2Id=a.Id) T1) AS Game  '
						IF(@IsScore=1)
							SET @sql='SELECT T.*,RANK() OVER(ORDER BY T.Score DESC) AS FinalRank,CONCAT(''第'',RANK() OVER(ORDER BY T.Score DESC),''名'') AS RankStr FROM ('
						ELSE
							SET @sql='SELECT T.*,RANK() OVER(ORDER BY T.Game DESC) AS FinalRank,CONCAT(''第'',RANK() OVER(ORDER BY T.Score DESC),''名'') AS RankStr FROM ('
						SET @orderby=@orderby+' ORDER BY T.State DESC '
						SET @filter=' AND a.State =''012002'' '
					END
				ELSE IF( @gameKnockout ='014001')--单淘汰,使用原有的排名函数,没有积分,没有参赛轮次
					BEGIN
						IF(@GameState='015005')
							BEGIN
								IF (@IsScore=1)
									SELECT @field=@field+',ISNULL(dbo.fn_GetTeamScore(@gameId,a.Id,0,0), 0) AS Score'
								SET @field=@field+',dbo.fn_GetGameLoopCount(@gameId,a.Id) AS LoopCount,dbo.fn_GetFinalRank(@gameId, a.Id,@gameKnockout) AS FinalRank,CONCAT(''第'',dbo.fn_GetFinalRank(@gameId, a.Id,@gameKnockout),''名'') AS RankStr '
								SET @orderby=@orderby+' ORDER BY a.State DESC,FinalRank ASC '
								SET @filter=' AND a.State =''012002'' '
							END
						ELSE
							SET @orderby=@orderby+' ORDER BY a.State,a.CreateDate '
					END
				ELSE--小组循环后淘汰,使用原有的排名函数,没有积分,没有参赛轮次
					BEGIN
						--SELECT @NotGroupFinishCount=ISNULL(COUNT(a.Id),0) FROM dbo.GameLoop a INNER JOIN dbo.GameOrder b ON a.GameId=b.GameId AND a.OrderId=b.Id WHERE b.GameId=@gameId AND b.OrderNo=1 AND a.State !='011003'
						--IF(@NotGroupFinishCount>0)--小组赛还在进行中,只有队伍列表
						IF(@GameState !='015005')
							SET @orderby=@orderby+' ORDER BY a.State,a.CreateDate '
						ELSE
							BEGIN
								SET @orderby=@orderby+' ORDER BY a.State DESC, CASE WHEN n.RankStr IS NULL THEN ''C'' ELSE n.RankStr END '
								SET @GroupTableRank=' LEFT JOIN ( SELECT DISTINCT a.Id AS TeamId,dbo.fn_GetFinalRank(@gameId, a.Id,@gameKnockout) AS FinalRank,CONCAT(ISNULL(b.KnockOutAB,''A''),''组第'',dbo.fn_GetFinalRank(@gameId, a.Id,@gameKnockout),''名'') AS RankStr  FROM dbo.GameTeam a INNER JOIN dbo.GameOrder b ON a.GameId=b.GameId INNER JOIN dbo.GameLoop c ON b.Id=c.OrderId  AND a.Id IN (c.Team1Id,c.Team2Id) WHERE a.GameId=@gameId AND ISNULL(c.GroupId,'''')='''' AND C.State=''011003'' AND b.KnockOutAB IN (''A'',''B'') ) n ON a.Id=n.TeamId '
								IF (@IsScore=1)
									SELECT @field=@field+',ISNULL(dbo.fn_GetTeamScore(@gameId,a.Id,0,0), 0) AS Score'
								SET @field=@field+',dbo.fn_GetGameLoopCount(@gameId,a.Id) AS LoopCount,n.FinalRank,n.RankStr'
								SET @filter=' AND a.State =''012002'' '
							END
					END
			END
            
        SET @sql =@sql+ 'SELECT  a.HeadUrl,a.SeedNo,a.Id,a.GameId,a.IsSeed,a.IsJoined,a.IsTeam,a.TeamName,a.TeamUserId,
						a.TeamUserName,a.Remark,a.CorpTeamId,a.CorpTeamName,c.LevelValue,
						(SELECT TOP 1 Score FROM UserSport WHERE UserId=a.TeamUserId) AS SportScore,
						g.ClubId,dbo.fn_Link(d.Id, d.Name) AS State,
						dbo.fn_GetUserLinkName(g.NameOption,a.CreatorId,dbo.fn_GetUserPetName(a.CreatorId,g.ClubId),b.CardName) AS CreatorId,
						dbo.fn_Link(m.Id, m.Name) AS CompanyId ,a.CreateDate,a.MobilePhone
						'+@field+'
					FROM  GameTeam a 
			LEFT JOIN UserAccount b ON a.CreatorId=b.Id 
			LEFT JOIN BaseData d ON a.State = d.Id 
			LEFT JOIN Game g ON a.GameId = g.Id 
			LEFT JOIN ClubUser c ON c.ClubId=g.ClubId AND c.UserId=a.TeamUserId 
			LEFT JOIN dbo.Company m ON m.Id = a.CompanyId 
			LEFT JOIN UserSport p ON  a.TeamUserId=p.UserId AND g.SportId=p.SportId 
			LEFT JOIN ScoreGrade q ON p.Score >=q.LeftScore AND p.Score <=q.RightScore ' 
			+@GroupTableRank+
			' WHERE a.GameId=@gameId '+@filter
			IF ISNULL(@teamName, '') != ''
				BEGIN
					SET @sql = @sql + ' AND TeamName LIKE ''%' + @teamName + '%'''
				END
			IF(@gameKnockout ='014002' AND @GameState IN ('015004','015005') )--单循环且比赛进行中或结束
				SET @sql=@sql+') T'
			SET @sql=@sql+@orderby
PRINT @sql
        EXEC SP_EXECUTESQL @sql,
            N'@gameId NVARCHAR(50),@teamName NVARCHAR(50),@IsTeam BIT,@gameKnockout NVARCHAR(50),@GroupTableRank NVARCHAR(MAX)',
            @gameId, @teamName,@IsTeam,@gameKnockout,@GroupTableRank
    END
GO

-- ----------------------------
-- Procedure structure for sp_GetGameTeamListForKnock
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameTeamListForKnock]
GO
-- =============================================
-- Author:		sxd
-- Create date: 2015-11-18
-- Description:	获取比赛报名队列表
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

-- ----------------------------
-- Procedure structure for sp_GetGameTopList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameTopList]
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

-- ----------------------------
-- Procedure structure for sp_GetGameTVList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGameTVList]
GO



CREATE PROCEDURE [dbo].[sp_GetGameTVList]
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

		--非俱乐部成员不能看见未加入俱乐部赛事
        --SET @filter = @filter
        --    + ' AND (ISNULL(a.ClubId,'''')='''' OR ISNULL(a.ClubId,'''')!='''' AND EXISTS(SELECT * FROM dbo.ClubUser x WHERE x.ClubId=a.ClubId AND x.UserId=@userId))'

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
				SELECT @rowCount=COUNT(Id) 
				FROM Game a 
				WHERE a.State!=''015009''
					--AND a.IsEnableTV=1
				'
                    + @filter                    
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@ClubId NVARCHAR(50),@cityId NVARCHAR(50),@gameName NVARCHAR(50),@state NVARCHAR(50),@userId NVARCHAR(50),@rowCount INT OUTPUT',
                    @clubId, @cityId, @gameName, @state,@userId, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
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
					WHERE a.State!=''015009'' 
							--AND a.IsEnableTV=1
					'+@filter+'
					ORDER BY PlayBeginTime DESC 
						OFFSET (@pageIndex-1)*@pageSize ROWS FETCH NEXT @pageSize ROWS ONLY '
	
        EXEC SP_EXECUTESQL @sql,
            N'@clubId NVARCHAR(50),@cityId NVARCHAR(50),@gameName NVARCHAR(50),@state NVARCHAR(50),@userId NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @clubId, @cityId, @gameName, @state,@userId, @pageIndex, @pageSize

		
    END
GO

-- ----------------------------
-- Procedure structure for sp_GetGeneralUserList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetGeneralUserList]
GO
--获取一般用户 (剔除教练)
 CREATE PROCEDURE [dbo].[sp_GetGeneralUserList]
    @keywords NVARCHAR(50) ,--帐号，昵称，姓名，手机
    @isAdmin NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' AND IsAdmin=' + @isAdmin
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
                + ' AND (a.Code+a.PetName+a.CardName+ISNULL(a.Mobile,'''') LIKE ''%''+@keywords+''%'')'         

        DECLARE @sql NVARCHAR(MAX)

		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
				SELECT @rowCount=COUNT(a.Id) 
				FROM UserAccount a
				WHERE NOT EXISTS(SELECT * FROM dbo.Coach WHERE a.Id= Id)/*剔除教练*/

				'
                    + @filter              
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@keywords NVARCHAR(50),@rowCount INT OUTPUT', @keywords,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
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
					WHERE NOT EXISTS(SELECT * FROM dbo.Coach WHERE a.Id= Id)/*剔除教练*/
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

-- ----------------------------
-- Procedure structure for sp_GetLiveRoomList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetLiveRoomList]
GO
 
CREATE PROCEDURE [dbo].[sp_GetLiveRoomList] 
	@GameId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
	
AS
	
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = '  AND a.IsVod=1 '
		 
		IF ISNULL(@GameId, '') != ''
            SET @filter = ' AND a.GameId =@GameId AND a.IsVod=1 OR  (ISNULL(a.IsVod, 0) !=1 AND a.GameId =@GameId AND a.State !=''UnActive'')'--需求加条件
		ELSE
			SET @filter=@filter+' OR (ISNULL(a.IsVod, 0) !=1 AND a.State=''Active'' ) '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(a.Id) 
						FROM dbo.LiveRoom a
						WHERE 1=1 
						' 
						+@filter
				
                EXEC SP_EXECUTESQL @sql,
                    N'@GameId NVARCHAR(50) ,@rowCount INT OUTPUT'
					,@GameId,@rowCount OUTPUT
                    
            END
        ELSE
            SET @rowCount = 0
		--分页取数据	
        SET @sql = '
					 
				SELECT 
						a.*
				FROM dbo.LiveRoom a
				WHERE 1=1 ' 
				+@filter+ '
				ORDER BY a.State,a.CreateDate
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@GameId NVARCHAR(50), @pageIndex INT,@pageSize INT'
			,@GameId,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetMsgList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetMsgList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<获取笔记列表>
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
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Msg WHERE ReceiverId=@userId'			
                EXEC SP_EXECUTESQL @sql,
                    N'@userId NVARCHAR(50),@rowCount INT OUTPUT', @userId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetNearbyTeachingPointList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetNearbyTeachingPointList]
GO
CREATE PROCEDURE [dbo].[sp_GetNearbyTeachingPointList]
    @userId NVARCHAR(50) ,
    @isOnlySelf NVARCHAR(50) ,
    @isUseVip NVARCHAR(50) ,
    @name NVARCHAR(50) ,
    @cityCode NVARCHAR(50) ,
	@curUserLng FLOAT,
	@curUserLat FLOAT,
	@isAll BIT , --是否返回全部, 包括已审核和未审核的
	@state NVARCHAR(50)='',
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--取用户管理员标志
        DECLARE @isAdmin BIT
        SELECT  @isAdmin = IsAdmin
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        IF @isAdmin IS NULL
            SET @isAdmin = 0

        --设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@name, '') != ''
            SET @filter = @filter + ' AND name LIKE ''%''+@name+''%'''
                        
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'  

        IF ISNULL(@isUseVip, '') != ''
            SET @filter = @filter + ' AND IsUseVip=1'  
		SET @filter = @filter + ' AND IsEnableTeachingPoint=1'  

        --查看自己创建的全部场馆或者其他通过审核的场馆，管理员查看所有   
        IF @isAdmin = 0
            BEGIN
                IF ISNULL(@isOnlySelf, '') = '1'
                    SET @filter = @filter
                        + ' AND (CreatorId=@userId OR AdminId=@userId 
						OR Id IN ( --消费过的场馆
									SELECT VenueId FROM VipUse WHERE PayState=''024002'' AND UserId=@userId)) '  
                ELSE IF @isAll !=1 --不返回全部
				BEGIN
						IF  ISNULL(@state, '') != ''
							SET @filter = @filter + '  AND State='''+@state+''''  
						ELSE	
							SET @filter = @filter + '  AND State=''010002'''  --不返回全部, 默认返回已审核的

				END
			 
            END

		--获取总行数
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
            
        --获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetNote
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetNote]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<获取笔记列表>
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

-- ----------------------------
-- Procedure structure for sp_GetNoteList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetNoteList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<获取笔记列表>
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
		--过滤条件
		DECLARE @filter NVARCHAR(MAX)
		IF	@isAll=1
			SET @filter='AND n.IsShare=1' --查询所有人的笔记
		ELSE IF @isSelf =1
			SET @filter= 'AND n.CreatorId=@noteCreatorId ' --查询自己的笔记
		ELSE
			SET @filter= 'AND n.CreatorId=@noteCreatorId AND n.IsShare=1 ' --查询别人的笔记并且是公开的
			
        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数  
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Note n WHERE 1=1  ' +@filter			
                EXEC SP_EXECUTESQL @sql,
                    N'@noteCreatorId NVARCHAR(50),@rowCount INT OUTPUT', @noteCreatorId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetNoteReplyList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetNoteReplyList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<获取笔记列表>
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
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM NoteReply WHERE NoteId=@noteId'			
                EXEC SP_EXECUTESQL @sql,
                    N'@noteId NVARCHAR(50),@rowCount INT OUTPUT', @noteId,
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetNoteSupportList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetNoteSupportList]
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
		--获取点赞总数
		SELECT @rowCount=COUNT(*) 
		FROM  dbo.NoteSupport 
        WHERE   NoteId = @noteId

		--最后出数据
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

-- ----------------------------
-- Procedure structure for sp_GetOnlineUser
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetOnlineUser]
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

-- ----------------------------
-- Procedure structure for sp_GetOrderTrialCourseList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetOrderTrialCourseList]
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetOrganizationList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetOrganizationList]
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetOrgList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetOrgList]
GO
 
CREATE PROCEDURE [dbo].[sp_GetOrgList] 
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
	
AS
	
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = '  '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 	@rowCount=COUNT(Id)  FROM Organization
						' 			
                EXEC SP_EXECUTESQL @sql,
                    N'@rowCount INT OUTPUT',
					@rowCount OUTPUT
 
            END
        ELSE
            SET @rowCount = 0
		--分页取数据	
        SET @sql = '
				SELECT * FROM Organization 
				ORDER BY TypeId
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		

        EXEC SP_EXECUTESQL @sql,
            N'@pageIndex INT,@pageSize INT',@pageIndex, @pageSize
 
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetPersonalRankListByOrder
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetPersonalRankListByOrder]
GO

-- =============================================
-- Author:		sxd
-- Create date: 2018-05-03
-- Description:	获取比赛个人排名列表,针对单循环
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetPersonalRankListByOrder]
    @gameId NVARCHAR(50) ,
    @startOrderNo INT,
    @endOrderNo INT,
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @sql NVARCHAR(MAX)
		DECLARE @filter NVARCHAR(MAX)
		DECLARE @scoreFilter NVARCHAR(MAX)
		SET @scoreFilter=' dbo.fn_GetPersonalSportScore(@gameId,a.Id,0,0) AS Score '
		SET @filter=' WHERE a.GameId=@gameId ';
		IF @startOrderNo >0
		BEGIN
			SET @filter=@filter+' AND a.OrderNo>=@startOrderNo AND a.OrderNo<=@endOrderNo '
			SET @scoreFilter=' dbo.fn_GetPersonalSportScore(@gameId,a.Id,@startOrderNo,@endOrderNo) AS Score '
		END
		
		--第一页获取总数
		IF @pageIndex=1
			BEGIN
				SET @sql='SELECT @rowCount=COUNT(a.Id) FROM UserAccount AS a INNER JOIN GameTeam AS b ON CHARINDEX(a.Id, b.TeamUserId)>0 
					WHERE  b.Id IN (
									 SELECT a.Team1Id AS TeamId FROM GameLoop AS a  '
									 +@filter+
									' UNION
									SELECT a.Team2Id AS TeamId FROM GameLoop AS a  '
									 +@filter+')'

				EXEC sp_executesql @sql,N'@gameId NVARCHAR(50) ,@startOrderNo INT, @endOrderNo INT,@rowCount INT OUTPUT',@gameId,@startOrderNo,@endOrderNo,@rowCount OUTPUT
			END	
		ELSE
			SET @rowCount=0
		
		--分页数据
		SET @sql=
               ' SELECT T.*,RANK() OVER(ORDER BY T.Score DESC) AS FinalRank FROM (SELECT DISTINCT a.HeadUrl, a.Sex,
			    (CASE WHEN c.NameOption=020001 THEN a.PetName ELSE a.CardName END) AS Name,'
			    +@scoreFilter+
				'
				FROM UserAccount AS a INNER JOIN GameTeam AS b ON CHARINDEX(a.Id, b.TeamUserId)>0 
				LEFT JOIN Game AS c ON b.GameId=c.Id
			    WHERE  b.Id IN (
								 SELECT a.Team1Id AS TeamId FROM GameLoop AS a  '
								 +@filter+
								' UNION
								SELECT a.Team2Id AS TeamId FROM GameLoop AS a  '
								 +@filter+')
                ) T  ORDER BY T.Score DESC 
				OFFSET (@pageIndex-1)*@pageSize ROWS 
				FETCH NEXT @pageSize ROWS ONLY'

		EXEC SP_EXECUTESQL @sql,N'@gameId NVARCHAR(50) ,@startOrderNo INT,@endOrderNo INT,@pageIndex INT,@pageSize INT',@gameId,@startOrderNo,@endOrderNo,@pageIndex,@pageSize

    END

GO

-- ----------------------------
-- Procedure structure for sp_GetRoleUserMapListByRole
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetRoleUserMapListByRole]
GO
 
CREATE PROCEDURE [dbo].[sp_GetRoleUserMapListByRole] 
	@roleid NVARCHAR(50),
	@cardanme NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
	
AS
	
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' AND a.RoleId=@roleid '
		 
		IF ISNULL(@cardanme, '') != ''
            SET @filter = @filter + ' AND  CHARINDEX(@cardanme,b.CardName) > 0 '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(a.Id) 
						 FROM LimitRoleUserMap AS a LEFT JOIN UserAccount AS b ON a.UserId=b.Id 
						WHERE 1=1 
						' 
						+@filter
				
                EXEC SP_EXECUTESQL @sql,
                    N'@roleid NVARCHAR(50),@cardanme NVARCHAR(50) ,@rowCount INT OUTPUT'
					,@roleid,@cardanme,@rowCount OUTPUT
 
            END
        ELSE
            SET @rowCount = 0
		--分页取数据	
        SET @sql = '
				SELECT b.CardName,b.PetName,b.Mobile,b.Code,a.RoleId,a.UserId FROM LimitRoleUserMap AS a LEFT JOIN UserAccount AS b ON a.UserId=b.Id 
				WHERE 1=1 ' 
				+@filter+ '
				ORDER BY a.CreateDate
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		

        EXEC SP_EXECUTESQL @sql,
            N'@roleid NVARCHAR(50),@cardanme NVARCHAR(50), @pageIndex INT,@pageSize INT'
			,@roleid,@cardanme,@pageIndex, @pageSize
 PRINT(@sql)
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetScoreHistoryList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetScoreHistoryList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetScoreHistoryList]
    @userId NVARCHAR(50) ,
    @sportId NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' WHERE a.UserId=@userId'   
		IF ISNULL(@sportId,'') !=''
			SET @filter=@filter+ ' AND a.SportId=@sportId'

        DECLARE @sql NVARCHAR(MAX)

		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(Id)+1 FROM UserScoreHistory a '
                    + @filter              
                    
                EXEC SP_EXECUTESQL @sql,
                    N'@userId NVARCHAR(50),@sportId NVARCHAR(50),@rowCount INT OUTPUT',
                    @userId, @sportId, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '(SELECT a.LoopId,a.SportId,a.UserId,a.Score,a.CreateDate,a.Editor,a.IsEdit,a.OldScore,c.Name AS GameName FROM UserScoreHistory AS a 
							LEFT JOIN GameLoop AS b ON a.LoopId=b.Id LEFT JOIN Game AS c ON b.GameId=c.Id '
							+@filter+
							' UNION ALL  
							SELECT NULL AS LoopId,NULL AS SportId,NULL AS UserId,1500 AS Score,CreateDate,cast(0 as NVARCHAR(50)) AS Editor,CAST(0 AS BIT) AS IsEdit, 0 AS OldScore, NULL AS GameName FROM UserAccount WHERE Id=@userId )  '
							+' ORDER BY CreateDate DESC 
							OFFSET (@pageIndex-1)*@pageSize ROWS
				            FETCH NEXT @pageSize ROWS ONLY '
        EXEC SP_EXECUTESQL @sql,
            N'@userId NVARCHAR(50),@sportId NVARCHAR(50),@pageIndex INT,@pageSize INT',
            @userId, @sportId, @pageIndex, @pageSize

    END

GO

-- ----------------------------
-- Procedure structure for sp_GetSealedBootcampList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetSealedBootcampList]
GO
 
CREATE PROCEDURE [dbo].[sp_GetSealedBootcampList] 
	@BootcampName NVARCHAR(200),
	@SealedOrganizationId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
		IF ISNULL(@BootcampName, '') != ''
            SET @filter = @filter + ' AND  a.Name LIKE ''%'+@BootcampName+'%'' '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(*) 
						FROM dbo.CoachBootcamp a
						LEFT JOIN dbo.Venue b ON a.VenueId=b.Id
						WHERE a.SealedOrganizationId=@SealedOrganizationId
						' +@filter
				
                EXEC SP_EXECUTESQL @sql,
                    N'@SealedOrganizationId NVARCHAR(50),@rowCount INT OUTPUT',
                    @SealedOrganizationId,@rowCount OUTPUT

            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
				SELECT 
					a.* ,
					b.Address AS VenueAddress
				FROM dbo.CoachBootcamp a
				LEFT JOIN dbo.Venue b ON a.VenueId=b.Id
				WHERE a.SealedOrganizationId=@SealedOrganizationId
				' +@filter+ '
				ORDER BY a.CreateDate Desc 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@SealedOrganizationId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @SealedOrganizationId,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetSealedOrganizationCoachList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetSealedOrganizationCoachList]
GO
 
CREATE PROCEDURE [dbo].[sp_GetSealedOrganizationCoachList] 
	@CoachName NVARCHAR(200),
	@SealedOrganizationId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
		IF ISNULL(@CoachName, '') != ''
            SET @filter = @filter + ' AND  b.CardName LIKE ''%'+@CoachName+'%'' '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(*) 
						FROM dbo.Coach a
						INNER JOIN dbo.UserAccount b ON a.Id =b.Id 
						WHERE a.SealedOrganizationId=@SealedOrganizationId  ' 
						+@filter
				
                EXEC SP_EXECUTESQL @sql,
                    N'@SealedOrganizationId NVARCHAR(50),@CoachName NVARCHAR(50),@rowCount INT OUTPUT',
                    @SealedOrganizationId,@CoachName ,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
				SELECT 
							a.*,
							b.HeadUrl,
							b.Sex,
							b.CardName AS Name,
							b.Code
				FROM dbo.Coach a
				INNER JOIN dbo.UserAccount b ON a.Id =b.Id 
				WHERE a.SealedOrganizationId=@SealedOrganizationId   ' 
				+@filter+ '
				ORDER BY CreateDate Desc 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@SealedOrganizationId NVARCHAR(50),@CoachName NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @SealedOrganizationId,@CoachName ,
			 @pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetSealedOrganizationList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetSealedOrganizationList]
GO
 
CREATE PROCEDURE [dbo].[sp_GetSealedOrganizationList] 
	@OrganizationName NVARCHAR(200),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
		IF ISNULL(@OrganizationName, '') != ''
            SET @filter = @filter + ' AND  Name LIKE ''%'+@OrganizationName+'%'' '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(*) 
						FROM dbo.CoachOrganization  
						WHERE 1=1 AND OrgType=''Sealed''  ' +@filter
				
                EXEC SP_EXECUTESQL @sql,
                    N'@rowCount INT OUTPUT',
                    @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
				SELECT 
							*,
							ManagerName=dbo.fn_GetUserName(ManagerId)
				FROM dbo.CoachOrganization  
				WHERE 1=1 AND OrgType=''Sealed''   ' +@filter+ '
				ORDER BY CreateDate Desc 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@pageIndex INT,@pageSize INT',
             @pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetSealedStudentList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetSealedStudentList]
GO
 
CREATE PROCEDURE [dbo].[sp_GetSealedStudentList] 
	@StudentName NVARCHAR(200),
	@CoachBootcampId NVARCHAR(50),
	@SealedOrganizationId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
		IF ISNULL(@CoachBootcampId, '') != ''
            SET @filter = @filter + ' AND  a.CoachBootcampId =@CoachBootcampId '
		
		IF ISNULL(@SealedOrganizationId, '') != ''
            SET @filter = @filter + ' AND  a.SealedOrganizationId =@SealedOrganizationId '

		IF ISNULL(@StudentName, '') != ''
            SET @filter = @filter + ' AND  dbo.fn_GetUserName(a.StudentId)  LIKE ''%'+@StudentName+'%'' '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(a.Id) 
						FROM dbo.CoachBootcampStudent a
						LEFT JOIN dbo.UserAccount b ON a.StudentId=b.Id  
						WHERE 1=1 
						' 
						+@filter
				
                EXEC SP_EXECUTESQL @sql,
                    N'@CoachBootcampId NVARCHAR(50)
					,@SealedOrganizationId NVARCHAR(50)
					,@rowCount INT OUTPUT'
					,@CoachBootcampId
					,@SealedOrganizationId
					,@rowCount OUTPUT
                    
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
				SELECT 
						a.*,
						a.StudentId AS UserId,
						b.HeadUrl,
						b.Sex,
						Name=dbo.fn_GetUserName(a.StudentId)
				FROM dbo.CoachBootcampStudent a
				LEFT JOIN dbo.UserAccount b ON a.StudentId=b.Id  
				WHERE 1=1 ' 
				+@filter+ '
				ORDER BY a.CreateDate Desc 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@CoachBootcampId NVARCHAR(50)
			,@SealedOrganizationId NVARCHAR(50)
			,@pageIndex INT,@pageSize INT'
            ,@CoachBootcampId
			,@SealedOrganizationId
			,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetSerialNo
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetSerialNo]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<获取笔记列表>
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

-- ----------------------------
-- Procedure structure for sp_GetSerialNo1
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetSerialNo1]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<获取笔记列表>
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

-- ----------------------------
-- Procedure structure for sp_GetStudentBookList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetStudentBookList]
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

-- ----------------------------
-- Procedure structure for sp_GetStudentBootcampList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetStudentBootcampList]
GO
 
CREATE PROCEDURE [dbo].[sp_GetStudentBootcampList] 
	@StudentId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT  
							@rowCount=COUNT(a.Id) 
						FROM(	
									-- 封闭机构的集训		
									SELECT 
										a.Id
									FROM  dbo.CoachBootcamp a
									INNER JOIN CoachBootcampStudent  b ON a.Id=b.CoachBootcampId
									INNER JOIN dbo.CoachOrganization d ON a.SealedOrganizationId=d.Id
									LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
									WHERE 
										b.StudentId=@StudentId 
									-- 悦动力的集训
									UNION 
									SELECT 
										a.Id
									FROM dbo.CoachBootcamp a
									WHERE a.SealedOrganizationId IS NULL OR a.SealedOrganizationId=''''
										AND a.State!=''Unpublish''
							) a
						' +@filter
				
                EXEC SP_EXECUTESQL @sql,
                    N'@StudentId NVARCHAR(50),@rowCount INT OUTPUT',
                    @StudentId,@rowCount OUTPUT

            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
					SELECT  
						a.*
					FROM(		
								-- 封闭机构的集训			
								SELECT 
										a.*,
										c.Address AS VenueAddress,
										''Sealed'' AS BootcampType
								FROM  dbo.CoachBootcamp a
								INNER JOIN CoachBootcampStudent  b ON a.Id=b.CoachBootcampId
								INNER JOIN dbo.CoachOrganization d ON a.SealedOrganizationId=d.Id
								LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
								WHERE 
									b.StudentId=@StudentId 
								UNION 
								-- 悦动力的集训
								SELECT 
										a.*,
										c.Address AS VenueAddress,
										''YDL'' AS BootcampType
								FROM dbo.CoachBootcamp a
								LEFT JOIN dbo.Venue c  ON a.VenueId=c.Id
								WHERE a.SealedOrganizationId IS NULL OR a.SealedOrganizationId=''''
										AND a.State!=''Unpublish''
						) a		
				' +@filter+ '
				ORDER BY a.CreateDate Desc 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@StudentId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @StudentId,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetStudentList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetStudentList]
GO
CREATE PROCEDURE [dbo].[sp_GetStudentList]
    @keywords NVARCHAR(50) ,
	@venueId NVARCHAR(50),
	@isSign NVARCHAR(5), -- 1:签约，0:未签约
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

		--排除教练
		SET @whereSql = @whereSql + ' AND a.Id NOT IN(SELECT UserId FROM Coach WHERE [State]=''010002'')'


		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(1) FROM UserAccount a LEFT JOIN VenueStudents b ON a.Id=b.UserId' + @whereSql

                EXEC SP_EXECUTESQL @sql,
                    N'@keywords NVARCHAR(50),@venueId NVARCHAR(50),@senderId NVARCHAR(50),@rowCount INT OUTPUT', 
					@keywords,@venueId,@venueId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = 'SELECT a.Id,a.Code,a.PetName,a.CardName,a.HeadUrl,a.Mobile,Sex = CASE Sex WHEN ''1'' THEN ''1,男'' ELSE ''0,女'' END
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

-- ----------------------------
-- Procedure structure for sp_GetStudentMonthPayListByYear
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetStudentMonthPayListByYear]
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

-- ----------------------------
-- Procedure structure for sp_GetStudentMonthStatistics
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetStudentMonthStatistics]
GO
CREATE PROCEDURE [dbo].[sp_GetStudentMonthStatistics]
    @venueId NVARCHAR(50),
    @beginDate DATE,
    @endDate DATE
AS
    BEGIN
        SET NOCOUNT ON;

		--包月
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

-- ----------------------------
-- Procedure structure for sp_GetStudentMyCourse
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetStudentMyCourse]
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据 --先取没有过期的数据,没过期的取完了才取过期的课程	
        SET @sql = '
				--获取所有没过期的数据 插入临时表	 
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
				--调试代码--开始
				--SELECT * FROM #NotExpiredCourseJoin
				--调试代码--结束

				--计算没过期数据有多少页
				DECLARE @NotExpiredPageCount INT 
				SELECT @NotExpiredPageCount=(COUNT(*)+@pageSize-1)/@pageSize FROM #NotExpiredCourseJoin
				
				--开始取数据,  没过期的取完了才取过期的课程
				IF @pageIndex <=@NotExpiredPageCount
				BEGIN
						--从没过期数据中取
						SELECT 
							*
						FROM #NotExpiredCourseJoin
						ORDER BY  EndTime ASC --按课程时间升序排
						OFFSET (@pageIndex-1)*@pageSize ROWS
						FETCH NEXT @pageSize ROWS ONLY
				END
				ELSE	
				BEGIN
					--从过期数据中取
					SET @pageIndex=(@pageIndex-@NotExpiredPageCount); --重置pageIndex

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
					ORDER BY  c.EndTime DESC -- 按课程时间倒序排
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

-- ----------------------------
-- Procedure structure for sp_GetStudentSealedBootcampList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetStudentSealedBootcampList]
GO
 
CREATE PROCEDURE [dbo].[sp_GetStudentSealedBootcampList] 
	@StudentId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(a.Id) 
						 FROM  dbo.CoachBootcamp a
						 INNER JOIN CoachBootcampStudent  b ON a.Id=b.CoachBootcampId
						 LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
						 WHERE 
								b.StudentId=@StudentId 
						' +@filter
				
                EXEC SP_EXECUTESQL @sql,
                    N'@StudentId NVARCHAR(50),@rowCount INT OUTPUT',
                    @StudentId,@rowCount OUTPUT

            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = '
					 
				 SELECT 
					a.*,
					c.Address AS VenueAddress
				 FROM  dbo.CoachBootcamp a
				 INNER JOIN CoachBootcampStudent  b ON a.Id=b.CoachBootcampId
				 LEFT JOIN dbo.Venue c ON a.VenueId=c.Id
				 WHERE 
						b.StudentId=@StudentId 
				' +@filter+ '
				ORDER BY a.CreateDate Desc 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@StudentId NVARCHAR(50),@pageIndex INT,@pageSize INT',
             @StudentId,@pageIndex, @pageSize

		
		
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetStudentsOfBookCourse
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetStudentsOfBookCourse]
GO
CREATE PROCEDURE [dbo].[sp_GetStudentsOfBookCourse] 
	@timeTableId			NVARCHAR(50),
	@curDate				DATETIME,
	@courseId				NVARCHAR(50),
	@incStudentsOfCourse	BIT--包括课程中的学员
AS
    BEGIN
        SET NOCOUNT ON;

		DECLARE @sql NVARCHAR(MAX),@joinSql NVARCHAR(500),@whereSql NVARCHAR(500),@fieldSql NVARCHAR(500)

		--0和1返回到程序中，无法自动转换成布尔类型，因此定义一个布尔参数来赋值
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

-- ----------------------------
-- Procedure structure for sp_GetStudentTimesBalance
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetStudentTimesBalance]
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

-- ----------------------------
-- Procedure structure for sp_GetStudentTimesStatistics
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetStudentTimesStatistics]
GO
CREATE PROCEDURE [dbo].[sp_GetStudentTimesStatistics]
    @venueId NVARCHAR(50),
    @beginDate DATE,
    @endDate DATE
AS
    BEGIN
        SET NOCOUNT ON;

		--按次
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

-- ----------------------------
-- Procedure structure for sp_GetSyllabusTeachingPointList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetSyllabusTeachingPointList]
GO
CREATE PROCEDURE [dbo].[sp_GetSyllabusTeachingPointList]
    @cityCode NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

        --设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'
                        
         
		--获取总行数
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
            
        --获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetTeachingPointCoachList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetTeachingPointCoachList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetTeachingPointCoachList]
    @keywords NVARCHAR(50) ,--帐号，昵称，姓名，手机
	@VenueId NVARCHAR(50),
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' WHERE 1=1 AND c.IsEnabled=1'  
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
                + ' AND (b.Code+b.PetName+b.CardName+ISNULL(b.Mobile,'''') LIKE ''%''+@keywords+''%'')'         

		IF ISNULL(@VenueId, '') != ''
            SET @filter = @filter+ ' AND a.VenueId=@VenueId '
                
        DECLARE @sql NVARCHAR(MAX)

		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetTeachingPointList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetTeachingPointList]
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetTeamsConcessionScore
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetTeamsConcessionScore]
GO
CREATE PROCEDURE [dbo].[sp_GetTeamsConcessionScore]
	@orderId NVARCHAR(50),
    @user1Id NVARCHAR(500),--双打时，由2个ID逗号分割。单打赛，此值为
    @user2Id NVARCHAR(500)
AS
    BEGIN
        SET NOCOUNT ON;

		DECLARE @user1Score INT,@user2Score INT,@concessionScore1 INT,@concessionScore2 INT
		SET @concessionScore1=0
		SET @concessionScore2=0

		DECLARE @gameId NVARCHAR(50),@knockoutOption NVARCHAR(50),@nextOrderId NVARCHAR(50),@isTeam BIT
		SELECT @gameId=GameId,@knockoutOption=KnockoutOption,@nextOrderId=ISNULL(NextOrderId,''),@isTeam=IsTeam FROM GameOrder WHERE Id=@orderId

		--是否是让分比赛
		IF EXISTS(SELECT 1 FROM Game WHERE Id=@gameId AND IsScoreGame=1 AND IsConcessionScore=1)
		BEGIN
			--决赛不让分
			--不是大循环，没有下一轮即为决赛
			IF @knockoutOption='014002' OR ISNULL(@nextOrderId,'')<>''
			BEGIN
				--如果是单打赛，重新取userId
				IF @isTeam=0
				BEGIN
					SELECT @user1Id=TeamUserId FROM GameTeam WHERE Id=@user1Id
					SELECT @user2Id=TeamUserId FROM GameTeam WHERE Id=@user2Id
				END
				

				DECLARE @isDouble INT --是否是双打
				SET @isDouble = CASE CHARINDEX(',',@user1Id) WHEN 0 THEN 0 ELSE 1 END
				
				IF @isDouble=0--单打
				BEGIN
					
					SELECT @user1Score=Score FROM UserSport WHERE UserId=@user1Id
					SELECT @user2Score=Score FROM UserSport WHERE UserId=@user2Id


					IF @user1Score/100>@user2Score/100
					BEGIN
						SET @concessionScore2=ABS(@user1Score/100-@user2Score/100)
						IF @concessionScore2>7
							SET @concessionScore2=7
					END
					ELSE IF @user2Score/100>@user1Score/100
					BEGIN
						SET @concessionScore1=ABS(@user1Score/100-@user2Score/100)
						IF @concessionScore1>7
							SET @concessionScore1=7
					END

				END
				ELSE--双打
				BEGIN
				
					SELECT @user1Score=SUM(Score) FROM UserSport WHERE UserId IN(SELECT Id FROM dbo.fn_Split(@user1Id) WHERE Id<>'')
					SELECT @user2Score=SUM(Score) FROM UserSport WHERE UserId IN(SELECT Id FROM dbo.fn_Split(@user2Id) WHERE Id<>'')

					IF @user1Score/200>@user2Score/200
					BEGIN
						SET @concessionScore2=ABS(@user1Score/200-@user2Score/200)
						IF @concessionScore2>6
							SET @concessionScore2=6
					END
					ELSE IF @user2Score/200>@user1Score/200
					BEGIN
						SET @concessionScore1=ABS(@user1Score/200-@user2Score/200)
						IF @concessionScore1>6
							SET @concessionScore1=6
					END
				END

			END
		END

		SELECT @concessionScore1 AS ConcessionScore1,@concessionScore2 AS ConcessionScore2
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetUser
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetUser]
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

        SELECT
				a.*,
				dbo.fn_Link(b.Id,b.Name) AS CityIdCombine ,
				IsCoacher=CONVERT(BIT, 
						(SELECT COUNT(Id) FROM dbo.Coach WHERE a.id=Id)
				)/*是否为教练*/
        FROM    dbo.UserAccount a
        LEFT JOIN dbo.City b ON a.CityId=b.Id
        WHERE a.Id=@userId
        
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetUserLimitList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetUserLimitList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<获取笔记列表>
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetUserLimitRequestList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetUserLimitRequestList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<获取笔记列表>
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
		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetUserList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetUserList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserList]
    @keywords NVARCHAR(50) ,--帐号，昵称，姓名，手机
    @isAdmin NVARCHAR(50) ,
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' WHERE IsAdmin=' + @isAdmin
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
                + ' AND (Code+PetName+CardName+ISNULL(Mobile,'''') LIKE ''%''+@keywords+''%'')'         

        DECLARE @sql NVARCHAR(MAX)

		--仅仅第一页的时候取行数
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
		
		--分页取数据	
        SET @sql = '
					SELECT 
						a.Id,
						Code,
						PetName,
						CardName,
						HeadUrl,
						Sex,
						Mobile,
						a.Id AS userId,
						b.TypeId AS OrganTypeId,
						b.Name AS OrgName
					FROM UserAccount AS a LEFT JOIN Organization AS b ON a.OrganTypeId=b.TypeId ' 
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

-- ----------------------------
-- Procedure structure for sp_GetUserListForIM
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetUserListForIM]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserListForIM]
    @keywords NVARCHAR(50) ,--帐号，昵称，姓名
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' WHERE 1=1' 
        IF ISNULL(@keywords, '') != ''
            SET @filter = @filter
				-- 注意: 暂时不能开放用手机搜索 , 会搜出多个相同手机号的账号, 因为有的人反复用同一个手机号注册过
                + ' AND (Code+PetName+CardName  LIKE ''%''+@keywords+''%'')'         

        DECLARE @sql NVARCHAR(MAX)

		--仅仅第一页的时候取行数
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
		
		--分页取数据	
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

-- ----------------------------
-- Procedure structure for sp_GetUserScoreHistoryList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetUserScoreHistoryList]
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

		--设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' WHERE a.UserId=@userId AND a.SportId=@sportId'   

        DECLARE @sql NVARCHAR(MAX)

		--仅仅第一页的时候取行数
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
		
		--分页取数据	
        SET @sql = 'SELECT * FROM (SELECT  a.Id ,
        a.UserId ,
        a.SportId ,
        CASE WHEN ISNULL(a.GameId, '''') != '''' 
			THEN dbo.fn_Link(b.Id, b.Name) 
			ELSE ''admin,管理员调整'' 
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

-- ----------------------------
-- Procedure structure for sp_GetUserSignList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetUserSignList]
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
		--获取总行数
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

        --获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetUserSportList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetUserSportList]
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
                a.Score ,
                a.CreateDate ,
                a.UserId
        FROM    UserSport a 
                LEFT JOIN SportType b ON a.SportId = b.Id
                LEFT JOIN BaseData c ON a.ProType = c.Id
                LEFT JOIN BaseData d ON a.GripOption = d.Id
        WHERE   a.UserId = @userId '

        IF ISNULL(@sportId, '') != ''
            SET @sql = @sql + ' AND a.SportId=@sportId'

        EXEC SP_EXECUTESQL @sql, N'@userId NVARCHAR(50),@sportId NVARCHAR(50)',
            @userId, @sportId
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetVenue
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVenue]
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
				Distance=dbo.fn_GetDistance(@curUserLat,@curUserLng,a.Lat,a.Lng),
				a.IsEnabled,
				a.IsEnableTeachingPoint
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

-- ----------------------------
-- Procedure structure for sp_GetVenueDiscountList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVenueDiscountList]
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

-- ----------------------------
-- Procedure structure for sp_GetVenueList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVenueList]
GO
CREATE PROCEDURE [dbo].[sp_GetVenueList]
    @userId NVARCHAR(50) ,
    @isOnlySelf NVARCHAR(50) ,
    @isUseVip NVARCHAR(50) ,
    @name NVARCHAR(50) ,
    @cityCode NVARCHAR(50) ,
	@curUserLng FLOAT,
	@curUserLat FLOAT,
	@isAll BIT , --是否返回全部, 包括已审核和未审核的
	@state NVARCHAR(50)='',
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--取用户管理员标志
        DECLARE @isAdmin BIT
        SELECT  @isAdmin = IsAdmin
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        IF @isAdmin IS NULL
            SET @isAdmin = 0

        --设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' AND IsEnabled=1 '
        IF ISNULL(@name, '') != ''
            SET @filter = @filter + ' AND name LIKE ''%''+@name+''%'''
                        
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'  

        IF ISNULL(@isUseVip, '') != ''
            SET @filter = @filter + ' AND IsUseVip=1'  

        --查看自己创建的全部场馆或者其他通过审核的场馆，管理员查看所有   
        IF @isAdmin = 0
            BEGIN
                IF ISNULL(@isOnlySelf, '') = '1'
                    SET @filter = @filter
                        + ' AND (CreatorId=@userId OR AdminId=@userId 
						OR Id IN ( --消费过的场馆
									SELECT VenueId FROM VipUse WHERE PayState=''024002'' AND UserId=@userId)) '  
                ELSE IF @isAll !=1 --不返回全部
				BEGIN
						IF  ISNULL(@state, '') != ''
							SET @filter = @filter + '  AND State='''+@state+''''  
						ELSE	
							SET @filter = @filter + '  AND State=''010002'''  --不返回全部, 默认返回已审核的

				END
			 
            END

		--获取总行数
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
            
        --获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetVenueListAllForCoacher
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVenueListAllForCoacher]
GO


-- =============================================
-- 业务逻辑:  获取所有场馆列表(包括审核的和未审核的), 并且自己创建的排在前面, 用于教练申请界面
-- 注意: 更改代码, 请同步更新业务逻辑注释
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
		 
		--取用户管理员标志
        DECLARE @isAdmin BIT
        SELECT  @isAdmin = IsAdmin
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        IF @isAdmin IS NULL
            SET @isAdmin = 0

        --设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' AND IsEnabled=1 '
        IF ISNULL(@name, '') != ''
            SET @filter = @filter + ' AND name LIKE ''%''+@name+''%'''
                        
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'  

        IF ISNULL(@isUseVip, '') != ''
            SET @filter = @filter + ' AND IsUseVip=1'  
		--设置 距离条件
		DECLARE @distanceFilter NVARCHAR(MAX)
		SET @distanceFilter=''
		IF ISNULL(@Distance, 0) != 0
            SET @distanceFilter = @distanceFilter + ' AND Distance<@Distance'  
	
        --查看自己创建的全部场馆或者其他通过审核的场馆，管理员查看所有   
        IF @isAdmin = 0
            BEGIN
                IF ISNULL(@isOnlySelf, '') = '1'
                    SET @filter = @filter
                        + ' AND (CreatorId=@userId OR AdminId=@userId 
						OR Id IN ( --消费过的场馆
									SELECT VenueId FROM VipUse WHERE PayState=''024002'' AND UserId=@userId)) '  
               
            END

		--获取总行数
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

        --首先--根据查询条件获取分页数据, 并将数据放到 #VenueList 临时表---开始
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
			INTO #VenueList /*根据查询条件将这一页数据放到临时表*/
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
								WHERE 1=1 AND CreatorId !=@creatorId /*先剔除掉我的场地,后面再获取*/ ' + @filter +'
							) z
					WHERE  1=1  '  +@distanceFilter+ 
			'
            ) a 
			INNER JOIN City b ON a.CityId=b.Id
			INNER JOIN BaseData c ON a.State=c.Id
			INNER JOIN SportType s ON s.Id = a.SportId
 			WHERE RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize
			--调试SQL
			--SELECT * FROM #VenueList
			'
	    --首先--根据查询条件获取分页数据, 并将数据放到 #VenueList 临时表-------结束

        	 
		--然后--如果是第一页,就拼凑一坨自己创建的场馆数据, 并且放在最前面-------开始
		IF	@pageIndex=1
		BEGIN
			SET @sql+='
			INSERT INTO #VenueList  /*追加我创建的场地到临时表, 在之前临时表里面已有一页数据*/
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
		--然后--如果是第一页,就拼凑一坨自己创建的场馆数据, 并且放在最前面-------结束

		--最后--开始出数据,将我创建的场地order by 到最前面
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

-- ----------------------------
-- Procedure structure for sp_GetVenueListForAudit
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVenueListForAudit]
GO
CREATE PROCEDURE [dbo].[sp_GetVenueListForAudit]
    @userId NVARCHAR(50) ,
    @isOnlySelf NVARCHAR(50) ,
    @isUseVip NVARCHAR(50) ,
    @name NVARCHAR(50) ,
    @cityCode NVARCHAR(50) ,
	@curUserLng FLOAT,
	@curUserLat FLOAT,
	@isAll BIT , --是否返回全部, 包括已审核和未审核的
	@state NVARCHAR(50)='',
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--取用户管理员标志
        DECLARE @isAdmin BIT
        SELECT  @isAdmin = IsAdmin
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        IF @isAdmin IS NULL
            SET @isAdmin = 0

        --设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter =' AND IsEnabled=1 '
        IF ISNULL(@name, '') != ''
            SET @filter = @filter + ' AND name LIKE ''%''+@name+''%'''
                        
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'  

        IF ISNULL(@isUseVip, '') != ''
            SET @filter = @filter + ' AND IsUseVip=1'  

      
        IF ISNULL(@isOnlySelf, '') = '1'
            SET @filter = @filter
                + ' AND (CreatorId=@userId OR AdminId=@userId 
				OR Id IN ( --消费过的场馆
							SELECT VenueId FROM VipUse WHERE PayState=''024002'' AND UserId=@userId)) '  
        ELSE IF @isAll !=1 --不返回全部
		BEGIN
				IF  ISNULL(@state, '') != ''
					SET @filter = @filter + '  AND State='''+@state+''''  
				ELSE	
					SET @filter = @filter + '  AND State=''010002'''  --不返回全部, 默认返回已审核的

		END
			 
       

		--获取总行数
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
            
        --获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetVenueListForGraph
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVenueListForGraph]
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
		 
		--取用户管理员标志
        DECLARE @isAdmin BIT
        SELECT  @isAdmin = IsAdmin
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        IF @isAdmin IS NULL
            SET @isAdmin = 0

        --设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ''
		SET @filter=@filter+' AND State=''010002'' '
        IF ISNULL(@name, '') != ''
            SET @filter = @filter + ' AND name LIKE ''%''+@name+''%'''
                        
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'  

        IF ISNULL(@isUseVip, '') != ''
            SET @filter = @filter + ' AND IsUseVip=1'  
		--设置 距离条件
		DECLARE @distanceFilter NVARCHAR(MAX)
		SET @distanceFilter=''
		IF ISNULL(@Distance, 0) != 0
            SET @distanceFilter = @distanceFilter + ' AND Distance<@Distance'  
	
        --查看自己创建的全部场馆或者其他通过审核的场馆，管理员查看所有   
        IF @isAdmin = 0
            BEGIN
                IF ISNULL(@isOnlySelf, '') = '1'
                    SET @filter = @filter
                        + ' AND (CreatorId=@userId OR AdminId=@userId 
						OR Id IN ( --消费过的场馆
									SELECT VenueId FROM VipUse WHERE PayState=''024002'' AND UserId=@userId)) '  
               
            END

		--获取总行数
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
            
        --获取每页数据
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
			--调试SQL
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

-- ----------------------------
-- Procedure structure for sp_GetVenueListForTeachingPoint
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVenueListForTeachingPoint]
GO
CREATE PROCEDURE [dbo].[sp_GetVenueListForTeachingPoint]
    @userId NVARCHAR(50) ,
    @isOnlySelf NVARCHAR(50) ,
    @isUseVip NVARCHAR(50) ,
    @name NVARCHAR(50) ,
    @cityCode NVARCHAR(50) ,
	@curUserLng FLOAT,
	@curUserLat FLOAT,
	@isAll BIT , --是否返回全部, 包括已审核和未审核的
	@state NVARCHAR(50)='',
    @pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
AS
    BEGIN
        SET NOCOUNT ON;

		--取用户管理员标志
        DECLARE @isAdmin BIT
        SELECT  @isAdmin = IsAdmin
        FROM    dbo.UserAccount
        WHERE   Id = @userId

        IF @isAdmin IS NULL
            SET @isAdmin = 0

        --设置条件
        DECLARE @filter NVARCHAR(MAX)
        SET @filter = ' AND IsEnabled=1 '
        IF ISNULL(@name, '') != ''
            SET @filter = @filter + ' AND name LIKE ''%''+@name+''%'''
                        
        IF ISNULL(@cityCode, '') != ''
            SET @filter = @filter + ' AND CityId=@cityCode'  

        IF ISNULL(@isUseVip, '') != ''
            SET @filter = @filter + ' AND IsUseVip=1'  

        --查看自己创建的全部场馆或者其他通过审核的场馆，管理员查看所有   
        IF @isAdmin = 0
            BEGIN
                IF ISNULL(@isOnlySelf, '') = '1'
                    SET @filter = @filter
                        + ' AND (CreatorId=@userId OR AdminId=@userId 
						OR Id IN ( --消费过的场馆
									SELECT VenueId FROM VipUse WHERE PayState=''024002'' AND UserId=@userId)) '  
                ELSE IF @isAll !=1 --不返回全部
				BEGIN
						IF  ISNULL(@state, '') != ''
							SET @filter = @filter + '  AND State='''+@state+''''  
						ELSE	
							SET @filter = @filter + '  AND State=''010002'''  --不返回全部, 默认返回已审核的

				END
			 
            END

		--获取总行数
        DECLARE @sql NVARCHAR(MAX);
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Venue WHERE 1=1 AND IsEnableTeachingPoint=1'
                    + @filter
                EXEC SP_EXECUTESQL @sql,
                    N'@name NVARCHAR(50),@cityCode NVARCHAR(50),@userId NVARCHAR(50),@rowCount INT OUTPUT',
                    @name, @cityCode, @userId, @rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
            
        --获取每页数据
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
								FROM Venue WHERE 1=1 AND IsEnableTeachingPoint=1 ' + @filter +'
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

-- ----------------------------
-- Procedure structure for sp_GetVenueSignList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVenueSignList]
GO
--指定机构的签约或未签约场馆
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

		--获取总行数
        IF @pageIndex = 1
            BEGIN
                SET @sql = 'SELECT @rowCount=COUNT(*) FROM Venue a LEFT JOIN CompanyVenues b ON a.Id=b.VenueId WHERE a.State=''010002''' + @whereSql       

                EXEC SP_EXECUTESQL @sql,
                    N'@companyId NVARCHAR(50),@name NVARCHAR(50),@rowCount INT OUTPUT',
                    @companyId,@name,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
           



		

        --获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetVenueTimetablesList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVenueTimetablesList]
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

-- ----------------------------
-- Procedure structure for sp_GetVipAccount
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipAccount]
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
                                  OR PayState = '024003'--待支付或者支付失败的
                                )
                ) AS PayCount,
				( SELECT    COUNT(*)
                  FROM      dbo.VipUse
                  WHERE     CreatorId = b.Id
                            AND ( PayState = '024001'
                                  OR PayState = '024003'--待支付或者支付失败的
                                )
                ) AS PayUseCount
        FROM    dbo.UserAccount b
                LEFT JOIN VipAccount a ON b.Id = a.Id
        WHERE   b.Id = @userId
    END

GO

-- ----------------------------
-- Procedure structure for sp_GetVipAccountList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipAccountList]
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

		--获取总行数
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

		--获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetVipBuy
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipBuy]
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

-- ----------------------------
-- Procedure structure for sp_GetVipBuyList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipBuyList]
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

		--设置条件
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

		--获取总行数
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

		--获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetVipCityDiscount
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipCityDiscount]
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

-- ----------------------------
-- Procedure structure for sp_GetVipCostScaleList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipCostScaleList]
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

-- ----------------------------
-- Procedure structure for sp_GetVipDayBook
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipDayBook]
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

		--仅仅第一页的时候取行数
        IF @pageIndex = 1
            BEGIN
                SELECT  @rowCount = ISNULL(@rowCount, 0) + COUNT(*)
                FROM    dbo.VipBuy
                WHERE   UserId = @userId--真实账户人
                        AND PayState = '024002'

                SELECT  @rowCount = ISNULL(@rowCount, 0) + COUNT(*)
                FROM    dbo.VipUse
                WHERE   CreatorId = @userId--支付人
                        AND PayState = '024002'

                SELECT  @rowCount = ISNULL(@rowCount, 0) + COUNT(*)
                FROM    dbo.VipRefund
                WHERE   UserId = @userId --退款人
            END
        ELSE
            SET @rowCount = 0
		
		--分页取数据	
        SET @sql = 'SELECT b.Id,b.MasterType,b.Amount,b.OtherAmount,b.PayDate,
						dbo.fn_link(c.Id,c.CardName) AS UserId,
						dbo.fn_link(d.Id,d.Name) AS PayOption 
			FROM (SELECT  a.*,ROW_NUMBER() OVER(ORDER BY PayDate DESC) AS RowNumber
			FROM    ( SELECT    Id ,
                    ''016011,充值'' AS MasterType ,
					PayOption,
                    Amount + ISNULL(GiveAmount, 0)  AS Amount,
                    ISNULL(GiveAmount, 0) AS OtherAmount ,
                    UserId ,
                    PayDate
            FROM      dbo.VipBuy
            WHERE     PayState = ''024002'' AND UserId=@userId

            UNION ALL

            SELECT    Id ,
                    ''016007,消费'' ,
					PayOption,
                    Amount ,
                    0 ,
                    CreatorId ,
                    PayDate
            FROM      dbo.VipUse
            WHERE     PayState = ''024002'' AND CreatorId=@userId

            UNION ALL

            SELECT    Id ,
                    ''016006,退款'' ,
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

-- ----------------------------
-- Procedure structure for sp_GetVipDiscount
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipDiscount]
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

-- ----------------------------
-- Procedure structure for sp_GetVipDiscountList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipDiscountList]
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
		--获取总行数
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

		--获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetVipInnerDiscount
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipInnerDiscount]
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

-- ----------------------------
-- Procedure structure for sp_GetVipInnerDiscountList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipInnerDiscountList]
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
		--获取总行数
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

		--获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetVipRefund
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipRefund]
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

-- ----------------------------
-- Procedure structure for sp_GetVipRefundList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipRefundList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- 获取退款单据列表
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
		--设置条件
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
		--获取总行数
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

		--获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetVipUse
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipUse]
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

-- ----------------------------
-- Procedure structure for sp_GetVipUseList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipUseList]
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
		--设置条件
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
		--获取总行数
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

		--获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetVipVenueBill
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipVenueBill]
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

-- ----------------------------
-- Procedure structure for sp_GetVipVenueBillDetailList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipVenueBillDetailList]
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
		--获取总行数
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

		--获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_GetVipVenueBillList
-- ----------------------------
DROP PROCEDURE [dbo].[sp_GetVipVenueBillList]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- 获取内部场馆结算单据列表
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
		--获取总行数
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

		--获取每页数据
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

-- ----------------------------
-- Procedure structure for sp_InsertGameJudge
-- ----------------------------
DROP PROCEDURE [dbo].[sp_InsertGameJudge]
GO
 
CREATE PROCEDURE [dbo].[sp_InsertGameJudge] 
	@GameId NVARCHAR(200)
AS
    BEGIN

 
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'3df24718e7364591ab65a87e0101064e',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'703a3e27bb5c4273a2aba87e01369390',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'d458198f8ff94778a45ea87e0134a5c1',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'da38a940fe384d0eb979a87e010483db',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'f98ceeb1e9784a019989a87e01363b02',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'878dd7ca1f9e46bc8bfea87e01032a8a',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'ba9fc81fb3434149b527a87e01042c0b',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'103e104fc4ca4b398ceca87e01373370',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'cb6794a60b5344f1ac54a87e013781ad',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'aaa2ebd509b349918a58a87e01363359',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'b319afa28a574f53a274a87e013690fc',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'50f1771cee5342b5a42ea87e010c42b2',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'5e44c7d071924c59bdc4a87e0135c769',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'6bed0eaacac1496ab6efa87e01038ef4',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'a8b8f97f8b434d68ad46a87e01038319',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'2a524c7fe4444ec18506a87e0137cd14',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'7e8d20558c6441c79ee1a87e0135165d',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'38c0860742fc44718ea5a87e0135eb66',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'65fbdb99722042d791f7a87e010c52bc',GETDATE())
 INSERT INTO [dbo].[GameJudge]([Id],[GameId],[UserId],[CreateDate]) VALUES(NEWID(),@GameId,'ebe24b681687482db768a87e01371a52',GETDATE())
  
		
		 
		
   END

GO

-- ----------------------------
-- Procedure structure for sp_QueryBillReport
-- ----------------------------
DROP PROCEDURE [dbo].[sp_QueryBillReport]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_QueryBillReport]
    @isPayDate BIT ,--是否付款日期
    @hasNoPay BIT ,--是否包含未付款
    @beginDate DATE ,--开始日期
    @endDate DATE ,--结束日期
    @companyId NVARCHAR(50) ,--公司编号
    @venueId NVARCHAR(50)--场馆编号
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
                                 ELSE ''总计''
                            END AS CompanyId ,
                            CASE WHEN GROUPING(b.Id) = 0 THEN b.Id
                                 WHEN GROUPING(x.CompanyId) = 1 THEN ''''
                                 ELSE ''合计''
                            END AS VenueId ,
                            CASE WHEN GROUPING(a.CostTypeId) = 0
                                 THEN a.CostTypeId
                                 WHEN GROUPING(b.Id) = 1 THEN ''''
                                 ELSE ''小计''
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

-- ----------------------------
-- Procedure structure for sp_QueryRechargeReport
-- ----------------------------
DROP PROCEDURE [dbo].[sp_QueryRechargeReport]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_QueryRechargeReport]
    @year INT ,--年份
    @beginMonth INT ,--开始月
    @endMonth INT --结束月
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX)
        SET @sql = '
		SELECT  CASE WHEN GROUPING(MONTH(PayDate)) = 1 THEN ''合计'' ELSE CAST(MONTH(PayDate) AS NVARCHAR(10)) + ''月'' END AS MONTH ,
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

-- ----------------------------
-- Procedure structure for sp_RemoveVenueTimetables
-- ----------------------------
DROP PROCEDURE [dbo].[sp_RemoveVenueTimetables]
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
			SET @errMsg='此课程时段已在使用中，无法删除。'
		END
		ELSE
			DELETE FROM CoachVenueTimetables WHERE Id=@Id

    END

GO

-- ----------------------------
-- Procedure structure for sp_ReserveCourseAddSubOne
-- ----------------------------
DROP PROCEDURE [dbo].[sp_ReserveCourseAddSubOne]
GO
 
CREATE PROCEDURE [dbo].[sp_ReserveCourseAddSubOne]
    @StudentUserId NVARCHAR(50) ,
	@CoachId NVARCHAR(50) ,
    @BigCourseId NVARCHAR(50) ,
	@CourseTypeId NVARCHAR(50) ,
	@CityId VARCHAR(50),
	@Type VARCHAR(50),--Add 为增加一次, Sub 为减少一次
    @message NVARCHAR(200) OUTPUT

AS
    BEGIN
		DECLARE @Id NVARCHAR(50)/*余额记录id*/ ,@sql NVARCHAR(MAX)
		SET @sql=''
	  
		IF	@CourseTypeId='027001' --大课
		BEGIN
			--找到没过期的, 剩余次数大于0的, 过期时间最小的那条数据 
			SET @sql+='
			SELECT
				TOP 1
				@Id=Id
 			FROM CoachStudentMoney 
			WHERE BigCourseInfoId=@BigCourseId  
				AND  StudentUserId=@StudentUserId AND Amount>=0 
				AND Deadline>GETDATE() 
		    ORDER BY Deadline
			' 
			 EXEC SP_EXECUTESQL @sql,
            N'@CityId NVARCHAR(50),@CoachId NVARCHAR(50),@StudentUserId NVARCHAR(50),
			@BigCourseId NVARCHAR(50),@Id NVARCHAR(50) OUTPUT',
             @CityId,@CoachId, @StudentUserId,@BigCourseId,@Id OUTPUT

		END 
		ELSE IF @CourseTypeId='027003' --私教
		BEGIN
			--剩余次数大于0的, 最老的购买记录 
			SET @sql+='
			SELECT
				TOP 1
				@Id=Id
 			FROM CoachStudentMoney 
			WHERE CoachId=@CoachId  
				AND  StudentUserId=@StudentUserId AND Amount>=0 
		    ORDER BY CreateDate
			' 
			 EXEC SP_EXECUTESQL @sql,
            N'@CityId NVARCHAR(50),@CoachId NVARCHAR(50),@StudentUserId NVARCHAR(50),
			@BigCourseId NVARCHAR(50),@Id NVARCHAR(50) OUTPUT',
             @CityId,@CoachId, @StudentUserId,@BigCourseId,@Id OUTPUT
		END 

		IF	ISNULL(@Id,'')!='' --有次数
		BEGIN
			IF	@Type='Sub'
			BEGIN
				UPDATE dbo.CoachStudentMoney SET Amount=Amount-1 WHERE Id=@Id
			END
			ELSE IF @Type='Add'
			BEGIN 
				UPDATE dbo.CoachStudentMoney SET Amount=Amount+1 WHERE Id=@Id
			END
            
		END
		ELSE	
		BEGIN
				RAISERROR('没有找到可以增加或减少余额的记录',11,1)
		END
		 
		--PRINT @Id

		
    END

GO

-- ----------------------------
-- Procedure structure for sp_ReserveCourseSubOne
-- ----------------------------
DROP PROCEDURE [dbo].[sp_ReserveCourseSubOne]
GO
 
CREATE PROCEDURE [dbo].[sp_ReserveCourseSubOne]
    @StudentUserId NVARCHAR(50) ,
	@CoachId NVARCHAR(50) ,
    @BigCourseId NVARCHAR(50) ,
	@CourseTypeId NVARCHAR(50) ,
	@CityId VARCHAR(50),
    @message NVARCHAR(200) OUTPUT

AS
    BEGIN
		DECLARE @Id NVARCHAR(50)/*余额记录id*/ ,@sql NVARCHAR(MAX)
		SET @sql=''
	 
		BEGIN TRY
		IF	@CourseTypeId='027001' --大课
		BEGIN
			--找到没过期的, 剩余次数大于0的, 过期时间最小的那条数据, 来进行扣除一次
			SET @sql+='
			SELECT
				TOP 1
				@Id=Id
 			FROM CoachStudentMoney 
			WHERE BigCourseInfoId=@BigCourseId  
				AND  StudentUserId=@StudentUserId AND Amount>0 
				AND Deadline>GETDATE() 
		    ORDER BY Deadline
			' 
			 EXEC SP_EXECUTESQL @sql,
            N'@CityId NVARCHAR(50),@CoachId NVARCHAR(50),@StudentUserId NVARCHAR(50),
			@BigCourseId NVARCHAR(50),@Id NVARCHAR(50) OUTPUT',
             @CityId,@CoachId, @StudentUserId,@BigCourseId,@Id OUTPUT

		END 
		ELSE IF @CourseTypeId='027003' --私教
		BEGIN
			--剩余次数大于0的, 最老的购买记录, 来进行扣除一次
			SET @sql+='
			SELECT
				TOP 1
				@Id=Id
 			FROM CoachStudentMoney 
			WHERE CoachId=@CoachId  
				AND  StudentUserId=@StudentUserId AND Amount>0 
		    ORDER BY CreateDate
			' 
			 EXEC SP_EXECUTESQL @sql,
            N'@CityId NVARCHAR(50),@CoachId NVARCHAR(50),@StudentUserId NVARCHAR(50),
			@BigCourseId NVARCHAR(50),@Id NVARCHAR(50) OUTPUT',
             @CityId,@CoachId, @StudentUserId,@BigCourseId,@Id OUTPUT
		END 

		IF	ISNULL(@Id,'')!='' --有次数
		BEGIN
			--次数减一
			UPDATE dbo.CoachStudentMoney SET Amount=Amount-1 WHERE Id=@Id
		END
		ELSE	--次数为0
		BEGIN
				RAISERROR('你的余额次数为0,请充值',11,1)
		END

		END TRY

        BEGIN CATCH
            SET @message = ERROR_MESSAGE()
        END CATCH
		--PRINT @Id

		
    END

GO

-- ----------------------------
-- Procedure structure for sp_ResetGameLoop
-- ----------------------------
DROP PROCEDURE [dbo].[sp_ResetGameLoop]
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
				--删除团体对阵
                DELETE  dbo.GameLoopMap
                WHERE   LoopId = @loopId

				--删除比分
                DELETE  dbo.GameLoopDetail
                WHERE   LoopId = @loopId

				--更新为初始状态
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

-- ----------------------------
-- Procedure structure for sp_SaveCity
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveCity]
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

-- ----------------------------
-- Procedure structure for sp_SaveClubRequest
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveClubRequest]
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
                RAISERROR('已经创建了加入申请，请等待俱乐部管理员处理。',11,1)

            IF EXISTS ( SELECT  *
                        FROM    ClubUser
                        WHERE   ClubId = @clubId
                                AND UserId = @userId )
                RAISERROR('已经是俱乐部成员，请刷新界面。',11,1)

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

-- ----------------------------
-- Procedure structure for sp_SaveCoachCourseJoin
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveCoachCourseJoin]
GO
 
CREATE PROCEDURE [dbo].[sp_SaveCoachCourseJoin]
    @StudentUserId NVARCHAR(50) ,
	@CoacherUserId NVARCHAR(50) ,
    @CourseId NVARCHAR(50) ,
	@CityId NVARCHAR(50),
	@Type NVARCHAR(10), -- Join 为报名, NotJoin 为取消报名
    @message NVARCHAR(200) OUTPUT,
	@ThenCourseUnitPrice DECIMAL(18,2) OUTPUT  --学员报名 当时的课程单价

AS
    BEGIN
		DECLARE @Id NVARCHAR(50) ,@sql NVARCHAR(MAX)
		SET @sql=''
        --找到我要报名的课程类型(大课还是私教...)
		DECLARE @CourseTypeId NVARCHAR(50)
		SELECT @CourseTypeId=Type FROM dbo.CoachCourse WHERE Id=@CourseId

		--找到我的余额记录
		SET @sql+='
			SELECT * INTO #CoacherStudentMoney
			FROM dbo.CoachStudentMoney 
			WHERE  StudentUserId=@StudentUserId AND CityId=@CityId
		'
		IF	@CourseTypeId='027003'  -- 私教才去匹配教练字段, 大课不用
			SET @sql+='   AND CoachId=@CoacherUserId  '


		
		BEGIN TRY
		IF @Type='Join' 
		----------------------------------------------报名 次数减一 ------------开始---------------------------------
		BEGIN
			--找到没过期的, 剩余次数大于0的, 过期时间最小的那条数据, 当前城市的, 来进行扣除一次
			SET @sql+='
			SELECT
				TOP 1
				@Id=Id
 			FROM #CoacherStudentMoney 
			WHERE CourseTypeId=@CourseTypeId  AND Amount>0 AND CityId=@CityId
			'
			IF	@CourseTypeId!='027003'  --私教没有 有效期限制 , 大课有
				SET @sql+=' AND Deadline>GETDATE() '
			
			SET @sql+='
		    ORDER BY Deadline
			' 
			SET @sql +=' DROP TABLE #CoacherStudentMoney  '

			 EXEC SP_EXECUTESQL @sql,
            N'@CityId NVARCHAR(50),@CoacherUserId NVARCHAR(50),@StudentUserId NVARCHAR(50),
			@CourseTypeId NVARCHAR(50),@Id NVARCHAR(50) OUTPUT',
             @CityId,@CoacherUserId, @StudentUserId,@CourseTypeId,@Id OUTPUT

			
			IF	ISNULL(@Id,'')!='' --有次数
			BEGIN
				--次数减一
				UPDATE dbo.CoachStudentMoney SET Amount=Amount-1 WHERE Id=@Id
				--计算报名这节课时的消费单价 =当时购买总价/总次数  , 供后面教练收入统计用  ---开始
				SELECT @ThenCourseUnitPrice=ThenMoney/ThenTotalAmount 
				FROM dbo.CoachStudentMoney WHERE Id=@Id
				----将当时的课程单价 更新到报名记录上
				--UPDATE dbo.CoachCourseJoin SET ThenCourseUnitPrice=@ThenCourseUnitPrice 
				--WHERE CourseId=@CourseId AND StudentId=@StudentUserId 
				--计算报名这节课时的消费单价 =当时购买总价/总次数  , 供后面教练收入统计用  ---结束
			END
			ELSE	--次数为0
			BEGIN
					RAISERROR('你的余额次数为0,请充值',11,1)
			END


		----------------------------------------------报名 次数减一 ------------结束---------------------------------
		END
		ELSE 
		----------------------------------------------取消报名  次数加一 ------------开始---------------------------------
		BEGIN
			--找到没过期的, 过期时间最小的那条数据 来加一次
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
				--RAISERROR('你的余额已过期,本次取消报名操作,不会返回次数到你的过期账户',11,1)

			---调试代码----------开始		
			--SELECT
			--	TOP 1
			-- *
 		--		FROM #CoacherStudentMoney 
			--WHERE CourseTypeId=@CourseTypeId AND Deadline>GETDATE()
			--ORDER BY Deadline  
			---调试代码----------结束
					
		END
		----------------------------------------------取消报名  次数加一 ------------结束---------------------------------
 

		END TRY

        BEGIN CATCH
            SET @message = ERROR_MESSAGE()
        END CATCH
		--PRINT @Id

		
    END

GO

-- ----------------------------
-- Procedure structure for sp_SaveCourseAutoBookSettings
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveCourseAutoBookSettings]
GO
CREATE PROCEDURE [dbo].[sp_SaveCourseAutoBookSettings] 
    @userId			NVARCHAR(50),
	@venueId		NVARCHAR(50),
	@itemXML		TEXT--自动预约课程时间
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

		--解析XML
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

-- ----------------------------
-- Procedure structure for sp_SaveGameGroupLeader
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveGameGroupLeader]
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
		--更新小组本身字段
        UPDATE  dbo.GameGroup
        SET     LeaderId = @leaderId ,
                TableNo = @tableNo
        WHERE   Id = @groupId

		--更新小组比赛副裁
        UPDATE  dbo.GameLoop
        SET     JudgeId = @leaderId
        WHERE   GroupId = @groupId
    END

GO

-- ----------------------------
-- Procedure structure for sp_SaveMsgReg
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveMsgReg]
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

-- ----------------------------
-- Procedure structure for sp_SaveNoteSupport
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveNoteSupport]
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

-- ----------------------------
-- Procedure structure for sp_SaveOrg
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveOrg]
GO
 
CREATE PROCEDURE [dbo].[sp_SaveOrg] 
	@name NVARCHAR(50) ,
	@typeId NVARCHAR(50),
    @parenetTypeId NVARCHAR(50)
	
AS
	
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = '  '

        DECLARE @sql NVARCHAR(MAX)
		---增加机构
		INSERT dbo.Organization
		        ( Id,
				  Name ,
		          TypeId ,
		          ParentTypeId ,
		          IsDefault ,
		          SonCounter ,
		          SonAmount ,
		          CreateDate
		        )
		VALUES  ( NEWID(),
				 @name , -- Name - nvarchar(50)
		          @typeId, -- TypeId - varchar(50)
		          @parenetTypeId , -- ParentTypeId - varchar(50)
		          0 , -- IsDefault - bit
		          0 , -- SonCounter - int
		          0 , -- SonAmount - int
		          GETDATE()  -- CreateDate - datetime
		        )

		---修改上级的计数器和子级数量
		UPDATE dbo.Organization SET SonCounter=SonCounter+1,SonAmount=SonAmount+1 WHERE TypeId=@parenetTypeId

    END

GO

-- ----------------------------
-- Procedure structure for sp_SaveQuickUser
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveQuickUser]
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
    @message NVARCHAR(200) OUTPUT,
	@WeiXinUnionId NVARCHAR(500) ,
	@QQOpenId NVARCHAR(500)
AS
    BEGIN
		--更新系统号
        UPDATE  dbo.Config
        SET     MaxID = MaxID + 1

        DECLARE @code NVARCHAR(50)
        SELECT  @code = CAST(MaxID AS NVARCHAR(50))
        FROM    dbo.Config

        SET @userCode = @code
		--创建用户信息
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
                  CreateDate,
				  WeiXinUnionId,
				  QQOpenId
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
                  GETDATE(),  -- CreateDate - datetime
				  @WeiXinUnionId,
				  @QQOpenId
		        )
		--创建默认权限
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
		--创建默认运动爱好
        INSERT  dbo.UserSport
                ( Id ,
                  UserId ,
                  SportId ,
                  IsActive ,
                  ProType ,
                  GripOption ,
                  Score ,
				  DefaultScore ,
                  CreateDate
						
                )
        VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                  @userId , -- UserId - nvarchar(50)
                  N'474C2709-325E-49F7-AB66-A676C40B2EA6' , -- SportId - nvarchar(50)
                  0 , -- IsActive - bit
                  N'001002' , -- ProType - nvarchar(50)
                  N'002001' , -- GripOption - nvarchar(50)
                  1500 , -- Score - int
				  1500 ,
                  GETDATE()  -- CreateDate - datetime
						
                )

    END

GO

-- ----------------------------
-- Procedure structure for sp_SaveUserSport
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveUserSport]
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
	@Editor NVARCHAR(50),
    @actionCode INT ,
    @message NVARCHAR(200) OUTPUT
AS
    BEGIN   
		--验证新建，修改
        IF ( @actionCode = 1
             OR @actionCode = 2
           )
            AND EXISTS ( SELECT *
                         FROM   dbo.UserSport
                         WHERE  Id != ISNULL(@Id, '')
                                AND UserId = @UserId
                                AND SportId = @SportId )
            BEGIN
                SET @message = '运动爱好已存在。'
                RETURN
            END

		--更新数据
        IF @actionCode = 1
			--新建--
            INSERT  dbo.UserSport
                    ( Id ,
                      UserId ,
                      SportId ,
                      IsActive ,
                      ProType ,
                      GripOption ,
                      Score ,
					  DefaultScore ,
                      CreateDate
			        )
            VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                      @UserId , -- UserId - nvarchar(50)
                      @SportId , -- SportId - nvarchar(50)
                      @IsActive , -- IsActive - bit
                      @ProType , -- ProType - nvarchar(50)
                      @GripOption , -- GripOption - nvarchar(50)
                      @Score , -- Score - int
					  @Score ,
                      GETDATE()  -- CreateDate - datetime
			        )
        ELSE
            IF @actionCode = 2
                BEGIN
			--更新--
                    DECLARE @oldScore INT
                    SELECT  @oldScore = Score
                    FROM    dbo.UserSport
                    WHERE   Id = @Id


					--记录积分变动记录
                    IF @oldScore != @Score
					BEGIN
						UPDATE  UserSport
						SET     UserId = @UserId ,
								SportId = @SportId ,
								IsActive = @IsActive ,
								ProType = @ProType ,
								GripOption = @GripOption ,
								Score = @Score ,
								DefaultScore = @Score
						WHERE   Id = @Id

                        INSERT  dbo.UserScoreHistory
                                ( Id ,
                                  UserId ,
                                  SportId ,
                                  GameId ,
                                  LoopId ,
								  MapId ,
                                  Score ,
								  OldScore ,
                                  CreateDate,
								  IsEdit,
								  Editor
								 )
                        VALUES  ( CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
                                  @UserId , -- UserId - nvarchar(50)
                                  @SportId , -- SportId - nvarchar(50)
                                  N'' , -- GameId - nvarchar(50)
                                  N'' , -- LoopId - nvarchar(50)
								  N'' ,
                                  @Score , -- Score - int
								  @oldScore ,
                                  GETDATE(),  -- CreateDate - datetime
								  1,
								  @Editor
								 )
					END
					ELSE
					BEGIN
						UPDATE  UserSport
						SET     UserId = @UserId ,
								SportId = @SportId ,
								IsActive = @IsActive ,
								ProType = @ProType ,
								GripOption = @GripOption 
						WHERE   Id = @Id
					END
                END
            ELSE
                IF @actionCode = 3
				--删除--
                    DELETE  dbo.UserSport
                    WHERE   Id = @Id
			

    END


GO

-- ----------------------------
-- Procedure structure for sp_SaveVenueBillPay
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveVenueBillPay]
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
                SET @message = '单据已经不存在。'
                RETURN
            END
        ELSE
            IF @state = '024002'
                BEGIN
                    SET @message = '单据已经支付。'
                    RETURN
                END
            ELSE
                BEGIN
				    --更新订单记录
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

-- ----------------------------
-- Procedure structure for sp_SaveVenueDiscount
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveVenueDiscount]
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
		--验证新建，修改
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
                SET @message = '该时间段消费类型已经定义折扣。'
                RETURN
            END

		--更新数据
        IF @actionCode = 1
			--新建--
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
			--更新--
                UPDATE  dbo.VenueDiscount
                SET     Discount = @Discount ,
                        BeginDate = @BeginDate ,
                        EndDate = @EndDate
                WHERE   Id = @Id
            ELSE
                IF @actionCode = 3
				--删除--
                    DELETE  dbo.VenueDiscount
                    WHERE   Id = @Id
			

    END


GO

-- ----------------------------
-- Procedure structure for sp_SaveVipBuyPay
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveVipBuyPay]
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
                    @userId = UserId--实际充值帐号（别人代充，入真实的充值帐号）
            FROM    dbo.VipBuy
            WHERE   Id = @id
                    OR OrderNo = @orderNo

            IF @state = NULL
                RAISERROR (N'单据已经不存在。',11,1)

            IF @state = '024001'
                BEGIN

					--查找赠送比率
                    DECLARE @scale DECIMAL(18, 2)
                    SET @scale = 0
                    SELECT  @scale = Scale
                    FROM    dbo.VipRechargeScale
                    WHERE   @amount >= Min
                            AND @amount <= Max

					--计算赠送金额
                    DECLARE @giveAmount DECIMAL(18, 2)
                    SET @giveAmount = @amount * @scale;

				    --更新订单记录
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

					--更新账户记录入账
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
            SET @message = '操作失败。' + ERROR_MESSAGE() 
        END CATCH 

    END

GO

-- ----------------------------
-- Procedure structure for sp_SaveVipCostScale
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveVipCostScale]
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
		--验证新建，修改
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
                SET @message = '该消费类型已经定义。'
                RETURN
            END

		--更新数据
        IF @actionCode = 1
			--新建--
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
			--更新--
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
				--删除--
                    DELETE  dbo.VipCostScale
                    WHERE   Id = @Id
			

    END


GO

-- ----------------------------
-- Procedure structure for sp_SaveVipDiscount
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveVipDiscount]
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
                SET @message = '当前城市本消费类别折扣已经存在。'
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

-- ----------------------------
-- Procedure structure for sp_SaveVipInnerDiscount
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveVipInnerDiscount]
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
                SET @message = '当前场馆本消费类别折扣已经存在。'
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

-- ----------------------------
-- Procedure structure for sp_SaveVipRefund
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveVipRefund]
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
			--获取用户余额
            DECLARE @balance FLOAT	
            SELECT  @balance = Balance
            FROM    VipAccount
            WHERE   Id = @UserId

			--实时检查余额是否足以退款
            IF ISNULL(@balance, 0) < @AppliedAmount
                RAISERROR (N'账户余额，不足退款金额。',11,1)

			--从账户上扣钱（使用申请金额）
            UPDATE  dbo.VipAccount
            SET     Refund = ISNULL(Refund, 0) + ISNULL(@AppliedAmount, 0) ,
                    Balance = ISNULL(Balance, 0) - ISNULL(@AppliedAmount, 0)
            WHERE   Id = @UserId

			--保存退款记录
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
            SET @message = '操作失败。' + ERROR_MESSAGE() 
        END CATCH 

    END

GO

-- ----------------------------
-- Procedure structure for sp_SaveVipUse
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveVipUse]
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
		/*--开始--注释原因:比如未完成的支付单据A 我要支付100, 下次我再支付时可能将金额改成了 80 , 所以应该生成新的单据,而不是在原来的基础上接着支付*/
		--验证原单据重复生成支付单据
        --IF ISNULL(@MasterId, '') != ''
        --    AND EXISTS ( SELECT *
        --                 FROM   dbo.VipUse
        --                 WHERE  MasterId = @MasterId )
        --    BEGIN
        --        SET @message = '原单据已经生成支付单。'
        --        RETURN
        --    END
		/*--结束--注释原因:比如未完成的支付单据A 我要支付100, 下次我再支付时可能将金额改成了 80 , 所以应该生成新的单据,而不是在原来的基础上接着支付*/

		--代支付验证
        IF @PayOption = '023003'
            BEGIN
                DECLARE @venueBalance FLOAT;
                SELECT  @venueBalance = Balance
                FROM    dbo.Venue
                WHERE   Id = @VenueId

                IF ISNULL(@venueBalance, 0) < ISNULL(@Amount, 0)
                    BEGIN
                        SET @message = '代支付失败：信用余额不足。'
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

-- ----------------------------
-- Procedure structure for sp_SaveVipUsePay
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SaveVipUsePay]
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
		DECLARE @TopUpUserId NVARCHAR(50) --要充值的用户Id
        BEGIN TRY
            SELECT  @state = PayState ,
                    @venueId = VenueId ,
                    @masterType = MasterType ,
                    @masterId = MasterId ,
                    @userId = CreatorId,--从创建者帐号扣钱（自己支付，帮别人支付）
					@TopUpUserId=UserId 
            FROM    dbo.VipUse
            WHERE   Id = @id
                    OR OrderNo = @orderNo

            IF @state = NULL
                RAISERROR (N'单据已经不存在。',11,1)

            IF @state = '024001'
                BEGIN
					--如果余额支付
                    IF @payOption = '023001'
                        BEGIN
							--检查支付密码，免支付密码
                            DECLARE @password NVARCHAR(50)
                            DECLARE @noPwdAmount INT
                            SELECT  @password = PayPassword ,
                                    @noPwdAmount = PayNoPwdAmount
                            FROM    dbo.UserAccount
                            WHERE   Id = @userId

                            IF ISNULL(@password, '') = ''
                                RAISERROR (N'请先在个人信息设置支付密码。',11,1)

                            IF @amount > ISNULL(@noPwdAmount, 0)
                                AND ISNULL(@payPassword, '') != ISNULL(@password,
                                                              '')
                                RAISERROR (N'支付密码不正确。',11,1)

							--检查余额不足
                            DECLARE @balance DECIMAL(18, 2);
                            SELECT  @balance = Balance
                            FROM    dbo.VipAccount
                            WHERE   Id = @userId
                            IF ISNULL(@balance, 0) < ISNULL(@amount, 0)
                                RAISERROR (N'支付失败：余额不足。',11,1)
                            ELSE
								--余额消费，更新账户记录入账，并记录消费积分
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

                    --支付宝支付
                    IF @payOption = '023002'
                        BEGIN
							--记录消费积分
                            UPDATE  dbo.VipAccount
                            SET     Score = ISNULL(Score, 0) + ISNULL(@amount,
                                                              0) ,
                                    BalanceScore = ISNULL(BalanceScore, 0)
                                    + ISNULL(@amount, 0)
                            WHERE   Id = @userId
                        END

					--场馆代支付（用户不获得计分）
                    IF @payOption = '023003'
                        BEGIN
                            DECLARE @venueBalance DECIMAL(18, 2);
                            SELECT  @venueBalance = Balance
                            FROM    dbo.Venue
                            WHERE   Id = @venueId

                            IF ISNULL(@venueBalance, 0) < ISNULL(@amount, 0)
                                RAISERROR (N'支付失败：场馆信用余额不足。',11,1)
                            ELSE
								--代支付，更新场馆额度
                                UPDATE  dbo.Venue
                                SET     Balance = ISNULL(Balance, 0)
                                        - ISNULL(@amount, 0)
                                WHERE   Id = @venueId
                        END

				    --更新订单记录
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

					---------------更新原始单据逻辑（@masterType，@masterId）-----------------------------------
					--学员购买私教, 大课次数 支付成功后, 业务更新---------------------开始
                    IF @masterType = '016010001' --学员购买教练支付
                        BEGIN
 							BEGIN TRANSACTION
							--插入正式表
							INSERT INTO CoachStudentMoney	
							SELECT * FROM CoachStudentMoneyNotPay WHERE Id=@masterId
							--修改为正式数据
						 	UPDATE dbo.CoachStudentMoney SET  IsPay=1  WHERE Id=@masterId
							--删除不要的数据
							DELETE FROM CoachStudentMoneyNotPay WHERE Id=@masterId

							IF @@ERROR=0
								COMMIT TRANSACTION
							ELSE
								ROLLBACK TRANSACTION
                        END

					--学员购买私教, 大课次数 支付成功后, 业务更新---------------------结束
				    
					--学员购买集训课 业务更新---------------------开始
					IF	@masterType='016010005'
					 BEGIN
 							BEGIN TRANSACTION
							DECLARE @Count INT=0,@ThenTotalAmount INT,@ThenMoney DECIMAL(18,2), @StudentId NVARCHAR(50),@BootcampId NVARCHAR(50)
							SELECT @Count=Amount,@ThenTotalAmount=ThenTotalAmount,@ThenMoney=ThenMoney,@StudentId=StudentUserId,@BootcampId=CoachBootcampId  
							FROM CoachStudentMoneyNotPay WHERE Id=@masterId

							IF	EXISTS(SELECT * FROM CoachStudentMoney WHERE StudentUserId=@StudentId AND CoachBootcampId=@BootcampId)
							BEGIN --存在累加次数
									UPDATE dbo.CoachStudentMoney 
									SET  Amount=Amount+@Count  ,
											ThenTotalAmount=ThenTotalAmount+@ThenTotalAmount,
											ThenMoney=ThenMoney+@ThenMoney,
											CreateDate=GETDATE()
									WHERE StudentUserId=@StudentId AND CoachBootcampId=@BootcampId
							END
							ELSE
							BEGIN --不存在 插入数据
									--插入正式表
									INSERT INTO CoachStudentMoney	
									SELECT * FROM CoachStudentMoneyNotPay WHERE Id=@masterId
									--修改为正式数据
						 			UPDATE dbo.CoachStudentMoney SET  IsPay=1  WHERE Id=@masterId
									--删除不要的数据
									DELETE FROM CoachStudentMoneyNotPay WHERE Id=@masterId
							END 

							IF @@ERROR=0
								COMMIT TRANSACTION
							ELSE
								ROLLBACK TRANSACTION
                        END
					--学员购买集训课 业务更新---------------------结束

					--购买悦豆 支付成功后, 业务更新---------------------开始
                    IF @masterType = '016020001' --学员购买教练支付
                        BEGIN
							DECLARE @Proportion INT,@YueDouAmount INT
							SELECT TOP 1 @Proportion=YueDouConvertibleProportion FROM dbo.Config
							SET  @YueDouAmount= @amount*@Proportion

 							BEGIN TRANSACTION
								
							IF NOT EXISTS(SELECT * FROM dbo.YueDou WHERE UserId=@TopUpUserId )
							BEGIN
									--插入悦豆余额记录
									INSERT dbo.YueDou
									        (Id,UserId, Balance, CreateDate )
									VALUES  (  
												NEWID(),
									          @TopUpUserId, -- UserId - nvarchar(50)
									          @YueDouAmount, -- Balance - int
									          GETDATE()  -- CreateDate - datetime
									          )
							END 
							ELSE
							BEGIN
								--更新悦豆余额记录
								UPDATE dbo.YueDou SET Balance=Balance+@amount*@Proportion 
								WHERE UserId=@TopUpUserId
							END 

							--插入悦豆账单记录
							INSERT dbo.YueDouFlow
							        ( 
										Id,
							          UserId ,
							          FlowType ,
							          Amount ,
							          CreateDate
							        )
							VALUES  ( 
									   NEWID(),
							          @TopUpUserId , -- UserId - nvarchar(50)
							          N'YueDouTopUp' , -- FlowType - nvarchar(100)
							          @YueDouAmount , -- Amount - int
							          GETDATE()  -- CreateDate - datetime
							        )

							IF @@ERROR=0
								COMMIT TRANSACTION
							ELSE
								ROLLBACK TRANSACTION
                        END

					--购买悦豆 支付成功后, 业务更新---------------------结束
					---------------更新原始单据逻辑（@masterType，@masterId）-----------------------------------
					
                END
        END TRY

        BEGIN CATCH
            SET @message = '操作失败。' + ERROR_MESSAGE() 
        END CATCH 
    END

GO

-- ----------------------------
-- Procedure structure for sp_SetActivityState
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SetActivityState]
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

		--更新活动
        UPDATE  dbo.Activity
        SET     State = @state
        WHERE   Id = @id
		--如果是活动结束，则需要更新活动积分
        IF @state = '005005'
            BEGIN
				--如果是俱乐部活动，更新关联活动积分
                DECLARE @clubId NVARCHAR(50)
                SELECT  @clubId = ClubId
                FROM    dbo.Activity
                WHERE   Id = @id
                IF ISNULL(@clubId, '') != ''
                    BEGIN
						--获取系统积分定义
                        DECLARE @activityScore INT
                        SELECT  @activityScore = ActivityScore
                        FROM    dbo.Config

						--更新当前积分
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

-- ----------------------------
-- Procedure structure for sp_SetCompanyIsStop
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SetCompanyIsStop]
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

-- ----------------------------
-- Procedure structure for sp_SetGameLoopState
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SetGameLoopState]
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

-- ----------------------------
-- Procedure structure for sp_SetGameState
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SetGameState]
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

		--检查比赛是否已经结束
        DECLARE @curState NVARCHAR(50)
        SELECT  @curState = State
        FROM    dbo.Game
        WHERE   Id = @gameId
        IF @curState = '015005'
            BEGIN
                SET @message = '比赛已经结束,无法设置为未发布。'
                RETURN
            END

        IF @state = '015004'--比赛开始，设置所有轮次开始
            BEGIN
			    --检查创建比赛进程
                IF NOT EXISTS ( SELECT  *
                                FROM    dbo.GameOrder
                                WHERE   GameId = @gameId )
                    BEGIN
                        SET @message = '没有创建比赛进程，比赛无法开始。'
                        RETURN
                    END
				--检查是否所有轮次都设置了胜场选项
                IF EXISTS ( SELECT  *
                            FROM    dbo.GameOrder
                            WHERE   GameId = @gameId
                                    AND WinGame = 0 )
                    BEGIN
                        SET @message = '某轮次没有设置胜场选项，比赛无法开始。'
                        RETURN
                    END

				--检查第一轮抽签情况
                DECLARE @knockOut NVARCHAR(50)
                DECLARE @firstOrderId NVARCHAR(50)
                DECLARE @knockOutCount INT

                SELECT  @knockOut = KnockoutOption ,
                        @knockOutCount = KnockoutCount ,
                        @firstOrderId = Id
                FROM    dbo.GameOrder
                WHERE   GameId = @gameId
                        AND OrderNo = 1

				--第一轮小组循环
                IF @knockOut = '014002'
                    BEGIN
					    --小组成员2人以上
                        IF EXISTS ( SELECT  GroupId
                                    FROM    dbo.GameGroupMember
                                    WHERE   GameId = @gameId
                                    GROUP BY GroupId
                                    HAVING  COUNT(*) < 2 )
                            BEGIN
                                SET @message = '存在某小组人数不足2人，比赛无法开始。'
                                RETURN
                            END

						--小组人数必须大于等于出线人数
                        IF EXISTS ( SELECT  GroupId
                                    FROM    dbo.GameGroupMember
                                    WHERE   GameId = @gameId
                                    GROUP BY GroupId
                                    HAVING  COUNT(*) < @knockOutCount )
                            BEGIN
                                SET @message = '存在某小组人数不足出线人数，比赛无法开始。'
                                RETURN
                            END

                        
                    END
				--第一轮淘汰
                IF @knockOut = '014001'
                    AND NOT EXISTS ( SELECT *
                                     FROM   dbo.GameLoop
                                     WHERE  OrderId = @firstOrderId
                                            AND ( ISNULL(Team1Id, '') != ''
                                                  OR ISNULL(Team2Id, '') != ''
                                                ) )
                    BEGIN
                        SET @message = '还没有进行第一轮抽签，比赛无法开始。'
                        RETURN
                    END
				--更新轮次状态
                UPDATE  dbo.GameOrder
                SET     State = '013002'
                WHERE   GameId = @gameId
            END
        ELSE
            IF @state = '015005'--比赛结束，设置所有轮次结束
                BEGIN
                    IF EXISTS ( SELECT  *
                                FROM    dbo.GameLoop
                                WHERE   GameId = @gameId
                                        AND IsBye = 0
                                        AND State != '011003' )
                        BEGIN
                            SET @message = '还存在未结束的比赛，无法结束赛事.'
                            RETURN
                        END
                    ELSE
                        UPDATE  dbo.GameOrder
                        SET     State = '013003'
                        WHERE   GameId = @gameId
                                AND State != '013003'

					--俱乐部比赛需要更新俱乐部活动积分（比赛相当于活动）
                    EXEC dbo.sp_UpdateGameClubScore @gameId
					--积分赛事更新运动积分
					--运动积分已改为，每场打完立即计算
                    --EXEC dbo.sp_UpdateGameSportScore @gameId
                END

            ELSE
                IF @state = '015009'--取消比赛，则删除数据
                    BEGIN
						--缓存场次编号列表
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
						--场次详情
                        DELETE  FROM dbo.GameLoopDetail
                        WHERE   LoopId IN ( SELECT  Id
                                            FROM    @loopList )
						--团队映射
                        DELETE  FROM dbo.GameLoopMap
                        WHERE   LoopId IN ( SELECT  Id
                                            FROM    @loopList )
						--场次
                        DELETE  FROM dbo.GameLoop
                        WHERE   GameId = @gameId

						--参赛队伍
                        DELETE  FROM dbo.GameTeam
                        WHERE   GameId = @gameId

						--参赛队伍队员
                        DELETE  FROM dbo.GameGroupMember
                        WHERE   GameId = @gameId

						--小组
                        DELETE  FROM dbo.GameGroup
                        WHERE   GameId = @gameId

						--裁判
                        DELETE  FROM dbo.GameJudge
                        WHERE   GameId = @gameId

						--轮次
                        DELETE  FROM dbo.GameOrder
                        WHERE   GameId = @gameId
                    END
                ELSE
                    IF @state = '015001'--未发布状态，则删除一些明细数据，保留报名队伍
                        BEGIN
                            EXECUTE dbo.sp_DeleteGameAllDetail @gameId
                        END
		--取消删除；非取消设置状态
        IF @state = '015009'
            DELETE  FROM dbo.Game
            WHERE   Id = @gameId
        ELSE
            UPDATE  dbo.Game
            SET     State = @state
            WHERE   Id = @gameId
    END


GO

-- ----------------------------
-- Procedure structure for sp_SetGameTopState
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SetGameTopState]
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

-- ----------------------------
-- Procedure structure for sp_SetStudentReleased
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SetStudentReleased]
GO
--场馆与学员解约
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
			SET @errMsg='操作失败，学员信息已删除！'
		END
		ELSE IF ISNULL(@venueId,'')=''
		BEGIN
			SET @errCode=-1
			SET @errMsg='学员已解约,无需再次操作！'
		END
		ELSE
		BEGIN
			DELETE FROM VenueStudents WHERE UserId=@userId

			INSERT INTO CoachReleasedLog(Id,SenderType,SenderId,ReceiverType,ReceiverId,JoinDate,CreatorId,CreateDate)
			VALUES(NEWID(),'016003',@venueId,'016010',@userId,@joinDate,@creatorId,GETDATE())
		END
    END

GO

-- ----------------------------
-- Procedure structure for sp_SetVenueReleased
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SetVenueReleased]
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
			SET @errMsg='操作失败，场馆信息已删除！'
		END
		ELSE IF ISNULL(@companyId,'')=''
		BEGIN
			SET @errCode=-1
			SET @errMsg='场馆已解约,无需再次操作！'
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

-- ----------------------------
-- Procedure structure for sp_SetVenueVip
-- ----------------------------
DROP PROCEDURE [dbo].[sp_SetVenueVip]
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

-- ----------------------------
-- Procedure structure for sp_UpdateGameClubScore
-- ----------------------------
DROP PROCEDURE [dbo].[sp_UpdateGameClubScore]
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
						--获取系统积分定义
                DECLARE @activityScore INT
                SELECT  @activityScore = ActivityScore
                FROM    dbo.Config

						--更新当前积分
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

-- ----------------------------
-- Procedure structure for sp_UpdateGameSportScore
-- ----------------------------
DROP PROCEDURE [dbo].[sp_UpdateGameSportScore]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateGameSportScore] @GameId NVARCHAR(50)
AS
    BEGIN
        DECLARE @isScoreGame BIT,@isConcessionScore BIT,@isTeam BIT
        DECLARE @sportId NVARCHAR(50)

        SELECT  @isScoreGame = IsScoreGame ,
				@isConcessionScore = IsConcessionScore ,
				@isTeam = IsTeam ,
                @sportId = SportId
        FROM    dbo.Game
        WHERE   Id = @GameId

        IF @isScoreGame = 1
            BEGIN
				CREATE TABLE #temp(
					User1Id NVARCHAR(50),
					Score1 INT,
					User1Score INT,
					User2Id NVARCHAR(50),
					Score2 INT,
					User2Score INT,
					High INT,
					LOW INT,
					GameId NVARCHAR(50),
					LoopId NVARCHAR(50))


				IF @isTeam=0--单打
				BEGIN
					IF @isConcessionScore=0--不让分
					BEGIN
						INSERT INTO #temp
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
						FROM    dbo.GameLoop a
								JOIN dbo.GameTeam b ON A.Team1Id = b.Id
								JOIN dbo.GameTeam c ON A.Team2Id = c.Id
								JOIN dbo.UserSport d ON d.UserId = b.TeamUserId
														AND d.SportId = @sportId
								JOIN dbo.UserSport e ON e.UserId = c.TeamUserId
														AND e.SportId = @sportId
								JOIN dbo.ScoreRange f ON ABS(d.Score - e.Score) >= f.BeginScore
														 AND ABS(d.Score - e.Score) <= f.EndScore
						WHERE   a.GameId = @GameId--排除轮空，弃权的比赛
								AND a.IsBye = 0
								AND ISNULL(a.WaiverOption, '') = ''
					END
					ELSE--单打让分，视为积分差为0,即为0~12分差那档
					BEGIN
						INSERT INTO #temp
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
						FROM    dbo.GameLoop a
								JOIN dbo.GameTeam b ON A.Team1Id = b.Id
								JOIN dbo.GameTeam c ON A.Team2Id = c.Id
								JOIN dbo.UserSport d ON d.UserId = b.TeamUserId
														AND d.SportId = @sportId
								JOIN dbo.UserSport e ON e.UserId = c.TeamUserId
														AND e.SportId = @sportId
								JOIN dbo.ScoreRange f ON 0 >= f.BeginScore
														 AND 0 <= f.EndScore
						WHERE   a.GameId = @GameId--排除轮空，弃权的比赛
								AND a.IsBye = 0
								AND ISNULL(a.WaiverOption, '') = ''
					END
				END
				ELSE--团体
				BEGIN
					IF @isConcessionScore=0--不让分
					BEGIN
						INSERT INTO #temp
						SELECT  z.User1Id ,
                        z.Game1 ,
                        d.Score AS User1Score ,
                        z.User2Id ,
                        z.Game2 ,
                        e.Score AS User2Score ,
                        f.High ,
                        f.Low ,
                        a.GameId ,
                        a.Id
						FROM    dbo.GameLoop a
								JOIN dbo.GameLoopMap z ON a.Id=z.LoopId
								JOIN dbo.UserSport d ON d.UserId = z.User1Id
														AND d.SportId = @sportId
								JOIN dbo.UserSport e ON e.UserId = z.User2Id
														AND e.SportId = @sportId
								JOIN dbo.ScoreRange f ON ABS(d.Score - e.Score) >= f.BeginScore
														 AND ABS(d.Score - e.Score) <= f.EndScore
						WHERE   a.GameId = @GameId--排除轮空，弃权的比赛
								AND a.IsBye = 0
								AND ISNULL(a.WaiverOption, '') = ''
                    END
					ELSE --团体让分
					BEGIN
						INSERT INTO #temp
						SELECT  z.User1Id ,
                        z.Game1 ,
                        d.Score AS User1Score ,
                        z.User2Id ,
                        z.Game2 ,
                        e.Score AS User2Score ,
                        f.High ,
                        f.Low ,
                        a.GameId ,
                        a.Id
						FROM    dbo.GameLoop a
								JOIN dbo.GameLoopMap z ON a.Id=z.LoopId
								JOIN dbo.UserSport d ON d.UserId = z.User1Id
														AND d.SportId = @sportId
								JOIN dbo.UserSport e ON e.UserId = z.User2Id
														AND e.SportId = @sportId
								JOIN dbo.ScoreRange f ON 0 >= f.BeginScore
														 AND 0 <= f.EndScore
						WHERE   a.GameId = @GameId--排除轮空，弃权的比赛
								AND a.IsBye = 0
								AND ISNULL(a.WaiverOption, '') = ''
					END
				END

                

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



				DROP TABLE #temp
            END
    END

GO

-- ----------------------------
-- Procedure structure for sp_UpdateGameSportScoreForOne
-- ----------------------------
DROP PROCEDURE [dbo].[sp_UpdateGameSportScoreForOne]
GO
--单打赛，更新个人积分
CREATE PROCEDURE [dbo].[sp_UpdateGameSportScoreForOne] 
	@GameId NVARCHAR(50),
	@LoopId NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @isScoreGame BIT,@isConcessionScore BIT,@isTeam BIT
    DECLARE @sportId NVARCHAR(50)

    SELECT  @isScoreGame = IsScoreGame ,
			@isConcessionScore = IsConcessionScore ,
			@isTeam = IsTeam ,
            @sportId = SportId
    FROM    Game
    WHERE   Id = @GameId


	--积分赛，才计算积分
	IF @isScoreGame = 1 AND @isTeam=0--单打
	BEGIN
		DECLARE @user1Id NVARCHAR(500)
        DECLARE @user1Score INT
        DECLARE @score1 INT
        DECLARE @user2Id NVARCHAR(500)
        DECLARE @user2Score INT
        DECLARE @score2 INT
		DECLARE @isbye BIT
		DECLARE @waiverOption NVARCHAR(200)

		DECLARE @user1Add INT
		DECLARE @user1AddTemp INT
		DECLARE @user2Add INT
		DECLARE @user2AddTemp INT

		DECLARE @high INT
        DECLARE @low INT



		SELECT  @user1Id=b.TeamUserId,
                @score1=a.Score1 ,
                @user1Score=d.Score,
                @user2Id=c.TeamUserId,
                @score2=a.Score2 ,
                @user2Score=e.Score,
				@isbye=a.IsBye,
				@waiverOption=a.WaiverOption
				FROM    GameLoop a
						JOIN GameTeam b ON A.Team1Id = b.Id
						JOIN GameTeam c ON A.Team2Id = c.Id
						JOIN UserSport d ON d.UserId = b.TeamUserId
												AND d.SportId = @sportId
						JOIN UserSport e ON e.UserId = c.TeamUserId
												AND e.SportId = @sportId
				WHERE   a.Id = @LoopId
		--排除轮空，弃权的比赛
		IF @isbye=0 AND ISNULL(@waiverOption, '') = ''
		BEGIN

			--非让分赛，查出对应分差区间的加减分
			IF @isConcessionScore=0
				SELECT @high=High,@low=Low FROM ScoreRange WHERE ABS(@user1Score - @user2Score) >= BeginScore AND ABS(@user1Score - @user2Score) <= EndScore
			ELSE
				SELECT @high=High,@low=Low FROM ScoreRange WHERE BeginScore=0


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

			--如果存在，直接更新老数据（避免重复操作结束某场对阵结果）
			IF EXISTS(SELECT 1 FROM UserScoreHistory WHERE UserId=@user1Id AND LoopId=@LoopId)
			BEGIN
				SELECT @user1AddTemp=Score FROM UserScoreHistory WHERE UserId=@user1Id AND LoopId=@LoopId

				UPDATE  UserSport
				SET     Score = Score + @user1Add - @user1AddTemp
				WHERE   UserId = @user1Id
						AND SportId = @sportId

				UPDATE UserScoreHistory SET Score=@user1Add,CreateDate=GETDATE() WHERE UserId=@user1Id AND LoopId=@LoopId
			END
            ELSE
			BEGIN
				UPDATE  UserSport
				SET     Score = Score + @user1Add
				WHERE   UserId = @user1Id
						AND SportId = @sportId  

				INSERT  UserScoreHistory
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
							@GameId , -- GameId - nvarchar(50)
							@LoopId , -- LoopId - nvarchar(50)
							@user1Add , -- Score - int
							GETDATE()  -- CreateDate - datetime
							)
			END

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

			--如果存在，直接更新老数据（避免重复操作结束某场对阵结果）
			IF EXISTS(SELECT 1 FROM UserScoreHistory WHERE UserId=@user2Id AND LoopId=@LoopId)
			BEGIN
				SELECT @user2AddTemp=Score FROM UserScoreHistory WHERE UserId=@user2Id AND LoopId=@LoopId

				UPDATE  UserSport
				SET     Score = Score + @user2Add - @user2AddTemp
				WHERE   UserId = @user2Id
						AND SportId = @sportId

				UPDATE UserScoreHistory SET Score=@user2Add,CreateDate=GETDATE() WHERE UserId=@user2Id AND LoopId=@LoopId
			END
            ELSE
			BEGIN
				UPDATE  UserSport
				SET     Score = Score + @user2Add
				WHERE   UserId = @user2Id
						AND SportId = @sportId

				INSERT  UserScoreHistory
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
							@GameId , -- GameId - nvarchar(50)
							@LoopId , -- LoopId - nvarchar(50)
							@user2Add , -- Score - int
							GETDATE()  -- CreateDate - datetime
							)
			END

		END
	END
END
GO

-- ----------------------------
-- Procedure structure for sp_UpdateGameSportScoreForTeam
-- ----------------------------
DROP PROCEDURE [dbo].[sp_UpdateGameSportScoreForTeam]
GO

--团体赛，更新个人积分
CREATE PROCEDURE [dbo].[sp_UpdateGameSportScoreForTeam] 
	@GameId NVARCHAR(50),
	@LoopId NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @isScoreGame BIT,@isConcessionScore BIT,@isTeam BIT
    DECLARE @sportId NVARCHAR(50)

    SELECT  @isScoreGame = IsScoreGame ,
			@isConcessionScore = IsConcessionScore ,
			@isTeam = IsTeam ,
            @sportId = SportId
    FROM    Game
    WHERE   Id = @GameId


	--积分赛，才计算积分
	IF @isScoreGame = 1 AND @isTeam=1--团体赛
	BEGIN
		DECLARE @MapId NVARCHAR(50)
		CREATE TABLE #Tab_User1(Id NVARCHAR(200) collate Chinese_PRC_CI_AS)
		CREATE TABLE #Tab_User2(Id NVARCHAR(200) collate Chinese_PRC_CI_AS)

		DECLARE @user1Id NVARCHAR(500)
        DECLARE @user1Score FLOAT
        DECLARE @game1 INT
        DECLARE @user2Id NVARCHAR(500)
        DECLARE @user2Score FLOAT
        DECLARE @game2 INT
		DECLARE @waiverOption NVARCHAR(200)

		DECLARE @user1Add INT
		DECLARE @user2Add INT

		DECLARE @high INT
        DECLARE @low INT


		DECLARE user_cur CURSOR
        FOR
            SELECT  
				a.Id,
				a.User1Id,
                a.Game1 ,
                a.User2Id,
                a.Game2 ,
				a.WaiverOption
				FROM GameLoopMap a 
				INNER JOIN GameLoop b ON a.LoopId=b.Id 
				WHERE b.Id = @LoopId AND b.IsBye=0
		

        OPEN user_cur

		FETCH NEXT FROM user_cur INTO @MapId, @user1Id, @game1, @user2Id, @game2, @waiverOption
        WHILE @@FETCH_STATUS = 0
		BEGIN
				
			--排除弃权的比赛,0比0即为未打比赛就结束了的
			IF ISNULL(@waiverOption, '') = '' AND @game1<>@game2
			BEGIN
				
				DELETE FROM #Tab_User1
				DELETE FROM #Tab_User2
				INSERT INTO #Tab_User1 SELECT Id FROM dbo.fn_Split(@user1Id) WHERE Id<>''
				INSERT INTO #Tab_User2 SELECT Id FROM dbo.fn_Split(@user2Id) WHERE Id<>''

				DECLARE @isDouble INT --是否是双打
				SET @isDouble = CASE CHARINDEX(',',@user1Id) WHEN 0 THEN 0 ELSE 1 END

				
				--非让分赛，查出对应分差区间的加减分
				IF @isConcessionScore=0
				BEGIN
					IF @isDouble=1
					BEGIN
						--双打，积分和除2
						SELECT @user1Score=SUM(CAST(Score AS FLOAT))/2 FROM UserSport WHERE UserId IN
							(
								SELECT Id FROM #Tab_User1
							)
							AND SportId=@sportId

						SELECT @user2Score=SUM(CAST(Score AS FLOAT))/2 FROM UserSport WHERE UserId IN
							(
								SELECT Id FROM #Tab_User2
							)
							AND SportId=@sportId
					END
					ELSE--单打
					BEGIN
						SELECT @user1Score=Score FROM UserSport WHERE UserId=@user1Id AND SportId=@sportId
						SELECT @user2Score=Score FROM UserSport WHERE UserId=@user2Id AND SportId=@sportId
					END
					
					SELECT @high=High,@low=Low FROM ScoreRange WHERE ABS(@user1Score - @user2Score) >= BeginScore AND ABS(@user1Score - @user2Score) <= EndScore
					
				END
				ELSE
					SELECT @high=High,@low=Low FROM ScoreRange WHERE BeginScore=0

					
				SET @user1Add = CASE WHEN @user1Score >= @user2Score
										THEN ( CASE WHEN @game1 > @game2
													THEN @high
													ELSE -@low
											END )
										ELSE ( CASE WHEN @game1 > @game2
													THEN @low
													ELSE -@high
											END )
								END

				
				
				--如果存在，直接更新老数据（避免重复操作结束某场对阵结果）
				IF EXISTS(SELECT 1 FROM UserScoreHistory WHERE UserId IN(SELECT Id FROM #Tab_User1) AND MapId=@MapId)
				BEGIN

					UPDATE  UserSport
					SET     Score = a.Score + @user1Add - b.Score
					FROM	UserSport a INNER JOIN UserScoreHistory b ON a.UserId=b.UserId AND b.MapId=@MapId
					WHERE	a.UserId IN(SELECT Id FROM #Tab_User1) AND a.SportId = @sportId

					UPDATE UserScoreHistory SET Score=@user1Add,CreateDate=GETDATE() WHERE UserId IN(SELECT Id FROM #Tab_User1) AND MapId=@MapId
				END
				ELSE
				BEGIN

					UPDATE  UserSport
					SET     Score = Score + @user1Add
					WHERE   UserId IN(SELECT Id FROM #Tab_User1)
							AND SportId = @sportId  

					INSERT  UserScoreHistory
							( Id ,
								UserId ,
								SportId ,
								GameId ,
								MapId ,
								Score ,
								CreateDate
								)
					SELECT  CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
								Id , -- UserId - nvarchar(50)
								@sportId , -- SportId - nvarchar(50)
								@GameId , -- GameId - nvarchar(50)
								@MapId , -- LoopId - nvarchar(50)
								@user1Add , -- Score - int
								GETDATE()  -- CreateDate - datetime
					FROM #Tab_User1
				END


				SET @user2Add = CASE WHEN @user2Score >= @user1Score
										THEN ( CASE WHEN @game2 > @game1
													THEN @high
													ELSE -@low
											END )
										ELSE ( CASE WHEN @game2 > @game1
													THEN @low
													ELSE -@high
											END )
								END
				
				--如果存在，直接更新老数据（避免重复操作结束某场对阵结果）
				IF EXISTS(SELECT 1 FROM UserScoreHistory WHERE UserId IN(SELECT Id FROM #Tab_User2) AND MapId=@MapId)
				BEGIN
					UPDATE  UserSport
					SET     Score = a.Score + @user2Add - b.Score
					FROM	UserSport a INNER JOIN UserScoreHistory b ON a.UserId=b.UserId AND b.MapId=@MapId
					WHERE	a.UserId IN(SELECT Id FROM #Tab_User2) AND a.SportId = @sportId

					UPDATE UserScoreHistory SET Score=@user2Add,CreateDate=GETDATE() WHERE UserId IN(SELECT Id FROM #Tab_User2) AND MapId=@MapId
				END
				ELSE
				BEGIN
					UPDATE  UserSport
					SET     Score = Score + @user2Add
					WHERE   UserId IN(SELECT Id FROM #Tab_User2)
							AND SportId = @sportId  

					INSERT  UserScoreHistory
							( Id ,
								UserId ,
								SportId ,
								GameId ,
								MapId ,
								Score ,
								CreateDate
								)
					SELECT  CAST(NEWID() AS NVARCHAR(50)) , -- Id - nvarchar(50)
								Id , -- UserId - nvarchar(50)
								@sportId , -- SportId - nvarchar(50)
								@GameId , -- GameId - nvarchar(50)
								@MapId , -- LoopId - nvarchar(50)
								@user2Add , -- Score - int
								GETDATE()  -- CreateDate - datetime
					FROM #Tab_User2
				END

			END


			FETCH NEXT FROM user_cur INTO @MapId, @user1Id, @game1, @user2Id, @game2, @waiverOption
		END--cursor end

		CLOSE user_cur
		DEALLOCATE user_cur

		DROP TABLE #Tab_User1
		DROP TABLE #Tab_User2
	END
END
GO

-- ----------------------------
-- Procedure structure for sp_UpdatePassword
-- ----------------------------
DROP PROCEDURE [dbo].[sp_UpdatePassword]
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
            SET @message = '原密码不正确。'
    END

GO

-- ----------------------------
-- Procedure structure for sp_UpdateTransferCreatorId
-- ----------------------------
DROP PROCEDURE [dbo].[sp_UpdateTransferCreatorId]
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

		--移交俱乐部，需要处理ClubUser中创建人设置
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

-- ----------------------------
-- Procedure structure for sp_UpdateValCode
-- ----------------------------
DROP PROCEDURE [dbo].[sp_UpdateValCode]
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
            SET     Code = @code,CreateDate=GETDATE()
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

-- ----------------------------
-- Procedure structure for sp_ValidateClubActivity
-- ----------------------------
DROP PROCEDURE [dbo].[sp_ValidateClubActivity]
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

-- ----------------------------
-- Procedure structure for sp_ValidateGameTeam
-- ----------------------------
DROP PROCEDURE [dbo].[sp_ValidateGameTeam]
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
    @userList NVARCHAR(500),
	@message NVARCHAR(200) OUTPUT
AS
    BEGIN
		BEGIN TRY
			 

			--如果赛事显示真实姓名，需检查队员身份证不能为空
			IF EXISTS(SELECT 1 FROM Game WHERE Id=@gameId AND NameOption='020002')
			BEGIN
				IF EXISTS(SELECT 1 FROM UserAccount WHERE Id IN(SELECT Id FROM dbo.fn_Split(@userList)) AND ISNULL(CardId,'')='')
				BEGIN
					DECLARE @cardnames NVARCHAR(200)
					SELECT @cardnames=STUFF((select ',' + CardName from UserAccount where Id IN(SELECT Id FROM dbo.fn_Split(@userList)) AND ISNULL(CardId,'')='' FOR XML PATH('')) , 1 , 1 , '') 
					SET @cardnames='本次赛事需实名认证，请完善队员【'+@cardnames+'】的身份证信息！'
					RAISERROR (@cardnames,11,1)
				END
			END

			--检查队员是否报名
			IF EXISTS(SELECT 1 FROM GameTeam WHERE GameId = @gameId
					AND Id != @teamId
					AND dbo.fn_SamePart(@userList, TeamUserId) > 0)
					/*
					AND ( CreatorId = @userId
						  OR dbo.fn_SamePart(@userList, TeamUserId) > 0
						))*/
			BEGIN
				RAISERROR (N'报名失败，部分队员已经报名！',11,1)
			END

			
		END TRY

        BEGIN CATCH
            SET @message = ERROR_MESSAGE() 
        END CATCH 
    END

GO

-- ----------------------------
-- Procedure structure for sp_ValidateUser
-- ----------------------------
DROP PROCEDURE [dbo].[sp_ValidateUser]
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
				VenueId=(SELECT TOP 1 Id FROM dbo.Venue WHERE AdminId=a.Id),
				IsCoacher=(SELECT  CONVERT(BIT,COUNT(Id))  FROM dbo.Coach WHERE Id=a.Id)
        FROM    UserAccount a
                LEFT JOIN dbo.UserSport b ON b.UserId = a.Id
                                             AND SportId = '474C2709-325E-49F7-AB66-A676C40B2EA6'
        WHERE   ( Code = @code
                  OR Mobile = @code
                )
                AND Password = @password
    END

GO

-- ----------------------------
-- Procedure structure for sp_ValidateUserSign
-- ----------------------------
DROP PROCEDURE [dbo].[sp_ValidateUserSign]
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
            SET @message = '存在未支付消费订单，无法签到。'
        ELSE
            IF EXISTS ( SELECT  *
                        FROM    UserSign
                        WHERE   CreatorId = @userId
                                AND MasterId = @masterId
                                AND CONVERT(NVARCHAR(10), CreateDate, 120) = @signDate )
                SET @message = '今日已签到。'
            ELSE
                SET @message = ''

        SELECT  @message
        
    END

GO

-- ----------------------------
-- Function structure for fn_GetCoachAge
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetCoachAge]
GO
--获取教练-- 教龄
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

-- ----------------------------
-- Function structure for fn_GetCoachAVGScore
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetCoachAVGScore]
GO
--获取教练的平均评分 
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

-- ----------------------------
-- Function structure for fn_GetCoacherScore
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetCoacherScore]
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

-- ----------------------------
-- Function structure for fn_GetDate
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetDate]
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

-- ----------------------------
-- Function structure for fn_GetDistance
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetDistance]
GO
CREATE FUNCTION [dbo].[fn_GetDistance] 

 --LatBegin 开始纬度 latitude
 --LngBegin 开始经度 longitude
    (
      @LatBegin REAL ,
      @LngBegin REAL ,
      @LatEnd REAL ,
      @LngEnd REAL
    )
RETURNS FLOAT
AS
    BEGIN
		--计算开始经度纬度和 结束经度纬度 之间的距离 (千米)
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

 	   --@Distance的单位为:千米
        RETURN @Distance

    END



GO

-- ----------------------------
-- Function structure for fn_GetFinalRank
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetFinalRank]
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

		--单循环从小组成员表中返回排名
        IF @gameKnockout = '014002'
            SELECT  @finalRank = CASE WHEN ISNULL(Rank, 0) = 0 THEN 10000
                                      ELSE Rank
                                 END
            FROM    dbo.GameGroupMember a
            WHERE   GameId = @gameId
                    AND TeamId = @teamId
        ELSE
            BEGIN
				--单淘汰，先循环后淘汰从淘汰赛中返回排名

				--检查是否参与了附加赛
                DECLARE @maxExtraOrder INT
                SELECT  @maxExtraOrder = MAX(ExtraOrder)
                FROM    dbo.GameLoop
                WHERE   GameId = @gameId
                        AND ( Team1Id = @teamId
                              OR Team2Id = @teamId
                            )
                        AND IsExtra = 1
				--参与了附加赛，则取附加赛排名
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
											--非最后一场附加赛和最后一场未进行则并列名次
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
					--检查是否参与了淘汰正赛
                        DECLARE @maxOrder INT
                        SELECT  @maxOrder = MAX(b.OrderNo)
                        FROM    dbo.GameLoop a
                                JOIN dbo.GameOrder b ON a.OrderId = b.Id
                        WHERE   a.GameId = @gameId
                                AND ( Team1Id = @teamId
                                      OR Team2Id = @teamId
                                    )
                                AND a.IsExtra = 0
                                AND a.OrderNo > 0--排除抢位赛
                                AND b.KnockoutOption = '014001'
						--如果参与了淘汰赛正赛，则取淘汰赛排名

                        IF ISNULL(@maxOrder, 0) > 0
                            BEGIN
                                SELECT  @finalRank = CASE WHEN a.BeginRank + 1 = a.EndRank
                                                              AND Score1 != Score2--决赛
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
														--非决赛和决赛未进行则并列名次
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

					--如果没有进入附加赛和淘汰正赛，则返回NULL
            END
        RETURN @finalRank

    END

GO

-- ----------------------------
-- Function structure for fn_GetFinalRankByOrder
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetFinalRankByOrder]
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<只针对筛选轮的单循环比赛, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetFinalRankByOrder]
    (
      @gameId NVARCHAR(50) ,
      @teamId NVARCHAR(50) 
    )
RETURNS INT
AS
    BEGIN
        DECLARE @finalRank INT
        SET @finalRank = 10000

		--单循环从小组成员表中返回排名
       SELECT  @finalRank = CASE WHEN ISNULL(Rank, 0) = 0 THEN 10000
                                      ELSE Rank
                                 END
            FROM    dbo.GameGroupMember a
            WHERE   GameId = @gameId
                    AND TeamId = @teamId


        RETURN @finalRank

    END

GO

-- ----------------------------
-- Function structure for fn_GetGameLoopCount
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetGameLoopCount]
GO
CREATE FUNCTION [dbo].[fn_GetGameLoopCount]
    (
      @gameId NVARCHAR(50) ,
      @teamId NVARCHAR(50)
    )
RETURNS INT
AS
    BEGIN
        DECLARE @result INT 
        SET @result = 0

        SELECT @result=COUNT(a.Id) FROM dbo.GameLoop AS a WHERE a.GameId=@gameId AND a.State='011003' AND CHARINDEX(@teamId,CONCAT(a.Team1Id,a.Team2Id))>0
        
		RETURN ISNULL(@result,0)
    END



GO

-- ----------------------------
-- Function structure for fn_GetGameTeamScore
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetGameTeamScore]
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

-- ----------------------------
-- Function structure for fn_GetLinkVenueName
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetLinkVenueName]
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

-- ----------------------------
-- Function structure for fn_GetPersonalSportScore
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetPersonalSportScore]
GO
CREATE FUNCTION [dbo].[fn_GetPersonalSportScore]
    (
      @gameId NVARCHAR(50) ,
      @userId NVARCHAR(50),
	  @startOrderNo INT,
	  @endOrderNo INT
    )
RETURNS INT
AS
    BEGIN
        DECLARE @result INT 
        SET @result = 0

		IF @startOrderNo <=0
			BEGIN
				SELECT @result=SUM(ISNULL(a.Score,0)) FROM dbo.UserScoreHistory AS a 
				WHERE a.UserId=@userId AND EXISTS (
				SELECT * FROM dbo.GameLoop AS b 
				WHERE b.Id=a.LoopId AND b.GameId=@gameId AND b.State='011003' 
				)
			END
        ELSE
			BEGIN
				SELECT @result=SUM(ISNULL(a.Score,0)) FROM dbo.UserScoreHistory AS a 
				WHERE a.UserId=@userId AND EXISTS (
				SELECT * FROM dbo.GameLoop AS b 
				WHERE b.Id=a.LoopId AND b.GameId=@gameId AND b.State='011003' AND b.OrderNo>=@startOrderNo AND b.OrderNo <=@endOrderNo
				)

				--INNER JOIN dbo.GameLoop AS b ON  a.LoopId=b.Id  
				--INNER JOIN dbo.GameOrder AS c ON c.Id=b.OrderId
				--WHERE a.UserId=@userId AND b.GameId=@gameId AND c.OrderNo>=@startOrderNo AND c.OrderNo <=@endOrderNo
			END

        RETURN @result

    END



GO

-- ----------------------------
-- Function structure for fn_GetReplyCount
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetReplyCount]
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

-- ----------------------------
-- Function structure for fn_GetSignCount
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetSignCount]
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

-- ----------------------------
-- Function structure for fn_GetTeachingPointCoachIds
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetTeachingPointCoachIds]
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

-- ----------------------------
-- Function structure for fn_GetTeachingPointCoachNames
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetTeachingPointCoachNames]
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
			@sql= @sql+'、'+b.CardName 
		FROM dbo.CoachTeachingPointCoaches  a
		INNER JOIN dbo.UserAccount b ON a.CoacherId=b.Id
		WHERE VenueId=@venueId
		
        RETURN @sql
    END

GO

-- ----------------------------
-- Function structure for fn_GetTeamScore
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetTeamScore]
GO
CREATE FUNCTION [dbo].[fn_GetTeamScore]
    (
      @gameId NVARCHAR(50) ,
      @TeamId NVARCHAR(50),
	  @startOrderNo INT=0,
	  @endOrderNo INT=0
    )
RETURNS INT
AS
    BEGIN
        DECLARE @result INT 
        SET @result = 0
		DECLARE @result1 INT 
		SET @result1 = 0
		DECLARE @result2 INT 
		SET @result2 = 0

		IF @startOrderNo <=0
		BEGIN
			SELECT @result1=ISNULL(SUM(ISNULL(a.Score1,0)),0) FROM dbo.GameLoop AS a WHERE a.GameId=@gameId AND a.Team1Id=@TeamId AND State='011003'
			SELECT @result2=ISNULL(SUM(ISNULL(a.Score2,0)),0) FROM dbo.GameLoop AS a WHERE a.GameId=@gameId AND a.Team2Id=@TeamId AND State='011003'
		END
		ELSE
		BEGIN
			SELECT @result1=ISNULL(SUM(ISNULL(a.Score1,0)),0) FROM dbo.GameLoop AS a  WHERE a.GameId=@gameId AND a.Team1Id=@TeamId AND State='011003' AND a.OrderNo>=@startOrderNo AND a.OrderNo <=@endOrderNo
			SELECT @result2=ISNULL(SUM(ISNULL(a.Score2,0)),0) FROM dbo.GameLoop AS a  WHERE a.GameId=@gameId AND a.Team2Id=@TeamId AND State='011003' AND a.OrderNo>=@startOrderNo AND a.OrderNo <=@endOrderNo
		END
        
		SET @result=@result1+@result2

        RETURN @result

    END



GO

-- ----------------------------
-- Function structure for fn_GetUserLinkCardName
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetUserLinkCardName]
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

-- ----------------------------
-- Function structure for fn_GetUserLinkName
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetUserLinkName]
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

-- ----------------------------
-- Function structure for fn_GetUserLinkPetName
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetUserLinkPetName]
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

-- ----------------------------
-- Function structure for fn_GetUserName
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetUserName]
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

-- ----------------------------
-- Function structure for fn_GetUserNameString
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetUserNameString]
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

-- ----------------------------
-- Function structure for fn_GetUserPetName
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetUserPetName]
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

-- ----------------------------
-- Function structure for fn_GetVenueNameString
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetVenueNameString]
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

-- ----------------------------
-- Function structure for fn_GetVenueUserUseCount
-- ----------------------------
DROP FUNCTION [dbo].[fn_GetVenueUserUseCount]
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

-- ----------------------------
-- Function structure for fn_Link
-- ----------------------------
DROP FUNCTION [dbo].[fn_Link]
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

-- ----------------------------
-- Function structure for fn_NewId
-- ----------------------------
DROP FUNCTION [dbo].[fn_NewId]
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

-- ----------------------------
-- Function structure for fn_SamePart
-- ----------------------------
DROP FUNCTION [dbo].[fn_SamePart]
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

-- ----------------------------
-- Function structure for fn_SimpleContent
-- ----------------------------
DROP FUNCTION [dbo].[fn_SimpleContent]
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

-- ----------------------------
-- Function structure for fn_Trim
-- ----------------------------
DROP FUNCTION [dbo].[fn_Trim]
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

-- ----------------------------
-- Indexes structure for table Activity
-- ----------------------------
CREATE INDEX [IX_Activity_ClubId] ON [dbo].[Activity]
([ClubId] ASC) 
GO
CREATE INDEX [IX_Activity_CreatorId] ON [dbo].[Activity]
([CreatorId] ASC) 
GO
CREATE INDEX [IX_Activity_CreateDate] ON [dbo].[Activity]
([CreateDate] ASC) 
GO
CREATE INDEX [IX_Activity_BeginTime] ON [dbo].[Activity]
([BeginTime] ASC) 
GO
CREATE INDEX [IX_Activity_EndTime] ON [dbo].[Activity]
([EndTime] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table Activity
-- ----------------------------
ALTER TABLE [dbo].[Activity] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table ActivityUser
-- ----------------------------
CREATE INDEX [IX_ActivityUser_ActivityId] ON [dbo].[ActivityUser]
([ActivityId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table ActivityUser
-- ----------------------------
ALTER TABLE [dbo].[ActivityUser] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table AppVersion
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table AppVersion
-- ----------------------------
ALTER TABLE [dbo].[AppVersion] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table BaseData
-- ----------------------------
CREATE CLUSTERED INDEX [IX_BaseData_GroupId] ON [dbo].[BaseData]
([GroupId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table BaseData
-- ----------------------------
ALTER TABLE [dbo].[BaseData] ADD PRIMARY KEY NONCLUSTERED ([Id])
GO

-- ----------------------------
-- Indexes structure for table City
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table City
-- ----------------------------
ALTER TABLE [dbo].[City] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Club
-- ----------------------------
CREATE INDEX [IX_Club_CreatorId] ON [dbo].[Club]
([CreatorId] ASC) 
GO
CREATE INDEX [IX_Club_CreateDate] ON [dbo].[Club]
([CreateDate] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table Club
-- ----------------------------
ALTER TABLE [dbo].[Club] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table ClubHonor
-- ----------------------------
CREATE INDEX [IX_ClubHonor_ClubId] ON [dbo].[ClubHonor]
([ClubId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table ClubHonor
-- ----------------------------
ALTER TABLE [dbo].[ClubHonor] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table ClubRequest
-- ----------------------------
CREATE INDEX [IX_ClubRequest_ClubId] ON [dbo].[ClubRequest]
([ClubId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table ClubRequest
-- ----------------------------
ALTER TABLE [dbo].[ClubRequest] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table ClubUser
-- ----------------------------
CREATE INDEX [IX_ClubUser_ClubId] ON [dbo].[ClubUser]
([ClubId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table ClubUser
-- ----------------------------
ALTER TABLE [dbo].[ClubUser] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Coach
-- ----------------------------
CREATE INDEX [IX_Coach_OrganizationId] ON [dbo].[Coach]
([OrganizationId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table Coach
-- ----------------------------
ALTER TABLE [dbo].[Coach] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachApply
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table CoachApply
-- ----------------------------
ALTER TABLE [dbo].[CoachApply] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachBootcamp
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table CoachBootcamp
-- ----------------------------
ALTER TABLE [dbo].[CoachBootcamp] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachBootcampCourse
-- ----------------------------
CREATE INDEX [IXC_CoachBootcampCourse_CoachBootcampId] ON [dbo].[CoachBootcampCourse]
([CoachBootcampId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table CoachBootcampCourse
-- ----------------------------
ALTER TABLE [dbo].[CoachBootcampCourse] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachBootcampCourseJoin
-- ----------------------------
CREATE INDEX [IX_CoachBootcampCourseJoin_StudentId] ON [dbo].[CoachBootcampCourseJoin]
([StudentId] ASC) 
GO
CREATE INDEX [IX_CoachBootcampCourseJoin_BootcampCourseId] ON [dbo].[CoachBootcampCourseJoin]
([BootcampCourseId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table CoachBootcampCourseJoin
-- ----------------------------
ALTER TABLE [dbo].[CoachBootcampCourseJoin] ADD PRIMARY KEY NONCLUSTERED ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachBootcampStudent
-- ----------------------------
CREATE INDEX [IX_CoachBootcampStudent_CoachBootcampId] ON [dbo].[CoachBootcampStudent]
([CoachBootcampId] ASC) 
GO

-- ----------------------------
-- Indexes structure for table CoachComment
-- ----------------------------
CREATE CLUSTERED INDEX [IXC_CoachComment_CoacherUserId] ON [dbo].[CoachComment]
([CoacherUserId] ASC) 
GO
CREATE INDEX [IX_CoachComment_CourseId] ON [dbo].[CoachComment]
([CourseId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table CoachComment
-- ----------------------------
ALTER TABLE [dbo].[CoachComment] ADD PRIMARY KEY NONCLUSTERED ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachCommentStudent
-- ----------------------------
CREATE UNIQUE INDEX [IX_CoachCommentStudent_Id] ON [dbo].[CoachCommentStudent]
([Id] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO
CREATE INDEX [IX_CoachCommentStudent_CoursePersonInfoId] ON [dbo].[CoachCommentStudent]
([CoursePersonInfoId] ASC) 
GO

-- ----------------------------
-- Indexes structure for table CoachCourse
-- ----------------------------
CREATE INDEX [IX_CoachCourse_CoachId] ON [dbo].[CoachCourse]
([CoachId] ASC) 
GO
CREATE INDEX [IX_CoachCourse_BeginTime] ON [dbo].[CoachCourse]
([BeginTime] ASC) 
GO
CREATE INDEX [IX_CoachCourse_EndTime] ON [dbo].[CoachCourse]
([EndTime] ASC) 
GO
CREATE INDEX [IX_CoachCourse_ReservedPersonId] ON [dbo].[CoachCourse]
([ReservedPersonId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table CoachCourse
-- ----------------------------
ALTER TABLE [dbo].[CoachCourse] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachCourseJoin
-- ----------------------------
CREATE CLUSTERED INDEX [IXC_CoachCourseJoin_CourseId] ON [dbo].[CoachCourseJoin]
([CourseId] ASC) 
GO
CREATE INDEX [IX_CoachCourseJoin_StudentId] ON [dbo].[CoachCourseJoin]
([StudentId] ASC) 
GO
CREATE INDEX [IX_CoachCourseJoin_CoachId] ON [dbo].[CoachCourseJoin]
([CoachId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table CoachCourseJoin
-- ----------------------------
ALTER TABLE [dbo].[CoachCourseJoin] ADD PRIMARY KEY NONCLUSTERED ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachCoursePersonInfo
-- ----------------------------
CREATE INDEX [IX_CoachCoursePersonInfo_CourseId] ON [dbo].[CoachCoursePersonInfo]
([CourseId] ASC) 
GO

-- ----------------------------
-- Indexes structure for table CoachFrequentStudent
-- ----------------------------
CREATE UNIQUE INDEX [IX_CoachFrequentStudent_Id] ON [dbo].[CoachFrequentStudent]
([Id] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO
CREATE INDEX [IX_CoachFrequentStudent_CreatorId] ON [dbo].[CoachFrequentStudent]
([CreatorId] ASC) 
GO

-- ----------------------------
-- Indexes structure for table CoachIncome
-- ----------------------------
CREATE CLUSTERED INDEX [IXC_CoachIncome_CoachId] ON [dbo].[CoachIncome]
([CoachId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table CoachIncome
-- ----------------------------
ALTER TABLE [dbo].[CoachIncome] ADD PRIMARY KEY NONCLUSTERED ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachLeave
-- ----------------------------
CREATE INDEX [IX_CoachLeave_State] ON [dbo].[CoachLeave]
([State] ASC) 
GO
CREATE INDEX [IX_CoachLeave_CoachId] ON [dbo].[CoachLeave]
([CoachId] ASC) 
GO

-- ----------------------------
-- Indexes structure for table CoachOrderTrialCourse
-- ----------------------------
CREATE CLUSTERED INDEX [IXC_CoachOrderTrialCourse_StudentId] ON [dbo].[CoachOrderTrialCourse]
([StudentId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table CoachOrderTrialCourse
-- ----------------------------
ALTER TABLE [dbo].[CoachOrderTrialCourse] ADD PRIMARY KEY NONCLUSTERED ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachOrganization
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table CoachOrganization
-- ----------------------------
ALTER TABLE [dbo].[CoachOrganization] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachPrice
-- ----------------------------
CREATE UNIQUE CLUSTERED INDEX [IXC_CoachPrice_CityCode] ON [dbo].[CoachPrice]
([CityCode] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Indexes structure for table CoachStudentMoney
-- ----------------------------
CREATE CLUSTERED INDEX [IXC_CoachStudentMoney_StudentUserId] ON [dbo].[CoachStudentMoney]
([StudentUserId] ASC) 
GO
CREATE INDEX [IX_CoachStudentMoney_CoachId] ON [dbo].[CoachStudentMoney]
([CoachId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table CoachStudentMoney
-- ----------------------------
ALTER TABLE [dbo].[CoachStudentMoney] ADD PRIMARY KEY NONCLUSTERED ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachStudentMoneyNotPay
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table CoachStudentMoneyNotPay
-- ----------------------------
ALTER TABLE [dbo].[CoachStudentMoneyNotPay] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachStudentRemark
-- ----------------------------
CREATE CLUSTERED INDEX [IXC_CoachStudentRemark_StudentId] ON [dbo].[CoachStudentRemark]
([StudentId] ASC) 
GO
CREATE INDEX [IX_CoachStudentRemark_CourseId] ON [dbo].[CoachStudentRemark]
([CourseId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table CoachStudentRemark
-- ----------------------------
ALTER TABLE [dbo].[CoachStudentRemark] ADD PRIMARY KEY NONCLUSTERED ([Id])
GO

-- ----------------------------
-- Indexes structure for table CoachTeachingPointCoaches
-- ----------------------------
CREATE CLUSTERED INDEX [IXC_CoachTeachingPointCoaches_VenueId] ON [dbo].[CoachTeachingPointCoaches]
([VenueId] ASC) 
GO

-- ----------------------------
-- Indexes structure for table CoachTrainingPlan
-- ----------------------------
CREATE INDEX [IX_CoachTrainingPlan_StudentId] ON [dbo].[CoachTrainingPlan]
([StudentId] ASC) 
GO
CREATE INDEX [IX_CoachTrainingPlan_CoachId] ON [dbo].[CoachTrainingPlan]
([CoachId] ASC) 
GO

-- ----------------------------
-- Indexes structure for table CoachUserFavorite
-- ----------------------------
CREATE CLUSTERED INDEX [IXC_CoachUserFavorite_UserId] ON [dbo].[CoachUserFavorite]
([UserId] ASC) 
GO
CREATE INDEX [IX_CoachUserFavorite_Favorite] ON [dbo].[CoachUserFavorite]
([FavoriteId] ASC) 
GO

-- ----------------------------
-- Indexes structure for table Company
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Company
-- ----------------------------
ALTER TABLE [dbo].[Company] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table CompanyVenues
-- ----------------------------
CREATE UNIQUE INDEX [IX_CompanyVenues_VenueId] ON [dbo].[CompanyVenues]
([VenueId] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO
CREATE INDEX [IX_CompanyVenues_CompanyId] ON [dbo].[CompanyVenues]
([CompanyId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table CompanyVenues
-- ----------------------------
ALTER TABLE [dbo].[CompanyVenues] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Config
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Config
-- ----------------------------
ALTER TABLE [dbo].[Config] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table CostType
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table CostType
-- ----------------------------
ALTER TABLE [dbo].[CostType] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table FileInfo
-- ----------------------------
CREATE INDEX [IX_FileInfo_MasterId] ON [dbo].[FileInfo]
([MasterId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table FileInfo
-- ----------------------------
ALTER TABLE [dbo].[FileInfo] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Game
-- ----------------------------
CREATE INDEX [IX_Game_CreateDate] ON [dbo].[Game]
([CreateDate] ASC) 
GO
CREATE INDEX [IX_Game_CreatorId] ON [dbo].[Game]
([CreatorId] ASC) 
GO
CREATE INDEX [IX_Game_PlayBeginTime] ON [dbo].[Game]
([PlayBeginTime] ASC) 
GO
CREATE INDEX [IX_Game_ActivityId] ON [dbo].[Game]
([ActivityId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table Game
-- ----------------------------
ALTER TABLE [dbo].[Game] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table GameGroup
-- ----------------------------
CREATE INDEX [IX_GameGroup_GameId] ON [dbo].[GameGroup]
([GameId] ASC) 
GO
CREATE INDEX [IX_GameGroup_OrderId] ON [dbo].[GameGroup]
([OrderId] ASC) 
GO
CREATE INDEX [IX_GameGroup_OrderNo] ON [dbo].[GameGroup]
([OrderNo] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table GameGroup
-- ----------------------------
ALTER TABLE [dbo].[GameGroup] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table GameGroupMember
-- ----------------------------
CREATE INDEX [IX_GameGroupMember_GameId] ON [dbo].[GameGroupMember]
([GameId] ASC) 
GO
CREATE INDEX [IX_GameGroupMember_GroupId] ON [dbo].[GameGroupMember]
([GroupId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table GameGroupMember
-- ----------------------------
ALTER TABLE [dbo].[GameGroupMember] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table GameJudge
-- ----------------------------
CREATE INDEX [IX_GameJudge_GameId] ON [dbo].[GameJudge]
([GameId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table GameJudge
-- ----------------------------
ALTER TABLE [dbo].[GameJudge] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table GameLoop
-- ----------------------------
CREATE INDEX [IX_GameLoop_GameId] ON [dbo].[GameLoop]
([GameId] ASC) 
GO
CREATE INDEX [IX_GameLoop_OrderId] ON [dbo].[GameLoop]
([OrderId] ASC) 
GO
CREATE INDEX [IX_GameLoop_GroupId] ON [dbo].[GameLoop]
([GroupId] ASC) 
GO
CREATE INDEX [IX_GameLoop_KnockLoopId] ON [dbo].[GameLoop]
([KnockLoopId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table GameLoop
-- ----------------------------
ALTER TABLE [dbo].[GameLoop] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table GameLoopDetail
-- ----------------------------
CREATE INDEX [IX_GameLoopDetail_LoopId] ON [dbo].[GameLoopDetail]
([LoopId] ASC) 
GO
CREATE INDEX [IX_GameLoopDetail_MapId] ON [dbo].[GameLoopDetail]
([MapId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table GameLoopDetail
-- ----------------------------
ALTER TABLE [dbo].[GameLoopDetail] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table GameLoopMap
-- ----------------------------
CREATE INDEX [IX_GameLoopMap_LoopId] ON [dbo].[GameLoopMap]
([LoopId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table GameLoopMap
-- ----------------------------
ALTER TABLE [dbo].[GameLoopMap] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table GameOrder
-- ----------------------------
CREATE INDEX [IX_GameOrder_GameId] ON [dbo].[GameOrder]
([GameId] ASC) 
GO
CREATE INDEX [IX_GameOrder_PreOrderId] ON [dbo].[GameOrder]
([PreOrderId] ASC) 
GO
CREATE INDEX [IX_GameOrder_NextOrderId] ON [dbo].[GameOrder]
([NextOrderId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table GameOrder
-- ----------------------------
ALTER TABLE [dbo].[GameOrder] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table GameTeam
-- ----------------------------
CREATE INDEX [IX_GameTeam_GameId] ON [dbo].[GameTeam]
([GameId] ASC) 
GO
CREATE INDEX [IX_GameTeam_State] ON [dbo].[GameTeam]
([State] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table GameTeam
-- ----------------------------
ALTER TABLE [dbo].[GameTeam] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table GameTeamLoopTemplet
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table GameTeamLoopTemplet
-- ----------------------------
ALTER TABLE [dbo].[GameTeamLoopTemplet] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table GameTeamLoopTempletDetail
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table GameTeamLoopTempletDetail
-- ----------------------------
ALTER TABLE [dbo].[GameTeamLoopTempletDetail] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table GameTeamLoopTempletMap
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table GameTeamLoopTempletMap
-- ----------------------------
ALTER TABLE [dbo].[GameTeamLoopTempletMap] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Limit
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Limit
-- ----------------------------
ALTER TABLE [dbo].[Limit] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table LimitName
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table LimitName
-- ----------------------------
ALTER TABLE [dbo].[LimitName] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table LimitRole
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table LimitRole
-- ----------------------------
ALTER TABLE [dbo].[LimitRole] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MobileValCode
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MobileValCode
-- ----------------------------
ALTER TABLE [dbo].[MobileValCode] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Msg
-- ----------------------------
CREATE INDEX [IX_Msg_ReceiverId] ON [dbo].[Msg]
([ReceiverId] ASC) 
GO
CREATE INDEX [IX_Msg_CreateDate] ON [dbo].[Msg]
([CreateDate] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table Msg
-- ----------------------------
ALTER TABLE [dbo].[Msg] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table MsgReg
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table MsgReg
-- ----------------------------
ALTER TABLE [dbo].[MsgReg] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table NationalFlag
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table NationalFlag
-- ----------------------------
ALTER TABLE [dbo].[NationalFlag] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Note
-- ----------------------------
CREATE INDEX [IX_Note_CreatorId] ON [dbo].[Note]
([CreatorId] ASC) 
GO
CREATE INDEX [IX_Note_CreateDate] ON [dbo].[Note]
([CreateDate] ASC) 
GO
CREATE INDEX [IX_Note_MasterId] ON [dbo].[Note]
([MasterId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table Note
-- ----------------------------
ALTER TABLE [dbo].[Note] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table NoteCreatorHide
-- ----------------------------
CREATE CLUSTERED INDEX [IX_WantHideUserId] ON [dbo].[NoteCreatorHide]
([WantHideUserId] ASC) 
GO

-- ----------------------------
-- Indexes structure for table NoteHide
-- ----------------------------
CREATE CLUSTERED INDEX [IX_WantHideUserId] ON [dbo].[NoteHide]
([WantHideUserId] ASC) 
GO

-- ----------------------------
-- Indexes structure for table NoteReply
-- ----------------------------
CREATE CLUSTERED INDEX [IXC_NoteReply_NoteId] ON [dbo].[NoteReply]
([NoteId] ASC) 
GO
CREATE INDEX [IX_NoteReply_UserId] ON [dbo].[NoteReply]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table NoteReply
-- ----------------------------
ALTER TABLE [dbo].[NoteReply] ADD PRIMARY KEY NONCLUSTERED ([Id])
GO

-- ----------------------------
-- Indexes structure for table NoteSupport
-- ----------------------------
CREATE CLUSTERED INDEX [IXC_NoteSupport_NoteId] ON [dbo].[NoteSupport]
([NoteId] ASC) 
GO
CREATE INDEX [IX_NoteSupport_UserId] ON [dbo].[NoteSupport]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table NoteSupport
-- ----------------------------
ALTER TABLE [dbo].[NoteSupport] ADD PRIMARY KEY NONCLUSTERED ([Id])
GO

-- ----------------------------
-- Indexes structure for table OnlineUser
-- ----------------------------
CREATE INDEX [IX_OnlineUser_UserId] ON [dbo].[OnlineUser]
([UserId] ASC) 
GO
CREATE INDEX [IX_OnlineUser_Token] ON [dbo].[OnlineUser]
([Token] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table OnlineUser
-- ----------------------------
ALTER TABLE [dbo].[OnlineUser] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Organization
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Organization
-- ----------------------------
ALTER TABLE [dbo].[Organization] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table QRCode
-- ----------------------------
CREATE UNIQUE CLUSTERED INDEX [IX_MatesrID_ActionType_BusinessType] ON [dbo].[QRCode]
([MasterId] ASC, [ActionType] ASC, [BusinessType] ASC) 
WITH (IGNORE_DUP_KEY = ON)
GO

-- ----------------------------
-- Indexes structure for table ScoreRange
-- ----------------------------
CREATE INDEX [IX_ScoreRange_BeginScore] ON [dbo].[ScoreRange]
([BeginScore] ASC) 
GO
CREATE INDEX [IX_ScoreRange_EndScore] ON [dbo].[ScoreRange]
([EndScore] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table ScoreRange
-- ----------------------------
ALTER TABLE [dbo].[ScoreRange] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SerialNo
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SerialNo
-- ----------------------------
ALTER TABLE [dbo].[SerialNo] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SportType
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SportType
-- ----------------------------
ALTER TABLE [dbo].[SportType] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table SysLog
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table SysLog
-- ----------------------------
ALTER TABLE [dbo].[SysLog] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table TestInfo
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table TestInfo
-- ----------------------------
ALTER TABLE [dbo].[TestInfo] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Transfer
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Transfer
-- ----------------------------
ALTER TABLE [dbo].[Transfer] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UserAccount
-- ----------------------------
CREATE INDEX [IX_UserAccount_CreateDate] ON [dbo].[UserAccount]
([CreateDate] ASC) 
GO
CREATE INDEX [IX_UserAccount_Mobile] ON [dbo].[UserAccount]
([Mobile] ASC) 
GO
CREATE INDEX [IX_UserAccount_PetName] ON [dbo].[UserAccount]
([PetName] ASC) 
GO
CREATE INDEX [IX_UserAccount_CardName] ON [dbo].[UserAccount]
([CardName] ASC) 
GO
CREATE INDEX [IX_UserAccount_Code] ON [dbo].[UserAccount]
([Code] ASC) 
GO
CREATE INDEX [IX_UserAccount_Password] ON [dbo].[UserAccount]
([Password] ASC) 
GO
CREATE INDEX [IX_UserAccount_WeiXinUnionId] ON [dbo].[UserAccount]
([WeiXinUnionId] ASC) 
GO
CREATE INDEX [IX_UserAccount_QQOpenId] ON [dbo].[UserAccount]
([QQOpenId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table UserAccount
-- ----------------------------
ALTER TABLE [dbo].[UserAccount] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UserFriend
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UserFriend
-- ----------------------------
ALTER TABLE [dbo].[UserFriend] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UserLimit
-- ----------------------------
CREATE INDEX [IX_UserLimit_UserId] ON [dbo].[UserLimit]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table UserLimit
-- ----------------------------
ALTER TABLE [dbo].[UserLimit] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UserLimitRequest
-- ----------------------------
CREATE INDEX [IX_UserLimitRequest_UserId] ON [dbo].[UserLimitRequest]
([UserId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table UserLimitRequest
-- ----------------------------
ALTER TABLE [dbo].[UserLimitRequest] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UserScoreHistory
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UserScoreHistory
-- ----------------------------
ALTER TABLE [dbo].[UserScoreHistory] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UserSign
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UserSign
-- ----------------------------
ALTER TABLE [dbo].[UserSign] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UserSport
-- ----------------------------
CREATE INDEX [IX_UserSport_UserId] ON [dbo].[UserSport]
([UserId] ASC) 
GO
CREATE INDEX [IX_UserSport_SportId] ON [dbo].[UserSport]
([SportId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table UserSport
-- ----------------------------
ALTER TABLE [dbo].[UserSport] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Venue
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Venue
-- ----------------------------
ALTER TABLE [dbo].[Venue] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table VenueDiscount
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table VenueDiscount
-- ----------------------------
ALTER TABLE [dbo].[VenueDiscount] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table VenueStudents
-- ----------------------------
CREATE INDEX [IX_VenueStudents_UserId] ON [dbo].[VenueStudents]
([UserId] ASC) 
GO
CREATE INDEX [IX_VenueStudents_VenueId] ON [dbo].[VenueStudents]
([VenueId] ASC) 
GO

-- ----------------------------
-- Primary Key structure for table VenueStudents
-- ----------------------------
ALTER TABLE [dbo].[VenueStudents] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table VipAccount
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table VipAccount
-- ----------------------------
ALTER TABLE [dbo].[VipAccount] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table VipBill
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table VipBill
-- ----------------------------
ALTER TABLE [dbo].[VipBill] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table VipBillDetail
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table VipBillDetail
-- ----------------------------
ALTER TABLE [dbo].[VipBillDetail] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table VipBuy
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table VipBuy
-- ----------------------------
ALTER TABLE [dbo].[VipBuy] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table VipCostScale
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table VipCostScale
-- ----------------------------
ALTER TABLE [dbo].[VipCostScale] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table VipRechargeScale
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table VipRechargeScale
-- ----------------------------
ALTER TABLE [dbo].[VipRechargeScale] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table VipRefund
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table VipRefund
-- ----------------------------
ALTER TABLE [dbo].[VipRefund] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table VipUse
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table VipUse
-- ----------------------------
ALTER TABLE [dbo].[VipUse] ADD PRIMARY KEY ([Id])
GO
