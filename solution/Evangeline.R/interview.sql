USE [master]
GO
/****** Object:  Database [Interview]    Script Date: 4/28/2025 7:10:14 PM ******/
CREATE DATABASE [Interview]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Interview', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Interview.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Interview_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Interview_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Interview] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Interview].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Interview] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Interview] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Interview] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Interview] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Interview] SET ARITHABORT OFF 
GO
ALTER DATABASE [Interview] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Interview] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Interview] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Interview] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Interview] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Interview] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Interview] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Interview] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Interview] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Interview] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Interview] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Interview] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Interview] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Interview] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Interview] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Interview] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Interview] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Interview] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Interview] SET  MULTI_USER 
GO
ALTER DATABASE [Interview] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Interview] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Interview] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Interview] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Interview] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Interview] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Interview] SET QUERY_STORE = ON
GO
ALTER DATABASE [Interview] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Interview]
GO
/****** Object:  Schema [Extract]    Script Date: 4/28/2025 7:10:14 PM ******/
CREATE SCHEMA [Extract]
GO
/****** Object:  Schema [OLAP]    Script Date: 4/28/2025 7:10:14 PM ******/
CREATE SCHEMA [OLAP]
GO
/****** Object:  Schema [Staging]    Script Date: 4/28/2025 7:10:14 PM ******/
CREATE SCHEMA [Staging]
GO
/****** Object:  Schema [Transform]    Script Date: 4/28/2025 7:10:14 PM ******/
CREATE SCHEMA [Transform]
GO
/****** Object:  Table [Extract].[Customers]    Script Date: 4/28/2025 7:10:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Extract].[Customers](
	[Index] [int] NULL,
	[CustomerId] [varchar](100) NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[Company] [varchar](255) NULL,
	[Country] [varchar](150) NULL,
	[Phone1] [varchar](100) NULL,
	[Phone2] [varchar](100) NULL,
	[Email] [varchar](255) NULL,
	[SubscriptionDate] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [OLAP].[DimCountry]    Script Date: 4/28/2025 7:10:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OLAP].[DimCountry](
	[CountryKey] [int] IDENTITY(1,1) NOT NULL,
	[CountryCode] [char](2) NOT NULL,
	[CountryName] [varchar](255) NOT NULL,
	[ISO3] [char](3) NOT NULL,
	[CountryNumber] [char](3) NOT NULL,
	[CountryFullName] [varchar](255) NOT NULL,
 CONSTRAINT [PK_DimCountryCode] PRIMARY KEY CLUSTERED 
(
	[CountryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [OLAP].[DimCustomers]    Script Date: 4/28/2025 7:10:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OLAP].[DimCustomers](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
	[Index] [int] NULL,
	[CustomerId] [varchar](100) NULL,
	[CustomerName] [varchar](200) NULL,
	[Company] [varchar](255) NULL,
	[CountryKey] [int] NULL,
	[Phone1] [varchar](100) NULL,
	[Phone2] [varchar](100) NULL,
	[Email] [varchar](255) NULL,
	[EmailDomain] [varchar](100) NULL,
	[SubscriptionDateKey] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Transform].[Customers]    Script Date: 4/28/2025 7:10:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Transform].[Customers](
	[Index] [int] NULL,
	[CustomerId] [varchar](100) NULL,
	[CustomerName] [varchar](200) NULL,
	[Company] [varchar](255) NULL,
	[CountryKey] [int] NULL,
	[Phone1] [varchar](100) NULL,
	[Phone2] [varchar](100) NULL,
	[Email] [varchar](255) NULL,
	[EmailDomain] [varchar](100) NULL,
	[SubscriptionDateKey] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [OLAP].[usp_LoadDimCustomers]    Script Date: 4/28/2025 7:10:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Step C5–C6: Create Load Procedure
CREATE   PROCEDURE [OLAP].[usp_LoadDimCustomers]
AS
BEGIN
    SET NOCOUNT ON;

    MERGE OLAP.DimCustomers AS target
    USING Transform.Customers AS source
    ON target.CustomerId = source.CustomerId
    WHEN MATCHED AND (
        target.CustomerName <> source.CustomerName OR
        target.Company <> source.Company OR
        target.CountryKey <> source.CountryKey OR
        target.Phone1 <> source.Phone1 OR
        target.Phone2 <> source.Phone2 OR
        target.Email <> source.Email OR
        target.EmailDomain <> source.EmailDomain OR
        target.SubscriptionDateKey <> source.SubscriptionDateKey
    )
    THEN UPDATE SET
        target.CustomerName = source.CustomerName,
        target.Company = source.Company,
        target.CountryKey = source.CountryKey,
        target.Phone1 = source.Phone1,
        target.Phone2 = source.Phone2,
        target.Email = source.Email,
        target.EmailDomain = source.EmailDomain,
        target.SubscriptionDateKey = source.SubscriptionDateKey
    WHEN NOT MATCHED BY TARGET THEN
    INSERT ([Index], CustomerId, CustomerName, Company, CountryKey, Phone1, Phone2, Email, EmailDomain, SubscriptionDateKey)
    VALUES ([Index], CustomerId, CustomerName, Company, CountryKey, Phone1, Phone2, Email, EmailDomain, SubscriptionDateKey);
END;
GO
/****** Object:  StoredProcedure [Transform].[usp_TransformCustomers]    Script Date: 4/28/2025 7:10:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Step B1: Create Stored Procedure
CREATE   PROCEDURE [Transform].[usp_TransformCustomers]
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Transform.Customers;

    INSERT INTO Transform.Customers (
        [Index], CustomerId, CustomerName, Company,
        CountryKey, Phone1, Phone2, Email, EmailDomain, SubscriptionDateKey
    )
    SELECT
        ISNULL([Index], -1),
        ISNULL(CustomerId, 'Unknown'),
        CASE 
            WHEN ISNULL(FirstName, '') = '' AND ISNULL(LastName, '') = '' THEN NULL
            ELSE ISNULL(FirstName, 'Unknown') + ' ' + ISNULL(LastName, 'Unknown')
        END,
        ISNULL(Company, 'Unknown'),
        ISNULL(dc.CountryKey, -1),
        CASE WHEN Phone1 LIKE '[0-9(+]%' THEN Phone1 ELSE 'Unknown' END,
        CASE WHEN Phone2 LIKE '[0-9(+]%' THEN Phone2 ELSE 'Unknown' END,
        ISNULL(Email, 'Unknown'),
        CASE WHEN CHARINDEX('@', Email) > 0 THEN RIGHT(Email, LEN(Email) - CHARINDEX('@', Email)) ELSE 'Unknown' END,
        CONVERT(INT, FORMAT(ISNULL(TRY_CAST(SubscriptionDate AS DATE), GETDATE()), 'yyyyMMdd'))
    FROM Extract.Customers ec
    LEFT JOIN OLAP.DimCountry dc ON ec.Country = dc.CountryName
    WHERE NOT (ISNULL(FirstName, '') = '' AND ISNULL(LastName, '') = '');
END;
GO
USE [master]
GO
ALTER DATABASE [Interview] SET  READ_WRITE 
GO
