
CREATE DATABASE NextStep;
GO

USE NextStep;
GO

SELECT DB_NAME() AS CurrentDatabase;

CREATE TABLE [User] (
	UserID INT PRIMARY KEY IDENTITY,
	Email VARCHAR(100) NOT NULL UNIQUE,
	Password VARCHAR(225) NOT NULL,
	CONSTRAINT Ck_User_Email CHECK (Email LIKE '%@%.%')
);


CREATE TABLE [Employer] (
    EmployerID INT PRIMARY KEY IDENTITY,   
    UserID INT NOT NULL,                        
    EmployerName VARCHAR(100) NOT NULL,         
    CompanyName VARCHAR(255) NOT NULL,          
    Address VARCHAR(255) NOT NULL,              
    EmployerContact VARCHAR(15) NOT NULL,       
    CONSTRAINT FK_Employer_User FOREIGN KEY (UserID) 
        REFERENCES [User](UserID)               
);


CREATE TABLE [Contact] (
    ContactID INT PRIMARY KEY IDENTITY,     
    EmployerID INT NOT NULL,                     
    ContactName VARCHAR(100) NOT NULL,           
    CompanyEmail VARCHAR(255) NOT NULL,         
    ContactNumber VARCHAR(15) NOT NULL,          
    Position VARCHAR(100) NOT NULL,             
    CONSTRAINT FK_Contact_Employer FOREIGN KEY (EmployerID) 
        REFERENCES Employer(EmployerID),        
    CONSTRAINT CK_Contact_Email CHECK (CompanyEmail LIKE '%@%.%')
);

CREATE TABLE [Skill] (
    SkillID INT PRIMARY KEY IDENTITY,  
    SkillName VARCHAR(100) NOT NULL,        
    SkillDescription VARCHAR(255) NOT NULL   
);

CREATE TABLE [Category] (
    CategoryID INT PRIMARY KEY IDENTITY,  
    CategoryName VARCHAR(100) NOT NULL,         
    CategoryDescription VARCHAR(255) NOT NULL
);


CREATE TABLE [Internship] (
    InternshipID INT PRIMARY KEY IDENTITY,      
    EmployerID INT NOT NULL,                          
    CategoryID INT NOT NULL,                          
    InternshipTitle VARCHAR(100) NOT NULL,            
    InternshipDate DATE NOT NULL DEFAULT GETDATE(),   
    Description VARCHAR(255) NOT NULL,                
    Duration VARCHAR(100) NOT NULL,                   
    Location VARCHAR(50) NOT NULL CHECK (Location IN ('On-Site', 'Remote', 'Hybrid')),
    Stipend VARCHAR(50) NOT NULL CHECK (Stipend IN ('Paid', 'Unpaid')),
    AvailabilityStatus VARCHAR(50) NOT NULL CHECK (AvailabilityStatus IN ('Open', 'Closed')),
    CONSTRAINT FK_Internship_Employer FOREIGN KEY (EmployerID)
		REFERENCES Employer(EmployerID),
    CONSTRAINT FK_Internship_Category FOREIGN KEY (CategoryID)
		REFERENCES Category(CategoryID)
);



CREATE TABLE [InternshipSkill] (
    InternshipID INT NOT NULL,
    SkillID INT NOT NULL,
    CONSTRAINT PK_InternshipSkill PRIMARY KEY (InternshipID, SkillID),
    CONSTRAINT FK_InternshipSkill_Internship FOREIGN KEY (InternshipID) 
        REFERENCES Internship(InternshipID),
    CONSTRAINT FK_InternshipSkill_Skill FOREIGN KEY (SkillID) 
        REFERENCES Skill(SkillID)
);


CREATE TABLE [Student] (
    StudentID INT PRIMARY KEY IDENTITY,
    StudentName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    CV VARCHAR(MAX) NOT NULL  
);


CREATE TABLE [Application] (
    ApplicationID INT PRIMARY KEY IDENTITY,
    StudentID INT NOT NULL,
    InternshipID INT NOT NULL,
    ApplicationDate DATE NOT NULL DEFAULT GETDATE(),
    Status VARCHAR(50) NOT NULL CHECK (Status In ('Pending', 'Reviewed', 'Withdrawn') ),
    CONSTRAINT FK_Application_Student FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),
    CONSTRAINT FK_Application_Internship FOREIGN KEY (InternshipID)
        REFERENCES Internship(InternshipID)
);



