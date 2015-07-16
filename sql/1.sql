CREATE DATABASE Crib;
--DROP DATABASE Crib;
GO
--хранение данных страницы
--DROP TABLE Page
CREATE TABLE Page
(
	PageID int IDENTITY NOT NULL PRIMARY KEY, 
	Title nvarchar(1024)
)

--DROP TABLE Tag
--тэги для поиска
CREATE TABLE Tag
(
	TagID int IDENTITY NOT NULL PRIMARY KEY,
	Tag nvarchar(128) NOT NULL UNIQUE
)

-- сопоставление страницы с тегами
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



--язык програмирования который используется в блоке контента
CREATE TABLE Lang
(
	LangID int IDENTITY NOT NULL PRIMARY KEY,
	Lang nvarchar(128) NOT NULL UNIQUE
)

CREATE TABLE Content
(
	ContentID int IDENTITY NOT NULL PRIMARY KEY,
	PageID int, -- ид заглавной станицы
	LangID int, -- код языка
	BlockNum int NOT NULL, --номер блока на странице 
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
(1,1,1,'Переходя к более подробному знакомству с C#, традиционно рассмотрим программу "Hello, world"'),
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
INSERT Page (Title) VALUES ('Завершение работы (выход) из приложения')

INSERT Content (PageID,LangID,BlockNum,Content) VALUES
(2,1,1,'<p>Завершение консольного приложения</p>'),
(2,2,2,
'
	//0 код возврата
	System.Environment.Exit(0);
')

--добавляем теги
INSERT PageTag(PageID,TagID) VALUES (2,1)

--UPDATE Page SET Title='Завершение работы (выход) из приложения' WHERE PageID=2
SELECT * FROM Content
UPDATE Content SET Content='<p>Переходя к более подробному знакомству с C#, традиционно рассмотрим программу "Hello, world"</p>' WHERE ContentID=1


INSERT Page (Title) VALUES ('Анимация изображения WPF')

INSERT Content (PageID,LangID,BlockNum,Content) VALUES
(3,1,1,'<p>Анимация изображения в WPF</p>'),
(3,2,2,
'
		/// <summary>Изображение пламени двигателя </summary>
        public Image ShipEngineImage;

        /// <summary>спрайты кадров анимации пламени двигателя</summary>
        public List<BitmapImage> ShipEngImageList = new List<BitmapImage>();

        /// <summary>количество кадров анимации пламени двигателя</summary>
        protected const int AnimShipEngMaxFrame = 4;

        /// <summary>Завис. свойство для анимации пламени двигателя</summary>
        public static readonly DependencyProperty CurFrameRotateProperty = DependencyProperty.Register(
            "CurFrameRotate", typeof(int), typeof(PlayerShip), new PropertyMetadata(default(int), CurFrameShipEngChange));

        /// <summary>Текущий кадр анимации двигателя </summary>
        public int CurFrameEngImage
        {
            get { return (int)GetValue(CurFrameRotateProperty); }
            set { SetValue(CurFrameRotateProperty, value); }
        }

        /// <summary>обработчик события срабатывает после смены каждого кадра</summary>
        private static void CurFrameShipEngChange(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            //Устанавливает изображение равное кадру анимации
            ((PlayerShip)(d)).ShipEngineImage.Source = ((PlayerShip)(d)).ShipEngImageList[((PlayerShip)(d)).CurFrameEngImage];
        }

        //создаем анимацию вращения
        public Int32Animation AnimEngFire = new Int32Animation(0, AnimShipEngMaxFrame - 1, TimeSpan.FromSeconds(0.4));

		//для анимации двигателя задаем повторятся вечно
        AnimEngFire.RepeatBehavior = RepeatBehavior.Forever;

        //Запускаем анимацию
        BeginAnimation(CurFrameRotateProperty, AnimEngFire);
')

INSERT PageTag(PageID,TagID) VALUES (3,2)