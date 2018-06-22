--剔除所有用户
DELETE FROM dbo.OnlineUser
--修改版本号
 UPDATE dbo.AppVersion SET 
	AndroidCode='192',
	AndroidName='',
	IosCode='192',
	IosName='',
	CreateDate=GETDATE(),
	IsRelease=1
WHERE Id='BCB89F64-83D3-4FC6-BC29-39D49CD1BD3D'


IF NOT EXISTS(SELECT 1 FROM BaseData WHERE Id='021007')
BEGIN
	INSERT INTO BaseData(Id,Name,GroupId,SortIndex,IsEnable)
	VALUES('021007','①A-X②B-Y③AC-XZ④B-Z⑤C-Y','021',1,1)
END

IF NOT EXISTS(SELECT 1 FROM BaseData WHERE Id='021008')
BEGIN
	INSERT INTO BaseData(Id,Name,GroupId,SortIndex,IsEnable)
	VALUES('021008','①CD-YZ②A-W③B-X④C-Y⑤D-Z','021',1,1)
END
GO


--新表
 IF OBJECT_ID('LiveRoom', 'U') IS  NULL 
BEGIN

CREATE TABLE [dbo].LiveRoom(
	Id NVARCHAR(50) NOT NULL,
	LiveTitle [NVARCHAR](200) NOT NULL,
	AnchorId [NVARCHAR](50) NOT NULL,
	[State] [NVARCHAR](50) NOT NULL,
	GameId [NVARCHAR](50) NOT NULL,
	HeadUrl NVARCHAR(1000) NULL,
	VsOrderId [NVARCHAR](50)  NULL,
	VsGameLoopId  [NVARCHAR](50)  NULL,
	[CreateDate] [DATETIME] NOT NULL,
)  

END

 IF OBJECT_ID('ScoreGrade', 'U') IS  NULL 
BEGIN

CREATE TABLE [dbo].ScoreGrade(
	Id NVARCHAR(50) NOT NULL,
	LeftScore DECIMAL(18,2) NOT NULL,
	RightScore DECIMAL(18,2) NOT NULL,
	GradeName [NVARCHAR](50) NOT NULL,
	GradeIndex INT NOT NULL,
	[CreateDate] [DATETIME] NOT NULL,
)  

END
 
--表修改
IF COL_LENGTH('Game','IsConcessionScore') IS NULL
BEGIN
	ALTER TABLE dbo.Game ADD IsConcessionScore  BIT  NOT  NULL DEFAULT (0) WITH VALUES
END

IF COL_LENGTH('LiveRoom','NotPushCount') IS NULL
BEGIN
	ALTER TABLE dbo.LiveRoom ADD NotPushCount  INT  NULL DEFAULT (0) WITH VALUES
END

 --  IF COL_LENGTH('UserLimit','IsAllowMobileData') IS NULL
 --BEGIN
	-- ALTER TABLE dbo.UserLimit ADD IsAllowMobileData  BIT  NULL DEFAULT (0) WITH VALUES
 --END

 --创建索引
 --预制数据
 IF	(NOT EXISTS(SELECT * FROM dbo.ScoreGrade WHERE Id='1'))
BEGIN

INSERT INTO [dbo].[ScoreGrade]
           ([Id]
           ,[LeftScore]
           ,[RightScore]
           ,[GradeName]
           ,[GradeIndex]
           ,[CreateDate])
     VALUES
           (1
           ,0
           ,1000
           ,'一段'
           ,1
           ,GETDATE()
		   )
        
END

GO

IF	(NOT EXISTS(SELECT * FROM dbo.ScoreGrade WHERE Id='2'))
BEGIN

INSERT INTO [dbo].[ScoreGrade]
           ([Id]
           ,[LeftScore]
           ,[RightScore]
           ,[GradeName]
           ,[GradeIndex]
           ,[CreateDate])
     VALUES
           (2
           ,1001
           ,1200
           ,'二段'
           ,2
           ,GETDATE()
		   )
        
