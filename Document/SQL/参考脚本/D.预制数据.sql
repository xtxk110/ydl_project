USE [YDL]
GO

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


