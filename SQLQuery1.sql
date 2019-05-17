USE [SEDCHome]
GO


--kreiranje na tabeli 
--Id na teacher e smallint bidejki nema poveke od 88 profesori(ako gledame dolgorocno ke stavime  smallint)
--Site primaat vrednosti (osnovni podatoci za profesor)

CREATE TABLE [dbo].Teacher(
	[Id][smallint] IDENTITY(1,1) NOT NULL,
	[FirstName][nvarchar](50) NOT NULL,
	[LastName][nvarchar](50) NOT NULL,
	[DateOfBirth][date] NOT NULL,
	[AcademicRank][nvarchar](50) NOT NULL,
	[HireDate][date] NOT NULL,
CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED
(
	[Id] ASC
))
GO

--NacionalIdentityNumber i CardNumber se odluciv za nvarchar zatoa sto ne e naglaseno dena se samo brojki
--istite mozat da bidat kombinacija na brojki, znaci i bukvi (mozebi studentot e stranec)
--ako se gleda dolgorocno i student bi trebalo da bide int no sega za sega dovolnno e smallint :)
CREATE TABLE [dbo].Student(
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[FirstName][nvarchar](50) NOT NULL,
	[LastName][nvarchar](50) NOT NULL,
	[DateOfBirth][date] NOT NULL,
	[EnrolledDate][date] NOT NULL,
	[Gender][char] NOT NULL,
	[NationalIDNumber][nvarchar](50) NOT NULL,
	[StudentCardNumber][nvarchar](50) NOT NULL,
CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED
(
	[Id] ASC
))
GO

--AcademicYear se odluciv za nvarchar bidejki moze da bide 2019/2020
--Semester nvarchar ..moze da bide I, II..IXa,.. Prv, Vtor...

CREATE TABLE [dbo].Course(
	[Id][tinyint] IDENTITY(1,1) NOT NULL,
	[Name][nvarchar](100) NOT NULL,
	[Credit][smallint] NOT NULL,
	[AcademicYear][nvarchar](15) NOT NULL,
	[Semester][nvarchar](10) NOT NULL,
CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED
(
	[Id] ASC
))
GO

--ako se cuvaat podatocite za Grades (koi momentalno se 20000) treba da se ostavi prostor i zatoa int

CREATE TABLE [dbo].Grade(
	[Id][int] IDENTITY(1,1) NOT NULL
	[StudentID][smallint] NOT NULL,
	[CourseID][tinyint] NOT NULL,
	[TeacherID][tinyint] NOT NULL,
	[Grade][tinyint] NOT NULL,
	[Comment][nvarchar](100) NULL,
	[CreatedDate][smalldatetime] NOT NULL,
CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED
(
	[Id] ASC
))
GO



CREATE TABLE [dbo].ArhievementType(
	[Id][int] IDENTITY(1,1) NOT NULL,
	[Name][nvarchar](100) NOT NULL,
	[Description][nvarchar](100) NULL,
	[ParticipationRate][smallmoney] NULL,
CONSTRAINT [PK_ArhievementType] PRIMARY KEY CLUSTERED
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].GradeDetails(
	[Id][int] IDENTITY(1,1) NOT NULL,
	[GradeID][int] NOT NULL,
	[ArhievementTypeID][int] NOT NULL,
	[ArhievementPoints][smallint] NOT NULL,
	[ArhivementMaxPoints][smallint] NOT NULL,
	[ArhivementDate][date] NOT NULL,
CONSTRAINT [PK_GradeDetails] PRIMARY KEY CLUSTERED
(
	[Id] ASC
))
GO