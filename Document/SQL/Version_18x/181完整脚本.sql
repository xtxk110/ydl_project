--修改版本号
 UPDATE dbo.AppVersion SET 
	AndroidCode='182' ,
	AndroidName='1.8.2',
	IosCode='182',
	IosName='1.8.2',
	CreateDate=GETDATE(),
	IsRelease=1
WHERE Id='BCB89F64-83D3-4FC6-BC29-39D49CD1BD3D'

 
--预制数据
IF	(NOT EXISTS(SELECT * FROM dbo.BaseData WHERE Id='027005'))
BEGIN

INSERT INTO [dbo].[BaseData]
        ( [Id] ,
          [Name] ,
          [GroupId] ,
          [SortIndex] ,
          [IsEnable] ,
          [MapName]
        )
VALUES  ( N'027005' , -- Id - nvarchar(50)
          N'集训课' , -- Name - nvarchar(50)
          N'027' , -- GroupId - nvarchar(50)
          1 , -- SortIndex - int
          1, -- IsEnable - bit
          N''  -- MapName - nvarchar(50)
        )
        
END

GO

--表修改
IF COL_LENGTH('CoachStudentMoney','CoachBootcampId') IS NULL
 BEGIN
	ALTER TABLE dbo.CoachStudentMoney ADD CoachBootcampId NVARCHAR(50) 
 END

 IF COL_LENGTH('CoachStudentMoneyNotPay','CoachBootcampId') IS NULL
 BEGIN
	ALTER TABLE dbo.CoachStudentMoneyNotPay ADD CoachBootcampId NVARCHAR(50) 
 END

 
--集训表

/****** Object:  Table [dbo].[CoachBootcamp]    Script Date: 2017/6/9 16:52:31 ******/

