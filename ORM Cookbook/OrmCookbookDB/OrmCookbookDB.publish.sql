﻿/*
Deployment script for OrmCookbook

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "OrmCookbook"
:setvar DefaultFilePrefix "OrmCookbook"
:setvar DefaultDataPath "D:\ProgramData\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "D:\ProgramData\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
GO

GO
PRINT N'Dropping Permission...';


GO
REVOKE VIEW ANY COLUMN ENCRYPTION KEY DEFINITION TO PUBLIC CASCADE;


GO
PRINT N'Dropping Permission...';


GO
REVOKE VIEW ANY COLUMN MASTER KEY DEFINITION TO PUBLIC CASCADE;


GO
PRINT N'Creating [HR]...';


GO
CREATE SCHEMA [HR]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [Production]...';


GO
CREATE SCHEMA [Production]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [Sales]...';


GO
CREATE SCHEMA [Sales]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [HR].[Department]...';


GO
CREATE TABLE [HR].[Department] (
    [DepartmentKey]  INT           IDENTITY (1000, 1) NOT NULL,
    [DepartmentName] NVARCHAR (30) NOT NULL,
    [DivisionKey]    INT           NOT NULL,
    CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([DepartmentKey] ASC),
    CONSTRAINT [UX_Department_DepartmentName] UNIQUE NONCLUSTERED ([DepartmentName] ASC)
);


GO
PRINT N'Creating [HR].[Division]...';


GO
CREATE TABLE [HR].[Division] (
    [DivisionKey]           INT                IDENTITY (1000, 1) NOT NULL,
    [DivisionId]            UNIQUEIDENTIFIER   NOT NULL,
    [DivisionName]          NVARCHAR (30)      NOT NULL,
    [CreatedDate]           DATETIME2 (7)      NOT NULL,
    [ModifiedDate]          DATETIME2 (7)      NOT NULL,
    [CreatedByEmployeeKey]  INT                NOT NULL,
    [ModifiedByEmployeeKey] INT                NOT NULL,
    [SalaryBudget]          DECIMAL (14, 4)    NULL,
    [FteBudget]             NUMERIC (5, 1)     NULL,
    [SuppliesBudget]        DECIMAL (14, 4)    NULL,
    [FloorSpaceBudget]      FLOAT (24)         NULL,
    [MaxEmployees]          INT                NULL,
    [LastReviewCycle]       DATETIMEOFFSET (7) NULL,
    [StartTime]             TIME (7)           NULL,
    CONSTRAINT [PK_Division] PRIMARY KEY CLUSTERED ([DivisionKey] ASC),
    CONSTRAINT [UX_Division_DivisionName] UNIQUE NONCLUSTERED ([DivisionName] ASC)
);


GO
PRINT N'Creating [HR].[EmployeeClassification]...';


GO
CREATE TABLE [HR].[EmployeeClassification] (
    [EmployeeClassificationKey]  INT          IDENTITY (1000, 1) NOT NULL,
    [EmployeeClassificationName] VARCHAR (30) NOT NULL,
    [IsExempt]                   BIT          NOT NULL,
    [IsEmployee]                 BIT          NOT NULL,
    CONSTRAINT [PK_EmployeeClassification] PRIMARY KEY CLUSTERED ([EmployeeClassificationKey] ASC),
    CONSTRAINT [UX_EmployeeClassification_EmployeeClassificationName] UNIQUE NONCLUSTERED ([EmployeeClassificationName] ASC)
);


GO
PRINT N'Creating [HR].[Employee]...';


GO
CREATE TABLE [HR].[Employee] (
    [EmployeeKey]               INT            IDENTITY (1000, 1) NOT NULL,
    [FirstName]                 NVARCHAR (50)  NOT NULL,
    [MiddleName]                NVARCHAR (50)  NULL,
    [LastName]                  NVARCHAR (50)  NOT NULL,
    [Title]                     NVARCHAR (100) NULL,
    [OfficePhone]               VARCHAR (15)   NULL,
    [CellPhone]                 VARCHAR (15)   NULL,
    [EmployeeClassificationKey] INT            NOT NULL,
    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([EmployeeKey] ASC)
);


GO
PRINT N'Creating [HR].[Employee].[IX_Employee_LastName]...';


GO
CREATE NONCLUSTERED INDEX [IX_Employee_LastName]
    ON [HR].[Employee]([LastName] ASC);


GO
PRINT N'Creating [Production].[ProductLine]...';


GO
CREATE TABLE [Production].[ProductLine] (
    [ProductLineKey]  INT           IDENTITY (1000, 1) NOT NULL,
    [ProductLineName] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_ProductLine] PRIMARY KEY CLUSTERED ([ProductLineKey] ASC),
    CONSTRAINT [UX_ProductLine_ProductLineName] UNIQUE NONCLUSTERED ([ProductLineName] ASC)
);


GO
PRINT N'Creating [Production].[Product]...';


GO
CREATE TABLE [Production].[Product] (
    [ProductKey]     INT             IDENTITY (1000, 1) NOT NULL,
    [ProductName]    NVARCHAR (50)   NOT NULL,
    [ProductLineKey] INT             NOT NULL,
    [ShippingWeight] NUMERIC (10, 4) NULL,
    [ProductWeight]  NUMERIC (10, 4) NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ProductKey] ASC)
);


GO
PRINT N'Creating [HR].[D_Division_DivisionId]...';


GO
ALTER TABLE [HR].[Division]
    ADD CONSTRAINT [D_Division_DivisionId] DEFAULT (NEWSEQUENTIALID()) FOR [DivisionId];


GO
PRINT N'Creating [HR].[D_Division_CreatedDate]...';


GO
ALTER TABLE [HR].[Division]
    ADD CONSTRAINT [D_Division_CreatedDate] DEFAULT SYSUTCDATETIME() FOR [CreatedDate];


GO
PRINT N'Creating [HR].[D_Division_ModifiedDate]...';


GO
ALTER TABLE [HR].[Division]
    ADD CONSTRAINT [D_Division_ModifiedDate] DEFAULT SYSUTCDATETIME() FOR [ModifiedDate];


GO
PRINT N'Creating [HR].[D_EmployeeClassification_IsExempt]...';


GO
ALTER TABLE [HR].[EmployeeClassification]
    ADD CONSTRAINT [D_EmployeeClassification_IsExempt] DEFAULT (0) FOR [IsExempt];


GO
PRINT N'Creating [HR].[D_EmployeeClassification_IsEmployee]...';


GO
ALTER TABLE [HR].[EmployeeClassification]
    ADD CONSTRAINT [D_EmployeeClassification_IsEmployee] DEFAULT (1) FOR [IsEmployee];


GO
PRINT N'Creating [HR].[FK_Department_DivisionKey]...';


GO
ALTER TABLE [HR].[Department]
    ADD CONSTRAINT [FK_Department_DivisionKey] FOREIGN KEY ([DivisionKey]) REFERENCES [HR].[Division] ([DivisionKey]);


GO
PRINT N'Creating [HR].[FK_Division_CreatedByEmployeeKey]...';


GO
ALTER TABLE [HR].[Division]
    ADD CONSTRAINT [FK_Division_CreatedByEmployeeKey] FOREIGN KEY ([CreatedByEmployeeKey]) REFERENCES [HR].[Employee] ([EmployeeKey]);


GO
PRINT N'Creating [HR].[FK_Division_ModifiedByEmployeeKey]...';


GO
ALTER TABLE [HR].[Division]
    ADD CONSTRAINT [FK_Division_ModifiedByEmployeeKey] FOREIGN KEY ([ModifiedByEmployeeKey]) REFERENCES [HR].[Employee] ([EmployeeKey]);


GO
PRINT N'Creating [HR].[FK_Employee_EmployeeClassificationKey]...';


GO
ALTER TABLE [HR].[Employee]
    ADD CONSTRAINT [FK_Employee_EmployeeClassificationKey] FOREIGN KEY ([EmployeeClassificationKey]) REFERENCES [HR].[EmployeeClassification] ([EmployeeClassificationKey]);


GO
PRINT N'Creating [Production].[FK_Product_ProductLineKey]...';


GO
ALTER TABLE [Production].[Product]
    ADD CONSTRAINT [FK_Product_ProductLineKey] FOREIGN KEY ([ProductLineKey]) REFERENCES [Production].[ProductLine] ([ProductLineKey]);


GO
PRINT N'Creating [Production].[C_Product_Weight]...';


GO
ALTER TABLE [Production].[Product]
    ADD CONSTRAINT [C_Product_Weight] CHECK (ShippingWeight IS NULL
                                       OR ProductWeight IS NULL
                                       OR ShippingWeight >= ProductWeight);


GO
PRINT N'Creating [HR].[DepartmentDetail]...';


GO
CREATE VIEW HR.DepartmentDetail
AS
	SELECT	d.DepartmentKey,
			d.DepartmentName,
			d.DivisionKey,
			d2.DivisionName
	FROM	HR.Department d
	LEFT JOIN HR.Division d2 ON d2.DivisionKey = d.DivisionKey;
GO
PRINT N'Creating [HR].[EmployeeDetail]...';


GO
CREATE VIEW HR.EmployeeDetail
WITH SCHEMABINDING
AS
SELECT e.EmployeeKey,
       e.FirstName,
       e.MiddleName,
       e.LastName,
       e.Title,
       e.OfficePhone,
       e.CellPhone,
       e.EmployeeClassificationKey,
       ec.EmployeeClassificationName,
       ec.IsExempt,
       ec.IsEmployee
FROM HR.Employee e
    INNER JOIN HR.EmployeeClassification ec
        ON e.EmployeeClassificationKey = ec.EmployeeClassificationKey;
GO
PRINT N'Creating [HR].[CountEmployeesByClassification]...';


GO
CREATE PROCEDURE HR.CountEmployeesByClassification
AS
BEGIN
    SET NOCOUNT ON;
    SELECT COUNT(e.EmployeeKey) AS EmployeeCount,
           ec.EmployeeClassificationKey,
           ec.EmployeeClassificationName
    FROM HR.EmployeeClassification ec
        LEFT JOIN HR.Employee e
            ON e.EmployeeClassificationKey = ec.EmployeeClassificationKey
    GROUP BY ec.EmployeeClassificationKey,
             ec.EmployeeClassificationName
    ORDER BY ec.EmployeeClassificationName;

    RETURN 0;
END;
GO
PRINT N'Creating [HR].[GetEmployeeClassifications]...';


GO
CREATE PROCEDURE HR.GetEmployeeClassifications @EmployeeClassificationKey INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ec.EmployeeClassificationKey,
           ec.EmployeeClassificationName,
           ec.IsExempt,
           ec.IsEmployee
    FROM HR.EmployeeClassification ec
    WHERE (@EmployeeClassificationKey IS NULL)
          OR (ec.EmployeeClassificationKey = @EmployeeClassificationKey);

    RETURN 0;
END;
GO
PRINT N'Creating [HR].[CreateEmployeeClassification]...';


GO
CREATE PROCEDURE HR.CreateEmployeeClassification
    @EmployeeClassificationName VARCHAR(30),
    @IsExempt BIT,
    @IsEmployee BIT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO HR.EmployeeClassification
    (
        EmployeeClassificationName,
        IsExempt,
        IsEmployee
    )
    VALUES
    (@EmployeeClassificationName, @IsExempt, @IsEmployee);

	--Use a temp variable to ensure the correct data type
	DECLARE @EmployeeClassificationKey INT = SCOPE_IDENTITY();
    SELECT @EmployeeClassificationKey AS EmployeeClassificationKey;

    RETURN 0;
END;
GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/


GO


DECLARE	@EmployeeClassification TABLE
(
 EmployeeClassificationKey INT NOT NULL,
 EmployeeClassificationName VARCHAR(30) NOT NULL,
 IsExempt BIT NOT NULL,
 IsEmployee BIT NOT NULL
);

INSERT	INTO @EmployeeClassification
		(EmployeeClassificationKey, EmployeeClassificationName, IsExempt, IsEmployee)
VALUES	(1, 'Full Time Salary', 1, 1),
		(2, 'Full Time Wage', 0, 1),
		(3, 'Part Time Wage', 0, 1),
		(4, 'Contractor', 0, 0),
		(5, 'Paid Intern', 0, 1),
		(6, 'Unpaid Intern', 1, 1),
		(7, 'Consultant', 1, 0);




SET IDENTITY_INSERT HR.EmployeeClassification ON;

MERGE INTO HR.EmployeeClassification t
USING @EmployeeClassification s
ON t.EmployeeClassificationKey = s.EmployeeClassificationKey
WHEN NOT MATCHED THEN
	INSERT (EmployeeClassificationKey,
			EmployeeClassificationName,
			IsExempt, IsEmployee
		   )
	VALUES (s.EmployeeClassificationKey,
			s.EmployeeClassificationName,
			s.IsExempt, s.IsEmployee
		   )
WHEN MATCHED THEN
	UPDATE SET t.EmployeeClassificationName = s.EmployeeClassificationName, t.IsExempt=s.IsExempt, t.IsEmployee = s.IsEmployee
WHEN NOT MATCHED BY SOURCE AND t.EmployeeClassificationKey < 1000 THEN
	DELETE;


SET IDENTITY_INSERT HR.EmployeeClassification OFF;


GO
DECLARE @Employee TABLE
(
    EmployeeKey INT NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50) NULL,
    LastName NVARCHAR(50) NOT NULL,
    Title NVARCHAR(100) NULL,
    OfficePhone VARCHAR(15) NULL,
    CellPhone VARCHAR(15) NULL,
    EmployeeClassificationKey INT NOT NULL
);

INSERT INTO @Employee
(
    EmployeeKey,
    FirstName,
    MiddleName,
    LastName,
    Title,
    OfficePhone,
    CellPhone,
    EmployeeClassificationKey
)
VALUES
(1, 'John', NULL, 'Doe', NULL, NULL, NULL, 1),
(2, 'Jane', NULL, 'Doe', NULL, NULL, NULL, 2),
(3, 'Tom', NULL, 'Jones', NULL, NULL, NULL, 3),
(4, 'Chuck', NULL, 'Jones', NULL, NULL, NULL, 4);





SET IDENTITY_INSERT HR.Employee ON;

MERGE INTO HR.Employee t
USING @Employee s
ON t.EmployeeKey = s.EmployeeKey
WHEN NOT MATCHED THEN
    INSERT
    (
        EmployeeKey,
        FirstName,
        MiddleName,
        LastName,
        Title,
        OfficePhone,
        CellPhone,
        EmployeeClassificationKey
    )
    VALUES
    (s.EmployeeKey, s.FirstName, s.MiddleName, s.LastName, s.Title, s.OfficePhone, s.CellPhone,
     s.EmployeeClassificationKey)
WHEN MATCHED THEN
    UPDATE SET t.FirstName = s.FirstName,
               t.MiddleName = s.MiddleName,
               t.LastName = s.LastName,
               t.Title = s.Title,
               t.OfficePhone = s.OfficePhone,
               t.CellPhone = s.CellPhone,
               t.EmployeeClassificationKey = s.EmployeeClassificationKey
WHEN NOT MATCHED BY SOURCE AND t.EmployeeKey < 1000 THEN
    DELETE;


SET IDENTITY_INSERT HR.Employee OFF;



GO

DECLARE @Division TABLE
(
    DivisionKey INT NOT NULL PRIMARY KEY,
    DivisionName NVARCHAR(30) NOT NULL
        UNIQUE,
    CreatedByEmployeeKey INT NOT NULL
        DEFAULT 1,
    ModifiedByEmployeeKey INT NOT NULL
        DEFAULT 1,
    SalaryBudget DECIMAL(14, 4) NULL,
    FteBudget NUMERIC(5, 1) NULL,
    SuppliesBudget DECIMAL(14, 4) NULL,
    FloorSpaceBudget FLOAT(24) NULL,
    MaxEmployees INT NULL,
    LastReviewCycle DATETIMEOFFSET NULL
        DEFAULT SYSDATETIMEOFFSET(),
    StartTime TIME NULL
);


INSERT INTO @Division
(
    DivisionKey,
    DivisionName,
    SalaryBudget,
    FteBudget,
    SuppliesBudget,
    FloorSpaceBudget,
    MaxEmployees,
    StartTime
)
VALUES
(1, 'HR', 875000, 10.5, 20000, 12000, 15, '9:00'),
(2, 'Accounting', null, null, null, null, null, null),
(3, 'Sales', 2312000, 40.5, 65000, 1000, 60, '12:00'),
(4, 'Manufactoring', 323000, 30, 24520000, 120000, 35, '6:00'),
(5, 'Engineering', 23000, 4, 25000, 32000, 8, '11:00');

SET IDENTITY_INSERT HR.Division ON;

MERGE INTO HR.Division t
USING @Division s
ON t.DivisionKey = s.DivisionKey
WHEN NOT MATCHED THEN
    INSERT
    (
        DivisionKey,
        DivisionName,
        CreatedByEmployeeKey,
        ModifiedByEmployeeKey,
        SalaryBudget,
        FteBudget,
        SuppliesBudget,
        FloorSpaceBudget,
        MaxEmployees,
        LastReviewCycle,
        StartTime
    )
    VALUES
    (s.DivisionKey, s.DivisionName, s.CreatedByEmployeeKey, s.ModifiedByEmployeeKey, s.SalaryBudget, s.FteBudget,
     s.SuppliesBudget, s.FloorSpaceBudget, s.MaxEmployees, s.LastReviewCycle, s.StartTime)
WHEN MATCHED THEN
    UPDATE SET t.DivisionName = s.DivisionName,
               t.ModifiedByEmployeeKey = s.ModifiedByEmployeeKey,
               t.SalaryBudget = s.SalaryBudget,
               t.FteBudget = s.FteBudget,
               t.SuppliesBudget = s.SuppliesBudget,
               t.FloorSpaceBudget = s.FloorSpaceBudget,
               t.ModifiedDate = SYSUTCDATETIME(),
               MaxEmployees = s.MaxEmployees,
               LastReviewCycle = s.LastReviewCycle,
               StartTime = s.StartTime
WHEN NOT MATCHED BY SOURCE AND t.DivisionKey < 1000 THEN
    DELETE;


SET IDENTITY_INSERT HR.Division OFF;



--Ensure all constraints are enabled
 
DECLARE @TableList TABLE
(
    TableId INT NOT NULL IDENTITY,
    SchameName NVARCHAR(100) NOT NULL,
    TableName NVARCHAR(100) NOT NULL
);
 
INSERT INTO @TableList
(
    SchameName,
    TableName
)
SELECT s.name,
       t.name
FROM sys.tables t
    INNER JOIN sys.schemas s
        ON t.schema_id = s.schema_id;
 
DECLARE @LastRow INT = 0;
DECLARE @SQL NVARCHAR(1000);
 
WHILE EXISTS (SELECT * FROM @TableList tl WHERE tl.TableId > @LastRow  )
BEGIN
       SET @LastRow = @LastRow+ 1;
       SELECT @SQL = 'ALTER TABLE [' + tl.SchameName + '].[' + tl.TableName + '] WITH CHECK CHECK CONSTRAINT ALL'
       FROM @TableList tl WHERE tl.TableId = @LastRow;
 
       EXEC sys.sp_executesql @SQL
END
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
