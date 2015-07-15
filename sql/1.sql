CREATE DATABASE Crib;
--DROP DATABASE Crib;
GO
--�������� ������ ��������
--DROP TABLE Page
CREATE TABLE Page
(
	PageID int IDENTITY NOT NULL PRIMARY KEY, 
	Title nvarchar(1024)
)

--DROP TABLE Tag
--���� ��� ������
CREATE TABLE Tag
(
	TagID int IDENTITY NOT NULL PRIMARY KEY,
	Tag nvarchar(128) NOT NULL UNIQUE
)

-- ������������� �������� � ������
--DROP TABLE PageTag
CREATE TABLE PageTag
(
	PageID int,
	TagID int 
)
--CREATE index PageTagIndex on PageTag (PageID,TagID);

ALTER TABLE PageTag WITH CHECK ADD  CONSTRAINT [FK_PageID_Page] FOREIGN KEY (PageID)
REFERENCES Page(PageID)

ALTER TABLE PageTag WITH CHECK ADD  CONSTRAINT [FK_TagID_Tag] FOREIGN KEY (TagID)
REFERENCES Tag(TagID)



--���� ��������������� ������� ������������ � ����� ��������
CREATE TABLE Lang
(
	LangID int IDENTITY NOT NULL PRIMARY KEY,
	Lang nvarchar(128) NOT NULL UNIQUE
)

CREATE TABLE Content
(
	ContentID int IDENTITY NOT NULL PRIMARY KEY,
	PageID int, -- �� ��������� �������
	LangID int, -- ��� �����
	BlockNum int NOT NULL, --����� ����� �� �������� 
	Content ntext
)

ALTER TABLE Content WITH CHECK ADD  CONSTRAINT [FK_LangID_Lang] FOREIGN KEY (LangID)
REFERENCES Lang(LangID)

ALTER TABLE Content WITH CHECK ADD  CONSTRAINT [FK_PageID_Content] FOREIGN KEY (PageID)
REFERENCES Page(PageID)

INSERT Lang (Lang) VALUES ('HTML'),('C#')

INSERT Tag(Tag) VALUES ('Console'),('WPF')


INSERT Page (Title,PageID) VALUES ('Hello world',1)

--UPDATE Page SET Title='Hello world'


INSERT PageTag(PageID,TagID) VALUES (1,1)

INSERT Content (PageID,LangID,BlockNum,Content) VALUES
(1,1,1,'�������� � ����� ���������� ���������� � C#, ����������� ���������� ��������� "Hello, world"'),
(1,2,2,'
using System;

class Hello
{
	static void Main()
	{
		Console.WriteLine("hello, world");
	}
}
')
GO

CREATE PROC GetPageTitle
@PageID int
AS
SELECT Title FROM Page WHERE PageID=@PageID

GO

CREATE PROC GetPage
@PageID int
AS
SELECT ContentID,PageID, LangID, BlockNum, Content  
FROM Content WHERE PageID=@PageID 
ORDER BY BlockNum 
GO



