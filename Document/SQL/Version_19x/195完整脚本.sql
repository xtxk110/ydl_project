--剔除所有用户
DELETE FROM dbo.OnlineUser
--有版本更新时，插入一条记录
INSERT INTO [dbo].[AppVersion]([Id],[AndroidCode] ,[AndroidName] ,[AndroidRemark] ,[IosCode] ,[IosName]
           ,[IosRemark] ,[CreateDate] ,[IsRelease] ,[AndroidIsUpdate],[IosIsUpdate])
     VALUES( NEWID() ,195 ,'1.9.5' ,'1.首页优化了直播的图标；\n
2.赛事新增了裁判计分的快捷入口；\n
3.赛事列表优化了展示方式；\n
4.赛事详情中优化了队伍信息和排名的入口；\n
5.直播用户端，如果关联了裁判正在打分的比赛，会显示对应的比分。',195,'1.9.5'
			,'1.首页优化了直播的图标；\n
2.赛事新增了裁判计分的快捷入口；\n
3.赛事列表优化了展示方式；\n
4.赛事详情中优化了队伍信息和排名的入口；\n
5.直播用户端，如果关联了裁判正在打分的比赛，会显示对应的比分。',GETDATE() ,1,1,1)

GO
            
--表修改
IF COL_LENGTH('Game','IsEnableLiveScore') IS NULL
BEGIN
	ALTER TABLE Game ADD IsEnableLiveScore BIT NULL DEFAULT (0)
END
GO

--表修改
IF COL_LENGTH('UserAccount','OrganTypeId') IS NULL
BEGIN
	ALTER TABLE UserAccount ADD OrganTypeId VARCHAR(50) NULL
	EXEC('UPDATE UserAccount SET OrganTypeId=''00001''')
END
GO

------------------权限相关-----------------
IF OBJECT_ID('Limit', 'U') IS  NULL 
BEGIN
	CREATE TABLE [dbo].[Limit](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[RoleId] [int] NOT NULL,
		[LimitName] [varchar](30) NOT NULL,
		[LimitDetail] [int] NOT NULL DEFAULT 0,
		CONSTRAINT [PK_Limit] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO

IF OBJECT_ID('LimitRole', 'U') IS  NULL 
BEGIN
	CREATE TABLE [dbo].[LimitRole](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[Name] [nvarchar](50) NULL,
		[IsDefault] [bit] NOT NULL DEFAULT 0,
		CONSTRAINT [PK_LimitRole] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO

IF OBJECT_ID('LimitRoleUserMap', 'U') IS  NULL 
BEGIN
	CREATE TABLE [dbo].[LimitRoleUserMap](
		[RoleId] [int] NOT NULL,
		[UserId] [nvarchar](50) NOT NULL
	) ON [PRIMARY]
END
GO

IF OBJECT_ID('Organization', 'U') IS  NULL 
BEGIN
	CREATE TABLE [dbo].[Organization](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[Name] [nvarchar](50) NOT NULL,
		[TypeId] [VARCHAR](50) NOT NULL,
		[ParentTypeId] [VARCHAR](50) NOT NULL,
		[IsDefault] [BIT] NOT NULL DEFAULT 0,
		[SonCounter] [INT] NOT NULL DEFAULT 0,
		[SonAmount] [INT] NOT NULL DEFAULT 0,
		CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	EXEC('
	INSERT INTO Organization
			( Name ,
			  TypeId ,
			  ParentTypeId ,
			  IsDefault ,
			  SonCounter ,
			  SonAmount
			)
	VALUES  ( N''悦动力'' , -- Name - nvarchar(50)
			  ''00001'' , -- TypeId - varchar(50)
			  ''00000'' , -- ParentTypeId - varchar(50)
			  1 , -- IsDefault - bit
			  0 , -- SonCounter - int
			  0  -- SonAmount - int
			)
	')
END
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是系统默认的角色，系统默认的不可修改删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LimitRole', @level2type=N'COLUMN',@level2name=N'IsDefault'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下级计数器，便于生成下级的TypeId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Organization', @level2type=N'COLUMN',@level2name=N'SonCounter'
GO

