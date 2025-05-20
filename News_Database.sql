-- Create the database
CREATE DATABASE NewspaperDB;
GO
--//--
-- Use the newly created database
USE NewspaperDB;
GO
--//--
--from user to devc--
--create tbl UserInfo
CREATE TABLE [dbo].[UserInfo] (
    [UserID]         NVARCHAR (30)  NOT NULL,
    [UserName]       NVARCHAR (30)  NOT NULL UNIQUE,
    [PassWord]       NVARCHAR (15)  NOT NULL,
    [FullName]       NVARCHAR (35)  NOT NULL,
    [Address]        NVARCHAR (45)  NOT NULL,
    [PhoneNumber]    NVARCHAR (13)  NOT NULL,
    [Email]          NVARCHAR (35)  NOT NULL,
    [Gender]         NVARCHAR (7)   NOT NULL,
    [Birthdate]      DATETIME NOT NULL,
    [UsingTime]      VARCHAR(10)     NOT NULL,
    [UserAvatarInfo] VARCHAR(200)         NOT NULL,
    CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED ([UserID] ASC),
    CONSTRAINT [CK_Password] CHECK (LEN([PassWord]) >= 8)
);
--create tbl UserType
CREATE TABLE [dbo].[UserType] (
    [UserTypeID]   NVARCHAR (30)  NOT NULL,
    [UserTimeStart]     DATETIME      NOT NULL,
    [UserType]     NVARCHAR (35)  NOT NULL,
    [UserID]       NVARCHAR (30)  NOT NULL,
    CONSTRAINT [PK_UserType] PRIMARY KEY CLUSTERED ([UserTypeID] ASC),
    CONSTRAINT [FK_UserType_UserInfo] FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserInfo] ([UserID])
);
--create tbl Device
CREATE TABLE [dbo].[Device] (
    [UserDeviceID]        NVARCHAR (30) NOT NULL,
    [UserDeviceIP]        NVARCHAR (30) NOT NULL,
    [UserOperatingSystem] NVARCHAR (30) NOT NULL,
    [UserDevice]          NVARCHAR (15) NOT NULL,
    [UserCount]           INT NOT NULL,
    [UserID]              NVARCHAR (30) NOT NULL,
    CONSTRAINT [PK_Device] PRIMARY KEY CLUSTERED ([UserDeviceID] ASC),
    CONSTRAINT [FK_Device_UserInfo] FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserInfo] ([UserID])
);
--from group to cmt--
--create tbl GroupInfo
CREATE TABLE [dbo].[GroupInfo] (
    [GroupID]       NVARCHAR (30) NOT NULL,
    [GroupName]     NVARCHAR (30) NOT NULL,
    [DateGroup]     DATETIME     NOT NULL,
    [AdminEditName] NVARCHAR (30) NOT NULL,
    CONSTRAINT [PK_GroupInfo] PRIMARY KEY CLUSTERED ([GroupID] ASC)
);
--create tbl CategoryInfo
CREATE TABLE [dbo].[CategoryInfo] (
    [CategoryID]      NVARCHAR (30)  NOT NULL,
    [CategoryName]    NVARCHAR (15)  NOT NULL,
    [CategoryContent] NVARCHAR (255) NOT NULL,
    [GroupID]         NVARCHAR (30)  NOT NULL,
    CONSTRAINT [PK_CategoryInfo] PRIMARY KEY CLUSTERED ([CategoryID] ASC),
    CONSTRAINT [FK_CategoryInfo_GroupInfo] FOREIGN KEY ([GroupID]) REFERENCES [dbo].[GroupInfo] ([GroupID])
);
--create tbl PostInfo
CREATE TABLE [dbo].[PostInfo] (
    [PostID]      NVARCHAR (30)  NOT NULL,
    [PostContent] NVARCHAR (255) NOT NULL,
    [DatePost]    DATETIME      NOT NULL,
    [UserPost]    NVARCHAR (30)  NOT NULL,
    [PostCount]     INT,
    [CategoryID]  NVARCHAR (30)  NOT NULL,
    CONSTRAINT [PK_PostInfo] PRIMARY KEY CLUSTERED ([PostID] ASC),
    CONSTRAINT [FK_PostInfo_CategoryInfo] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[CategoryInfo] ([CategoryID])
);
--create tbl CommentDetail
CREATE TABLE [dbo].[CommentDetail] (
    [CommentID]      NVARCHAR (30)  NOT NULL,
    [HistoryComment] NVARCHAR (255) NOT NULL,
    [HistoryLogin]   NVARCHAR (35)  NOT NULL,
    [PostID]         NVARCHAR (30)  NOT NULL,
    CONSTRAINT [PK_CommentDetail] PRIMARY KEY CLUSTERED ([CommentID] ASC),
    CONSTRAINT [FK_CommentDetail_PostInfo] FOREIGN KEY ([PostID]) REFERENCES [dbo].[PostInfo] ([PostID])
);
--create tbl ImageInfo
CREATE TABLE [dbo].[ImageInfo] (
    [ImageID]   NVARCHAR (30) NOT NULL PRIMARY KEY,
    [ImageName] NVARCHAR (50) NOT NULL,
    [UrlImage]  NVARCHAR (100) NOT NULL,
    [ImageType] NVARCHAR (10) NOT NULL,
    [PostID]    NVARCHAR (30) NOT NULL,
    CONSTRAINT [FK_ImageInfo_PostInfo] FOREIGN KEY ([PostID]) REFERENCES [dbo].[PostInfo] ([PostID])
);
--//--
--insert tbl GroupInfo
INSERT INTO GroupInfo VALUES ('grp001','Worlds Political News','2000-12-01', 'adm001'),
                                ('grp002', 'Financial News', '2000-12-01', 'adm001'),
                                ('grp003', 'Tech News', '2000-12-01','adm001'),
                                ('grp004','Culture News', '2000-12-01', 'adm001'),
                                ('grp005', 'National News', '2000-12-01', 'adm001'),
                                ('grp006', 'Machinary Industry News', '2000-12-01','adm001'),
                                ('grp007','sPort News','2000-12-01', 'adm001'),
                                ('grp008', 'eSports News', '2000-12-01', 'adm001'),
                                ('grp009', 'Unmanned', '2000-12-01','adm001'),
                                ('grp010',' Local Industry News', '2000-12-01', 'adm001'),
                                ('grp011', 'Travel News', '2000-12-01', 'adm001'),
                                ('grp012', 'Car News', '2000-12-01','adm001');
