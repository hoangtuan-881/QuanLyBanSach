using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using QuanLyBanSach.Models;
using Newtonsoft.Json;
using System.Net.Http;

namespace QuanLyBanSach.Controllers
{
    public class SachApiController : ApiController
    {
        QLBanSachDataContext db = new QLBanSachDataContext();

        // GET: api/SachApi
        public HttpResponseMessage GetProducts()
        {
            var saches = db.Saches
                .Select(s => new {
                    s.TenSach,
                    s.SoTrang,
                    s.TrongLuong,
                    s.DinhDang,
                    s.GiaBan,
                    s.MoTa,
                    s.NgayCapNhat,
                    s.AnhBia,
                    s.SLTon
                })
                .ToList();

            var response = Request.CreateResponse(System.Net.HttpStatusCode.OK, saches);
            response.Content = new StringContent(JsonConvert.SerializeObject(saches), System.Text.Encoding.UTF8, "application/json");

            return response;
        }

        // GET: api/SachApi/5
        public HttpResponseMessage GetProduct(int id)
        {
            var sach = db.Saches.SingleOrDefault(x => x.MaSach == id);

            if (sach == null)
            {
                return Request.CreateResponse(System.Net.HttpStatusCode.BadRequest);
            }

            var sachDTO = new
            {
                sach.TenSach,
                sach.SoTrang,
                sach.TrongLuong,
                sach.DinhDang,
                sach.GiaBan,
                sach.MoTa,
                sach.NgayCapNhat,
                sach.AnhBia,
                sach.SLTon
            };


            var response = Request.CreateResponse(System.Net.HttpStatusCode.OK, sachDTO);
            response.Content = new StringContent(JsonConvert.SerializeObject(sachDTO), System.Text.Encoding.UTF8, "application/json");

            return response;
        }
    }
}