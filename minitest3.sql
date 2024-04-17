create database minitest3;

use minitest3;

create table VatTu (
id int primary key,
maVatTu varchar(255),
tenVatTu varchar(255),
donViTinh varchar(255),
giaTien double
);

create table TonKho (
id int primary key,
vatTu_id int,
soLuongDau int,
tongSoLuongNhap int,
tongSoLuongXuat int,
foreign key (vatTu_id) references VatTu(id)
);

create table NhaCungCap (
id int primary key,
maNhaCungCap varchar(255),
tenNhaCungCap varchar(255),
diaChi varchar(255),
soDienThoai varchar(255)
);

create table DonDatHang (
id int primary key,
maDon varchar(255),
ngayDatHang date,
nhaCungCap_id int,
foreign key (nhaCungCap_id) references NhaCungCap(id)
);

create table PhieuNhap (
id int primary key,
soPhieuNhap varchar(255),
ngayNhap date,
donHang_id int,
foreign key (donHang_id) references DonDatHang(id)
);

create table PhieuXuat (
id int primary key,
ngayXuat date,
tenKhachHang varchar(255)
);

create table CTDonHang (
id int primary key,
donHang_id int,
vatTu_id int,
soLuongDat int,foreign key (donHang_id) references DonDatHang(id),
foreign key (vatTu_id) references VatTu(id)
);

create table CTPhieuNhap (
id int primary key,
phieuNhap_id int,
vatTu_id int,
soLuongNhap int,
donGiaNhap double,
ghiChu varchar(255),
foreign key (phieuNhap_id) references PhieuNhap(id),
foreign key (vatTu_id) references VatTu(id)
);

create table CTPhieuXuat (
id int primary key,
phieuXuat_id int,
vatTu_id int,
soLuongXuat int,
donGiaXuat double,
ghiChu varchar(255),
foreign key (phieuXuat_id) references PhieuXuat(id),
foreign key (vatTu_id) references VatTu(id)
);

insert into VatTu (id, maVatTu, tenVatTu, donViTinh, giaTien) values
(1, '001', 'Ghế', 'bộ', 150),
(2, '002', 'Bàn', 'bộ', 100),
(3, '003', 'Búa', 'cái', 30),
(4, '004', 'tua vít', 'cái', 35),
(5, '005', 'Dây điện', 'cuộn', 45);

insert into TonKho (id, vatTu_id, soLuongDau, tongSoLuongNhap, tongSoLuongXuat) values
(1, 1, 50, 100, 100),
(2, 2, 50, 100, 100),
(3, 3, 5, 10, 7),
(4, 4, 10, 15, 10),
(5, 5, 3, 20, 8);

insert into NhaCungCap (id, maNhaCungCap, tenNhaCungCap, diaChi, soDienThoai) values
(1, '001', 'Tran Van A', 'TanBinh', '0283761047'),
(2, '002', 'Nguyen Van B', 'TanPhu', '0257834128'),
(3, '003', 'Tran Van C', 'PhuNhuan', '0857362756');

insert into DonDatHang (id, maDon, ngayDatHang, nhaCungCap_id) values
(1, '001', '2024-04-03', 1),
(2, '002', '2024-11-18', 2),
(3, '003', '2024-04-06', 3);

insert into PhieuNhap (id, soPhieuNhap, ngayNhap, donHang_id) values
(1, '35', '2024-06-18', 1),
(2, '78', '2024-01-30', 2),
(3, '42', '2024-08-03', 3);

insert into PhieuXuat (id, ngayXuat, tenKhachHang) values
(1, '2024-04-27', 'Tran Van A'),
(2, '2024-09-23', 'Tran Van B'),
(3, '2024-06-05', 'Tran Van C');

insert into CTDonHang (id, donHang_id, vatTu_id, soLuongDat) values
(1, 1, 1, '100'),
(2, 2, 2, '150'),
(3, 1, 3, '87'),
(4, 3, 4, '50'),
(5, 3, 4, '75'),
(6, 2, 3, '200');

insert into CTPhieuNhap (id, phieuNhap_id, vatTu_id, soLuongNhap, donGiaNhap, ghiChu) values
(1, 2, 1, '100', '150', 'ổn'),
(2, 3, 4, '50', '35', 'ổn'),
(3, 3, 5, '50', '45', 'ổn'),
(4, 1, 2, '75', '100', 'ổn'),
(5, 3, 3, '15', '30', 'ổn'),
(6, 2, 1, '45', '150', 'ổn');

insert into CTPhieuXuat (id, phieuXuat_id, vatTu_id, soLuongXuat, donGiaXuat, ghiChu) values
(1, 2, 1, '100', '25', 'ổn'),
(2, 3, 4, '50', '75', 'ổn'),
(3, 3, 5, '50', '15', 'ổn'),
(4, 1, 2, '75', '30', 'ổn'),
(5, 3, 3, '15', '18', 'ổn'),
(6, 2, 1, '45', '70', 'ổn');

-- Câu 1. Tạo view có tên vw_CTPNHAP bao gồm các thông tin sau: số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
create view vw_CTNHAP as
select PhieuNhap.soPhieuNhap,  VatTu.maVatTu, soLuongNhap, donGiaNhap, soLuongNhap*donGiaNhap as "thanh tien nhap" from CTPhieuNhap ctpn
inner join PhieuNhap on ctpn.phieuNhap_id = PhieuNhap.id
inner join vatTu on ctpn.vatTu_id = VatTu.id;