CREATE TABLE [Shortlist] (
    ShortlistID INT PRIMARY KEY IDENTITY,       
    InternshipID INT NOT NULL,                       
    ApplicationID INT NOT NULL,                       
    Decision VARCHAR(50) NOT NULL CHECK (Decision IN ('Shortlisted', 'Rejected')), 
    DecisionDate DATE NOT NULL DEFAULT GETDATE(),    
    CONSTRAINT FK_Shortlist_Internship FOREIGN KEY (InternshipID)
        REFERENCES Internship(InternshipID),
    CONSTRAINT FK_Shortlist_Application FOREIGN KEY (ApplicationID)
        REFERENCES Application(ApplicationID)
);


CREATE TABLE [Report] (
    ReportID INT PRIMARY KEY IDENTITY,           
    EmployerID INT NOT NULL,                          
    ReportTitle VARCHAR(100) NOT NULL,              
    ReportDate DATE NOT NULL DEFAULT GETDATE(),      
    NumberOfApplicants INT NOT NULL DEFAULT 0,      
    NumberOfPositionsFilled INT NOT NULL DEFAULT 0, 
    CONSTRAINT FK_Report_Employer FOREIGN KEY (EmployerID)
        REFERENCES Employer(EmployerID)
);



--INSERT Queries--

INSERT INTO [User] (Email, Password) VALUES
('nimalperera@gmail.com', 'Nimal@1985'),
('kamalasilva@yahoo.com', 'Kandy#1990'),
('sunilfernando@outlook.com', 'Sunil@1978'),
('ranijayasinghe@gmail.com', 'Rani#1988'),
('samankumara@hotmail.com', 'Saman@1992'),
('anushadealwis@gmail.com', 'Anusha#1987'),
('pradeepbandara@yahoo.com', 'Pradeep@1991'),
('malinignasekara@gmail.com', 'Malini#1983'),
('dilshanweerasinghe@gmail.com', 'Dilshan@1995'),
('isharakariyawasam@gmail.com', 'Ishara#1994');

SELECT * FROM [User];


INSERT INTO [Employer] (UserID, EmployerName, CompanyName, Address, EmployerContact) VALUES
(1, 'Nimal Perera', 'Lanka Tech Solutions (Pvt) Ltd', '123 Galle Road, Colombo', '0711234567'),
(2, 'Kamala Silva', 'Central IT Systems Pvt Ltd', '45 Peradeniya Road, Kandy', '0722345678'),
(3, 'Sunil Fernando', 'Southern Software Technologies', '78 Fort, Galle', '0773456789'),
(4, 'Rani Jayasinghe', 'NorthStar IT Solutions', '12 Stanley Road, Jaffna', '0769876543'),
(5, 'Saman Kumara', 'Matara Web Innovations', '56 Beach Road, Matara', '0755678901'),
(6, 'Anusha De Alwis', 'Negombo Cloud Services Pvt Ltd', '22 Main Street, Negombo', '0718889999'),
(7, 'Pradeep Bandara', 'Wayamba Cyber Systems', '10 Kurunegala Road, Kurunegala', '0721112223'),
(8, 'Malini Gunasekara', 'Sabaragamuwa Digital Labs', '98 Main Street, Ratnapura', '0783334445'),
(9, 'Dilshan Weerasinghe', 'Uva DataHive Analytics Pvt Ltd', '77 Bandarawela Road, Badulla', '0775556667'),
(10, 'Ishara Kariyawasam', 'Eastern GreenSoft Technologies', '65 Main Street, Trincomalee', '0717778889');

SELECT * FROM [Employer];


