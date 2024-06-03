Create database QL_BanSach
use QL_BanSach

create table DanhMuc
(
	MaDM char(4) NOT NULL,
	TenDM nvarchar(50),
	constraint PK_DanhMuc primary key(MaDM),
);
create table AdminSach
(
	MaAD int identity(1,1) NOT NULL,
	TenAD nvarchar(50),
	TaiKhoan varchar(50),
	MatKhau nvarchar(50),
	constraint PK_AdminSach primary key(MaAD),
);
create table NhaXuatBan
(
	MaNXB char(5) NOT NULL,
	TenNXB nvarchar(100),
	DiaChi nvarchar(100),
	DienThoai char(20),
	constraint PK_NhaXuatBan primary key(MaNXB),
);
create table KhachHang
(
	MaKH int identity(1,1) NOT NULL,
	HoTen nvarchar(50),
	NgaySinh datetime,
	GioiTinh nvarchar(3),
	DienThoai char(10),
	TaiKhoan varchar(50),
	MatKhau nvarchar(50),
	Email varchar(50),
	DiaChi nvarchar(50),
	AnhBia char(20),
	constraint PK_KhachHang primary key(MaKH),
);
create table TacGia
(
	MaTG int identity(1,1) NOT NULL,
	TenTG nvarchar(100),
	DienThoai char(10),
	TieuSu nvarchar(50),
	DiaChi nvarchar(50),
	constraint PK_TacGia primary key(MaTG),
);
create table DonHang
(
	MaDH int NOT NULL,
	MaKH int NOT NULL,
	NgayDat datetime,
	TongTien money,
	constraint PK_DonHang primary key(MaDH),
	constraint FK_DonHang_KhachHang foreign key(MaKH) references KhachHang(MaKH),
);
create table Sach
(
	MaSach int identity(1,1) NOT NULL,
	MaDM char(4) NOT NULL,
	MaNXB char(5) NOT NULL,
	TenSach nvarchar(100),
	DoiTuong nvarchar(35),
	Kho varchar(20),
	SoTrang int,
	TrongLuong int,
	DinhDang nvarchar(15),
	GiaBan money,
	MoTa nvarchar (Max),
	NgayCapNhat datetime,
	AnhBia char(20),
	SLTon int,
	constraint PK_Sach primary key(MaSach),
	constraint FK_Sach_DanhMuc foreign key(MaDM) references DanhMuc(MaDM),
	constraint FK_Sach_NhaXuatBan foreign key(MaNXB) references NhaXuatBan(MaNXB),
);
create table ChiTietTacGia
(
	MaSach int NOT NULL,
	MaTG int NOT NULL,
	constraint PK_ChiTietTacGia primary key(MaSach, MaTG),
	constraint FK_ChiTietTacGia_TacGia foreign key(MaTG) references TacGia(MaTG),
	constraint FK_ChiTietTacGia_Sach foreign key(MaSach) references Sach(MaSach),
);
create table ChiTietDonHang
(
	MaDH int NOT NULL,
	MaSach int NOT NULL,
	SL int,
	TongGia money,
	constraint PK_ChiTietDonHang primary key(MaSach, MaDH),
	constraint FK_ChiTietDonHang_DonHang foreign key(MaDH) references DonHang(MaDH),
	constraint FK_ChiTietDonHang_Sach foreign key(MaSach) references Sach(MaSach),
);
CREATE TABLE Role (
    MaRole int identity(1,1) NOT NULL,
    TenRole nvarchar(50) NOT NULL,
    MoTa nvarchar(255),
    CONSTRAINT PK_Role PRIMARY KEY (MaRole)
);
CREATE TABLE UserRole (
    MaKH int NOT NULL,
    MaRole int NOT NULL,
    CONSTRAINT FK_UserRole_KhachHang FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    CONSTRAINT FK_UserRole_Role FOREIGN KEY (MaRole) REFERENCES Role(MaRole),
    PRIMARY KEY (MaKH, MaRole)
);


INSERT INTO DanhMuc
Values
	('DM01', N'Lịch sử, Truyền thống'),
	('DM02', N'Văn học Việt Nam'),
	('DM03', N'Văn học Nước Ngoài'),
	('DM04', N'Kiến thức, Khoa học'),
	('DM05', N'Truyện tranh'),
	('DM06', N'Manga - Comic'),
	('DM07', N'Giải mã bản thân'),
	('DM08', N'Dành cho cha mẹ');
INSERT INTO AdminSach (TenAD, TaiKhoan, MatKhau)
VALUES
    (N'Admin 1', 'admin1', 'password1'),
    (N'Admin 2', 'admin2', 'password2'),
    (N'Admin 3', 'admin3', 'password3'),
    (N'Admin 4', 'admin4', 'password4'),
    (N'Admin 5', 'admin5', 'password5');
insert into NhaXuatBan
values
	('NXB01', N'Kim Đồng', N'Số 55 Quang Trung, Nguyễn Du, Hai Bà Trưng, Hà Nội', '(+84) 1900571595'),
	('NXB02', N'Nhã Nam', N'Số 59, Đỗ Quang, Trung Hoà, Cầu Giấy, Hà Nội.', '0903244248'),
	('NXB03', N'Đại học Quốc Gia Hà Nội', N'16 Hàng Chuối, Phạm Đình Hổ, Hai Bà Trưng, Hà Nội', '024 3971 4896'),
	('NXB04', N'Lao Động', N'Số 97 Trần Quốc Toản, Phường Trần Hưng Đạo, Quận Hoàn Kiếm, Hà Nội', '024 3851 5380'),
	('NXB05', N'Giáo Dục Việt Nam', N'Số 81 Trần Hưng Đạo, Hoàn Kiếm, Hà Nội', '024 3822 0801'),
	('NXB06', N'Tổng Hợp Thành Phố Hồ Chí Minh', N'62 Nguyễn Thị Minh Khai, Phường Đa Kao, Quận 1, TP HCM', '028 3825 6804');
INSERT INTO KhachHang (HoTen, NgaySinh, GioiTinh, DienThoai, TaiKhoan, MatKhau, Email, DiaChi, AnhBia)
VALUES
    (N'Trần Văn A', '2000-01-01', N'Nam', '0123456789', 'user1', 'password1', 'user1@example.com', N'Hà Nội','1000000001.jpg'),
    (N'Nguyễn Thị B', '1995-05-15', N'Nữ', '0987654321', 'user2', 'password2', 'user2@example.com', N'Hồ Chí Minh','1000000002.jpg'),
    (N'Lê Văn C', '1988-12-10', N'Nam', '0369845127', 'user3', 'password3', 'user3@example.com', N'Đà Nẵng','1000000003.jpg'),
    (N'Phạm Thị D', '1992-09-20', N'Nữ', '0321654987', 'user4', 'password4', 'user4@example.com', N'Hải Phòng','1000000004.jpg'),
    (N'Huỳnh Văn E', '1998-03-25', N'Nam', '0765432198', 'user5', 'password5', 'user5@example.com', N'Cần Thơ','1000000005.jpg'),
    (N'Võ Thị F', '1990-07-08', N'Nữ', '0852147963', 'user6', 'password6', 'user6@example.com', N'Bình Dương','1000000006.jpg'),
    (N'Đặng Văn G', '1997-11-30', N'Nam', '0541236987', 'user7', 'password7', 'user7@example.com', N'Đồng Nai','1000000007.jpg'),
    (N'Bùi Thị H', '1993-06-18', N'Nữ', '0635489721', 'user8', 'password8', 'user8@example.com', N'Vũng Tàu','1000000008.jpg'),
    (N'Nguyễn Văn I', '1985-02-14', N'Nam', '0978541236', 'user9', 'password9', 'user9@example.com', N'Quảng Ninh','1000000009.jpg'),
    (N'Trần Thị K', '1991-08-03', N'Nữ', '0963214875', 'user10', 'password10', 'user10@example.com', N'Bà Rịa - Vũng Tàu','1000000010.jpg'),
    (N'Lê Văn L', '1996-04-07', N'Nam', '0658741236', 'user11', 'password11', 'user11@example.com', N'Long An','1000000011.jpg'),
    (N'Hoàng Thị M', '1989-10-11', N'Nữ', '0378965412', 'user12', 'password12', 'user12@example.com', N'Tây Ninh','1000000012.jpg'),
    (N'Mai Văn N', '1994-07-19', N'Nam', '0987456321', 'user13', 'password13', 'user13@example.com', N'Tiền Giang','1000000013.jpg'),
    (N'Đinh Thị O', '1999-05-28', N'Nữ', '0345968214', 'user14', 'password14', 'user14@example.com', N'Bình Thuận','1000000014.jpg'),
    (N'Phan Văn P', '1987-11-09', N'Nam', '0758963142', 'user15', 'password15', 'user15@example.com', N'Lào Cai','1000000015.jpg'),
    (N'Trương Thị Q', '1990-08-12', N'Nữ', '0632147859', 'user16', 'password16', 'user16@example.com', N'Lạng Sơn','1000000016.jpg'),
    (N'Vũ Văn R', '1986-03-17', N'Nam', '0978456321', 'user17', 'password17', 'user17@example.com', N'Sơn La','1000000017.jpg'),
    (N'Ngô Thị S', '1993-01-24', N'Nữ', '0857421963', 'user18', 'password18', 'user18@example.com', N'Hà Giang','1000000018.jpg'),
    (N'Hoàng Văn T', '1988-12-05', N'Nam', '0945621738', 'user19', 'password19', 'user19@example.com', N'Hòa Bình','1000000019.jpg'),
    (N'Đào Thị U', '1997-09-14', N'Nữ', '0321547896', 'user20', 'password20', 'user20@example.com', N'Phú Thọ','1000000020.jpg');
INSERT INTO Role (TenRole, MoTa)
VALUES
    (N'Admin', N'Quản lý tất cả các chức năng trong hệ thống'),
    (N'Seller', N'Quản lý bán hàng, tạo hóa đơn, quản lý khách hàng')
INSERT INTO UserRole (MaKH, MaRole)
VALUES
    (1, 1), -- Khách hàng 1 có vai trò Quản trị viên
    (2, 2) -- Khách hàng 2 có vai trò Nhân viên bán hàng
INSERT INTO TacGia (TenTG, DienThoai, TieuSu, DiaChi)
VALUES
    (N'Nguyễn Như Mai', '0123456789', N'Tiểu sử của Nguyễn Như Mai', N'Địa chỉ của Nguyễn Như Mai'),
    (N'Nguyễn Quốc Tín', '0987654321', N'Tiểu sử của Nguyễn Quốc Tín', N'Địa chỉ của Nguyễn Quốc Tín'),
    (N'Nguyễn Huy Thắng', '0369845127', N'Tiểu sử của Nguyễn Huy Thắng', N'Địa chỉ của Nguyễn Huy Thắng'),
    (N'Nam Cao', '0321654987', N'Tiểu sử của Nam Cao', N'Địa chỉ của Nam Cao'),
    (N'Nguyễn Thánh Ngã', '0765432198', N'Tiểu sử của Nguyễn Thánh Ngã', N'Địa chỉ của Nguyễn Thánh Ngã'),
    (N'Hân Phạm', '0852147963', N'Tiểu sử của Hân Phạm', N'Địa chỉ của Hân Phạm'),
    (N'Nonchan', '0541236987', N'Tiểu sử của Nonchan', N'Địa chỉ của Nonchan'),
    (N'Đoàn Vị Thượng', '0635489721', N'Tiểu sử của Đoàn Vị Thượng', N'Địa chỉ của Đoàn Vị Thượng'),
    (N'Mai Quyên', '0978541236', N'Tiểu sử của Mai Quyên', N'Địa chỉ của Mai Quyên'),
    (N'Flowerliti', '0963214875', N'Tiểu sử của Flowerliti', N'Địa chỉ của Flowerliti'),
    (N'Nguyễn Thành Long', '0658741236', N'Tiểu sử của Nguyễn Thành Long', N'Địa chỉ của Nguyễn Thành Long'),
    (N'Lisa Thompson', '0378965412', N'Tiểu sử của Lisa Thompson', N'Địa chỉ của Lisa Thompson'),
    (N'Đặng Thị Hoài Thư', '0987456321', N'Tiểu sử của Đặng Thị Hoài Thư', N'Địa chỉ của Đặng Thị Hoài Thư'),
    (N'Bôn Đông Huân', '0345968214', N'Tiểu sử của Bôn Đông Huân', N'Địa chỉ của Bôn Đông Huân'),
    (N'Yên Yên', '0758963142', N'Tiểu sử của Yên Yên', N'Địa chỉ của Yên Yên'),
    (N'Vũ Thị Huyền Trang', '0632147859', N'Tiểu sử của Vũ Thị Huyền Trang', N'Địa chỉ của Vũ Thị Huyền Trang'),
    (N'Asia Citro', '0978456321', N'Tiểu sử của Asia Citro', N'Địa chỉ của Asia Citro'),
    (N'Marion Lindsay', '0857421963', N'Tiểu sử của Marion Lindsay', N'Địa chỉ của Marion Lindsay'),
    (N'George MacDonald', '0945621738', N'Tiểu sử của George MacDonald', N'Địa chỉ của George MacDonald'),
    (N'Nhiều tác giả', '0123456789', N'Tiểu sử của Nhiều tác giả', N'Địa chỉ của Nhiều tác giả'),
    (N'Cùng tác giả', '0987654321', N'Tiểu sử của Cùng tác giả', N'Địa chỉ của Cùng tác giả'),
    (N'Phạm Ngọc Tuấn', '0369845127', N'Tiểu sử của Phạm Ngọc Tuấn', N'Địa chỉ của Phạm Ngọc Tuấn'),
    (N'Hiếu Minh', '0321654987', N'Tiểu sử của Hiếu Minh', N'Địa chỉ của Hiếu Minh'),
    (N'Nguyễn Công Hoan', '0765432198', N'Tiểu sử của Nguyễn Công Hoan', N'Địa chỉ của Nguyễn Công Hoan'),
    (N'Hồng Hà', '0852147963', N'Tiểu sử của Hồng Hà', N'Địa chỉ của Hồng Hà'),
    (N'Bùi Lâm Bằng', '0541236987', N'Tiểu sử của Bùi Lâm Bằng', N'Địa chỉ của Bùi Lâm Bằng'),
    (N'Hồ Quảng', '0635489721', N'Tiểu sử của Hồ Quảng', N'Địa chỉ của Hồ Quảng'),
    (N'Tạ Thúc Bình', '0978541236', N'Tiểu sử của Tạ Thúc Bình', N'Địa chỉ của Tạ Thúc Bình'),
    (N'Lê Minh Hải', '0658741236', N'Tiểu sử của Lê Minh Hải', N'Địa chỉ của Lê Minh Hải'),
    (N'Ngô Mạnh Lân', '0378965412', N'Tiểu sử của Ngô Mạnh Lân', N'Địa chỉ của Ngô Mạnh Lân'),
    (N'Thảo Hương', '0987456321', N'Tiểu sử của Thảo Hương', N'Địa chỉ của Thảo Hương'),
    (N'Akagishi K', '0345968214', N'Tiểu sử của Akagishi K', N'Địa chỉ của Akagishi K'),
    (N'Ren Eguchi', '0758963142', N'Tiểu sử của Ren Eguchi', N'Địa chỉ của Ren Eguchi'),
    (N'Masa', '0632147859', N'Tiểu sử của Masa', N'Địa chỉ của Masa'),
    (N'Natsu Hyuuga', '0978456321', N'Tiểu sử của Natsu Hyuuga', N'Địa chỉ của Natsu Hyuuga'),
    (N'Touco Shino', '0857421963', N'Tiểu sử của Touco Shino', N'Địa chỉ của Touco Shino'),
    (N'Itsuki Nanao', '0945621738', N'Tiểu sử của Itsuki Nanao', N'Địa chỉ của Itsuki Nanao'),
    (N'Nekokurage', '0123456789', N'Tiểu sử của Nekokurage', N'Địa chỉ của Nekokurage'),
    (N'Nguyễn Thanh Hải', '0987654321', N'Tiểu sử của Nguyễn Thanh Hải', N'Địa chỉ của Nguyễn Thanh Hải'),
    (N'Coline Pierré', '0369845127', N'Tiểu sử của Coline Pierré', N'Địa chỉ của Coline Pierré'),
    (N'Loic Froissart', '0321654987', N'Tiểu sử của Loic Froissart', N'Địa chỉ của Loic Froissart'),
    (N'Đạm Phương Nữ Sử', '0765432198', N'Tiểu sử của Đạm Phương Nữ Sử', N'Địa chỉ của Đạm Phương Nữ Sử'),
    (N'Arimoto Hidefumi', '0852147963', N'Tiểu sử của Arimoto Hidefumi', N'Địa chỉ của Arimoto Hidefumi'),
    (N'Koshimizu Kaori', '0541236987', N'Tiểu sử của Koshimizu Kaori', N'Địa chỉ của Koshimizu Kaori'),
    (N'Urako Kanamori', '0635489721', N'Tiểu sử của Urako Kanamori', N'Địa chỉ của Urako Kanamori'),
    (N'Sun Li', '0978541236', N'Tiểu sử của Sun Li', N'Địa chỉ của Sun Li'),
    (N'Phan Linh', '0658741236', N'Tiểu sử của Phan Linh', N'Địa chỉ của Phan Linh'),
    (N'Lê Minh Quốc', '0378965412', N'Tiểu sử của Lê Minh Quốc', N'Địa chỉ của Lê Minh Quốc'),
    (N'Nguyễn Thị Thu', '0987456321', N'Tiểu sử của Nguyễn Thị Thu', N'Địa chỉ của Nguyễn Thị Thu'),
    (N'Luo Yijun', '0345968214', N'Tiểu sử của Luo Yijun', N'Địa chỉ của Luo Yijun'),
    (N'Evelien van Dort', '0758963142', N'Tiểu sử của Evelien van Dort', N'Địa chỉ của Evelien van Dort');