--insert into tbl CategoryInfo
INSERT INTO CategoryInfo VALUES ('ctg001','Worlds News','War, Politics, Religions', 'grp001'),
                                ('ctg002', 'Finance', 'Bitcoin, USD, Countries GDP', 'grp002'),
                                ('ctg003', 'Technology', 'Laptop, Intelligient Machine, Machine Learning','grp003'),
                                ('ctg004','Culture', 'Local culture, Worldwide culture', 'grp004'),
                                ('ctg005', 'National', 'Military systems, Bank system', 'grp005'),
                                ('ctg006', 'Machine', 'CNC, Manual Machine, Russian Machine','grp006'),
                                ('ctg007','Sports','Tenis, Balling, Bia', 'grp007'),
                                ('ctg008', 'eSports', 'Freefire, Hotel, Counter As1', 'grp008'),
                                ('ctg009', 'Unmanned airs', 'Agricultural unmanned machines, industrial unmanned machine','grp009'),
                                ('ctg010','Industry', 'Local Industry, Foreign Industry', 'grp010'),
                                ('ctg011', 'Travel', 'Local travel, Foreign travel, ...', 'grp011'),
                                ('ctg012', 'Car World', 'Europe Car, Asian Car, American Car','grp012');
--insert tbl PostInfo
INSERT INTO PostInfo VALUES ('pos001','Political Haiti','2022-05-01','admin001', 0, 'ctg001'),
                                ('pos002', 'Financial Europe', '2022-05-01','admin002', 1, 'ctg002'),
                                ('pos003', 'Financial East South Asian', '2022-06-01','admin002', 2, 'ctg003'),
                                ('pos004','Greeks Culture', '2021-07-01','admin001', 3, 'ctg004'),
                                ('pos005', 'National Industry', '2019-08-01','admin002', 4, 'ctg005'),
                                ('pos006', 'Unmanned Machine', '2019-05-01','admin001', 5, 'ctg006'),
                                ('pos007','Fes Tennis US','2020-05-01','admin002', 6, 'ctg007'),
                                ('pos008', 'eSports Freefire win01', '2020-05-01','admin001', 7, 'ctg008'),
                                ('pos009', 'Unmanned airs', '2022-05-01','admin003', 8, 'ctg009'),
                                ('pos010','Industry', '2022-05-01','admin001', 9, 'ctg010'),
                                ('pos011', 'Travel all days', '2021-01-12','admin002', 10, 'ctg011'),
                                ('pos012', 'Genesis Car', '2020-12-01','admin003', 11, 'ctg012');
