USE [master]
GO
/****** Object:  Database [SpaceBook]    Script Date: 2019-04-01 2:20:29 AM ******/
CREATE DATABASE [SpaceBook]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SpaceBook', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\SpaceBook.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SpaceBook_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\SpaceBook_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [SpaceBook] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SpaceBook].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SpaceBook] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SpaceBook] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SpaceBook] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SpaceBook] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SpaceBook] SET ARITHABORT OFF 
GO
ALTER DATABASE [SpaceBook] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SpaceBook] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SpaceBook] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SpaceBook] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SpaceBook] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SpaceBook] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SpaceBook] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SpaceBook] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SpaceBook] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SpaceBook] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SpaceBook] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SpaceBook] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SpaceBook] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SpaceBook] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SpaceBook] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SpaceBook] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SpaceBook] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SpaceBook] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SpaceBook] SET  MULTI_USER 
GO
ALTER DATABASE [SpaceBook] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SpaceBook] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SpaceBook] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SpaceBook] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SpaceBook] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SpaceBook] SET QUERY_STORE = OFF
GO
USE [SpaceBook]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 2019-04-01 2:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[FacilityId] [int] NOT NULL,
	[StartDateTime] [datetime] NULL,
	[EndDateTime] [datetime] NULL,
	[Cost] [money] NULL,
	[Notes] [varchar](max) NULL,
	[Cancelled] [bit] NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facility]    Script Date: 2019-04-01 2:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facility](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](100) NULL,
	[Phone] [varchar](15) NULL,
	[Description] [varchar](max) NULL,
	[Address] [varchar](250) NULL,
	[City] [varchar](50) NULL,
	[PostalCode] [varchar](50) NULL,
	[Province] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[Type] [int] NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[HourlyRate] [money] NULL,
	[ActiveFlag] [bit] NULL,
 CONSTRAINT [PK_Facility] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacilityTime]    Script Date: 2019-04-01 2:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacilityTime](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FacilityId] [int] NOT NULL,
	[BookingId] [int] NULL,
	[StartTime] [time](7) NULL,
	[Day] [int] NULL,
	[Rate] [money] NULL,
	[IsAvailable] [bit] NULL,
 CONSTRAINT [PK_FacilityTime] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacilityType]    Script Date: 2019-04-01 2:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacilityType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_FacilityType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 2019-04-01 2:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Type] [int] NULL,
	[Message] [varchar](max) NULL,
	[DateTime] [datetime] NULL,
	[IsReadFlag] [bit] NULL,
	[ActiveFlag] [bit] NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationType]    Script Date: 2019-04-01 2:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_NotificationType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 2019-04-01 2:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[FacilityId] [int] NOT NULL,
	[BookingId] [int] NOT NULL,
	[Rating] [int] NULL,
	[Comment] [varchar](max) NULL,
	[ActiveFlag] [bit] NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TagAssignment]    Script Date: 2019-04-01 2:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TagAssignment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TagId] [int] NOT NULL,
	[FacilityId] [int] NOT NULL,
 CONSTRAINT [PK_TagAssignment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TagType]    Script Date: 2019-04-01 2:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TagType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_FacilityTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 2019-04-01 2:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Phone] [varchar](15) NULL,
	[ProfilePicFilename] [varchar](50) NOT NULL,
	[Type] [int] NOT NULL,
	[ActiveFlag] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserType]    Script Date: 2019-04-01 2:20:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_UserType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Booking] ON 