INSERT INTO Sach (MaDM, MaNXB, TenSach, DoiTuong, Kho, SoTrang, TrongLuong, DinhDang, GiaBan, MoTa, NgayCapNhat, AnhBia, SLTon)
VALUES 
-- DM01, NXB01
('DM01', 'NXB01', N'Chuyện Hay Sử Việt - Thời Cổ - Không Chỉ Là Huyền Sử', N'Nhi đồng', 'A4', 75, 75, N'bìa cứng', 90000, N'Lịch sử đất nước đã trải qua hàng nghìn năm với biết bao thời khắc huy hoàng và bi tráng. Bộ sách Chuyện Hay Sử Việt sẽ dẫn dắt bạn đọc đi ngược dòng thời gian, thông qua những sự kiện hào hùng, câu chuyện về những nhân vật được ghi trong chính sử và cả các huyền tích, giai thoại lưu truyền trong dân gian.Thời Cổ - Không Chỉ Là Huyền Sử khắc họa bức tranh về thuở bình minh của dân tộc Việt với sự giao thoa giữa hiện thực và huyền ảo, giữa chứng tích khảo cổ với truyền thuyết dân gian.Cùng với những minh họa sống động, gần gũi, đời sống của người xưa, bộ sách Chuyện Hay Sử Việt làm sống dậy những suy nghĩ và tình cảm, mưu cầu và khát khao của họ trên từng trang sách, giúp các bạn trẻ hiểu rõ hơn về chặng đường quá khứ mà ông cha ta đã đi qua và góp phần tăng thêm lòng tự hào dân tộc, thêm yêu lịch sử nước nhà và có ý thức hơn về trách nhiệm đối với đất nước.', '2024-05-11', '0000000001.jpg', 10),
('DM01', 'NXB01', N'Chuyện Hay Sử Việt - Thời Bắc Thuộc - Cuộc Kháng Cự Ngàn Năm', N'Nhi đồng', 'A4', 100, 100, N'bìa mềm', 80000, N'Lịch sử đất nước đã trải qua hàng nghìn năm với biết bao thời khắc huy hoàng và bi tráng. Bộ sách Chuyện Hay Sử Việt sẽ dẫn dắt bạn đọc đi ngược dòng thời gian, thông qua những sự kiện hào hùng, câu chuyện về những nhân vật được ghi trong chính sử và cả các huyền tích, giai thoại lưu truyền trong dân gian. Thời Bắc Thuộc – Cuộc Kháng Cự Ngàn Năm tái hiện một giai đoạn đau thương mà hào hùng khi nước ta chịu sự đô hộ kéo dài của kẻ xâm lược phương Bắc. Nhưng nhờ những gương mặt anh hùng như Hai Bà Trưng, Bà Triệu, Lí Nam Đế, Dương Đình Nghệ, Phùng Hưng…, mưu kế của thực dân phương Bắc không thể đạt thành.Cùng với những minh họa sống động, gần gũi, đời sống của người xưa, bộ sách Chuyện Hay Sử Việt làm sống dậy những suy nghĩ và tình cảm, mưu cầu và khát khao của họ trên từng trang sách, giúp các bạn trẻ hiểu rõ hơn về chặng đường quá khứ mà ông cha ta đã đi qua và góp phần tăng thêm lòng tự hào dân tộc, thêm yêu lịch sử nước nhà và có ý thức hơn về trách nhiệm đối với đất nước.', '2024-05-11', '0000000002.jpg', 10),
('DM01', 'NXB01', N'Chuyện Hay Sử Việt - Thời Kì Đầu Độc Lập - Khai Mở Nền Tự Chủ', N'Nhi đồng', 'A4', 120, 120, N'bìa cứng', 95000, N'Lịch sử đất nước đã trải qua hàng nghìn năm với biết bao thời khắc huy hoàng và bi tráng. Bộ sách Chuyện Hay Sử Việt sẽ dẫn dắt bạn đọc đi ngược dòng thời gian, thông qua những sự kiện hào hùng, câu chuyện về những nhân vật được ghi trong chính sử và cả các huyền tích, giai thoại lưu truyền trong dân gian. Thời Kì Đầu Độc Lập – Khai Mở Nền Tự Chủ là cuộc gặp với các gương mặt danh nhân: Ngô Quyền, Đinh Bộ Lĩnh, Lê Hoàn… Những triều đại phong kiến sơ khai do họ dựng lên có vai trò khai mở cho nền độc lập tự chủ của Việt Nam. Cùng với những minh họa sống động, gần gũi, đời sống của người xưa, bộ sách Chuyện Hay Sử Việt làm sống dậy những suy nghĩ và tình cảm, mưu cầu và khát khao của họ trên từng trang sách, giúp các bạn trẻ hiểu rõ hơn về chặng đường quá khứ mà ông cha ta đã đi qua và góp phần tăng thêm lòng tự hào dân tộc, thêm yêu lịch sử nước nhà và có ý thức hơn về trách nhiệm đối với đất nước.', '2024-05-11', '0000000003.jpg', 10),
('DM01', 'NXB01', N'Chuyện Hay Sử Việt - Nhà Lí - Xây Nền Văn Hiến Quốc Gia', N'Nhi đồng', 'A4', 85, 85, N'bìa mềm', 85000, N'Lịch sử đất nước đã trải qua hàng nghìn năm với biết bao thời khắc huy hoàng và bi tráng. Bộ sách Chuyện Hay Sử Việt sẽ dẫn dắt bạn đọc đi ngược dòng thời gian, thông qua những sự kiện hào hùng, câu chuyện về những nhân vật được ghi trong chính sử và cả các huyền tích, giai thoại lưu truyền trong dân gian. Nhà Lí - Xây Nền Văn Hiến Quốc Gia đưa chúng ta đến gặp tám vị vua (mà cũng có thể là chín) nhà Lí, với các sự kiện trọng đại như việc dời đô về Thăng Long, đặt tên nước là Đại Việt hay chiến thắng quân Tống trên sông Như Nguyệt. Cùng với những minh họa sống động, gần gũi, đời sống của người xưa, bộ sách Chuyện Hay Sử Việt làm sống dậy những suy nghĩ và tình cảm, mưu cầu và khát khao của họ trên từng trang sách, giúp các bạn trẻ hiểu rõ hơn về chặng đường quá khứ mà ông cha ta đã đi qua và góp phần tăng thêm lòng tự hào dân tộc, thêm yêu lịch sử nước nhà và có ý thức hơn về trách nhiệm đối với đất nước.', '2024-05-11', '0000000004.jpg', 10),
('DM01', 'NXB01', N'Chuyện Hay Sử Việt - Nhà Trần - Hào Khí Đông A', N'Nhi đồng', 'A4', 110, 110, N'bìa cứng', 70000, N'Lịch sử đất nước đã trải qua hàng nghìn năm với biết bao thời khắc huy hoàng và bi tráng. Bộ sách Chuyện Hay Sử Việt sẽ dẫn dắt bạn đọc đi ngược dòng thời gian, thông qua những sự kiện hào hùng, câu chuyện về những nhân vật được ghi trong chính sử và cả các huyền tích, giai thoại lưu truyền trong dân gian. Nhà Trần - Hào Khí Đông A đã ghi vào lịch sử nước nhà những trang hào hùng nhất với ba lần đánh thắng quân Nguyên – Mông. Hào khí này còn tiếp tục truyền đến đời Hậu Trần, khi nước ta bị quân xâm lược phương Bắc đô hộ. Cùng với những minh họa sống động, gần gũi, đời sống của người xưa, bộ sách Chuyện Hay Sử Việt làm sống dậy những suy nghĩ và tình cảm, mưu cầu và khát khao của họ trên từng trang sách, giúp các bạn trẻ hiểu rõ hơn về chặng đường quá khứ mà ông cha ta đã đi qua và góp phần tăng thêm lòng tự hào dân tộc, thêm yêu lịch sử nước nhà và có ý thức hơn về trách nhiệm đối với đất nước.', '2024-05-11', '0000000005.jpg', 10),
('DM01', 'NXB01', N'Chuyện Hay Sử Việt - Nhà Lê Sơ - Những Trang Sử Bi Hùng', N'Nhi đồng', 'A4', 140, 140, N'bìa mềm', 75000, N'Lịch sử đất nước đã trải qua hàng nghìn năm với biết bao thời khắc huy hoàng và bi tráng. Bộ sách Chuyện Hay Sử Việt sẽ dẫn dắt bạn đọc đi ngược dòng thời gian, thông qua những sự kiện hào hùng, câu chuyện về những nhân vật được ghi trong chính sử và cả các huyền tích, giai thoại lưu truyền trong dân gian. Nhà Lê Sơ – Những Trang Sử Bi Hùng bắt đầu bằng công cuộc chiến thắng giặc Minh của Lê Lợi. Đây là triều đại huy hoàng bậc nhất trong lịch sử nước ta. Chúng ta sẽ gặp ở đây vị vua hiền như Lê Thánh Tông, nhưng cuối triều đại cũng xuất hiện những vị hôn quân như Vua Quỷ, Vua Lợn. Cùng với những minh họa sống động, gần gũi, đời sống của người xưa, bộ sách Chuyện Hay Sử Việt làm sống dậy những suy nghĩ và tình cảm, mưu cầu và khát khao của họ trên từng trang sách, giúp các bạn trẻ hiểu rõ hơn về chặng đường quá khứ mà ông cha ta đã đi qua và góp phần tăng thêm lòng tự hào dân tộc, thêm yêu lịch sử nước nhà và có ý thức hơn về trách nhiệm đối với đất nước.', '2024-05-11', '0000000006.jpg', 10),
('DM01', 'NXB01', N'Chuyện Hay Sử Việt - Nhà Mạc Và Thời Lê Trịnh - Đất Nước Phân Li ', N'Nhi đồng', 'A4', 95, 95, N'bìa cứng', 60000, N'Lịch sử đất nước đã trải qua hàng nghìn năm với biết bao thời khắc huy hoàng và bi tráng. Bộ sách Chuyện Hay Sử Việt sẽ dẫn dắt bạn đọc đi ngược dòng thời gian, thông qua những sự kiện hào hùng, câu chuyện về những nhân vật được ghi trong chính sử và cả các huyền tích, giai thoại lưu truyền trong dân gian. Nhà Mạc Và Thời Lê - Trịnh - Đất Nước Phân Li là một thời kì đặc biệt, chứng kiến sự trị vì, giành giật lãnh thổ tranh chấp lẫn nhau của nhiều thế lực; sự tồn tại song song của Nam triều và Bắc triều, của cung vua và phủ chúa đồng nghĩa với việc đất nước rối ren và liên miên nội chiến. Cùng với những minh họa sống động, gần gũi, đời sống của người xưa, bộ sách Chuyện Hay Sử Việt làm sống dậy những suy nghĩ và tình cảm, mưu cầu và khát khao của họ trên từng trang sách, giúp các bạn trẻ hiểu rõ hơn về chặng đường quá khứ mà ông cha ta đã đi qua và góp phần tăng thêm lòng tự hào dân tộc, thêm yêu lịch sử nước nhà và có ý thức hơn về trách nhiệm đối với đất nước.', '2024-05-11', '0000000007.jpg', 10),
('DM01', 'NXB01', N'Chuyện Hay Sử Việt - Chúa Nguyễn Và Nhà Tây Sơn - Mở Mang Bờ Cõi, Nối Liền Bắc Nam', N'Nhi đồng', 'A4', 130, 130, N'bìa mềm', 65000, N'Lịch sử đất nước đã trải qua hàng nghìn năm với biết bao thời khắc huy hoàng và bi tráng. Bộ sách Chuyện Hay Sử Việt sẽ dẫn dắt bạn đọc đi ngược dòng thời gian, thông qua những sự kiện hào hùng, câu chuyện về những nhân vật được ghi trong chính sử và cả các huyền tích, giai thoại lưu truyền trong dân gian. Chúa Nguyễn Và Nhà Tây Sơn – Mở Mang Bờ Cõi, Nối Liền Bắc Nam đưa chúng ta đến gặp các chúa Nguyễn – những người mở cõi phương Nam để đất nước có được hình hài như ngày nay. Cùng với đó là nhà Nguyễn Tây Sơn, những người không chỉ lập chiến công hiển hách, đánh đuổi giặc ngoại xâm mà còn nối thông đất nước ta suốt từ Nam ra Bắc. Cùng với những minh họa sống động, gần gũi, đời sống của người xưa, bộ sách Chuyện Hay Sử Việt làm sống dậy những suy nghĩ và tình cảm, mưu cầu và khát khao của họ trên từng trang sách, giúp các bạn trẻ hiểu rõ hơn về chặng đường quá khứ mà ông cha ta đã đi qua và góp phần tăng thêm lòng tự hào dân tộc, thêm yêu lịch sử nước nhà và có ý thức hơn về trách nhiệm đối với đất nước.', '2024-05-11', '0000000008.jpg', 10),
('DM01', 'NXB01', N'Chuyện Hay Sử Việt - Nhà Nguyễn - Quốc Gia Thống Nhất', N'Nhi đồng', 'A4', 105, 105, N'bìa cứng', 55000, N'Lịch sử đất nước đã trải qua hàng nghìn năm với biết bao thời khắc huy hoàng và bi tráng. Bộ sách Chuyện Hay Sử Việt sẽ dẫn dắt bạn đọc đi ngược dòng thời gian, thông qua những sự kiện hào hùng, câu chuyện về những nhân vật được ghi trong chính sử và cả các huyền tích, giai thoại lưu truyền trong dân gian. Dưới thời nhà Nguyễn, nước ta chính thức có tên là Việt Nam. Nhưng trước sự thay đổi của thời đại, khi nhiều quốc gia tiến hành cải cách, phát triển vượt bậc, thì nhà Nguyễn lại duy trì một chính sách bảo thủ, trì trệ, triệt tiêu mọi cơ hội đổi mới đất nước. Họa mất nước cũng từ đó mà ra. Biến đổi lịch sử ấy diễn ra như thế nào? Mời chúng ta cùng đọc trong Nhà Nguyễn – Quốc Gia Thống Nhất! Cùng với những minh họa sống động, gần gũi, đời sống của người xưa, bộ sách Chuyện Hay Sử Việt làm sống dậy những suy nghĩ và tình cảm, mưu cầu và khát khao của họ trên từng trang sách, giúp các bạn trẻ hiểu rõ hơn về chặng đường quá khứ mà ông cha ta đã đi qua và góp phần tăng thêm lòng tự hào dân tộc, thêm yêu lịch sử nước nhà và có ý thức hơn về trách nhiệm đối với đất nước.', '2024-05-11', '0000000009.jpg', 10),
('DM01', 'NXB01', N'Chuyện Hay Sử Việt - Thời Cận Đại - Đông Tây Đối Đầu', N'Nhi đồng', 'A4', 75, 75, N'bìa mềm', 50000, N'Lịch sử đất nước đã trải qua hàng nghìn năm với biết bao thời khắc huy hoàng và bi tráng. Bộ sách Chuyện Hay Sử Việt sẽ dẫn dắt bạn đọc đi ngược dòng thời gian, thông qua những sự kiện hào hùng, câu chuyện về những nhân vật được ghi trong chính sử và cả các huyền tích, giai thoại lưu truyền trong dân gian. Thời Cận Đại – Đông Tây Đối Đầu khắc họa bối cảnh lịch sử khi Việt Nam nằm dưới sự đô hộ của thực dân Pháp. Các cuộc khởi nghĩa lần lượt nổ ra trên cả nước, dần dẫn đến sự hình thành các phong trào cách mạng. Hãy cùng tìm hiểu những trang sử bi thương nhưng cũng rất đáng tự hào trong cuốn sách này nhé! Cùng với những minh họa sống động, gần gũi, đời sống của người xưa, bộ sách Chuyện Hay Sử Việt làm sống dậy những suy nghĩ và tình cảm, mưu cầu và khát khao của họ trên từng trang sách, giúp các bạn trẻ hiểu rõ hơn về chặng đường quá khứ mà ông cha ta đã đi qua và góp phần tăng thêm lòng tự hào dân tộc, thêm yêu lịch sử nước nhà và có ý thức hơn về trách nhiệm đối với đất nước.', '2024-05-11', '0000000010.jpg', 10),
-- DM02, NXB01
('DM02', 'NXB01', N'Truyện ngắn Nam Cao', N'Thiếu niên', 'A4', 125, 125, N'bìa cứng', 180000, N'“Ngày nay, chúng ta thường hay quan tâm và luận bàn về tính hiện đại của tác phẩm văn học, về cái mới và khả năng thử thách với thời gian của chúng. Thế mà những tác phẩm của chúng ta vẫn bị cũ đi, bị người đọc lãng quên rất nhanh, không chịu được thử thách của thời gian như những cái Nam Cao đã viết ra. Vậy thì ở những tác phẩm của Nam Cao có cái gì khiến nó vẫn cứ mới mãi, được người đọc đọc mãi…”', '2024-05-11', '0000000011.jpg', 10),
('DM02', 'NXB01', N'Hạt bắp vỗ tay', N'Nhi đồng', 'A4', 85, 85, N'bìa mềm', 171000, N'Tuổi thơ là kho tàng vô giá của tâm hồn. Ở đó bé được ùa vào lòng ông bà cha mẹ, chơi đùa cùng các con vật đáng yêu, sống với thanh âm trong trẻo và cảnh sắc tươi đẹp của xứ sở. Những điều ấy càng tuyệt vời hơn trong khung cảnh vùng đất Tây Nguyên độc đáo, với tiếng khèn lá và tiếng đàn trưng, với nhà sàn và buôn làng, với ánh mắt cha mẹ dõi theo bé băng qua rừng núi để đi học...
Ai cũng có nơi chốn để quay về, đó là quê hương của riêng mình. Ai cũng có khoảng thời gian trong đời để ước mong trở lại, đó là tuổi thơ yêu dấu. Cùng lật mở từng trang thơ Hạt bắp vỗ tay và bắt đầu hành trình khám phá một miền tuổi thơ kì thú, bạn nhé', '2024-05-11', '0000000012.jpg', 10),
('DM02', 'NXB01', N'Cháu là cổ tích', N'Nhi đồng', 'A4', 115, 115, N'bìa cứng', 203000, N'Thế giới của trẻ thơ là xứ sở nghìn lẻ một chuyện kể. Nơi trái ớt hóa nụ cười, mặt trăng là trái thị, dấu hỏi thành ông lão khom lưng, vịt bầu cũng đi học, còn nắng thì mê chơi lò cò… Tập thơ Cháu là cổ tích chứa đầy những câu chuyện nhỏ xinh, hóm hỉnh và bay bổng. Nghe hết một chuyện, ta càng háo hức muốn nghe chuyện tiếp theo. Và khi khép lại câu chuyện sau cùng, ta thấy mình hạnh phúc như được lim dim trong lời ru yên ả và tình thương dịu ngọt. Tuổi thơ tuyệt vời đến thế vì tuổi thơ là câu chuyện thần tiên đẹp nhất trên đời.', '2024-05-11', '0000000013.jpg', 10),
('DM02', 'NXB01', N'Chú dế đêm trăng', N'Nhi đồng', 'A4', 130, 130, N'bìa mềm', 121000, N'Thiên nhiên, tình yêu và hạnh phúc luôn ở quanh ta. Không cần đi đâu xa, bé hãy nhìn qua khung cửa sổ, ngước lên vòm trời, thủ thỉ với mẹ cha trong vòng tay ấm, bé sẽ thấy mình là người hạnh phúc nhất thế gian. Chú dế đêm trăng là những cung bậc cảm xúc của một em bé tràn đầy tin cậy và yêu thương, luôn quan sát thế giới bằng đôi mắt trong veo.
Nào, hãy lật mở quyển sách xinh xắn này, đọc từng câu thơ đáng yêu và cùng ngắm vạn vật qua mắt nhìn bay bổng của trẻ thơ, bạn nhé!', '2024-05-11', '0000000014.jpg', 10),
('DM02', 'NXB01', N'Lặng lẽ Sa Pa', N'Tuổi mới lớn', 'A4', 80, 80, N'bìa cứng', 222000, N'Cuốn sách tuyển chọn các tác phẩm đặc sắc của nhà văn Nguyễn Thành Long Lặng lẽ Sa Pa, Giữa trong xanh, Núi Đỗ Quyên, Cái gốc, Đà Lạt hoa hương, Lý Sơn mùa tỏi, Hạnh Nhơn, Chuyện tình trên cù lao xanh, Chim đã cất cánh, Sáng mai nào, xế chiều nào. Nguyễn Thành Long, từ trước tới nay, qua các tác phẩm của mình, đã cho ta thấy rõ hơn những thuận lợi của ông trong khai thác vỉa sống. Ông có những ngày qua thiết tha nhất, chưa lí trí lắm nhưng chằng chịt những khắc họa sâu sắc. Mỗi truyện ngắn của Nguyễn Thành Long tương tự như một trang đời, một mảng, một nét của cuộc sống chắt ra. - Nhà văn TÔ HOÀI Trong ý nghĩ của một số người chúng tôi hồi ấy, Nguyễn Thành Long là nhà văn vừa có vốn liếng thực tế, vừa có học, lại có tấm lòng đôn hậu. Tài năng của anh là do công phu rèn luyện mà nên, có vẻ nó như một thứ tài có thể cố mà được nên chúng tôi càng thấy gần. - Nhà phê bình Văn học VƯƠNG TRÍ NHÀN Nhằm giúp các bạn học sinh có một nền tảng kiến thức văn học phong phú, vững vàng, Nhà xuất bản Kim Đồng tổ chức biên soạn bộ sách Văn học trong nhà trường, với sự tham gia biên soạn, tuyển chọn, bình giảng của các chuyên gia uy tín trong lĩnh vực này. Ngoài giá trị tư liệu học tập, bộ sách còn giúp bồi dưỡng thêm tình yêu văn học, khích lệ tư duy sáng tạo giúp người đọc có được cho mình những nhận định khách quan và hợp lí', '2024-05-11', '0000000015.jpg', 10),
('DM02', 'NXB01', N'Nhóc Cá Vàng', N'Thiếu niên', 'A4', 105, 105, N'bìa mềm', 164000, N'Matthew Corbin mới 12 tuổi, sống cùng bố mẹ ở căn nhà số 9 trong ngõ Hạt Dẻ. Cậu mang nỗi ám ảnh với vi khuẩn và số 13 xui xẻo. Đã nhiều tuần, Matthew giam mình trong phòng, liên tục lau chùi và chỉ trò chuyện với Sư Tử Dán Tường về những gì cậu âm thầm quan sát được qua cửa sổ. Một ngày nọ, bé Teddy ở nhà số 11 đột ngột biến mất, và Matthew là người cuối cùng nhìn thấy đứa trẻ. Lòng trắc ẩn, trí tò mò cũng như cảm giác có trách nhiệm vì là người am hiểu khu phố nhất đã thôi thúc cậu bắt tay vào điều tra vụ mất tích... Nhóc Cá Vàng hướng đến nhiều đối tượng độc giả, là sự hòa trộn hoàn hảo, cân bằng, vừa xoay quanh những vấn đề nóng hổi, vừa thú vị, hấp dẫn. - Tạp chí phê bình sách KIRKUS (Mĩ) ', '2024-05-11', '0000000016.jpg', 10),
('DM02', 'NXB01', N'Bạn có thích làm mèo?', N'Thiếu niên', 'A4', 140, 140, N'bìa cứng', 237000, N'Nếu coi như tất cả mọi người đều thích mèo, thì thích LÀM mèo lại là chuyện hoàn toàn khác.
Dương là một cô bé yêu mèo, cũng muốn trở thành mèo để ăn và ngủ thoải mái.
Điều gì sẽ xảy ra nếu mong ước của cô trở thành sự thật?
TÁC PHẨM DỰ GIẢI THƯỞNG VĂN HỌC KIM ĐỒNG LẦN THỨ NHẤT 2023-2025 ', '2024-05-11', '0000000017.jpg', 10),
('DM02', 'NXB01', N'Cậu bé Bi Đất (Bụng Tròn Chứa Đầy Niềm Tin!)', N'Nhi đồng', 'A4', 90, 90, N'bìa mềm', 161000, N'Bi Đất lưu lạc từ khi mới chào đời trong một thế giới đang chết dần vì bị loài Hai Chân khai thác đến kiệt quệ.
Được ông Mặt Trời cử Nắng đến đưa về nhà, thì bố Cục Đất và mẹ Giọt Nước đã qua đời. Cậu tuy còn nhỏ tuổi nhưng đã gánh vác sự nghiệp của bố mẹ để lại, là chăm sóc Ngôi nhà xanh nghìn cửa sổ, nơi cưu mang các loài sinh vật bị mất môi trường sống, đành phải di cư…
Trong khi đó, con quái vật Sa mạc hóa vẫn ngày đêm tiếp cận Khu Rừng Niềm Tin.', '2024-05-11', '0000000018.jpg', 10),
('DM02', 'NXB01', N'Lạc khỏi ngân hà', N'Nhi đồng', 'A4', 120, 120, N'bìa cứng', 266000, N'Có một vì sao nọ, chẳng may bị rơi khỏi sông Ngân. Xuống Trái Đất, vượt qua những bỡ ngỡ ban đầu, vì sao đã trở thành một thành viên thật sự của hành tinh xanh, gần gụi với những công việc thật trần gian như chăm em, giải cứu san hô, cứu cá ngừ, hoặc đơn giản được là chính mình: thắp sáng!
“– Cháu mắc kẹt ở đây! – Nó đá đá chân, túc tắc lựa lời.
– Cậu đang sống ở đây! – Bác bọ ngựa chỉnh lại.”
“Tới một ngày, trong lòng Vi Vu chốt hạ một quyết định (như đinh đóng cột) rằng nó sẽ thôi hỏi, không có hỏi ai nữa. Rằng nó sẽ sống thiệt tốt ở nơi nào còn cần nó chiếu sáng.”
TÁC PHẨM DỰ GIẢI THƯỞNG VĂN HỌC KIM ĐỒNG LẦN THỨ NHẤT 2023-2025 ', '2024-05-11', '0000000019.jpg', 10),
('DM02', 'NXB01', N'Những đám mây ngoan', N'Nhi đồng', 'A4', 95, 95, N'bìa mềm', 254000, N'Mỗi đứa trẻ đều có một câu chuyện để kể về tuổi thơ mình. Có câu chuyện thật đáng yêu của những đám mây ngoan, thật ấm áp như vệt nắng sân trường, có câu chuyện cảm động sâu lắng của vạt cúc vạn thọ, xót xa trìu mến của bông hoa đào nở trên vai...
Thấp thoáng trong những câu chuyện đó luôn là hình ảnh người mẹ. Có người mẹ tảo tần sớm hôm nuôi con khôn lớn, hi sinh cả thân thể mình vì con, nhưng cũng có người mẹ đã bỏ lại con mình... Cho dù thế nào, chắc chắn rằng, những đứa trẻ sẽ mang theo hình ảnh họ suốt cuộc đời.
TÁC PHẨM DỰ GIẢI THƯỞNG VĂN HỌC KIM ĐỒNG LẦN THỨ NHẤT 2023-2025 ', '2024-05-11', '0000000020.jpg', 10),
-- DM03, NXB01
('DM03', 'NXB01', N'Zoey Và Xá Xị - Tập 1 - Kẹo Dẻo Và Những Chú Rồng', N'Nhi đồng', 'A4', 110, 110, N'bìa cứng', 142000, N'BẠN SẼ LÀM GÌ NẾU MỘT SINH VẬT THẦN KÌ XUẤT HIỆN VÀ NHỜ BẠN GIÚP ĐỠ?
Ôi không! Những bông hồng rừng đang gặp vấn đề, đó là những bông hồng có phép thần vô cùng quan trọng bởi vì chúng là thức ăn đầu tiên cho những chú bằng mã mới nở. Liệu Zoey, bác Pip và Xá Xị có thể vận dụng kiến thức khoa học của mình để cứu hoa hồng rừng trước khi trứng bằng mã nở không?
---
ASIA CITRO xuất thân là một giáo viên khoa học, nhưng hiện tại cô ở nhà cùng hai con và viết sách. Khi còn nhỏ, cô cũng có một chú mèo giống như Xá Xị. Nó thích ăn bọ và luôn khiến cô bật cười (món đồ chơi yêu thích của nó là một cái mũi bằng nhựa dẻo được nó tha đi khắp nơi). Asia cũng đã xuất bản ba cuốn sách kĩ năng, gồm: 150+ hoạt động giúp trẻ em rời màn hình điện thoại, Sách khoa học dành cho các bé hiếu kì, và Một chút lấm bẩn. Cô vẫn chưa tìm được chú rồng nhỏ nào ở sân sau, nhưng cô luôn cẩn thận để mắt, biết đâu được.
MARION LINDSAY là họa sĩ minh họa sách thiếu nhi. Cô rất thích những câu chuyện kể và chỉ cần đọc là biết ngay đâu là một câu chuyện hay. Cô thích vẽ tất cả mọi thứ nhưng dành nhiều thời gian nhất để vẽ mèo. Và để che giấu điều này, đôi khi cô phải vẽ chó. Cô minh họa truyện tranh, truyện nhiều chương, vẽ các bức họa và thiết kế hoa văn. Cũng như Asia, Marion luôn tìm kiếm những con rồng và đoán thể nào cũng có một chú rồng nhỏ nào đó sống trong tủ sưởi.', '2024-05-11', '0000000021.jpg', 10),
('DM03', 'NXB01', N'Zoey Và Xá Xị - Tập 2 - Chuyện Nhỏ Của Quái Vật', N'Nhi đồng', 'A4', 140, 140, N'bìa mềm', 212000, N'BẠN SẼ LÀM GÌ NẾU MỘT SINH VẬT THẦN KÌ XUẤT HIỆN VÀ NHỜ BẠN GIÚP ĐỠ?
Ôi không! Những bông hồng rừng đang gặp vấn đề, đó là những bông hồng có phép thần vô cùng quan trọng bởi vì chúng là thức ăn đầu tiên cho những chú bằng mã mới nở. Liệu Zoey, bác Pip và Xá Xị có thể vận dụng kiến thức khoa học của mình để cứu hoa hồng rừng trước khi trứng bằng mã nở không?
---
ASIA CITRO xuất thân là một giáo viên khoa học, nhưng hiện tại cô ở nhà cùng hai con và viết sách. Khi còn nhỏ, cô cũng có một chú mèo giống như Xá Xị. Nó thích ăn bọ và luôn khiến cô bật cười (món đồ chơi yêu thích của nó là một cái mũi bằng nhựa dẻo được nó tha đi khắp nơi). Asia cũng đã xuất bản ba cuốn sách kĩ năng, gồm: 150+ hoạt động giúp trẻ em rời màn hình điện thoại, Sách khoa học dành cho các bé hiếu kì, và Một chút lấm bẩn. Cô vẫn chưa tìm được chú rồng nhỏ nào ở sân sau, nhưng cô luôn cẩn thận để mắt, biết đâu được.
MARION LINDSAY là họa sĩ minh họa sách thiếu nhi. Cô rất thích những câu chuyện kể và chỉ cần đọc là biết ngay đâu là một câu chuyện hay. Cô thích vẽ tất cả mọi thứ nhưng dành nhiều thời gian nhất để vẽ mèo. Và để che giấu điều này, đôi khi cô phải vẽ chó. Cô minh họa truyện tranh, truyện nhiều chương, vẽ các bức họa và thiết kế hoa văn. Cũng như Asia, Marion luôn tìm kiếm những con rồng và đoán thể nào cũng có một chú rồng nhỏ nào đó sống trong tủ sưởi.', '2024-05-11', '0000000022.jpg', 10),
('DM03', 'NXB01', N'Zoey Và Xá Xị - Tập 3 - Tiên Cá Ngựa Và Bong Bóng Xà Phòng', N'Nhi đồng', 'A4', 100, 100, N'bìa cứng', 399000, N'BẠN SẼ LÀM GÌ NẾU MỘT SINH VẬT THẦN KÌ XUẤT HIỆN VÀ NHỜ BẠN GIÚP ĐỠ?
Ôi không! Những bông hồng rừng đang gặp vấn đề, đó là những bông hồng có phép thần vô cùng quan trọng bởi vì chúng là thức ăn đầu tiên cho những chú bằng mã mới nở. Liệu Zoey, bác Pip và Xá Xị có thể vận dụng kiến thức khoa học của mình để cứu hoa hồng rừng trước khi trứng bằng mã nở không?
---
ASIA CITRO xuất thân là một giáo viên khoa học, nhưng hiện tại cô ở nhà cùng hai con và viết sách. Khi còn nhỏ, cô cũng có một chú mèo giống như Xá Xị. Nó thích ăn bọ và luôn khiến cô bật cười (món đồ chơi yêu thích của nó là một cái mũi bằng nhựa dẻo được nó tha đi khắp nơi). Asia cũng đã xuất bản ba cuốn sách kĩ năng, gồm: 150+ hoạt động giúp trẻ em rời màn hình điện thoại, Sách khoa học dành cho các bé hiếu kì, và Một chút lấm bẩn. Cô vẫn chưa tìm được chú rồng nhỏ nào ở sân sau, nhưng cô luôn cẩn thận để mắt, biết đâu được.
MARION LINDSAY là họa sĩ minh họa sách thiếu nhi. Cô rất thích những câu chuyện kể và chỉ cần đọc là biết ngay đâu là một câu chuyện hay. Cô thích vẽ tất cả mọi thứ nhưng dành nhiều thời gian nhất để vẽ mèo. Và để che giấu điều này, đôi khi cô phải vẽ chó. Cô minh họa truyện tranh, truyện nhiều chương, vẽ các bức họa và thiết kế hoa văn. Cũng như Asia, Marion luôn tìm kiếm những con rồng và đoán thể nào cũng có một chú rồng nhỏ nào đó sống trong tủ sưởi.', '2024-05-11', '0000000023.jpg', 10),
('DM03', 'NXB01', N'Zoey Và Xá Xị - Tập 4 - Mèo Cánh Bướm Và Băng', N'Nhi đồng', 'A4', 125, 125, N'bìa mềm', 365000, N'BẠN SẼ LÀM GÌ NẾU MỘT SINH VẬT THẦN KÌ XUẤT HIỆN VÀ NHỜ BẠN GIÚP ĐỠ?
Ôi không! Những bông hồng rừng đang gặp vấn đề, đó là những bông hồng có phép thần vô cùng quan trọng bởi vì chúng là thức ăn đầu tiên cho những chú bằng mã mới nở. Liệu Zoey, bác Pip và Xá Xị có thể vận dụng kiến thức khoa học của mình để cứu hoa hồng rừng trước khi trứng bằng mã nở không?
---
ASIA CITRO xuất thân là một giáo viên khoa học, nhưng hiện tại cô ở nhà cùng hai con và viết sách. Khi còn nhỏ, cô cũng có một chú mèo giống như Xá Xị. Nó thích ăn bọ và luôn khiến cô bật cười (món đồ chơi yêu thích của nó là một cái mũi bằng nhựa dẻo được nó tha đi khắp nơi). Asia cũng đã xuất bản ba cuốn sách kĩ năng, gồm: 150+ hoạt động giúp trẻ em rời màn hình điện thoại, Sách khoa học dành cho các bé hiếu kì, và Một chút lấm bẩn. Cô vẫn chưa tìm được chú rồng nhỏ nào ở sân sau, nhưng cô luôn cẩn thận để mắt, biết đâu được.
MARION LINDSAY là họa sĩ minh họa sách thiếu nhi. Cô rất thích những câu chuyện kể và chỉ cần đọc là biết ngay đâu là một câu chuyện hay. Cô thích vẽ tất cả mọi thứ nhưng dành nhiều thời gian nhất để vẽ mèo. Và để che giấu điều này, đôi khi cô phải vẽ chó. Cô minh họa truyện tranh, truyện nhiều chương, vẽ các bức họa và thiết kế hoa văn. Cũng như Asia, Marion luôn tìm kiếm những con rồng và đoán thể nào cũng có một chú rồng nhỏ nào đó sống trong tủ sưởi.', '2024-05-11', '0000000024.jpg', 10),
('DM03', 'NXB01', N'Zoey Và Xá Xị - Tập 5 - Chuyện Đầm Lầy Và Vỏ Hạt Thần Kì', N'Nhi đồng', 'A4', 135, 135, N'bìa cứng', 573000, N'BẠN SẼ LÀM GÌ NẾU MỘT SINH VẬT THẦN KÌ XUẤT HIỆN VÀ NHỜ BẠN GIÚP ĐỠ?
Ôi không! Những bông hồng rừng đang gặp vấn đề, đó là những bông hồng có phép thần vô cùng quan trọng bởi vì chúng là thức ăn đầu tiên cho những chú bằng mã mới nở. Liệu Zoey, bác Pip và Xá Xị có thể vận dụng kiến thức khoa học của mình để cứu hoa hồng rừng trước khi trứng bằng mã nở không?
---
ASIA CITRO xuất thân là một giáo viên khoa học, nhưng hiện tại cô ở nhà cùng hai con và viết sách. Khi còn nhỏ, cô cũng có một chú mèo giống như Xá Xị. Nó thích ăn bọ và luôn khiến cô bật cười (món đồ chơi yêu thích của nó là một cái mũi bằng nhựa dẻo được nó tha đi khắp nơi). Asia cũng đã xuất bản ba cuốn sách kĩ năng, gồm: 150+ hoạt động giúp trẻ em rời màn hình điện thoại, Sách khoa học dành cho các bé hiếu kì, và Một chút lấm bẩn. Cô vẫn chưa tìm được chú rồng nhỏ nào ở sân sau, nhưng cô luôn cẩn thận để mắt, biết đâu được.
MARION LINDSAY là họa sĩ minh họa sách thiếu nhi. Cô rất thích những câu chuyện kể và chỉ cần đọc là biết ngay đâu là một câu chuyện hay. Cô thích vẽ tất cả mọi thứ nhưng dành nhiều thời gian nhất để vẽ mèo. Và để che giấu điều này, đôi khi cô phải vẽ chó. Cô minh họa truyện tranh, truyện nhiều chương, vẽ các bức họa và thiết kế hoa văn. Cũng như Asia, Marion luôn tìm kiếm những con rồng và đoán thể nào cũng có một chú rồng nhỏ nào đó sống trong tủ sưởi.', '2024-05-11', '0000000025.jpg', 10),
('DM03', 'NXB01', N'Zoey Và Xá Xị - Tập 6 - Chuyện Bé Kì Lân', N'Nhi đồng', 'A4', 95, 95, N'bìa mềm', 553000, N'BẠN SẼ LÀM GÌ NẾU MỘT SINH VẬT THẦN KÌ XUẤT HIỆN VÀ NHỜ BẠN GIÚP ĐỠ?
Ôi không! Những bông hồng rừng đang gặp vấn đề, đó là những bông hồng có phép thần vô cùng quan trọng bởi vì chúng là thức ăn đầu tiên cho những chú bằng mã mới nở. Liệu Zoey, bác Pip và Xá Xị có thể vận dụng kiến thức khoa học của mình để cứu hoa hồng rừng trước khi trứng bằng mã nở không?
---
ASIA CITRO xuất thân là một giáo viên khoa học, nhưng hiện tại cô ở nhà cùng hai con và viết sách. Khi còn nhỏ, cô cũng có một chú mèo giống như Xá Xị. Nó thích ăn bọ và luôn khiến cô bật cười (món đồ chơi yêu thích của nó là một cái mũi bằng nhựa dẻo được nó tha đi khắp nơi). Asia cũng đã xuất bản ba cuốn sách kĩ năng, gồm: 150+ hoạt động giúp trẻ em rời màn hình điện thoại, Sách khoa học dành cho các bé hiếu kì, và Một chút lấm bẩn. Cô vẫn chưa tìm được chú rồng nhỏ nào ở sân sau, nhưng cô luôn cẩn thận để mắt, biết đâu được.
MARION LINDSAY là họa sĩ minh họa sách thiếu nhi. Cô rất thích những câu chuyện kể và chỉ cần đọc là biết ngay đâu là một câu chuyện hay. Cô thích vẽ tất cả mọi thứ nhưng dành nhiều thời gian nhất để vẽ mèo. Và để che giấu điều này, đôi khi cô phải vẽ chó. Cô minh họa truyện tranh, truyện nhiều chương, vẽ các bức họa và thiết kế hoa văn. Cũng như Asia, Marion luôn tìm kiếm những con rồng và đoán thể nào cũng có một chú rồng nhỏ nào đó sống trong tủ sưởi.', '2024-05-11', '0000000026.jpg', 10),
('DM03', 'NXB01', N'Zoey Và Xá Xị - Tập 7 - Gắt Gỏm Và Sâu Hại', N'Nhi đồng', 'A4', 130, 130, N'bìa cứng', 462000, N'BẠN SẼ LÀM GÌ NẾU MỘT SINH VẬT THẦN KÌ XUẤT HIỆN VÀ NHỜ BẠN GIÚP ĐỠ?
Ôi không! Những bông hồng rừng đang gặp vấn đề, đó là những bông hồng có phép thần vô cùng quan trọng bởi vì chúng là thức ăn đầu tiên cho những chú bằng mã mới nở. Liệu Zoey, bác Pip và Xá Xị có thể vận dụng kiến thức khoa học của mình để cứu hoa hồng rừng trước khi trứng bằng mã nở không?
---
ASIA CITRO xuất thân là một giáo viên khoa học, nhưng hiện tại cô ở nhà cùng hai con và viết sách. Khi còn nhỏ, cô cũng có một chú mèo giống như Xá Xị. Nó thích ăn bọ và luôn khiến cô bật cười (món đồ chơi yêu thích của nó là một cái mũi bằng nhựa dẻo được nó tha đi khắp nơi). Asia cũng đã xuất bản ba cuốn sách kĩ năng, gồm: 150+ hoạt động giúp trẻ em rời màn hình điện thoại, Sách khoa học dành cho các bé hiếu kì, và Một chút lấm bẩn. Cô vẫn chưa tìm được chú rồng nhỏ nào ở sân sau, nhưng cô luôn cẩn thận để mắt, biết đâu được.
MARION LINDSAY là họa sĩ minh họa sách thiếu nhi. Cô rất thích những câu chuyện kể và chỉ cần đọc là biết ngay đâu là một câu chuyện hay. Cô thích vẽ tất cả mọi thứ nhưng dành nhiều thời gian nhất để vẽ mèo. Và để che giấu điều này, đôi khi cô phải vẽ chó. Cô minh họa truyện tranh, truyện nhiều chương, vẽ các bức họa và thiết kế hoa văn. Cũng như Asia, Marion luôn tìm kiếm những con rồng và đoán thể nào cũng có một chú rồng nhỏ nào đó sống trong tủ sưởi.', '2024-05-11', '0000000027.jpg', 10),
('DM03', 'NXB01', N'Zoey Và Xá Xị - Tập 8 - Bíp Và Hoa Hồng', N'Nhi đồng', 'A4', 85, 85, N'bìa mềm', 516000, N'BẠN SẼ LÀM GÌ NẾU MỘT SINH VẬT THẦN KÌ XUẤT HIỆN VÀ NHỜ BẠN GIÚP ĐỠ?
Ôi không! Những bông hồng rừng đang gặp vấn đề, đó là những bông hồng có phép thần vô cùng quan trọng bởi vì chúng là thức ăn đầu tiên cho những chú bằng mã mới nở. Liệu Zoey, bác Pip và Xá Xị có thể vận dụng kiến thức khoa học của mình để cứu hoa hồng rừng trước khi trứng bằng mã nở không?
---
ASIA CITRO xuất thân là một giáo viên khoa học, nhưng hiện tại cô ở nhà cùng hai con và viết sách. Khi còn nhỏ, cô cũng có một chú mèo giống như Xá Xị. Nó thích ăn bọ và luôn khiến cô bật cười (món đồ chơi yêu thích của nó là một cái mũi bằng nhựa dẻo được nó tha đi khắp nơi). Asia cũng đã xuất bản ba cuốn sách kĩ năng, gồm: 150+ hoạt động giúp trẻ em rời màn hình điện thoại, Sách khoa học dành cho các bé hiếu kì, và Một chút lấm bẩn. Cô vẫn chưa tìm được chú rồng nhỏ nào ở sân sau, nhưng cô luôn cẩn thận để mắt, biết đâu được.
MARION LINDSAY là họa sĩ minh họa sách thiếu nhi. Cô rất thích những câu chuyện kể và chỉ cần đọc là biết ngay đâu là một câu chuyện hay. Cô thích vẽ tất cả mọi thứ nhưng dành nhiều thời gian nhất để vẽ mèo. Và để che giấu điều này, đôi khi cô phải vẽ chó. Cô minh họa truyện tranh, truyện nhiều chương, vẽ các bức họa và thiết kế hoa văn. Cũng như Asia, Marion luôn tìm kiếm những con rồng và đoán thể nào cũng có một chú rồng nhỏ nào đó sống trong tủ sưởi.', '2024-05-11', '0000000028.jpg', 10),
('DM03', 'NXB01', N'Zoey Và Xá Xị - Tập 9 - Rắc Rối Của Nàng Tiên Ước Nguyện', N'Nhi đồng', 'A4', 120, 120, N'bìa cứng', 598000, N'BẠN SẼ LÀM GÌ NẾU MỘT SINH VẬT THẦN KÌ XUẤT HIỆN VÀ NHỜ BẠN GIÚP ĐỠ?
Ôi không! Những bông hồng rừng đang gặp vấn đề, đó là những bông hồng có phép thần vô cùng quan trọng bởi vì chúng là thức ăn đầu tiên cho những chú bằng mã mới nở. Liệu Zoey, bác Pip và Xá Xị có thể vận dụng kiến thức khoa học của mình để cứu hoa hồng rừng trước khi trứng bằng mã nở không?
---
ASIA CITRO xuất thân là một giáo viên khoa học, nhưng hiện tại cô ở nhà cùng hai con và viết sách. Khi còn nhỏ, cô cũng có một chú mèo giống như Xá Xị. Nó thích ăn bọ và luôn khiến cô bật cười (món đồ chơi yêu thích của nó là một cái mũi bằng nhựa dẻo được nó tha đi khắp nơi). Asia cũng đã xuất bản ba cuốn sách kĩ năng, gồm: 150+ hoạt động giúp trẻ em rời màn hình điện thoại, Sách khoa học dành cho các bé hiếu kì, và Một chút lấm bẩn. Cô vẫn chưa tìm được chú rồng nhỏ nào ở sân sau, nhưng cô luôn cẩn thận để mắt, biết đâu được.
MARION LINDSAY là họa sĩ minh họa sách thiếu nhi. Cô rất thích những câu chuyện kể và chỉ cần đọc là biết ngay đâu là một câu chuyện hay. Cô thích vẽ tất cả mọi thứ nhưng dành nhiều thời gian nhất để vẽ mèo. Và để che giấu điều này, đôi khi cô phải vẽ chó. Cô minh họa truyện tranh, truyện nhiều chương, vẽ các bức họa và thiết kế hoa văn. Cũng như Asia, Marion luôn tìm kiếm những con rồng và đoán thể nào cũng có một chú rồng nhỏ nào đó sống trong tủ sưởi.', '2024-05-11', '0000000029.jpg', 10),
('DM03', 'NXB01', N'Sau lưng Gió Bấc', N'Tuổi mới lớn', 'A4', 105, 105, N'bìa mềm', 498000, N'Cuộc gặp gỡ giữa nhóc Kim Cương và bà Gió Bấc trên căn gác xép chuồng ngựa là khởi đầu cho chuyến hành trình kì diệu của sự thấu ngộ những bài học cuộc đời, mà người ta chỉ có thể tìm thấy mọi câu trả lời ở đích đến sau cùng – xứ sở sau lưng gió bấc. Kim Cương ngây ngô, thiện lành, tựa một thiên thần khơi lên cái thiện trong tâm trí người đời. Cậu nhóc cũng can trường, mạnh mẽ, và dẫu có bị nói là theo đuổi những lí tưởng chẳng đâu hay điều không có thực, cậu vẫn vững tin đẩy lui mọi thứ tai hại giáng xuống bạn bè, người thân của cậu, những mầm mống xấu xa khiến người chẳng còn để tâm tới người.
Một câu chuyện ngân vang những khúc hát và vần điệu của trẻ thơ, nhưng cũng lắng đọng biết bao niềm vui, nỗi buồn của phận người.
“Kilmeny đã đến nơi em không hề biết, 
Và trông thấy những điều chẳng thể khoe ra; [...]
Đất lành của tình yêu, chốn về của ánh sáng, 
Không cần mặt trời, mặt trăng hay đêm tối; 
Nơi dòng sông rung rinh nguồn sống, 
Nơi ánh sáng trong trẻo, tinh khôi: 
Lãnh địa của ảo mộng, tưởng như, 
Và vĩnh viễn một giấc mơ bất diệt.”', '2024-05-11', '0000000030.jpg', 10),
-- DM04, NXB01
('DM04', 'NXB01', N'Bồi Dưỡng Kĩ Năng Đọc Hiểu Cho Học Sinh Tiểu Học: Tìm Hiểu Về Các Quốc Gia - Quyển 1', N'Nhi đồng', 'A4', 120, 120, N'bìa cứng', 438000, N'Cảm xúc luôn hiện hữu trong mỗi người, nhưng đồng thời cũng là một trong những điều khó nắm bắt nhất. Có muôn màu cảm xúc trong cuộc sống mà hiểu được chúng cũng sẽ giúp ta trở nên tốt hơn trong nhiều mặt. Hãy cùng tìm hiểu về cảm xúc trong cuốn sách lí thú này nhé!
---
Không chỉ tập hợp các kiến thức lí thú, bộ sách Bồi dưỡng kĩ năng đọc hiểu cho học sinh tiểu học còn có phần Phiếu bài tập để các bạn nhỏ có thể kiểm tra lại kiến thức sau khi đã đọc xong phần lí thuyết. Bố mẹ và thầy cô hãy giúp các con đối chiếu với đáp án nhé!', '2024-05-11', '0000000031.jpg', 10),
('DM04', 'NXB01', N'Bồi Dưỡng Kĩ Năng Đọc Hiểu Cho Học Sinh Tiểu Học: Tìm Hiểu Về Các Quốc Gia - Quyển 2', N'Nhi đồng', 'A4', 75, 75, N'bìa mềm', 479000, N'Cảm xúc luôn hiện hữu trong mỗi người, nhưng đồng thời cũng là một trong những điều khó nắm bắt nhất. Có muôn màu cảm xúc trong cuộc sống mà hiểu được chúng cũng sẽ giúp ta trở nên tốt hơn trong nhiều mặt. Hãy cùng tìm hiểu về cảm xúc trong cuốn sách lí thú này nhé!
---
Không chỉ tập hợp các kiến thức lí thú, bộ sách Bồi dưỡng kĩ năng đọc hiểu cho học sinh tiểu học còn có phần Phiếu bài tập để các bạn nhỏ có thể kiểm tra lại kiến thức sau khi đã đọc xong phần lí thuyết. Bố mẹ và thầy cô hãy giúp các con đối chiếu với đáp án nhé!', '2024-05-11', '0000000032.jpg', 10),
('DM04', 'NXB01', N'Bồi Dưỡng Kĩ Năng Đọc Hiểu Cho Học Sinh Tiểu Học - Bí Mật Của Tự Nhiên - Quyển 1', N'Nhi đồng', 'A4', 85, 85, N'bìa cứng', 285000, N'Cảm xúc luôn hiện hữu trong mỗi người, nhưng đồng thời cũng là một trong những điều khó nắm bắt nhất. Có muôn màu cảm xúc trong cuộc sống mà hiểu được chúng cũng sẽ giúp ta trở nên tốt hơn trong nhiều mặt. Hãy cùng tìm hiểu về cảm xúc trong cuốn sách lí thú này nhé!
---
Không chỉ tập hợp các kiến thức lí thú, bộ sách Bồi dưỡng kĩ năng đọc hiểu cho học sinh tiểu học còn có phần Phiếu bài tập để các bạn nhỏ có thể kiểm tra lại kiến thức sau khi đã đọc xong phần lí thuyết. Bố mẹ và thầy cô hãy giúp các con đối chiếu với đáp án nhé!', '2024-05-11', '0000000033.jpg', 10),
('DM04', 'NXB01', N'Bồi Dưỡng Kĩ Năng Đọc Hiểu Cho Học Sinh Tiểu Học - Bí Mật Của Tự Nhiên - Quyển 2', N'Nhi đồng', 'A4', 110, 110, N'bìa mềm', 531000, N'Cảm xúc luôn hiện hữu trong mỗi người, nhưng đồng thời cũng là một trong những điều khó nắm bắt nhất. Có muôn màu cảm xúc trong cuộc sống mà hiểu được chúng cũng sẽ giúp ta trở nên tốt hơn trong nhiều mặt. Hãy cùng tìm hiểu về cảm xúc trong cuốn sách lí thú này nhé!
---
Không chỉ tập hợp các kiến thức lí thú, bộ sách Bồi dưỡng kĩ năng đọc hiểu cho học sinh tiểu học còn có phần Phiếu bài tập để các bạn nhỏ có thể kiểm tra lại kiến thức sau khi đã đọc xong phần lí thuyết. Bố mẹ và thầy cô hãy giúp các con đối chiếu với đáp án nhé!', '2024-05-11', '0000000034.jpg', 10),
('DM04', 'NXB01', N'Bồi Dưỡng Kĩ Năng Đọc Hiểu Cho Học Sinh Tiểu Học - Bí Mật Của Tự Nhiên - Quyển 3', N'Nhi đồng', 'A4', 140, 140, N'bìa cứng', 538000, N'Cảm xúc luôn hiện hữu trong mỗi người, nhưng đồng thời cũng là một trong những điều khó nắm bắt nhất. Có muôn màu cảm xúc trong cuộc sống mà hiểu được chúng cũng sẽ giúp ta trở nên tốt hơn trong nhiều mặt. Hãy cùng tìm hiểu về cảm xúc trong cuốn sách lí thú này nhé!
---
Không chỉ tập hợp các kiến thức lí thú, bộ sách Bồi dưỡng kĩ năng đọc hiểu cho học sinh tiểu học còn có phần Phiếu bài tập để các bạn nhỏ có thể kiểm tra lại kiến thức sau khi đã đọc xong phần lí thuyết. Bố mẹ và thầy cô hãy giúp các con đối chiếu với đáp án nhé!', '2024-05-11', '0000000035.jpg', 10),
('DM04', 'NXB01', N'Bồi Dưỡng Kĩ Năng Đọc Hiểu Cho Học Sinh Tiểu Học: Thế Giới Khủng Long', N'Nhi đồng', 'A4', 100, 100, N'bìa mềm', 365000, N'Cảm xúc luôn hiện hữu trong mỗi người, nhưng đồng thời cũng là một trong những điều khó nắm bắt nhất. Có muôn màu cảm xúc trong cuộc sống mà hiểu được chúng cũng sẽ giúp ta trở nên tốt hơn trong nhiều mặt. Hãy cùng tìm hiểu về cảm xúc trong cuốn sách lí thú này nhé!
---
Không chỉ tập hợp các kiến thức lí thú, bộ sách Bồi dưỡng kĩ năng đọc hiểu cho học sinh tiểu học còn có phần Phiếu bài tập để các bạn nhỏ có thể kiểm tra lại kiến thức sau khi đã đọc xong phần lí thuyết. Bố mẹ và thầy cô hãy giúp các con đối chiếu với đáp án nhé!', '2024-05-11', '0000000036.jpg', 10),
('DM04', 'NXB01', N'Bồi Dưỡng Kĩ Năng Đọc Hiểu Cho Học Sinh Tiểu Học: Thắc Mắc Về Cơ Thể Người', N'Nhi đồng', 'A4', 120, 120, N'bìa cứng', 361000, N'Cảm xúc luôn hiện hữu trong mỗi người, nhưng đồng thời cũng là một trong những điều khó nắm bắt nhất. Có muôn màu cảm xúc trong cuộc sống mà hiểu được chúng cũng sẽ giúp ta trở nên tốt hơn trong nhiều mặt. Hãy cùng tìm hiểu về cảm xúc trong cuốn sách lí thú này nhé!
---
Không chỉ tập hợp các kiến thức lí thú, bộ sách Bồi dưỡng kĩ năng đọc hiểu cho học sinh tiểu học còn có phần Phiếu bài tập để các bạn nhỏ có thể kiểm tra lại kiến thức sau khi đã đọc xong phần lí thuyết. Bố mẹ và thầy cô hãy giúp các con đối chiếu với đáp án nhé!', '2024-05-11', '0000000037.jpg', 10),
('DM04', 'NXB01', N'Bồi Dưỡng Kĩ Năng Đọc Hiểu Cho Học Sinh Tiểu Học: Chuyện Thú Vị Về Loài Vật', N'Nhi đồng', 'A4', 135, 135, N'bìa mềm', 501000, N'Cảm xúc luôn hiện hữu trong mỗi người, nhưng đồng thời cũng là một trong những điều khó nắm bắt nhất. Có muôn màu cảm xúc trong cuộc sống mà hiểu được chúng cũng sẽ giúp ta trở nên tốt hơn trong nhiều mặt. Hãy cùng tìm hiểu về cảm xúc trong cuốn sách lí thú này nhé!
---
Không chỉ tập hợp các kiến thức lí thú, bộ sách Bồi dưỡng kĩ năng đọc hiểu cho học sinh tiểu học còn có phần Phiếu bài tập để các bạn nhỏ có thể kiểm tra lại kiến thức sau khi đã đọc xong phần lí thuyết. Bố mẹ và thầy cô hãy giúp các con đối chiếu với đáp án nhé!', '2024-05-11', '0000000038.jpg', 10),
('DM04', 'NXB01', N'Bồi Dưỡng Kĩ Năng Đọc Hiểu Cho Học Sinh Tiểu Học: Muôn Màu Cảm Xúc', N'Nhi đồng', 'A4', 95, 95, N'bìa cứng', 50000, N'Cảm xúc luôn hiện hữu trong mỗi người, nhưng đồng thời cũng là một trong những điều khó nắm bắt nhất. Có muôn màu cảm xúc trong cuộc sống mà hiểu được chúng cũng sẽ giúp ta trở nên tốt hơn trong nhiều mặt. Hãy cùng tìm hiểu về cảm xúc trong cuốn sách lí thú này nhé!
---
Không chỉ tập hợp các kiến thức lí thú, bộ sách Bồi dưỡng kĩ năng đọc hiểu cho học sinh tiểu học còn có phần Phiếu bài tập để các bạn nhỏ có thể kiểm tra lại kiến thức sau khi đã đọc xong phần lí thuyết. Bố mẹ và thầy cô hãy giúp các con đối chiếu với đáp án nhé!', '2024-05-11', '0000000039.jpg', 10),
('DM04', 'NXB01', N'Bồi Dưỡng Kĩ Năng Đọc Hiểu Cho Học Sinh Tiểu Học: Các Sinh Vật Nguy Hiểm', N'Nhi đồng', 'A4', 100, 100, N'bìa mềm', 98000, N'Cảm xúc luôn hiện hữu trong mỗi người, nhưng đồng thời cũng là một trong những điều khó nắm bắt nhất. Có muôn màu cảm xúc trong cuộc sống mà hiểu được chúng cũng sẽ giúp ta trở nên tốt hơn trong nhiều mặt. Hãy cùng tìm hiểu về cảm xúc trong cuốn sách lí thú này nhé!
---
Không chỉ tập hợp các kiến thức lí thú, bộ sách Bồi dưỡng kĩ năng đọc hiểu cho học sinh tiểu học còn có phần Phiếu bài tập để các bạn nhỏ có thể kiểm tra lại kiến thức sau khi đã đọc xong phần lí thuyết. Bố mẹ và thầy cô hãy giúp các con đối chiếu với đáp án nhé!', '2024-05-11', '0000000040.jpg', 10),
('DM04', 'NXB01', N'Bồi Dưỡng Kĩ Năng Đọc Hiểu Cho Học Sinh Tiểu Học: Khám Phá Vũ Trụ', N'Nhi đồng', 'A4', 100, 100, N'bìa mềm', 466000, N'Cảm xúc luôn hiện hữu trong mỗi người, nhưng đồng thời cũng là một trong những điều khó nắm bắt nhất. Có muôn màu cảm xúc trong cuộc sống mà hiểu được chúng cũng sẽ giúp ta trở nên tốt hơn trong nhiều mặt. Hãy cùng tìm hiểu về cảm xúc trong cuốn sách lí thú này nhé!
---
Không chỉ tập hợp các kiến thức lí thú, bộ sách Bồi dưỡng kĩ năng đọc hiểu cho học sinh tiểu học còn có phần Phiếu bài tập để các bạn nhỏ có thể kiểm tra lại kiến thức sau khi đã đọc xong phần lí thuyết. Bố mẹ và thầy cô hãy giúp các con đối chiếu với đáp án nhé!', '2024-05-11', '0000000041.jpg', 10),
-- DM05, NXB01
('DM05', 'NXB01', N'Tranh truyện dân gian Việt Nam - Sinh con rồi mới sinh cha (2021)', N'Nhà trẻ - mẫu giáo', 'A4', 135, 135, N'bìa cứng', 628000, N'“Tham vàng phụ nghĩa cố nhân,

Oan hồn, hồn hiện, trời gần chẳng xa,

Sinh con rồi mới sinh cha,

Sinh cháu giữ nhà rồi mới sinh ông.”

Câu ca quen thuộc này liên quan đến một tích chuyện li kì. Mời các em cùng đọc truyện để hiểu vì sao lại có sự tích ngược đời: “Sinh con rồi mới sinh cha”.

Những câu chuyện dân gian giúp các em giàu thêm ước mơ, biết sống đẹp và trân trọng truyền thống cha ông.

Sau nhiều năm xây dựng, Tủ sách Tranh truyện dân gian Việt Nam do NXB Kim Đồng ấn hành đã tập hợp hơn 100 câu chuyện dân gian phong phú, hấp dẫn nhất dành cho lứa tuổi thiếu nhi. Bằng lời văn trong trẻo, mượt mà cùng những nét minh hoạ tươi sáng của nhiều hoạ sĩ nổi tiếng, “Tranh truyện dân gian Việt Nam” là bộ sách đặc biệt không thể thiếu trên giá sách của mỗi gia đình.', '2024-05-11', '0000000042.jpg', 10),
('DM05', 'NXB01', N'Tranh truyện dân gian Việt Nam - Sự tích quạ và công (2021)', N'Nhà trẻ - mẫu giáo', 'A4', 90, 90, N'bìa mềm', 839000, N'Xưa kia Quạ và Công là đôi bạn thân. Cả hai cùng có bộ lông xám xịt, lem nhem; chúng biết mình xấu xí nên chả dám đi đâu xa, suốt ngày chỉ quanh quẩn ở xó rừng. Rồi một hôm Quạ nghĩ ra một kế hòng làm thay đổi bộ lông của mình và Công. Nhưng rồi lại chỉ mình công có được bộ lông đẹp. Vì sao thế nhỉ? Mời các em cùng đọc truyện!

Những câu chuyện dân gian giúp các em giàu thêm mơ ước, biết sống đẹp và trân trọng truyền thống cha ông. Cùng tìm đọc hơn 100 cuốn Tranh truyện dân gian Việt Nam do NXB Kim Đồng ấn hành!', '2024-05-11', '0000000043.jpg', 10),
('DM05', 'NXB01', N'Tranh truyện dân gian Việt Nam - Bảy điều ước (2021)', N'Nhà trẻ - mẫu giáo', 'A4', 135, 135, N'bìa cứng', 727000, N'Được một nàng tiên tặng cho bảy điều ước để trả ơn cứu giúp, người em hiền lành chỉ giữ lại  ba, còn dành cho anh trai bốn điều ước. Người anh tham lam, ước lợi cho riêng mình, cuối cùng tự làm hại cả bản thân. Người em khiêm tốn với những ước nguyện nhỏ nhoi, không dựa vào phép màu mà lười biếng, ỷ lại nên cuối cùng được no đủ, hạnh phúc. Những câu chuyện dân gian giúp các em giàu thêm mơ ước, biết sống đẹp và trân trọng truyền thống cha ông. Cùng tìm đọc hơn 100 cuốn Tranh truyện dân gian Việt Nam do NXB Kim Đồng ấn hành!', '2024-05-11', '0000000044.jpg', 10),
('DM05', 'NXB01', N'Tranh truyện dân gian Việt Nam - Đi ở học thành tài (2021)', N'Nhà trẻ - mẫu giáo', 'A4', 90, 90, N'bìa mềm', 580000, N'Cậu bé Lệnh Tân mồ côi cha, phải đi ở cho nhà phú ông từ năm lên bảy. Những tưởng một đứa trẻ nghèo đi ở thì chỉ có việc ngày đêm quần quật lam làm cho nhà chủ? Nhưng không, cũng chính từ nhà phú ông, Lệnh Tân đã được biết đến chữ nghĩa thánh hiền. Và cũng nhờ đó, sau này cậu trở thành một ông quan to trong triều Lê. Câu chuyện về cậu bé nghèo hiếu học Lệnh Tân là một lời khích lệ, thúc giục các em cố gắng vươn lên trong học tập, để mai sau trở thành người có ích cho xã hội...

Những câu chuyện dân gian giúp các em giàu thêm mơ ước, biết sống đẹp và trân trọng truyền thống cha ông. Cùng tìm đọc hơn 100 cuốn Tranh truyện dân gian Việt Nam do NXB Kim Đồng ấn hành!', '2024-05-11', '0000000045.jpg', 10),
('DM05', 'NXB01', N'Tranh truyện dân gian Việt Nam - Người cha và ba con trai (2021)', N'Nhà trẻ - mẫu giáo', 'A4', 135, 135, N'bìa cứng', 705000, N'Chàng Út vượt núi, băng rừng tìm thứ cỏ thơm về chữa bệnh cho cha. Hai người anh vì tham muốn chiếm cả gia tài nên đã lừa em mà chiếm lấy nắm thuốc quý mang về định tâng công với cha. Nhưng thuốc quý vào tay những kẻ tham lam, ích kỉ thì lại trở nên vô dụng… Kết cục, chỉ có lòng hiếu thảo và sự độ lượng, vị tha mới làm cuộc sống tốt đẹp hơn mà thôi!

Những câu chuyện dân gian giúp các em giàu thêm mơ ước, biết sống đẹp và trân trọng truyền thống cha ông. Cùng tìm đọc hơn 100 cuốn Tranh truyện dân gian Việt Nam do NXB Kim Đồng ấn hành!', '2024-05-11', '0000000046.jpg', 10),
('DM05', 'NXB01', N'Tranh truyện dân gian Việt Nam - Người mẹ kế và hai con trai (2021)', N'Nhà trẻ - mẫu giáo', 'A4', 90, 90, N'bìa mềm', 553000, N'Chuyện kể về một người mẹ kế nhân hậu, yêu thương con chồng như con rứt ruột đẻ ra. Không may hai đứa con của bà gặp nạn. Khi được chọn cho một đứa phải sống, một đứa phải chết, người mẹ ấy xử sự như thế nào?', '2024-05-11', '0000000047.jpg', 10),
('DM05', 'NXB01', N'Tranh truyện dân gian Việt Nam - Thạch Sanh (2021)', N'Nhà trẻ - mẫu giáo', 'A4', 135, 135, N'bìa cứng', 839000, N'“Đàn kêu tích tịch tình tang/Ai mang công chúa dưới hang trở về!” Từ trong ngục sâu, tiếng đàn trách móc, oán thương  đã khiến công chúa cất lên tiếng nói. Thế rồi Thạch Sanh – người anh hùng diệt xà tinh được minh oan, còn Lý Thông – kẻ cướp công, hại người bị biến thành con bọ hung suốt ngày chui rúc ở nơi bẩn thỉu. Nhưng câu chuyện về chàng Thạch Sanh chưa kết thúc, vì vừa lúc đó, đại quân 18 nước láng giềng ầm ầm kéo đến vây kinh đô, đòi bắt công chúa…

Những câu chuyện dân gian giúp các em giàu thêm mơ ước, biết sống đẹp và trân trọng truyền thống cha ông. Cùng tìm đọc hơn 100 cuốn Tranh truyện dân gian Việt Nam do NXB Kim Đồng ấn hành!', '2024-05-11', '0000000048.jpg', 10),
('DM05', 'NXB01', N'Tranh truyện dân gian Việt Nam - Anh chàng học khôn (2021)', N'Nhà trẻ - mẫu giáo', 'A4', 90, 90, N'bìa mềm', 386000, N'Một anh chàng Ngốc quyết tâm lên đường đi học cái khôn để đòi lại vợ. Tuy chẳng biết phải học khôn như thế nào nhưng những câu nói anh chàng vô tình nghe được và học thuộc trên đường đi, vào một ngày kia lại giúp chàng giành được vợ về, hơn nữa còn dạy cho những kẻ tham vàng bỏ ngãi một bài học đích đáng... Những câu chuyện dân gian giúp các em giàu thêm mơ ước, biết sống đẹp và trân trọng truyền thống cha ông. Cùng tìm đọc hơn 100 cuốn Tranh truyện dân gian Việt Nam do NXB Kim Đồng ấn hành!', '2024-05-11', '0000000049.jpg', 10),
('DM05', 'NXB01', N'Tranh truyện dân gian Việt Nam - Anh học trò và ba con quỷ (2021)', N'Nhi đồng', 'A4', 135, 135, N'bìa cứng', 739000, N'Có ba con quỷ cáo ẩn mình trong cái then cửa buồng cô gái xinh đẹp kia. Chúng hớp mất hồn cô gái xinh đẹp, lại còn hại cả nhà cô điêu đứng. Và khi anh học trò tài trí xuất hiện, ba con quỷ ấy phải khiếp sợ, van xin anh tha mạng. Đổi lại, chúng đưa cho anh ba vật thần kì: mặt trời, mặt trăng và một con ngựa. Những báu vật ấy đã giúp anh kịp tới kinh thi.

Và đến khi được bổ làm quan, anh đã dùng chúng để trừ yêu ma quỷ quái, mang lại bình yên cho dân làng…

Những câu chuyện dân gian nuôi dưỡng tâm hồn các em, giúp các em biết học điều hay lẽ phải, yêu cái thiện, ghét cái xấu và trân trọng truyền thống cha ông. Bộ sách Tranh truyện dân gian Việt Nam là món quà ý nghĩa với những câu chuyện được tuyển chọn và biên soạn kĩ lưỡng. Phần tranh vẽ minh họa sinh động, gần gũi giúp các em dễ dàng hơn trong việc tiếp cận và ghi nhớ câu chuyện.', '2024-05-11', '0000000050.jpg', 10),
('DM05', 'NXB01', N'Tranh truyện dân gian Việt Nam - Cây tre trăm đốt (2021)', N'Nhi đồng', 'A4', 90, 90, N'bìa mềm', 670000, N'Những câu chuyện dân gian nuôi dưỡng tâm hồn các em, giúp các em biết học điều hay lẽ phải, yêu cái thiện, ghét cái xấu và trân trọng truyền thống cha ông. Bộ sách Tranh truyện dân gian Việt Nam là món quà ý nghĩa với những câu chuyện được tuyển chọn và biên soạn kĩ lưỡng. Phần tranh vẽ minh họa sinh động, gần gũi giúp các em dễ dàng hơn trong việc tiếp cận và ghi nhớ câu chuyện.

Có lão phú ông bủn xỉn, hành hạ kẻ ở đủ đường. Lão hứa gả con gái, để bắt anh đầy tớ dốc sức làm lụng ngày đêm. Nhưng ít lâu sau, vì muốn gả con gái cho một nhà giàu, lão chủ lại nghĩ mưu tính kế, bắt anh đầy tớ đi tìm cho được cây tre có một trăm đốt thì mới được lấy cô gái kia làm vợ. Nhưng liệu có cây tre nào cao đủ một trăm đốt? Anh đầy tớ phải làm sao? Mời các em cùng đọc truyện!', '2024-05-11', '0000000051.jpg', 10),
-- DM06, NXB01
('DM06', 'NXB01', N'Chu du ẩm thực tại Dị giới với kĩ năng không tưởng - Tập 2', N'Tuổi mới lớn', 'A4', 100, 100, N'bìa cứng', 612000, N'“Ngươi hầm thịt nó luôn hả!? Nghe ngon đấy!!”
Và thế là nhiệm vụ thảo phạt đám Wyvern đã trút xuống đầu nhóm Mukoda.
Bên cạnh Fel đang quyết tâm săn về nguyên liệu thịt mới, Sui cũng rất háo hức khi được truyền thụ bị kíp chiến đấu với kẻ địch biết bay.
Với sự hăng hái của cả hai, chẳng mấy chốc nhiệm vụ hoàn tất! Sau khi lấy được tiền thưởng và tiền giao dịch, cuối cùng Mukoda rủng rỉnh của chúng ta cũng sắm được chiếc bồn tắm mà anh luôn ao ước!
Sau khi được thỏa mãn giấc mơ tắm bồn, anh bắt tay vào chế biến loại nguyên liệu đắt giá: Thịt Wyvern! 
Trong lúc Fel đi săn để giết thời gian, một nồi thịt hầm ngon lành đã ra lò…! Nhưng vì Fel quá sức lem luốc nên Mukoda đã đề nghị phải tắm rửa sạch sẽ rồi mới được ăn…
Những ngày lưu lại Kalerina sắp kết thúc? Tập 6 của chuyến chu du tại Dị giới sắp sửa bước sang hành trình mới! ', '2024-05-11', '0000000052.jpg', 10),
('DM06', 'NXB01', N'Chu du ẩm thực tại Dị giới với kĩ năng không tưởng - Tập 3', N'Tuổi mới lớn', 'A4', 130, 130, N'bìa mềm', 692000, N'“Ngươi hầm thịt nó luôn hả!? Nghe ngon đấy!!”
Và thế là nhiệm vụ thảo phạt đám Wyvern đã trút xuống đầu nhóm Mukoda.
Bên cạnh Fel đang quyết tâm săn về nguyên liệu thịt mới, Sui cũng rất háo hức khi được truyền thụ bị kíp chiến đấu với kẻ địch biết bay.
Với sự hăng hái của cả hai, chẳng mấy chốc nhiệm vụ hoàn tất! Sau khi lấy được tiền thưởng và tiền giao dịch, cuối cùng Mukoda rủng rỉnh của chúng ta cũng sắm được chiếc bồn tắm mà anh luôn ao ước!
Sau khi được thỏa mãn giấc mơ tắm bồn, anh bắt tay vào chế biến loại nguyên liệu đắt giá: Thịt Wyvern! 
Trong lúc Fel đi săn để giết thời gian, một nồi thịt hầm ngon lành đã ra lò…! Nhưng vì Fel quá sức lem luốc nên Mukoda đã đề nghị phải tắm rửa sạch sẽ rồi mới được ăn…
Những ngày lưu lại Kalerina sắp kết thúc? Tập 6 của chuyến chu du tại Dị giới sắp sửa bước sang hành trình mới! ', '2024-05-11', '0000000053.jpg', 10),
('DM06', 'NXB01', N'Chu du ẩm thực tại Dị giới với kĩ năng không tưởng - Tập 4', N'Tuổi mới lớn', 'A4', 100, 100, N'bìa cứng', 899000, N'“Ngươi hầm thịt nó luôn hả!? Nghe ngon đấy!!”
Và thế là nhiệm vụ thảo phạt đám Wyvern đã trút xuống đầu nhóm Mukoda.
Bên cạnh Fel đang quyết tâm săn về nguyên liệu thịt mới, Sui cũng rất háo hức khi được truyền thụ bị kíp chiến đấu với kẻ địch biết bay.
Với sự hăng hái của cả hai, chẳng mấy chốc nhiệm vụ hoàn tất! Sau khi lấy được tiền thưởng và tiền giao dịch, cuối cùng Mukoda rủng rỉnh của chúng ta cũng sắm được chiếc bồn tắm mà anh luôn ao ước!
Sau khi được thỏa mãn giấc mơ tắm bồn, anh bắt tay vào chế biến loại nguyên liệu đắt giá: Thịt Wyvern! 
Trong lúc Fel đi săn để giết thời gian, một nồi thịt hầm ngon lành đã ra lò…! Nhưng vì Fel quá sức lem luốc nên Mukoda đã đề nghị phải tắm rửa sạch sẽ rồi mới được ăn…
Những ngày lưu lại Kalerina sắp kết thúc? Tập 6 của chuyến chu du tại Dị giới sắp sửa bước sang hành trình mới! ', '2024-05-11', '0000000054.jpg', 10),
('DM06', 'NXB01', N'Chu du ẩm thực tại Dị giới với kĩ năng không tưởng - Tập 5', N'Tuổi mới lớn', 'A4', 130, 130, N'bìa mềm', 845000, N'“Ngươi hầm thịt nó luôn hả!? Nghe ngon đấy!!”
Và thế là nhiệm vụ thảo phạt đám Wyvern đã trút xuống đầu nhóm Mukoda.
Bên cạnh Fel đang quyết tâm săn về nguyên liệu thịt mới, Sui cũng rất háo hức khi được truyền thụ bị kíp chiến đấu với kẻ địch biết bay.
Với sự hăng hái của cả hai, chẳng mấy chốc nhiệm vụ hoàn tất! Sau khi lấy được tiền thưởng và tiền giao dịch, cuối cùng Mukoda rủng rỉnh của chúng ta cũng sắm được chiếc bồn tắm mà anh luôn ao ước!
Sau khi được thỏa mãn giấc mơ tắm bồn, anh bắt tay vào chế biến loại nguyên liệu đắt giá: Thịt Wyvern! 
Trong lúc Fel đi săn để giết thời gian, một nồi thịt hầm ngon lành đã ra lò…! Nhưng vì Fel quá sức lem luốc nên Mukoda đã đề nghị phải tắm rửa sạch sẽ rồi mới được ăn…
Những ngày lưu lại Kalerina sắp kết thúc? Tập 6 của chuyến chu du tại Dị giới sắp sửa bước sang hành trình mới! ', '2024-05-11', '0000000055.jpg', 10),
('DM06', 'NXB01', N'Chu du ẩm thực tại Dị giới với kĩ năng không tưởng - Tập 6', N'Tuổi mới lớn', 'A4', 100, 100, N'bìa cứng', 785000, N'“Ngươi hầm thịt nó luôn hả!? Nghe ngon đấy!!”
Và thế là nhiệm vụ thảo phạt đám Wyvern đã trút xuống đầu nhóm Mukoda.
Bên cạnh Fel đang quyết tâm săn về nguyên liệu thịt mới, Sui cũng rất háo hức khi được truyền thụ bị kíp chiến đấu với kẻ địch biết bay.
Với sự hăng hái của cả hai, chẳng mấy chốc nhiệm vụ hoàn tất! Sau khi lấy được tiền thưởng và tiền giao dịch, cuối cùng Mukoda rủng rỉnh của chúng ta cũng sắm được chiếc bồn tắm mà anh luôn ao ước!
Sau khi được thỏa mãn giấc mơ tắm bồn, anh bắt tay vào chế biến loại nguyên liệu đắt giá: Thịt Wyvern! 
Trong lúc Fel đi săn để giết thời gian, một nồi thịt hầm ngon lành đã ra lò…! Nhưng vì Fel quá sức lem luốc nên Mukoda đã đề nghị phải tắm rửa sạch sẽ rồi mới được ăn…
Những ngày lưu lại Kalerina sắp kết thúc? Tập 6 của chuyến chu du tại Dị giới sắp sửa bước sang hành trình mới! ', '2024-05-11', '0000000056.jpg', 10),
('DM06', 'NXB01', N'Chu du ẩm thực tại Dị giới với kĩ năng không tưởng - Tập 7', N'Tuổi mới lớn', 'A4', 130, 130, N'bìa mềm', 406000, N'“Ngươi hầm thịt nó luôn hả!? Nghe ngon đấy!!”
Và thế là nhiệm vụ thảo phạt đám Wyvern đã trút xuống đầu nhóm Mukoda.
Bên cạnh Fel đang quyết tâm săn về nguyên liệu thịt mới, Sui cũng rất háo hức khi được truyền thụ bị kíp chiến đấu với kẻ địch biết bay.
Với sự hăng hái của cả hai, chẳng mấy chốc nhiệm vụ hoàn tất! Sau khi lấy được tiền thưởng và tiền giao dịch, cuối cùng Mukoda rủng rỉnh của chúng ta cũng sắm được chiếc bồn tắm mà anh luôn ao ước!
Sau khi được thỏa mãn giấc mơ tắm bồn, anh bắt tay vào chế biến loại nguyên liệu đắt giá: Thịt Wyvern! 
Trong lúc Fel đi săn để giết thời gian, một nồi thịt hầm ngon lành đã ra lò…! Nhưng vì Fel quá sức lem luốc nên Mukoda đã đề nghị phải tắm rửa sạch sẽ rồi mới được ăn…
Những ngày lưu lại Kalerina sắp kết thúc? Tập 6 của chuyến chu du tại Dị giới sắp sửa bước sang hành trình mới! ', '2024-05-11', '0000000057.jpg', 10),
('DM06', 'NXB01', N'Chu du ẩm thực tại Dị giới với kĩ năng không tưởng - Tập 8', N'Tuổi mới lớn', 'A4', 100, 100, N'bìa cứng', 308000, N'“Ngươi hầm thịt nó luôn hả!? Nghe ngon đấy!!”
Và thế là nhiệm vụ thảo phạt đám Wyvern đã trút xuống đầu nhóm Mukoda.
Bên cạnh Fel đang quyết tâm săn về nguyên liệu thịt mới, Sui cũng rất háo hức khi được truyền thụ bị kíp chiến đấu với kẻ địch biết bay.
Với sự hăng hái của cả hai, chẳng mấy chốc nhiệm vụ hoàn tất! Sau khi lấy được tiền thưởng và tiền giao dịch, cuối cùng Mukoda rủng rỉnh của chúng ta cũng sắm được chiếc bồn tắm mà anh luôn ao ước!
Sau khi được thỏa mãn giấc mơ tắm bồn, anh bắt tay vào chế biến loại nguyên liệu đắt giá: Thịt Wyvern! 
Trong lúc Fel đi săn để giết thời gian, một nồi thịt hầm ngon lành đã ra lò…! Nhưng vì Fel quá sức lem luốc nên Mukoda đã đề nghị phải tắm rửa sạch sẽ rồi mới được ăn…
Những ngày lưu lại Kalerina sắp kết thúc? Tập 6 của chuyến chu du tại Dị giới sắp sửa bước sang hành trình mới! ', '2024-05-11', '0000000058.jpg', 10),
('DM06', 'NXB01', N'Dược sư tự sự - Tập 1 (Manga)', N'Tuổi trưởng thành', 'A4', 130, 130, N'bìa mềm', 150000, N'La Hán thua một ván cờ tướng khi đấu với Miêu Miêu, phải uống rượu phạt và say bí tỉ. Trong mơ, ông ta nhớ về những chuyện xảy ra với người kĩ nữ năm xưa và cuộc gặp gỡ cùng con gái. Và rồi, sau khi La Hán tỉnh lại ở Lục Thanh quán, ai sẽ là kĩ nữ mà ông ta lựa chọn chuộc thân...?
Tập 8 mở ra với phân đoạn cao trào trong tập 2 tiểu thuyết nguyên tác, hé lộ bí mật về sự ra đời của Miêu Miêu...
* WINGS BOOKS - Thương hiệu sách trẻ của NXB Kim Đồng hân hạnh gửi đến các bạn độc giả phiên bản chuyển thể manga đặc sắc của bộ light-novel siêu ăn khách DƯỢC SƯ TỰ SỰ!
Series đã vượt mốc 13 triệu bản tại thị trường Nhật Bản, luôn thống trị bảng xếp hạng bán chạy mỗi khi ra tập mới!', '2024-05-11', '0000000059.jpg', 10),
('DM06', 'NXB01', N'Dược sư tự sự - Tập 2 (Manga)', N'Tuổi trưởng thành', 'A4', 130, 130, N'bìa mềm', 150000, N'La Hán thua một ván cờ tướng khi đấu với Miêu Miêu, phải uống rượu phạt và say bí tỉ. Trong mơ, ông ta nhớ về những chuyện xảy ra với người kĩ nữ năm xưa và cuộc gặp gỡ cùng con gái. Và rồi, sau khi La Hán tỉnh lại ở Lục Thanh quán, ai sẽ là kĩ nữ mà ông ta lựa chọn chuộc thân...?
Tập 8 mở ra với phân đoạn cao trào trong tập 2 tiểu thuyết nguyên tác, hé lộ bí mật về sự ra đời của Miêu Miêu...
* WINGS BOOKS - Thương hiệu sách trẻ của NXB Kim Đồng hân hạnh gửi đến các bạn độc giả phiên bản chuyển thể manga đặc sắc của bộ light-novel siêu ăn khách DƯỢC SƯ TỰ SỰ!
Series đã vượt mốc 13 triệu bản tại thị trường Nhật Bản, luôn thống trị bảng xếp hạng bán chạy mỗi khi ra tập mới!', '2024-05-11', '0000000060.jpg', 10),
('DM06', 'NXB01', N'Dược sư tự sự - Tập 3 (Manga)', N'Tuổi trưởng thành', 'A4', 130, 130, N'bìa mềm', 150000, N'La Hán thua một ván cờ tướng khi đấu với Miêu Miêu, phải uống rượu phạt và say bí tỉ. Trong mơ, ông ta nhớ về những chuyện xảy ra với người kĩ nữ năm xưa và cuộc gặp gỡ cùng con gái. Và rồi, sau khi La Hán tỉnh lại ở Lục Thanh quán, ai sẽ là kĩ nữ mà ông ta lựa chọn chuộc thân...?
Tập 8 mở ra với phân đoạn cao trào trong tập 2 tiểu thuyết nguyên tác, hé lộ bí mật về sự ra đời của Miêu Miêu...
* WINGS BOOKS - Thương hiệu sách trẻ của NXB Kim Đồng hân hạnh gửi đến các bạn độc giả phiên bản chuyển thể manga đặc sắc của bộ light-novel siêu ăn khách DƯỢC SƯ TỰ SỰ!
Series đã vượt mốc 13 triệu bản tại thị trường Nhật Bản, luôn thống trị bảng xếp hạng bán chạy mỗi khi ra tập mới!', '2024-05-11', '0000000061.jpg', 10),
('DM06', 'NXB01', N'Dược sư tự sự - Tập 4 (Manga)', N'Tuổi trưởng thành', 'A4', 130, 130, N'bìa mềm', 150000, N'La Hán thua một ván cờ tướng khi đấu với Miêu Miêu, phải uống rượu phạt và say bí tỉ. Trong mơ, ông ta nhớ về những chuyện xảy ra với người kĩ nữ năm xưa và cuộc gặp gỡ cùng con gái. Và rồi, sau khi La Hán tỉnh lại ở Lục Thanh quán, ai sẽ là kĩ nữ mà ông ta lựa chọn chuộc thân...?
Tập 8 mở ra với phân đoạn cao trào trong tập 2 tiểu thuyết nguyên tác, hé lộ bí mật về sự ra đời của Miêu Miêu...
* WINGS BOOKS - Thương hiệu sách trẻ của NXB Kim Đồng hân hạnh gửi đến các bạn độc giả phiên bản chuyển thể manga đặc sắc của bộ light-novel siêu ăn khách DƯỢC SƯ TỰ SỰ!
Series đã vượt mốc 13 triệu bản tại thị trường Nhật Bản, luôn thống trị bảng xếp hạng bán chạy mỗi khi ra tập mới!', '2024-05-11', '0000000062.jpg', 10),
('DM06', 'NXB01', N'Dược sư tự sự - Tập 5 (Manga)', N'Tuổi trưởng thành', 'A4', 130, 130, N'bìa mềm', 150000, N'La Hán thua một ván cờ tướng khi đấu với Miêu Miêu, phải uống rượu phạt và say bí tỉ. Trong mơ, ông ta nhớ về những chuyện xảy ra với người kĩ nữ năm xưa và cuộc gặp gỡ cùng con gái. Và rồi, sau khi La Hán tỉnh lại ở Lục Thanh quán, ai sẽ là kĩ nữ mà ông ta lựa chọn chuộc thân...?
Tập 8 mở ra với phân đoạn cao trào trong tập 2 tiểu thuyết nguyên tác, hé lộ bí mật về sự ra đời của Miêu Miêu...
* WINGS BOOKS - Thương hiệu sách trẻ của NXB Kim Đồng hân hạnh gửi đến các bạn độc giả phiên bản chuyển thể manga đặc sắc của bộ light-novel siêu ăn khách DƯỢC SƯ TỰ SỰ!
Series đã vượt mốc 13 triệu bản tại thị trường Nhật Bản, luôn thống trị bảng xếp hạng bán chạy mỗi khi ra tập mới!', '2024-05-11', '0000000063.jpg', 10),
('DM06', 'NXB01', N'Dược sư tự sự - Tập 6 (Manga)', N'Tuổi trưởng thành', 'A4', 130, 130, N'bìa mềm', 150000, N'La Hán thua một ván cờ tướng khi đấu với Miêu Miêu, phải uống rượu phạt và say bí tỉ. Trong mơ, ông ta nhớ về những chuyện xảy ra với người kĩ nữ năm xưa và cuộc gặp gỡ cùng con gái. Và rồi, sau khi La Hán tỉnh lại ở Lục Thanh quán, ai sẽ là kĩ nữ mà ông ta lựa chọn chuộc thân...?
Tập 8 mở ra với phân đoạn cao trào trong tập 2 tiểu thuyết nguyên tác, hé lộ bí mật về sự ra đời của Miêu Miêu...
* WINGS BOOKS - Thương hiệu sách trẻ của NXB Kim Đồng hân hạnh gửi đến các bạn độc giả phiên bản chuyển thể manga đặc sắc của bộ light-novel siêu ăn khách DƯỢC SƯ TỰ SỰ!
Series đã vượt mốc 13 triệu bản tại thị trường Nhật Bản, luôn thống trị bảng xếp hạng bán chạy mỗi khi ra tập mới!', '2024-05-11', '0000000064.jpg', 10),
('DM06', 'NXB01', N'Dược sư tự sự - Tập 7 (Manga)', N'Tuổi trưởng thành', 'A4', 130, 130, N'bìa mềm', 150000, N'La Hán thua một ván cờ tướng khi đấu với Miêu Miêu, phải uống rượu phạt và say bí tỉ. Trong mơ, ông ta nhớ về những chuyện xảy ra với người kĩ nữ năm xưa và cuộc gặp gỡ cùng con gái. Và rồi, sau khi La Hán tỉnh lại ở Lục Thanh quán, ai sẽ là kĩ nữ mà ông ta lựa chọn chuộc thân...?
Tập 8 mở ra với phân đoạn cao trào trong tập 2 tiểu thuyết nguyên tác, hé lộ bí mật về sự ra đời của Miêu Miêu...
* WINGS BOOKS - Thương hiệu sách trẻ của NXB Kim Đồng hân hạnh gửi đến các bạn độc giả phiên bản chuyển thể manga đặc sắc của bộ light-novel siêu ăn khách DƯỢC SƯ TỰ SỰ!
Series đã vượt mốc 13 triệu bản tại thị trường Nhật Bản, luôn thống trị bảng xếp hạng bán chạy mỗi khi ra tập mới!', '2024-05-11', '0000000065.jpg', 10),
('DM06', 'NXB01', N'Dược sư tự sự - Tập 8 (Manga)', N'Tuổi trưởng thành', 'A4', 130, 130, N'bìa mềm', 150000, N'La Hán thua một ván cờ tướng khi đấu với Miêu Miêu, phải uống rượu phạt và say bí tỉ. Trong mơ, ông ta nhớ về những chuyện xảy ra với người kĩ nữ năm xưa và cuộc gặp gỡ cùng con gái. Và rồi, sau khi La Hán tỉnh lại ở Lục Thanh quán, ai sẽ là kĩ nữ mà ông ta lựa chọn chuộc thân...?
Tập 8 mở ra với phân đoạn cao trào trong tập 2 tiểu thuyết nguyên tác, hé lộ bí mật về sự ra đời của Miêu Miêu...
* WINGS BOOKS - Thương hiệu sách trẻ của NXB Kim Đồng hân hạnh gửi đến các bạn độc giả phiên bản chuyển thể manga đặc sắc của bộ light-novel siêu ăn khách DƯỢC SƯ TỰ SỰ!
Series đã vượt mốc 13 triệu bản tại thị trường Nhật Bản, luôn thống trị bảng xếp hạng bán chạy mỗi khi ra tập mới!', '2024-05-11', '0000000066.jpg', 10),
('DM06', 'NXB01', N'Dược sư tự sự - Tập 9 (Manga)', N'Tuổi trưởng thành', 'A4', 130, 130, N'bìa mềm', 150000, N'La Hán thua một ván cờ tướng khi đấu với Miêu Miêu, phải uống rượu phạt và say bí tỉ. Trong mơ, ông ta nhớ về những chuyện xảy ra với người kĩ nữ năm xưa và cuộc gặp gỡ cùng con gái. Và rồi, sau khi La Hán tỉnh lại ở Lục Thanh quán, ai sẽ là kĩ nữ mà ông ta lựa chọn chuộc thân...?
Tập 8 mở ra với phân đoạn cao trào trong tập 2 tiểu thuyết nguyên tác, hé lộ bí mật về sự ra đời của Miêu Miêu...
* WINGS BOOKS - Thương hiệu sách trẻ của NXB Kim Đồng hân hạnh gửi đến các bạn độc giả phiên bản chuyển thể manga đặc sắc của bộ light-novel siêu ăn khách DƯỢC SƯ TỰ SỰ!
Series đã vượt mốc 13 triệu bản tại thị trường Nhật Bản, luôn thống trị bảng xếp hạng bán chạy mỗi khi ra tập mới!', '2024-05-11', '0000000067.jpg', 10),
('DM06', 'NXB01', N'Dược sư tự sự - Tập 10 (Manga)', N'Tuổi trưởng thành', 'A4', 130, 130, N'bìa mềm', 150000, N'La Hán thua một ván cờ tướng khi đấu với Miêu Miêu, phải uống rượu phạt và say bí tỉ. Trong mơ, ông ta nhớ về những chuyện xảy ra với người kĩ nữ năm xưa và cuộc gặp gỡ cùng con gái. Và rồi, sau khi La Hán tỉnh lại ở Lục Thanh quán, ai sẽ là kĩ nữ mà ông ta lựa chọn chuộc thân...?
Tập 8 mở ra với phân đoạn cao trào trong tập 2 tiểu thuyết nguyên tác, hé lộ bí mật về sự ra đời của Miêu Miêu...
* WINGS BOOKS - Thương hiệu sách trẻ của NXB Kim Đồng hân hạnh gửi đến các bạn độc giả phiên bản chuyển thể manga đặc sắc của bộ light-novel siêu ăn khách DƯỢC SƯ TỰ SỰ!
Series đã vượt mốc 13 triệu bản tại thị trường Nhật Bản, luôn thống trị bảng xếp hạng bán chạy mỗi khi ra tập mới!', '2024-05-11', '0000000068.jpg', 10),
-- DM07, NXB01
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Bạch Dương', N'Thiếu niên', 'A4', 80, 80, N'bìa cứng', 160000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000069.jpg', 10),
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Kim Ngưu', N'Thiếu niên', 'A4', 125, 125, N'bìa mềm', 80000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000070.jpg', 10),
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Song Tử', N'Thiếu niên', 'A4', 85, 85, N'bìa cứng', 80000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000071.jpg', 10),
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Cự Giải', N'Thiếu niên', 'A4', 115, 115, N'bìa mềm', 80000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000072.jpg', 10),
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Sư Tử', N'Thiếu niên', 'A4', 130, 130, N'bìa cứng', 90000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000073.jpg', 10),
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Xử Nữ', N'Thiếu niên', 'A4', 100, 100, N'bìa mềm', 92000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000074.jpg', 10),
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Thiên Bình', N'Thiếu niên', 'A4', 80, 80, N'bìa cứng', 96000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000075.jpg', 10),
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Bọ Cạp', N'Thiếu niên', 'A4', 125, 125, N'bìa mềm', 444000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000076.jpg', 10),
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Nhân Mã', N'Thiếu niên', 'A4', 85, 85, N'bìa cứng', 425000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000077.jpg', 10),
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Ma Kết', N'Thiếu niên', 'A4', 115, 115, N'bìa mềm', 490000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000078.jpg', 10),
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Bảo Bình', N'Thiếu niên', 'A4', 130, 130, N'bìa cứng', 382000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000079.jpg', 10),
('DM07', 'NXB01', N'Giải mã 12 chòm sao - Khám phá tất tần tật cung Song Ngư', N'Thiếu niên', 'A4', 100, 100, N'bìa mềm', 360000, N'Cùng nhau bước vào hành trình khám phá:

- Những điều cực thú vị về tính cách tiềm ẩn của bạn.

- Hiểu hơn về sở thích, ưu điểm, nhược điểm của bản thân.

- Hoàn thiện mình bằng cách phát huy các thế mạnh sẵn có của mỗi cung tuổi và khắc phục những điểm yếu trong tính cách của mình.

- Gỡ rối những xích mích với bạn bè và gà bông.

- Nhận ra những tố chất của bản thân, giúp có những lựa chọn nghề nghiệp, công việc phù hợp.', '2024-05-11', '0000000080.jpg', 10),
---- DM08, NXB01
('DM08', 'NXB01', N'Người hướng nội - Hướng dẫn sử dụng', N'Thiếu niên', 'A4', 80, 80, N'bìa cứng', 451000, N'Bạn có bị thu hút lạ lùng khi trông thấy bìa sách? Bạn có từng bị trách cứ là xa cách, dè dặt hay tâm hồn cứ để đâu đâu? Vậy thì có lẽ bạn chính là… NGƯỜI HƯỚNG NỘI.
Thế có nghĩa là gì? Một căn bệnh chăng? Hay một loại virus lạ? Một siêu năng lực? Hay một bản dạng bí mật? Tất cả đều không phải! Theo nhà phân tâm học nổi tiếng Carl Jung, “hướng nội” là một kiểu hình tâm lí xác định cách chúng ta quan tâm tới người khác, tới thế giới, tới tất cả những gì ngoài kia và cả chính ta. Theo đó, người hướng nội có xu hướng thu mình vào thế giới nội tâm riêng, suy nghĩ, cảm xúc, mộng mơ riêng mình, lấy năng lượng từ sự tĩnh lặng và cô độc.
Nếu bạn muốn biết nhiều hơn về những người hướng nội, nếu bạn còn băn khoăn không biết mình có phải người hướng nội hay không, nếu bạn muốn khám phá tập tính và đời sống của những người hướng nội, nếu bạn muốn “khóa mỏ” những kẻ ngáng đường ngăn bạn được là chính mình, nếu bạn muốn dõng dạc tuyên bố bản tính hướng nội của mình, thì Người Hướng Nội – Hướng Dẫn Sử Dụng chính là cuốn sách dành cho bạn! 
Người Hướng Nội – Hướng Dẫn Sử Dụng là cuốn cẩm nang phát triển cá tính trong thế giới khác biệt dành cho những người kín đáo, những kẻ rụt rè, những người khép kín, những kẻ mộng mơ, những người lặng lẽ, những kẻ cô độc, những người trầm tư, những kẻ kiệm lời, những người độc lập, những kẻ lãng đãng trên mây, những người bí hiểm, những kẻ tầm ngầm, những con mọt sách… Nếu bạn tìm thấy mình (hoặc một chút gì đó của mình) trong loạt tính từ dài thượt được liệt kê trên kia, còn chần chừ gì nữa, hãy cùng tìm hiểu ngay thôi nào!', '2024-05-11', '0000000081.jpg', 10),
('DM08', 'NXB01', N'Giáo dục nhi đồng', N'Tuổi trưởng thành', 'A4', 125, 125, N'bìa mềm', 239000, N'“Bản sách này ra đời có mục đích là giúp đường chỉ nẻo trong muôn một cho các ông cha bà mẹ muốn dạy con. Nó sẽ là người bạn của những bà mẹ hiền từ, rất thương con và muốn cho con nên người.”
(Lời nói đầu, Giáo dục nhi đồng)', '2024-05-11', '0000000082.jpg', 10),
('DM08', 'NXB01', N'Kinh nghiệm từ nước Nhật - 49 bí quyết giúp trẻ lắng nghe và truyền đạt', N'Tuổi trưởng thành', 'A4', 85, 85, N'bìa cứng', 265000, N'• Làm thế nào để lắng nghe câu chuyện của bạn bè một cách tốt nhất?
• Làm thế nào để trò chuyện một cách hiệu quả?
• Làm thế nào để giải quyết mâu thuẫn hay ngăn chặn một cuộc xung đột?
Ngày càng có nhiều trẻ em không giỏi lắng nghe câu chuyện của bạn bè và không biết cách thể hiện cảm xúc của chính mình, khả năng giải quyết các vấn đề thông qua giao tiếp tích cực của trẻ cũng gặp nhiều hạn chế.
Trong cuốn sách này, chúng tôi hướng dẫn trẻ có được các cách thức giao tiếp hiệu quả, thông qua các tình huống sinh động và minh hoạ hấp dẫn.
Đây là tài liệu cần thiết cho phụ huynh và giáo viên nuôi dạy nên những đứa trẻ giỏi giao tiếp và truyền đạt.', '2024-05-11', '0000000083.jpg', 10),
('DM08', 'NXB01', N'90% trẻ thông minh nhờ cách trò chuyện đúng đắn của cha mẹ (2023)', N'Tuổi trưởng thành', 'A4', 115, 115, N'bìa mềm', 268000, N'Bạn có bao giờ thốt ra những câu dù biết là không nên nói như  “Còn lề mề đến bao giờ nữa hả?” hay “Chẳng được cái trò trống gì, đưa đây xem nào!”… nhưng vẫn lỡ lời không?

Trong quá trình trẻ trưởng thành, những lời lẽ kiểu “Mày chẳng được cái tích sự gì!” trẻ phải nghe ngày ngày sẽ thẩm thấu qua vô thức, rồi sau đó trở thành ý thức coi mình chỉ là loại “vô dụng”. Không biết từ lúc nào, trẻ sẽ bắt đầu thực hiện những hành vi, lối sống không tốt.

Trong cuốn sách này, chúng tôi sẽ giới thiệu tới quý vị phụ huynh những câu nói “có phép lạ” khiến các con trở thành những đứa trẻ “tự có ý thức” mà cha mẹ không cần cằn nhằn nhiều. Hơn nữa, đây hoàn toàn là những câu chúng ta có thể áp dụng ngay từ ngày hôm nay như “Mẹ luôn đứng về phía con!”, “Mẹ con mình cùng làm nhé!”…

Về bản chất, mỗi đứa trẻ đều mang trong mình một “sức mạnh” tuyệt vời. Nhưng trước hết, chúng ta phải tin tưởng vào sức mạnh ấy đã! Khi được tin cậy, “sức mạnh” bên trong trẻ sẽ được nuôi dưỡng một cách tự nhiên.

Cuốn sách này sẽ giới thiệu cách trò chuyện giúp khai phá sức mạnh ấy từ nhiều góc độ. Chắc chắn không chỉ các con mà ngay cả chính các bậc phụ huynh cũng sẽ thay đổi. Cuộc sống sẽ lại một lần nữa trở nên thật tuyệt vời.

Cuốn sách này sẽ giúp mở rộng tiềm năng của trẻ tới vô hạn!', '2024-05-11', '0000000084.jpg', 10),
('DM08', 'NXB01', N'Mẹ các nước dạy con trưởng thành - Mẹ Do Thái dạy con tư duy', N'Tuổi trưởng thành', 'A4', 130, 130, N'bìa cứng', 299000, N'Bộ sách Mẹ Các Nước Dạy Con Trưởng Thành nằm trong Tủ Sách Làm Cha Mẹ. Đây là bộ sách để các bậc phụ huynh có thể tham khảo cách dạy dỗ và nuôi nấng con cái của nhiều người mẹ ở các quốc gia khác nhau. Mỗi dân tộc có những đặc trưng riêng về văn hóa cũng những quy tắc ứng xử, bộ sách là sự tiếp thu có chọn lọc những phẩm chất nổi bật đáng học tập nhất từ mỗi đất nước ấy.

Người Do Thái vốn nổi tiếng là có nhiều đức tính đáng ngưỡng mộ và học hỏi. Trong cuốn sách Mẹ Do Thái Dạy Con Tư Duy này, các bậc phụ huynh sẽ được tiếp thu những phương pháp dạy con trẻ biết giữ chữ tín, biết chia sẻ với mọi người xung quanh và biết quản lí tiền bạc ngay từ khi còn nhỏ.', '2024-05-11', '0000000085.jpg', 10),
('DM08', 'NXB01', N'Mẹ Việt nuôi dạy con kiểu Bắc Âu', N'Tuổi trưởng thành', 'A4', 100, 100, N'bìa mềm', 621000, N'', '2024-05-11', '0000000086.jpg', 10),
('DM08', 'NXB01', N'Từng ngày ba mẹ thở theo con', N'Tuổi trưởng thành', 'A4', 80, 80, N'bìa cứng', 317000, N'Ở tuổi sáu mươi, nhà thơ lãng tử bỗng trở thành một người cha, lần đầu tiên. Chính từ đây, rất nhiều “lần đầu tiên” khác được khám phá: Lần đầu tiên thức khuya dậy sớm trông con, lần đầu tiên lo âu thắt lòng khi con ốm, lần đầu tiên biết đến nỗi khắc khoải ngày con đi mẫu giáo, lần đầu tiên mơ ước xa xôi với nhân vật chính chẳng phải bản thân mà là con gái bé bỏng... Tất cả mọi tình huống gần gũi mà đặc biệt ấy được nhà thơ Lê Minh Quốc ghi lại tỉ mỉ thành một tập hợp xinh xắn những câu chuyện đan xen các vần thơ hóm hỉnh, bất ngờ và tràn đầy cảm xúc.  ', '2024-05-11', '0000000087.jpg', 10),
('DM08', 'NXB01', N'Kỉ luật mềm của trái tim - Mẹ Việt dạy con kiểu Nhật Bản (2022)', N'Tuổi trưởng thành', 'A4', 125, 125, N'bìa mềm', 54000, N'Trẻ cần gì nhất ở cha mẹ trong những năm tháng đầu đời?
Trẻ cần những trải nghiệm nào nhất trong giai đoạn ấu thơ?
Làm thế nào để vượt qua giai đoạn phản kháng và những cơn ăn vạ của con để mỗi ngày bên con thực sự là hành trình hạnh phúc và ý nghĩa?
Làm thế nào để nuôi dưỡng cho con những năng lực sống - kĩ năng sống cần thiết nhất sẽ theo con suốt cả cuộc đời sau này?
Cuốn sách Kỉ luật mềm của trái tim – Mẹ Việt dạy con kiểu Nhật Bản là sẽ trả lời cho những câu hỏi trên và những câu hỏi khác về nuôi dạy con của người Nhật Bản, thông qua chính những trải nghiệm thực tế của tác giả với hơn mười một năm ở Nhật vừa học tập, vừa làm mẹ, trong đó có sáu năm đồng hành chia sẻ những câu chuyện nuôi dạy con với các cha mẹ Việt Nam.', '2024-05-11', '0000000088.jpg', 10),
('DM08', 'NXB01', N'Nuôi dạy trẻ hướng nội', N'Tuổi trưởng thành', 'A4', 85, 85, N'bìa cứng', 388000, N'Khi nhắc đến đứa con hướng nội của mình, phụ huynh sẽ dùng từ gì để miêu tả nhỉ? Không mau mồm mau miệng, hay ngại ngùng, thiếu năng lực giao tiếp xã hội, không có nhiều bạn bè, cô lập, khép mình, không có chính kiến, thái độ tiêu cực, bi quan v.v… dường như đa số đều là những từ ngữ tiêu cực.

Nhưng thực ra, trẻ hướng nội có một thế giới nội tâm phong phú và đầy tiềm năng. Khi ấy, những bậc làm cha mẹ cần phải:

• Tinh tế, kiên nhẫn để thấy được vẻ đẹp lấp lánh trong tính cách của con;

• Biết khi nào cần hỗ trợ và hỗ trợ như thế nào để con phát huy sức mạnh của mình.

Cuốn sách NUÔI DẠY TRẺ HƯỚNG NỘI – Bí quyết phát huy tiềm năng của những người sống nội tâm sẽ đưa chúng ta tiến vào thế giới của những đứa trẻ hướng nội, đưa ra một số gợi ý ứng xử phù hợp với trẻ có thiên hướng tính cách hướng nội, để giúp trẻ phát huy tối đa tiềm năng của bản thân.', '2024-05-11', '0000000089.jpg', 10),
('DM08', 'NXB01', N'Vì sao trẻ không chịu ngồi yên?', N'Tuổi trưởng thành', 'A4', 115, 115, N'bìa mềm', 727000, N'Liệu con tôi có nên tập đi ở độ tuổi sơ sinh không?

Vì sao con tôi lại hậu đậu như vậy?

Làm cách nào để giúp con tôi đang bị kiệt sức?

Vì sao trẻ không chịu ngồi yên? là cuốn sách giúp cha mẹ tìm hiểu vai trò của vận động và vui chơi

đối với sự phát triển thể chất và trí tuệ của trẻ. Trong cuốn sách này, tác giả giải thích mối liên hệ giữa vận động và nhận thức. Sự kết hợp này chính là nền tảng cho sự phát triển của trẻ trên mọi phương diện.

EVELIEN VAN DORT (người Hà Lan) là một bác sĩ vật lí trị liệu cho trẻ em với hơn ba mươi năm kinh nghiệm. Evelien đã viết hơn bảy mươi cuốn sách cho thanh thiếu niên và nhi đồng. Những cuốn sách của cô được dịch ra nhiều ngôn ngữ. Thiên nhiên, tình bạn và động vật đóng một vai trò quan trọng trong những câu chuyện của cô. Là một người mẹ hai con, cô cho rằng thơ ca và những điều nhỏ bé, tích cực xung quanh sẽ giúp ta nhận ra những điều tốt đẹp nhất trong trái tim mình. Nhờ những cống hiến cho cộng đồng, cụ thể là các dự án đọc trong và ngoài nước, cô đã được phong tước hiệp sĩ.', '2024-05-11', '0000000090.jpg', 10);
INSERT INTO ChiTietTacGia
VALUES
	(1,1),(1,2),(1,3),
	(2,1),(2,2),(2,3),
	(3,1),(3,2),(3,3),
	(4,1),(4,2),(4,3),	
	(5,1),(5,2),(5,3),
	(6,1),(6,2),(6,3),
	(7,1),(7,2),(7,3),
	(8,1),(8,2),(8,3),
	(9,1),(9,2),(9,3),
	(10,1),(10,2),(10,3),
	(11,4),
	(12,5),(12,6),
	(13,7),(13,8),
	(14,9),(14,10),
	(15,11),
	(16,12),
	(17,13),
	(18,14),
	(19,15),
	(20,16),
	(21,17),(21,18),
	(22,17),(22,18),
	(23,17),(23,18),
	(24,17),(24,18),
	(25,17),(25,18),
	(26,17),(26,18),
	(27,17),(27,18),
	(28,17),(28,18),
	(29,17),(29,18),
	(30,19),
	(31,20),
	(32,20),
	(33,20),
	(34,20),
	(35,20),
	(36,20),
	(37,20),
	(38,20),
	(39,20),
	(40,20),
	(41,21),
	(42,22),
	(43,23),
	(44,24),
	(45,25),
	(46,26),
	(47,27),
	(48,28),
	(49,29),
	(50,30),
	(51,31),
	(52,32),(52,33),(52,34),
	(53,32),(53,33),(53,34),
	(54,32),(54,33),(54,34),
	(55,32),(55,33),(55,34),
	(56,32),(56,33),(56,34),
	(57,32),(57,33),(57,34),
	(58,32),(58,33),(58,34),
	(59,35),(59,36),(59,37),(59,38),
	(60,35),(60,36),(60,37),(60,38),
	(61,35),(61,36),(61,37),(61,38),
	(62,35),(62,36),(62,37),(62,38),
	(63,35),(63,36),(63,37),(63,38),
	(64,35),(64,36),(64,37),(64,38),
	(65,35),(65,36),(65,37),(65,38),
	(66,35),(66,36),(66,37),(66,38),
	(67,35),(67,36),(67,37),(67,38),
	(68,35),(68,36),(68,37),(68,38),
	(69,39),
	(70,39),
	(71,39),
	(72,39),
	(73,39),
	(74,39),
	(75,39),
	(76,39),
	(77,39),
	(78,39),
	(79,39),
	(80,39),	
	(81,40),(81,41),
	(82,42),
	(83,43),(83,44),
	(84,45),
	(85,46),
	(86,47),
	(87,48),
	(88,49),
	(89,50),
	(90,51);
	
	
