--insert tbl UserInfo
INSERT INTO UserInfo VALUES ('us001','konsvecto12','xiaomisys','Kons Vecto','100 Weli Streets, Anpha Pre','0994395885','konsvecto12@gmail.com','male','1999-12-01','12:20:00','https://hongkongsdf.com/kouslouisandfilms1/g5678'),
                            ('us002','davidliiz12','macsys09','David Liiz','101 Weli Streets, Anpha Pre','0932894833','davidliiz12@gmail.com','female','2001-12-12','09:12:11','https://hongkongsdf.com/kouslouisandfilms2/g5679'),
                            ('us003','kaneuos12','huaweisys','Kane Ups','102 Weli Streets, Anpha Pre','0905043043','kaneuos12@gmail.com','male','1999-09-15','10:01:20','https://hongkongsdf.com/kouslouisandfilms2/g5680'),
                            ('us004','mikennowse12','huaweisys','Miken Nowse','103 Weli Streets, Anpha Pre','0976897349','mikennowse12@gmail.com','male','1998-08-10','15:01:25','https://hongkongsdf.com/kouslouisandfilms2/g5681'),
                            ('us005','noisnous12','androidsys','Nois Nous','104 Weli Streets, Anpha Pre','0973565849','noisnous12@gmail.com','female','1997-08-17','17:01:20','https://hongkongsdf.com/kouslouisandfilms2/g5682'),
                            ('us006','peternunp12','iosyssys','Peter Nunp','105 Weli Streets, Anpha Pre','0967547349','peternunp12@gmail.com','female','1990-03-09','16:09:20','https://hongkongsdf.com/kouslouisandfilms2/g5683'),
                            ('us007','fokimei12','visionOSsys','Foki Mei','106 Weli Streets, Anpha Pre','0973511779','fokimei12@gmail.com','male','1991-10-19','22:08:20','https://hongkongsdf.com/kouslouisandfilms2/g5684'),
                            ('us008','lingmeimei12','visionultrasys','Ling Mei Mei','107 Weli Streets, Anpha Pre','0973823449','lingmeimei12@gmail.com','male','1990-04-10','23:01:20','https://hongkongsdf.com/kouslouisandfilms2/g5685'),
                            ('us009','shiang89mons','vistasys12','Shiang Monster','108 Weli Streets, Anpha Pre','0955667349','shiang89mons@gmail.com','female','1992-08-12','18:01:20','https://hongkongsdf.com/kouslouisandfilms2/g5686'),
                            ('us010','keptonouns89','Xsystasys12', 'Kepto Nouns','109 Weli Streets, Anpha Pre','0973877790','keptonouns89@gmail.com','male','1993-06-08','07:01:20','https://hongkongsdf.com/kouslouisandfilms2/g5687'),
                            ('us011','louisdenv12','terminalsys','Louis Denv','110 Weli Streets, Anpha Pre','0885437009','louisdenv12@gmail.com','male','1990-09-01','08:01:20','https://hongkongsdf.com/kouslouisandfilms2/g5688'),
                            ('us012','louddidi129','winsys569','Loud Di Di','111 Weli Streets, Anpha Pre','0885454459','louddidi129@gmail.com','female','1995-12-03','04:01:20','https://hongkongsdf.com/kouslouisandfilms2/g5689');
