-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 18-Mar-2019 às 00:49
-- Versão do servidor: 5.7.21
-- PHP Version: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pizzaria_01`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `cardapio`
--

DROP TABLE IF EXISTS `cardapio`;
CREATE TABLE IF NOT EXISTS `cardapio` (
  `car_cod` int(11) NOT NULL AUTO_INCREMENT,
  `car_descricao` varchar(80) NOT NULL,
  `car_tipo` varchar(80) NOT NULL,
  `car_valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`car_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `cardapio`
--

INSERT INTO `cardapio` (`car_cod`, `car_descricao`, `car_tipo`, `car_valor`) VALUES
(1, 'Pizza Calabreza', 'Media', '20.00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `cli_cod` int(11) NOT NULL AUTO_INCREMENT,
  `cli_nome` varchar(80) NOT NULL,
  `cli_rua` varchar(80) NOT NULL,
  `cli_bairro` varchar(80) NOT NULL,
  `cli_telefone` varchar(80) NOT NULL,
  `cli_data_cad` date NOT NULL,
  PRIMARY KEY (`cli_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `clientes`
--

INSERT INTO `clientes` (`cli_cod`, `cli_nome`, `cli_rua`, `cli_bairro`, `cli_telefone`, `cli_data_cad`) VALUES
(1, 'Jonathan Saldanha', 'Holanda', 'Alexandria', '980634913', '2019-03-17');

-- --------------------------------------------------------

--
-- Estrutura da tabela `entregador`
--

DROP TABLE IF EXISTS `entregador`;
CREATE TABLE IF NOT EXISTS `entregador` (
  `ent_cod` int(11) NOT NULL AUTO_INCREMENT,
  `ent_nome` varchar(80) NOT NULL,
  `ent_status` varchar(80) NOT NULL,
  `ent_data_cad` date NOT NULL,
  PRIMARY KEY (`ent_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `entregador`
--

INSERT INTO `entregador` (`ent_cod`, `ent_nome`, `ent_status`, `ent_data_cad`) VALUES
(1, 'Kelly', 'A', '2019-03-17');

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
CREATE TABLE IF NOT EXISTS `funcionarios` (
  `fun_cod` int(11) NOT NULL AUTO_INCREMENT,
  `fun_nome` varchar(80) NOT NULL,
  `fun_cargo` varchar(80) NOT NULL,
  `fun_permissao` varchar(80) NOT NULL,
  `fun_data_cad` date NOT NULL,
  PRIMARY KEY (`fun_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `funcionarios`
--

INSERT INTO `funcionarios` (`fun_cod`, `fun_nome`, `fun_cargo`, `fun_permissao`, `fun_data_cad`) VALUES
(1, 'Murilo', 'Atendente', 'a', '2019-03-17');

-- --------------------------------------------------------

--
-- Estrutura da tabela `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `item_cod` int(11) NOT NULL AUTO_INCREMENT,
  `item_ent_cod` int(11) NOT NULL,
  `item_fun_cod` int(11) NOT NULL,
  `item_cli_cod` int(11) NOT NULL,
  `item_ped_cod` int(11) NOT NULL,
  `item_car_cod` int(11) NOT NULL,
  `item_quantidade` int(11) NOT NULL,
  PRIMARY KEY (`item_cod`,`item_ent_cod`,`item_cli_cod`,`item_ped_cod`,`item_car_cod`,`item_quantidade`),
  KEY `ItemPedido` (`item_ped_cod`,`item_cli_cod`,`item_fun_cod`,`item_ent_cod`),
  KEY `ItemCardapio` (`item_car_cod`),
  KEY `ItemEntregador` (`item_ent_cod`),
  KEY `ItemFuncionario` (`item_fun_cod`),
  KEY `ItemCliente` (`item_cli_cod`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE IF NOT EXISTS `pedidos` (
  `ped_cod` int(11) NOT NULL AUTO_INCREMENT,
  `ped_data` date NOT NULL,
  `ped_total` decimal(10,2) NOT NULL,
  `ped_cli_cod` int(10) NOT NULL,
  `ped_ent_cod` int(10) NOT NULL,
  `ped_fun_cod` int(10) NOT NULL,
  PRIMARY KEY (`ped_cod`),
  KEY `ped_fun_cod` (`ped_fun_cod`),
  KEY `ped_ent_cod` (`ped_ent_cod`),
  KEY `PedidoFuncionario` (`ped_cli_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `pedidos`
--

INSERT INTO `pedidos` (`ped_cod`, `ped_data`, `ped_total`, `ped_cli_cod`, `ped_ent_cod`, `ped_fun_cod`) VALUES
(3, '2019-03-17', '600.00', 1, 1, 1);

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `ItemCardapio` FOREIGN KEY (`item_car_cod`) REFERENCES `cardapio` (`car_cod`),
  ADD CONSTRAINT `ItemCliente` FOREIGN KEY (`item_cli_cod`) REFERENCES `clientes` (`cli_cod`),
  ADD CONSTRAINT `ItemEntregador` FOREIGN KEY (`item_ent_cod`) REFERENCES `entregador` (`ent_cod`),
  ADD CONSTRAINT `ItemFuncionario` FOREIGN KEY (`item_fun_cod`) REFERENCES `funcionarios` (`fun_cod`),
  ADD CONSTRAINT `ItemPedido` FOREIGN KEY (`item_ped_cod`) REFERENCES `pedidos` (`ped_cod`);

--
-- Limitadores para a tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `ClientePedido` FOREIGN KEY (`ped_cli_cod`) REFERENCES `clientes` (`cli_cod`),
  ADD CONSTRAINT `EntregadorPedido` FOREIGN KEY (`ped_ent_cod`) REFERENCES `entregador` (`ent_cod`),
  ADD CONSTRAINT `FuncionarioPedido` FOREIGN KEY (`ped_fun_cod`) REFERENCES `funcionarios` (`fun_cod`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