GO
INSERT [dbo].[Booking] ([Id], [UserId], [FacilityId], [StartDateTime], [EndDateTime], [Cost], [Notes], [Cancelled]) VALUES (1, 1, 1, CAST(N'2019-03-18T08:00:00.000' AS DateTime), CAST(N'2019-03-18T08:00:00.000' AS DateTime), 30.0000, N'this is a test note', 0)
GO
SET IDENTITY_INSERT [dbo].[Booking] OFF
GO
SET IDENTITY_INSERT [dbo].[Facility] ON 
GO
INSERT [dbo].[Facility] ([Id], [Name], [Email], [Phone], [Description], [Address], [City], [PostalCode], [Province], [Country], [Type], [StartTime], [EndTime], [HourlyRate], [ActiveFlag]) VALUES (1, N'The Field', N'test@gmail.com', N'3065781249', N'This is the description of the field', N'2094 Wascana Meadows', N'Regina', N'S4V4K8', N'Saskatchewan', N'Canada', 1, CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), 75.0000, 1)
GO
INSERT [dbo].[Facility] ([Id], [Name], [Email], [Phone], [Description], [Address], [City], [PostalCode], [Province], [Country], [Type], [StartTime], [EndTime], [HourlyRate], [ActiveFlag]) VALUES (2, N'Second Test Field', N'secondtest@gmail.com', N'3065471843', N'This is the description of the second field', N'2094 Wascana Meadows', N'Regina', N'S4V4K8', N'Saskatchewan', N'Canada', 1, CAST(N'07:00:00' AS Time), CAST(N'20:00:00' AS Time), 50.0000, 1)
GO
INSERT [dbo].[Facility] ([Id], [Name], [Email], [Phone], [Description], [Address], [City], [PostalCode], [Province], [Country], [Type], [StartTime], [EndTime], [HourlyRate], [ActiveFlag]) VALUES (3, N'Connors Facility', N'connor.meredith1@gmail.com', N'3065555555', N'This is the test description', N'11146 Wascana Meadow', N'Regina', N'S4V 2W2', N'SK', N'Canada', 1, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[Facility] ([Id], [Name], [Email], [Phone], [Description], [Address], [City], [PostalCode], [Province], [Country], [Type], [StartTime], [EndTime], [HourlyRate], [ActiveFlag]) VALUES (4, N'Connors Facility', N'test@gmail.com', N'3065555555', N'dasddsa', N'11146 Wascana Meadow', N'Regina', N'S4V 2W2', N'SK', N'Canada', 1, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Facility] OFF
GO
SET IDENTITY_INSERT [dbo].[FacilityTime] ON 
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (1, 3, NULL, CAST(N'00:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2, 3, NULL, CAST(N'00:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3, 3, NULL, CAST(N'01:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (4, 3, NULL, CAST(N'01:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (5, 3, NULL, CAST(N'02:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (6, 3, NULL, CAST(N'02:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (7, 3, NULL, CAST(N'03:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (8, 3, NULL, CAST(N'03:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (9, 3, NULL, CAST(N'04:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (10, 3, NULL, CAST(N'04:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (11, 3, NULL, CAST(N'05:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (12, 3, NULL, CAST(N'05:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (13, 3, NULL, CAST(N'06:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (14, 3, NULL, CAST(N'06:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (15, 3, NULL, CAST(N'07:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (16, 3, NULL, CAST(N'07:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (17, 3, NULL, CAST(N'08:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (18, 3, NULL, CAST(N'08:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (19, 3, NULL, CAST(N'09:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (20, 3, NULL, CAST(N'09:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (21, 3, NULL, CAST(N'10:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (22, 3, NULL, CAST(N'10:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (23, 3, NULL, CAST(N'11:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (24, 3, NULL, CAST(N'11:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (25, 3, NULL, CAST(N'12:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (26, 3, NULL, CAST(N'12:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (27, 3, NULL, CAST(N'13:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (28, 3, NULL, CAST(N'13:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (29, 3, NULL, CAST(N'14:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (30, 3, NULL, CAST(N'14:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (31, 3, NULL, CAST(N'15:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (32, 3, NULL, CAST(N'15:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (33, 3, NULL, CAST(N'16:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (34, 3, NULL, CAST(N'16:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (35, 3, NULL, CAST(N'17:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (36, 3, NULL, CAST(N'17:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (37, 3, NULL, CAST(N'18:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (38, 3, NULL, CAST(N'18:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (39, 3, NULL, CAST(N'19:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (40, 3, NULL, CAST(N'19:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (41, 3, NULL, CAST(N'20:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (42, 3, NULL, CAST(N'20:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (43, 3, NULL, CAST(N'21:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (44, 3, NULL, CAST(N'21:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (45, 3, NULL, CAST(N'22:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (46, 3, NULL, CAST(N'22:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (47, 3, NULL, CAST(N'23:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (48, 3, NULL, CAST(N'23:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (49, 3, NULL, CAST(N'00:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (50, 3, NULL, CAST(N'00:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (51, 3, NULL, CAST(N'01:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (52, 3, NULL, CAST(N'01:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (53, 3, NULL, CAST(N'02:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (54, 3, NULL, CAST(N'02:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (55, 3, NULL, CAST(N'03:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (56, 3, NULL, CAST(N'03:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (57, 3, NULL, CAST(N'04:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (58, 3, NULL, CAST(N'04:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (59, 3, NULL, CAST(N'05:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (60, 3, NULL, CAST(N'05:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (61, 3, NULL, CAST(N'06:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (62, 3, NULL, CAST(N'06:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (63, 3, NULL, CAST(N'07:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (64, 3, NULL, CAST(N'07:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (65, 3, NULL, CAST(N'08:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (66, 3, NULL, CAST(N'08:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (67, 3, NULL, CAST(N'09:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (68, 3, NULL, CAST(N'09:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (69, 3, NULL, CAST(N'10:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (70, 3, NULL, CAST(N'10:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (71, 3, NULL, CAST(N'11:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (72, 3, NULL, CAST(N'11:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (73, 3, NULL, CAST(N'12:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (74, 3, NULL, CAST(N'12:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (75, 3, NULL, CAST(N'13:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (76, 3, NULL, CAST(N'13:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (77, 3, NULL, CAST(N'14:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (78, 3, NULL, CAST(N'14:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (79, 3, NULL, CAST(N'15:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (80, 3, NULL, CAST(N'15:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (81, 3, NULL, CAST(N'16:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (82, 3, NULL, CAST(N'16:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (83, 3, NULL, CAST(N'17:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (84, 3, NULL, CAST(N'17:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (85, 3, NULL, CAST(N'18:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (86, 3, NULL, CAST(N'18:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (87, 3, NULL, CAST(N'19:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (88, 3, NULL, CAST(N'19:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (89, 3, NULL, CAST(N'20:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (90, 3, NULL, CAST(N'20:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (91, 3, NULL, CAST(N'21:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (92, 3, NULL, CAST(N'21:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (93, 3, NULL, CAST(N'22:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (94, 3, NULL, CAST(N'22:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (95, 3, NULL, CAST(N'23:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (96, 3, NULL, CAST(N'23:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (97, 3, NULL, CAST(N'00:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (98, 3, NULL, CAST(N'00:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (99, 3, NULL, CAST(N'01:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (100, 3, NULL, CAST(N'01:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (101, 3, NULL, CAST(N'02:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (102, 3, NULL, CAST(N'02:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (103, 3, NULL, CAST(N'03:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (104, 3, NULL, CAST(N'03:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (105, 3, NULL, CAST(N'04:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (106, 3, NULL, CAST(N'04:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (107, 3, NULL, CAST(N'05:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (108, 3, NULL, CAST(N'05:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (109, 3, NULL, CAST(N'06:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (110, 3, NULL, CAST(N'06:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (111, 3, NULL, CAST(N'07:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (112, 3, NULL, CAST(N'07:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (113, 3, NULL, CAST(N'08:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (114, 3, NULL, CAST(N'08:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (115, 3, NULL, CAST(N'09:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (116, 3, NULL, CAST(N'09:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (117, 3, NULL, CAST(N'10:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (118, 3, NULL, CAST(N'10:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (119, 3, NULL, CAST(N'11:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (120, 3, NULL, CAST(N'11:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (121, 3, NULL, CAST(N'12:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (122, 3, NULL, CAST(N'12:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (123, 3, NULL, CAST(N'13:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (124, 3, NULL, CAST(N'13:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (125, 3, NULL, CAST(N'14:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (126, 3, NULL, CAST(N'14:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (127, 3, NULL, CAST(N'15:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (128, 3, NULL, CAST(N'15:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (129, 3, NULL, CAST(N'16:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (130, 3, NULL, CAST(N'16:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (131, 3, NULL, CAST(N'17:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (132, 3, NULL, CAST(N'17:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (133, 3, NULL, CAST(N'18:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (134, 3, NULL, CAST(N'18:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (135, 3, NULL, CAST(N'19:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (136, 3, NULL, CAST(N'19:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (137, 3, NULL, CAST(N'20:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (138, 3, NULL, CAST(N'20:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (139, 3, NULL, CAST(N'21:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (140, 3, NULL, CAST(N'21:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (141, 3, NULL, CAST(N'22:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (142, 3, NULL, CAST(N'22:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (143, 3, NULL, CAST(N'23:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (144, 3, NULL, CAST(N'23:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (145, 3, NULL, CAST(N'00:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (146, 3, NULL, CAST(N'00:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (147, 3, NULL, CAST(N'01:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (148, 3, NULL, CAST(N'01:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (149, 3, NULL, CAST(N'02:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (150, 3, NULL, CAST(N'02:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (151, 3, NULL, CAST(N'03:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (152, 3, NULL, CAST(N'03:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (153, 3, NULL, CAST(N'04:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (154, 3, NULL, CAST(N'04:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (155, 3, NULL, CAST(N'05:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (156, 3, NULL, CAST(N'05:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (157, 3, NULL, CAST(N'06:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (158, 3, NULL, CAST(N'06:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (159, 3, NULL, CAST(N'07:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (160, 3, NULL, CAST(N'07:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (161, 3, NULL, CAST(N'08:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (162, 3, NULL, CAST(N'08:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (163, 3, NULL, CAST(N'09:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (164, 3, NULL, CAST(N'09:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (165, 3, NULL, CAST(N'10:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (166, 3, NULL, CAST(N'10:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (167, 3, NULL, CAST(N'11:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (168, 3, NULL, CAST(N'11:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (169, 3, NULL, CAST(N'12:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (170, 3, NULL, CAST(N'12:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (171, 3, NULL, CAST(N'13:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (172, 3, NULL, CAST(N'13:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (173, 3, NULL, CAST(N'14:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (174, 3, NULL, CAST(N'14:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (175, 3, NULL, CAST(N'15:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (176, 3, NULL, CAST(N'15:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (177, 3, NULL, CAST(N'16:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (178, 3, NULL, CAST(N'16:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (179, 3, NULL, CAST(N'17:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (180, 3, NULL, CAST(N'17:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (181, 3, NULL, CAST(N'18:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (182, 3, NULL, CAST(N'18:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (183, 3, NULL, CAST(N'19:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (184, 3, NULL, CAST(N'19:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (185, 3, NULL, CAST(N'20:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (186, 3, NULL, CAST(N'20:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (187, 3, NULL, CAST(N'21:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (188, 3, NULL, CAST(N'21:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (189, 3, NULL, CAST(N'22:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (190, 3, NULL, CAST(N'22:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (191, 3, NULL, CAST(N'23:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (192, 3, NULL, CAST(N'23:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (193, 3, NULL, CAST(N'00:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (194, 3, NULL, CAST(N'00:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (195, 3, NULL, CAST(N'01:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (196, 3, NULL, CAST(N'01:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (197, 3, NULL, CAST(N'02:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (198, 3, NULL, CAST(N'02:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (199, 3, NULL, CAST(N'03:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (200, 3, NULL, CAST(N'03:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (201, 3, NULL, CAST(N'04:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (202, 3, NULL, CAST(N'04:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (203, 3, NULL, CAST(N'05:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (204, 3, NULL, CAST(N'05:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (205, 3, NULL, CAST(N'06:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (206, 3, NULL, CAST(N'06:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (207, 3, NULL, CAST(N'07:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (208, 3, NULL, CAST(N'07:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (209, 3, NULL, CAST(N'08:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (210, 3, NULL, CAST(N'08:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (211, 3, NULL, CAST(N'09:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (212, 3, NULL, CAST(N'09:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (213, 3, NULL, CAST(N'10:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (214, 3, NULL, CAST(N'10:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (215, 3, NULL, CAST(N'11:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (216, 3, NULL, CAST(N'11:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (217, 3, NULL, CAST(N'12:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (218, 3, NULL, CAST(N'12:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (219, 3, NULL, CAST(N'13:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (220, 3, NULL, CAST(N'13:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (221, 3, NULL, CAST(N'14:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (222, 3, NULL, CAST(N'14:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (223, 3, NULL, CAST(N'15:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (224, 3, NULL, CAST(N'15:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (225, 3, NULL, CAST(N'16:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (226, 3, NULL, CAST(N'16:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (227, 3, NULL, CAST(N'17:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (228, 3, NULL, CAST(N'17:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (229, 3, NULL, CAST(N'18:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (230, 3, NULL, CAST(N'18:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (231, 3, NULL, CAST(N'19:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (232, 3, NULL, CAST(N'19:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (233, 3, NULL, CAST(N'20:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (234, 3, NULL, CAST(N'20:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (235, 3, NULL, CAST(N'21:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (236, 3, NULL, CAST(N'21:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (237, 3, NULL, CAST(N'22:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (238, 3, NULL, CAST(N'22:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (239, 3, NULL, CAST(N'23:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (240, 3, NULL, CAST(N'23:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (241, 3, NULL, CAST(N'00:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (242, 3, NULL, CAST(N'00:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (243, 3, NULL, CAST(N'01:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (244, 3, NULL, CAST(N'01:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (245, 3, NULL, CAST(N'02:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (246, 3, NULL, CAST(N'02:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (247, 3, NULL, CAST(N'03:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (248, 3, NULL, CAST(N'03:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (249, 3, NULL, CAST(N'04:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (250, 3, NULL, CAST(N'04:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (251, 3, NULL, CAST(N'05:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (252, 3, NULL, CAST(N'05:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (253, 3, NULL, CAST(N'06:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (254, 3, NULL, CAST(N'06:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (255, 3, NULL, CAST(N'07:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (256, 3, NULL, CAST(N'07:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (257, 3, NULL, CAST(N'08:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (258, 3, NULL, CAST(N'08:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (259, 3, NULL, CAST(N'09:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (260, 3, NULL, CAST(N'09:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (261, 3, NULL, CAST(N'10:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (262, 3, NULL, CAST(N'10:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (263, 3, NULL, CAST(N'11:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (264, 3, NULL, CAST(N'11:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (265, 3, NULL, CAST(N'12:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (266, 3, NULL, CAST(N'12:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (267, 3, NULL, CAST(N'13:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (268, 3, NULL, CAST(N'13:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (269, 3, NULL, CAST(N'14:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (270, 3, NULL, CAST(N'14:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (271, 3, NULL, CAST(N'15:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (272, 3, NULL, CAST(N'15:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (273, 3, NULL, CAST(N'16:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (274, 3, NULL, CAST(N'16:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (275, 3, NULL, CAST(N'17:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (276, 3, NULL, CAST(N'17:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (277, 3, NULL, CAST(N'18:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (278, 3, NULL, CAST(N'18:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (279, 3, NULL, CAST(N'19:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (280, 3, NULL, CAST(N'19:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (281, 3, NULL, CAST(N'20:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (282, 3, NULL, CAST(N'20:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (283, 3, NULL, CAST(N'21:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (284, 3, NULL, CAST(N'21:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (285, 3, NULL, CAST(N'22:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (286, 3, NULL, CAST(N'22:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (287, 3, NULL, CAST(N'23:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (288, 3, NULL, CAST(N'23:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (289, 3, NULL, CAST(N'00:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (290, 3, NULL, CAST(N'00:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (291, 3, NULL, CAST(N'01:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (292, 3, NULL, CAST(N'01:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (293, 3, NULL, CAST(N'02:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (294, 3, NULL, CAST(N'02:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (295, 3, NULL, CAST(N'03:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (296, 3, NULL, CAST(N'03:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (297, 3, NULL, CAST(N'04:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (298, 3, NULL, CAST(N'04:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (299, 3, NULL, CAST(N'05:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (300, 3, NULL, CAST(N'05:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (301, 3, NULL, CAST(N'06:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (302, 3, NULL, CAST(N'06:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (303, 3, NULL, CAST(N'07:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (304, 3, NULL, CAST(N'07:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (305, 3, NULL, CAST(N'08:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (306, 3, NULL, CAST(N'08:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (307, 3, NULL, CAST(N'09:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (308, 3, NULL, CAST(N'09:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (309, 3, NULL, CAST(N'10:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (310, 3, NULL, CAST(N'10:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (311, 3, NULL, CAST(N'11:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (312, 3, NULL, CAST(N'11:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (313, 3, NULL, CAST(N'12:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (314, 3, NULL, CAST(N'12:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (315, 3, NULL, CAST(N'13:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (316, 3, NULL, CAST(N'13:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (317, 3, NULL, CAST(N'14:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (318, 3, NULL, CAST(N'14:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (319, 3, NULL, CAST(N'15:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (320, 3, NULL, CAST(N'15:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (321, 3, NULL, CAST(N'16:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (322, 3, NULL, CAST(N'16:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (323, 3, NULL, CAST(N'17:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (324, 3, NULL, CAST(N'17:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (325, 3, NULL, CAST(N'18:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (326, 3, NULL, CAST(N'18:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (327, 3, NULL, CAST(N'19:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (328, 3, NULL, CAST(N'19:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (329, 3, NULL, CAST(N'20:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (330, 3, NULL, CAST(N'20:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (331, 3, NULL, CAST(N'21:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (332, 3, NULL, CAST(N'21:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (333, 3, NULL, CAST(N'22:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (334, 3, NULL, CAST(N'22:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (335, 3, NULL, CAST(N'23:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (336, 3, NULL, CAST(N'23:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (337, 4, NULL, CAST(N'00:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (338, 4, NULL, CAST(N'00:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (339, 4, NULL, CAST(N'01:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (340, 4, NULL, CAST(N'01:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (341, 4, NULL, CAST(N'02:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (342, 4, NULL, CAST(N'02:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (343, 4, NULL, CAST(N'03:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (344, 4, NULL, CAST(N'03:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (345, 4, NULL, CAST(N'04:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (346, 4, NULL, CAST(N'04:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (347, 4, NULL, CAST(N'05:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (348, 4, NULL, CAST(N'05:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (349, 4, NULL, CAST(N'06:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (350, 4, NULL, CAST(N'06:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (351, 4, NULL, CAST(N'07:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (352, 4, NULL, CAST(N'07:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (353, 4, NULL, CAST(N'08:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (354, 4, NULL, CAST(N'08:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (355, 4, NULL, CAST(N'09:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (356, 4, NULL, CAST(N'09:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (357, 4, NULL, CAST(N'10:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (358, 4, NULL, CAST(N'10:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (359, 4, NULL, CAST(N'11:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (360, 4, NULL, CAST(N'11:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (361, 4, NULL, CAST(N'12:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (362, 4, NULL, CAST(N'12:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (363, 4, NULL, CAST(N'13:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (364, 4, NULL, CAST(N'13:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (365, 4, NULL, CAST(N'14:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (366, 4, NULL, CAST(N'14:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (367, 4, NULL, CAST(N'15:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (368, 4, NULL, CAST(N'15:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (369, 4, NULL, CAST(N'16:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (370, 4, NULL, CAST(N'16:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (371, 4, NULL, CAST(N'17:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (372, 4, NULL, CAST(N'17:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (373, 4, NULL, CAST(N'18:00:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (374, 4, NULL, CAST(N'18:30:00' AS Time), 1, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (375, 4, NULL, CAST(N'19:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (376, 4, NULL, CAST(N'19:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (377, 4, NULL, CAST(N'20:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (378, 4, NULL, CAST(N'20:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (379, 4, NULL, CAST(N'21:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (380, 4, NULL, CAST(N'21:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (381, 4, NULL, CAST(N'22:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (382, 4, NULL, CAST(N'22:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (383, 4, NULL, CAST(N'23:00:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (384, 4, NULL, CAST(N'23:30:00' AS Time), 1, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (385, 4, NULL, CAST(N'00:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (386, 4, NULL, CAST(N'00:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (387, 4, NULL, CAST(N'01:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (388, 4, NULL, CAST(N'01:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (389, 4, NULL, CAST(N'02:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (390, 4, NULL, CAST(N'02:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (391, 4, NULL, CAST(N'03:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (392, 4, NULL, CAST(N'03:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (393, 4, NULL, CAST(N'04:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (394, 4, NULL, CAST(N'04:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (395, 4, NULL, CAST(N'05:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (396, 4, NULL, CAST(N'05:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (397, 4, NULL, CAST(N'06:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (398, 4, NULL, CAST(N'06:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (399, 4, NULL, CAST(N'07:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (400, 4, NULL, CAST(N'07:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (401, 4, NULL, CAST(N'08:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (402, 4, NULL, CAST(N'08:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (403, 4, NULL, CAST(N'09:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (404, 4, NULL, CAST(N'09:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (405, 4, NULL, CAST(N'10:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (406, 4, NULL, CAST(N'10:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (407, 4, NULL, CAST(N'11:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (408, 4, NULL, CAST(N'11:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (409, 4, NULL, CAST(N'12:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (410, 4, NULL, CAST(N'12:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (411, 4, NULL, CAST(N'13:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (412, 4, NULL, CAST(N'13:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (413, 4, NULL, CAST(N'14:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (414, 4, NULL, CAST(N'14:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (415, 4, NULL, CAST(N'15:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (416, 4, NULL, CAST(N'15:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (417, 4, NULL, CAST(N'16:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (418, 4, NULL, CAST(N'16:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (419, 4, NULL, CAST(N'17:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (420, 4, NULL, CAST(N'17:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (421, 4, NULL, CAST(N'18:00:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (422, 4, NULL, CAST(N'18:30:00' AS Time), 2, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (423, 4, NULL, CAST(N'19:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (424, 4, NULL, CAST(N'19:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (425, 4, NULL, CAST(N'20:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (426, 4, NULL, CAST(N'20:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (427, 4, NULL, CAST(N'21:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (428, 4, NULL, CAST(N'21:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (429, 4, NULL, CAST(N'22:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (430, 4, NULL, CAST(N'22:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (431, 4, NULL, CAST(N'23:00:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (432, 4, NULL, CAST(N'23:30:00' AS Time), 2, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (433, 4, NULL, CAST(N'00:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (434, 4, NULL, CAST(N'00:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (435, 4, NULL, CAST(N'01:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (436, 4, NULL, CAST(N'01:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (437, 4, NULL, CAST(N'02:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (438, 4, NULL, CAST(N'02:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (439, 4, NULL, CAST(N'03:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (440, 4, NULL, CAST(N'03:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (441, 4, NULL, CAST(N'04:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (442, 4, NULL, CAST(N'04:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (443, 4, NULL, CAST(N'05:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (444, 4, NULL, CAST(N'05:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (445, 4, NULL, CAST(N'06:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (446, 4, NULL, CAST(N'06:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (447, 4, NULL, CAST(N'07:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (448, 4, NULL, CAST(N'07:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (449, 4, NULL, CAST(N'08:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (450, 4, NULL, CAST(N'08:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (451, 4, NULL, CAST(N'09:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (452, 4, NULL, CAST(N'09:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (453, 4, NULL, CAST(N'10:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (454, 4, NULL, CAST(N'10:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (455, 4, NULL, CAST(N'11:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (456, 4, NULL, CAST(N'11:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (457, 4, NULL, CAST(N'12:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (458, 4, NULL, CAST(N'12:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (459, 4, NULL, CAST(N'13:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (460, 4, NULL, CAST(N'13:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (461, 4, NULL, CAST(N'14:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (462, 4, NULL, CAST(N'14:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (463, 4, NULL, CAST(N'15:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (464, 4, NULL, CAST(N'15:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (465, 4, NULL, CAST(N'16:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (466, 4, NULL, CAST(N'16:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (467, 4, NULL, CAST(N'17:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (468, 4, NULL, CAST(N'17:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (469, 4, NULL, CAST(N'18:00:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (470, 4, NULL, CAST(N'18:30:00' AS Time), 3, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (471, 4, NULL, CAST(N'19:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (472, 4, NULL, CAST(N'19:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (473, 4, NULL, CAST(N'20:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (474, 4, NULL, CAST(N'20:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (475, 4, NULL, CAST(N'21:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (476, 4, NULL, CAST(N'21:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (477, 4, NULL, CAST(N'22:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (478, 4, NULL, CAST(N'22:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (479, 4, NULL, CAST(N'23:00:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (480, 4, NULL, CAST(N'23:30:00' AS Time), 3, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (481, 4, NULL, CAST(N'00:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (482, 4, NULL, CAST(N'00:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (483, 4, NULL, CAST(N'01:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (484, 4, NULL, CAST(N'01:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (485, 4, NULL, CAST(N'02:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (486, 4, NULL, CAST(N'02:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (487, 4, NULL, CAST(N'03:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (488, 4, NULL, CAST(N'03:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (489, 4, NULL, CAST(N'04:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (490, 4, NULL, CAST(N'04:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (491, 4, NULL, CAST(N'05:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (492, 4, NULL, CAST(N'05:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (493, 4, NULL, CAST(N'06:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (494, 4, NULL, CAST(N'06:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (495, 4, NULL, CAST(N'07:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (496, 4, NULL, CAST(N'07:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (497, 4, NULL, CAST(N'08:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (498, 4, NULL, CAST(N'08:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (499, 4, NULL, CAST(N'09:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (500, 4, NULL, CAST(N'09:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (501, 4, NULL, CAST(N'10:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (502, 4, NULL, CAST(N'10:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (503, 4, NULL, CAST(N'11:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (504, 4, NULL, CAST(N'11:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (505, 4, NULL, CAST(N'12:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (506, 4, NULL, CAST(N'12:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (507, 4, NULL, CAST(N'13:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (508, 4, NULL, CAST(N'13:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (509, 4, NULL, CAST(N'14:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (510, 4, NULL, CAST(N'14:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (511, 4, NULL, CAST(N'15:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (512, 4, NULL, CAST(N'15:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (513, 4, NULL, CAST(N'16:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (514, 4, NULL, CAST(N'16:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (515, 4, NULL, CAST(N'17:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (516, 4, NULL, CAST(N'17:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (517, 4, NULL, CAST(N'18:00:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (518, 4, NULL, CAST(N'18:30:00' AS Time), 4, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (519, 4, NULL, CAST(N'19:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (520, 4, NULL, CAST(N'19:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (521, 4, NULL, CAST(N'20:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (522, 4, NULL, CAST(N'20:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (523, 4, NULL, CAST(N'21:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (524, 4, NULL, CAST(N'21:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (525, 4, NULL, CAST(N'22:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (526, 4, NULL, CAST(N'22:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (527, 4, NULL, CAST(N'23:00:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (528, 4, NULL, CAST(N'23:30:00' AS Time), 4, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (529, 4, NULL, CAST(N'00:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (530, 4, NULL, CAST(N'00:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (531, 4, NULL, CAST(N'01:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (532, 4, NULL, CAST(N'01:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (533, 4, NULL, CAST(N'02:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (534, 4, NULL, CAST(N'02:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (535, 4, NULL, CAST(N'03:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (536, 4, NULL, CAST(N'03:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (537, 4, NULL, CAST(N'04:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (538, 4, NULL, CAST(N'04:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (539, 4, NULL, CAST(N'05:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (540, 4, NULL, CAST(N'05:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (541, 4, NULL, CAST(N'06:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (542, 4, NULL, CAST(N'06:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (543, 4, NULL, CAST(N'07:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (544, 4, NULL, CAST(N'07:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (545, 4, NULL, CAST(N'08:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (546, 4, NULL, CAST(N'08:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (547, 4, NULL, CAST(N'09:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (548, 4, NULL, CAST(N'09:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (549, 4, NULL, CAST(N'10:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (550, 4, NULL, CAST(N'10:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (551, 4, NULL, CAST(N'11:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (552, 4, NULL, CAST(N'11:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (553, 4, NULL, CAST(N'12:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (554, 4, NULL, CAST(N'12:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (555, 4, NULL, CAST(N'13:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (556, 4, NULL, CAST(N'13:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (557, 4, NULL, CAST(N'14:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (558, 4, NULL, CAST(N'14:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (559, 4, NULL, CAST(N'15:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (560, 4, NULL, CAST(N'15:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (561, 4, NULL, CAST(N'16:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (562, 4, NULL, CAST(N'16:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (563, 4, NULL, CAST(N'17:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (564, 4, NULL, CAST(N'17:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (565, 4, NULL, CAST(N'18:00:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (566, 4, NULL, CAST(N'18:30:00' AS Time), 5, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (567, 4, NULL, CAST(N'19:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (568, 4, NULL, CAST(N'19:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (569, 4, NULL, CAST(N'20:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (570, 4, NULL, CAST(N'20:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (571, 4, NULL, CAST(N'21:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (572, 4, NULL, CAST(N'21:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (573, 4, NULL, CAST(N'22:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (574, 4, NULL, CAST(N'22:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (575, 4, NULL, CAST(N'23:00:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (576, 4, NULL, CAST(N'23:30:00' AS Time), 5, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (577, 4, NULL, CAST(N'00:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (578, 4, NULL, CAST(N'00:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (579, 4, NULL, CAST(N'01:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (580, 4, NULL, CAST(N'01:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (581, 4, NULL, CAST(N'02:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (582, 4, NULL, CAST(N'02:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (583, 4, NULL, CAST(N'03:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (584, 4, NULL, CAST(N'03:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (585, 4, NULL, CAST(N'04:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (586, 4, NULL, CAST(N'04:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (587, 4, NULL, CAST(N'05:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (588, 4, NULL, CAST(N'05:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (589, 4, NULL, CAST(N'06:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (590, 4, NULL, CAST(N'06:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (591, 4, NULL, CAST(N'07:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (592, 4, NULL, CAST(N'07:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (593, 4, NULL, CAST(N'08:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (594, 4, NULL, CAST(N'08:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (595, 4, NULL, CAST(N'09:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (596, 4, NULL, CAST(N'09:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (597, 4, NULL, CAST(N'10:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (598, 4, NULL, CAST(N'10:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (599, 4, NULL, CAST(N'11:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (600, 4, NULL, CAST(N'11:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (601, 4, NULL, CAST(N'12:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (602, 4, NULL, CAST(N'12:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (603, 4, NULL, CAST(N'13:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (604, 4, NULL, CAST(N'13:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (605, 4, NULL, CAST(N'14:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (606, 4, NULL, CAST(N'14:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (607, 4, NULL, CAST(N'15:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (608, 4, NULL, CAST(N'15:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (609, 4, NULL, CAST(N'16:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (610, 4, NULL, CAST(N'16:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (611, 4, NULL, CAST(N'17:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (612, 4, NULL, CAST(N'17:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (613, 4, NULL, CAST(N'18:00:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (614, 4, NULL, CAST(N'18:30:00' AS Time), 6, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (615, 4, NULL, CAST(N'19:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (616, 4, NULL, CAST(N'19:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (617, 4, NULL, CAST(N'20:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (618, 4, NULL, CAST(N'20:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (619, 4, NULL, CAST(N'21:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (620, 4, NULL, CAST(N'21:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (621, 4, NULL, CAST(N'22:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (622, 4, NULL, CAST(N'22:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (623, 4, NULL, CAST(N'23:00:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (624, 4, NULL, CAST(N'23:30:00' AS Time), 6, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (625, 4, NULL, CAST(N'00:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (626, 4, NULL, CAST(N'00:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (627, 4, NULL, CAST(N'01:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (628, 4, NULL, CAST(N'01:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (629, 4, NULL, CAST(N'02:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (630, 4, NULL, CAST(N'02:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (631, 4, NULL, CAST(N'03:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (632, 4, NULL, CAST(N'03:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (633, 4, NULL, CAST(N'04:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (634, 4, NULL, CAST(N'04:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (635, 4, NULL, CAST(N'05:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (636, 4, NULL, CAST(N'05:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (637, 4, NULL, CAST(N'06:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (638, 4, NULL, CAST(N'06:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (639, 4, NULL, CAST(N'07:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (640, 4, NULL, CAST(N'07:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (641, 4, NULL, CAST(N'08:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (642, 4, NULL, CAST(N'08:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (643, 4, NULL, CAST(N'09:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (644, 4, NULL, CAST(N'09:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (645, 4, NULL, CAST(N'10:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (646, 4, NULL, CAST(N'10:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (647, 4, NULL, CAST(N'11:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (648, 4, NULL, CAST(N'11:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (649, 4, NULL, CAST(N'12:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (650, 4, NULL, CAST(N'12:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (651, 4, NULL, CAST(N'13:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (652, 4, NULL, CAST(N'13:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (653, 4, NULL, CAST(N'14:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (654, 4, NULL, CAST(N'14:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (655, 4, NULL, CAST(N'15:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (656, 4, NULL, CAST(N'15:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (657, 4, NULL, CAST(N'16:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (658, 4, NULL, CAST(N'16:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (659, 4, NULL, CAST(N'17:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (660, 4, NULL, CAST(N'17:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (661, 4, NULL, CAST(N'18:00:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (662, 4, NULL, CAST(N'18:30:00' AS Time), 7, NULL, 1)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (663, 4, NULL, CAST(N'19:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (664, 4, NULL, CAST(N'19:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (665, 4, NULL, CAST(N'20:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (666, 4, NULL, CAST(N'20:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (667, 4, NULL, CAST(N'21:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (668, 4, NULL, CAST(N'21:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (669, 4, NULL, CAST(N'22:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (670, 4, NULL, CAST(N'22:30:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (671, 4, NULL, CAST(N'23:00:00' AS Time), 7, NULL, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (672, 4, NULL, CAST(N'23:30:00' AS Time), 7, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[FacilityTime] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [Password], [Phone], [ProfilePicFilename], [Type], [ActiveFlag]) VALUES (1, N'TestFirstName', N'testLastName', N'test@gmail.com', N'pwd', N'3065811492', N'default.jpg', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Facility] FOREIGN KEY([FacilityId])
REFERENCES [dbo].[Facility] ([Id])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Facility]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_User]
GO
ALTER TABLE [dbo].[FacilityTime]  WITH CHECK ADD  CONSTRAINT [FK_FacilityTime_Booking] FOREIGN KEY([BookingId])
REFERENCES [dbo].[Booking] ([Id])
GO
ALTER TABLE [dbo].[FacilityTime] CHECK CONSTRAINT [FK_FacilityTime_Booking]
GO
ALTER TABLE [dbo].[FacilityTime]  WITH CHECK ADD  CONSTRAINT [FK_FacilityTime_Facility] FOREIGN KEY([FacilityId])
REFERENCES [dbo].[Facility] ([Id])
GO
ALTER TABLE [dbo].[FacilityTime] CHECK CONSTRAINT [FK_FacilityTime_Facility]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_User]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Booking] FOREIGN KEY([BookingId])
REFERENCES [dbo].[Booking] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Booking]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Facility] FOREIGN KEY([FacilityId])
REFERENCES [dbo].[Facility] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Facility]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_User]
GO
ALTER TABLE [dbo].[TagAssignment]  WITH CHECK ADD  CONSTRAINT [FK_TagAssignment_Facility] FOREIGN KEY([FacilityId])
REFERENCES [dbo].[Facility] ([Id])
GO
ALTER TABLE [dbo].[TagAssignment] CHECK CONSTRAINT [FK_TagAssignment_Facility]
GO
ALTER TABLE [dbo].[TagAssignment]  WITH CHECK ADD  CONSTRAINT [FK_TagAssignment_TagType] FOREIGN KEY([TagId])
REFERENCES [dbo].[TagType] ([Id])
GO
ALTER TABLE [dbo].[TagAssignment] CHECK CONSTRAINT [FK_TagAssignment_TagType]
GO
USE [master]
GO
ALTER DATABASE [SpaceBook] SET  READ_WRITE 
GO