--insert tbl UserType
INSERT INTO UserType VALUES ('ut001','2020-05-12','business','us001'),
                            ('ut002','2021-05-12','accountant','us002'),
                            ('ut003','2021-05-12','business','us003'),
                            ('ut004','2021-05-12','normal','us004'),
                            ('ut005','2021-05-12','normal','us005'),
                            ('ut006','2019-05-12','business','us006'),
                            ('ut007','2020-05-12','dev','us007'),
                            ('ut008','2020-05-12','dev','us008'),
                            ('ut009','2020-05-12','physicians','us009'),
                            ('ut010','2020-05-12','mediator','us010'),
                            ('ut011','2020-05-12','techtor','us011'),
                            ('ut012','2020-05-12','adminentor','us012');
--insert into tbl Device 
INSERT INTO Device VALUES ('ud001','1.7.246.255','xiaomi sys','Huawei pro2',200,'us001'),
                            ('ud002','2.16.10.255','mac sys','Xiaomi proxs',300,'us002'),
                            ('ud003','2.16.10.255','huawei sys','VisionPro2',400,'us003'),
                            ('ud004','2.16.28.239','huawei sys','AndroidSX',400,'us004'),
                            ('ud005','2.56.23.255','android sys','Iphone pro 13',500,'us005'),
                            ('ud006','2.255.252.186','ios sys','Iphone pro 15',250,'us006'),
                            ('ud007','2.255.254.14','vision OS sys','Iphone pro 14',350,'us007'),
                            ('ud008','5.133.210.125','vision ultra sys','Iphone pro 13',450,'us008'),
                            ('ud009','5.133.215.31','vista sys','Vision Pro 3',320,'us009'),
                            ('ud010','5.133.215.211','X sys','Vision Pro 4',210,'us010'),
                            ('ud011','5.133.216.135','terminal sys','Iphone 16',180,'us011'),
                            ('ud012','5.133.223.57','win sys','Iphone 15 Pro',150,'us012');
--insert into tbl CommentDetail
INSERT INTO CommentDetail VALUES ('cmt001','From left: Formula One racer and brand partner of Genesis Jacky Ickx.','2000-12-02','pos001'),
                                    ('cmt002','America; Luc Donckerwolke, chief creative officer at Genesis; Chang','2000-12-11','pos002'),
                                    ('cmt003','the brands first full-size electric sports utility vehicle','2009-01-12','pos003'),
                                    ('cmt004','Neolun and the high-performance GV60 Magma','2008-10-09','pos004'),
                                    ('cmt005','House New York on Monday, highlighting the future vision of the luxury automaker','2008-09-01','pos005'),
                                    ('cmt006','According to Hyundai Motor Group, the electric SUV concepts','2010-09-19','pos006'),
                                    ('cmt007','The distinctive coach doors on the side','2011-11-01','pos007'),
                                    ('cmt008','Genesis underlined that the Neoluns interior cabin represents ','2011-10-09','pos007'),
                                    ('cmt009','the concept cars heating system','2019-12-21','pos003'),
                                    ('cmt010','underneath the floor to warm a room','2020-03-12','pos008'),
                                    ('cmt011','The front-row seats swiveling function also adds more to the concept vehicles interior hospitality','2019-03-02','pos009'),
                                    ('cmt012','will add a new dimension to the luxury auto brand as it','2001-05-17','pos010'),
                                    ('cmt013','The automaker said the plan is to ultimately develop a high-performance Magma ','2001-05-12','pos011');
