/*Jamies Queries*/

SELECT COUNT(Treatment.TreatmentID) AS "Treatment Count", Treatment.TreatmentName AS "Treatment", CONCAT(DoctorID,' ',DoctorStaff.Fname,' ',DoctorStaff.Lname) AS "Doctors Name & ID"
FROM (DoctorStaff
JOIN treatment ON treatment.treatmentid = doctorstaff.treatmentid)
GROUP BY treatment.treatmentid, DoctorID, doctorstaff.Fname, doctorstaff.Lname
ORDER BY "Treatment Count" desc;


/*Cams Query*/

SELECT WardSpeciality.WardName AS "Ward Name", WardSpeciality.SpecialityName AS "Speciality Name", 
CONCAT (NurseStaff.Fname, NurseStaff.Lname) AS "Nurse Staff" ,CONCAT (DoctorStaff.Fname, DoctorStaff.Lname) AS "Doctor Staff"
FROM ((WardSpeciality 
JOIN NurseStaff ON NurseStaff.Fname = NurseStaff.Lname)
JOIN DoctorStaff ON DoctorStaff.Fname = DoctorStaff.Lname);

/*Jacobs Queries*/

SELECT patientrecord.patientrecordid AS "Patient Record ID", CONCAT(patientrecord.fname, ' ',  patientrecord.sname) AS "Patient Name", treatment.treatmentname AS "Treatment Name", CONCAT(doctorstaff.fname, ' ', doctorstaff.lname) AS "Doctor Name"
FROM (((medicalhistory
JOIN patientrecord ON patientrecord.patientrecordid=medicalhistory.medicalrecordid)
JOIN treatment ON treatment.treatmentid=patientrecord.patientrecordid)
JOIN doctorstaff ON doctorstaff.doctorid=treatment.treatmentid)
ORDER BY patientrecord.fname desc;

SELECT COUNT(DISTINCT patientdoctors.patientid) AS "Number of patients", CONCAT(doctorstaff.fname,' ',doctorstaff.lname) AS "Doctor"
FROM ((patientdoctors
JOIN doctorstaff ON doctorstaff.doctorid = patientdoctors.doctorid)
JOIN medicalhistory ON medicalrecordid = doctorstaff.doctorid)
WHERE medicalhistory.dateadmitted BETWEEN '01/10/2016' AND '11/01/2019'
GROUP BY doctorstaff.fname, doctorstaff.lname;

