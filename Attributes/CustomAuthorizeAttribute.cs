using System;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using QuanLyBanSach.Models;

namespace QuanLyBanSach.Attributes
{
    public class CustomAuthorizeAttribute : AuthorizeAttribute
    {
        public string RolesName { get; set; }

        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            if (!httpContext.User.Identity.IsAuthenticated)
            {
                return false;
            }

            var userName = httpContext.User.Identity.Name;
            using (var db = new QLBanSachDataContext())
            {
                var user = db.KhachHangs.FirstOrDefault(u => u.Email == userName);
                if (user == null)
                {
                    return false;
                }

                var userRole = db.UserRoles.FirstOrDefault(r => r.MaKH == user.MaKH);
                if (userRole == null)
                {
                    return false;
                }

                return RolesName.Split(',').Any(role => role.Trim().Equals(userRole.Role.TenRole, StringComparison.InvariantCultureIgnoreCase));
            }
        }

        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            if (!filterContext.HttpContext.User.Identity.IsAuthenticated)
            {
                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Login", action = "Login" }));
            }
            else
            {
                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Home", action = "Index" }));
            }
        }
    }
}