--insert tbl ImageInfo
INSERT INTO ImageInfo VALUES ('img001','Political Haiti Image','databinary01','jpg', 'pos001'),
                                ('img002', 'Financial Europe Image', 'databinary02','jpg', 'pos002'),
                                ('img003', 'Financial East South Asian Image', 'databinary03','jpg','pos003'),
                                ('img104','Greeks Culture Image', 'databinary04','jpg', 'pos004'),
                                ('img005', 'National Industry Image', 'databinary05','jpg', 'pos005'),
                                ('img006', 'Unmanned Machine Image', 'databinary06','jpg','pos006'),
                                ('img007','Fes Tennis US Image','databinary07','jpg', 'pos007'),
                                ('img008', 'eSports Freefire win01 Image', 'databinary08','jpg', 'pos008'),
                                ('img009', 'Unmanned airs Image', 'databinary09','jpg','pos009'),
                                ('img010',' Local Industry Image', 'databinary010','jpg', 'pos010'),
                                ('img011', 'Travel Image', 'databinary011','jpg', 'pos011'),
                                ('img012', 'Genesis Car Image', 'databinary012','jpg','pos012');

--//--
--create procedure update UserName
CREATE PROCEDURE pr_nameUserInfo_tbl_update 
    (@oldName NVARCHAR(1024),
    @newName NVARCHAR(1024))
    AS
        UPDATE UserInfo SET UserName = @newName WHERE UserName = @oldName;
--call procedure pr_nameUserInfo_tbl_update
DECLARE @rc INT
DECLARE @oldName NVARCHAR(1024)
DECLARE @newName NVARCHAR(1024)
SET @oldName = 'Sia Nhohe';
SET @newName = 'Sia the bot';
--add exec--
EXECUTE @rc = [dbo].[pr_nameUserInfo_tbl_update] @oldName, @newName;

--create proc insert tbl GroupInfo
CREATE PROCEDURE pr_insertGroupInfo_tbl_insert
    (@groupID NVARCHAR(1024), @groupName NVARCHAR(1024), @dateGroup DATETIME, @adminname NVARCHAR(1024))
    AS 
    INSERT INTO GroupInfo VALUES (@groupID, @groupName, @dateGroup, @adminname);
--call proc pr_insertGroupInfo_tbl_insert
DECLARE @rc1 INT
DECLARE @groupID NVARCHAR(1024)
DECLARE @groupName NVARCHAR(1024)
DECLARE @dateGroup NVARCHAR(1024)
DECLARE @adminname NVARCHAR(1024)
SET @groupID = 'grp019';
SET @groupName = 'UID Industry';
SET @dateGroup = '2000-12-30';
SET @adminname = 'adm001';
--add exec--
EXECUTE @rc1 = [dbo].[pr_insertGroupInfo_tbl_insert] @groupID, @groupName, @dateGroup, @adminname;
--procedure 2--
-- Create a stored procedure to get articles by a specific author
CREATE PROCEDURE GetPostByUser
    @UserPost NVARCHAR(50)
AS
BEGIN
    SELECT PostID, PostContent, DatePost
    FROM PostInfo
    WHERE UserPost = (SELECT UserPost FROM PostInfo WHERE UserPost = @UserPost);
END;
--//----//--
--find pers where gender 'male' and UserID ias nums
SELECT * FROM UserInfo WHERE [UserInfo].Gender LIKE 'male' AND UserID LIKE '[^(a-zA-Z)]';
--find pers where time le 12h
SELECT * FROM UserInfo WHERE UsingTime < CONVERT(TIME, '12:00:00');
--find pers where time nle 12h
SELECT * FROM UserInfo WHERE UsingTime < CONVERT(TIME, '12:00:00');
--find pers where len(phonenumber) el 10
SELECT UserName, FullName, PhoneNumber FROM UserInfo WHERE LEN(PhoneNumber) = 10;
--find pers where len(phonenumber) el 11
SELECT UserName, FullName, PhoneNumber FROM UserInfo WHERE LEN(PhoneNumber) != 10 ;
--delete from tbl UserInfo where name David Liiz
DELETE FROM UserInfo WHERE UserName LIKE 'David Liiz';
--joins 
--find PostInfo inner joins CategoryInfo where CategoryID = 'ctg002'
SELECT p1.PostContent, p1.DatePost, p2.* FROM PostInfo p1 JOIN CategoryInfo p2 ON p1.CategoryID = p2.CategoryID WHERE p2.CategoryID = 'ctg002';
--find 3 pers where age less than others then sort ascending
SELECT TOP 10 UserName, YEAR(GETDATE()) - YEAR(CONVERT(DATETIME,Birthdate)) AS Age 
FROM UserInfo WHERE (Birthdate IN (SELECT TOP 10 Birthdate FROM UserInfo ORDER BY Birthdate ASC)) ORDER BY Age ASC ;
--create view vw_find3pers
CREATE VIEW vw_find3persAge AS 
    SELECT TOP 3 UserName, YEAR(GETDATE()) - YEAR(CONVERT(DATETIME,Birthdate)) AS Age 
    FROM UserInfo WHERE (Birthdate IN (SELECT TOP 10 Birthdate FROM UserInfo ORDER BY Birthdate ASC)) ORDER BY Age ASC ;
