--剔除所有用户
DELETE FROM dbo.OnlineUser
--修改版本号
 UPDATE dbo.AppVersion SET 
	AndroidCode='188',
	AndroidName='2.0.0',
	IosCode='188',
	IosName='2.0.0',
	CreateDate=GETDATE(),
	IsRelease=1
WHERE Id='BCB89F64-83D3-4FC6-BC29-39D49CD1BD3D'

--新表
IF OBJECT_ID('YueDou', 'U') IS  NULL 
BEGIN

CREATE TABLE [dbo].YueDou(
	Id NVARCHAR(50) NOT NULL,
	UserId [NVARCHAR](50) NOT NULL,
	Balance INT NOT NULL DEFAULT 0,
	[CreateDate] [DATETIME] NOT NULL,
)  

END

IF OBJECT_ID('YueDouFlow', 'U') IS  NULL 
BEGIN

CREATE TABLE [dbo].YueDouFlow(
	Id NVARCHAR(50) NOT NULL,
	UserId [NVARCHAR](50) NOT NULL,
	FlowType NVARCHAR(100) NULL,
	Amount INT NOT NULL DEFAULT 0,
	ServiceCharge DECIMAL NULL DEFAULT 0,
	GameId [NVARCHAR](50)  NULL,
	GuessBetType  [NVARCHAR](50)  NULL,
	GuessId  [NVARCHAR](50)  NULL,
	[CreateDate] [DATETIME] NOT NULL,
)  

END 

IF OBJECT_ID('Guess', 'U') IS  NULL 
BEGIN

CREATE TABLE [dbo].Guess(
	[Id] [NVARCHAR](50) NOT NULL,
	GuessName [NVARCHAR](200) NOT NULL,
	[State] NVARCHAR(50) NULL,
	VsGameLoopId NVARCHAR(50)  NULL,
	VsOrderId  NVARCHAR(50)  NULL,
	VsOrderNo INT NULL,
	GuessType NVARCHAR(50) NOT NULL,
	VSLeftId NVARCHAR(50) NULL,
	VSLeftOdds DECIMAL(18,2) NULL,
	VsRightId NVARCHAR(50) NULL,
	VsRightOdds DECIMAL(18,2) NULL,
	BeginTime DATETIME NOT NULL,
	EndTime DATETIME NOT NULL,
	VictoryDefeatDeclarerDeposit DECIMAL(18,2) NULL,
	ScoreDeclarerDeposit DECIMAL(18,2) NULL,
	CreatorId NVARCHAR(50) NOT NULL,
	GameId NVARCHAR(50) NOT NULL,
	[CreateDate] [DATETIME] NOT NULL,
)  

END 

IF OBJECT_ID('GuessScore', 'U') IS  NULL 
BEGIN

CREATE TABLE [dbo].GuessScore(
	[Id] [NVARCHAR](50) NOT NULL,
	GuessId [NVARCHAR](50) NOT NULL,
	LeftScore INT NOT NULL,
	RightScore  INT NOT NULL,
	Odds  DECIMAL(18,2) NOT NULL,
	IsOddsAuto BIT NOT NULL,
	[CreateDate] [DATETIME] NOT NULL,
)  

END 

IF OBJECT_ID('GuessBet', 'U') IS  NULL 
BEGIN

CREATE TABLE [dbo].GuessBet(
	[Id] [NVARCHAR](50) NOT NULL,
	GuessId [NVARCHAR](50) NOT NULL,
	UserId [NVARCHAR](50) NOT NULL,
	BetType NVARCHAR(50) NOT NULL,
	Amount INT NOT NULL,
	BetVSId [NVARCHAR](50)  NULL,
	LeftScore INT  NULL,
	RightScore  INT  NULL,
	[CreateDate] [DATETIME] NOT NULL,
)  

END 

-- 表修改
IF COL_LENGTH('Config','YueDouConvertibleProportion') IS NULL
 BEGIN
	 ALTER TABLE dbo.Config ADD YueDouConvertibleProportion INT NULL DEFAULT (10) WITH VALUES
 END

 IF COL_LENGTH('Config','GuessServiceCharge') IS NULL
 BEGIN
	 ALTER TABLE dbo.Config ADD GuessServiceCharge DECIMAL NULL DEFAULT (10) WITH VALUES
 END
   

-- 预制数据
 IF	(NOT EXISTS(SELECT * FROM dbo.BaseData WHERE Id='016020001'))
BEGIN

INSERT INTO [dbo].[BaseData]
        ( [Id] ,
          [Name] ,
          [GroupId] ,
          [SortIndex] ,
          [IsEnable] ,
          [MapName]
        )
VALUES  ( N'016020001' , -- Id - nvarchar(50)
          N'购买悦豆支付' , -- Name - nvarchar(50)
          N'016' , -- GroupId - nvarchar(50)
          1 , -- SortIndex - int
          1, -- IsEnable - bit
          N''  -- MapName - nvarchar(50)
        )
        
END

GO

 --创建索引

 --存储过程和函数
 