INSERT INTO [Contact] (EmployerID, ContactName, CompanyEmail, ContactNumber, Position) VALUES
(1, 'Chamara Perera', 'chamara@lankatechsolutions.com', '0771112222', 'HR Manager'),
(2, 'Dilani Fernando', 'dilani@centralitsystems.com', '0772223333', 'Recruitment Officer'),
(3, 'Ruwan Silva', 'ruwan@southernsoftware.com', '0773334444', 'Talent Manager'),
(4, 'Menaka Jayawardena', 'menaka@northstaritsolutions.com', '0774445555', 'HR Coordinator'),
(5, 'Asanka Kumara', 'asanka@matarawebinnovations.com', '0775556666', 'Recruitment Lead'),
(6, 'Piumi De Silva', 'piumi@negombocloudservices.com', '0776667777', 'Hiring Specialist'),
(7, 'Roshan Bandara', 'roshan@wayambacybersystems.com', '0777778888', 'Internship Manager'),
(8, 'Tharushi Gunasekara', 'tharushi@sabaragamuwadigitallabs.com', '0778889999', 'HR Associate'),
(9, 'Hiran Weerathunga', 'hiran@uvadatahive.com', '0779990000', 'HR Officer'),
(10, 'Isuri Kariyawasam', 'isuri@easterngreensoft.com', '0781112222', 'Recruitment Specialist');

SELECT * FROM [Contact];

INSERT INTO Skill (SkillName, SkillDescription) VALUES
('Python', 'Programming language for data science and AI'),
('Java', 'Object-oriented programming language'),
('C#', 'Language for .NET applications'),
('SQL', 'Database query language'),
('JavaScript', 'Language for web development'),
('HTML/CSS', 'Markup and styling for websites'),
('PHP', 'Server-side scripting language'),
('React', 'Frontend JavaScript library'),
('AWS', 'Cloud computing platform'),
('Linux', 'Operating system used in servers');

SELECT * FROM [Skill];

INSERT INTO [Category] (CategoryName, CategoryDescription) VALUES
('Software Development', 'Internships in software engineering and development'),
('Data Science', 'Internships in analytics and machine learning'),
('Cybersecurity', 'Internships in IT security'),
('Cloud Computing', 'Internships in AWS, Azure, GCP'),
('Web Development', 'Frontend and backend internships'),
('Mobile Development', 'Internships in Android/iOS'),
('Networking', 'Internships in computer networks'),
('UI/UX Design', 'Internships in interface design'),
('DevOps', 'Internships in automation and deployment'),
('AI Research', 'Internships in artificial intelligence');

SELECT * FROM [Category];

INSERT INTO [Internship] (EmployerID, CategoryID, InternshipTitle, Description, Duration, Location, Stipend, AvailabilityStatus) VALUES
(1, 1, 'Software Engineer Intern', 'Work on backend systems', '6 months', 'On-Site', 'Paid', 'Open'),
(2, 2, 'Data Analyst Intern', 'Assist in data analysis', '3 months', 'Remote', 'Unpaid', 'Open'),
(3, 3, 'Cybersecurity Intern', 'Monitor security systems', '4 months', 'Hybrid', 'Paid', 'Closed'),
(4, 4, 'Cloud Intern', 'Work with AWS cloud tools', '5 months', 'On-Site', 'Paid', 'Open'),
(5, 5, 'Web Developer Intern', 'Assist in building websites', '6 months', 'Remote', 'Unpaid', 'Open'),
(6, 6, 'Mobile Developer Intern', 'Develop Android apps', '3 months', 'On-Site', 'Paid', 'Closed'),
(7, 7, 'Networking Intern', 'Assist with IT networking', '4 months', 'Hybrid', 'Paid', 'Open'),
(8, 8, 'UI/UX Intern', 'Assist in product design', '3 months', 'On-Site', 'Unpaid', 'Open'),
(9, 9, 'DevOps Intern', 'Work on CI/CD pipelines', '5 months', 'Remote', 'Paid', 'Closed'),
(10, 10, 'AI Intern', 'Research and develop AI models', '6 months', 'Hybrid', 'Paid', 'Open'),
(1, 8, 'UI/UX Intern', 'Work on frontend systems', '6 months', 'Hybrid', 'Paid', 'Open'),
(1, 7, 'Networking Intern', 'Work with Cisco networks', '1 year', 'On-Site', 'Paid', 'Open'),
(2, 6, 'Mobile App Developer Intern', 'Work with Flutter', '1 year', 'On-Site', 'Paid', 'Open');

SELECT * FROM [Internship];


