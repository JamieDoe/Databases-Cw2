CREATE DATABASE hospital_db;

CREATE TABLE WardRecord (
  WardRecordID CHAR(6) UNIQUE,
  SpecialityID CHAR(6),
  WardName VARCHAR(15),
  PRIMARY KEY (WardRecordID)
);

CREATE TABLE Ward (
  WardName VARCHAR(15) UNIQUE,
  HeadNurseID CHAR(6),
  NurseID CHAR(6),
  WardRecordID CHAR(6),
  PRIMARY KEY (WardName)
);

CREATE TABLE Patient (
  PatientID CHAR(6) UNIQUE,
  PatientRecordID CHAR(6),
  DoctorID CHAR(6),
  PRIMARY KEY (PatientID)
);

CREATE TABLE MedicalHistory (
  MedicalRecordID VARCHAR(10) UNIQUE,
  Complaint VARCHAR(40),
  TreatmentDescription VARCHAR(40),
  DateAdmitted DATE,
  DateDischarged DATE,
  DTS DATE,
  DTE DATE,
  PatientRecordID CHAR(6),
  DoctorID CHAR(6),
  TreatmentID CHAR(6),
  PRIMARY KEY (MedicalRecordID)
);

CREATE TABLE PatientTreatment (
  TreatmentID VARCHAR(10),
  PatientID CHAR(6) UNIQUE
);

CREATE TABLE NurseStaff (
  NurseID CHAR(6) UNIQUE,
  Fname VARCHAR(20),
  Lname VARCHAR(20),
  WardName CHAR(6),
  PRIMARY KEY (NurseID)
);

CREATE TABLE DoctorStaff (
  DoctorID CHAR(6) UNIQUE,
  Fname VARCHAR(20),
  Lname VARCHAR(20),
  PatientID CHAR(6),
  TreatmentID CHAR(10),
  PRIMARY KEY (DoctorID)
);

CREATE TABLE PatientDoctors (
  PatientID CHAR(6) UNIQUE,
  DoctorID CHAR(6) UNIQUE
);

CREATE TABLE PatientRecord (
  PatientRecordID CHAR(6) UNIQUE,
  Fname VARCHAR(20),
  Sname VARCHAR(20),
  DOB DATE,
  GPFname VARCHAR(20),
  GPLname VARCHAR(20),
  GPAddress VARCHAR(100),
  PatientID CHAR(6),
  MedicalRecordID VARCHAR(10),
  PRIMARY KEY (PatientRecordID)
);

CREATE TABLE WardSpeciality (
  SpecialityID CHAR(6) UNIQUE,
  SpecialityName VARCHAR(50),
  WardName VARCHAR(15),
  PRIMARY KEY (SpecialityID)
);

CREATE TABLE Treatment (
  TreatmentID CHAR(10) UNIQUE,
  TreatmentName VARCHAR(50),
  PRIMARY KEY (TreatmentID)
);


/* Adding the FK constraints to all tables and PK's t0 intersection tables */

/* constraints and PK's for PatientTreatment */

ALTER TABLE PatientTreatment ADD PRIMARY KEY(TreatmentID, PatientID);
ALTER TABLE PatientTreatment ADD CONSTRAINT TreatmentFK FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID);
ALTER TABLE PatientTreatment ADD CONSTRAINT PatientFK FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

/* constraints and PK's for PatientDoctors */

ALTER TABLE PatientDoctors ADD PRIMARY KEY(PatientID, DoctorID);
ALTER TABLE PatientDoctors ADD CONSTRAINT DoctorIDFK FOREIGN KEY (DoctorID) REFERENCES DoctorStaff(DoctorID);
ALTER TABLE PatientDoctors ADD CONSTRAINT PatientIDFK FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

/* constrains for WardRecord */

ALTER TABLE WardRecord ADD CONSTRAINT SpecialityFK FOREIGN KEY (SpecialityID) REFERENCES WardSpeciality(SpecialityID);
ALTER TABLE WardRecord ADD CONSTRAINT WardFK FOREIGN KEY (WardName) REFERENCES Ward(WardName);

/* constraints for Ward */

ALTER TABLE Ward ADD CONSTRAINT NurseFK FOREIGN KEY (NurseID) REFERENCES NurseStaff(NurseID);
ALTER TABLE Ward ADD CONSTRAINT WardRecordFK FOREIGN KEY (WardRecordID) REFERENCES WardRecord(WardRecordID);

/* constraints for Patient */

ALTER TABLE Patient ADD CONSTRAINT PatientRecordIDFK FOREIGN KEY (PatientRecordID) REFERENCES PatientRecord(PatientRecordID);
ALTER TABLE Patient ADD CONSTRAINT DoctorIDFK FOREIGN KEY (DoctorID) REFERENCES DoctorStaff(DoctorID);

/* constraints for MedicalHistory */

ALTER TABLE MedicalHistory ADD CONSTRAINT PatientRecordIDFK FOREIGN KEY (PatientRecordID) REFERENCES PatientRecord(PatientRecordID);
ALTER TABLE MedicalHistory ADD CONSTRAINT DoctorIDFK FOREIGN KEY (DoctorID) REFERENCES DoctorStaff(DoctorID);

ALTER TABLE MedicalHistory ADD CONSTRAINT TreatmentIDFK FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID);

/* constraints for NurseStaff */

ALTER TABLE NurseStaff ADD CONSTRAINT WardNameFK FOREIGN KEY (WardName) REFERENCES Ward(WardName);

/* constraints for DoctorStaff */

ALTER TABLE DoctorStaff ADD CONSTRAINT PatientIDFK FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);
ALTER TABLE DoctorStaff ADD CONSTRAINT TreatmentIDFK FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID);

/* constraints for PatientRecord */

ALTER TABLE PatientRecord ADD CONSTRAINT MedicalRecordIDFK FOREIGN KEY (MedicalRecordID) REFERENCES MedicalHistory(MedicalRecordID);
ALTER TABLE PatientRecord ADD CONSTRAINT PatientIDFK FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

/* constraints for WardSpeciality */

ALTER TABLE WardSpeciality ADD CONSTRAINT WardNameFK FOREIGN KEY (WardName) REFERENCES Ward(WardName);