IF OBJECT_ID('CoachBootcamp', 'U') IS  NULL 
BEGIN 
CREATE TABLE [dbo].[CoachBootcamp](
	[Id] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[State] [nvarchar](50) NULL,
	[Price] [numeric](18, 2) NULL,
	[DiscountPrice] [numeric](18, 2) NULL,
	[BeginTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[JoinDeadline] [datetime] NULL,
	[VenueId] [nvarchar](50) NULL,
	[Remark] [nvarchar](4000) NULL,
	[HeadUrl] [nvarchar](200) NULL,
	[UpdateDate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_CoachBootcamp] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Table [dbo].[CoachBootcampCourse]    Script Date: 2017/6/9 16:52:31 ******/
 
IF OBJECT_ID('CoachBootcampCourse', 'U') IS  NULL 
BEGIN 
CREATE TABLE [dbo].[CoachBootcampCourse](
	[Id] [nvarchar](50) NOT NULL,
	[CoachBootcampId] [nvarchar](50) NULL,
	[BeginTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[CourseContent] [nvarchar](2000) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_CoachBootcampCourse] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IXC_CoachBootcampCourse_CoachBootcampId]    Script Date: 2017/6/9 16:52:31 ******/
CREATE NONCLUSTERED INDEX [IXC_CoachBootcampCourse_CoachBootcampId] ON [dbo].[CoachBootcampCourse]
(
	[CoachBootcampId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END

 ----存储过程和函数

 
  
/****** Object:  UserDefinedFunction [dbo].[fn_Trim]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_Trim]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Split]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_Split]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_SimpleContent]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_SimpleContent]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_SamePart]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_SamePart]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_NewId]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_NewId]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Link]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_Link]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetVenueUserUseCount]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetVenueUserUseCount]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetVenueNameString]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetVenueNameString]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserPetName]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetUserPetName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserNameString]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetUserNameString]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserName]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetUserName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkPetName]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetUserLinkPetName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkName]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetUserLinkName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkCardName]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetUserLinkCardName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetTeachingPointCoachNames]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetTeachingPointCoachNames]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetTeachingPointCoachIds]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetTeachingPointCoachIds]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetSignCount]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetSignCount]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetReplyCount]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetReplyCount]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetLinkVenueName]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetLinkVenueName]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetGameTeamScore]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetGameTeamScore]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetFinalRank]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetFinalRank]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetDistance]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetDistance]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetDate]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetDate]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoacherScore]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetCoacherScore]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoachAVGScore]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetCoachAVGScore]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoachAge]    Script Date: 2017/6/9 16:52:31 ******/
DROP FUNCTION [dbo].[fn_GetCoachAge]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateUserSign]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_ValidateUserSign]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateUser]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_ValidateUser]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateGameTeam]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_ValidateGameTeam]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateClubActivity]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_ValidateClubActivity]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateValCode]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_UpdateValCode]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTransferCreatorId]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_UpdateTransferCreatorId]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePassword]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_UpdatePassword]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateGameSportScore]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_UpdateGameSportScore]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateGameClubScore]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_UpdateGameClubScore]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetVenueVip]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SetVenueVip]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetVenueReleased]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SetVenueReleased]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetStudentReleased]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SetStudentReleased]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetGameTopState]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SetGameTopState]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetGameState]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SetGameState]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetGameLoopState]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SetGameLoopState]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetCompanyIsStop]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SetCompanyIsStop]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetActivityState]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SetActivityState]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipUsePay]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveVipUsePay]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipUse]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveVipUse]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipRefund]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveVipRefund]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipInnerDiscount]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveVipInnerDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipDiscount]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveVipDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipCostScale]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveVipCostScale]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVipBuyPay]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveVipBuyPay]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVenueDiscount]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveVenueDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVenueBillPay]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveVenueBillPay]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveUserSport]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveUserSport]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveQuickUser]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveQuickUser]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveNoteSupport]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveNoteSupport]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveMsgReg]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveMsgReg]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveGameGroupLeader]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveGameGroupLeader]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveCourseAutoBookSettings]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveCourseAutoBookSettings]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveCoachCourseJoin]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveCoachCourseJoin]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveClubRequest]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveClubRequest]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveCity]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_SaveCity]
GO
/****** Object:  StoredProcedure [dbo].[sp_ResetGameLoop]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_ResetGameLoop]
GO
/****** Object:  StoredProcedure [dbo].[sp_RemoveVenueTimetables]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_RemoveVenueTimetables]
GO
/****** Object:  StoredProcedure [dbo].[sp_QueryRechargeReport]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_QueryRechargeReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_QueryBillReport]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_QueryBillReport]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBillList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipVenueBillList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBillDetailList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipVenueBillDetailList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBill]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipVenueBill]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipUseList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipUseList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipUse]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipUse]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipRefundList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipRefundList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipRefund]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipRefund]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipInnerDiscountList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipInnerDiscountList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipInnerDiscount]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipInnerDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipDiscountList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipDiscountList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipDiscount]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipDayBook]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipDayBook]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipCostScaleList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipCostScaleList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipCityDiscount]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipCityDiscount]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipBuyList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipBuyList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipBuy]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipBuy]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipAccountList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipAccountList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVipAccount]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVipAccount]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueTimetablesList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVenueTimetablesList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueSignList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVenueSignList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListForGraph]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVenueListForGraph]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListForAudit]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVenueListForAudit]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListAllForCoacher]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVenueListAllForCoacher]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVenueList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenueDiscountList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVenueDiscountList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVenue]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetVenue]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserSportList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetUserSportList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserSignList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetUserSignList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserScoreHistoryList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetUserScoreHistoryList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetUserList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserLimitRequestList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetUserLimitRequestList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserLimitList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetUserLimitList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUser]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetUser]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTeachingPointList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetTeachingPointList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTeachingPointCoachList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetTeachingPointCoachList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSyllabusTeachingPointList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetSyllabusTeachingPointList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentTimesStatistics]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetStudentTimesStatistics]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentTimesBalance]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetStudentTimesBalance]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentsOfBookCourse]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetStudentsOfBookCourse]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMyCourse]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetStudentMyCourse]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMonthStatistics]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetStudentMonthStatistics]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMonthPayListByYear]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetStudentMonthPayListByYear]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetStudentList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudentBookList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetStudentBookList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSerialNo1]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetSerialNo1]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSerialNo]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetSerialNo]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrganizationList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetOrganizationList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrderTrialCourseList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetOrderTrialCourseList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOnlineUser]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetOnlineUser]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNoteSupportList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetNoteSupportList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNoteReplyList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetNoteReplyList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNoteList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetNoteList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNote]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetNote]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNearbyTeachingPointList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetNearbyTeachingPointList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetMsgList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetMsgList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGeneralUserList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGeneralUserList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTopList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameTopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeamListForKnock]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameTeamListForKnock]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeamList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameTeamList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeam]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameTeam]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTableList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameTableList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameRankList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameRankList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameProgress]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameProgress]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameOrderLoopList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameOrderLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameOrderList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameOrderList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameMyLoopList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameMyLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopMapList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameLoopMapList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopDetailList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameLoopDetailList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameKnockLoopList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameKnockLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameJudgeLoopList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameJudgeLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameJudgeList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameJudgeList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupRankList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameGroupRankList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupMemberList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameGroupMemberList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupLoopList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameGroupLoopList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGameGroupList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGame]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetGame]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDynamicVenueBill]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetDynamicVenueBill]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetContactCategoryList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetContactCategoryList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompanyList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCompanyList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompany]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCompany]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachTeachingCourseList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoachTeachingCourseList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachPriceList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoachPriceList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoachList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherMyStudentList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherMyStudentList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherListForSelect]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherListForSelect]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherListForGradeUpgrade]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherListForGradeUpgrade]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherCourseVenueList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherCourseVenueList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherCourseStudentList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherCourseStudentList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherApply]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoacherApply]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoacher]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoacher]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachCommentList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoachCommentList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachBootcampListForStudent]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoachBootcampListForStudent]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachBootcampList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoachBootcampList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachBootcampCourseList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoachBootcampCourseList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachAuditList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCoachAuditList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubUserList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetClubUserList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubRequestList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetClubRequestList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubMyList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetClubMyList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetClubList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClubAddressList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetClubAddressList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClub]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetClub]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCityList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetCityList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetBootcampJoinedStudentList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetBootcampJoinedStudentList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetActivityUserList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetActivityUserList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetActivityList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetActivityList]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetActivity]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_GetActivity]
GO
/****** Object:  StoredProcedure [dbo].[sp_FinishGameOrder]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_FinishGameOrder]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteOnlineUser]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_DeleteOnlineUser]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameTeamById]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_DeleteGameTeamById]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameTeam]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_DeleteGameTeam]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameGroup]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_DeleteGameGroup]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameAllDetail]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_DeleteGameAllDetail]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateVipVenueBill]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_CreateVipVenueBill]
GO
/****** Object:  StoredProcedure [dbo].[sp_CoachAuditPass]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_CoachAuditPass]
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckGameSign]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_CheckGameSign]
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckGameGroupState]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_CheckGameGroupState]
GO
/****** Object:  StoredProcedure [dbo].[sp_CancelVipUse]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_CancelVipUse]
GO
/****** Object:  StoredProcedure [dbo].[sp_CancelVipRefund]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_CancelVipRefund]
GO
/****** Object:  StoredProcedure [dbo].[sp_CancelVenueBill]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_CancelVenueBill]
GO
/****** Object:  StoredProcedure [dbo].[sp_CancelCourseAutoBook]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_CancelCourseAutoBook]
GO
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateTestGameTeam]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_AutoCreateTestGameTeam]
GO
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateCourseBookByMonth]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_AutoCreateCourseBookByMonth]
GO
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateCourseBook]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_AutoCreateCourseBook]
GO
/****** Object:  StoredProcedure [dbo].[sp_AuditClubRequest]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[sp_AuditClubRequest]
GO
/****** Object:  StoredProcedure [dbo].[GetStudentJoinCourseList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[GetStudentJoinCourseList]
GO
/****** Object:  StoredProcedure [dbo].[GetStudentCourseRemarkList]    Script Date: 2017/6/9 16:52:31 ******/
DROP PROCEDURE [dbo].[GetStudentCourseRemarkList]
GO
/****** Object:  StoredProcedure [dbo].[GetStudentCourseRemarkList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[GetStudentJoinCourseList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_AuditClubRequest]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateCourseBook]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateCourseBookByMonth]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_AutoCreateTestGameTeam]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CancelCourseAutoBook]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CancelVenueBill]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CancelVipRefund]    Script Date: 2017/6/9 16:52:31 ******/
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
            SET @message = '单据在处理中，无法取消，请刷新状态。'

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_CancelVipUse]    Script Date: 2017/6/9 16:52:31 ******/
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
            SET @message = '单据已支付，不能取消。';
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_CheckGameGroupState]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CheckGameSign]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CoachAuditPass]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_CreateVipVenueBill]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameAllDetail]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameGroup]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameTeam]    Script Date: 2017/6/9 16:52:31 ******/
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
            SET @message = '报名已经审核通过，请联系赛事管理员取消报名。'

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGameTeamById]    Script Date: 2017/6/9 16:52:31 ******/
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
            SET @message = '该队伍已经分配了比赛，不能取消。'
        ELSE
            DELETE  FROM dbo.GameTeam
            WHERE   Id = @teamId AND GameId=@gameId
    END


GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteOnlineUser]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_FinishGameOrder]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetActivity]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetActivityList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetActivityUserList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetBootcampJoinedStudentList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetCityList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetClub]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetClubAddressList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetClubList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetClubMyList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetClubRequestList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetClubUserList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoachAuditList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoachBootcampCourseList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetCoachBootcampCourseList]
    @CoachBootcampId NVARCHAR(50) ,
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
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
				SELECT 
					@rowCount=COUNT(*) 
				FROM CoachBootcampCourse 
				WHERE CoachBootcampId=@CoachBootcampId

				'+ @filter
			
                EXEC SP_EXECUTESQL @sql,
                    N'@BeginTime NVARCHAR(100),@EndTime NVARCHAR(100), @CoachBootcampId NVARCHAR(50), @rowCount INT OUTPUT',
                    @BeginTime,@EndTime,@CoachBootcampId,@rowCount OUTPUT
            END
        ELSE
            SET @rowCount = 0
		
      	--分页取数据	
        SET @sql = '
					 
				SELECT 
					*
				FROM CoachBootcampCourse 
				WHERE CoachBootcampId=@CoachBootcampId
				'+ @filter +'
				ORDER BY BeginTime 
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY

				'

		--PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@BeginTime NVARCHAR(100),@EndTime NVARCHAR(100), @CoachBootcampId NVARCHAR(50),@pageIndex INT,@pageSize INT',
              @BeginTime,@EndTime, @CoachBootcampId ,@pageIndex, @pageSize

		
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCoachBootcampList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoachBootcampListForStudent]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoachCommentList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoacher]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherApply]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherCourseStudentList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherCourseVenueList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherListForGradeUpgrade]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherListForSelect]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoacherMyStudentList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoachList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoachPriceList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCoachTeachingCourseList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCompany]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCompanyList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetContactCategoryList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetDynamicVenueBill]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetGame]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupLoopList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupMemberList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameGroupRankList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameJudgeList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameJudgeLoopList]    Script Date: 2017/6/9 16:52:31 ******/
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
				--排除小组轮空的比赛，淘汰赛轮空由裁判处理
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameKnockLoopList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameList]    Script Date: 2017/6/9 16:52:31 ******/
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

		--非俱乐部成员不能看见未加入俱乐部赛事
        SET @filter = @filter
            + ' AND (ISNULL(a.ClubId,'''')='''' OR ISNULL(a.ClubId,'''')!='''' AND EXISTS(SELECT * FROM dbo.ClubUser x WHERE x.ClubId=a.ClubId AND x.UserId=@userId))'

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
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopDetailList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameLoopMapList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameMyLoopList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameOrderList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameOrderLoopList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameProgress]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameRankList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
        
        DECLARE @sql NVARCHAR(MAX)
		
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
            SET @message = '比赛尚未结束，无法排名。';
        
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTableList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeam]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
                a.CreateDate
        FROM    GameTeam a
                INNER JOIN dbo.Game g ON g.Id = a.GameId
                INNER JOIN UserAccount b ON a.CreatorId = b.Id
                INNER JOIN BaseData d ON a.State = d.Id
				LEFT JOIN dbo.Company c ON c.Id = a.CompanyId
        WHERE   CHARINDEX(a.Id, @TeamId) > 0
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeamList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameTeamListForKnock]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetGameTopList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetGeneralUserList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetMsgList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetNearbyTeachingPointList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetNote]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetNoteList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetNoteReplyList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetNoteSupportList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetOnlineUser]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetOrderTrialCourseList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetOrganizationList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetSerialNo]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetSerialNo1]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetStudentBookList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetStudentList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMonthPayListByYear]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMonthStatistics]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetStudentMyCourse]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetStudentsOfBookCourse]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetStudentTimesBalance]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetStudentTimesStatistics]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetSyllabusTeachingPointList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetTeachingPointCoachList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetTeachingPointList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetUser]    Script Date: 2017/6/9 16:52:31 ******/
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
				)/*是否为教练*/
        FROM    dbo.UserAccount a
        LEFT JOIN dbo.City b ON a.CityId=b.Id
        WHERE a.Id=@userId
        
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserLimitList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetUserLimitRequestList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetUserList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetUserScoreHistoryList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetUserSignList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetUserSportList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVenue]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVenueDiscountList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVenueList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListAllForCoacher]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
        SET @filter = ''
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
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListForAudit]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVenueListForGraph]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVenueSignList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetVenueTimetablesList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipAccount]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipAccountList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipBuy]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipBuyList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipCityDiscount]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipCostScaleList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipDayBook]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipDiscount]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipDiscountList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipInnerDiscount]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipInnerDiscountList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipRefund]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipRefundList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipUse]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipUseList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBill]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBillDetailList]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetVipVenueBillList]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_QueryBillReport]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_QueryRechargeReport]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RemoveVenueTimetables]    Script Date: 2017/6/9 16:52:31 ******/
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
			SET @errMsg='此课程时段已在使用中，无法删除。'
		END
		ELSE
			DELETE FROM CoachVenueTimetables WHERE Id=@Id

    END

