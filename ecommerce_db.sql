-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2021 at 07:20 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `idbarang` int(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `idkategori` int(20) NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  `file_gambar` blob NOT NULL,
  `tampil` varchar(255) NOT NULL,
  `harga` int(11) NOT NULL,
  `berat` int(11) NOT NULL,
  `stok` int(11) NOT NULL,
  `tgl_insert` datetime NOT NULL,
  `tgl_update` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `idpenjualan` int(20) NOT NULL,
  `idbarang` int(20) NOT NULL,
  `qty` int(11) NOT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `idkategori` int(20) NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `konfirm_pembayaran`
--

CREATE TABLE `konfirm_pembayaran` (
  `idpenjualan` int(11) NOT NULL,
  `nama_bank` varchar(100) NOT NULL,
  `no_rekening` varchar(50) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `total_bayar` int(11) NOT NULL,
  `tgl_bayar` date NOT NULL,
  `scan_struk` varchar(200) NOT NULL,
  `verifikasi` varchar(200) NOT NULL,
  `idpetugas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `kota`
--

CREATE TABLE `kota` (
  `idkota` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `idprovinsi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `idpelanggan` int(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `password` varchar(30) NOT NULL,
  `jenis_kelamin` varchar(30) NOT NULL,
  `alamat` varchar(200) NOT NULL,
  `idkota` int(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telp` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `idpenjualan` int(20) NOT NULL,
  `idpelanggan` int(20) NOT NULL,
  `tgl_penjualan` date NOT NULL,
  `total_harga` int(11) NOT NULL,
  `total_item` int(11) NOT NULL,
  `total_berat` int(11) NOT NULL,
  `ongkir` int(11) NOT NULL,
  `jenis_pengiriman` varchar(50) NOT NULL,
  `nama_kirim` varchar(100) NOT NULL,
  `alamat_kirim` varchar(200) NOT NULL,
  `idkota_kirim` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `petugas`
--

CREATE TABLE `petugas` (
  `idpetugas` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `provinsi`
--

CREATE TABLE `provinsi` (
  `idprovinsi` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `idstatus` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `status_penjualan`
--

CREATE TABLE `status_penjualan` (
  `idpenjualan` int(11) NOT NULL,
  `idstatus` int(11) NOT NULL,
  `tgl_update` date NOT NULL,
  `idpetugas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tarif_ongkir`
--

CREATE TABLE `tarif_ongkir` (
  `idkota_tujuan` int(11) NOT NULL,
  `jenis_pengiriman` varchar(50) NOT NULL,
  `harga` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`idbarang`),
  ADD KEY `idkategori` (`idkategori`);

--
-- Indexes for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD PRIMARY KEY (`idpenjualan`,`idbarang`),
  ADD KEY `idpenjualan` (`idpenjualan`,`idbarang`),
  ADD KEY `idbarang` (`idbarang`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`idkategori`);

--
-- Indexes for table `konfirm_pembayaran`
--
ALTER TABLE `konfirm_pembayaran`
  ADD PRIMARY KEY (`idpenjualan`),
  ADD KEY `idpetugas` (`idpetugas`);

--
-- Indexes for table `kota`
--
ALTER TABLE `kota`
  ADD PRIMARY KEY (`idkota`),
  ADD KEY `idprovinsi` (`idprovinsi`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`idpelanggan`),
  ADD KEY `idkota` (`idkota`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`idpenjualan`),
  ADD KEY `idpelanggan` (`idpelanggan`,`idkota_kirim`),
  ADD KEY `jenis_pengiriman` (`jenis_pengiriman`),
  ADD KEY `idkota_kirim` (`idkota_kirim`);

--
-- Indexes for table `petugas`
--
ALTER TABLE `petugas`
  ADD PRIMARY KEY (`idpetugas`);

--
-- Indexes for table `provinsi`
--
ALTER TABLE `provinsi`
  ADD PRIMARY KEY (`idprovinsi`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`idstatus`);

--
-- Indexes for table `status_penjualan`
--
ALTER TABLE `status_penjualan`
  ADD PRIMARY KEY (`idpenjualan`,`idstatus`),
  ADD KEY `idpetugas` (`idpetugas`),
  ADD KEY `idpenjualan` (`idpenjualan`,`idstatus`),
  ADD KEY `idstatus` (`idstatus`);

--
-- Indexes for table `tarif_ongkir`
--
ALTER TABLE `tarif_ongkir`
  ADD PRIMARY KEY (`idkota_tujuan`,`jenis_pengiriman`),
  ADD KEY `idkota_tujuan` (`idkota_tujuan`,`jenis_pengiriman`),
  ADD KEY `jenis_pengiriman` (`jenis_pengiriman`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`idkategori`) REFERENCES `kategori` (`idkategori`);

--
-- Constraints for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD CONSTRAINT `detail_penjualan_ibfk_1` FOREIGN KEY (`idpenjualan`) REFERENCES `penjualan` (`idpenjualan`),
  ADD CONSTRAINT `detail_penjualan_ibfk_2` FOREIGN KEY (`idbarang`) REFERENCES `barang` (`idbarang`);

--
-- Constraints for table `konfirm_pembayaran`
--
ALTER TABLE `konfirm_pembayaran`
  ADD CONSTRAINT `konfirm_pembayaran_ibfk_1` FOREIGN KEY (`idpenjualan`) REFERENCES `penjualan` (`idpenjualan`),
  ADD CONSTRAINT `konfirm_pembayaran_ibfk_2` FOREIGN KEY (`idpetugas`) REFERENCES `petugas` (`idpetugas`);

--
-- Constraints for table `kota`
--
ALTER TABLE `kota`
  ADD CONSTRAINT `kota_ibfk_1` FOREIGN KEY (`idprovinsi`) REFERENCES `provinsi` (`idprovinsi`);

--
-- Constraints for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD CONSTRAINT `pelanggan_ibfk_1` FOREIGN KEY (`idkota`) REFERENCES `kota` (`idkota`);

--
-- Constraints for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `penjualan_ibfk_1` FOREIGN KEY (`idpelanggan`) REFERENCES `pelanggan` (`idpelanggan`),
  ADD CONSTRAINT `penjualan_ibfk_2` FOREIGN KEY (`idkota_kirim`) REFERENCES `kota` (`idkota`);

--
-- Constraints for table `status_penjualan`
--
ALTER TABLE `status_penjualan`
  ADD CONSTRAINT `status_penjualan_ibfk_1` FOREIGN KEY (`idpenjualan`) REFERENCES `penjualan` (`idpenjualan`),
  ADD CONSTRAINT `status_penjualan_ibfk_2` FOREIGN KEY (`idstatus`) REFERENCES `status` (`idstatus`),
  ADD CONSTRAINT `status_penjualan_ibfk_3` FOREIGN KEY (`idpetugas`) REFERENCES `petugas` (`idpetugas`);

--
-- Constraints for table `tarif_ongkir`
--
ALTER TABLE `tarif_ongkir`
  ADD CONSTRAINT `tarif_ongkir_ibfk_1` FOREIGN KEY (`idkota_tujuan`) REFERENCES `kota` (`idkota`),
  ADD CONSTRAINT `tarif_ongkir_ibfk_2` FOREIGN KEY (`jenis_pengiriman`) REFERENCES `penjualan` (`jenis_pengiriman`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
