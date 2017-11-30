-- MySQL Script generated by MySQL Workbench
-- Wed Nov 29 23:02:43 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema jungbokl_201_site
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema jungbokl_201_site
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jungbokl_201_site` DEFAULT CHARACTER SET utf8 ;
USE `jungbokl_201_site` ;

-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`schools`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`schools` (
  `idSchool` INT NOT NULL,
  `SchoolName` VARCHAR(45) NULL,
  `SchoolImage` VARCHAR(500) NULL,
  PRIMARY KEY (`idSchool`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`departments` (
  `idDepartment` INT NOT NULL,
  `longName` VARCHAR(45) NULL,
  `prefix` VARCHAR(45) NULL,
  `schools_idSchool` INT NOT NULL,
  PRIMARY KEY (`idDepartment`),
  INDEX `fk_departments_schools1_idx` (`schools_idSchool` ASC),
  CONSTRAINT `schools_idSchool`
    FOREIGN KEY (`schools_idSchool`)
    REFERENCES `jungbokl_201_site`.`schools` (`idSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`courses` (
  `idcourses` INT NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `units` INT NULL,
  `term` VARCHAR(45) NULL,
  `year` INT NULL,
  `departments_idDepartment` INT NOT NULL,
  PRIMARY KEY (`idcourses`, `departments_idDepartment`),
  INDEX `fk_courses_departments1_idx` (`departments_idDepartment` ASC),
  CONSTRAINT `fk_courses_departments1`
    FOREIGN KEY (`departments_idDepartment`)
    REFERENCES `jungbokl_201_site`.`departments` (`idDepartment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`staffMembers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`staffMembers` (
  `idstaffMembers` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `id` INT NULL,
  `email` VARCHAR(45) NULL,
  `fname` VARCHAR(45) NULL,
  `lname` VARCHAR(45) NULL,
  `image` VARCHAR(500) NULL,
  `phone` VARCHAR(45) NULL,
  `office` VARCHAR(45) NULL,
  PRIMARY KEY (`idstaffMembers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`meetings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`meetings` (
  `idmeetings` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `section` VARCHAR(45) NULL,
  `room` VARCHAR(45) NULL,
  PRIMARY KEY (`idmeetings`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`officeHours`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`officeHours` (
  `idofficeHours` INT NOT NULL,
  `day` VARCHAR(45) NULL,
  `time` VARCHAR(45) NULL,
  `staffMemberId` INT NULL,
  PRIMARY KEY (`idofficeHours`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`assistants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`assistants` (
  `idassistants` INT NOT NULL,
  `staffMemberID` INT NULL,
  `idmeetings` INT NULL,
  PRIMARY KEY (`idassistants`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`meetingPeriods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`meetingPeriods` (
  `idmeetingPeriods` INT NOT NULL,
  `day` VARCHAR(45) NULL,
  `time` VARCHAR(45) NULL,
  `idmeetings` INT NOT NULL,
  PRIMARY KEY (`idmeetingPeriods`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`textbooks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`textbooks` (
  `idtextbooks` INT NOT NULL,
  `number` INT NULL,
  `author` VARCHAR(100) NULL,
  `title` VARCHAR(100) NULL,
  `publisher` VARCHAR(100) NULL,
  `year` VARCHAR(45) NULL,
  `isbn` VARCHAR(45) NULL,
  `courses_idcourses` INT NOT NULL,
  PRIMARY KEY (`idtextbooks`, `courses_idcourses`),
  INDEX `fk_textbooks_courses1_idx` (`courses_idcourses` ASC),
  CONSTRAINT `fk_textbooks_courses1`
    FOREIGN KEY (`courses_idcourses`)
    REFERENCES `jungbokl_201_site`.`courses` (`idcourses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`syllabus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`syllabus` (
  `idsyllabus` INT NOT NULL,
  `url` VARCHAR(500) NULL,
  `courses_idcourses` INT NOT NULL,
  PRIMARY KEY (`idsyllabus`, `courses_idcourses`),
  INDEX `fk_syllabus_courses1_idx` (`courses_idcourses` ASC),
  CONSTRAINT `courses_idcourses`
    FOREIGN KEY (`courses_idcourses`)
    REFERENCES `jungbokl_201_site`.`courses` (`idcourses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`weeks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`weeks` (
  `idweeks` INT NOT NULL,
  `week` INT NULL,
  PRIMARY KEY (`idweeks`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`labs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`labs` (
  `idlabs` INT NOT NULL,
  `number` INT NULL,
  `title` VARCHAR(100) NULL,
  `url` VARCHAR(500) NULL,
  `idweeks` INT NULL,
  PRIMARY KEY (`idlabs`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`lectures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`lectures` (
  `idlectures` INT NOT NULL,
  `number` INT NULL,
  `date` VARCHAR(45) NULL,
  `day` VARCHAR(45) NULL,
  `chapters` VARCHAR(45) NULL,
  `idweeks` INT NULL,
  PRIMARY KEY (`idlectures`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`topics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`topics` (
  `idtopics` INT NOT NULL,
  `number` INT NULL,
  `title` VARCHAR(100) NULL,
  `url` VARCHAR(500) NULL,
  `idlectures` INT NULL,
  PRIMARY KEY (`idtopics`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`files`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`files` (
  `idfiles` INT NOT NULL,
  `number` INT NULL,
  `title` VARCHAR(100) NULL,
  `url` VARCHAR(500) NULL,
  `topicId` INT NULL,
  `testId` INT NULL,
  PRIMARY KEY (`idfiles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`assignments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`assignments` (
  `idassignments` INT NOT NULL,
  `number` VARCHAR(45) NULL,
  `assignedDate` VARCHAR(45) NULL,
  `dueDate` VARCHAR(45) NULL,
  `title` VARCHAR(45) NULL,
  `url` VARCHAR(500) NULL,
  `gradePercentage` VARCHAR(45) NULL,
  PRIMARY KEY (`idassignments`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`gradingCriteriaFiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`gradingCriteriaFiles` (
  `idgradingCriteriaFiles` INT NOT NULL,
  `number` INT NULL,
  `title` VARCHAR(45) NULL,
  `url` VARCHAR(500) NULL,
  `assignmentId` INT NULL,
  PRIMARY KEY (`idgradingCriteriaFiles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`deliverables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`deliverables` (
  `iddeliverables` INT NOT NULL,
  `number` VARCHAR(45) NULL,
  `title` VARCHAR(45) NULL,
  `duedate` VARCHAR(100) NULL,
  `gradePercentage` VARCHAR(45) NULL,
  `assignmentId` INT NULL,
  PRIMARY KEY (`iddeliverables`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`exams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`exams` (
  `idexams` INT NOT NULL,
  `semester` VARCHAR(45) NULL,
  `year` VARCHAR(45) NULL,
  PRIMARY KEY (`idexams`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`tests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`tests` (
  `idtests` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `idexams` INT NULL,
  PRIMARY KEY (`idtests`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`assignmentsFiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`assignmentsFiles` (
  `idassignmentsFiles` INT NOT NULL,
  `number` INT NULL,
  `title` VARCHAR(45) NULL,
  `url` VARCHAR(500) NULL,
  `assignmentId` INT NULL,
  PRIMARY KEY (`idassignmentsFiles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`solutionFiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`solutionFiles` (
  `idsolutionFiles` INT NOT NULL,
  `number` INT NULL,
  `title` VARCHAR(45) NULL,
  `url` VARCHAR(500) NULL,
  `assignmentId` INT NULL,
  PRIMARY KEY (`idsolutionFiles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jungbokl_201_site`.`deliverableFiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jungbokl_201_site`.`deliverableFiles` (
  `iddeliverableFiles` INT NOT NULL,
  `number` INT NULL,
  `title` VARCHAR(45) NULL,
  `url` VARCHAR(500) NULL,
  `deliverableId` INT NULL,
  PRIMARY KEY (`iddeliverableFiles`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;