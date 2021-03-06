USE [YDL]
GO
DELETE  FROM dbo.Coach
DELETE  FROM dbo.CoachStudentMoney

INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)
VALUES ( N'2ff52433316b486285d2a72600bc8cd7', N'010002', '2010-01-01 00:00:00.000', 3, N'20170303/e6ae92d2-94cb-4001-b13f-576fcdc16116.png', N'20170303/d26a1693-357b-49ed-a5f3-ba1f2355dea6.jpg', N'20170303/bcdf9363-3ce0-42bd-b8d7-b529b6c3d366.jpg', CAST(0x0000A72B0107B952 AS DateTime), N'女，国家一级运动员，参加过国家青年队集训，曾效力山东鲁能乒乓球俱乐部。2007年至2010年在台湾执教，带领7名队员代表台湾参加国际比赛；2012年在香港执；2013年在陈龙灿俱乐部执教，有着多年教练经验。 
获奖经历
2000年获山东省运动会单打冠军；
2003年获全国娃娃杯冠军； 
2004年获希望杯前8名；
2005年获全国甲B联赛冠军； 
2015至2017年代表泸州老窖参加全国四大名白酒比赛；', NULL, N'250bee59415d45a1941ca6f1010f3878',
100,'ydl',1,GETDATE())
GO
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)