END

GO

IF	(NOT EXISTS(SELECT * FROM dbo.ScoreGrade WHERE Id='3'))
BEGIN

INSERT INTO [dbo].[ScoreGrade]
           ([Id]
           ,[LeftScore]
           ,[RightScore]
           ,[GradeName]
           ,[GradeIndex]
           ,[CreateDate])
     VALUES
           (3
           ,1201
           ,1400
           ,'三段'
           ,3
           ,GETDATE()
		   )
        
END

GO


IF	(NOT EXISTS(SELECT * FROM dbo.ScoreGrade WHERE Id='4'))
BEGIN

INSERT INTO [dbo].[ScoreGrade]
           ([Id]
           ,[LeftScore]
           ,[RightScore]
           ,[GradeName]
           ,[GradeIndex]
           ,[CreateDate])
     VALUES
           (4
           ,1401
           ,1600
           ,'四段'
           ,4
           ,GETDATE()
		   )
        
END

GO


IF	(NOT EXISTS(SELECT * FROM dbo.ScoreGrade WHERE Id='5'))
BEGIN

INSERT INTO [dbo].[ScoreGrade]
           ([Id]
           ,[LeftScore]
           ,[RightScore]
           ,[GradeName]
           ,[GradeIndex]
           ,[CreateDate])
     VALUES
           (5
           ,1601
           ,1800
           ,'五段'
           ,5
           ,GETDATE()
		   )
        
END

GO


IF	(NOT EXISTS(SELECT * FROM dbo.ScoreGrade WHERE Id='6'))
BEGIN

INSERT INTO [dbo].[ScoreGrade]
           ([Id]
           ,[LeftScore]
           ,[RightScore]
           ,[GradeName]
           ,[GradeIndex]
           ,[CreateDate])
     VALUES
           (6
           ,1801
           ,2000
           ,'六段'
           ,6
           ,GETDATE()
		   )
        
END

GO

IF	(NOT EXISTS(SELECT * FROM dbo.ScoreGrade WHERE Id='7'))
BEGIN

INSERT INTO [dbo].[ScoreGrade]
           ([Id]
           ,[LeftScore]
           ,[RightScore]
           ,[GradeName]
           ,[GradeIndex]
           ,[CreateDate])
     VALUES
           (7
           ,2001
           ,2200
           ,'七段'
           ,7
           ,GETDATE()
		   )
        
END

GO


IF	(NOT EXISTS(SELECT * FROM dbo.ScoreGrade WHERE Id='8'))
BEGIN

INSERT INTO [dbo].[ScoreGrade]
           ([Id]
           ,[LeftScore]
           ,[RightScore]
           ,[GradeName]
           ,[GradeIndex]
           ,[CreateDate])
     VALUES
           (8
           ,2201
           ,2400
           ,'八段'
           ,8
           ,GETDATE()
		   )
        
END

GO


IF	(NOT EXISTS(SELECT * FROM dbo.ScoreGrade WHERE Id='9'))
BEGIN

INSERT INTO [dbo].[ScoreGrade]
           ([Id]
           ,[LeftScore]
           ,[RightScore]
           ,[GradeName]
           ,[GradeIndex]
           ,[CreateDate])
     VALUES
           (9
           ,2401
           ,2600
           ,'九段'
           ,9
           ,GETDATE()
		   )
        
END

GO

IF	(NOT EXISTS(SELECT * FROM dbo.ScoreGrade WHERE Id='10'))
BEGIN

INSERT INTO [dbo].[ScoreGrade]
           ([Id]
           ,[LeftScore]
           ,[RightScore]
           ,[GradeName]
           ,[GradeIndex]
           ,[CreateDate])
     VALUES
           (10
           ,2601
           ,999999
           ,'十段'
           ,10
           ,GETDATE()
		   )
        
END

GO
 --存储过程和函数 

  