-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 27 juin 2026 à 17:51
-- Version du serveur : 8.4.7
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `iam_dw`
--

-- --------------------------------------------------------

--
-- Structure de la table `dim_abonne`
--

DROP TABLE IF EXISTS `dim_abonne`;
CREATE TABLE IF NOT EXISTS `dim_abonne` (
  `id_dim_abonne` int NOT NULL AUTO_INCREMENT,
  `id_abonne` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nom` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prenom` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sexe` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` int DEFAULT NULL,
  `ville` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `csp` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_client` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_dim_abonne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dim_agence`
--

DROP TABLE IF EXISTS `dim_agence`;
CREATE TABLE IF NOT EXISTS `dim_agence` (
  `id_dim_agence` int NOT NULL AUTO_INCREMENT,
  `code_agence` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nom_agence` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ville` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_agence` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_dim_agence`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dim_date`
--

DROP TABLE IF EXISTS `dim_date`;
CREATE TABLE IF NOT EXISTS `dim_date` (
  `id_dim_date` int NOT NULL AUTO_INCREMENT,
  `date_complete` date DEFAULT NULL,
  `jour` int DEFAULT NULL,
  `mois` int DEFAULT NULL,
  `nom_mois` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trimestre` int DEFAULT NULL,
  `annee` int DEFAULT NULL,
  PRIMARY KEY (`id_dim_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dim_offre`
--

DROP TABLE IF EXISTS `dim_offre`;
CREATE TABLE IF NOT EXISTS `dim_offre` (
  `id_dim_offre` int NOT NULL AUTO_INCREMENT,
  `code_offre` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `libelle_offre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categorie` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `segment` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prix_mensuel` decimal(8,2) DEFAULT NULL,
  `type_facturation` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_dim_offre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fait_facture`
--

DROP TABLE IF EXISTS `fait_facture`;
CREATE TABLE IF NOT EXISTS `fait_facture` (
  `id_fait` int NOT NULL AUTO_INCREMENT,
  `id_facture` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_contrat` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_emission` date DEFAULT NULL,
  `montant_ht` decimal(10,2) DEFAULT NULL,
  `montant_tva` decimal(10,2) DEFAULT NULL,
  `montant_ttc` decimal(10,2) DEFAULT NULL,
  `statut_paiement` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `statut_montant` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_abonne` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_offre` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_agence` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_dim_agence` int DEFAULT NULL,
  `id_dim_abonne` int DEFAULT NULL,
  `id_dim_offre` int DEFAULT NULL,
  `id_dim_date` int DEFAULT NULL,
  PRIMARY KEY (`id_fait`),
  KEY `fk_fait_agence` (`code_agence`),
  KEY `fk_fait_abonne` (`id_abonne`),
  KEY `fk_fait_offre` (`code_offre`),
  KEY `idx_fk_dim_abonne` (`id_dim_abonne`),
  KEY `idx_fk_dim_offre` (`id_dim_offre`),
  KEY `idx_fk_dim_agence` (`id_dim_agence`),
  KEY `idx_fk_dim_date` (`id_dim_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `fait_facture`
--
ALTER TABLE `fait_facture`
  ADD CONSTRAINT `fk_fait_dim_abonne` FOREIGN KEY (`id_dim_abonne`) REFERENCES `dim_abonne` (`id_dim_abonne`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_fait_dim_agence` FOREIGN KEY (`id_dim_agence`) REFERENCES `dim_agence` (`id_dim_agence`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_fait_dim_date` FOREIGN KEY (`id_dim_date`) REFERENCES `dim_date` (`id_dim_date`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_fait_dim_offre` FOREIGN KEY (`id_dim_offre`) REFERENCES `dim_offre` (`id_dim_offre`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
