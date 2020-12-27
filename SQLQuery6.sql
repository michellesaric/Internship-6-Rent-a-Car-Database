CREATE DATABASE Rent_A_Car

USE Rent_A_Car

CREATE TABLE Class (
	Id int IDENTITY(1,1) PRIMARY KEY,
	Type nvarchar(128) NOT NULL,
	WinterDailyPrice decimal(7,2) NOT NULL,
	SummerDailyPrice AS WinterDailyPrice * 1.5
)

CREATE TABLE Vehicle (
	Id int IDENTITY(1,1) PRIMARY KEY,
	Model nvarchar(128) NOT NULL,
	Brand nvarchar(128) NOT NULL,
	Mileage nvarchar(128) NOT NULL,
	Type nvarchar(128) NOT NULL,
	Color nvarchar(16) NOT NULL,
	ClassId int FOREIGN KEY REFERENCES Class(Id) NOT NULL 
)

CREATE TABLE Registration(
	Id int IDENTITY(1,1) PRIMARY KEY,
	Date datetime NOT NULL,
	EndingDate AS DATEADD(year, 1, Date),
	VehicleId int FOREIGN KEY REFERENCES Vehicle(Id) NOT NULL
)

CREATE TABLE Employee (
	Id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(128) NOT NULL,
	LastName nvarchar(128) NOT NULL,
	Gender nvarchar(8) NOT NULL CHECK(Gender = 'Muškarac' OR Gender = 'Žena'),
	DateOfBirth date NOT NULL,
	Adress nvarchar(256) NOT NULL,
	PhoneNumber nvarchar(12) NOT NULL
)

CREATE TABLE Rent(
	Id int IDENTITY(1,1) PRIMARY KEY,
	RentDate datetime NOT NULL, 
	EndDate datetime NOT NULL, 
	BuyerOIB nvarchar(11) NOT NULL, 
	BuyerFirstName nvarchar(128) NOT NULL, 
	BuyerLastName nvarchar(128) NOT NULL, 
	BuyerDateOfBirth date NOT NULL, 
	DrivingLicenseNumber nvarchar(8) NOT NULL, 
	CreditCardNumber nvarchar(16) NOT NULL, 
	VehicleId int FOREIGN KEY REFERENCES Vehicle(Id) NOT NULL, 
	EmployeeId int FOREIGN KEY REFERENCES Employee(Id) NOT NULL
)
ALTER TABLE Rent ADD CHECK (EndDate >= DATEADD(day, 1, RentDate))
ALTER TABLE Rent ADD CHECK (DATEDIFF(hour, RentDate, EndDate) % 12 = 0)
ALTER TABLE Rent ADD UNIQUE(BuyerOIB)
ALTER TABLE Rent ADD UNIQUE(DrivingLicenseNumber)
ALTER TABLE Rent ADD UNIQUE(CreditCardNumber)

INSERT INTO Class(Type, WinterDailyPrice)
VALUES
('A - City Car', 450.00),
('B - Niska klasa', 500.00),
('C - Srednja klasa', 580.00),
('D - Viša srednja klasa', 700.00 ),
('E - Viša klasa', 890.00),
('F - Luksuzna klasa', 1200.00),
('M - Minivan', 650.00)

INSERT INTO Vehicle(Brand, Model, Mileage, Type, Color, ClassId)
VALUES
('Citroen', 'C1', '100 000 km', 'auto', 'svijetlo-plava', 1),
('Fiat', 'Panda', '150 000 km', 'auto', 'naran?asta', 1),
('Hyundai' ,'i10', '200 000km' , 'auto', 'crvena', 1),
('Hyundai' ,'i10', '100 000km' , 'auto', 'crvena', 1),
('Golf','4', '200 000km' , 'auto', 'crvena', 2),
('Golf' ,'4', '999 000km' , 'auto', 'roza', 2),
('Golf' ,'5', '350 000km' , 'auto', 'modra', 2),
('Golf' ,'5', '150 000km' , 'auto', 'crna', 2),
('Golf' ,'Karavan', '400 000km' , 'auto', 'modra', 3),
('Golf' ,'Karavan', '250 000km' , 'auto', 'modra', 3),
('Mazda' ,'6', '205 000km' , 'auto', 'crna', 4),
('Mazda' ,'6', '450 000km' , 'auto', 'crna', 4),
('Audi' ,'A8', '100 000km' , 'auto', 'siva', 4),
('Mercedes' ,'E-klasa Karavan', '200 000km' , 'auto', 'bijela', 5),
('Mercedes' ,'E-klasa Karavan', '500 000km' , 'auto', 'bijela', 5),
('Audi' ,'R8 V10 Coupe', '350 000km' , 'auto', 'plava', 6),
('Crysler' ,'Pacifica', '400 000km' , 'minivan', 'plava', 7),
('Crysler' ,'Pacifica', '250 000km' , 'minivan', 'plava', 7),
('Toyota' ,'Sienna', '600 000km' , 'minivan', 'tamno siva', 7),
('Dodge' ,'Grand Karavan', '600 000km' , 'minivan', 'siva', 7)

