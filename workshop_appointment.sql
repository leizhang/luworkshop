---create database ---

DROP SCHEMA IF EXISTS workshop_appointment;
CREATE SCHEMA workshop_appointment;
USE workshop_appointment;

--- create table ---

--- creat tables below ---
CREATE TABLE IF NOT EXISTS user
(
    User_id INT AUTO_INCREMENT NOT NULL,
    Username VARCHAR(25) NOT NULL,
    Email VARCHAR(30) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role ENUM('staff','admin')  DEFAULT 'staff' NOT NULL,
    CONSTRAINT PK_account PRIMARY KEY (User_id,Username,Email),
    UNIQUE KEY(Username, Email)
);



CREATE TABLE IF NOT EXISTS SLC_Staff
(
    StaffID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Userid INT NOT NULL,
    FullName VARCHAR(50),
    TutorType VARCHAR(50),
    Current BOOLEAN NOT NULL,
    FOREIGN KEY (Userid) REFERENCES user (User_id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE IF NOT EXISTS ethnicities
(
    EthnicityNo INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Ethnicity VARCHAR(50) NOT NULL,
    EthnicityDescription VARCHAR(50) NOT NULL
);


CREATE TABLE IF NOT EXISTS peopleSoftExtract
(
    PeopleSoftID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    Sex VARCHAR(10) NOT NULL,
    DateofBirth DATE NOT NULL,
    EthnicityNo INT NOT NULL,
    CitizenshipCategory VARCHAR(50) NOT NULL,
    CitizenshipCountry VARCHAR(50) NOT NULL,
    IntStudHowFunded VARCHAR(50) NOT NULL,
    CourseCode VARCHAR(50) NOT NULL,
    AcademicCareer VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    FOREIGN KEY (EthnicityNo) REFERENCES ethnicities (EthnicityNo)
);



CREATE TABLE IF NOT EXISTS workshop_category
(
    CategoryNo INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Category VARCHAR(50) NOT NULL,
    Code INT NOT NULL,
    CodefromMinistry INT NOT NULL,
    Other VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS workshop_title
(
    WorkshopTitleID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Title VARCHAR(255),
    Description VARCHAR(255),
    CategoryNo INT NOT NULL,
    Current BOOLEAN NOT NULL,
    Subject VARCHAR(100),
    SubjectHours DECIMAL,
    FOREIGN KEY (CategoryNo) REFERENCES workshop_category (CategoryNo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS workshop
(
    WorkshopID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    WorkshopTitleID INT NOT NULL,
    Date DATE NOT NULL,
    StartTime TIME,
    Duration_in_hours DECIMAL,
    Room VARCHAR(20),
    Current BOOLEAN NOT NULL,
    Num_registered_at_workshop INT,
    Total_num_registered_for_workshop INT,
    FOREIGN KEY (WorkshopTitleID) REFERENCES workshop_title (WorkshopTitleID) ON DELETE CASCADE ON UPDATE CASCADE
    );





CREATE TABLE IF NOT EXISTS regisration_date
(
    RegistrationPeriod INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Current BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS registration 
(   RegistrationNo INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    PeopleSoftID INT NOT NULL ,
    RegistrationPeriod INT NOT NULL , 
    Paid BOOLEAN , 
    FOREIGN KEY (PeopleSoftID) REFERENCES peopleSoftExtract (PeopleSoftID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (RegistrationPeriod) REFERENCES regisration_date (RegistrationPeriod) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE IF NOT EXISTS appointment
(
    PeopleSoftID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    TutorInitials VARCHAR(50) NOT NULL,
    Duration DECIMAL NOT NULL,
    Category VARCHAR(20) NOT NULL,
    Attended Enum('Yes','No') NOT NULL,
    Notes VARCHAR(255) NOT NULL,
    FOREIGN KEY (PeopleSoftID) REFERENCES peopleSoftExtract (PeopleSoftID) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS tblDropIns
(
    DropInID INT AUTO_INCREMENT NOT NULL PRIMARY KEY ,
    PeopleSoftID INT NOT NULL,
    DropInDate DATE NOT NULL,
    CategoryNo INT NOT NULL,
    FOREIGN KEY (CategoryNo) REFERENCES workshop_category (CategoryNo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PeopleSoftID) REFERENCES peopleSoftExtract (PeopleSoftID) ON DELETE CASCADE ON UPDATE CASCADE
);




CREATE TABLE IF NOT EXISTS workshop_attendance
(
    attendanceID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    PeopleSoftID INT NOT NULL,
    WorkshopID INT NOT NULL,
    FOREIGN KEY(PeopleSoftID) REFERENCES peopleSoftExtract (PeopleSoftID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(WorkshopID) REFERENCES workshop (WorkshopID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS otherTeaching
(
    SubjectID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    SubjectName VARCHAR(100),
    StaffID INT,
    Duration_hrs DECIMAL NOT NULL,
    CategoryNo INT,
    Addended BOOLEAN,
    FOREIGN KEY(StaffID) REFERENCES SLC_Staff( StaffID) ON DELETE CASCADE ON UPDATE CASCADE

);



CREATE TABLE IF NOT EXISTS work_staffed_by
(
    IndexID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    StaffID INT NOT NULL,
    Initials VARCHAR(255),
    WorkshopID INT NOT NULL,
    FOREIGN KEY(WorkshopID) REFERENCES workshop_attendance( WorkshopID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(StaffID) REFERENCES SLC_Staff(StaffID) ON DELETE CASCADE ON UPDATE CASCADE

);


-- Inserting sample data into the user table
INSERT INTO user VALUES
(1, 'user1', 'user1@example.com', 'scrypt:32768:8:1$n2O4M70JYYQWBuFC$74415b9cc3c38c859263e82b280194ff05d78a8caf50d7fec63d4f9cacfc3f4e11fc13357550af37c35315a5b8dca7c3a0d8720efcc3cde2f341bd4a3e46b4dd', 'admin'),
(2, 'user2', 'user2@example.com', 'scrypt:32768:8:1$n2O4M70JYYQWBuFC$74415b9cc3c38c859263e82b280194ff05d78a8caf50d7fec63d4f9cacfc3f4e11fc13357550af37c35315a5b8dca7c3a0d8720efcc3cde2f341bd4a3e46b4dd', 'staff'),
(3, 'user3', 'user3@example.com', 'scrypt:32768:8:1$n2O4M70JYYQWBuFC$74415b9cc3c38c859263e82b280194ff05d78a8caf50d7fec63d4f9cacfc3f4e11fc13357550af37c35315a5b8dca7c3a0d8720efcc3cde2f341bd4a3e46b4dd', 'staff'),
(4, 'user4', 'user4@example.com', 'scrypt:32768:8:1$n2O4M70JYYQWBuFC$74415b9cc3c38c859263e82b280194ff05d78a8caf50d7fec63d4f9cacfc3f4e11fc13357550af37c35315a5b8dca7c3a0d8720efcc3cde2f341bd4a3e46b4dd', 'staff'),
(5, 'user5', 'user5@example.com', 'scrypt:32768:8:1$n2O4M70JYYQWBuFC$74415b9cc3c38c859263e82b280194ff05d78a8caf50d7fec63d4f9cacfc3f4e11fc13357550af37c35315a5b8dca7c3a0d8720efcc3cde2f341bd4a3e46b4dd', 'staff'),
(6, 'user6', 'user6@example.com', 'scrypt:32768:8:1$n2O4M70JYYQWBuFC$74415b9cc3c38c859263e82b280194ff05d78a8caf50d7fec63d4f9cacfc3f4e11fc13357550af37c35315a5b8dca7c3a0d8720efcc3cde2f341bd4a3e46b4dd', 'staff'),
(7, 'user7', 'user7@example.com', 'scrypt:32768:8:1$n2O4M70JYYQWBuFC$74415b9cc3c38c859263e82b280194ff05d78a8caf50d7fec63d4f9cacfc3f4e11fc13357550af37c35315a5b8dca7c3a0d8720efcc3cde2f341bd4a3e46b4dd', 'staff'),
(8, 'user8', 'user8@example.com', 'scrypt:32768:8:1$n2O4M70JYYQWBuFC$74415b9cc3c38c859263e82b280194ff05d78a8caf50d7fec63d4f9cacfc3f4e11fc13357550af37c35315a5b8dca7c3a0d8720efcc3cde2f341bd4a3e46b4dd', 'staff'),
(9, 'user9', 'user9@example.com', 'scrypt:32768:8:1$n2O4M70JYYQWBuFC$74415b9cc3c38c859263e82b280194ff05d78a8caf50d7fec63d4f9cacfc3f4e11fc13357550af37c35315a5b8dca7c3a0d8720efcc3cde2f341bd4a3e46b4dd', 'staff'),
(10, 'user10', 'user10@example.com', 'scrypt:32768:8:1$n2O4M70JYYQWBuFC$74415b9cc3c38c859263e82b280194ff05d78a8caf50d7fec63d4f9cacfc3f4e11fc13357550af37c35315a5b8dca7c3a0d8720efcc3cde2f341bd4a3e46b4dd', 'staff');


-- Inserting sample data into the SLC_Staff table
INSERT INTO SLC_Staff (Userid, FullName, TutorType, Current) VALUES
(1, 'Admin User', NULL, TRUE),
(2, 'Jane Smith', 'Junior Tutor', TRUE),
(3, 'Alice Johnson', 'Senior Tutor', TRUE),
(4, 'Bob Brown', 'Junior Tutor', TRUE),
(5, 'Emily Davis', 'Junior Tutor', TRUE),
(6, 'Michael Wilson', 'Senior Tutor', TRUE),
(7, 'John Doe', 'Senior Tutor', TRUE),
(8, 'Eva Lee', 'Junior Tutor', TRUE),
(9, 'Chris Taylor', 'Senior Tutor', TRUE),
(10, 'Samantha Clark', 'Junior Tutor', TRUE);



-- Inserting sample data into the ethnicities table
INSERT INTO ethnicities (Ethnicity, EthnicityDescription) VALUES
('Asian', 'People having origins in any of the original peoples of the Far East, Southeast Asia, or the Indian subcontinent including, for example, Cambodia, China, India, Japan, Korea, Malaysia, Pakistan, the Philippine Islands, Thailand, and Vietnam.'),
('Black or African American', 'People having origins in any of the black racial groups of Africa.'),
('Hispanic or Latino', 'People of Cuban, Mexican, Puerto Rican, South or Central American, or other Spanish culture or origin, regardless of race.'),
('White', 'People having origins in any of the original peoples of Europe, the Middle East, or North Africa.');




-- Inserting sample data into the peopleSoftExtract table
INSERT INTO peopleSoftExtract (LastName, FirstName, Sex, DateofBirth, EthnicityNo, CitizenshipCategory, CitizenshipCountry, IntStudHowFunded, CourseCode, AcademicCareer, Department) VALUES
('Doe', 'John', 'Male', '1990-05-15', 1, 'Category A', 'Country A', 'Funded', 'CS101', 'Undergraduate', 'Computer Science'),
('Smith', 'Jane', 'Female', '1992-08-20', 2, 'Category B', 'Country B', 'Self-funded', 'ENG201', 'Graduate', 'Engineering'),
('Johnson', 'Alice', 'Female', '1988-03-10', 3, 'Category C', 'Country C', 'Funded', 'BIO301', 'Undergraduate', 'Biology'),
('Brown', 'Bob', 'Male', '1991-11-25', 4, 'Category D', 'Country D', 'Funded', 'MATH401', 'Graduate', 'Mathematics'),
('Davis', 'Emily', 'Female', '1993-06-18', 1, 'Category A', 'Country A', 'Self-funded', 'PHYS501', 'Undergraduate', 'Physics'),
('Wilson', 'Michael', 'Male', '1989-09-30', 2, 'Category B', 'Country B', 'Funded', 'CHEM601', 'Graduate', 'Chemistry'),
('Lee', 'Eva', 'Female', '1994-02-08', 3, 'Category C', 'Country C', 'Self-funded', 'PSYCH701', 'Undergraduate', 'Psychology'),
('Taylor', 'Chris', 'Male', '1987-07-12', 4, 'Category D', 'Country D', 'Funded', 'ART801', 'Graduate', 'Art'),
('Clark', 'Samantha', 'Female', '1990-12-05', 1, 'Category A', 'Country A', 'Self-funded', 'SOC901', 'Undergraduate', 'Sociology'),
('Johnson', 'Robert', 'Male', '1995-04-28', 2, 'Category B', 'Country B', 'Funded', 'HIST1001', 'Graduate', 'History');





-- Inserting sample data into the workshop_category table
INSERT INTO workshop_category (Category, Code, CodefromMinistry, Other) VALUES
('Category 1', 101, 201, NULL),
('Category 2', 102, 202, NULL),
('Category 3', 103, 203, NULL);




-- Inserting sample data into the workshop_title table
INSERT INTO workshop_title VALUES
(1, 'Workshop 1', 'Description for Workshop 1', 1, TRUE, 'Subject 1', 2.5),
(2, 'Workshop 2', 'Description for Workshop 2', 2, TRUE, 'Subject 2', 3),
(3, 'Workshop 3', 'Description for Workshop 3', 1, TRUE, 'Subject 3', 1.5),
(4, 'Workshop 4', 'Description for Workshop 4', 3, TRUE, 'Subject 4', 2),
(5, 'Workshop 5', 'Description for Workshop 5', 2, TRUE, 'Subject 5', 2.5),
(6, 'Workshop 6', 'Description for Workshop 6', 1, TRUE, 'Subject 6', 1.5),
(7, 'Workshop 7', 'Description for Workshop 7', 3, TRUE, 'Subject 7', 3),
(8, 'Workshop 8', 'Description for Workshop 8', 2, TRUE, 'Subject 8', 2),
(9, 'Workshop 9', 'Description for Workshop 9', 1, TRUE, 'Subject 9', 2.5),
(10, 'Workshop 10', 'Description for Workshop 10', 3, TRUE, 'Subject 10', 1.5);







-- Inserting sample data into the workshop table
INSERT INTO workshop (WorkshopTitleID, Date, StartTime, Duration_in_hours, Room, Current, Num_registered_at_workshop, Total_num_registered_for_workshop) VALUES
(1, '2024-04-05', '09:00:00', 2, 'Room 101', TRUE, 15, 20),
(2, '2024-04-10', '10:30:00', 3, 'Room 102', TRUE, 20, 25),
(3, '2024-04-15', '14:00:00', 1.5, 'Room 103', TRUE, 10, 15),
(4, '2024-04-20', '13:00:00', 2, 'Room 104', TRUE, 18, 20),
(5, '2024-04-25', '11:00:00', 2.5, 'Room 105', TRUE, 22, 25),
(6, '2024-05-01', '10:00:00', 1.5, 'Room 101', TRUE, 12, 15),
(7, '2024-05-05', '09:30:00', 3, 'Room 102', TRUE, 25, 30),
(8, '2024-05-10', '14:00:00', 2, 'Room 103', TRUE, 20, 25),
(9, '2024-05-15', '13:30:00', 2.5, 'Room 104', TRUE, 15, 20),
(10, '2024-05-20', '12:00:00', 1.5, 'Room 105', TRUE, 18, 20);





-- Inserting sample data into the regisration_date table
INSERT INTO regisration_date (StartDate, EndDate, Current) VALUES
('2024-04-01', '2024-04-30', TRUE),
('2024-05-01', '2024-05-31', TRUE),
('2024-06-01', '2024-06-30', TRUE);



-- Inserting sample data into the registration table
INSERT INTO registration (PeopleSoftID, RegistrationPeriod, Paid) VALUES
(1, 1, TRUE),
(2, 2, TRUE),
(3, 3, FALSE),
(4, 1, TRUE),
(5, 2, FALSE),
(6, 3, TRUE),
(7, 1, TRUE),
(8, 2, FALSE),
(9, 3, TRUE),
(10, 1, TRUE);





-- Inserting sample data into the appointment table
INSERT INTO appointment (PeopleSoftID, AppointmentDate, TutorInitials, Duration, Category, Attended, Notes) VALUES
(1, '2024-04-05', 'JD', 1.5, 'Category A', 'Yes', 'Notes for appointment 1'),
(2, '2024-04-10', 'JS', 2, 'Category B', 'No', 'Notes for appointment 2'),
(3, '2024-04-15', 'AJ', 1, 'Category C', 'Yes', 'Notes for appointment 3'),
(4, '2024-04-20', 'BB', 1.5, 'Category D', 'Yes', 'Notes for appointment 4'),
(5, '2024-04-25', 'ED', 2, 'Category A', 'No', 'Notes for appointment 5'),
(6, '2024-05-01', 'MW', 1, 'Category B', 'Yes', 'Notes for appointment 6'),
(7, '2024-05-05', 'EL', 1.5, 'Category C', 'Yes', 'Notes for appointment 7'),
(8, '2024-05-10', 'CT', 2, 'Category D', 'No', 'Notes for appointment 8'),
(9, '2024-05-15', 'SC', 2.5, 'Category A', 'Yes', 'Notes for appointment 9'),
(10, '2024-05-20', 'RJ', 1, 'Category B', 'Yes', 'Notes for appointment 10');





-- Inserting sample data into the tblDropIns table
INSERT INTO tblDropIns (PeopleSoftID, DropInDate, CategoryNo) VALUES
(1, '2024-04-05', 1),
(2, '2024-04-10', 2),
(3, '2024-04-15', 1),
(4, '2024-04-20', 3),
(5, '2024-04-25', 2),
(6, '2024-05-01', 1),
(7, '2024-05-05', 3),
(8, '2024-05-10', 2),
(9, '2024-05-15', 1),
(10, '2024-05-20', 3);







-- Inserting sample data into the workshop_attendance table
INSERT INTO workshop_attendance (PeopleSoftID, WorkshopID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Inserting sample data into the otherTeaching table
INSERT INTO otherTeaching (SubjectName, StaffID, Duration_hrs, CategoryNo, Addended) VALUES
('Mathematics', 2, 2, 1, TRUE),
('Physics', 5, 3, 2, FALSE),
('Biology', 3, 1.5, 3, TRUE),
('Chemistry', 6, 2, 1, TRUE),
('Art', 8, 2, 2, FALSE),
('Psychology', 7, 3, 3, TRUE),
('Computer Science', 1, 1.5, 1, TRUE),
('Engineering', 2, 2, 2, FALSE),
('History', 10, 2, 3, TRUE),
('Sociology', 9, 1.5, 1, TRUE);

-- Inserting sample data into the work_staffed_by table
INSERT INTO work_staffed_by (StaffID, Initials, WorkshopID) VALUES
(2, 'JD', 1),
(5, 'JS', 2),
(8, 'AJ', 3),
(3, 'BB', 4),
(6, 'ED', 5),
(9, 'MW', 6),
(1, 'EL', 7),
(4, 'MW', 8),
(7, 'EL', 9),
(10, 'RC', 10);
