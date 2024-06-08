using QuanLyBanSach.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanLyBanSach.Controllers
{
    public class SachController : Controller
    {
        QLBanSachDataContext db = new QLBanSachDataContext();

        public ActionResult Detail(int id)
        {
            Sach book = db.Saches.Single(x => x.MaSach == id);
            if (book == null)
            {
                return HttpNotFound();
            }

            // Trả về một partial view chứa nội dung chi tiết sách
            return PartialView(book);
        }
    }
}