INSERT INTO Registration (Date, VehicleId)
VALUES
('2020-03-12 10:00', 1),
('2019-04-21 12:30', 2),
('2019-06-29 13:30', 3),
('2020-05-20 10:30', 4),
('2020-01-01 14:15', 5),
('2019-01-10 14:50', 6),
('2020-02-15 13:00', 7),
('2020-07-11 12:15', 8),
('2020-10-03 09:00', 9),
('2019-08-19 08:30', 10),
('2020-01-23 10:10', 11),
('2020-03-12 13:00', 12),
('2019-10-15 16:00', 13),
('2020-04-11 14:00', 14),
('2019-01-12 13:00', 15),
('2020-02-28 13:30', 16),
('2020-05-27 12:00', 17),
('2019-04-30 10:00', 18),
('2020-01-25 11:15', 19),
('2019-09-21 16:00', 20)

INSERT INTO Registration(Date, VehicleId)
VALUES
('2019-03-12 10:00', 1),
('2018-03-12 10:00', 1),
('2017-03-12 10:00', 1)


INSERT INTO Employee(FirstName, LastName, Gender, Adress, DateOfBirth, PhoneNumber)
VALUES
('Mate', 'Mati?', 'Muškarac', 'Adresa A', '1986-04-09', '091-222-3333'),
('Ana', 'Ani?', 'Žena', 'Adresa B','1992-10-11', '092-333-4444'),
('Željana', 'Želji?', 'Žena', 'Adresa C', '1991-09-09', '099-111-3344'),
('Ante', 'Anti?', 'Muškarac', 'Adresa D', '1970-01-21', '095-219-1111'),
('Matija', 'Matiji?', 'Muškarac', 'Adresa E', '1996-03-10', '095-666-1234')

INSERT INTO Rent(RentDate, EndDate, BuyerOIB, BuyerFirstName, BuyerLastName, BuyerDateOfBirth, DrivingLicenseNumber,CreditCardNumber, VehicleId, EmployeeId)
VALUES
('2020-11-21 12:00', '2020-11-28 12:00', '12345678999', 'Marko', 'Marki?', '1978-01-01', '12345678', '1111222233334444', 4, 2),
('2020-04-12 14:00', '2020-04-20 14:00', '12345678911', 'Marija', 'Mariji?', '1990-12-03', '12345688', '1111222233335555', 2, 5),
('2020-02-10 10:00', '2020-02-13 22:00', '12345678922', 'Mirna', 'Beovi?', '1995-10-09', '12345677', '1111222233336666', 12, 1),
('2020-02-26 13:00', '2020-03-02 13:00', '12345678933', 'Anita', 'Ani?', '1989-11-22', '12345666', '1111222233337777', 16, 3),
('2020-01-24 10:00', '2020-01-29 10:00', '12345678944', 'Snježana', 'Muci?', '1986-11-03', '12345655', '1111222233338888', 10, 2),
('2020-02-27 18:00', '2020-03-05 18:00', '12345678955', 'Ranko', 'Ranki?', '1996-12-12', '12345644', '1111222233339999', 11, 3),
('2020-09-12 09:00', '2020-09-17 09:00', '12345678966', 'Anamarija', 'Šari?', '1992-12-08', '12345633', '1111222244441111', 12, 1),
('2020-01-20 19:00', '2020-02-03 19:00', '12345678977', 'Jelena', 'Jonji?', '1991-09-03', '12345622', '1111222244442222', 1, 5),
('2020-05-20 10:00', '2020-05-25 10:00', '12345678988', 'Rita', 'Šerkini?', '1970-03-03', '12345611', '1111222244443333', 20, 1),
('2020-06-01 12:00', '2020-06-10 12:00', '12345678111', 'Ružica', 'Mari?', '1985-12-28', '12345111', '1111222244445555', 2, 4),
('2020-09-21 17:00', '2020-10-01 17:00', '12345678222', 'Lucia', 'Vukorepa', '1998-09-19', '12345222', '1111222244446666', 6, 1),
('2020-08-12 08:30', '2020-08-19 08:30', '12345678333', 'Ivan', 'Ivi?', '1992-04-04', '12345333', '1111222244447777', 3, 4),
('2020-08-12 15:00', '2020-08-19 15:00', '12345678444', 'Tomislav', 'Smol?i?', '1993-05-27', '12345444', '1111222244448888', 5, 4),
('2020-02-24 14:00', '2020-02-29 14:00', '12345678555', 'Smiljana', 'Smili?', '1987-06-06', '12345555', '1111222244449999', 14, 4),
('2020-11-21 12:00', '2020-11-28 12:00', '12345678666', 'Borna', 'Milas', '1999-02-01', '12345243', '1111222255551111', 14, 5),
('2020-03-01 10:20', '2020-03-20 22:20', '12345678777', 'Miroslav', 'Mekini?', '1979-01-24', '12345777', '1111222255552222', 7, 3),
('2020-01-02 04:00', '2020-01-10 16:00', '12345678888', 'Krešimir', 'Topi?', '1998-03-04', '12345888', '1111222255553333', 17, 4),
('2020-04-12 14:30', '2020-04-23 14:30', '12345671111', 'Nikolina', 'Kucelin', '1994-11-12', '12345999', '1111222255554444', 18, 3),
('2020-08-15 13:00', '2020-08-24 13:00', '12345672222', 'Sanja', 'Rudi?', '1997-03-23', '12341111', '1111222255556666', 8, 1),
('2020-12-12 10:00', '2020-12-30 10:00', '12345673333', 'Mirko', 'Katuši?', '1993-09-21', '12342222', '1111222255557777', 8, 3),
('2020-09-27 15:00', '2020-10-10 15:00', '12345674444', 'Marko', 'Marki?', '1990-04-17', '12343333', '1111222255558888', 13, 3)


