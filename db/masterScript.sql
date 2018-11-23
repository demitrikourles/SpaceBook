USE [master]
GO
/****** Object:  Database [SpaceBook]    Script Date: 11/22/2018 9:05:12 PM ******/
CREATE DATABASE [SpaceBook]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SpaceBook', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\SpaceBook.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SpaceBook_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\SpaceBook_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
ALTER DATABASE [SpaceBook] SET RECOVERY FULL 
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
/****** Object:  Table [dbo].[Booking]    Script Date: 11/22/2018 9:05:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[facilityId] [int] NOT NULL,
	[startDateTime] [time](7) NULL,
	[endDateTime] [time](7) NULL,
	[cost] [float] NULL,
	[notes] [varchar](max) NULL,
	[cancelled] [bit] NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facility]    Script Date: 11/22/2018 9:05:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facility](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](max) NOT NULL,
	[description] [varchar](max) NULL,
	[address] [varchar](max) NULL,
	[type] [varchar](max) NULL,
	[openTime] [time](7) NULL,
	[closeTime] [time](7) NULL,
	[hourlyRate] [float] NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_Facility] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 11/22/2018 9:05:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](max) NULL,
	[userId] [int] NOT NULL,
	[message] [varchar](max) NULL,
	[dateTime] [datetime] NULL,
	[isRead] [varchar](max) NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 11/22/2018 9:05:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[facilityId] [int] NOT NULL,
	[rating] [int] NULL,
	[comment] [int] NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 11/22/2018 9:05:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](max) NOT NULL,
	[email] [varchar](max) NULL,
	[phone] [int] NULL,
	[type] [varchar](max) NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Facility] FOREIGN KEY([facilityId])
REFERENCES [dbo].[Facility] ([id])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Facility]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_User]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_User]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Facility] FOREIGN KEY([facilityId])
REFERENCES [dbo].[Facility] ([id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Facility]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_User]
GO
USE [master]
GO
ALTER DATABASE [SpaceBook] SET  READ_WRITE 
GO