VALUES ( N'3320be93-6039-41d9-b6cc-a5d6015cb8ae', N'010002', '2014-01-01 00:00:00.000', 3, N'20170331/37780d8b-58d7-4747-a07a-67d11b1db8e6.jpg', N'20170331/2ba5ad24-e4bd-47ef-9a75-33ef854bbdfe.jpg', N'20170331/3d18c769-24b1-4b01-8291-f3426de6811c.jpg', CAST(0x0000A74700F28783 AS DateTime), N'国家二级运动员，从小开始学习乒乓球，经常参加各种类型的乒乓球赛事，有着丰富的实战经验，长期从事青少年乒乓球教学培训工作，能根据学员的不同特点制定合理的教学培训计划，年轻、有活力的教学方式深受孩子们的喜爱。

获奖经历：

资阳市乒乓球团体赛冠军
2015.7月获“资阳国际商贸城杯”乒乓球单打第四名
2016.4月获成都理工大学“乒协杯”乒乓球比赛第一名
2016.4月获成都在线“爱之杯”分档单打赛冠军
2016年4月获第十二届成都高新西区乒乓球联赛团体冠军
2016.7月获成都市斯多瑞业余乒乓球西体站亚军
2016.8月获“活力天府 运动华阳”格胤杯第二届全民乒乓球邀请赛青年组单打冠军
2016.11月获第一届“缘怡欣运”杯大学生高校乒乓球团体赛第二名
2016.12月获红双喜——和嘉天健杯乒乓球团体赛冠军', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())

GO
INSERT [dbo].[Coach] ([Id],  [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)
VALUES ( N'48c878f489a34bd5b86ca6ff012c98d1', N'010002', '2015-01-01 00:00:00.000',3, N'~/Annexs/Temp/20170119/0e4dbd67-1736-4827-957a-201e814d60e7.jpg', N'20170119/7d4dc4aa-e835-4c32-a770-32577093cdb9.jpg', N'20170119/2c1da44e-3767-42bd-881e-57f98ca474d6.jpg', CAST(0x0000A700010026C3 AS DateTime), N'成都体育学院乒乓球专业，乒乓球实战技术娴熟、经验丰富、教学水平高', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())

GO
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)
VALUES ( N'7180eef59d0c4ca7a73da72600b5c0c0', N'010002', '2012-01-01 00:00:00.000', 3, N'20170303/df1458c9-14cb-4fdb-ad58-bfa207f55468.jpg', N'20170303/0ef55e91-0f78-468e-9fe2-5fc5e91b909d.jpg', N'20170303/9cd910eb-5c78-4142-aaef-ec6de1b8a325.jpg', CAST(0x0000A72B010694BD AS DateTime), N'男，国家二级运动员，原吉林省专业队队员，代表吉林省参加全国甲D联赛。2012年在长春87中俱乐部执教，2013至2016在泸州市执教，并带领队员参加省市一级比赛取得优异成绩，有着丰富的执教经验。
获奖经历：
2007年获得吉林省青少年少儿乒协杯比赛团体冠军单打第二名；
2010年参加吉林省青少年乒乓球锦标赛男子单打第三名；
近期参加斯蒂卡杯全国俱乐部巡回赛获得亚军。', NULL, N'250bee59415d45a1941ca6f1010f3878',
100,'ydl',1,GETDATE())

GO
INSERT [dbo].[Coach] ([Id],  [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)

VALUES ( N'a6d465c6-6401-4350-afaf-a6d200958764', N'010002',  '2002-01-01 00:00:00.000', 3, N'20170421/c0c824a4-bab7-477c-af52-f9e757382f64.jpg', N'20170421/1d3335ce-7e68-4bba-9629-49cc1e76e3b9.png', N'20170421/d1a34013-c1dc-46b1-bd71-b4d9a0147e5a.png', CAST(0x0000A75C00F1FE50 AS DateTime), N'男，国家专业二级运动员, 国家业余健将运动员, 在四川业余乒乓球界有着“碧玉刀”的称号。2000年至今，在成都从事青少年乒乓教学培训工作，有着丰富的执教经验。善于根据学员实际情况，制定合理的教学计划，并带领专业教练团队落实培训计划，让每一位学员掌握乒乓球的运动技能和练习方法。

获奖经历
2001-2004年连续三届获四川省高校乒乓球联赛男子单打冠军
2005年代表成都获川渝乒乓球对抗赛团体冠军
2006年获得四川省第十届运动会乒乓球男子团体、单打冠军
2007年在全国“SDK”杯邀请赛获团体冠军、单打亚军
2008年至今，多次参加四川省各商业赛事，并取得男子单打冠军
2016年获得四川省SPPA乒乓球联赛川南赛区团体及单打冠军，总决赛单打季军', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())
GO
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)

VALUES ( N'b144d99abc294ff98288a72f008bc4c7', N'010002', '2010-01-01 00:00:00.000', 3, N'20170309/5ff83ed0-ea9d-49ef-ad90-54bf866f0b1e.png', N'20170309/7a5cd0f4-baad-421c-b8b9-13951ae3b21e.jpg', N'20170309/a1c8a4c0-e3f5-4bc5-a61d-f179af5ef7d0.jpg', CAST(0x0000A73100A23AAF AS DateTime), N'国家专业二级运动员，内江市专业队女队教练，四川省业余训练教练员。2010年至今从事乒乓球教学工作，擅长零基础教学。曾在四川大学童玲俱乐部、优客运动城等乒乓球俱乐部兼职教练，能因材施教，通过耐心观察和沟通，为学生找到最适合的教学方式。

获奖经历：

2002年8月四川省第九届青运会乒乓球比赛获团体第七名
2004年8月四川省乒乓球比赛获团体第八名
2006年8月四川省第十届青运会乒乓球比赛获团体第五名、双打第四名
2007年3月四川省中学生乒乓球比赛获混合双打第一名', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())
GO
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)

VALUES (N'b1ca6678-f060-47a6-bb32-a5d300e9240e', N'010002', '2007-01-01 00:00:00.000', 3, N'20170223/85e29aaa-d1b9-4b85-a89a-246b1e3e3f18.jpg', N'20170223/5a83fb38-dd6a-4609-99c8-cf222f1eb350.jpg', N'20170223/d38f12f6-bb2c-4989-bead-569cbec77c4c.jpg', CAST(0x0000A72300EEB9FE AS DateTime), N'男，国家一级运动员，原四川省专业队队员。从事多年乒乓球训练工作，2008年在台湾从事技术交流和教练工作；2010年带领队员获得美国国家队选拔赛第二名，荣获德州最佳教练称号，有着丰富的乒乓教学经验。擅长少儿、成人培训，能快速提高学员乒乓球技术。

获奖经历
1999年全国乒乓球优秀少年赛获男单前8名
2001年全国乒乓球锦标赛获团体第五名
2002年全国乒乓球甲B联赛总决赛获第三名
2003年全国城市运动会获男团第四名
2004年印度尼西亚全国俱乐部联赛获第一名
2006年美国加州公开赛获男单冠军
2011年四川省职工乒乓球比赛获男单冠军', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())

GO
INSERT [dbo].[Coach] ([Id], [State], BeginTeachingDate, [Grade], [HeadUrl], [IdCardFrontUrl], [IdCardBackUrl], [CreateDate], [Qualification], [AuditOpinion], [VenueId],
CommissionPercentage,OrganizationId,IsEnabled,AuditDateTime)

VALUES (N'f053d11cc1fc4bcf8c40a7200104faca', N'010002',  '2015-01-01 00:00:00.000',3, N'~/Annexs/Temp/20170227/004e975a-2c18-4b08-aa0b-c4febcf97dc8.jpg', N'20170227/f532b8f2-86fc-402f-bb86-f92bca8c5b4e.jpg', N'20170227/175e6d03-549f-4931-be4b-dff9d5bc2ec7.jpg', CAST(0x0000A7270143E7AB AS DateTime), N'程教练从小开始学习乒乓球，具有丰富的实战和教学经验。曾获得南充市西充县高中组比赛第二名，四川省南充市男子单打第三名，南充市青年组团体赛第二名。在执教期间，服务过成都市南门某俱乐部，擅长一对一等小班教学。主要教学对象：5-15岁青少年。', NULL, N'1e31dc00de0d48868374a6f200e6af38',
100,'ydl',1,GETDATE())

GO



INSERT [dbo].[CoachStudentMoney] ([Id], [StudentUserId], [CoachId], [Amount], 
[IsPay], [ThenMoney], [CourseTypeId], [CourseTypeName], [Deadline], [CreateDate], [HeadUrl],ThenTotalAmount,CityId) 
VALUES (N'6c506c28129046b3a906a75d012b2ede', N'067268413c3941dfb8dea75d012afacc', N'a6d465c6-6401-4350-afaf-a6d200958764', 10,1, CAST(1500.00 AS Decimal(18, 2)), N'027003', N'私教课', 
'9999-12-31 23:59:59.997', CAST(0x0000A75D012B2EDD AS DateTime), NULL,10,'75')

GO
INSERT [dbo].[CoachStudentMoney] ([Id], [StudentUserId], [CoachId], [Amount], [IsPay], [ThenMoney], [CourseTypeId], [CourseTypeName], [Deadline], [CreateDate]
, [HeadUrl],ThenTotalAmount,CityId)  
VALUES (N'1a0881e8f7df484f8ae9a72e0111cee1', N'49d59b709b3d430b9118a72e011076cc', N'2ff52433316b486285d2a72600bc8cd7', 10, 1, CAST(1500.00 AS Decimal(18, 2)), N'027003', N'私教课', CAST(0x000639E80111CEDF AS DateTime), '9999-12-31 23:59:59.997', NULL
,10,'75')

GO
INSERT [dbo].[CoachStudentMoney] ([Id], [StudentUserId], [CoachId], [Amount], [IsPay], [ThenMoney], [CourseTypeId], [CourseTypeName], [Deadline], [CreateDate], [HeadUrl],ThenTotalAmount,CityId)  
VALUES (N'66dfd08d6ddc42f986b9a72e01115851', N'65057fb0-055c-4adc-ba62-a5b400b0ce2b', N'2ff52433316b486285d2a72600bc8cd7', 10, 1, CAST(1500.00 AS Decimal(18, 2)), N'027003', N'私教课', CAST(0x000639E801115850 AS DateTime), '9999-12-31 23:59:59.997', NULL,
10,'75')
GO
INSERT [dbo].[CoachStudentMoney] ([Id], [StudentUserId], [CoachId], [Amount], [IsPay], [ThenMoney], [CourseTypeId], [CourseTypeName], [Deadline], [CreateDate], [HeadUrl],ThenTotalAmount,CityId)  
VALUES (N'4abf333352a24f30899da74501510724', N'c0758234e4884d22be22a745014fb899', N'b1ca6678-f060-47a6-bb32-a5d300e9240e', 10, 1, CAST(1000.00 AS Decimal(18, 2)), N'027001', N'大课', '2017-12-31 23:59:59.997', '2017-12-31 23:59:59.997', NULL,
10,'75')
GO

 