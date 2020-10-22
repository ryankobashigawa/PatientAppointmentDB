--**********************************************************************************************--
-- Title: Final_Assignment08
-- Author: RKobashigawa
-- Desc: This file demonstrates how to design and create; 
--       tables, constraints, views, stored procedures, and permissions
-- Change Log: When,Who,What
-- 2020-05-21,RKobashigawa,Created File, created tables, created views, create/test sprocs
-- 2020-05-22, RKobashigawa, set permissions
--***********************************************************************************************--
-- Use DB as needed

Begin Try
	Use Master;
	If Exists(Select Name From SysDatabases Where Name = 'Assignment08_RKobashigawa')
	 Begin 
	  Alter Database [Assignment08_RKobashigawa] set Single_user With Rollback Immediate;
	  Drop Database Assignment08_RKobashigawa;
	 End
	Create Database Assignment08_RKobashigawa;
End Try
Begin Catch
	Print Error_Number();
End Catch
Go
Use Assignment08_RKobashigawa;
Go

/* Creating the tables and adding constraints */

-- Creates a table for the clinics 
Create Table Clinics (
	ClinicID Int Primary Key Identity Not Null,
	ClinicName nvarchar(100) Not Null,
	ClinicPhoneNumber nvarchar(100) Not Null,
    ClinicAddress nvarchar(100) Not Null,
	ClinicCity nvarchar(100) Not Null,
	ClinicState nchar(2) Not Null,
	ClinicZipCode nvarchar(10) Not Null
);
Go

