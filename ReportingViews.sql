--**********************************************************************************************--
-- Title: Final_Assignment09
-- Author: RKobashigawa
-- Desc: This file creates reporting views of the application. First view shows date, days until 
-- next appointment,patient name, patient phone number, doctor name, and clinic name. 
-- The second view shows date, time, doctor and clinic name. This information
-- can be used by the receptionist to call a patient and remind them of upcoming appointments or
-- to avoid booking conflicting appointments with another patient. 
-- Change Log: When,Who,What
-- 2020-05-26,RKobashigawa, Create reporting view
-- 2020-05-27,Rkobashigawa, Create second view
--***********************************************************************************************--
-- Use DB

Use Assignment08_RKobashigawa;
Go

-- appointment reminder view, shows appintment date, number of days left to appointment, patient and clinic names
Create or Alter View vAppointmentReminder
	As
	Select
	Top 1000
	Convert(Date, a.[AppointmentDateTime]) as AppointmentDate,    -- Convert to date 
	DateDiff(Day, GetDate(), a.AppointmentDateTime) as DaysUntilAppointment, --get difference for appointment date and current date
	--Convert(nvarchar(15), Cast(a.[AppointmentDateTime] as Time), 100) as AppointmentTime, --Convert to time as AM or PM
	Concat(p.[PatientFirstName], ' ', p.[PatientLastName]) as PatientName, -- Combine first and last name
	p.[PatientPhoneNumber],
	--Concat(d.[DoctorFirstName], ' ', d.[DoctorLastName]) as DoctorName,   
	c.[ClinicName]
	From dbo.Appointments as a
	Join dbo.Clinics as c
	On a.AppointmentClinicID = c.ClinicID
	Join dbo.Patients as p
	On a.AppointmentPatientID = p.PatientID
	Join dbo.Doctors as d
	On a.AppointmentDoctorID = d.DoctorID
	Order By DaysUntilAppointment ASC; --sort by days until appintment least to greatest
Go

Select * From vAppointmentReminder;
Go

-- shows date, time, doctor name, and clinic information. This can be used 
Create or Alter View vAppointmentTime
	As
	Select
	Top 1000
	Convert(Date, a.[AppointmentDateTime]) as AppointmentDate,    -- Convert to date 
	Convert(nvarchar(15), Cast(a.[AppointmentDateTime] as Time), 100) as AppointmentTime, --Convert to time as AM or PM
	Concat(d.[DoctorFirstName], ' ', d.[DoctorLastName]) as DoctorName,   
	c.[ClinicName]
	From dbo.Appointments as a
	Join dbo.Clinics as c
	On a.AppointmentClinicID = c.ClinicID
	Join dbo.Patients as p
	On a.AppointmentPatientID = p.PatientID
	Join dbo.Doctors as d
	On a.AppointmentDoctorID = d.DoctorID
	Order By ClinicName; -- sort by clinic
Go

Select * From vAppointmentTime;
Go