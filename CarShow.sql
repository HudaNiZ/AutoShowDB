

CREATE SCHEMA `CarShow` ;
USE `CarShow` ;


-- -------------------- CREATE --------------------


CREATE TABLE Employee(
FName              VARCHAR(50),
Lname              VARCHAR(50),
EmployeeID         INT(10)     NOT NULL,
IDexpiration       INT(4),
DateOfBirth        DATE,
University         VARCHAR(50),
CurrentJob         VARCHAR(50),
GraduationYear     INT(4),
YearOfWork         INT(2),
Gender             VARCHAR(6),
Salary             DECIMAL,
CONSTRAINT Employee_PK PRIMARY KEY(EmployeeID)
);

CREATE TABLE Customer( 
CustomerID         INT(10)     NOT NULL,
Nationality        VARCHAR(200),
IDexpiration       INT(4),
FName    	  	   VARCHAR(30),
LName 			   VARCHAR(30),
DateOfBirth		   DATE,
Gender			   VARCHAR(6),
Country			   VARCHAR(200),
PostCode		   INT(5),
City			   VARCHAR(200),
CONSTRAINT Customer_PK PRIMARY KEY( CustomerID )
);

CREATE TABLE Product (
VIN                VARCHAR(15) NOT NULL ,
Price              DECIMAL(10,2) ,
CONSTRAINT Product_PK  PRIMARY KEY ( VIN )
);

