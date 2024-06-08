using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuanLyBanSach.Models
{
    public class GioHang
    {
        QLBanSachDataContext db = new QLBanSachDataContext();
        public int iMaSach { get; set; }
        public string sTenSach { get; set; }
        public string sAnhBia { get; set; }
        public double dDonGia { get; set; }
        public int iSoLuong { get; set; }
        public double dThanhTien
        {
            get { return iSoLuong * dDonGia; }
        }
        public GioHang(int MaSach)
        {
            iMaSach = MaSach;
            Sach sach = db.Saches.Single(s => s.MaSach == iMaSach);
            sTenSach = sach.TenSach;
            sAnhBia = sach.AnhBia;
            dDonGia = double.Parse(sach.GiaBan.ToString());
            iSoLuong = 1;
        }

        public GioHang()
        {
        }

        public GioHang(int iMaSach, string sTenSach, string sAnhBia, double dDonGia, int iSoLuong)
        {
            this.iMaSach = iMaSach;
            this.sTenSach = sTenSach;
            this.sAnhBia = sAnhBia;
            this.dDonGia = dDonGia;
            this.iSoLuong = iSoLuong;
        }
    }
}