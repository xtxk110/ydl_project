--剔除所有用户
DELETE FROM dbo.OnlineUser
--有版本更新时，插入一条记录
DELETE FROM AppVersion WHERE AndroidCode=198
go
INSERT INTO [dbo].[AppVersion]([Id],[AndroidCode] ,[AndroidName] ,[AndroidRemark] ,[IosCode] ,[IosName]
           ,[IosRemark] ,[CreateDate] ,[IsRelease] ,[AndroidIsUpdate],[IosIsUpdate])
     VALUES( NEWID() ,198 ,'1.9.8' ,'1.新增赛事视频播放',198,'1.9.8','1.新增赛事视频播放',GETDATE() ,1,1,1)

GO

-----------------------------表------------------------------
IF COL_LENGTH('LiveRoom','IsVod') IS NULL
BEGIN
	ALTER TABLE LiveRoom ADD IsVod BIT NULL DEFAULT (0)
END
GO
IF COL_LENGTH('LiveRoom','VodPlayUrl') IS NULL
BEGIN
	ALTER TABLE LiveRoom ADD VodPlayUrl nvarchar(255) NULL 
END
GO
-------------------------注释添加------------------------------------
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'LiveRoom', 
'COLUMN', N'IsVod')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'是否是点播'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LiveRoom'
, @level2type = 'COLUMN', @level2name = N'IsVod'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'是否是点播'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LiveRoom'
, @level2type = 'COLUMN', @level2name = N'IsVod'
GO
IF ((SELECT COUNT(*) from fn_listextendedproperty('MS_Description', 
'SCHEMA', N'dbo', 
'TABLE', N'LiveRoom', 
'COLUMN', N'VodPlayUrl')) > 0) 
EXEC sp_updateextendedproperty @name = N'MS_Description', @value = N'点播视频地址'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LiveRoom'
, @level2type = 'COLUMN', @level2name = N'VodPlayUrl'
ELSE
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'点播视频地址'
, @level0type = 'SCHEMA', @level0name = N'dbo'
, @level1type = 'TABLE', @level1name = N'LiveRoom'
, @level2type = 'COLUMN', @level2name = N'VodPlayUrl'
GO
---------------------存储过程-----------------------------------------------
 
ALTER PROCEDURE [dbo].[sp_GetLiveRoomList] 
	@GameId NVARCHAR(50),
	@pageIndex INT ,
    @pageSize INT ,
    @rowCount INT OUTPUT
	
AS
	
    BEGIN
        SET NOCOUNT ON;
		DECLARE @filter NVARCHAR(MAX)
        SET @filter = '  AND a.IsVod=1 '
		 
		IF ISNULL(@GameId, '') != ''
            SET @filter = ' AND a.GameId =@GameId AND a.IsVod=1 OR  (ISNULL(a.IsVod, 0) !=1 AND a.GameId =@GameId AND a.State !=''UnActive'')'--需求加条件
		ELSE
			SET @filter=@filter+' OR (ISNULL(a.IsVod, 0) !=1 AND a.State=''Active'' ) '

        DECLARE @sql NVARCHAR(MAX)
		--仅仅第一页的时候取行数
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
                    N'@GameId NVARCHAR(50) ,@rowCount INT OUTPUT'
					,@GameId,@rowCount OUTPUT
                    
            END
        ELSE
            SET @rowCount = 0
		--分页取数据	
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

		PRINT (@sql)

        EXEC SP_EXECUTESQL @sql,
            N'@GameId NVARCHAR(50), @pageIndex INT,@pageSize INT'
			,@GameId,@pageIndex, @pageSize

		
		
    END
