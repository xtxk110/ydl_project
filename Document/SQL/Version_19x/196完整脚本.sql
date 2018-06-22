--剔除所有用户
DELETE FROM dbo.OnlineUser
--有版本更新时，插入一条记录
DELETE FROM AppVersion WHERE AndroidCode=196
go
INSERT INTO [dbo].[AppVersion]([Id],[AndroidCode] ,[AndroidName] ,[AndroidRemark] ,[IosCode] ,[IosName]
           ,[IosRemark] ,[CreateDate] ,[IsRelease] ,[AndroidIsUpdate],[IosIsUpdate])
     VALUES( NEWID() ,196 ,'1.9.6' ,'1.首页新增了俱乐部入口；\n
2.赛事详情中新增赛事管理员角色，帮助创建者更好地管理赛事；\n
3.赛事详情的队伍中，优化了排名的展示方式；\n
4.赛事详情的队伍中，单循环新增了联赛模式；\n
5.赛事详情的赛况中，新增了多条件筛选功能；\n
6.赛事详情的赛况中，优化了对阵的展示方式；\n
7.我的界面新增了我的积分展示方式和记录详情；
',196,'1.9.6'
			,'1.首页新增了俱乐部入口；\n
2.赛事详情中新增赛事管理员角色，帮助创建者更好地管理赛事；\n
3.赛事详情的队伍中，优化了排名的展示方式；\n
4.赛事详情的队伍中，单循环新增了联赛模式；\n
5.赛事详情的赛况中，新增了多条件筛选功能；\n
6.赛事详情的赛况中，优化了对阵的展示方式；\n
7.我的界面新增了我的积分展示方式和记录详情；',GETDATE() ,1,1,1)

GO


------------------权限相关-----------------
IF OBJECT_ID('Limit', 'U') IS  NULL 
BEGIN
	CREATE TABLE [dbo].[Limit](
		[Id] [nvarchar](50)  NOT NULL,
		[RoleId] [nvarchar](50) NOT NULL,
		[LimitName] [varchar](30) NOT NULL,
		[LimitDetail] [int] NOT NULL DEFAULT 0,
		[Type] [int] ,
		[CreateDate] [datetime]
		CONSTRAINT [PK_Limit] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	
	EXEC('INSERT INTO [dbo].[Limit] ([Id], [RoleId], [LimitName], [LimitDetail],[Type], [CreateDate]) VALUES 
		(NEWID(), ''000002'', ''GameOper'', 291,1, GETDATE()),
		(NEWID(), ''000002'', ''ActivityOper'', 4387,1, GETDATE()),
		(NEWID(), ''000002'', ''ClubOper'', 1,1, GETDATE()),
		(NEWID(), ''000002'', ''VenueOper'', 1059,1, GETDATE()),
		(NEWID(), ''000002'', ''GuessAdd'', 1,3, GETDATE()),
		(NEWID(), ''000001'', ''GameOper'', 871,1, GETDATE()),
		(NEWID(), ''000001'', ''ActivityOper'', 13159,1, GETDATE()),
		(NEWID(), ''000001'', ''ClubOper'', 1, 1,GETDATE()),
		(NEWID(), ''000001'', ''VenueOper'', 3303,1, GETDATE()),
		(NEWID(), ''000001'', ''GuessAdd'', 1, 3,GETDATE()),
		(NEWID(), ''000001'', ''LiveAdd'', 1,3, GETDATE()),
		(NEWID(), ''000001'', ''ScoreGameAdd'', 1,3, GETDATE())
		')
END
GO


IF OBJECT_ID('LimitRole', 'U') IS  NULL 
BEGIN
	CREATE TABLE [dbo].[LimitRole](
		[Id] [nvarchar](50) NOT NULL,
		[Name] [nvarchar](50) NULL,
		[IsDefault] [bit] NOT NULL DEFAULT 0,
		[CreateDate] [datetime]
		CONSTRAINT [PK_LimitRole] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	EXEC('INSERT INTO [dbo].[LimitRole] ([Id], [Name], [IsDefault], [CreateDate]) VALUES (N''000001'', N''系统管理员'', 1, GETDATE()),(N''000002'', N''普通用户'', 1, GETDATE())')
END
GO


IF OBJECT_ID('LimitRoleUserMap', 'U') IS  NULL 
BEGIN
	CREATE TABLE [dbo].[LimitRoleUserMap](
		[Id] [nvarchar](50) NOT NULL,
		[RoleId] [nvarchar](50) NOT NULL,
		[UserId] [nvarchar](50) NOT NULL,
		[CreateDate] [datetime]
	) ON [PRIMARY]
	EXEC('INSERT INTO dbo.LimitRoleUserMap SELECT NEWID(),''000002'',a.Id,GETDATE() FROM UserAccount AS a WHERE a.Code !=''001001''')
	EXEC('INSERT INTO dbo.LimitRoleUserMap SELECT NEWID(),''000001'',a.Id,GETDATE() FROM UserAccount AS a WHERE a.Code =''001001''')
END
GO


IF OBJECT_ID('Organization', 'U') IS  NULL 
BEGIN
	CREATE TABLE [dbo].[Organization](
		[Id] [nvarchar](50) NOT NULL,
		[Name] [nvarchar](50) NOT NULL,
		[TypeId] [VARCHAR](50) NOT NULL,
		[ParentTypeId] [VARCHAR](50) NOT NULL,
		[IsDefault] [BIT] NOT NULL DEFAULT 0,
		[SonCounter] [INT] NOT NULL DEFAULT 0,
		[SonAmount] [INT] NOT NULL DEFAULT 0,
		[CreateDate] [datetime]
		CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	EXEC('
	INSERT INTO dbo.Organization
			( Id,Name ,
			  TypeId ,
			  ParentTypeId ,
			  IsDefault ,
			  SonCounter ,
			  SonAmount,
			  CreateDate
			)
	VALUES  ( NEWID(),N''悦动力'' , -- Name - nvarchar(50)
			  ''00001'' , -- TypeId - varchar(50)
			  ''00000'' , -- ParentTypeId - varchar(50)
			  1 , -- IsDefault - bit
			  0 , -- SonCounter - int
			  0 , -- SonAmount - int
			  GETDATE()
			)
	')
END
GO
IF NOT EXISTS(SELECT c.* FROM sys.tables AS a INNER JOIN sys.columns AS b ON a.object_id=b.object_id 
INNER JOIN sys.extended_properties AS c ON a.object_id=c.major_id AND b.column_id=c.minor_id 
WHERE a.name='LimitRole' AND b.name='IsDefault')
BEGIN
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是系统默认的角色，系统默认的不可修改删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LimitRole', @level2type=N'COLUMN',@level2name=N'IsDefault'
END
GO
IF NOT EXISTS(SELECT c.* FROM sys.tables AS a INNER JOIN sys.columns AS b ON a.object_id=b.object_id 
INNER JOIN sys.extended_properties AS c ON a.object_id=c.major_id AND b.column_id=c.minor_id 
WHERE a.name='Organization' AND b.name='SonCounter')
BEGIN
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下级计数器，便于生成下级的TypeId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Organization', @level2type=N'COLUMN',@level2name=N'SonCounter'
END
GO



--表修改
IF COL_LENGTH('UserAccount','OrganTypeId') IS NULL
BEGIN
	ALTER TABLE UserAccount ADD OrganTypeId VARCHAR(50) NULL
	EXEC('UPDATE UserAccount SET OrganTypeId=''00001''')
END
GO
IF COL_LENGTH('Game','AuditId') IS NULL
BEGIN
	ALTER TABLE Game ADD AuditId VARCHAR(MAX) NULL
END
GO
IF COL_LENGTH('Game','ManageId') IS NULL
BEGIN
	ALTER TABLE Game ADD ManageId VARCHAR(MAX) NULL
END
GO
IF COL_LENGTH('Game','IsLeague') IS NULL
BEGIN
	ALTER TABLE Game ADD IsLeague BIT  DEFAULT 0
END
GO
--
IF NOT EXISTS(SELECT c.* FROM sys.tables AS a INNER JOIN sys.columns AS b ON a.object_id=b.object_id 
INNER JOIN sys.extended_properties AS c ON a.object_id=c.major_id AND b.column_id=c.minor_id 
WHERE a.name='Game' AND b.name='IsLeague')
BEGIN
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否启用联赛模式(单循环才此操作)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Game', @level2type=N'COLUMN',@level2name=N'IsLeague'
END
GO
--删除云服务器上临时加的触发器
IF EXISTS(
  SELECT *
    FROM sys.triggers
   WHERE name = N'GameLoopDetailInsert' AND parent_class_desc = N'OBJECT_OR_COLUMN'
)
	DROP TRIGGER [dbo].[GameLoopDetailInsert]
GO