--剔除所有用户
DELETE FROM dbo.OnlineUser
--有版本更新时，插入一条记录
DELETE FROM AppVersion WHERE AndroidCode=199
go
INSERT INTO [dbo].[AppVersion]([Id],[AndroidCode] ,[AndroidName] ,[AndroidRemark] ,[IosCode] ,[IosName]
           ,[IosRemark] ,[CreateDate] ,[IsRelease] ,[AndroidIsUpdate],[IosIsUpdate])
     VALUES( NEWID() ,199 ,'1.9.9' ,'1.增加团体对阵模板规则自定义功能\n ',199,'1.9.9','1.增加团体对阵模板规则自定义功能\n ',GETDATE() ,1,1,1)

GO

-----------------------------表------------------------------
IF(OBJECT_ID('GameTeamLoopTemplet','U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[GameTeamLoopTemplet] (
	[Id] nvarchar(50) NOT NULL PRIMARY KEY,
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
	EXEC('INSERT INTO dbo.GameTeamLoopTemplet VALUES 
(''021001'',NULL, ''默认模板1'', ''①A-X②B-Y③*C-*Z④*-Z⑤C-*'', 3, 5, 0, ''①A-X②B-Y③*C-*Z④*-Z⑤C-*'', NULL, 1, 0, 1, 1, ''001006'', GETDATE())
,(''021002'',NULL, ''默认模板2'', ''①A-X②B-Y③C-Z④A-Y⑤B-X'', 3, 5, 0, ''①A-X②B-Y③C-Z④A-Y⑤B-X'', NULL, 1, 0, 1, 1, ''001006'', GETDATE())
,(''021003'',NULL, ''默认模板3'', ''①A-A②BC-BC③D-D'', 4, 3, 0, ''①A-A②BC-BC③D-D'', NULL, 0, 0, 1, 1, ''001006'', GETDATE())
,(''021004'',NULL, ''默认模板4'', ''①A-X②B-Y③**-**④A-Y⑤C-Z'', 4, 5, 0, ''①A-X②B-Y③**-**④A-Y⑤C-Z'', NULL, 1, 0, 1, 1, ''001006'', GETDATE())
,(''021005'',NULL, ''默认模板5'', ''①A-A②B-B③C-C④D-D⑤*D-*D'', 4, 5, 0, ''①A-A②B-B③C-C④D-D⑤*D-*D'', NULL, 0, 0, 1, 1, ''001006'', GETDATE())
,(''021006'',NULL, ''默认模板6'', ''①A-X②B-Y③**-**④A-Y⑤*-*'', 4, 5, 0, ''①A-X②B-Y③**-**④A-Y⑤*-*'', NULL, 1, 0, 1, 1, ''001006'', GETDATE())
,(''021007'',NULL, ''默认模板7'', ''①A-X②B-Y③AC-XZ④B-Z⑤C-Y'', 3, 5, 0, ''①A-X②B-Y③AC-XZ④B-Z⑤C-Y'', NULL, 1, 0, 1, 1, ''001006'', GETDATE())
,(''021008'',NULL, ''默认模板8'', ''①CD-YZ②A-W③B-X④C-Y⑤D-Z'', 4, 5, 0, ''①CD-YZ②A-W③B-X④C-Y⑤D-Z'', NULL, 1, 0, 1, 1, ''001006'', GETDATE())
,(''021009'',NULL, ''默认模板9'', ''①BC-YZ②A-X③C-Z④A-Y⑤B-X'', 3, 5, 0, ''①BC-YZ②A-X③C-Z④A-Y⑤B-X'', NULL, 1, 0, 1, 1, ''001006'', GETDATE())
')
END
IF(OBJECT_ID('GameTeamLoopTempletDetail','U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[GameTeamLoopTempletDetail] (
	[Id] nvarchar(50) NOT NULL PRIMARY KEY ,
	[TempletId] nvarchar(50) NOT NULL ,
	[OrderNo] int NULL DEFAULT ((0)) ,
	[Code1] nvarchar(5) NULL ,
	[Code2] nvarchar(5) NULL ,
	[IsDouble] bit NULL DEFAULT ((0)) ,
	[CreateDate] datetime NULL 
)
EXEC('INSERT INTO dbo.GameTeamLoopTempletDetail VALUES 
(NEWID(),''021001'',1,''A'',''X'',0,GETDATE())
,(NEWID(),''021001'',2,''B'',''Y'',0,GETDATE())
,(NEWID(),''021001'',3,''*C'',''*Z'',1,GETDATE())
,(NEWID(),''021001'',4,''*'',''Z'',0,GETDATE())
,(NEWID(),''021001'',5,''C'',''*'',0,GETDATE())
,(NEWID(),''021002'',1,''A'',''X'',0,GETDATE())
,(NEWID(),''021002'',2,''B'',''Y'',0,GETDATE())
,(NEWID(),''021002'',3,''C'',''Z'',0,GETDATE())
,(NEWID(),''021002'',4,''A'',''Y'',0,GETDATE())
,(NEWID(),''021002'',5,''B'',''X'',0,GETDATE())
,(NEWID(),''021003'',1,''A'',''A'',0,GETDATE())
,(NEWID(),''021003'',2,''BC'',''BC'',1,GETDATE())
,(NEWID(),''021003'',3,''D'',''D'',0,GETDATE())
,(NEWID(),''021004'',1,''A'',''X'',0,GETDATE())
,(NEWID(),''021004'',2,''B'',''Y'',0,GETDATE())
,(NEWID(),''021004'',3,''**'',''**'',1,GETDATE())
,(NEWID(),''021004'',4,''A'',''Y'',0,GETDATE())
,(NEWID(),''021004'',5,''D'',''W'',0,GETDATE())
,(NEWID(),''021005'',1,''A'',''A'',0,GETDATE())
,(NEWID(),''021005'',2,''B'',''B'',0,GETDATE())
,(NEWID(),''021005'',3,''C'',''C'',0,GETDATE())
,(NEWID(),''021005'',4,''D'',''D'',0,GETDATE())
,(NEWID(),''021005'',5,''*D'',''*D'',1,GETDATE())
,(NEWID(),''021006'',1,''A'',''X'',0,GETDATE())
,(NEWID(),''021006'',2,''B'',''Y'',0,GETDATE())
,(NEWID(),''021006'',3,''**'',''**'',1,GETDATE())
,(NEWID(),''021006'',4,''A'',''Y'',0,GETDATE())
,(NEWID(),''021006'',5,''*'',''*'',0,GETDATE())
,(NEWID(),''021007'',1,''A'',''X'',0,GETDATE())
,(NEWID(),''021007'',2,''B'',''Y'',0,GETDATE())
,(NEWID(),''021007'',3,''AC'',''XZ'',1,GETDATE())
,(NEWID(),''021007'',4,''B'',''Z'',0,GETDATE())
,(NEWID(),''021007'',5,''C'',''Y'',0,GETDATE())
,(NEWID(),''021008'',1,''CD'',''YZ'',1,GETDATE())
,(NEWID(),''021008'',2,''A'',''W'',0,GETDATE())
,(NEWID(),''021008'',3,''B'',''X'',0,GETDATE())
,(NEWID(),''021008'',4,''C'',''Y'',0,GETDATE())
,(NEWID(),''021008'',5,''D'',''Z'',0,GETDATE())
,(NEWID(),''021009'',1,''BC'',''YZ'',1,GETDATE())
,(NEWID(),''021009'',2,''A'',''X'',0,GETDATE())
,(NEWID(),''021009'',3,''C'',''Z'',0,GETDATE())
,(NEWID(),''021009'',4,''A'',''Y'',0,GETDATE())
,(NEWID(),''021009'',5,''B'',''X'',0,GETDATE())
')
END
IF (OBJECT_ID('GameTeamLoopTempletMap','U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[GameTeamLoopTempletMap] (
	[Id] nvarchar(50) NOT NULL PRIMARY KEY ,
	[TempletId] nvarchar(50) NOT NULL ,
	[GameId] nvarchar(50) NOT NULL ,
	[LoopId] nvarchar(50) NOT NULL ,
	[TeamId] nvarchar(50) NOT NULL ,
	[Code] nvarchar(5) NULL ,
	[CodeUserId] nvarchar(50) NULL ,
	[CodeUserName] nvarchar(20) NULL ,
	[IsHost] bit NULL DEFAULT ((0)) ,
	[CreateDate] datetime NULL 
)
END
-------------------------注释添加------------------------------------
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