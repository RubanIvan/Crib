using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace Crib.Models
{

    public enum LangEnum
    {
        HTML = 1,
        Charp = 2,
        SQL = 3
    }

    public class Content
    {
        public int ContentID { get; set; }
        public int PageID { get; set; }
        public int LangID { get; set; }
        public int BlockNum { get; set; }
        public string BlockContent { get; set; }

        public Content(int contentID, int pageID, int langID, int blockNum, string blockContent)
        {
            ContentID = contentID;
            PageID = pageID;
            LangID = langID;
            BlockNum = blockNum;
            BlockContent = blockContent;
        }

    }
}