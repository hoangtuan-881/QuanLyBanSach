using System.Linq;
using System.Web.Mvc;
using System.Web.Security;
using QuanLyBanSach.Models;

namespace QuanLyBanSach.Controllers
{
    public class LoginController : Controller
    {
        QLBanSachDataContext db = new QLBanSachDataContext();

        // GET: Account/Login
        public ActionResult Login()
        {
            return View();
        }

        // POST: Account/Login
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = db.KhachHangs.FirstOrDefault(u => u.Email == model.Email && u.MatKhau == model.Password);
                if (user != null)
                {
                    Session["MaKH"] = user.MaKH;
                    // Tìm vai trò của người dùng từ bảng UserRole
                    var userRole = db.UserRoles.FirstOrDefault(r => r.MaKH == user.MaKH);
                    if (userRole != null && userRole.Role.TenRole == "Admin")
                    {
                        FormsAuthentication.SetAuthCookie(user.Email, model.RememberMe);
                        return RedirectToAction("AdminIndex", "Admin");
                    }
                    else
                    {
                        FormsAuthentication.SetAuthCookie(user.Email, model.RememberMe);
                        return RedirectToAction("Index", "Home");
                    }
                }
                ModelState.AddModelError("", "Email hoặc mật khẩu không đúng.");
            }
            return View(model);
        }

        // GET: Account/Register
        public ActionResult Register()
        {
            return View();
        }

        // POST: Account/Register
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = new KhachHang
                {
                    Email = model.Email,
                    MatKhau = model.Password
                };
                db.KhachHangs.InsertOnSubmit(user);
                db.SubmitChanges();
                FormsAuthentication.SetAuthCookie(user.Email, false);
                return RedirectToAction("Index", "Home");
            }
            return View(model);
        }

        // GET: Account/Logout
        [HttpGet]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }
    }
}