SELECT 
	VehicleId, Brand, Model 
FROM 
	Vehicle v
		JOIN Registration r ON v.Id = r.VehicleId
GROUP BY
	VehicleId, Brand, Model
HAVING 
	MAX(EndingDate) < CURRENT_TIMESTAMP

--

SELECT 
	VehicleId, Brand, Model 
FROM 
	Vehicle v
		JOIN Registration r ON v.Id = r.VehicleId
GROUP BY
	VehicleId, Brand, Model
HAVING 
	MAX(EndingDate) > CURRENT_TIMESTAMP AND MAX(EndingDate) < DATEADD(month, 1, CURRENT_TIMESTAMP)

--

SELECT
	COUNT(Id) AS NumberOfTypes, Type
FROM
	Vehicle
GROUP BY 
	Type

--

SELECT TOP(5)
	r.*
FROM
	Employee e
		JOIN Rent r ON e.Id = r.EmployeeId
WHERE
	EmployeeId = 5
ORDER BY
	RentDate DESC


--

SELECT 
	r.Id,
CASE
	WHEN RentDate > DATEPART(month, '2020-10-01') AND EndDate > DATEPART(month, '2020-10-01') AND RentDate < DATEPART(month, '2020-03-01') AND EndDate < DATEPART(month,'2020-03-01')
	THEN CAST(DATEDIFF(day, RentDate, EndDate) AS float) * WinterDailyPrice
	WHEN 
	ELSE CAST(DATEDIFF(day, RentDate, EndDate) AS float) * SummerDailyPrice
END AS TotalPrice
FROM
	Class c
		JOIN Vehicle v ON c.Id = v.ClassId
		JOIN Rent r ON v.Id = r.VehicleId

--

SELECT DISTINCT
	BuyerOIB, BuyerFirstName, BuyerLastName, BuyerDateOfBirth, DrivingLicenseNumber, CreditCardNumber
FROM
	Rent

--

SELECT 
	EmployeeId, MAX(RentDate) AS LatestTimeStamp
FROM
	Employee e
		JOIN Rent r ON e.Id = r.EmployeeId
GROUP BY
	EmployeeId

--

SELECT 
	COUNT(Id) AS NumberOfModels, Brand
FROM
	Vehicle
GROUP BY
	Brand

--

SELECT
	COUNT(Id) AS NumberOfRents, DATEPART(month, RentDate) AS Month
FROM
	Rent
GROUP BY DATEPART(month, RentDate)

--

SELECT 
	VehicleId, Brand, Model,
CASE
	WHEN MAX(EndingDate) > CURRENT_TIMESTAMP AND MAX(EndingDate) < DATEADD(month, 1, CURRENT_TIMESTAMP) THEN 'Treba registraciju'
	ELSE 'Ne treba registraciju'
END AS IsRegistrationNeeded
FROM 
	Vehicle v
		JOIN Registration r ON v.Id = r.VehicleId
GROUP BY
	VehicleId, Brand, Model

--

SELECT
	COUNT(r.Id) AS NumberOfTypes, Type
FROM
	Vehicle v
		JOIN Rent r ON v.Id = r.VehicleId
WHERE
	DATEDIFF(day, r.RentDate, r.EndDate) > 
	(SELECT 
		AVG(DATEDIFF(day, RentDate, EndDate))
	FROM
		Rent)
GROUP BY
	Type