--call view vw_find3persAge
SELECT * FROM vw_find3persAge;
--select PostID and count comments each PostID and has least 2 comments exist
SELECT PostID, COUNT(CommentID) AS 'comments count' FROM CommentDetail GROUP BY PostID HAVING COUNT(CommentID) = 2;
--select count numbers of male in tbl UserInfo
SELECT COUNT(Gender) AS 'male count' FROM UserInfo WHERE Gender = 'male' ;
--select count numbers of female in tbl UserInfo
SELECT COUNT(Gender) AS 'female count' FROM UserInfo WHERE Gender = 'female' ;
--trigger--
-- Create a trigger to update article count when a new article is inserted
CREATE TRIGGER UpdatePostCount
ON PostInfo
AFTER INSERT
AS
BEGIN
    UPDATE PostInfo
    SET PostCount = PostCount + 1
    WHERE PostID IN (SELECT PostID FROM inserted);
END;
--function--
-- Create a function to calculate the number of User posted for posts in tbl in 2 years recently to now
CREATE FUNCTION GetPostCountOfEachAdmin (@UserPost NVARCHAR(1024))
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM PostInfo WHERE UserPost = @UserPost AND DatePost < DATEADD(YEAR, -2, GETDATE());
    RETURN @Count;
END;
--create function to count comments on specified post
CREATE FUNCTION GetCommentCount (@PostID NVARCHAR(30))
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM CommentDetail WHERE PostID = @PostID;
    RETURN @Count;
END;
-- Create an index on DatePost column for quick access
CREATE INDEX IX_DatePost ON PostInfo(DatePost);
-- Example of a transaction that inserts 2 new post
BEGIN TRANSACTION;
INSERT INTO PostInfo VALUES ('pos013','HawaiiStyle Stores', GETDATE(),'admin001', 'ctg011');
INSERT INTO PostInfo VALUES ('pos014','HawaiiStyle Life', GETDATE(),'admin002', 'ctg011');
COMMIT TRANSACTION;
--retrieve data on a table
SELECT * FROM GroupInfo;
--select using Order by
SELECT * FROM PostInfo ORDER BY PostID ASC;
--select using Like operator and string comparisons
SELECT * FROM PostInfo WHERE PostContent LIKE 'Financial%';
--select related to time conditions
SELECT * FROM PostInfo WHERE DatePost >= '2000-12-01';
-- select data from multiple tables using Inner join
SELECT a.CategoryName, b.PostContent
FROM CategoryInfo a
INNER JOIN PostInfo b ON a.CategoryID = b.CategoryID;
--select using Self join, Outer join
SELECT a1.CategoryName, a2.CategoryName AS RelatedCategoryName
FROM CategoryInfo a1
LEFT JOIN CategoryInfo a2 ON a1.CategoryID = a2.CategoryID AND a1.CategoryID <> a2.CategoryID;
--select using With
WITH RecentPosts AS (
    SELECT *
    FROM PostInfo
    WHERE DatePost >= DATEADD(YEAR, -12, GETDATE())
)
SELECT * FROM RecentPosts;
--select using Group by and Having
SELECT PostID, COUNT(*) AS PostCount
FROM PostInfo
GROUP BY PostID
HAVING COUNT(*) > 2;
--**--
--select using the function written in the previous step
SELECT PostID, PostContent, dbo.GetCommentCount(PostID) AS CommentCount
FROM PostInfo;