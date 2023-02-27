DROP DATABASE IF EXISTS `psychiatric-ward`;
CREATE DATABASE `psychiatric-ward`;
USE `psychiatric-ward`;

CREATE TABLE `user`(
	`UserID` INT NOT NULL AUTO_INCREMENT,
    `Login` VARCHAR(10) UNIQUE NOT NULL CHECK (`Login` REGEXP "^[a-zA-Z0-9_]*"),
	`Password` VARCHAR(20) NOT NULL CHECK (`Password` REGEXP "[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*"),
	`Email` VARCHAR(63) UNIQUE NOT NULL CHECK (`Email` REGEXP "^[a-zA-Z0-9][a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*?[a-zA-Z0-9._-]?@[a-zA-Z0-9][a-zA-Z0-9._-]*?[a-zA-Z0-9]?\\.[a-zA-Z]{2,63}$"),
	`MobileNumber` VARCHAR(14) UNIQUE NOT NULL CHECK (`MobileNumber` REGEXP '^[+][0-9]{4,13}$'),
	`FirstName` VARCHAR(20) NOT NULL,
    `LastName` VARCHAR(20) NOT NULL,
    `Sex` CHAR(1) NOT NULL CHECK (Sex in ('M', 'F', 'O')),
    `BirthDate` DATE NOT NULL,
	PRIMARY KEY(UserID)
) ;

CREATE TABLE `therapy`(
	`TherapyID` INT NOT NULL AUTO_INCREMENT,
    `Type` VARCHAR(30) NOT NULL,
    `TimesPerWeek` INT NOT NULL CHECK (1 <= TimesPerWeek <= 7),
	PRIMARY KEY(`TherapyID`)
);

CREATE TABLE `medication`(
	`MedicationID` INT NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(30) UNIQUE NOT NULL,
    `Price` FLOAT CHECK (Price > 0),
	PRIMARY KEY(`MedicationID`)
);

CREATE TABLE `treatment`(
	`TreatmentID` INT NOT NULL AUTO_INCREMENT,
    `TherapyID` INT,
    `Hospitalization` BOOL NOT NULL CHECK(`Hospitalization` in (0, 1)) ,
	PRIMARY KEY(`TreatmentID`),
	FOREIGN KEY (TherapyID) 
    REFERENCES therapy(TherapyID)
);

CREATE TABLE `disease`(
	`DiseaseID` INT NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(30) NOT NULL,
    `Symptoms` VARCHAR(100) NOT NULL,
    `Causes` VARCHAR(100) NOT NULL,
    `TreatmentID` INT NOT NULL,
	PRIMARY KEY(`DiseaseID`),
	FOREIGN KEY (TreatmentID) 
    REFERENCES treatment(TreatmentID)
);

CREATE TABLE `patient`(
	`PatientID` INT NOT NULL AUTO_INCREMENT,
	`UserID` INT NOT NULL, 
    `DiseaseID` INT,
    PRIMARY KEY (`PatientID`),
    FOREIGN KEY (DiseaseID) 
    REFERENCES disease(DiseaseID),
	FOREIGN KEY (UserID) 
    REFERENCES user(UserID)
) COMMENT="Patient has personal information";

CREATE TABLE `room`(
	`RoomID` INT NOT NULL AUTO_INCREMENT,
    `Specialization` VARCHAR(20),
    `Tools` VARCHAR(100),
	PRIMARY KEY(`RoomID`)
);

CREATE TABLE `doctor`(
	`DoctorID` INT NOT NULL AUTO_INCREMENT,
	`UserID` INT NOT NULL, 
    `Position` VARCHAR(20) NOT NULL,
    `Education` VARCHAR(20) NOT NULL,
    `RoomID` INT,
    PRIMARY KEY(`DoctorID`),
	FOREIGN KEY (RoomID) 
    REFERENCES room(RoomID),
	FOREIGN KEY (UserID) 
    REFERENCES user(UserID)
);

CREATE TABLE `appointment`(
	`AppointmentID` INT NOT NULL AUTO_INCREMENT,
    `DoctorID` INT NOT NULL,
    `PatientID` INT NOT NULL ,
	PRIMARY KEY(`AppointmentID`),
	FOREIGN KEY (DoctorID) 
    REFERENCES doctor(DoctorID),
	FOREIGN KEY (PatientID) 
    REFERENCES patient(PatientID)
);

CREATE TABLE `timetable`(
	`TimetableID` INT NOT NULL AUTO_INCREMENT,
    `Date` DATE NOT NULL,
    `Time` TIME NOT NULL,
    `AppointmentID` INT UNIQUE NOT NULL,
	PRIMARY KEY(`TimetableID`),
	FOREIGN KEY (AppointmentID) 
    REFERENCES appointment(AppointmentID)
);

CREATE TABLE `treatment_history`(
	`RecordID` INT NOT NULL AUTO_INCREMENT,
    `Observations` VARCHAR(100) NOT NULL,
	`PatientID` INT NOT NULL,
	PRIMARY KEY(`RecordID`),
	FOREIGN KEY (PatientID) 
    REFERENCES patient(PatientID)
);

CREATE TABLE `treatment_medication`(
	`TreatmentID` INT NOT NULL,
    `MedicationID` INT NOT NULL,
	PRIMARY KEY(`TreatmentID`, `MedicationID`),
	FOREIGN KEY (TreatmentID) 
    REFERENCES treatment(TreatmentID),
	FOREIGN KEY (MedicationID) 
    REFERENCES medication(MedicationID)
);

CREATE TABLE `user_log`(
	`UserID` INT NOT NULL AUTO_INCREMENT,
    `Login` VARCHAR(10) UNIQUE NOT NULL CHECK (`Login` REGEXP "^[a-zA-Z0-9_]*"),
	`Password` VARCHAR(20) NOT NULL CHECK (`Password` REGEXP "[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*"),
	`Email` VARCHAR(63) UNIQUE NOT NULL CHECK (`Email` REGEXP "^[a-zA-Z0-9][a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*?[a-zA-Z0-9._-]?@[a-zA-Z0-9][a-zA-Z0-9._-]*?[a-zA-Z0-9]?\\.[a-zA-Z]{2,63}$"),
	`MobileNumber` VARCHAR(14) UNIQUE NOT NULL CHECK (`MobileNumber` REGEXP '^[+][0-9]{4,13}$'),
	`FirstName` VARCHAR(20) NOT NULL,
    `LastName` VARCHAR(20) NOT NULL,
    `Sex` CHAR(1) NOT NULL CHECK (Sex in ('M', 'F', 'O')),
    `BirthDate` DATE NOT NULL,
	PRIMARY KEY(UserID)
) ;
