
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 04/24/2016 13:01:06
-- Generated from EDMX file: C:\Users\MSIG70\Documents\Visual Studio 2015\Projects\SportShopProject\SportShopProject\Models\SportShopDBModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [SportShopDB_3];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_ClientOrder]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_ClientOrder];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderOrderedProduct]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[OrderedProducts] DROP CONSTRAINT [FK_OrderOrderedProduct];
GO
IF OBJECT_ID(N'[dbo].[FK_ProductOrderedProduct]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[OrderedProducts] DROP CONSTRAINT [FK_ProductOrderedProduct];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Clients]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Clients];
GO
IF OBJECT_ID(N'[dbo].[OrderedProducts]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderedProducts];
GO
IF OBJECT_ID(N'[dbo].[Orders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Orders];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Clients'
CREATE TABLE [dbo].[Clients] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(max)  NOT NULL,
    [LastName] nvarchar(max)  NOT NULL,
    [Age] nvarchar(max)  NOT NULL,
    [Gender] int  NULL,
    [Mail] nvarchar(max)  NULL,
    [Phone] int  NULL,
    [UserName] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'OrderedProducts'
CREATE TABLE [dbo].[OrderedProducts] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [OrderId] int  NOT NULL,
    [ProductId] int  NOT NULL,
    [Count] int  NOT NULL,
    [Note] nvarchar(max)  NULL
);
GO

-- Creating table 'Orders'
CREATE TABLE [dbo].[Orders] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [ClientId] int  NOT NULL,
    [Discount] int  NOT NULL
);
GO

-- Creating table 'Categories'
CREATE TABLE [dbo].[Categories] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Products'


-- Creating primary key on [Id] in table 'Clients'
ALTER TABLE [dbo].[Clients]
ADD CONSTRAINT [PK_Clients]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'OrderedProducts'
ALTER TABLE [dbo].[OrderedProducts]
ADD CONSTRAINT [PK_OrderedProducts]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [ClientId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_ClientOrder]
    FOREIGN KEY ([ClientId])
    REFERENCES [dbo].[Clients]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ClientOrder'
CREATE INDEX [IX_FK_ClientOrder]
ON [dbo].[Orders]
    ([ClientId]);
GO

-- Creating foreign key on [OrderId] in table 'OrderedProducts'
ALTER TABLE [dbo].[OrderedProducts]
ADD CONSTRAINT [FK_OrderOrderedProduct]
    FOREIGN KEY ([OrderId])
    REFERENCES [dbo].[Orders]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderOrderedProduct'
CREATE INDEX [IX_FK_OrderOrderedProduct]
ON [dbo].[OrderedProducts]
    ([OrderId]);
GO

-- Creating foreign key on [ProductId] in table 'OrderedProducts'
ALTER TABLE [dbo].[OrderedProducts]
ADD CONSTRAINT [FK_ProductOrderedProduct]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductOrderedProduct'
CREATE INDEX [IX_FK_ProductOrderedProduct]
ON [dbo].[OrderedProducts]
    ([ProductId]);
GO


-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------