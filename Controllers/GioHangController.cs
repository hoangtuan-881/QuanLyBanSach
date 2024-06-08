using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QuanLyBanSach.Models;

namespace QuanLyBanSach.Controllers
{
    public class GioHangController : Controller
    {
        // GET: GioHang
        QLBanSachDataContext db = new QLBanSachDataContext();
        public List<GioHang> LayGioHang()
        {
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if (lstGioHang == null)
            {
                lstGioHang = new List<GioHang>();
                Session["GioHang"] = lstGioHang;
            }
            return lstGioHang;
        }
        public ActionResult ThemGioHang(int ms, string strURL)
        {
            List<GioHang> lstGioHang = LayGioHang();
            GioHang SanPham = lstGioHang.Find(sp => sp.iMaSach == ms);
            if (SanPham == null)
            {
                SanPham = new GioHang(ms);
                lstGioHang.Add(SanPham);
                return Redirect(strURL);
            }
            else
            {
                SanPham.iSoLuong++;
                return Redirect(strURL);
            }
        }

        public ActionResult ThemGioHangNoRedirect(int productId, int quantity)
        {
            // Lấy danh sách các sản phẩm đã thêm vào giỏ hàng từ Session, nếu Session chưa được khởi tạo, tạo mới
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int> ?? new Dictionary<int, int>();

            // Nếu sản phẩm đã có trong giỏ hàng, tăng số lượng; nếu chưa, thêm mới
            if (cart.ContainsKey(productId))
            {
                cart[productId] += quantity;
            }
            else
            {
                cart[productId] = quantity;
            }

            // Lưu lại danh sách giỏ hàng vào Session
            Session["Cart"] = cart;
            
            // Trả về số lượng sản phẩm trong giỏ hàng
            int cartCount = cart.Values.Sum();
            return Json(new { success = true, cartCount = cartCount });
        }

        public ActionResult GetCount()
        {
            // Lấy danh sách các sản phẩm đã thêm vào giỏ hàng từ Session, nếu Session chưa được khởi tạo, tạo mới
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int> ?? new Dictionary<int, int>();
            // Trả về số lượng sản phẩm trong giỏ hàng
            int cartCount = cart.Values.Sum();
            return Json(new { success = true, cartCount = cartCount });
        }

        public ActionResult GetCart()
        {
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int> ?? new Dictionary<int, int>();

            List<GioHang> cartItems = new List<GioHang>();

            foreach (var item in cart)
            {
                int productId = item.Key;
                int quantity = item.Value;

                // Thay thế GetProductById bằng phương thức của bạn để lấy thông tin chi tiết về sản phẩm
                Sach product = db.Saches.Single(x => x.MaSach == item.Key);

                if (product != null)
                {
                    cartItems.Add(new GioHang
                    {
                        iMaSach = product.MaSach,
                        sTenSach = product.TenSach,
                        sAnhBia = product.AnhBia,
                        dDonGia = (double)product.GiaBan,
                        iSoLuong = quantity,
                    });
                }
            }

            return PartialView(cartItems);
        }

        private int TongSoLuong()
        {
            int tsl = 0;
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if (lstGioHang != null)
            {
                tsl = lstGioHang.Sum(sp => sp.iSoLuong);
            }
            return tsl;
        }
        private double TongThanhTien()
        {
            double ttt = 0;
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if (lstGioHang != null)
            {
                ttt += lstGioHang.Sum(sp => sp.dThanhTien);
            }
            return ttt;
        }
        public ActionResult GioHang()
        {
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("CuaHang", "Home");
            }
            List<GioHang> lstGioHang = LayGioHang();

            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongThanhTien = TongThanhTien();

            return View(lstGioHang);
        }
        public ActionResult GioHangPartial()
        {
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongThanhTien = TongThanhTien();
            return PartialView();
        }
        public ActionResult XoaGiohang(int id)
        {
            var cart = Session["Cart"] as Dictionary<int, int>;
            if (cart != null && cart.ContainsKey(id))
            {
                cart.Remove(id);
                Session["Cart"] = cart; // Lưu thay đổi sau khi xoá
            }

            return Json(new { success = true });
        }
        public ActionResult XoaGioHangAll()
        {
            Session["Cart"] = new Dictionary<int, int>(); // Tạo mới dictionary rỗng
            return Json(new { success = true });
        }
        public ActionResult CapNhatGioHang(int MaSP, FormCollection f)
        {
            List<GioHang> lstGioHang = LayGioHang();
            GioHang sp = lstGioHang.Single(s => s.iMaSach == MaSP);
            if (sp != null)
            {
                sp.iSoLuong = int.Parse(f["txtSoLuong"].ToString());
            }
            return RedirectToAction("GioHang", "GioHang");
        }

        [Authorize]
        public ActionResult DatHang()
        {
            // 1. Kiểm tra dữ liệu đơn hàng từ model
            if (ModelState.IsValid)
            {
                // 2. Lấy thông tin giỏ hàng từ Session
                Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int> ?? new Dictionary<int, int>();
                List<ChiTietDonHang> listChiTietDonHang = new List<ChiTietDonHang>();
                EntitySet<ChiTietDonHang> entitySetChiTietDonHang = new EntitySet<ChiTietDonHang>();

                // 3. Tạo đơn hàng mới
                DonHang donHang = new DonHang
                {
                    MaDH = db.DonHangs.Count(),
                    NgayDat = DateTime.Now,
                    MaKH = (int)Session["MaKH"], // Lấy thông tin từ model
                    TongTien = 0,
                    ChiTietDonHangs = entitySetChiTietDonHang,
                };

                // 4. Thêm chi tiết đơn hàng
                foreach (var item in cart)
                {
                    Sach product = db.Saches.Single(x => x.MaSach == item.Key);

                    if (product != null)
                    {
                        donHang.ChiTietDonHangs.Add(new ChiTietDonHang
                        {
                            MaSach = product.MaSach,
                            SL = item.Value,
                            TongGia = product.GiaBan * item.Value
                        });
                        donHang.TongTien += product.GiaBan * item.Value;
                    }
                }

                // 5. Lưu đơn hàng vào database
                db.DonHangs.InsertOnSubmit(donHang);
                db.SubmitChanges();

                // 6. Xoá giỏ hàng sau khi đặt hàng thành công
                Session["Cart"] = new Dictionary<int, int>();

                // 7. Chuyển hướng hoặc trả về kết quả thành công
                return RedirectToAction("Success", new { id = donHang.MaDH });
            }
            else
            {
                // Xử lý lỗi validation (nếu có)
                return View("Error");
            }
        }

        public ActionResult Success(int id)
        {
            var donHang = db.DonHangs.SingleOrDefault(x => x.MaDH == id);
            if (donHang == null)
            {
                return HttpNotFound();
            }
            return View(donHang);
        }
    }
}