INSERT INTO [InternshipSkill] (InternshipID, SkillID) VALUES
(1, 1), (1, 4),   -- Software Engineer: Python, SQL--
(2, 1), (2, 4),   -- Data Analyst: Python, SQL--
(3, 2), (3, 4),   -- Cybersecurity: Java, SQL--
(4, 9), (4, 10),  -- Cloud Intern: AWS, Linux--
(5, 5), (5, 6),   -- Web Dev: JavaScript, HTML/CSS--
(6, 2), (6, 5),   -- Mobile Dev: Java, JavaScript--
(7, 4), (7, 10),  -- Networking: SQL, Linux--
(8, 6), (8, 8),   -- UI/UX: HTML/CSS, React--
(9, 7), (9, 9),   -- DevOps: PHP, AWS--
(10, 1), (10, 9); -- AI: Python, AWS--

SELECT * FROM [InternshipSkill];


INSERT INTO [Student] (StudentName, Email, CV) VALUES
('Apeksha Senanayake', 'apekshas23@gmail.com', 'CV_Apeksha.pdf'),
('Chamara Hettiarachchi', 'chamaraH24@yahoo.com', 'CV_Chamara.pdf'),
('Iresha Karunaratne', 'ireshaK22@gmail.com', 'CV_Iresha.pdf'),
('Lasitha Munasinghe', 'lasithaM23@outlook.com', 'CV_Lasitha.pdf'),
('Nimali Rathnayake', 'nimaliR22@gmail.com', 'CV_Nimali.pdf'),
('Prashan De Mel', 'prashanD23@yahoo.com', 'CV_Prashan.pdf'),
('Sachini Jayalath', 'sachiniJ24@gmail.com', 'CV_Sachini.pdf'),
('Thushara Peris', 'thusharaP23@outlook.com', 'CV_Thushara.pdf'),
('Vishaka Gunawardena', 'vishakaG22@gmail.com', 'CV_Vishaka.pdf'),
('Yashoda Liyanage', 'yashodaL23@yahoo.com', 'CV_Yashoda.pdf'),
('Amali Silva', 'amali@gmail.com', 'CV_Amali.pdf'),
('Naduni Ekanayaka', 'naduni@gmail.com', 'CV_Naduni.pdf');

SELECT * FROM [Student];

INSERT INTO [Application] (StudentID, InternshipID, Status) VALUES
(1, 1, 'Reviewed'),
(2, 2, 'Reviewed'),
(3, 3, 'Reviewed'),
(4, 4, 'Reviewed'),
(5, 5, 'Reviewed'),
(6, 6, 'Reviewed'),
(7, 7, 'Reviewed'),
(8, 8, 'Reviewed'),
(9, 9, 'Reviewed'),
(10, 10, 'Reviewed'),
(2,1,'pending'),
(3,1,'Pending'),
(4,2,'pending'),
(7,2,'pending'),
(10,4,'pending'),
(11,5,'pending'),
(12,5,'pending');


SELECT * FROM [Application];

INSERT INTO Shortlist (InternshipID, ApplicationID, Decision) VALUES
(1, 1, 'Shortlisted'),
(2, 2, 'Rejected'),
(3, 3, 'Shortlisted'),
(4, 4, 'Rejected'),
(5, 5, 'Shortlisted'),
(6, 6, 'Rejected'),
(7, 7, 'Shortlisted'),
(8, 8, 'Rejected'),
(9, 9, 'Shortlisted'),
(10, 10, 'Rejected');

SELECT * FROM [Shortlist];

INSERT INTO [Report] (EmployerID, ReportTitle, NumberOfApplicants, NumberOfPositionsFilled) VALUES
(1, 'January 2025 Internship Report', 15, 5),
(1, 'February 2025 Internship Report', 12, 4),  
(2, 'March 2025 Internship Report', 18, 6),
(2, 'April 2025 Internship Report', 20, 8),    
(3, 'May 2025 Internship Report', 10, 3),
(3, 'June 2025 Internship Report', 22, 9),
(4, 'July 2025 Internship Report', 25, 10),
(5, 'July 2025 Internship Report', 19, 7),
(6, 'August 2025 Internship Report', 17, 6),
(7, 'August 2025 Internship Report', 23, 8);

SELECT * FROM [Report];

--QUERY REPORTS -- 

--Display all the internships with the contact details --

SELECT 
    i.InternshipTitle,
    e.CompanyName,
	i.Duration,
	i.Location,
	i.Stipend,
    co.ContactName,
    co.CompanyEmail,
    co.ContactNumber,   
    i.AvailabilityStatus
