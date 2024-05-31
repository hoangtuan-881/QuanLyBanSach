using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QuanLyBanSach.Models;

namespace QuanLyBanSach.Controllers
{
    public class HomeController : Controller
    {
        QLBanSachDataContext db = new QLBanSachDataContext();
        public ActionResult Index()
        {
            ViewBag.Title = "Trang chủ";

            return View();
        }
        public ActionResult CuaHang()
        {
            ViewBag.Title = "Cửa hàng";

            var lists = db.Saches.ToList();
            return View(lists);
        }
        public ActionResult GioiThieu()
        {
            ViewBag.Title = "Giới thiệu";

            return View();
        }
        public ActionResult LienHe()
        {
            ViewBag.Title = "Liên hệ";

            return View();
        }
        // Phần thể hiện cửa hàng
        public ActionResult DanhMucPartial()
        {
            var listd = db.DanhMucs.ToList();
            return View(listd);
        }
        public ActionResult Sach_DM(string MaDM)
        {
            List<Sach> listcd = db.Saches.Where(s => s.MaDM.StartsWith(MaDM)).ToList();
            if (listcd.Count() == 0)
            {
                ViewBag.TB = "Không có sách nào thuộc chủ đề này!";
            }
            var dm = db.DanhMucs.SingleOrDefault(x => x.MaDM.StartsWith(MaDM));
            if (dm == null)
            {
                ViewBag.TB = "Chủ đề không tồn tại!";
                return View(new List<Sach>());
            }
            ViewBag.TenCD = dm.TenDM;
            return View(listcd);
        }
        public ActionResult Detail(int id)
        {
            var sach = db.Saches.FirstOrDefault(s => s.MaSach == id);
            if (sach == null)
            {
                return HttpNotFound();
            }
            return PartialView("SachDetail", sach);
        }
    }
}