GO
/****** Object:  StoredProcedure [dbo].[sp_ResetGameLoop]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveCity]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveClubRequest]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveCoachCourseJoin]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_SaveCourseAutoBookSettings]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_SaveGameGroupLeader]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveMsgReg]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveNoteSupport]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveQuickUser]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveUserSport]    Script Date: 2017/6/9 16:52:31 ******/
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
                SET @message = '运动类型已经定义。'
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
			--更新--
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

					--记录积分变动记录
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
				--删除--
                    DELETE  dbo.UserSport
                    WHERE   Id = @Id
			

    END


GO
/****** Object:  StoredProcedure [dbo].[sp_SaveVenueBillPay]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveVenueDiscount]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveVipBuyPay]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveVipCostScale]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveVipDiscount]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveVipInnerDiscount]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveVipRefund]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveVipUse]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveVipUsePay]    Script Date: 2017/6/9 16:52:31 ******/
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
                    @userId = CreatorId--从创建者帐号扣钱（自己支付，帮别人支付）
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
					--学员购买教练, 大课次数 支付成功后, 业务更新---------------------开始
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
					--学员购买教练, 大课次数 支付成功后, 业务更新---------------------结束

					---------------更新原始单据逻辑（@masterType，@masterId）-----------------------------------
					
                END
        END TRY

        BEGIN CATCH
            SET @message = '操作失败。' + ERROR_MESSAGE() 
        END CATCH 
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetActivityState]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SetCompanyIsStop]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SetGameLoopState]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SetGameState]    Script Date: 2017/6/9 16:52:31 ******/
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
                    EXEC dbo.sp_UpdateGameSportScore @gameId
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
/****** Object:  StoredProcedure [dbo].[sp_SetGameTopState]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SetStudentReleased]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_SetVenueReleased]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SetVenueVip]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateGameClubScore]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateGameSportScore]    Script Date: 2017/6/9 16:52:31 ******/
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
                WHERE   a.GameId = @GameId--排除轮空，弃权的比赛
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
/****** Object:  StoredProcedure [dbo].[sp_UpdatePassword]    Script Date: 2017/6/9 16:52:31 ******/
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
            SET @message = '原密码不正确。'
    END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTransferCreatorId]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateValCode]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidateClubActivity]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidateGameTeam]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidateUser]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidateUserSign]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoachAge]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoachAVGScore]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetCoacherScore]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetDate]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetDistance]    Script Date: 2017/6/9 16:52:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetFinalRank]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetGameTeamScore]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetLinkVenueName]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetReplyCount]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetSignCount]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetTeachingPointCoachIds]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetTeachingPointCoachNames]    Script Date: 2017/6/9 16:52:31 ******/
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
			@sql= @sql+'、'+b.CardName 
		FROM dbo.CoachTeachingPointCoaches  a
		INNER JOIN dbo.UserAccount b ON a.CoacherId=b.Id
		WHERE VenueId=@venueId
		
        RETURN @sql
    END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkCardName]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkName]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserLinkPetName]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserName]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserNameString]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserPetName]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetVenueNameString]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetVenueUserUseCount]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_Link]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_NewId]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_SamePart]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_SimpleContent]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_Split]    Script Date: 2017/6/9 16:52:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_Trim]    Script Date: 2017/6/9 16:52:31 ******/
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
