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
           ('ydl','','成都悦动力网络科技有限公司','天府五街',100,'001001',GETDATE())
END

GO


