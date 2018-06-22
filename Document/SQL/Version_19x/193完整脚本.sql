--�޳������û�
DELETE FROM dbo.OnlineUser
--�޸İ汾��
 /*UPDATE dbo.AppVersion SET 
	AndroidCode='193',
	AndroidName='',
	IosCode='193',
	IosName='',
	CreateDate=GETDATE(),
	IsRelease=1,
	AndroidIsUpdate=1,
	IosIsUpdate=1
WHERE Id='BCB89F64-83D3-4FC6-BC29-39D49CD1BD3D'
*/
--�а汾����ʱ������һ����¼
INSERT INTO [dbo].[AppVersion]([Id],[AndroidCode] ,[AndroidName] ,[AndroidRemark] ,[IosCode] ,[IosName]
           ,[IosRemark] ,[CreateDate] ,[IsRelease] ,[AndroidIsUpdate],[IosIsUpdate])
     VALUES( NEWID() ,193 ,'1.9.3' ,'1.ֱ��ģ�����ӵ��������빦��\n2.���Ӱ汾���¿��ƹ���',180,'1.8.0'
			,'1.ֱ��ģ�����ӵ��������빦��\n2.���Ӱ汾���¿��ƹ���',GETDATE() ,1,1,1)


--���޸�
IF COL_LENGTH('LiveRoom','IsThirdparty') IS NULL
BEGIN
	ALTER TABLE LiveRoom ADD IsThirdparty  BIT  NOT  NULL DEFAULT (0) WITH VALUES
END

-- zq 20180320
IF COL_LENGTH('LiveRoom','GameId') IS NOT NULL
BEGIN
	ALTER TABLE LiveRoom ALTER COLUMN GameId  NVARCHAR(50) NULL 
END
IF COL_LENGTH('AppVersion','AndroidIsUpdate') IS NULL
BEGIN
	ALTER TABLE AppVersion ADD AndroidIsUpdate  BIT NULL DEFAULT (0) WITH VALUES
END
IF COL_LENGTH('AppVersion','IosIsUpdate') IS NULL
BEGIN
	ALTER TABLE AppVersion ADD IosIsUpdate  BIT NULL DEFAULT (0) WITH VALUES
END


--�洢���̺ͺ��� 
 /*���Ĵ洢���� sp_GetLiveRoomList    zq 20180320*/
 IF OBJECT_ID('sp_GetLiveRoomList','P') IS NOT NULL
	DROP PROCEDURE [dbo].[sp_GetLiveRoomList]
 GO
CREATE PROCEDURE [dbo].[sp_GetLiveRoomList] 
	@GameId NVARCHAR(50),
	@pageIndex INT ,
	@pageSize INT ,
	@state NVARCHAR(50)='Active',
	@rowCount INT OUTPUT
	
AS
BEGIN	
	SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
		DECLARE	@state1 NVARCHAR(50)
        SET @filter = ''
		SET @state1='UnActive'
		 
		IF ISNULL(@GameId, '') != ''
            SET @filter = @filter + ' AND  a.GameId =@GameId AND a.State !=@state1'
		ELSE
			SET @filter=@filter+' AND  a.State=@state '

        DECLARE @sql NVARCHAR(MAX)
		--������һҳ��ʱ��ȡ����
        IF @pageIndex = 1
            BEGIN
                SET @sql = '
						SELECT 
							@rowCount=COUNT(a.Id) 
						FROM dbo.LiveRoom a
						WHERE 1=1 
						' 
						+@filter
				
                EXEC SP_EXECUTESQL @sql,
                    N'@GameId NVARCHAR(50),@state NVARCHAR(50) ,@state1 NVARCHAR(50) ,@rowCount INT OUTPUT'
					,@GameId,@state,@state1,@rowCount OUTPUT
                    
            END
        ELSE
            SET @rowCount = 0
		--��ҳȡ����	
        SET @sql = '
					 
				SELECT 
						a.*
				FROM dbo.LiveRoom a
				WHERE 1=1 ' 
				+@filter+ '
				ORDER BY a.State,a.CreateDate
				OFFSET (@pageIndex-1)*@pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY
				'

        EXEC SP_EXECUTESQL @sql,
            N'@GameId NVARCHAR(50),@state NVARCHAR(50),@state1 NVARCHAR(50), @pageIndex INT,@pageSize INT'
			,@GameId,@state,@state1,@pageIndex, @pageSize
END
	GO