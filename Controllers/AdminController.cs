using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QuanLyBanSach.Models;
using System.IO;
using System.Data.Linq.SqlClient;
using QuanLyBanSach.Attributes;

namespace QuanLyBanSach.Controllers
{
    public class AdminController : Controller
    {
        QLBanSachDataContext db = new QLBanSachDataContext();
        //---------------------Sách---------------------------------
        [CustomAuthorize(RolesName = "Admin")]
        public ActionResult AdminIndex()
        {
            ViewBag.Title = "Trang Admin";
            return View();
        }
        public ActionResult List_Sach()//Hiển thị cho trang admin
        {
            var lists = db.Saches.ToList();
            return View(lists);
        }
        public ActionResult Detail_Sach(int id = 0)
        {
            Sach book = db.Saches.Single(x => x.MaSach == id);
            if (book == null)
            {
                return HttpNotFound();
            }
            return View(book);
        }
        public ActionResult Delete_Sach(int id)
        {
            // Tìm tất cả các chi tiết tác giả liên quan đến sách
            var authorDetails = db.ChiTietTacGias.Where(s => s.MaSach == id).ToList();
            var bookToDelete = db.Saches.FirstOrDefault(s => s.MaSach == id);
            if (bookToDelete != null)
            {
                // Xóa tất cả các chi tiết tác giả liên quan
                foreach (var authorDetail in authorDetails)
                {
                    db.ChiTietTacGias.DeleteOnSubmit(authorDetail);
                }
                // Xóa sách
                db.Saches.DeleteOnSubmit(bookToDelete);
                // Lưu thay đổi vào cơ sở dữ liệu
                db.SubmitChanges();
                return RedirectToAction("List_Sach"); // Chuyển hướng đến action SachList sau khi xóa thành công
            }
            else
            {
                return HttpNotFound(); // Trả về lỗi 404 Not Found nếu không tìm thấy sách để xóa
            }
        }
        public ActionResult Create_Sach()
        {
            var viewModel = new SachModel
            {
                DanhMucs = db.DanhMucs.ToList(),
                NhaXuatBans = db.NhaXuatBans.ToList(),
                NgayCapNhat = DateTime.Now
            };
            return View(viewModel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create_Sach(SachModel model)
        {
            if (ModelState.IsValid)
            {
                string fileName = null;
                if (model.AnhBia != null && model.AnhBia.ContentLength > 0)
                {
                    // Lưu file ảnh vào thư mục /Content/Images/
                    fileName = Path.GetFileName(model.AnhBia.FileName);
                    string path = Path.Combine(Server.MapPath("~/Content/images/sach/"), fileName);
                    model.AnhBia.SaveAs(path);
                }

                Sach sach = new Sach
                {
                    MaDM = model.MaDM,
                    MaNXB = model.MaNXB,
                    TenSach = model.TenSach,
                    DoiTuong = model.DoiTuong,
                    Kho = model.Kho,
                    SoTrang = model.SoTrang,
                    TrongLuong = model.TrongLuong,
                    DinhDang = model.DinhDang,
                    GiaBan = model.GiaBan,
                    MoTa = model.MoTa,
                    NgayCapNhat = model.NgayCapNhat,
                    AnhBia = fileName,
                    SLTon = model.SLTon
                };
                db.Saches.InsertOnSubmit(sach);
                db.SubmitChanges();
                return RedirectToAction("List_Sach");
            }
            model.DanhMucs = db.DanhMucs.ToList();
            model.NhaXuatBans = db.NhaXuatBans.ToList();
            return View(model);
        }
        //---------------------------Tác giả-----------------------------------------
        public ActionResult List_TacGia()
        {
            var listt = db.TacGias.ToList();
            return View(listt);
        }

        //---------------------------Nhà xuất bản --------------------------------------
        public ActionResult List_NXB()
        {
            var listt = db.NhaXuatBans.ToList();
            return View(listt);
        }
        public ActionResult Create_NXB()
        {
            return View();
        }

        // POST: NhaXuatBan/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create_NXB(NXBModel model)
        {
            if (ModelState.IsValid)
            {
                NhaXuatBan nhaXuatBan = new NhaXuatBan
                {
                    MaNXB = model.MaNXB,
                    TenNXB = model.TenNXB,
                    DiaChi = model.DiaChi,
                    DienThoai = model.DienThoai
                };

                db.NhaXuatBans.InsertOnSubmit(nhaXuatBan);
                db.SubmitChanges();
                return RedirectToAction("List_NXB"); // Chuyển hướng đến một trang khác sau khi thêm thành công
            }

            return View(model);
        }
        //--------------------------Danh mục----------------------------
        public ActionResult List_DM()
        {
            var listt = db.DanhMucs.ToList();
            return View(listt);
        }
        public ActionResult Create_DM()
        {
            return View();
        }

        // POST: DanhMuc/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create_DM(DMModel model)
        {
            if (ModelState.IsValid)
            {
                DanhMuc danhMuc = new DanhMuc
                {
                    MaDM = model.MaDM,
                    TenDM = model.TenDM
                };

                db.DanhMucs.InsertOnSubmit(danhMuc);
                db.SubmitChanges();
                return RedirectToAction("List_DM"); // Chuyển hướng đến một trang khác sau khi thêm thành công
            }

            return View(model);
        }
        //--------------------------Khách hàng----------------------------
        [Authorize]
        public ActionResult List_KH()
        {
            var listk = db.KhachHangs.ToList();
            return View(listk);
        }
        public ActionResult Detail_KH(int id)
        {
            KhachHang khachHang = db.KhachHangs.FirstOrDefault(k => k.MaKH == id);
            if (khachHang == null)
            {
                return HttpNotFound();
            }
            return View(khachHang);
        }

        public ActionResult Delete_KH(int id)
        {
            var KhachHang = db.KhachHangs.FirstOrDefault(s => s.MaKH == id);
            db.KhachHangs.DeleteOnSubmit(KhachHang);
            db.SubmitChanges();
            return RedirectToAction("List_KH");
        }
        //--------------------------AD----------------------------
        public ActionResult List_AD()
        {
            var lista = db.AdminSaches.ToList();
            return View(lista);
        }
        public ActionResult Detail_AD(int id)
        {
            AdminSach adminSach = db.AdminSaches.FirstOrDefault(a => a.MaAD == id);
            if (adminSach == null)
            {
                return HttpNotFound();
            }
            return View(adminSach);
        }

        public ActionResult Delete_AD(int id)
        {
            var Admin = db.AdminSaches.FirstOrDefault(s => s.MaAD == id);
            db.AdminSaches.DeleteOnSubmit(Admin);
            db.SubmitChanges();
            return RedirectToAction("List_AD");
        }
    }
}