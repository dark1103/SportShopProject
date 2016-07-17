
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 04/28/2016 08:11:13
-- Generated from EDMX file: C:\Users\MSIG70\Documents\Visual Studio 2015\Projects\SportShopProject\SportShopProject\Models\SportShopDBModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [SportShopDB_4];
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
IF OBJECT_ID(N'[dbo].[FK_CategoryProduct]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Products] DROP CONSTRAINT [FK_CategoryProduct];
GO
IF OBJECT_ID(N'[dbo].[FK_Bike_inherits_Product]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Products_Bike] DROP CONSTRAINT [FK_Bike_inherits_Product];
GO
IF OBJECT_ID(N'[dbo].[FK_Clothes_inherits_Product]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Products_Clothes] DROP CONSTRAINT [FK_Clothes_inherits_Product];
GO
IF OBJECT_ID(N'[dbo].[FK_Shoes_inherits_Product]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Products_Shoes] DROP CONSTRAINT [FK_Shoes_inherits_Product];
GO
IF OBJECT_ID(N'[dbo].[FK_Sneakers_inherits_Shoes]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Products_Sneakers] DROP CONSTRAINT [FK_Sneakers_inherits_Shoes];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Products]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Products];
GO
IF OBJECT_ID(N'[dbo].[Clients]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Clients];
GO
IF OBJECT_ID(N'[dbo].[OrderedProducts]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderedProducts];
GO
IF OBJECT_ID(N'[dbo].[Orders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Orders];
GO
IF OBJECT_ID(N'[dbo].[Categories]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Categories];
GO
IF OBJECT_ID(N'[dbo].[Products_Bike]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Products_Bike];
GO
IF OBJECT_ID(N'[dbo].[Products_Clothes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Products_Clothes];
GO
IF OBJECT_ID(N'[dbo].[Products_Shoes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Products_Shoes];
GO
IF OBJECT_ID(N'[dbo].[Products_Sneakers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Products_Sneakers];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Products'
CREATE TABLE [dbo].[Products] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(30)  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Price] decimal(18,0)  NULL,
    [Vendor] nvarchar(20)  NULL,
    [CategoryId] int  NULL,
    [Article] nvarchar(20)  NULL
);
GO

-- Creating table 'Clients'
CREATE TABLE [dbo].[Clients] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(max)  NULL,
    [LastName] nvarchar(max)  NULL,
    [Age] int  NULL,
    [Gender] int  NULL,
    [Mail] nvarchar(max)  NOT NULL,
    [Phone] int  NULL,
    [UserName] nvarchar(max)  NULL
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

-- Creating table 'Products_Bike'
CREATE TABLE [dbo].[Products_Bike] (
    [Material] int  NOT NULL,
    [MaxWeight] int  NOT NULL,
    [SpeedsCount] int  NOT NULL,
    [Id] int  NOT NULL
);
GO

-- Creating table 'Products_Clothes'
CREATE TABLE [dbo].[Products_Clothes] (
    [Sizes] nvarchar(max)  NULL,
    [Colors] nvarchar(max)  NULL,
    [Id] int  NOT NULL
);
GO

-- Creating table 'Products_Shoes'
CREATE TABLE [dbo].[Products_Shoes] (
    [Sizes] nvarchar(max)  NULL,
    [Colors] nvarchar(max)  NULL,
    [Id] int  NOT NULL
);
GO

-- Creating table 'Products_Sneakers'
CREATE TABLE [dbo].[Products_Sneakers] (
    [Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

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

-- Creating primary key on [Id] in table 'Categories'
ALTER TABLE [dbo].[Categories]
ADD CONSTRAINT [PK_Categories]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Products_Bike'
ALTER TABLE [dbo].[Products_Bike]
ADD CONSTRAINT [PK_Products_Bike]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Products_Clothes'
ALTER TABLE [dbo].[Products_Clothes]
ADD CONSTRAINT [PK_Products_Clothes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Products_Shoes'
ALTER TABLE [dbo].[Products_Shoes]
ADD CONSTRAINT [PK_Products_Shoes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Products_Sneakers'
ALTER TABLE [dbo].[Products_Sneakers]
ADD CONSTRAINT [PK_Products_Sneakers]
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

-- Creating foreign key on [CategoryId] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [FK_CategoryProduct]
    FOREIGN KEY ([CategoryId])
    REFERENCES [dbo].[Categories]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CategoryProduct'
CREATE INDEX [IX_FK_CategoryProduct]
ON [dbo].[Products]
    ([CategoryId]);
GO

-- Creating foreign key on [Id] in table 'Products_Bike'
ALTER TABLE [dbo].[Products_Bike]
ADD CONSTRAINT [FK_Bike_inherits_Product]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Id] in table 'Products_Clothes'
ALTER TABLE [dbo].[Products_Clothes]
ADD CONSTRAINT [FK_Clothes_inherits_Product]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Id] in table 'Products_Shoes'
ALTER TABLE [dbo].[Products_Shoes]
ADD CONSTRAINT [FK_Shoes_inherits_Product]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Id] in table 'Products_Sneakers'
ALTER TABLE [dbo].[Products_Sneakers]
ADD CONSTRAINT [FK_Sneakers_inherits_Shoes]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[Products_Shoes]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------