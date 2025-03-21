Create database football_db;

USE football_db;

-- Entitas Kuat (5)
CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(101),
    no_telepon VARCHAR(26),
    tanggal_daftar DATE
);

CREATE TABLE karyawan (
    id_karyawan INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(101),
    no_telepon VARCHAR(26)
);

CREATE TABLE lapangan (
    id_lapangan INT PRIMARY KEY AUTO_INCREMENT,
    kapasitas INT,
    harga_per_jam DECIMAL(10,2),
    ukuran VARCHAR(51)
);

CREATE TABLE promo (
    id_promo INT PRIMARY KEY AUTO_INCREMENT,
    potongan DECIMAL(10,2)
);

CREATE TABLE pemesanan (
    id_pemesanan INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    id_karyawan INT,
    id_lapangan INT,
    id_promo INT NULL,
    tanggal_pemesanan DATE,
    waktu_mulai TIME,
    waktu_selesai TIME,
    durasi INT, -- diinput manual
    total_harga DECIMAL(10,2),
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan),
    FOREIGN KEY (id_lapangan) REFERENCES lapangan(id_lapangan),
    FOREIGN KEY (id_promo) REFERENCES promo(id_promo),
    FOREIGN KEY (id_karyawan) REFERENCES karyawan(id_karyawan)
);

CREATE TABLE transaksi (
    id_transaksi INT PRIMARY KEY AUTO_INCREMENT,
    id_pemesanan INT NOT NULL,
    id_karyawan INT NOT NULL,
    total_bayar DECIMAL(10,2),
    metode_pembayaran ENUM('Tunai', 'Transfer', 'E-wallet'),
    status_pembayaran ENUM('Belum Lunas', 'Lunas', 'Pending', 'Dibatalkan'),
    tanggal_transaksi DATE,
    FOREIGN KEY (id_pemesanan) REFERENCES pemesanan(id_pemesanan),
    FOREIGN KEY (id_karyawan) REFERENCES karyawan(id_karyawan)
);


CREATE TABLE jadwal (
    id_jadwal INT PRIMARY KEY AUTO_INCREMENT,
    id_lapangan INT,
    hari ENUM('Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'),
    jam_buka TIME,
    jam_tutup TIME,
    FOREIGN KEY (id_lapangan) REFERENCES lapangan(id_lapangan)
);

CREATE TABLE fasilitas_lapangan (
    id_fasilitas INT PRIMARY KEY AUTO_INCREMENT,
    id_lapangan INT,
    nama_fasilitas VARCHAR(101),
    kondisi ENUM('Baik', 'Sedang', 'Rusak', 'Tidak Tersedia'),
    FOREIGN KEY (id_lapangan) REFERENCES lapangan(id_lapangan)
);



-- syntax for modification
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'football_db';

ALTER TABLE pemesanan 
ADD COLUMN id_karyawan INT,
ADD FOREIGN KEY (id_karyawan) REFERENCES karyawan(id_karyawan);

ALTER TABLE transaksi 
ADD COLUMN id_karyawan INT NOT NULL,
ADD FOREIGN KEY (id_karyawan) REFERENCES karyawan(id_karyawan);

DROP TABLE IF EXISTS pemesanan;
DROP TABLE IF EXISTS transaksi;


