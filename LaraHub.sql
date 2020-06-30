SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`profil`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`profil` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nama_lengkap` VARCHAR(255) NOT NULL ,
  `gender` VARCHAR(255) NOT NULL ,
  `alamat` VARCHAR(255) NOT NULL ,
  `photo` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pertanyaan`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`pertanyaan` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `isi` VARCHAR(400) NOT NULL ,
  `tanggal_dibuat` DATETIME NOT NULL ,
  `tanggal_diperbaharui` DATETIME NOT NULL ,
  `user_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_pertanyaan_user` (`user_id` ASC) ,
  CONSTRAINT `fk_pertanyaan_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `mydb`.`profil` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`jawaban`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`jawaban` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `isi` VARCHAR(400) NOT NULL ,
  `tanggal_dibuat` DATETIME NOT NULL ,
  `user_id` INT NOT NULL ,
  `pertanyaan_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_jawaban_user1` (`user_id` ASC) ,
  INDEX `fk_jawaban_pertanyaan1` (`pertanyaan_id` ASC) ,
  CONSTRAINT `fk_jawaban_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `mydb`.`profil` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jawaban_pertanyaan1`
    FOREIGN KEY (`pertanyaan_id` )
    REFERENCES `mydb`.`pertanyaan` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`komentar`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`komentar` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `isi` VARCHAR(400) NOT NULL ,
  `tanggal_dibuat` DATETIME NOT NULL ,
  `tanggal_diperbaharui` DATETIME NOT NULL ,
  `pemberi_komentar_id` INT NOT NULL ,
  `jawaban_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_komentar_user1` (`pemberi_komentar_id` ASC) ,
  INDEX `fk_komentar_jawaban_jawaban1` (`jawaban_id` ASC) ,
  CONSTRAINT `fk_komentar_user10`
    FOREIGN KEY (`pemberi_komentar_id` )
    REFERENCES `mydb`.`profil` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_komentar_jawaban_jawaban1`
    FOREIGN KEY (`jawaban_id` )
    REFERENCES `mydb`.`jawaban` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nama` VARCHAR(255) NOT NULL ,
  `email` VARCHAR(255) NOT NULL ,
  `password` VARCHAR(255) NOT NULL ,
  `profil_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  INDEX `fk_user_profil1` (`profil_id` ASC) ,
  CONSTRAINT `fk_user_profil1`
    FOREIGN KEY (`profil_id` )
    REFERENCES `mydb`.`profil` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vote`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`vote` (
  `pertanyaan_id` INT NOT NULL ,
  `jawaban_id` INT NOT NULL ,
  `like` INT(11) NULL ,
  `dislike` INT(11) NULL ,
  PRIMARY KEY (`pertanyaan_id`, `jawaban_id`) ,
  INDEX `fk_pertanyaan_has_jawaban_pertanyaan1` (`pertanyaan_id` ASC) ,
  INDEX `fk_pertanyaan_has_jawaban_jawaban1` (`jawaban_id` ASC) ,
  CONSTRAINT `fk_pertanyaan_has_jawaban_pertanyaan1`
    FOREIGN KEY (`pertanyaan_id` )
    REFERENCES `mydb`.`pertanyaan` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pertanyaan_has_jawaban_jawaban1`
    FOREIGN KEY (`jawaban_id` )
    REFERENCES `mydb`.`jawaban` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
