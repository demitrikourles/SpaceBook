USE [master]
GO
/****** Object:  Database [SpaceBook]    Script Date: 2/11/2019 11:50:42 PM ******/
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
/****** Object:  Table [dbo].[Booking]    Script Date: 2/11/2019 11:50:42 PM ******/
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
/****** Object:  Table [dbo].[Facility]    Script Date: 2/11/2019 11:50:42 PM ******/
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
/****** Object:  Table [dbo].[FacilityTime]    Script Date: 2/11/2019 11:50:42 PM ******/
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
/****** Object:  Table [dbo].[FacilityType]    Script Date: 2/11/2019 11:50:42 PM ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 2/11/2019 11:50:42 PM ******/
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
/****** Object:  Table [dbo].[NotificationType]    Script Date: 2/11/2019 11:50:42 PM ******/
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
/****** Object:  Table [dbo].[Review]    Script Date: 2/11/2019 11:50:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[FacilityId] [int] NOT NULL,
	[Rating] [int] NULL,
	[Comment] [varchar](max) NULL,
	[ActiveFlag] [bit] NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TagAssignment]    Script Date: 2/11/2019 11:50:42 PM ******/
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
/****** Object:  Table [dbo].[TagType]    Script Date: 2/11/2019 11:50:42 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 2/11/2019 11:50:43 PM ******/
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
/****** Object:  Table [dbo].[UserType]    Script Date: 2/11/2019 11:50:43 PM ******/
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

SET IDENTITY_INSERT [dbo].[Facility] ON 

INSERT [dbo].[Facility] ([Id], [Name], [Email], [Phone], [Description], [Address], [City], [PostalCode], [Province], [Country], [Type], [StartTime], [EndTime], [HourlyRate], [ActiveFlag]) VALUES (1, N'The Field', N'test@gmail.com', N'3065781249', N'This is the description of the field', N'2094 Wascana Meadows', N'Regina', N'S4V4K8', N'Saskatchewan', N'Canada', 1, CAST(N'08:00:00' AS Time), CAST(N'17:00:00' AS Time), 75.0000, 1)
INSERT [dbo].[Facility] ([Id], [Name], [Email], [Phone], [Description], [Address], [City], [PostalCode], [Province], [Country], [Type], [StartTime], [EndTime], [HourlyRate], [ActiveFlag]) VALUES (2, N'Second Test Field', N'secondtest@gmail.com', N'3065471843', N'This is the description of the second field', N'2094 Wascana Meadows', N'Regina', N'S4V4K8', N'Saskatchewan', N'Canada', 1, CAST(N'07:00:00' AS Time), CAST(N'20:00:00' AS Time), 50.0000, 1)
SET IDENTITY_INSERT [dbo].[Facility] OFF

SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Email], [Password], [Phone], [ProfilePicFilename], [Type], [ActiveFlag]) VALUES (1, N'TestFirstName', N'testLastName', N'test@gmail.com', N'pwd', N'3065811492', N'default.jpg', 1, 1)
SET IDENTITY_INSERT [dbo].[User] OFF

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
ALTER TABLE [dbo].[TagAssignment]  WITH CHECK ADD  CONSTRAINT [FK_TagAssignment_FacilityType] FOREIGN KEY([FacilityId])
REFERENCES [dbo].[FacilityType] ([Id])
GO
ALTER TABLE [dbo].[TagAssignment] CHECK CONSTRAINT [FK_TagAssignment_FacilityType]
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
