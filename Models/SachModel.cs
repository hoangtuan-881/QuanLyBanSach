using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace QuanLyBanSach.Models
{
    public class SachModel
    {
        [Required]
        public string MaDM { get; set; }
        public IEnumerable<DanhMuc> DanhMucs { get; set; }

        [Required]
        public string MaNXB { get; set; }
        public IEnumerable<NhaXuatBan> NhaXuatBans { get; set; }

        [Required]
        public string TenSach { get; set; }

        [Required]
        public string DoiTuong { get; set; }

        [Required]
        public string Kho { get; set; }

        [Required]
        public int SoTrang { get; set; }

        [Required]
        public int TrongLuong { get; set; }

        [Required]
        public string DinhDang { get; set; }

        [Required]
        public decimal GiaBan { get; set; }

        public string MoTa { get; set; }

        [Required]
        public DateTime NgayCapNhat { get; set; }

        public HttpPostedFileBase AnhBia { get; set; }

        public SachModel(string tenSach, int soTrang, int trongLuong, string dinhDang, decimal giaBan, string moTa, DateTime ngayCapNhat, HttpPostedFileBase anhBia, int sLTon)
        {
            TenSach = tenSach;
            SoTrang = soTrang;
            TrongLuong = trongLuong;
            DinhDang = dinhDang;
            GiaBan = giaBan;
            MoTa = moTa;
            NgayCapNhat = ngayCapNhat;
            AnhBia = anhBia;
            SLTon = sLTon;
        }

        public SachModel()
        {
        }

        [Required]
        public int SLTon { get; set; }
    }
}