Alter Table dbo.Clinics
	Add 
		Constraint uniqueClinicName Unique (ClinicName),
		Constraint checkClinicPhoneNumber Check (ClinicPhoneNumber Like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
		Constraint checkClinicZipCode Check (ClinicZipCode Like '[0-9][0-9][0-9][0-9][0-9]' Or
			ClinicZipCode Like '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' );
Go

-- Creates a table for patients
Create Table Patients (
	PatientID Int Primary Key Identity Not Null,
	PatientFirstName nvarchar(100) Not Null,
	PatientLastName nvarchar(100) Not Null,
	PatientPhoneNumber nvarchar(100) Not Null,
    PatientAddress nvarchar(100) Not Null,
	PatientCity nvarchar(100) Not Null,
	PatientState nchar(2) Not Null,
	PatientZipCode nvarchar(10) Not Null
);
Go

Alter Table dbo.Patients
	Add 
		Constraint checkPatientPhoneNumber Check (PatientPhoneNumber Like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
		Constraint checkPatientZipCode Check (PatientZipCode Like '[0-9][0-9][0-9][0-9][0-9]' Or
			PatientZipCode Like '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' );
Go

-- Creates a table for doctors
Create Table Doctors (
	DoctorID Int Primary Key Identity Not Null,
	DoctorFirstName nvarchar(100) Not Null,
	DoctorLastName nvarchar(100) Not Null,
	DoctorPhoneNumber nvarchar(100) Not Null,
    DoctorAddress nvarchar(100) Not Null,
	DoctorCity nvarchar(100) Not Null,
	DoctorState nchar(2) Not Null,
	DoctorZipCode nvarchar(10) Not Null
);
Go

Alter Table dbo.Doctors
	Add 
		Constraint checkDoctorPhoneNumber Check (DoctorPhoneNumber Like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
		Constraint checkDoctorZipCode Check (DoctorZipCode Like '[0-9][0-9][0-9][0-9][0-9]' Or
			DoctorZipCode Like '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' );
Go

-- Create a table for appointments
Create Table Appointments (
	AppointmentID Int Primary Key Identity Not Null,
	AppointmentDateTime datetime Not Null,
	AppointmentPatientID int Not Null,
	AppointmentDoctorID int Not Null,
	AppointmentClinicID int Not Null
);
Go

Alter Table dbo.Appointments
	Add 
		Constraint fkPatientID Foreign Key (AppointmentPatientID)
			References dbo.Patients (PatientID),
		Constraint fkDoctorID Foreign Key (AppointmentDoctorID)
			References dbo.Doctors (DoctorID),
		Constraint fkClinicID Foreign Key (AppointmentClinicID)
			References dbo.Clinics (ClinicID);
Go

/* Creating Views */

-- Creates the view for the clinics table 
Create View vClinics
	As
	Select
	c.[ClinicID],
	c.[ClinicName],
	c.[ClinicPhoneNumber],
	c.[ClinicAddress],
	c.[ClinicCity],
	c.[ClinicState],
	c.[ClinicZipCode]
	From dbo.Clinics As c;
Go

-- Creates the view for the patients table
Create View vPatients
	As
	Select
	p.[PatientID],
	p.[PatientFirstName],
	p.[PatientLastName],
	p.[PatientPhoneNumber],
	p.[PatientAddress],
	p.[PatientCity],
	p.[PatientState],
	p.[PatientZipCode]
	From dbo.Patients As p;
Go

-- Creates the view for the doctors  table 
Create View vDoctors
	As
	Select
	d.[DoctorID],
	d.[DoctorFirstName],
	d.[DoctorLastName],
	d.[DoctorPhoneNumber],
	d.[DoctorAddress],
	d.[DoctorCity],
	d.[DoctorState],
	d.[DoctorZipCode]
	From dbo.Doctors As d;
Go

-- Create view for appointments table
Create View vAppointments
	As
	Select
	a.[AppointmentID],
	a.[AppointmentDateTime],
	a.[AppointmentPatientID],
	a.[AppointmentDoctorID],
	a.[AppointmentClinicID]
	From dbo.Appointments As a;
Go

/* Creates a reporting view that joins all the tables together, 
   first and last names combined, date and time seperated*/
Create or Alter View vAppointmentsByPatientsDoctorsAndClinics
	As
	Select
	a.[AppointmentID],
	Convert(Date, a.[AppointmentDateTime]) as AppointmentDate,    -- Convert to date
	Convert(Time(0), a.[AppointmentDateTime]) as AppointmentTime, -- Covnert to time 
	p.[PatientID],
	Concat(p.[PatientFirstName], ' ', p.[PatientLastName]) as PatientName, -- Combine first and last name
	p.[PatientPhoneNumber],
	p.[PatientAddress],
	p.[PatientCity],
	p.[PatientState],
	p.[PatientZipCode],
	d.[DoctorID],
	Concat(d.[DoctorFirstName], ' ', d.[DoctorLastName]) as DoctorName,   
	d.[DoctorPhoneNumber],
	d.[DoctorAddress],
	d.[DoctorCity],
	d.[DoctorState],
	d.[DoctorZipCode],
	c.[ClinicID],
	c.[ClinicName],
	c.[ClinicPhoneNumber],
	c.[ClinicAddress],
	c.[ClinicCity],
	c.[ClinicState],
	c.[ClinicZipCode]
	From dbo.Appointments as a
	Join dbo.Clinics as c
	On a.AppointmentClinicID = c.ClinicID
	Join dbo.Patients as p
	On a.AppointmentPatientID = p.PatientID
	Join dbo.Doctors as d
	On a.AppointmentDoctorID = d.DoctorID;
Go


/* Creating Stored Procedures */
-- insert clinic
Create Procedure pInsClinics (@ClinicName nvarchar(100), @ClinicPhoneNumber nvarchar(100), 
	@ClinicAddress nvarchar(100), @ClinicCity nvarchar(100), @ClinicState nchar(2), @ClinicZipCode nvarchar(10),
	@ClinicID int OUTPUT)
As
 Begin
  Declare @RC Int = 0
  Begin Try
   Begin Transaction 
    -- Transaction Code --
	Insert Into dbo.Clinics (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, 
	 ClinicState, ClinicZipCode)
	Values (@ClinicName, @ClinicPhoneNumber, @ClinicAddress, @ClinicCity, @ClinicState, @ClinicZipCode)
   Commit Transaction
   Set @RC = +1
   Set @ClinicID = @@IDENTITY  
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction
   Print Error_Message()
   Set @RC = -1
  End Catch
  Return @RC;
 End
Go

-- update clinic
Create Procedure pUpdClinics
(@ClinicID int, @ClinicName nvarchar(100), @ClinicPhoneNumber nvarchar(100), @ClinicAddress nvarchar(100),
 @ClinicCity nvarchar(100), @ClinicState nchar(2), @ClinicZipCode nvarchar(10))
As
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
	 Update Clinics 
	 Set ClinicName = @ClinicName, ClinicAddress = @ClinicAddress, 
	 ClinicCity = @ClinicCity, ClinicState = @ClinicState, ClinicZipCode = @ClinicZipCode
	 Where ClinicID = @ClinicID;
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction;
   Print Error_Message();
   Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
Go

-- delete clinic
Create Procedure pDelClinics
(@ClinicID int)
As
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --ClinicID
	 Delete From Clinics Where ClinicID = @ClinicID
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction;
   Print Error_Message();
   Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
Go

-- insert patient
Create Procedure pInsPatients (@PatientFirstName nvarchar(100), @PatientLastName nvarchar(100), @PatientPhoneNumber nvarchar(100), 
	@PatientAddress nvarchar(100), @PatientCity nvarchar(100), @PatientState nchar(2), @PatientZipCode nvarchar(10),
	@PatientID int OUTPUT)
As
 Begin
  Declare @RC Int = 0
  Begin Try
   Begin Transaction 
    -- Transaction Code --
	Insert Into dbo.Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, 
	 PatientState, PatientZipCode)
	Values (@PatientFirstName, @PatientLastName, @PatientPhoneNumber, @PatientAddress, @PatientCity, @PatientState, @PatientZipCode)
   Commit Transaction
   Set @RC = +1
   Set @PatientID = @@IDENTITY  
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction
   Print Error_Message()
   Set @RC = -1
  End Catch
  Return @RC;
 End
Go

-- update patient
Create Procedure pUpdPatients
(@PatientID int, @PatientFirstName nvarchar(100), @PatientLastName nvarchar(100),
 @PatientPhoneNumber nvarchar(100), @PatientAddress nvarchar(100),
 @PatientCity nvarchar(100), @PatientState nchar(2), @PatientZipCode nvarchar(10))
As
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
	 Update Patients 
	 Set PatientFirstName = @PatientFirstName, PatientLastName = @PatientLastName, PatientAddress = @PatientAddress, 
	 PatientCity = @PatientCity, PatientState = @PatientState, PatientZipCode = @PatientZipCode
	 Where PatientID = @PatientID;
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction;
   Print Error_Message();
   Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
Go

-- delete patient
Create Procedure pDelPatients
(@PatientID int)
As
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
	 Delete From Patients Where PatientID = @PatientID
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction;
   Print Error_Message();
   Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
Go

--insert Doctor
Create Procedure pInsDoctors (@DoctorFirstName nvarchar(100), @DoctorLastName nvarchar(100), @DoctorPhoneNumber nvarchar(100), 
	@DoctorAddress nvarchar(100), @DoctorCity nvarchar(100), @DoctorState nchar(2), @DoctorZipCode nvarchar(10),
	@DoctorID int OUTPUT)
As
 Begin
  Declare @RC Int = 0
  Begin Try
   Begin Transaction 
    -- Transaction Code --
	Insert Into dbo.Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, 
	 DoctorState, DoctorZipCode)
	Values (@DoctorFirstName, @DoctorLastName, @DoctorPhoneNumber, @DoctorAddress, @DoctorCity, @DoctorState, @DoctorZipCode)
   Commit Transaction
   Set @RC = +1
   Set @DoctorID = @@IDENTITY  
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction
   Print Error_Message()
   Set @RC = -1
  End Catch
  Return @RC;
 End
Go

-- update doctor
Create Procedure pUpdDoctors
(@DoctorID int, @DoctorFirstName nvarchar(100), @DoctorLastName nvarchar(100),
 @DoctorPhoneNumber nvarchar(100), @DoctorAddress nvarchar(100),
 @DoctorCity nvarchar(100), @DoctorState nchar(2), @DoctorZipCode nvarchar(10))
As
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
	 Update Doctors 
	 Set DoctorFirstName = @DoctorFirstName, DoctorLastName = @DoctorLastName, DoctorAddress = @DoctorAddress, 
	 DoctorCity = @DoctorCity, DoctorState = @DoctorState, DoctorZipCode = @DoctorZipCode
	 Where DoctorID = @DoctorID;
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction;
   Print Error_Message();
   Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
Go

-- delete doctor
Create Procedure pDelDoctors
(@DoctorID int)
As
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
	 Delete From Doctors Where DoctorID = @DoctorID
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction;
   Print Error_Message();
   Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
Go

--insert appointment
Create Procedure pInsAppointments (@AppointmentDateTime datetime, @AppointmentPatientID int, @AppointmentDoctorID int, 
	@AppointmentClinicID int, @AppointmentID int OUTPUT)
As
 Begin
  Declare @RC Int = 0
  Begin Try
   Begin Transaction 
    -- Transaction Code --
	Insert Into dbo.Appointments(AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
	Values (@AppointmentDateTime, @AppointmentPatientID, @AppointmentDoctorID, @AppointmentClinicID) 
   Commit Transaction
   Set @RC = +1
   Set @AppointmentID = @@IDENTITY  
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction
   Print Error_Message()
   Set @RC = -1
  End Catch
  Return @RC;
 End
Go

-- update appointment
Create Procedure pUpdAppointments
(@AppointmentID int, @AppointmentDateTime datetime, @AppointmentPatientID int, @AppointmentDoctorID int, 
 @AppointmentClinicID int)
As
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
	 Update Appointments 
	 Set AppointmentDateTime = @AppointmentDateTime, AppointmentPatientID = @AppointmentPatientID, 
	 AppointmentDoctorID = @AppointmentDoctorID, AppointmentClinicID = @AppointmentClinicID
	 Where AppointmentID = @AppointmentID;
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction;
   Print Error_Message();
   Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
Go

--delete appointment 
Create Procedure pDelAppointments
(@AppointmentID int)
As
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
	 Delete From Appointments Where AppointmentID = @AppointmentID
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
   If(@@Trancount > 0) Rollback Transaction;
   Print Error_Message();
   Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
Go
/* Setting Permissions */

/* Denying permissions for the public to change any of the tables*/
Deny Select, Insert, Update, Delete On Clinics To Public
Deny Select, Insert, Update, Delete On Patients To Public;
Deny Select, Insert, Update, Delete On Doctors To Public;
Deny Select, Insert, Update, Delete On Appointments To Public;

/* Giving permission for the public to select the views */
Grant Select On vClinics To Public;
Grant Select On vPatients To Public;
Grant Select On vDoctors To Public;
Grant Select On vAppointmentsByPatientsDoctorsAndClinics To Public;

/* Giving permission for the public to use any of the stored procedures for each table */
Grant Execute On pInsClinics To Public;
Grant Execute On pInsPatients To Public;
Grant Execute On pInsDoctors To Public; 
Grant Execute On pInsAppointments To Public; 

Grant Execute On pUpdClinics To Public;
Grant Execute On pUpdPatients To Public;
Grant Execute On PUpdDoctors To Public; 
Grant Execute On pUpdAppointments To Public; 

Grant Execute On pDelClinics To Public;
Grant Execute On PDelPatients To Public;
Grant Execute On pDelDoctors To Public; 
Grant Execute On pDelAppointments To Public;

Go

/* Creating Test Code For Stored Procedures */

-- Insert Clinic
Declare @Status Int
Declare @ID int
Exec 
	@Status = pInsClinics @ClinicName = 'Clinic 1', @ClinicPhoneNumber ='425-525-4250', 
	@ClinicAddress = '123 Main St.', @ClinicCity = 'Seattle', @ClinicState = 'WA', 
	@ClinicZipCode = '98012', @ClinicID = @ID OUTPUT 
Select Case @Status
  When +1 Then 'Insert was successful!'
  When -1 Then 'Insert failed! Common Issues: Duplicate Data'
  End as [Status]
  Select @ID as NewIdentity
  Select * From Clinics;
Go

-- Insert Patient
Declare @Status Int
Declare @ID int
Exec 
	@Status = pInsPatients @PatientFirstName = 'Bob', @PatientLastName = 'Smith', @PatientPhoneNumber ='111-222-3333', 
	@PatientAddress = '111 Pine St.', @PatientCity = 'Seattle', @PatientState = 'WA', 
	@PatientZipCode = '98012', @PatientID = @ID OUTPUT 
Select Case @Status
  When +1 Then 'Insert was successful!'
  When -1 Then 'Insert failed! Common Issues: Duplicate Data'
  End as [Status]
  Select @ID as NewIdentity
  Select * From Patients;
Go

-- Insert Doctor
Declare @Status Int
Declare @ID int
Exec 
	@Status = pInsDoctors @DoctorFirstName = 'Ken', @DoctorLastName = 'Jeong', @DoctorPhoneNumber ='808-707-1234', 
	@DoctorAddress = '100 Aloha St.', @DoctorCity = 'Seattle', @DoctorState = 'WA', 
	@DoctorZipCode = '98012', @DoctorID = @ID OUTPUT 
Select Case @Status
  When +1 Then 'Insert was successful!'
  When -1 Then 'Insert failed! Common Issues: Duplicate Data'
  End as [Status]
  Select @ID as NewIdentity
  Select * From Doctors;
Go

--Insert Appointment
Declare @Status Int
Declare @ID int
Exec 
	@Status = pInsAppointments @AppointmentDateTime = '2020-06-01 00:15:00', @AppointmentPatientID = 1, @AppointmentDoctorID = 1,
	@AppointmentClinicID = 1, @AppointmentID = @ID OUTPUT 
Select Case @Status
  When +1 Then 'Insert was successful!'
  When -1 Then 'Insert failed! Common Issues: Duplicate Data'
  End as [Status]
  Select @ID as NewIdentity
  Select * From Appointments;
Go

-- Update Clinic
Declare @Status int;
Declare @NewClinicID int = IDENT_CURRENT('Clinics');
Exec @Status = pUpdClinics
                @ClinicID = @NewClinicID, @ClinicName = 'Clinic 1A', @ClinicPhoneNumber = '425-525-4250', @ClinicAddress = '123 Main St.',
				@ClinicCity = 'Seattle', @ClinicState = 'WA', @ClinicZipCode = '98012'
Select Case @Status
  When +1 Then 'Update was successful!'
  When -1 Then 'Update failed! Common Issues: Check Values'
  End as [Status]
  Select * From Clinics;
Go

-- Update Patient
Declare @Status int;
Declare @NewPatientID int = IDENT_CURRENT('Patients');
Exec @Status = pUpdPatients
                @PatientID = @NewPatientID, @PatientFirstName = 'Robert', @PatientLastName = 'Smith', 
				@PatientPhoneNumber = '111-222-3333', @PatientAddress = '111 Pine St.',
				@PatientCity = 'Seattle', @PatientState = 'WA', @PatientZipCode = '98012'
Select Case @Status
  When +1 Then 'Update was successful!'
  When -1 Then 'Update failed! Common Issues: Check Values'
  End as [Status]
  Select * From Patients;
Go

-- Update Doctor
Declare @Status int;
Declare @NewDoctorID int = IDENT_CURRENT('Doctors');
Exec @Status = pUpdDoctors
                @DoctorID = @NewDoctorID, @DoctorFirstName = 'Kennith', @DoctorLastName = 'Jeong', 
				@DoctorPhoneNumber = '808-707-1234', @DoctorAddress = '100 Aloha St.',
				@DoctorCity = 'Seattle', @DoctorState = 'WA', @DoctorZipCode = '98012'
Select Case @Status
  When +1 Then 'Update was successful!'
  When -1 Then 'Update failed! Common Issues: Check Values'
  End as [Status]
  Select * From Doctors;
Go

-- Update Appointment
Declare @Status int;
Declare @NewAppointmentID int = IDENT_CURRENT('Appointments');
Exec @Status = pUpdAppointments
                @AppointmentID = @NewAppointmentID, @AppointmentDateTime = '2020-06-02 00:15:00', @AppointmentPatientID = 1,
				@AppointmentDoctorID = 1, @AppointmentClinicID = 1
Select Case @Status
  When +1 Then 'Update was successful!'
  When -1 Then 'Update failed! Common Issues: Check Values'
  End as [Status]
  Select * From Appointments;
Go

--Delete Appointment
Declare @Status int;
Declare @NewAppointmentID int = IDENT_CURRENT('Appointments');
Exec @Status = pDelAppointments
                @AppointmentID = @NewAppointmentID;
Select Case @Status
  When +1 Then 'Delete was successful!'
  When -1 Then 'Delete failed! Common Issues: Foreign Key Values must be deleted first'
  End as [Status]
  Select * From Appointments;
Go

-- Delete Clinic Test
Declare @Status int;
Declare @NewClinicID int = IDENT_CURRENT('Clinics');
Exec @Status = pDelClinics
                @ClinicID = @NewClinicID;
Select Case @Status
  When +1 Then 'Delete was successful!'
  When -1 Then 'Delete failed! Common Issues: Foreign Key Values must be deleted first'
  End as [Status]
  Select * From Clinics;
Go

-- Delete Patient
Declare @Status int;
Declare @NewPatientID int = IDENT_CURRENT('Patients');
Exec @Status = pDelPatients
                @PatientID = @NewPatientID;
Select Case @Status
  When +1 Then 'Delete was successful!'
  When -1 Then 'Delete failed! Common Issues: Foreign Key Values must be deleted first'
  End as [Status]
  Select * From Patients;
Go

-- Delete Doctor
Declare @Status int;
Declare @NewDoctorID int = IDENT_CURRENT('Doctors');
Exec @Status = pDelDoctors
                @DoctorID = @NewDoctorID;
Select Case @Status
  When +1 Then 'Delete was successful!'
  When -1 Then 'Delete failed! Common Issues: Foreign Key Values must be deleted first'
  End as [Status]
  Select * From Doctors;
Go


/* Final Reporting view to show all the added data*/
Select * From vAppointmentsByPatientsDoctorsAndClinics;
Go

--{ IMPORTANT }--
-- To get full credit, your script must run without having to highlight individual statements!!!  
/**************************************************************************************************/