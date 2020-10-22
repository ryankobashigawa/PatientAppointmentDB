--**********************************************************************************************--
-- Title: Final_Assignment09
-- Author: RKobashigawa
-- Desc: This file imports data into patients,doctors,clinics,appointment tables
-- Change Log: When,Who,What
-- 2020-05-26,RKobashigawa, import data from mockaroo
--***********************************************************************************************--
-- Use DB

Use Assignment08_RKobashigawa;
Go

--insert clinic data
insert into Clinics (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode) 
values ('Watson Clinic', '858-148-0540', '02 Old Shore Terrace', 'San Diego', 'WA', '92121');
insert into Clinics (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode)
values ('Zydus Clinic', '850-530-2441', '4 Lillian Plaza', 'Panama City', 'WA', '92405');
insert into Clinics (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode) 
values ('Glenview Clinic', '754-592-9776', '115 Reindahl Hill', 'Pompano Beach', 'WA', '93069');
insert into Clinics (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode) 
values ('Kroger Klinic', '757-275-0989', '069 Sunfield Trail', 'Hampton', 'WA', '93668');
insert into Clinics (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode)
values ('Sanum Clinic', '617-632-3324', '622 Clemons Point', 'Boston', 'WA', '92283');

--insert patient data
insert into Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode) values ('Andrei', 'Balke', '205-132-9718', '56577 Atwood Circle', 'Birmingham', 'WA', '95285');
insert into Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode) values ('Daron', 'Harsant', '312-667-7984', '2 Eagle Crest Lane', 'Chicago', 'WA', '90674');
insert into Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode) values ('Melantha', 'Pancost', '501-168-2935', '497 Glacier Hill Way', 'North Little Rock', 'WA', '92199');
insert into Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode) values ('Tammy', 'Duke', '571-574-9149', '60347 Marquette Plaza', 'Alexandria', 'WA', '92313');
insert into Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode) values ('Hanna', 'Hallgath', '901-847-1411', '2 Morning Lane', 'Memphis', 'WA', '98197');
insert into Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode) values ('Kerby', 'Fiorentino', '843-986-7814', '50838 Glacier Hill Place', 'Beaufort', 'WA', '99905');
insert into Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode) values ('Cassandra', 'Weatherby', '253-999-9539', '0 Dahle Court', 'Tacoma', 'WA', '98464');
insert into Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode) values ('Tiebout', 'Castanaga', '202-589-2455', '8415 Lake View Trail', 'Lynnwood', 'WA', '90599');
insert into Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode) values ('Hester', 'Churms', '218-882-0617', '03195 Kinsman Alley', 'Duluth', 'WA', '95805');
insert into Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode) values ('Percy', 'Tuke', '213-557-2555', '290 Myrtle Place', 'Los Angeles', 'WA', '90101');

--insert Doctors
insert into Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode) values ('Corty', 'Burnard', '253-210-4050', '6 Everett Parkway', 'Tacoma', 'WA', '98405');
insert into Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode) values ('Martainn', 'Bellord', '253-307-3067', '707 Old Shore Hill', 'Tacoma', 'WA', '98481');
insert into Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode) values ('Ikey', 'Coste', '360-807-4983', '87 Pennsylvania Point', 'Olympia', 'WA', '98506');
insert into Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode) values ('Gris', 'Birrane', '206-291-0221', '091 Rigney Trail', 'Seattle', 'WA', '98140');
insert into Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode) values ('Berenice', 'Kumar', '360-527-7105', '6 Dennis Lane', 'Seattle', 'WA', '98121');
insert into Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode) values ('Ryun', 'Deeprose', '509-106-3592', '98509 Redwing Trail', 'Spokane', 'WA', '99260');
insert into Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode) values ('Elyssa', 'Mansuer', '509-976-4731', '8 Holmberg Place', 'Spokane', 'WA', '99260');
insert into Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode) values ('Rafael', 'Petrak', '360-519-7861', '79 Dennis Junction', 'Vancouver', 'WA', '98682');
insert into Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode) values ('Ellynn', 'Yitzhakov', '425-878-8199', '4366 Claremont Place', 'Seattle', 'WA', '98140');
insert into Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode) values ('Britteny', 'Inman', '360-461-4700', '04393 8th Center', 'Vancouver', 'WA', '98664');

--insert appointment data
insert into Appointments (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID) values ('2020-12-15 18:40:51', 2, 2, 2);
insert into Appointments (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID) values ('2020-06-22 18:44:55', 3, 3, 3);
insert into Appointments (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID) values ('2021-02-26 16:02:23', 4, 4, 4);
insert into Appointments (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID) values ('2021-04-22 18:52:38', 5, 5, 5);
insert into Appointments (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID) values ('2021-04-20 07:05:37', 6, 6, 6);
insert into Appointments (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID) values ('2020-09-24 08:29:07', 7, 7, 2);
insert into Appointments (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID) values ('2020-11-11 08:27:27', 8, 8, 3);
insert into Appointments (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID) values ('2020-10-01 07:42:32', 9, 9, 4);
insert into Appointments (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID) values ('2021-02-20 10:22:44', 10, 10, 5);
insert into Appointments (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID) values ('2021-02-23 07:22:25', 11, 11, 6);