CREATE TABLE Contract (
ContractNumber     INT(10)     NOT NULL ,
`Date`             Date ,
FullBatch          DECIMAL ,
HallfBatch         DECIMAL , 
Installment        DECIMAL ,
VIN                VARCHAR(15) NOT NULL      UNIQUE,
EmployeeID         INT(10)                   UNIQUE,
CustomerID         INT(10)                   UNIQUE,
CONSTRAINT Contract_PK  PRIMARY KEY( ContractNumber ) ,
CONSTRAINT Contract_FK1 FOREIGN KEY (EmployeeID)  REFERENCES Employee(EmployeeID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT Contract_FK2 FOREIGN KEY (CustomerID)  REFERENCES Customer(CustomerID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT Contract_FK3 FOREIGN KEY (VIN)  REFERENCES Product(VIN)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Manufacture (
Brand              VARCHAR(20) NOT NULL,
Country            VARCHAR(200),
CONSTRAINT Manufacture_PK PRIMARY KEY(Brand)
);

CREATE TABLE Produces(
Brand             VARCHAR(15) NOT NULL,
VIN               VARCHAR(15) NOT NULL,
CONSTRAINT Produces_PK PRIMARY KEY(Brand,VIN),
CONSTRAINT Produces_FK1 FOREIGN KEY (Brand) REFERENCES Manufacture(Brand)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT Produces_FK2 FOREIGN KEY (VIN) REFERENCES Product(VIN)
ON DELETE CASCADE	
ON UPDATE CASCADE 
);

CREATE TABLE Service (
CarRental          VARCHAR(20) ,           -- ShortNameService = R
CarPlate	       VARCHAR(12) ,           -- ShortNameService = P
CarMaintenance	   VARCHAR(20) ,           -- ShortNameService = M
SoshibalCar 	   VARCHAR(20),            -- ShortNameService = S
ShortNameService   VARCHAR(10) NOT NULL ,
ContractNumber	   INT(10)     NOT NULL ,
CONSTRAINT Service_PK PRIMARY KEY (ShortNameService , ContractNumber ),
CONSTRAINT Service_FK1 FOREIGN KEY (ContractNumber) REFERENCES Contract(ContractNumber)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE GetsOn (
CustomerID         INT(10)       NOT NULL,
ShortNameservice   varchar(15)   NOT NULL ,
ContractNumber     INT(10)       NOT NULL ,
CONSTRAINT GetsOn_PK  PRIMARY KEY( CustomerID , ContractNumber , ShortNameservice ) ,
CONSTRAINT GetsOn_FK1 FOREIGN KEY (CustomerID)    REFERENCES Customer(CustomerID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT GetsOn_FK2 FOREIGN KEY (ShortNameservice) REFERENCES Service(ShortNameservice)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT GetsOn_FK3 FOREIGN KEY (ContractNumber)   REFERENCES Contract(ContractNumber)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE MultiColor (
Color              VARCHAR(30) NOT NULL ,
VIN                VARCHAR(15) NOT NULL ,
CONSTRAINT MultiColor_PK PRIMARY KEY (Color , VIN),
CONSTRAINT MultiColor_FK FOREIGN KEY (VIN) REFERENCES Product(VIN)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE  CustomerPhNumber (
PhoneNumber        INT(10)     NOT NULL,
CustomerID         INT(10)                   UNIQUE,
CONSTRAINT CustomerPhNumber_PK PRIMARY KEY (PhoneNumber , CustomerID),
CONSTRAINT CustomerPhNumber_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE  EmploeeysPhNumber (
PhoneNumber        INT(10)     NOT NULL,
EmployeeID         INT(10)     NOT NULL ,
CONSTRAINT EmploeeysPhNumber_PK PRIMARY KEY (PhoneNumber , EmployeeID),
CONSTRAINT EmploeeysPhNumber_FK FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE MultiTypeOfVehicles (
TypeOfVehicles     VARCHAR(50) NOT NULL,
VIN                VARCHAR(15) NOT NULL ,
CONSTRAINT MultiTypeOfVehicles_PK  PRIMARY KEY ( TypeOfVehicles , VIN ) ,
CONSTRAINT MultiTypeOfVehicles_FK  FOREIGN KEY (VIN)  REFERENCES Product(VIN)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE YearOfManufacturing (
YearOfManufacturing     INT(4) NOT NULL ,
Brand              VARCHAR(20) NOT NULL ,
CONSTRAINT YearOfManufacturing_PK  PRIMARY KEY ( YearOfManufacturing , Brand ) ,
CONSTRAINT YearOfManufacturing_FK  FOREIGN KEY (Brand) REFERENCES Manufacture(Brand)
ON DELETE CASCADE 
ON UPDATE CASCADE
);


-- -------------------- INSERT --------------------


INSERT INTO Employee
VALUES 
('Fahad' ,        'Ahmad' ,    1118743271 , 2025 , '96/2/15' ,'UMM AL-QURA' , 'Marketing' ,         2018 , 3 , 'Male' ,   8500 ),
('Sara' ,         'Ali' ,      1113456904 , 2026 , '98/6/11' ,'UMM AL-QURA' , 'Customer Service' ,  2020 , 2 , 'Female' , 7500 ),
('Maha' ,         'Mohammed' , 1112378935 , 2024 , '95/9/1' , 'UMM AL-QURA' , 'Sales Manager' ,     2017 , 5 , 'Female' , 9900 ),
('lama' ,         'Naif',      1118735261 , 2029 , '94/5/3' , 'UMM AL-QURA' , 'Vendor' ,            2018 , 3 , 'Female' , 8500 ),
('Suha' ,         'Saud' ,     1191544286 , 2025 , '93/2/21' ,'UMM AL-QURA' , 'Accounting' ,        2016 , 6 , 'Female' , 11000 ),
('Mohammed' ,     'Saleh' ,    1153002716 , 2027 , '97/7/8' , 'UMM AL-QURA' , 'Vendor' ,            2019 , 4 , 'Male',    9000 ),
('Abdullrahman' , 'Naser' ,    1156398320 , 2028 , '92/11/1' ,'UMM AL-QURA' , 'Financial Manager' , 2015 , 8 , 'Male' ,   12000 );
SELECT * FROM Employee ;

INSERT INTO Customer 
VALUES
(1178064089 ,'Saudi', 2027 ,'Lama' ,   'Abdullah' , '04/3/15' , 'Women' , 'Saudi Arabia' , 65532 , 'Jeddah'),
(1165088032 ,'Saudi', 2024 ,'Naif' ,   'Rami' ,     '99/5/2' ,  'Man' ,   'Saudi Arabia' , 20339 , 'Makkah'),
(1125038094 ,'Saudi', 2030 ,'Hala',    'Ahmed' ,    '92/9/10' , 'Women' , 'Saudi Arabia' , 11506 , 'Makkah'),
(1194077350 ,'Saud',  2030 ,'Samar' ,  'Faisal' ,   '00/1/1' ,  'Women' , 'Saudi Arabia' , 64322 , 'Taif'),
(1178055034 ,'Saudi', 2025 ,'Faisal' , 'Abdullah' , '98/5/11' , 'Man' ,   'Saudi Arabia' , 54410 , 'Taif'),
(1133750122 ,'Saudi', 2028 ,'Omar' ,   'Ahmed' ,    '93/7/20' , 'Man' ,   'Saudi Arabia' , 60473 , 'Makkah');
SELECT * FROM Customer ;

INSERT INTO Product
VALUES
('A1234', 100.00),
('E5678', 250.50),
('I012',  500.00),
('M3456', 75.25),
('Q7890', 999.99);
SELECT * FROM Product ;

INSERT INTO Contract 
VALUES
(1722498015, '2015/8/11', 40000.70 , null,   null, 'A1234' ,  1118743271 , 1178064089),
(1968989006, '2006/9/18', 1205000,   null,   null, 'E5678' ,  1113456904 , 1133750122),
(1648989089, '1989/4/30', null,      204500, null, 'I012' ,   1112378935 , 1125038094),
(1478743005, '2005/5/28', null,      null,   79000, 'M3456' , 1118735261 , 1194077350),
(1932843002, '2002/3/25', 1001900,   null,   null, 'Q7890',   1156398320 , 1178055034);
SELECT * FROM Contract ;

INSERT INTO Manufacture
VALUES 
('BMW',      'Germany'),
('Mercedes', 'Germany'),
('Hyundai',  'South Korea'),
('GMC',      'America'),
('Genesis',  'Korea'),
('mazda',    'Japan'),
('Bently',   'England');
SELECT * FROM Manufacture ;

INSERT INTO Produces
VALUES 
('BMW' ,      'A1234'),
('mercedes' , 'E5678'),
('hyundai' ,  'I012'),
('GMC' ,      'M3456'),
('genesis' ,  'Q7890');
SELECT * FROM Produces ;

INSERT INTO Service 
VALUES
('Yes', 'ABC123', 'Yes', 'No',  'R , P , M', 1968989006),
('No',  'DEF456', 'No',  'Yes', 'P , S'    , 1648989089),
('Yes', 'GHI789', 'Yes', 'No',  'R , P , M', 1478743005),
('No',  'JKL012', 'No',  'Yes', 'P , S'    , 1932843002),
('Yes', 'MNO345', 'Yes', 'No',  'R , P , M', 1722498015);
SELECT * FROM Service ;

INSERT INTO GetsOn 
VALUES
(1178064089 , 'R , P , M' , 1968989006),
(1165088032 , 'P , S'     , 1648989089),
(1125038094 , 'R , P , M' , 1478743005),
(1194077350 , 'P , S'     , 1932843002),
(1178055034 , 'R , P , M' , 1722498015);
SELECT * FROM GetsOn ;

INSERT INTO MultiColor
VALUES 
('Grey',  'A1234'),
('Red' ,  'E5678'),
('Blue',  'I012'),
('White', 'M3456'),
('Black', 'Q7890');
SELECT * FROM MultiColor ;

INSERT INTO CustomerPhNumber
VALUES 
(0561134537, 1125038094),
(0579891205, 1165088032),
(0555342379, 1178055034),
(0513409754, 1178064089),
(0598564321, 1194077350);
SELECT * FROM CustomerPhNumber ;

INSERT INTO EmploeeysPhNumber
VALUES 
(0561566453, 1118743271),
(0549003205, 1113456904),
(0550328879, 1112378935),
(0506094354, 1118735261),
(0506839221, 1191544286);
SELECT * FROM EmploeeysPhNumber ;

INSERT INTO MultiTypeOfVehicles 
VALUES
('SUV' ,       'M3456'),
('Sedan' ,     'I012'),
('Supercar' ,  'I012'),
('Hatchback' , 'A1234'),
('Sedan' ,     'Q7890'),
('Supercar' ,  'E5678');
SELECT * FROM MultiTypeOfVehicles ;

INSERT INTO YearOfManufacturing 
VALUES
(2011 , 'BMW'),
(1999 , 'mercedes'),
(2021 , 'hyundai'),
(2016 , 'GMC'),
(2015 , 'genesis'),
(2023 , 'mazda'),
(2015 , 'bently');
SELECT * FROM YearOfManufacturing ;

-- -------------------- QUERIES --------------------


-- Employee  [ORDER BY +  HAVING]
SELECT Gender, count(FName) 
FROM Employee 
GROUP BY Gender 
HAVING count(FName) > 2;

-- Customer  [DELETE + WHERE + SELECT]
DELETE FROM Customer
	WHERE CustomerID = 1165088032;
	SELECT * FROM Customer ;

-- Product  [UPDATE + WHERE]
UPDATE Product
SET Price = 299.99
WHERE VIN = 'E5678';
SELECT * FROM Product ;

-- Contract  [GROUP BY]
SELECT ContractNumber , CustomerID , Count(*)
FROM Contract
GROUP BY ContractNumber , CustomerID ; 

-- Manufacture  [ORDER BY]
SELECT Brand FROM Manufacture
	ORDER BY Brand ASC;

-- Produces  [UPDATE + ORDER BY + WHERE]
DELETE FROM Produces
WHERE  Brand='GMC';
SELECT * FROM Produces ;

SELECT *
FROM Produces 
ORDER BY VIN DESC;

-- Service  [JOIN]
-- SQL query that performs a join operation between the Service and Product tables
-- It selects the shortNameService and ContractNumber columns from the Service table 
-- and the VIN and Price columns from the Product table
SELECT S.shortNameService, S.ContractNumber, P.VIN, P.Price
FROM Service S JOIN Contract C ON S.ContractNumber = C.ContractNumber
JOIN Product P ON C.VIN = P.VIN;

-- GetsOn  [WHERE]
SELECT ContractNumber 
FROM GetsOn
WHERE CustomerID = 1178064089 ;

-- MultiColor  [ORDER BY]
SELECT *
FROM MultiColor
ORDER BY Color ASC;

-- CustomerPhNumber  [ORDER BY + SUBQUERIES]
SELECT *
FROM CustomerPhNumber
ORDER BY PhoneNumber DESC;

SELECT *
FROM CustomerPhNumber
WHERE CustomerID IN (SELECT CustomerID FROM Customer WHERE City = 'Jeddah');

-- EmploeeysPhNumber  [UPDATE + ORDER BY + WHERE]
UPDATE EmploeeysPhNumber
SET PhoneNumber = 0530704098
WHERE EmployeeID = 1113456904;
SELECT * FROM EmploeeysPhNumber ;

SELECT *
FROM EmploeeysPhNumber
ORDER BY PhoneNumber ASC;

-- YearOfManufacturing  [LEFT JOIN + WHERE + ORDER BY]
SELECT M.Brand, YM.YearOfManufacturing, M.Country
FROM Manufacture AS M
LEFT JOIN YearOfManufacturing AS YM
ON M.Brand = YM.Brand WHERE YM.YearOfManufacturing >= 2015 
ORDER BY YM.YearOfManufacturing ASC;