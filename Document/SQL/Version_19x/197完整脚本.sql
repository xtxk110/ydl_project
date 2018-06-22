--剔除所有用户
DELETE FROM dbo.OnlineUser
--有版本更新时，插入一条记录
DELETE FROM AppVersion WHERE AndroidCode=197
go
INSERT INTO [dbo].[AppVersion]([Id],[AndroidCode] ,[AndroidName] ,[AndroidRemark] ,[IosCode] ,[IosName]
           ,[IosRemark] ,[CreateDate] ,[IsRelease] ,[AndroidIsUpdate],[IosIsUpdate])
     VALUES( NEWID() ,197 ,'1.9.7' ,'1.修改赛事BUG',197,'1.9.7','1.修改赛事BUG',GETDATE() ,1,1,0)

GO

