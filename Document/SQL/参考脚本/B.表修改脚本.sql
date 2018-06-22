USE [YDL]
GO
-- �ֵ��� Id , CreateDate �ֶ�
IF COL_LENGTH('SysDic','Id') IS NULL
 BEGIN
	ALTER TABLE dbo.SysDic ADD Id NVARCHAR(50) 
 END
 IF COL_LENGTH('SysDic','NameIndex') IS NULL
 BEGIN
	ALTER TABLE dbo.SysDic ADD  NameIndex INT 
 END
  IF COL_LENGTH('SysDic','CreateDate') IS NULL
 BEGIN
	ALTER TABLE dbo.SysDic ADD  CreateDate DATETIME
 END
--���ӿγ̹���Ա�ֶ�
  IF COL_LENGTH('Venue','CourseManagerId') IS NULL
 BEGIN
	ALTER TABLE dbo.Venue ADD CourseManagerId NVARCHAR(50)  
 END
  IF COL_LENGTH('Venue','IsEnableTeachingPoint') IS NULL
 BEGIN
	ALTER TABLE dbo.Venue ADD  IsEnableTeachingPoint BIT
 END

 --�����Ч�� 90��
   IF COL_LENGTH('Config','BigCourseValidDays') IS NULL
 BEGIN
	ALTER TABLE dbo.Config ADD BigCourseValidDays INT DEFAULT 90 WITH VALUES   
 END
 --���ӽ�ѧ�����ֶ�
   IF COL_LENGTH('UserLimit','IsTeachManage') IS NULL
 BEGIN
	ALTER TABLE dbo.UserLimit ADD IsTeachManage BIT DEFAULT 0 WITH VALUES
 END

 --MsgReg �� RegId �ֶγ��� �ĳ��� 500
ALTER TABLE MsgReg
ALTER COLUMN RegId NVARCHAR(500)