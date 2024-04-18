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

-- Câu 2. Tạo view có tên vw_CTPNHAP_VT bao gồm các thông tin sau: số phiếu nhập hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
create view vw_CTPNHAP_VT as
select PhieuNhap.soPhieuNhap, VatTu.maVatTu, VatTu.tenVatTu, soLuongNhap, donGiaNhap, soLuongNhap*donGiaNhap as "thanh tien nhap" from CTPhieuNhap ctpn 
inner join PhieuNhap on ctpn.phieuNhap_id = PhieuNhap.id
inner join vatTu on ctpn.vatTu_id = VatTu.id;

-- Câu 3. Tạo view có tên vw_CTPNHAP_VT_PN bao gồm các thông tin sau: số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
create view vw_CTPNHAP_VT_PN as
select PhieuNhap.soPhieuNhap, PhieuNhap.ngayNhap, DonDatHang.maDon, VatTu.maVatTu, VatTu.tenVatTu, soLuongNhap, donGiaNhap, soLuongNhap*donGiaNhap as "thanh tien nhap" from CTPhieuNhap ctpn
inner join PhieuNhap on ctpn.phieuNhap_id = PhieuNhap.id
inner join DonDatHang on PhieuNhap.donHang_id = DonDatHang.id
inner join vatTu on ctpn.vatTu_id = VatTu.id;

-- Câu 4. Tạo view có tên vw_CTPNHAP_VT_PN_DH bao gồm các thông tin sau: số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng, mã nhà cung cấp, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
create view vw_CTPNHAP_VT_PN_DH as
select PhieuNhap.soPhieuNhap, PhieuNhap.ngayNhap, DonDatHang.maDon, NhaCungCap.maNhaCungCap, VatTu.maVatTu, VatTu.tenVatTu, soLuongNhap, donGiaNhap, soLuongNhap*donGiaNhap as "thanh tien nhap" from CTPhieuNhap ctpn
inner join PhieuNhap on ctpn.phieuNhap_id = PhieuNhap.id
inner join DonDatHang on PhieuNhap.donHang_id = DonDatHang.id
inner join NhaCungCap on DonDatHang.nhaCungCap_id = NhaCungCap.id
inner join vatTu on ctpn.vatTu_id = VatTu.id;

-- Câu 5. Tạo view có tên vw_CTPNHAP_loc  bao gồm các thông tin sau: số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập. Và chỉ liệt kê các chi tiết nhập có số lượng nhập > 5.
create view vw_CTPNHAP_loc as
select PhieuNhap.soPhieuNhap, VatTu.maVatTu, soLuongNhap, donGiaNhap, soLuongNhap*donGiaNhap as "thanh tien nhap" from CTPhieuNhap ctpn
inner join PhieuNhap on ctpn.phieuNhap_id = PhieuNhap.id
inner join vatTu on ctpn.vatTu_id = VatTu.id
where soLuongNhap > 5;

-- Câu 6. Tạo view có tên vw_CTPNHAP_VT_loc bao gồm các thông tin sau: số phiếu nhập hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập. Và chỉ liệt kê các chi tiết nhập vật tư có đơn vị tính là Bộ
create view vw_CTPNHAP_VT_loc as
select PhieuNhap.soPhieuNhap, VatTu.maVatTu, VatTu.tenVatTu, soLuongNhap, donGiaNhap, soLuongNhap*donGiaNhap as "thanh tien nhap" from CTPhieuNhap ctpn
inner join PhieuNhap on ctpn.phieuNhap_id = PhieuNhap.id
inner join vatTu on ctpn.vatTu_id = VatTu.id
where donViTinh like "bộ";

-- Câu 7. Tạo view có tên vw_CTPXUAT bao gồm các thông tin sau: số phiếu xuất hàng, mã vật tư, số lượng xuất, đơn giá xuất, thành tiền xuất
create view vw_CTPXUAT as
select phieuXuat_id as "Số phiếu xuất hàng", VatTu.maVatTu, soLuongXuat, donGiaXuat, soLuongXuat*donGiaXuat as "thanh tien xuat" from CTPhieuXuat ctpx
inner join PhieuXuat on ctpx.phieuxuat_id = PhieuXuat.id
inner join vatTu on ctpx.vatTu_id = VatTu.id
group by phieuXuat_id, VatTu.maVatTu, soLuongXuat, donGiaXuat, soLuongXuat*donGiaXuat;

 -- Câu 8. Tạo view có tên vw_CTPXUAT_VT bao gồm các thông tin sau: số phiếu xuất hàng, mã vật tư, tên vật tư, số lượng xuất, đơn giá xuất.
 create view vw_CTPXUAT_VT as
 select phieuXuat_id as "Số phiếu xuất hàng", VatTu.maVatTu, VatTu.tenVatTu, soLuongXuat, donGiaXuat from CTPhieuXuat ctpx
 inner join PhieuXuat on ctpx.phieuxuat_id = PhieuXuat.id
 inner join vatTu on ctpx.vatTu_id = VatTu.id
 group by phieuXuat_id, VatTu.maVatTu, VatTu.tenVatTu, soLuongXuat, donGiaXuat;

-- Câu 9. Tạo view có tên vw_CTPXUAT_VT_PX bao gồm các thông tin sau: số phiếu xuất hàng, tên khách hàng, mã vật tư, tên vật tư, số lượng xuất, đơn giá xuất.
create view vw_CTPXUAT_VT_PX as
select phieuXuat_id as "Số phiếu xuất hàng", tenKhachHang, VatTu.maVatTu, VatTu.tenVatTu, soLuongXuat, donGiaXuat from CTPhieuXuat ctpx
inner join PhieuXuat on ctpx.phieuxuat_id = PhieuXuat.id
inner join vatTu on ctpx.vatTu_id = VatTu.id
group by phieuXuat_id, tenKhachHang, VatTu.maVatTu, VatTu.tenVatTu, soLuongXuat, donGiaXuat;

-- Tạo các stored procedure sau

-- Câu 1. Tạo Stored procedure (SP) cho biết tổng số lượng cuối của vật tư với mã vật tư là tham số vào.
