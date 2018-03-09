-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 09, 2018 at 04:32 AM
-- Server version: 10.1.19-MariaDB
-- PHP Version: 7.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apotek`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_pembelian`
--

CREATE TABLE `detail_pembelian` (
  `ID_DETAIL_PEMBELIAN` int(11) NOT NULL,
  `KODE_OBAT` int(11) DEFAULT NULL,
  `ID_PEMBELIAN` int(11) DEFAULT NULL,
  `QTY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `ID_DETAIL_PENJUALAN` int(11) NOT NULL,
  `ID_PENJUALAN` int(11) DEFAULT NULL,
  `KODE_OBAT` int(11) DEFAULT NULL,
  `QTY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `ID_KARYAWAN` int(11) NOT NULL,
  `NAMA_KARYAWAN` varchar(64) DEFAULT NULL,
  `ALAMAT_KARYAWAN` text,
  `TELPON_KARYAWAN` varchar(20) DEFAULT NULL,
  `JABATAN` varchar(32) DEFAULT NULL,
  `USERNAME` varchar(64) DEFAULT NULL,
  `PASSWORD` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `karyawan`
--
DELIMITER $$
CREATE TRIGGER `delete_karyawan` BEFORE DELETE ON `karyawan` FOR EACH ROW BEGIN
delete from pembelian where id_pembelian=old.id_karyawan;
delete from penjualan where id_penjualan=old.id_karyawan;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `KODE_OBAT` int(11) NOT NULL,
  `NAMA_OBAT` varchar(64) DEFAULT NULL,
  `SATUAN` varchar(32) DEFAULT NULL,
  `STOK` int(11) DEFAULT NULL,
  `HARGA_BELI` int(11) DEFAULT NULL,
  `HARGA_JUAL` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`KODE_OBAT`, `NAMA_OBAT`, `SATUAN`, `STOK`, `HARGA_BELI`, `HARGA_JUAL`) VALUES
(1, 'paramex', 'tablet', 1, 10000, 11000);

--
-- Triggers `obat`
--
DELIMITER $$
CREATE TRIGGER `delete_obat` BEFORE DELETE ON `obat` FOR EACH ROW BEGIN
DELETE FROM detail_pembelian where id_detail_pembelian= old.kode_obat;
DELETE FROM detail_penjualan where id_detail_penjualan= old.kode_obat;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pembelian`
--

CREATE TABLE `pembelian` (
  `ID_PEMBELIAN` int(11) NOT NULL,
  `ID_KARYAWAN` int(11) DEFAULT NULL,
  `ID_SUPPLIER` int(11) DEFAULT NULL,
  `KETERANGAN` text,
  `TANGGAL` datetime DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `pembelian`
--
DELIMITER $$
CREATE TRIGGER `pembelian` BEFORE DELETE ON `pembelian` FOR EACH ROW BEGIN
delete from detail_pembelian where id_detail_pembelian=old.id_pembelian;
delete from supplier where id_supplier=old.id_pembelian;
delete FROM karyawan where id_karyawan=old.id_pembelian;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `ID_PENJUALAN` int(11) NOT NULL,
  `ID_KARYAWAN` int(11) DEFAULT NULL,
  `KODE_NOTA` varchar(5) DEFAULT NULL,
  `KETERANGAN` text,
  `TANGGAL` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `penjualan`
--
DELIMITER $$
CREATE TRIGGER `delete_penjualan` BEFORE DELETE ON `penjualan` FOR EACH ROW BEGIN
DELETE FROM detail_penjualan WHERE id_detail_penjualan=old.id_penjualan;
delete from karyawan WHERE id_karyawan=old.id_penjualan;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `ID_SUPPLIER` int(11) NOT NULL,
  `NAMA_SUPPLIER` varchar(1024) DEFAULT NULL,
  `ALAMAT_SUPPLIER` text,
  `TELPON_SUPPLIER` varchar(20) DEFAULT NULL,
  `EMAIL_SUPPLIER` varchar(64) DEFAULT NULL,
  `FAX_SUPPLIER` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `supplier`
--
DELIMITER $$
CREATE TRIGGER `delete_supplier` BEFORE DELETE ON `supplier` FOR EACH ROW BEGIN
delete from pembelian WHERE id_pembelian=old.id_supplier;
end
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  ADD PRIMARY KEY (`ID_DETAIL_PEMBELIAN`),
  ADD KEY `FK_RELATIONSHIP_3` (`KODE_OBAT`),
  ADD KEY `FK_RELATIONSHIP_7` (`ID_PEMBELIAN`);

--
-- Indexes for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD PRIMARY KEY (`ID_DETAIL_PENJUALAN`),
  ADD KEY `FK_RELATIONSHIP_1` (`KODE_OBAT`),
  ADD KEY `FK_RELATIONSHIP_6` (`ID_PENJUALAN`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`ID_KARYAWAN`);

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`KODE_OBAT`);

--
-- Indexes for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`ID_PEMBELIAN`),
  ADD KEY `FK_RELATIONSHIP_4` (`ID_KARYAWAN`),
  ADD KEY `FK_RELATIONSHIP_5` (`ID_SUPPLIER`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`ID_PENJUALAN`),
  ADD KEY `FK_RELATIONSHIP_2` (`ID_KARYAWAN`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`ID_SUPPLIER`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  ADD CONSTRAINT `FK_RELATIONSHIP_3` FOREIGN KEY (`KODE_OBAT`) REFERENCES `obat` (`KODE_OBAT`),
  ADD CONSTRAINT `FK_RELATIONSHIP_7` FOREIGN KEY (`ID_PEMBELIAN`) REFERENCES `pembelian` (`ID_PEMBELIAN`);

--
-- Constraints for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD CONSTRAINT `FK_RELATIONSHIP_1` FOREIGN KEY (`KODE_OBAT`) REFERENCES `obat` (`KODE_OBAT`),
  ADD CONSTRAINT `FK_RELATIONSHIP_6` FOREIGN KEY (`ID_PENJUALAN`) REFERENCES `penjualan` (`ID_PENJUALAN`);

--
-- Constraints for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD CONSTRAINT `FK_RELATIONSHIP_4` FOREIGN KEY (`ID_KARYAWAN`) REFERENCES `karyawan` (`ID_KARYAWAN`),
  ADD CONSTRAINT `FK_RELATIONSHIP_5` FOREIGN KEY (`ID_SUPPLIER`) REFERENCES `supplier` (`ID_SUPPLIER`);

--
-- Constraints for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `FK_RELATIONSHIP_2` FOREIGN KEY (`ID_KARYAWAN`) REFERENCES `karyawan` (`ID_KARYAWAN`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