FROM Internship i
JOIN Employer e ON i.EmployerID = e.EmployerID
JOIN Contact co ON e.EmployerID = co.EmployerID
ORDER BY e.CompanyName, i.InternshipTitle;



-- Display all the internships of a Specific Company (e.g.: Lanka Tech Solutions (Pvt) Ltd)--

SELECT 
    i.InternshipTitle,
    e.CompanyName,
	i.Duration,
    i.Location,
    i.Stipend,
    co.ContactName,
    co.CompanyEmail,
    co.ContactNumber,
    i.AvailabilityStatus
FROM Internship i
JOIN Employer e ON i.EmployerID = e.EmployerID
JOIN Contact co ON e.EmployerID = co.EmployerID
WHERE e.CompanyName = 'Lanka Tech Solutions (Pvt) Ltd'
ORDER BY i.InternshipTitle;


--Display number of internships in each category--

SELECT 
	c.CategoryName, 
	COUNT(i.InternshipID) AS TotalInternships
FROM Category c
LEFT JOIN Internship i ON c.CategoryID = i.CategoryID
GROUP BY c.CategoryName
HAVING COUNT(i.InternshipID) > 1
ORDER BY TotalInternships DESC;

--Display the number of internships in each category for a specific company (e.g., Lanka Tech Solutions (Pvt) Ltd)-- 

SELECT 
	c.CategoryName, 
	COUNT(i.InternshipID) AS TotalInternships
FROM Internship i
JOIN Category c ON i.CategoryID = c.CategoryID
JOIN Employer e ON i.EmployerID = e.EmployerID
WHERE e.CompanyName = 'Lanka Tech Solutions (Pvt) Ltd'
GROUP BY c.CategoryName;

--Find employers whose postings received more than one application --

SELECT 
	e.EmployerName, 
	COUNT(a.ApplicationID) AS TotalApplications
FROM Employer e
JOIN Internship i ON e.EmployerID = i.EmployerID
JOIN Application a ON i.InternshipID = a.InternshipID
GROUP BY e.EmployerName
HAVING COUNT(a.ApplicationID) > 1
ORDER BY TotalApplications DESC;

--Shows reports for employers where more than 15 applicants applied--

SELECT 
	e.CompanyName, 
	r.ReportTitle,
	r.NumberOfApplicants, 
	r.NumberOfPositionsFilled
FROM Employer e
JOIN Report r ON e.EmployerID = r.EmployerID
WHERE r.NumberOfApplicants > 15
ORDER BY r.NumberOfApplicants DESC;

--Lists internships that are open and paid--
SELECT 
	i.InternshipTitle, 
	c.CategoryName, 
	e.CompanyName, 
	i.Duration, 
	i.Location
FROM Internship i
JOIN Employer e ON i.EmployerID = e.EmployerID
JOIN Category c ON i.CategoryID = c.CategoryID
WHERE i.Stipend = 'Paid' AND i.AvailabilityStatus = 'Open'
ORDER BY i.Duration DESC;

-- Lists open and paid internships for a specific company (eg-: Lanka Tech Solutions (Pvt) Ltd)--

SELECT 
    i.InternshipTitle, 
    c.CategoryName, 
    e.CompanyName, 
    i.Duration, 
    i.Location
FROM Internship i
JOIN Employer e ON i.EmployerID = e.EmployerID
JOIN Category c ON i.CategoryID = c.CategoryID
WHERE i.Stipend = 'Paid' 
  AND i.AvailabilityStatus = 'Open'
  AND e.CompanyName = 'Lanka Tech Solutions (Pvt) Ltd'
ORDER BY i.Duration DESC;


--TRANSACTION--

--Transaction for shortlisting applications--

BEGIN TRANSACTION;

BEGIN TRY
	UPDATE Application
	SET Status = 'Reviewed'
	WHERE ApplicationID = 11;

	INSERT INTO Shortlist (InternshipID, ApplicationID, Decision)
	VALUES (1,11,'Shortlisted');

	COMMIT TRANSACTION;
	PRINT 'Application Shortlisted';
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION;
	PRINT 'Transaction Failed';
END CATCH;


SELECT ApplicationID, Status
FROM Application
WHERE ApplicationID = 11;

SELECT *
FROM Shortlist
WHERE ApplicationID = 11;















