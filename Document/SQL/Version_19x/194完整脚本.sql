--�޳������û�
DELETE FROM dbo.OnlineUser
--�а汾����ʱ������һ����¼
INSERT INTO [dbo].[AppVersion]([Id],[AndroidCode] ,[AndroidName] ,[AndroidRemark] ,[IosCode] ,[IosName]
           ,[IosRemark] ,[CreateDate] ,[IsRelease] ,[AndroidIsUpdate],[IosIsUpdate])
     VALUES( NEWID() ,194 ,'1.9.4' ,'',180,'1.8.0'
			,'',GETDATE() ,1,1,1)

GO
            
--���޸�
IF COL_LENGTH('UserScoreHistory','MapId') IS NULL
BEGIN
	ALTER TABLE UserScoreHistory ADD MapId NVARCHAR(50) NULL
END
GO

IF COL_LENGTH('UserScoreHistory','Editor') IS NULL
BEGIN
	ALTER TABLE UserScoreHistory ADD Editor NVARCHAR(50) NULL
END
GO

IF COL_LENGTH('UserScoreHistory','IsEdit') IS NULL
BEGIN
	ALTER TABLE UserScoreHistory ADD IsEdit BIT NOT NULL DEFAULT (0) WITH VALUES
END
GO

IF COL_LENGTH('UserScoreHistory','OldScore') IS NULL
BEGIN
	ALTER TABLE UserScoreHistory ADD OldScore INT NULL
END
GO

