USE [master]
GO
/****** Object:  Database [SpaceBook]    Script Date: 4/2/2019 8:05:26 AM ******/
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
EXEC sys.sp_db_vardecimal_storage_format N'SpaceBook', N'ON'
GO
ALTER DATABASE [SpaceBook] SET QUERY_STORE = OFF
GO
USE [SpaceBook]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 4/2/2019 8:05:27 AM ******/
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
/****** Object:  Table [dbo].[Facility]    Script Date: 4/2/2019 8:05:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facility](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OwnerId] [int] NULL,
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
/****** Object:  Table [dbo].[FacilityTime]    Script Date: 4/2/2019 8:05:27 AM ******/
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
/****** Object:  Table [dbo].[FacilityType]    Script Date: 4/2/2019 8:05:27 AM ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 4/2/2019 8:05:28 AM ******/
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
/****** Object:  Table [dbo].[NotificationType]    Script Date: 4/2/2019 8:05:28 AM ******/
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
/****** Object:  Table [dbo].[Review]    Script Date: 4/2/2019 8:05:28 AM ******/
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
/****** Object:  Table [dbo].[TagAssignment]    Script Date: 4/2/2019 8:05:28 AM ******/
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
/****** Object:  Table [dbo].[TagType]    Script Date: 4/2/2019 8:05:28 AM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 4/2/2019 8:05:28 AM ******/
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
/****** Object:  Table [dbo].[UserType]    Script Date: 4/2/2019 8:05:28 AM ******/
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

INSERT [dbo].[Booking] ([Id], [UserId], [FacilityId], [StartDateTime], [EndDateTime], [Cost], [Notes], [Cancelled]) VALUES (2, 1, 11, CAST(N'2019-04-03T09:30:00.000' AS DateTime), CAST(N'2019-04-03T10:29:59.000' AS DateTime), 15.0000, NULL, 0)
SET IDENTITY_INSERT [dbo].[Booking] OFF
SET IDENTITY_INSERT [dbo].[Facility] ON 

INSERT [dbo].[Facility] ([Id], [OwnerId], [Name], [Email], [Phone], [Description], [Address], [City], [PostalCode], [Province], [Country], [Type], [StartTime], [EndTime], [HourlyRate], [ActiveFlag]) VALUES (11, 1, N'Goodison', N'wdhary@hotmail.com', N'3065411519', N'a', N'Albert Memorial Bridge Regina', N'rf', N'e', N'SK', N'Canada', 1, NULL, NULL, 75.0000, 1)
INSERT [dbo].[Facility] ([Id], [OwnerId], [Name], [Email], [Phone], [Description], [Address], [City], [PostalCode], [Province], [Country], [Type], [StartTime], [EndTime], [HourlyRate], [ActiveFlag]) VALUES (12, 1, N'Old Trafford', N'OT@gmail.com', N'3065411519', N'q', N'OT Road', N'Manchester', N'S4v2l8', N'London', N'Pakistan', 1, NULL, NULL, 150.0000, 1)
SET IDENTITY_INSERT [dbo].[Facility] OFF
SET IDENTITY_INSERT [dbo].[FacilityTime] ON 

INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2689, 11, NULL, CAST(N'00:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2690, 11, NULL, CAST(N'00:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2691, 11, NULL, CAST(N'01:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2692, 11, NULL, CAST(N'01:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2693, 11, NULL, CAST(N'02:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2694, 11, NULL, CAST(N'02:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2695, 11, NULL, CAST(N'03:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2696, 11, NULL, CAST(N'03:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2697, 11, NULL, CAST(N'04:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2698, 11, NULL, CAST(N'04:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2699, 11, NULL, CAST(N'05:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2700, 11, NULL, CAST(N'05:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2701, 11, NULL, CAST(N'06:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2702, 11, NULL, CAST(N'06:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2703, 11, NULL, CAST(N'07:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2704, 11, NULL, CAST(N'07:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2705, 11, NULL, CAST(N'08:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2706, 11, NULL, CAST(N'08:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2707, 11, NULL, CAST(N'09:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2708, 11, NULL, CAST(N'09:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2709, 11, NULL, CAST(N'10:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2710, 11, NULL, CAST(N'10:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2711, 11, NULL, CAST(N'11:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2712, 11, NULL, CAST(N'11:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2713, 11, NULL, CAST(N'12:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2714, 11, NULL, CAST(N'12:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2715, 11, NULL, CAST(N'13:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2716, 11, NULL, CAST(N'13:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2717, 11, NULL, CAST(N'14:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2718, 11, NULL, CAST(N'14:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2719, 11, NULL, CAST(N'15:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2720, 11, NULL, CAST(N'15:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2721, 11, NULL, CAST(N'16:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2722, 11, NULL, CAST(N'16:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2723, 11, NULL, CAST(N'17:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2724, 11, NULL, CAST(N'17:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2725, 11, NULL, CAST(N'18:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2726, 11, NULL, CAST(N'18:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2727, 11, NULL, CAST(N'19:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2728, 11, NULL, CAST(N'19:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2729, 11, NULL, CAST(N'20:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2730, 11, NULL, CAST(N'20:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2731, 11, NULL, CAST(N'21:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2732, 11, NULL, CAST(N'21:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2733, 11, NULL, CAST(N'22:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2734, 11, NULL, CAST(N'22:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2735, 11, NULL, CAST(N'23:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2736, 11, NULL, CAST(N'23:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2737, 11, NULL, CAST(N'00:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2738, 11, NULL, CAST(N'00:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2739, 11, NULL, CAST(N'01:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2740, 11, NULL, CAST(N'01:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2741, 11, NULL, CAST(N'02:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2742, 11, NULL, CAST(N'02:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2743, 11, NULL, CAST(N'03:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2744, 11, NULL, CAST(N'03:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2745, 11, NULL, CAST(N'04:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2746, 11, NULL, CAST(N'04:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2747, 11, NULL, CAST(N'05:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2748, 11, NULL, CAST(N'05:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2749, 11, NULL, CAST(N'06:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2750, 11, NULL, CAST(N'06:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2751, 11, NULL, CAST(N'07:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2752, 11, NULL, CAST(N'07:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2753, 11, NULL, CAST(N'08:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2754, 11, NULL, CAST(N'08:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2755, 11, NULL, CAST(N'09:00:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2756, 11, NULL, CAST(N'09:30:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2757, 11, NULL, CAST(N'10:00:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2758, 11, NULL, CAST(N'10:30:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2759, 11, NULL, CAST(N'11:00:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2760, 11, NULL, CAST(N'11:30:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2761, 11, NULL, CAST(N'12:00:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2762, 11, NULL, CAST(N'12:30:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2763, 11, NULL, CAST(N'13:00:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2764, 11, NULL, CAST(N'13:30:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2765, 11, NULL, CAST(N'14:00:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2766, 11, NULL, CAST(N'14:30:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2767, 11, NULL, CAST(N'15:00:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2768, 11, NULL, CAST(N'15:30:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2769, 11, NULL, CAST(N'16:00:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2770, 11, NULL, CAST(N'16:30:00' AS Time), 2, 125.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2771, 11, NULL, CAST(N'17:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2772, 11, NULL, CAST(N'17:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2773, 11, NULL, CAST(N'18:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2774, 11, NULL, CAST(N'18:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2775, 11, NULL, CAST(N'19:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2776, 11, NULL, CAST(N'19:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2777, 11, NULL, CAST(N'20:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2778, 11, NULL, CAST(N'20:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2779, 11, NULL, CAST(N'21:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2780, 11, NULL, CAST(N'21:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2781, 11, NULL, CAST(N'22:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2782, 11, NULL, CAST(N'22:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2783, 11, NULL, CAST(N'23:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2784, 11, NULL, CAST(N'23:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2785, 11, NULL, CAST(N'00:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2786, 11, NULL, CAST(N'00:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2787, 11, NULL, CAST(N'01:00:00' AS Time), 3, 0.0000, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2788, 11, NULL, CAST(N'01:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2789, 11, NULL, CAST(N'02:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2790, 11, NULL, CAST(N'02:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2791, 11, NULL, CAST(N'03:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2792, 11, NULL, CAST(N'03:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2793, 11, NULL, CAST(N'04:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2794, 11, NULL, CAST(N'04:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2795, 11, NULL, CAST(N'05:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2796, 11, NULL, CAST(N'05:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2797, 11, NULL, CAST(N'06:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2798, 11, NULL, CAST(N'06:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2799, 11, NULL, CAST(N'07:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2800, 11, NULL, CAST(N'07:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2801, 11, NULL, CAST(N'08:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2802, 11, NULL, CAST(N'08:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2803, 11, NULL, CAST(N'09:00:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2804, 11, NULL, CAST(N'09:30:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2805, 11, NULL, CAST(N'10:00:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2806, 11, NULL, CAST(N'10:30:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2807, 11, NULL, CAST(N'11:00:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2808, 11, NULL, CAST(N'11:30:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2809, 11, NULL, CAST(N'12:00:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2810, 11, NULL, CAST(N'12:30:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2811, 11, NULL, CAST(N'13:00:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2812, 11, NULL, CAST(N'13:30:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2813, 11, NULL, CAST(N'14:00:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2814, 11, NULL, CAST(N'14:30:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2815, 11, NULL, CAST(N'15:00:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2816, 11, NULL, CAST(N'15:30:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2817, 11, NULL, CAST(N'16:00:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2818, 11, NULL, CAST(N'16:30:00' AS Time), 3, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2819, 11, NULL, CAST(N'17:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2820, 11, NULL, CAST(N'17:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2821, 11, NULL, CAST(N'18:00:00' AS Time), 3, 375.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2822, 11, NULL, CAST(N'18:30:00' AS Time), 3, 375.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2823, 11, NULL, CAST(N'19:00:00' AS Time), 3, 375.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2824, 11, NULL, CAST(N'19:30:00' AS Time), 3, 375.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2825, 11, NULL, CAST(N'20:00:00' AS Time), 3, 375.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2826, 11, NULL, CAST(N'20:30:00' AS Time), 3, 375.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2827, 11, NULL, CAST(N'21:00:00' AS Time), 3, 375.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2828, 11, NULL, CAST(N'21:30:00' AS Time), 3, 375.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2829, 11, NULL, CAST(N'22:00:00' AS Time), 3, 375.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2830, 11, NULL, CAST(N'22:30:00' AS Time), 3, 375.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2831, 11, NULL, CAST(N'23:00:00' AS Time), 3, 375.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2832, 11, NULL, CAST(N'23:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2833, 11, NULL, CAST(N'00:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2834, 11, NULL, CAST(N'00:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2835, 11, NULL, CAST(N'01:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2836, 11, NULL, CAST(N'01:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2837, 11, NULL, CAST(N'02:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2838, 11, NULL, CAST(N'02:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2839, 11, NULL, CAST(N'03:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2840, 11, NULL, CAST(N'03:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2841, 11, NULL, CAST(N'04:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2842, 11, NULL, CAST(N'04:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2843, 11, NULL, CAST(N'05:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2844, 11, NULL, CAST(N'05:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2845, 11, NULL, CAST(N'06:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2846, 11, NULL, CAST(N'06:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2847, 11, NULL, CAST(N'07:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2848, 11, NULL, CAST(N'07:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2849, 11, NULL, CAST(N'08:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2850, 11, NULL, CAST(N'08:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2851, 11, NULL, CAST(N'09:00:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2852, 11, NULL, CAST(N'09:30:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2853, 11, NULL, CAST(N'10:00:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2854, 11, NULL, CAST(N'10:30:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2855, 11, NULL, CAST(N'11:00:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2856, 11, NULL, CAST(N'11:30:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2857, 11, NULL, CAST(N'12:00:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2858, 11, NULL, CAST(N'12:30:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2859, 11, NULL, CAST(N'13:00:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2860, 11, NULL, CAST(N'13:30:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2861, 11, NULL, CAST(N'14:00:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2862, 11, NULL, CAST(N'14:30:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2863, 11, NULL, CAST(N'15:00:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2864, 11, NULL, CAST(N'15:30:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2865, 11, NULL, CAST(N'16:00:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2866, 11, NULL, CAST(N'16:30:00' AS Time), 4, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2867, 11, NULL, CAST(N'17:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2868, 11, NULL, CAST(N'17:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2869, 11, NULL, CAST(N'18:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2870, 11, NULL, CAST(N'18:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2871, 11, NULL, CAST(N'19:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2872, 11, NULL, CAST(N'19:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2873, 11, NULL, CAST(N'20:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2874, 11, NULL, CAST(N'20:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2875, 11, NULL, CAST(N'21:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2876, 11, NULL, CAST(N'21:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2877, 11, NULL, CAST(N'22:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2878, 11, NULL, CAST(N'22:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2879, 11, NULL, CAST(N'23:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2880, 11, NULL, CAST(N'23:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2881, 11, NULL, CAST(N'00:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2882, 11, NULL, CAST(N'00:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2883, 11, NULL, CAST(N'01:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2884, 11, NULL, CAST(N'01:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2885, 11, NULL, CAST(N'02:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2886, 11, NULL, CAST(N'02:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2887, 11, NULL, CAST(N'03:00:00' AS Time), 5, 0.0000, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2888, 11, NULL, CAST(N'03:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2889, 11, NULL, CAST(N'04:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2890, 11, NULL, CAST(N'04:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2891, 11, NULL, CAST(N'05:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2892, 11, NULL, CAST(N'05:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2893, 11, NULL, CAST(N'06:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2894, 11, NULL, CAST(N'06:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2895, 11, NULL, CAST(N'07:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2896, 11, NULL, CAST(N'07:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2897, 11, NULL, CAST(N'08:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2898, 11, NULL, CAST(N'08:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2899, 11, NULL, CAST(N'09:00:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2900, 11, NULL, CAST(N'09:30:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2901, 11, NULL, CAST(N'10:00:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2902, 11, NULL, CAST(N'10:30:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2903, 11, NULL, CAST(N'11:00:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2904, 11, NULL, CAST(N'11:30:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2905, 11, NULL, CAST(N'12:00:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2906, 11, NULL, CAST(N'12:30:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2907, 11, NULL, CAST(N'13:00:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2908, 11, NULL, CAST(N'13:30:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2909, 11, NULL, CAST(N'14:00:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2910, 11, NULL, CAST(N'14:30:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2911, 11, NULL, CAST(N'15:00:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2912, 11, NULL, CAST(N'15:30:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2913, 11, NULL, CAST(N'16:00:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2914, 11, NULL, CAST(N'16:30:00' AS Time), 5, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2915, 11, NULL, CAST(N'17:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2916, 11, NULL, CAST(N'17:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2917, 11, NULL, CAST(N'18:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2918, 11, NULL, CAST(N'18:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2919, 11, NULL, CAST(N'19:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2920, 11, NULL, CAST(N'19:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2921, 11, NULL, CAST(N'20:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2922, 11, NULL, CAST(N'20:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2923, 11, NULL, CAST(N'21:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2924, 11, NULL, CAST(N'21:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2925, 11, NULL, CAST(N'22:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2926, 11, NULL, CAST(N'22:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2927, 11, NULL, CAST(N'23:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2928, 11, NULL, CAST(N'23:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2929, 11, NULL, CAST(N'00:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2930, 11, NULL, CAST(N'00:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2931, 11, NULL, CAST(N'01:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2932, 11, NULL, CAST(N'01:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2933, 11, NULL, CAST(N'02:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2934, 11, NULL, CAST(N'02:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2935, 11, NULL, CAST(N'03:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2936, 11, NULL, CAST(N'03:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2937, 11, NULL, CAST(N'04:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2938, 11, NULL, CAST(N'04:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2939, 11, NULL, CAST(N'05:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2940, 11, NULL, CAST(N'05:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2941, 11, NULL, CAST(N'06:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2942, 11, NULL, CAST(N'06:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2943, 11, NULL, CAST(N'07:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2944, 11, NULL, CAST(N'07:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2945, 11, NULL, CAST(N'08:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2946, 11, NULL, CAST(N'08:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2947, 11, NULL, CAST(N'09:00:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2948, 11, NULL, CAST(N'09:30:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2949, 11, NULL, CAST(N'10:00:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2950, 11, NULL, CAST(N'10:30:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2951, 11, NULL, CAST(N'11:00:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2952, 11, NULL, CAST(N'11:30:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2953, 11, NULL, CAST(N'12:00:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2954, 11, NULL, CAST(N'12:30:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2955, 11, NULL, CAST(N'13:00:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2956, 11, NULL, CAST(N'13:30:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2957, 11, NULL, CAST(N'14:00:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2958, 11, NULL, CAST(N'14:30:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2959, 11, NULL, CAST(N'15:00:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2960, 11, NULL, CAST(N'15:30:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2961, 11, NULL, CAST(N'16:00:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2962, 11, NULL, CAST(N'16:30:00' AS Time), 6, 37.5000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2963, 11, NULL, CAST(N'17:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2964, 11, NULL, CAST(N'17:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2965, 11, NULL, CAST(N'18:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2966, 11, NULL, CAST(N'18:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2967, 11, NULL, CAST(N'19:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2968, 11, NULL, CAST(N'19:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2969, 11, NULL, CAST(N'20:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2970, 11, NULL, CAST(N'20:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2971, 11, NULL, CAST(N'21:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2972, 11, NULL, CAST(N'21:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2973, 11, NULL, CAST(N'22:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2974, 11, NULL, CAST(N'22:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2975, 11, NULL, CAST(N'23:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2976, 11, NULL, CAST(N'23:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2977, 11, NULL, CAST(N'00:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2978, 11, NULL, CAST(N'00:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2979, 11, NULL, CAST(N'01:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2980, 11, NULL, CAST(N'01:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2981, 11, NULL, CAST(N'02:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2982, 11, NULL, CAST(N'02:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2983, 11, NULL, CAST(N'03:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2984, 11, NULL, CAST(N'03:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2985, 11, NULL, CAST(N'04:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2986, 11, NULL, CAST(N'04:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2987, 11, NULL, CAST(N'05:00:00' AS Time), 7, 0.0000, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2988, 11, NULL, CAST(N'05:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2989, 11, NULL, CAST(N'06:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2990, 11, NULL, CAST(N'06:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2991, 11, NULL, CAST(N'07:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2992, 11, NULL, CAST(N'07:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2993, 11, NULL, CAST(N'08:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2994, 11, NULL, CAST(N'08:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2995, 11, NULL, CAST(N'09:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2996, 11, NULL, CAST(N'09:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2997, 11, NULL, CAST(N'10:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2998, 11, NULL, CAST(N'10:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (2999, 11, NULL, CAST(N'11:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3000, 11, NULL, CAST(N'11:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3001, 11, NULL, CAST(N'12:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3002, 11, NULL, CAST(N'12:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3003, 11, NULL, CAST(N'13:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3004, 11, NULL, CAST(N'13:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3005, 11, NULL, CAST(N'14:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3006, 11, NULL, CAST(N'14:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3007, 11, NULL, CAST(N'15:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3008, 11, NULL, CAST(N'15:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3009, 11, NULL, CAST(N'16:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3010, 11, NULL, CAST(N'16:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3011, 11, NULL, CAST(N'17:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3012, 11, NULL, CAST(N'17:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3013, 11, NULL, CAST(N'18:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3014, 11, NULL, CAST(N'18:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3015, 11, NULL, CAST(N'19:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3016, 11, NULL, CAST(N'19:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3017, 11, NULL, CAST(N'20:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3018, 11, NULL, CAST(N'20:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3019, 11, NULL, CAST(N'21:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3020, 11, NULL, CAST(N'21:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3021, 11, NULL, CAST(N'22:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3022, 11, NULL, CAST(N'22:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3023, 11, NULL, CAST(N'23:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3024, 11, NULL, CAST(N'23:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3025, 12, NULL, CAST(N'00:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3026, 12, NULL, CAST(N'00:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3027, 12, NULL, CAST(N'01:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3028, 12, NULL, CAST(N'01:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3029, 12, NULL, CAST(N'02:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3030, 12, NULL, CAST(N'02:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3031, 12, NULL, CAST(N'03:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3032, 12, NULL, CAST(N'03:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3033, 12, NULL, CAST(N'04:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3034, 12, NULL, CAST(N'04:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3035, 12, NULL, CAST(N'05:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3036, 12, NULL, CAST(N'05:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3037, 12, NULL, CAST(N'06:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3038, 12, NULL, CAST(N'06:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3039, 12, NULL, CAST(N'07:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3040, 12, NULL, CAST(N'07:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3041, 12, NULL, CAST(N'08:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3042, 12, NULL, CAST(N'08:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3043, 12, NULL, CAST(N'09:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3044, 12, NULL, CAST(N'09:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3045, 12, NULL, CAST(N'10:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3046, 12, NULL, CAST(N'10:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3047, 12, NULL, CAST(N'11:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3048, 12, NULL, CAST(N'11:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3049, 12, NULL, CAST(N'12:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3050, 12, NULL, CAST(N'12:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3051, 12, NULL, CAST(N'13:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3052, 12, NULL, CAST(N'13:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3053, 12, NULL, CAST(N'14:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3054, 12, NULL, CAST(N'14:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3055, 12, NULL, CAST(N'15:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3056, 12, NULL, CAST(N'15:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3057, 12, NULL, CAST(N'16:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3058, 12, NULL, CAST(N'16:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3059, 12, NULL, CAST(N'17:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3060, 12, NULL, CAST(N'17:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3061, 12, NULL, CAST(N'18:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3062, 12, NULL, CAST(N'18:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3063, 12, NULL, CAST(N'19:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3064, 12, NULL, CAST(N'19:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3065, 12, NULL, CAST(N'20:00:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3066, 12, NULL, CAST(N'20:30:00' AS Time), 1, 250.0000, 1)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3067, 12, NULL, CAST(N'21:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3068, 12, NULL, CAST(N'21:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3069, 12, NULL, CAST(N'22:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3070, 12, NULL, CAST(N'22:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3071, 12, NULL, CAST(N'23:00:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3072, 12, NULL, CAST(N'23:30:00' AS Time), 1, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3073, 12, NULL, CAST(N'00:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3074, 12, NULL, CAST(N'00:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3075, 12, NULL, CAST(N'01:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3076, 12, NULL, CAST(N'01:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3077, 12, NULL, CAST(N'02:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3078, 12, NULL, CAST(N'02:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3079, 12, NULL, CAST(N'03:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3080, 12, NULL, CAST(N'03:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3081, 12, NULL, CAST(N'04:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3082, 12, NULL, CAST(N'04:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3083, 12, NULL, CAST(N'05:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3084, 12, NULL, CAST(N'05:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3085, 12, NULL, CAST(N'06:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3086, 12, NULL, CAST(N'06:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3087, 12, NULL, CAST(N'07:00:00' AS Time), 2, 0.0000, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3088, 12, NULL, CAST(N'07:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3089, 12, NULL, CAST(N'08:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3090, 12, NULL, CAST(N'08:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3091, 12, NULL, CAST(N'09:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3092, 12, NULL, CAST(N'09:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3093, 12, NULL, CAST(N'10:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3094, 12, NULL, CAST(N'10:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3095, 12, NULL, CAST(N'11:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3096, 12, NULL, CAST(N'11:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3097, 12, NULL, CAST(N'12:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3098, 12, NULL, CAST(N'12:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3099, 12, NULL, CAST(N'13:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3100, 12, NULL, CAST(N'13:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3101, 12, NULL, CAST(N'14:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3102, 12, NULL, CAST(N'14:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3103, 12, NULL, CAST(N'15:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3104, 12, NULL, CAST(N'15:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3105, 12, NULL, CAST(N'16:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3106, 12, NULL, CAST(N'16:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3107, 12, NULL, CAST(N'17:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3108, 12, NULL, CAST(N'17:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3109, 12, NULL, CAST(N'18:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3110, 12, NULL, CAST(N'18:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3111, 12, NULL, CAST(N'19:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3112, 12, NULL, CAST(N'19:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3113, 12, NULL, CAST(N'20:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3114, 12, NULL, CAST(N'20:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3115, 12, NULL, CAST(N'21:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3116, 12, NULL, CAST(N'21:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3117, 12, NULL, CAST(N'22:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3118, 12, NULL, CAST(N'22:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3119, 12, NULL, CAST(N'23:00:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3120, 12, NULL, CAST(N'23:30:00' AS Time), 2, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3121, 12, NULL, CAST(N'00:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3122, 12, NULL, CAST(N'00:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3123, 12, NULL, CAST(N'01:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3124, 12, NULL, CAST(N'01:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3125, 12, NULL, CAST(N'02:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3126, 12, NULL, CAST(N'02:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3127, 12, NULL, CAST(N'03:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3128, 12, NULL, CAST(N'03:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3129, 12, NULL, CAST(N'04:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3130, 12, NULL, CAST(N'04:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3131, 12, NULL, CAST(N'05:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3132, 12, NULL, CAST(N'05:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3133, 12, NULL, CAST(N'06:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3134, 12, NULL, CAST(N'06:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3135, 12, NULL, CAST(N'07:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3136, 12, NULL, CAST(N'07:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3137, 12, NULL, CAST(N'08:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3138, 12, NULL, CAST(N'08:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3139, 12, NULL, CAST(N'09:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3140, 12, NULL, CAST(N'09:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3141, 12, NULL, CAST(N'10:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3142, 12, NULL, CAST(N'10:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3143, 12, NULL, CAST(N'11:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3144, 12, NULL, CAST(N'11:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3145, 12, NULL, CAST(N'12:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3146, 12, NULL, CAST(N'12:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3147, 12, NULL, CAST(N'13:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3148, 12, NULL, CAST(N'13:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3149, 12, NULL, CAST(N'14:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3150, 12, NULL, CAST(N'14:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3151, 12, NULL, CAST(N'15:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3152, 12, NULL, CAST(N'15:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3153, 12, NULL, CAST(N'16:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3154, 12, NULL, CAST(N'16:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3155, 12, NULL, CAST(N'17:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3156, 12, NULL, CAST(N'17:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3157, 12, NULL, CAST(N'18:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3158, 12, NULL, CAST(N'18:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3159, 12, NULL, CAST(N'19:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3160, 12, NULL, CAST(N'19:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3161, 12, NULL, CAST(N'20:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3162, 12, NULL, CAST(N'20:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3163, 12, NULL, CAST(N'21:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3164, 12, NULL, CAST(N'21:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3165, 12, NULL, CAST(N'22:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3166, 12, NULL, CAST(N'22:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3167, 12, NULL, CAST(N'23:00:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3168, 12, NULL, CAST(N'23:30:00' AS Time), 3, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3169, 12, NULL, CAST(N'00:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3170, 12, NULL, CAST(N'00:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3171, 12, NULL, CAST(N'01:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3172, 12, NULL, CAST(N'01:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3173, 12, NULL, CAST(N'02:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3174, 12, NULL, CAST(N'02:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3175, 12, NULL, CAST(N'03:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3176, 12, NULL, CAST(N'03:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3177, 12, NULL, CAST(N'04:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3178, 12, NULL, CAST(N'04:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3179, 12, NULL, CAST(N'05:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3180, 12, NULL, CAST(N'05:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3181, 12, NULL, CAST(N'06:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3182, 12, NULL, CAST(N'06:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3183, 12, NULL, CAST(N'07:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3184, 12, NULL, CAST(N'07:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3185, 12, NULL, CAST(N'08:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3186, 12, NULL, CAST(N'08:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3187, 12, NULL, CAST(N'09:00:00' AS Time), 4, 0.0000, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3188, 12, NULL, CAST(N'09:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3189, 12, NULL, CAST(N'10:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3190, 12, NULL, CAST(N'10:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3191, 12, NULL, CAST(N'11:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3192, 12, NULL, CAST(N'11:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3193, 12, NULL, CAST(N'12:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3194, 12, NULL, CAST(N'12:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3195, 12, NULL, CAST(N'13:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3196, 12, NULL, CAST(N'13:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3197, 12, NULL, CAST(N'14:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3198, 12, NULL, CAST(N'14:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3199, 12, NULL, CAST(N'15:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3200, 12, NULL, CAST(N'15:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3201, 12, NULL, CAST(N'16:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3202, 12, NULL, CAST(N'16:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3203, 12, NULL, CAST(N'17:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3204, 12, NULL, CAST(N'17:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3205, 12, NULL, CAST(N'18:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3206, 12, NULL, CAST(N'18:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3207, 12, NULL, CAST(N'19:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3208, 12, NULL, CAST(N'19:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3209, 12, NULL, CAST(N'20:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3210, 12, NULL, CAST(N'20:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3211, 12, NULL, CAST(N'21:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3212, 12, NULL, CAST(N'21:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3213, 12, NULL, CAST(N'22:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3214, 12, NULL, CAST(N'22:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3215, 12, NULL, CAST(N'23:00:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3216, 12, NULL, CAST(N'23:30:00' AS Time), 4, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3217, 12, NULL, CAST(N'00:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3218, 12, NULL, CAST(N'00:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3219, 12, NULL, CAST(N'01:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3220, 12, NULL, CAST(N'01:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3221, 12, NULL, CAST(N'02:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3222, 12, NULL, CAST(N'02:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3223, 12, NULL, CAST(N'03:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3224, 12, NULL, CAST(N'03:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3225, 12, NULL, CAST(N'04:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3226, 12, NULL, CAST(N'04:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3227, 12, NULL, CAST(N'05:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3228, 12, NULL, CAST(N'05:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3229, 12, NULL, CAST(N'06:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3230, 12, NULL, CAST(N'06:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3231, 12, NULL, CAST(N'07:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3232, 12, NULL, CAST(N'07:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3233, 12, NULL, CAST(N'08:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3234, 12, NULL, CAST(N'08:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3235, 12, NULL, CAST(N'09:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3236, 12, NULL, CAST(N'09:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3237, 12, NULL, CAST(N'10:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3238, 12, NULL, CAST(N'10:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3239, 12, NULL, CAST(N'11:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3240, 12, NULL, CAST(N'11:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3241, 12, NULL, CAST(N'12:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3242, 12, NULL, CAST(N'12:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3243, 12, NULL, CAST(N'13:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3244, 12, NULL, CAST(N'13:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3245, 12, NULL, CAST(N'14:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3246, 12, NULL, CAST(N'14:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3247, 12, NULL, CAST(N'15:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3248, 12, NULL, CAST(N'15:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3249, 12, NULL, CAST(N'16:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3250, 12, NULL, CAST(N'16:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3251, 12, NULL, CAST(N'17:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3252, 12, NULL, CAST(N'17:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3253, 12, NULL, CAST(N'18:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3254, 12, NULL, CAST(N'18:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3255, 12, NULL, CAST(N'19:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3256, 12, NULL, CAST(N'19:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3257, 12, NULL, CAST(N'20:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3258, 12, NULL, CAST(N'20:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3259, 12, NULL, CAST(N'21:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3260, 12, NULL, CAST(N'21:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3261, 12, NULL, CAST(N'22:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3262, 12, NULL, CAST(N'22:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3263, 12, NULL, CAST(N'23:00:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3264, 12, NULL, CAST(N'23:30:00' AS Time), 5, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3265, 12, NULL, CAST(N'00:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3266, 12, NULL, CAST(N'00:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3267, 12, NULL, CAST(N'01:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3268, 12, NULL, CAST(N'01:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3269, 12, NULL, CAST(N'02:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3270, 12, NULL, CAST(N'02:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3271, 12, NULL, CAST(N'03:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3272, 12, NULL, CAST(N'03:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3273, 12, NULL, CAST(N'04:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3274, 12, NULL, CAST(N'04:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3275, 12, NULL, CAST(N'05:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3276, 12, NULL, CAST(N'05:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3277, 12, NULL, CAST(N'06:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3278, 12, NULL, CAST(N'06:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3279, 12, NULL, CAST(N'07:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3280, 12, NULL, CAST(N'07:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3281, 12, NULL, CAST(N'08:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3282, 12, NULL, CAST(N'08:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3283, 12, NULL, CAST(N'09:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3284, 12, NULL, CAST(N'09:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3285, 12, NULL, CAST(N'10:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3286, 12, NULL, CAST(N'10:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3287, 12, NULL, CAST(N'11:00:00' AS Time), 6, 0.0000, 0)
GO
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3288, 12, NULL, CAST(N'11:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3289, 12, NULL, CAST(N'12:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3290, 12, NULL, CAST(N'12:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3291, 12, NULL, CAST(N'13:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3292, 12, NULL, CAST(N'13:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3293, 12, NULL, CAST(N'14:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3294, 12, NULL, CAST(N'14:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3295, 12, NULL, CAST(N'15:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3296, 12, NULL, CAST(N'15:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3297, 12, NULL, CAST(N'16:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3298, 12, NULL, CAST(N'16:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3299, 12, NULL, CAST(N'17:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3300, 12, NULL, CAST(N'17:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3301, 12, NULL, CAST(N'18:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3302, 12, NULL, CAST(N'18:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3303, 12, NULL, CAST(N'19:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3304, 12, NULL, CAST(N'19:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3305, 12, NULL, CAST(N'20:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3306, 12, NULL, CAST(N'20:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3307, 12, NULL, CAST(N'21:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3308, 12, NULL, CAST(N'21:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3309, 12, NULL, CAST(N'22:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3310, 12, NULL, CAST(N'22:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3311, 12, NULL, CAST(N'23:00:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3312, 12, NULL, CAST(N'23:30:00' AS Time), 6, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3313, 12, NULL, CAST(N'00:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3314, 12, NULL, CAST(N'00:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3315, 12, NULL, CAST(N'01:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3316, 12, NULL, CAST(N'01:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3317, 12, NULL, CAST(N'02:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3318, 12, NULL, CAST(N'02:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3319, 12, NULL, CAST(N'03:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3320, 12, NULL, CAST(N'03:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3321, 12, NULL, CAST(N'04:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3322, 12, NULL, CAST(N'04:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3323, 12, NULL, CAST(N'05:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3324, 12, NULL, CAST(N'05:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3325, 12, NULL, CAST(N'06:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3326, 12, NULL, CAST(N'06:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3327, 12, NULL, CAST(N'07:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3328, 12, NULL, CAST(N'07:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3329, 12, NULL, CAST(N'08:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3330, 12, NULL, CAST(N'08:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3331, 12, NULL, CAST(N'09:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3332, 12, NULL, CAST(N'09:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3333, 12, NULL, CAST(N'10:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3334, 12, NULL, CAST(N'10:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3335, 12, NULL, CAST(N'11:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3336, 12, NULL, CAST(N'11:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3337, 12, NULL, CAST(N'12:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3338, 12, NULL, CAST(N'12:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3339, 12, NULL, CAST(N'13:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3340, 12, NULL, CAST(N'13:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3341, 12, NULL, CAST(N'14:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3342, 12, NULL, CAST(N'14:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3343, 12, NULL, CAST(N'15:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3344, 12, NULL, CAST(N'15:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3345, 12, NULL, CAST(N'16:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3346, 12, NULL, CAST(N'16:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3347, 12, NULL, CAST(N'17:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3348, 12, NULL, CAST(N'17:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3349, 12, NULL, CAST(N'18:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3350, 12, NULL, CAST(N'18:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3351, 12, NULL, CAST(N'19:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3352, 12, NULL, CAST(N'19:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3353, 12, NULL, CAST(N'20:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3354, 12, NULL, CAST(N'20:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3355, 12, NULL, CAST(N'21:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3356, 12, NULL, CAST(N'21:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3357, 12, NULL, CAST(N'22:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3358, 12, NULL, CAST(N'22:30:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3359, 12, NULL, CAST(N'23:00:00' AS Time), 7, 0.0000, 0)
INSERT [dbo].[FacilityTime] ([Id], [FacilityId], [BookingId], [StartTime], [Day], [Rate], [IsAvailable]) VALUES (3360, 12, NULL, CAST(N'23:30:00' AS Time), 7, 0.0000, 0)
SET IDENTITY_INSERT [dbo].[FacilityTime] OFF
SET IDENTITY_INSERT [dbo].[TagAssignment] ON 

INSERT [dbo].[TagAssignment] ([Id], [TagId], [FacilityId]) VALUES (9, 2, 11)
INSERT [dbo].[TagAssignment] ([Id], [TagId], [FacilityId]) VALUES (10, 3, 11)
INSERT [dbo].[TagAssignment] ([Id], [TagId], [FacilityId]) VALUES (11, 2, 12)
INSERT [dbo].[TagAssignment] ([Id], [TagId], [FacilityId]) VALUES (12, 3, 12)
SET IDENTITY_INSERT [dbo].[TagAssignment] OFF
SET IDENTITY_INSERT [dbo].[TagType] ON 

INSERT [dbo].[TagType] ([Id], [Name]) VALUES (1, N'Indoor')
INSERT [dbo].[TagType] ([Id], [Name]) VALUES (2, N'Outoor')
INSERT [dbo].[TagType] ([Id], [Name]) VALUES (3, N'Soccer')
INSERT [dbo].[TagType] ([Id], [Name]) VALUES (4, N'Football')
INSERT [dbo].[TagType] ([Id], [Name]) VALUES (5, N'Basketball')
INSERT [dbo].[TagType] ([Id], [Name]) VALUES (6, N'Hockey')
INSERT [dbo].[TagType] ([Id], [Name]) VALUES (7, N'Baseball')
INSERT [dbo].[TagType] ([Id], [Name]) VALUES (8, N'Improv')
SET IDENTITY_INSERT [dbo].[TagType] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [Password], [Phone], [ProfilePicFilename], [Type], [ActiveFlag]) VALUES (1, N'TestFirstName', N'testLastName', N'owner', N'pwd', N'3065811492', N'default.jpg', 1, 1)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [Password], [Phone], [ProfilePicFilename], [Type], [ActiveFlag]) VALUES (2, N't', N'a', N'test', N'pwd', N'3065481419', N'', 1, 1)
INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [Password], [Phone], [ProfilePicFilename], [Type], [ActiveFlag]) VALUES (3, N't', N'a', N'secondOwn', N'pwd', N'3065481419', N'', 1, 1)
SET IDENTITY_INSERT [dbo].[User] OFF

SET IDENTITY_INSERT [dbo].[NotificationType] ON 
INSERT [dbo].[NotificationType]([Id], [Name]) VALUES (1, N'facilityOwner_VenueBooked');
INSERT [dbo].[NotificationType]([Id], [Name]) VALUES (2, N'facilityOwner_UserCancelledBooking');
INSERT [dbo].[NotificationType]([Id], [Name]) VALUES (3, N'facilityOwner_UserMessageReceived');
INSERT [dbo].[NotificationType]([Id], [Name]) VALUES (4, N'user_FacilityOwnerMessageReceived');
INSERT [dbo].[NotificationType]([Id], [Name]) VALUES (5, N'user_FacilityOwnerCancelledBooking');
INSERT [dbo].[NotificationType]([Id], [Name]) VALUES (6, N'facilityOwner_ReviewReceived');
SET IDENTITY_INSERT [dbo].[NotificationType] OFF 

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
ALTER TABLE [dbo].[Facility]  WITH CHECK ADD  CONSTRAINT [FK_Facility_User] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Facility] CHECK CONSTRAINT [FK_Facility_User]
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
