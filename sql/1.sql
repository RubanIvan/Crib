CREATE DATABASE Crib;
GO

CREATE TABLE Page
(
	PageID int IDENTITY NOT NULL PRIMARY KEY,
	Title nvarchar(1024),
)

CREATE TABLE Tag
(
	TagID int IDENTITY NOT NULL PRIMARY KEY,
	Tag nvarchar(128)
)