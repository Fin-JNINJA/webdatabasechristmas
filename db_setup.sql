DROP DATABASE IF EXISTS coursework;

CREATE DATABASE coursework;

USE coursework;

-- This is the Course table
 
DROP TABLE IF EXISTS Course;

CREATE TABLE Course (
Crs_Code 	INT UNSIGNED NOT NULL,
Crs_Title 	VARCHAR(255) NOT NULL,
Crs_Enrollment INT UNSIGNED,
PRIMARY KEY (Crs_code));


INSERT INTO Course VALUES 
(100,'BSc Computer Science', 150),
(101,'BSc Computer Information Technology', 20),
(200, 'MSc Data Science', 100),
(201, 'MSc Security', 30),
(210, 'MSc Electrical Engineering', 70),
(211, 'BSc Physics', 100);


-- This is the student table definition


DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
URN INT UNSIGNED NOT NULL,
Stu_FName 	VARCHAR(255) NOT NULL,
Stu_LName 	VARCHAR(255) NOT NULL,
Stu_DOB 	DATE,
Stu_Phone 	VARCHAR(12),
Stu_Course	INT UNSIGNED NOT NULL,
Stu_Type 	ENUM('UG', 'PG'),
PRIMARY KEY (URN),
FOREIGN KEY (Stu_Course) REFERENCES Course (Crs_Code)
ON DELETE RESTRICT);


INSERT INTO Student VALUES
(612345, 'Sara', 'Khan', '2002-06-20', '01483112233', 100, 'UG'),
(612346, 'Pierre', 'Gervais', '2002-03-12', '01483223344', 100, 'UG'),
(612347, 'Patrick', 'O-Hara', '2001-05-03', '01483334455', 100, 'UG'),
(612348, 'Iyabo', 'Ogunsola', '2002-04-21', '01483445566', 100, 'UG'),
(612349, 'Omar', 'Sharif', '2001-12-29', '01483778899', 100, 'UG'),
(612350, 'Yunli', 'Guo', '2002-06-07', '01483123456', 100, 'UG'),
(612351, 'Costas', 'Spiliotis', '2002-07-02', '01483234567', 100, 'UG'),
(612352, 'Tom', 'Jones', '2001-10-24',  '01483456789', 101, 'UG'),
(612353, 'Simon', 'Larson', '2002-08-23', '01483998877', 101, 'UG'),
(612354, 'Sue', 'Smith', '2002-05-16', '01483776655', 101, 'UG');

DROP TABLE IF EXISTS Undergraduate;

CREATE TABLE Undergraduate (
UG_URN 	INT UNSIGNED NOT NULL,
UG_Credits   INT NOT NULL,
CHECK (60 <= UG_Credits <= 150),
PRIMARY KEY (UG_URN),
FOREIGN KEY (UG_URN) REFERENCES Student(URN)
ON DELETE CASCADE);

INSERT INTO Undergraduate VALUES
(612345, 120),
(612346, 90),
(612347, 150),
(612348, 120),
(612349, 120),
(612350, 60),
(612351, 60),
(612352, 90),
(612353, 120),
(612354, 90);

DROP TABLE IF EXISTS Postgraduate;

CREATE TABLE Postgraduate (
PG_URN 	INT UNSIGNED NOT NULL,
Thesis  VARCHAR(512) NOT NULL,
PRIMARY KEY (PG_URN),
FOREIGN KEY (PG_URN) REFERENCES Student(URN)
ON DELETE CASCADE);


-- Please add your table definitions below this line.......

-- add drop tableeebee

CREATE TABLE Hobby(
    HOBBY_CODE INT UNSIGNED NOT NULL,
    Hobby_Name VARCHAR(255) NOT NULL,
    Hobby_Description VARCHAR(512) NOT NULL,
    Hobby_Catagory VARCHAR(20),
    PRIMARY KEY (HOBBY_CODE)
);

INSERT INTO HOBBY VALUES(
    (1,"Football", "", "Sports"),
    (2, "Yoga", "", "Fitness"),
    (3, "Mountain climbing", "", "Outdoor")
)

CREATE TABLE Stu_Hobby(
    PRIMARY KEY (URN, HOBBY_CODE),
    FOREIGN KEY (URN) REFERENCES Student(URN),
    FOREIGN KEY (HOBBY_CODE) REFERENCES Hobby(HOBBY_CODE)
);

CREATE TABLE Club (
    CLUB_CODE INT UNSIGNED NOT NULL,
    Club_Name VARCHAR(255) NOT NULL,
    Club_Description VARCHAR(512) NOT NULL,
    Club_Catagory VARCHAR(20) NOT NULL,
    Club_Founded DATE NOT NULL,
    CLub_Website VARCHAR(255),
    PRIMARY KEY (CLUB_CODE)
)

CREATE TABLE Phone (
    PHONE VARCHAR(20) NOT NULL,--to account for phone numbers being up to 17 characters then with spaces
    PRIMARY KEY (CLUB, PHONE),
    FOREIGN KEY (CLUB) REFERENCES Club(CLUB_CODE)
)

CREATE TABLE Stu_Club (
    PRIMARY KEY (URN, CLUB_CODE),
    FOREIGN KEY URN REFERENCES Student(URN),
    FOREIGN KEY CLUB_CODE REFERENCES Club(CLUB_CODE)
)

CREATE TABLE Accommodation (
    ACCOM_ID INT UNSIGNED NOT NULL,
    Acc_Address VARCHAR(255) NOT NULL,
    Acc_Rent MONEY NOT NULL,
    PRIMARY KEY (ACCOM_ID)
)

CREATE TABLE Accommodation_A(
    Acc_Parking_Address VARCHAR(255),
    PRIMARY KEY (ACCOM_ID),
    FOREIGN KEY ACCOM_ID REFERENCES Accommodation (ACCOM_ID)
)

CREATE TABLE Accommodation_B(
    ACCOM_ID VARCHAR(255),
    PRIMARY KEY (ACCOM_ID),
    FOREIGN KEY ACCOM_ID REFERENCES Accommodation (ACCOM_ID)
)

CREATE TABLE Accommodation_EXT(
    Acc_Landlord_Phone VARCHAR(20),
    PRIMARY KEY (ACCOM_ID),
    FOREIGN KEY ACCOM_ID REFERENCES Accommodation (ACCOM_ID)
)