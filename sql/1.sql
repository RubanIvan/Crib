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


INSERT Lang (Lang) VALUES ('HTML'),('C#'),('SQL')

INSERT Tag(Tag) VALUES ('Console'),('WPF')


INSERT Page (Title,PageID) VALUES ('Hello world',1)


--UPDATE Page SET Title='Hello world'


INSERT PageTag(PageID,TagID) VALUES (1,1)

--SELECT * FROM PageTag
--SELECT * FROM Tag

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
------------------------------------------------------------------------------------
--SELECT * FROM Page
--LangID HTML=1,C#=2,SQL=3
INSERT Page (Title) VALUES ('���������� ������ (�����) �� ����������')

INSERT Content (PageID,LangID,BlockNum,Content) VALUES
(2,1,1,'<p>���������� ����������� ����������</p>'),
(2,2,2,
'
	//0 ��� ��������
	System.Environment.Exit(0);
')

--��������� ����
INSERT PageTag(PageID,TagID) VALUES (2,1)

--UPDATE Page SET Title='���������� ������ (�����) �� ����������' WHERE PageID=2
SELECT * FROM Content
UPDATE Content SET Content='<p>�������� � ����� ���������� ���������� � C#, ����������� ���������� ��������� "Hello, world"</p>' WHERE ContentID=1


INSERT Page (Title) VALUES ('�������� ����������� WPF')

INSERT Content (PageID,LangID,BlockNum,Content) VALUES
(3,1,1,'<p>�������� ����������� � WPF</p>'),
(3,2,2,
'
		/// <summary>����������� ������� ��������� </summary>
        public Image ShipEngineImage;

        /// <summary>������� ������ �������� ������� ���������</summary>
        public List<BitmapImage> ShipEngImageList = new List<BitmapImage>();

        /// <summary>���������� ������ �������� ������� ���������</summary>
        protected const int AnimShipEngMaxFrame = 4;

        /// <summary>�����. �������� ��� �������� ������� ���������</summary>
        public static readonly DependencyProperty CurFrameRotateProperty = DependencyProperty.Register(
            "CurFrameRotate", typeof(int), typeof(PlayerShip), new PropertyMetadata(default(int), CurFrameShipEngChange));

        /// <summary>������� ���� �������� ��������� </summary>
        public int CurFrameEngImage
        {
            get { return (int)GetValue(CurFrameRotateProperty); }
            set { SetValue(CurFrameRotateProperty, value); }
        }

        /// <summary>���������� ������� ����������� ����� ����� ������� �����</summary>
        private static void CurFrameShipEngChange(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            //������������� ����������� ������ ����� ��������
            ((PlayerShip)(d)).ShipEngineImage.Source = ((PlayerShip)(d)).ShipEngImageList[((PlayerShip)(d)).CurFrameEngImage];
        }

        //������� �������� ��������
        public Int32Animation AnimEngFire = new Int32Animation(0, AnimShipEngMaxFrame - 1, TimeSpan.FromSeconds(0.4));

		//��� �������� ��������� ������ ���������� �����
        AnimEngFire.RepeatBehavior = RepeatBehavior.Forever;

        //��������� ��������
        BeginAnimation(CurFrameRotateProperty, AnimEngFire);
')

INSERT PageTag(PageID,TagID) VALUES (3,2)