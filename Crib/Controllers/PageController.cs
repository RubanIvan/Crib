using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Crib.Models;


namespace Crib.Controllers
{
    public class PageController : Controller
    {
        private static string ConString = ConfigurationManager.ConnectionStrings["CribConnection"].ConnectionString;


        //
        // GET: /Page/
        public ActionResult Index(int? id)
        {
            List<Content> Contents;
            SqlCommand Command;
            SqlParameter PageId;

            using ( SqlConnection Сonnection = new SqlConnection(ConString))
            {
                Сonnection.Open();

                Command = Сonnection.CreateCommand();
                Command.CommandText = "GetPageTitle";
                Command.CommandType = CommandType.StoredProcedure;

                PageId = new SqlParameter("PageID", SqlDbType.Int);
                PageId.Value = id;
                Command.Parameters.Add(PageId);
                ViewBag.Title = Command.ExecuteScalar();
                //-------------------------------------------------------------

                Command = Сonnection.CreateCommand();
                Command.CommandText = "GetPage";
                Command.CommandType = CommandType.StoredProcedure;

                PageId = new SqlParameter("PageID", SqlDbType.Int);
                PageId.Value = id;
                Command.Parameters.Add(PageId);


                SqlDataReader reader = Command.ExecuteReader();

                Contents=new List<Content>();
                while (reader.Read())
                {
                    Contents.Add(new Content((int)reader["ContentID"], (int)reader["PageID"], (int)reader["LangID"], (int)reader["BlockNum"], (string)reader["Content"]));
                }

            }
           
            return View(Contents);
        }


        
    }
}
