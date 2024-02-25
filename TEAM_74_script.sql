CREATE DATABASE Advising_Team_74

GO


USE Advising_Team_74
GO

CREATE PROCEDURE CreateAllTables
AS

CREATE TABLE Advisor(
advisor_id INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(40),
email VARCHAR(40),
office VARCHAR(40),
password VARCHAR(40)
);

CREATE TABLE Student(
student_id INT PRIMARY KEY IDENTITY(1,1),
f_name VARCHAR(40),
l_name VARCHAR(40),
gpa DECIMAL(3,2),
faculty VARCHAR(40),
email VARCHAR(40),
major VARCHAR(40),
password VARCHAR(40),
financial_status BIT,
semester INT,
acquired_hours INT,
assigned_hours INT,
advisor_id INT,
CHECK(assigned_hours <=34),
CHECK(gpa BETWEEN 0.7 AND 5),
CHECK(acquired_hours >=34),
CONSTRAINT FK FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id)
);

CREATE TABLE Student_Phone(
student_id INT NOT NULL,
phone_number VARCHAR(40) NOT NULL,
PRIMARY KEY (student_id,phone_number),
FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Course(
course_id INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(40),
major VARCHAR(40),
is_offered BIT,
credit_hours INT,
semester INT
);

CREATE TABLE PreqCourse_course(
prerequisite_course_id INT NOT NULL,
course_id INT NOT NULL,
PRIMARY KEY (prerequisite_course_id,course_id),
FOREIGN KEY (prerequisite_course_id) REFERENCES Course(course_id),
FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Instructor(
instructor_id INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(40),
email VARCHAR(40),
faculty VARCHAR(40),
office VARCHAR(40)
);

CREATE TABLE Instructor_Course(
course_id INT NOT NULL,
instructor_id INT NOT NULL,
PRIMARY KEY(course_id,instructor_id),
FOREIGN KEY (course_id) REFERENCES Course (course_id),
FOREIGN KEY(instructor_id) REFERENCES Instructor (instructor_id)
);

CREATE TABLE Student_Instructor_Course_Take(
student_id INT NOT NULL,
course_id INT NOT NULL,
instructor_id INT,
semester_code VARCHAR(40) NOT NULL,
exam_type VARCHAR(40) DEFAULT 'Normal',
grade VARCHAR(40),
CHECK(exam_type IN ('Normal', 'First_makeup', 'Second_makeup')),
PRIMARY KEY (student_id,course_id,semester_code),
FOREIGN KEY (student_id) REFERENCES Student(student_id),
FOREIGN KEY (course_id) REFERENCES Course(course_id),
FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

CREATE TABLE Semester(
semester_code VARCHAR(40) PRIMARY KEY,
start_date DATE,
end_date DATE,
);

CREATE TABLE Course_Semester(
course_id INT NOT NULL,
semester_code VARCHAR(40) NOT NULL,
PRIMARY KEY(course_id,semester_code),
FOREIGN KEY(course_id) REFERENCES Course(course_id),
FOREIGN KEY(semester_code) REFERENCES Semester(semester_code)
);



CREATE TABLE Slot(
slot_id INT PRIMARY KEY IDENTITY(1,1),
day VARCHAR(40),
time VARCHAR(40),
location VARCHAR(40),
course_id INT,
instructor_id INT,
FOREIGN KEY (course_id) REFERENCES Course(course_id),
FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

CREATE TABLE Graduation_Plan(
plan_id INT NOT NULL IDENTITY(1,1),
semester_code VARCHAR(40) NOT NULL,
semester_credit_hours INT,
expected_grad_date DATE,
advisor_id INT,
student_id INT,
PRIMARY KEY(plan_id,semester_code),
FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id),
FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE GradPlan_Course(
plan_id INT NOT NULL,
semester_code VARCHAR(40) NOT NULL,
course_id INT NOT NULL,
PRIMARY KEY(plan_id,semester_code,course_id),
FOREIGN KEY (plan_id, semester_code) REFERENCES Graduation_Plan(plan_id, semester_code)
);

CREATE TABLE Request(
request_id INT PRIMARY KEY IDENTITY(1,1),
type VARCHAR(40),
comment VARCHAR(40),
status VARCHAR(40) DEFAULT 'pending',
credit_hours INT,
student_id INT,
advisor_id INT,
course_id INT,
FOREIGN KEY (student_id) REFERENCES Student(student_id),
FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id),
FOREIGN KEY (course_id) REFERENCES Course(course_id),
);

CREATE TABLE MakeUp_Exam(
exam_id INT PRIMARY KEY IDENTITY(1,1),
date DATE, 
type VARCHAR(40),
course_id INT,
FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Exam_Student(
exam_id INT NOT NULL,
student_id INT NOT NULL,
course_id INT,
PRIMARY KEY(exam_id,student_id),
FOREIGN KEY (exam_id) REFERENCES MakeUp_Exam(exam_id),
FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Payment(
payment_id INT PRIMARY KEY IDENTITY(1,1),
amount INT,
deadline DATETIME,
n_installments INT,
status VARCHAR(40) DEFAULT 'notPaid',
fund_percentage DECIMAL(4,2),
start_date DATETIME,
student_id INT,
semester_code VARCHAR(40),
CHECK(status IN ('notPaid', 'Paid')),
FOREIGN KEY (student_id) REFERENCES Student(student_id),
FOREIGN KEY (semester_code) REFERENCES Semester(semester_code)
);

CREATE TABLE Installment(
payment_id INT NOT NULL,
deadline DateTime NOT NULL,
amount INT,
status VARCHAR(40) DEFAULT 'notPaid',
start_date DateTime,
CHECK(status IN ('notPaid', 'Paid')),
PRIMARY KEY(payment_id,deadline),
FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
);
GO

CREATE PROCEDURE DropAllTables
AS
	DROP TABLE Request
	DROP TABLE Installment
	DROP TABLE Payment
	DROP TABLE Exam_Student
	DROP TABLE MakeUp_Exam
	DROP TABLE GradPlan_Course
	DROP TABLE Graduation_Plan
	DROP TABLE Slot
	DROP TABLE Course_Semester
	DROP TABLE Semester
	DROP TABLE Student_Instructor_Course_Take
	DROP TABLE Instructor_Course
	DROP TABLE Instructor
	DROP TABLE PreqCourse_course
	DROP TABLE Course
	DROP TABLE Student_Phone
	DROP TABLE Student
	DROP TABLE Advisor
GO

CREATE PROCEDURE clearAllTables
AS
	ALTER TABLE Student 
	NOCHECK CONSTRAINT FK;

	DELETE FROM Student_Instructor_Course_Take;
	DELETE FROM Request;
	DELETE FROM Exam_Student;
	DELETE FROM Student_Phone;
	DELETE FROM Installment;
	DELETE FROM Payment;
	DELETE FROM GradPlan_Course;
	DELETE FROM Slot;
	DELETE FROM Course_Semester;
	DELETE FROM Instructor_Course;
	DELETE FROM PreqCourse_course;
	DELETE FROM MakeUp_Exam;
	DELETE FROM Graduation_Plan;
	DELETE FROM Advisor;
	DELETE FROM Student;
	DELETE FROM Instructor;
	DELETE FROM Course;
	DELETE FROM Semester;

	ALTER TABLE Student
	CHECK CONSTRAINT FK
GO

EXEC CreateAllTables
GO

CREATE  VIEW  view_Students AS
Select * from Student where financial_status = 1
Go

SELECT student_id, f_name + ' ' + l_name AS 'Name', major FROM view_Students WHERE advisor_id = @advisorID
GO

CREATE  VIEW  view_Course_prerequisites AS
Select C1.*, C2.course_id as preRequsite_course_id, C2.name as preRequsite_course_name 
from Course C1 inner join PreqCourse_course On C1.course_id = PreqCourse_course.course_id
inner join course C2 on PreqCourse_course.prerequisite_course_id = c2.course_id
go

SELECT * FROM view_Course_prerequisites
GO

CREATE  VIEW  Instructors_AssignedCourses AS
Select Instructor.instructor_id, Instructor.name as Instructor, Course.course_id, Course.name As Course
from Instructor inner join Student_Instructor_Course_take t on Instructor.instructor_id = t.instructor_id
inner join Course On Course.course_id = t.course_id 
GO

SELECT * FROM Instructors_AssignedCourses;
Go

CREATE VIEW Student_Payment
AS
SELECT P.*,
	   S.f_name,
	   s.l_name
	   FROM Payment P INNER JOIN Student S ON P.student_id = S.student_id
GO

CREATE VIEW Courses_Slots_Instructor
AS 
SELECT C.course_id, 
	   C.name, 
	   S.slot_id, 
	   S.day,
	   S.Time,
       S.location, 
	   I.name AS 'Instructor_name'
	   FROM Course C LEFT OUTER JOIN Slot S ON C.course_id = S.course_id LEFT OUTER JOIN Instructor I ON S.instructor_id = I.instructor_id
GO

SELECT * FROM Courses_Slots_Instructor
GO

CREATE VIEW Courses_MakeupExams
AS
SELECT C.name,
       C.semester,
	   M.exam_id,
	   M.date,
	   M.type
	   FROM Course C LEFT OUTER JOIN MakeUp_Exam M ON C.course_id = M.course_id
GO

SELECT * FROM Courses_MakeupExams
GO;

CREATE VIEW Students_Courses_transcript
AS
SELECT S.student_id,
       S.f_name + ' '+ S.l_name AS 'Student_Name',
	   C.course_id,
	   C.name AS 'Course_Name',
	   Sic.exam_type,
	   Sic.grade,
	   Sic.semester_code,
	   I.name AS 'Instructor Name'
	   FROM Student S INNER JOIN Student_Instructor_Course_Take Sic ON S.student_id = Sic.student_id
	                  INNER JOIN Instructor I ON Sic.instructor_id = I.instructor_id INNER JOIN Course C ON Sic.course_id = C.course_id
GO

CREATE VIEW Semester_offered_Courses
AS
SELECT C.course_id,
       C.name,
	   S.semester_code
	   FROM Semester S LEFT OUTER JOIN Course_Semester CS ON S.semester_code = CS.semester_code
	                   LEFT OUTER JOIN Course C ON CS.course_id = C.course_id
GO

SELECT * FROM Semester_offered_Courses
GO

CREATE VIEW Advisors_Graduation_Plan
AS 
SELECT G.plan_id,
       G.semester_code,
	   G.semester_credit_hours,
	   G.expected_grad_date,
	   G.student_id,
	   A.advisor_id,
	   A.name
	   FROM Graduation_Plan G LEFT OUTER JOIN Advisor A  ON G.advisor_id = A.advisor_id
GO

CREATE PROC [Procedures_StudentRegistration]
     @first_name varchar(20), 
     @last_name varchar(20), 
     @password varchar(20), 
     @faculty varchar(20), 
     @email varchar(50), 
     @major varchar(20),
     @Semester int,
     @Student_id int OUTPUT
     AS 
     insert into Student  (f_name,l_name,password, faculty, email, major, semester) 
     values (@first_name, @last_name, @password, @faculty, @email, @major, @Semester)
    
    Select @Student_id =  student_id from Student 
     where f_name = @first_name and
     l_name= @last_name and
     password = @password  and
     email = @email 
    
     Go


CREATE PROC [Procedures_AdvisorRegistration]
     @advisor_name varchar(20), 
     @password varchar(20), 
     @email varchar(50), 
     @office varchar(20),
     @Advisor_id int OUTPUT
     AS 
     insert into Advisor(name,password, email, office) 
     values (@advisor_name, @password, @email, @office)
    
    Select @Advisor_id =  advisor_id from Advisor 
     where name = @advisor_name and
     password = @password  and
     email = @email 
    
     Go

CREATE PROCEDURE Procedures_AdminListStudents
AS
	SELECT S.student_id,S.f_name,S.l_name,S.gpa,S.faculty,S.email,S.major,S.financial_status,S.semester,S.acquired_hours,S.assigned_hours,S.advisor_id 
	FROM Student S
GO

CREATE PROCEDURE Procedures_AdminListAdvisors
AS
	SELECT A.advisor_id, A.name, A.email,A.office
	FROM Advisor A
GO

Create Proc [AdminListStudentsWithAdvisors] AS
Select Student.student_id, Student.f_name, Student.l_name, Advisor.advisor_id, Advisor.name
from Student inner join Advisor on Student.advisor_id = Advisor.advisor_id
GO

CREATE PROCEDURE AdminAddingSemester
@start_date DATE,
@end_date DATE,
@semester_code VARCHAR(40)
AS
	INSERT INTO Semester(semester_code,start_date,end_date)
	VALUES (@semester_code,@start_date,@end_date)
GO

CREATE PROCEDURE Procedures_AdminAddingCourse
@major VARCHAR(40),
@semester INT,
@credit_hours INT,
@course_name VARCHAR(40),
@offered BIT
AS
	INSERT INTO Course(name,major,is_offered,credit_hours,semester)
	VALUES(@course_name,@major,@offered,@credit_hours,@semester)
GO

CREATE PROCEDURE Procedures_AdminLinkInstructor
@InstructorId int,
@courseId int,
@slotID int
AS
	IF NOT EXISTS(SELECT* FROM Instructor_Course WHERE course_id = @courseId AND instructor_id = @InstructorId)
	begin
	INSERT INTO Instructor_Course(course_id,instructor_id)
	VALUES(@courseId,@InstructorId)
	end

	UPDATE Slot
	SET course_id = @courseId, instructor_id = @InstructorId
	WHERE slot_id = @slotID
GO

CREATE PROCEDURE Procedures_AdminLinkStudent
@InstructorId int,
@studentId int,
@courseId int,
@semester_code varchar(40)
AS
	INSERT INTO Student_Instructor_Course_Take(student_id,course_id,instructor_id,semester_code)
	VALUES(@studentId,@courseId,@InstructorId,@semester_code)
GO

CREATE PROCEDURE Procedures_AdminLinkStudentToAdvisor
@studentID INT,
@advisorID INT
AS
	UPDATE Student
	SET advisor_id = @advisorID
	WHERE student_id = @studentID
GO

CREATE PROCEDURE Procedures_AdminAddExam
@Type VARCHAR(40),
@date DATETIME,
@courseID INT
AS
	INSERT INTO MakeUp_Exam(date, type, course_id)
	VALUES(@date, @Type, @courseID)
GO

CREATE PROCEDURE Procedures_AdminIssueInstallment
@payment_ID INT
AS
	DECLARE @Number INT, @start DATETIME, @amount INT
	SELECT @Number = DATEDIFF(MONTH,start_date, deadline), @start = start_date, @amount = amount
	FROM Payment
	WHERE payment_id = @payment_ID

	UPDATE Payment
	SET n_installments = @Number
	WHERE payment_id = @payment_ID
	
	DECLARE @Count INT
	SET @Count =1
	IF @Number IS NOT NULL
	BEGIN
		WHILE @Count <= @Number 
		BEGIN 
			INSERT INTO Installment(payment_id, deadline, amount, start_date)
			VALUES(@payment_ID, DATEADD(MONTH, @Count, @start), (@amount/@Number), DATEADD(MONTH, (@Count-1), @start))
			SET @Count = @Count+1
		END
	END
GO

CREATE PROCEDURE Procedures_AdminDeleteCourse
@courseID INT 
AS
	DELETE FROM PreqCourse_course WHERE prerequisite_course_id = @courseID OR course_id = @courseID
	DELETE FROM Instructor_Course WHERE course_id = @courseID
	DELETE FROM Student_Instructor_Course_Take WHERE course_id = @courseID
	DELETE FROM Course_Semester WHERE course_id = @courseID
	DELETE FROM GradPlan_Course WHERE course_id = @courseID
	
	DECLARE @examID INT
	SELECT @examID = exam_id FROM MakeUp_Exam WHERE course_id = @courseID

	DELETE FROM Exam_Student
	WHERE exam_id = @examID

	DELETE FROM MakeUp_Exam WHERE course_id = @courseID

	UPDATE Request
	SET course_id = NULL
	WHERE course_id = @courseID

	UPDATE Slot
	SET course_id = NULL, instructor_id = NULL
	WHERE course_id = @courseID

	DELETE FROM Course WHERE course_id = @courseID

GO

create proc [Procedure_AdminUpdateStudentStatus]
@student_id int
as
 update Student
 set financial_status = dbo.FN_AdminCheckStudentStatus(@student_id)
 where student_id = @student_id
GO

Create View all_Pending_Requests As
Select * from Request where status = 'Pending';
GO

CREATE FUNCTION [FN_AdminCheckStudentStatus]
(@Student_id int)     --Define Function Input
Returns bit   	  --Define Function Output

AS
Begin
Declare
@status bit,
@install_status varchar(40)

Select @install_status = Installment.status 
from Installment inner join Payment on Payment.payment_id = Installment.payment_id
and Payment.student_id = @Student_id and Installment.deadline < current_timestamp

if @install_status = 'Paid'
set @status =1

Else if @install_status = 'NotPaid'
set @status =0

Return @status 	 --Return Function Output
END
go

SELECT * FROM all_Pending_Requests
GO

CREATE PROC [Procedures_AdminDeleteSlots]
@current_semester varchar(40)

As

Delete from slot where Slot.course_id In (Select Slot.course_id from Slot inner join Course_Semester on Slot.course_id = Course_Semester.course_id
and Course_Semester.semester_code = @current_semester)
GO

CREATE FUNCTION FN_AdvisorLogin
(@ID INT,@password varchar(40))
Returns BIT
AS
Begin 
	DECLARE @retvalue BIT
	IF EXISTS (SELECT 1 FROM Advisor WHERE advisor_id = @ID AND password = @password)
	BEGIN
		Set @retvalue = 1
	END
	ELSE
	BEGIN
		SET @retvalue = 0
	END
	RETURN @retvalue
END
GO
declare @id INT, @password VARCHAR(40)
select dbo.FN_AdvisorLogin(@id,@password)
GO
CREATE PROCEDURE Procedures_AdvisorCreateGP
@Semester_code VARCHAR(40),
@expected_graduation_date DATE,
@sem_credit_hours INT,
@advisor_id INT,
@student_id INT
AS
	DECLARE @acquiredHours INT
	SELECT @acquiredHours = acquired_hours 
	FROM Student
	WHERE student_id = @student_id

	IF(@acquiredHours > 157)
	BEGIN
		INSERT INTO Graduation_Plan(semester_code, semester_credit_hours, expected_grad_date, advisor_id, student_id)
		VALUES(@Semester_code,@sem_credit_hours,@expected_graduation_date,@advisor_id,@student_id)
	END
GO

CREATE PROC [Procedures_AdvisorAddCourseGP]
 
@student_id int,
@Semester_code varchar(40),
@course_name varchar(40)
AS
declare 
@graduation_plan int,
@course_id int

select @graduation_plan = Graduation_Plan.plan_id from Graduation_Plan where Graduation_Plan.student_id = @student_id and Graduation_Plan.semester_code = @Semester_code
select @course_id = Course.course_id from Course where Course.name = @course_name

insert into GradPlan_Course values (@graduation_plan, @Semester_code, @course_id) 

GO

CREATE PROCEDURE Procedures_AdvisorUpdateGP
@expected_grad_date DATE,
@studentID INT
AS
	UPDATE Graduation_Plan
	SET expected_grad_date = @expected_grad_date
	WHERE student_id = @studentID
GO

Create PROC [Procedures_AdvisorDeleteFromGP]
@studentID int,
@sem_code varchar(40),
@courseID int


As
declare @gp_plan int
select @gp_plan = Graduation_Plan.plan_id from Graduation_Plan where Graduation_Plan.student_id = @studentID and Graduation_Plan.semester_code = @sem_code

delete from GradPlan_Course
where GradPlan_Course.plan_id = @gp_plan and GradPlan_Course.course_id= @courseID and GradPlan_Course.semester_code = @sem_code

GO

CREATE FUNCTION [FN_Advisors_Requests]
(@advisorID INT)
RETURNS TABLE
AS
	RETURN(SELECT R.* 
		   FROM Request R INNER JOIN Advisor A ON R.advisor_id = A.advisor_id
		   WHERE R.advisor_id = @advisorID)
GO

SELECT * FROM dbo.FN_Advisors_Requests(@advisorID);
GO

Create PROC [Procedures_AdvisorApproveRejectCHRequest]
@requestID int,
@current_sem_code varchar(40)

As 

declare 
@requestCreditHours int,
@type varchar(40),  -- 0 ch
@studentGPA decimal(10,2),
@studentCH  int,
@stat varchar(40),
@new_studentCH int,
@studentid int,
@paymentid int,
@nextinstalldate date

select @studentid = Request.student_id from Request where Request.request_id = @requestID
select @studentGPA = Student.gpa from Student where Student.student_id = @studentid
select @studentCH = Student.assigned_hours from Student where Student.student_id = @studentid
select @requestCreditHours = Request.credit_hours from Request where Request.request_id = @requestID
select @type = Request.type from Request where Request.request_id = @requestID
set @new_studentCH = @studentCH

if @type like '%credit%'
begin
if @studentCH + @requestCreditHours<=34 and @studentGPA < 3.7 and @requestCreditHours<=3
Begin
set @stat = 'Accept' 
set @new_studentCH = @studentCH + @requestCreditHours

update Student
set student.assigned_hours = @new_studentCH
where Student.student_id = @studentid

select @paymentid = payment.payment_id from Payment where payment.student_id = @studentid and semester_code = @current_sem_code
Select Top 1 @nextinstalldate =  Installment.start_date from Installment where installment.status = 'notPaid' order by Installment.start_date ASC 

update installment
set installment.amount = installment.amount + (1000*@requestCreditHours)
where payment_id = @paymentid and Installment.start_date =@nextinstalldate

update Payment
set payment.amount = payment.amount + (1000*@requestCreditHours)
where payment_id = @paymentid
END
Else
set @stat = 'Reject'

update Request
set request.status = @stat
where Request.request_id = @requestID
END

GO


CREATE PROCEDURE Procedures_AdvisorViewAssignedStudents
@AdvisorID INT,
@major varchar(40)
AS
	SELECT S.student_id,S.f_name + ' ' + S.l_name AS 'Student name',S.major,C.name As 'Course name'
	FROM Advisor A INNER JOIN Student S ON A.advisor_id = S.advisor_id
				   INNER JOIN Student_Instructor_Course_Take SIC ON S.student_id = SIC.student_id
				   INNER JOIN Course C ON SIC.course_id = C.course_id
	WHERE A.advisor_id = @AdvisorID AND S.major = @major
GO

Create PROC [Procedures_AdvisorApproveRejectCourseRequest]
@requestID int,
@current_semester_code varchar(40)

As 

declare 
@type varchar(40),  -- 1 course
@studentah  int,
@status varchar(40),
@studentid int,
@requestcourse_id int,
@course_hours int,
@new_studentah int,
@isoffered bit,
@prerequiste bit,
@instructor_id int

select @studentid = Request.student_id from Request where Request.request_id = @requestID
select @studentah = Student.assigned_hours from Student where Student.student_id = @studentid
select @requestcourse_id = Request.course_id from Request where Request.request_id = @requestID
select @type = Request.type from Request where Request.request_id = @requestID
select @course_hours = Course.credit_hours from course where Course.course_id = @requestcourse_id
select @isoffered = Course.is_offered from course where Course.course_id = @requestcourse_id

set @prerequiste = dbo.FN_check_prerequiste(@studentid,@requestcourse_id)
set @new_studentah = @studentah

if @type like '%course%' and @studentah >= @course_hours and @isoffered = 1 and @prerequiste = 1
Begin
set @status = 'Accept' 
set @new_studentah = @new_studentah - @course_hours
insert into Student_Instructor_Course_take (student_id, course_id,semester_code) values (@studentid,@requestcourse_id,@current_semester_code)
select *
from Student_Instructor_Course_take
END
Else
set @status = 'Reject'

update Request
set request.status = @status
where Request.request_id = @requestID

update Student
set student.assigned_hours = @new_studentah
where Student.student_id = @studentid

GO

CREATE PROCEDURE Procedures_AdvisorViewPendingRequests
@advisorID INT
AS
	SELECT R.*
	FROM Request R
	WHERE R.advisor_id = @advisorID AND R.status = 'pending'
GO

CREATE FUNCTION FN_StudentLogin 
(@studentID INT, @password VARCHAR(40))
RETURNS BIT
AS
BEGIN
    DECLARE @success BIT;

    IF EXISTS (SELECT 1 FROM Student S WHERE S.student_id = @studentID AND S.password = @password)
    BEGIN 
        SET @success = 1;
    END
    ELSE 
    BEGIN
        SET @success = 0;
    END

    RETURN @success;
END
GO
declare @id int, @password Varchar(40)
select dbo.FN_StudentLogin(@id,@password)
GO
CREATE PROCEDURE Procedures_StudentaddMobile
@StudentID int,
@mobile_number VARCHAR (40)
AS  
	INSERT INTO Student_Phone (student_id, phone_number)
	VALUES (@StudentID,@mobile_number)
GO

CREATE FUNCTION [FN_SemsterAvailableCourses]
     (@semstercode varchar(40))
   RETURNs table
   AS
   RETURN (
   Select Course.name, Course.course_id 
   from Course inner join Course_Semester 
   on Course.course_id = Course_Semester.course_id and Course_Semester.semester_code = @semstercode
   )
GO

Declare @semester_code VARCHAR(40);
SELECT * FROM dbo.FN_SemsterAvailableCourses(@semester_code);
go

CREATE PROCEDURE Procedures_StudentSendingCourseRequest
@Student_ID INT,
@course_ID INT,
@type VARCHAR(40),
@comment VARCHAR(40)
AS
	DECLARE @advisorID INT
	SELECT @advisorID = advisor_id
	FROM Student 
	WHERE student_id = @Student_ID

	INSERT INTO Request(type,comment,student_id,advisor_id,course_id)
	VALUES(@type,@comment,@Student_ID,@advisorID,@course_ID)
GO

CREATE PROCEDURE Procedures_StudentSendingCHRequest
@Student_ID INT,
@credit_hours INT,
@type VARCHAR(40),
@comment VARCHAR(40)
AS
	DECLARE @advisorID INT
	SELECT @advisorID = advisor_id
	FROM Student 
	WHERE student_id = @Student_ID

	INSERT INTO Request(type,comment,credit_hours,student_id,advisor_id)
	VALUES(@type,@comment,@credit_hours,@Student_ID,@advisorID)
GO

CREATE FUNCTION [FN_StudentViewGP]
     (@student_ID int)
   RETURNs table
   AS
   RETURN (
   Select Student.f_name +' '+ Student.l_name as Student_name , Graduation_Plan.*, GradPlan_Course.course_id, Course.name
   from Student inner join Graduation_Plan on Student.student_id = Graduation_Plan.student_id and Student.student_id = @student_ID
   inner join GradPlan_Course on Graduation_Plan.plan_id = GradPlan_Course.plan_id and Graduation_Plan.semester_code = GradPlan_Course.semester_code
   inner join Course on Course.course_id = GradPlan_Course.course_id
   )
GO


SELECT * FROM dbo.FN_StudentViewGP(@student_ID);
Go

CREATE FUNCTION [FN_StudentUpcoming_installment]
     (@student_ID int)
   RETURNs date
  Begin
  declare @installdeadline date 
  Select top 1 @installdeadline = Installment.deadline from Installment inner join Payment
  on Payment.payment_id = Installment.payment_id and Payment.student_id = @student_ID and Installment.status='notpaid'
  where Installment.deadline > CURRENT_TIMESTAMP
 
  Order by Installment.deadline ASC

  return @installdeadline
  End
GO

SELECT dbo.FN_StudentUpcoming_installment(@student_ID)
GO 

Select top 1 Installment.amount from Installment inner join Payment
on Payment.payment_id = Installment.payment_id and Payment.student_id = @student_ID and Installment.status='notpaid'
where Installment.deadline > CURRENT_TIMESTAMP
 
Order by Installment.deadline ASC
GO

CREATE FUNCTION [FN_StudentViewSlot]
(@CourseID INT,@InstructorID INT)
RETURNS TABLE
AS
RETURN(SELECT S.slot_id, S.location, S.time, S.day, C.name AS 'Course name' , I.name AS 'Instructor name'
	   FROM Course C INNER JOIN Slot S ON C.course_id = S.course_id INNER JOIN Instructor I ON S.instructor_id = I.instructor_id
	   WHERE S.course_id = @CourseID AND S.instructor_id = @InstructorID)
GO

SELECT * FROM DBO.FN_StudentViewSlot(@CourseID, @InstructorID);
GO

Create PROC [Procedures_StudentRegisterFirstMakeup]
@StudentID int, @courseID int, @studentCurr_sem varchar(40)
AS
declare 
@exam_id int,
@instructor_id int


If(not exists( Select * from Student_Instructor_Course_take where Student_Instructor_Course_take.student_id = @StudentID and Student_Instructor_Course_take.course_id
= @courseID and Student_Instructor_Course_take.exam_type in ('First_makeup','Second_makeup')))
begin 
If(exists(Select * from Student_Instructor_Course_take where Student_Instructor_Course_take.student_id = @StudentID and Student_Instructor_Course_take.course_id
= @courseID  and Student_Instructor_Course_take.exam_type = 'Normal' and Student_Instructor_Course_take.grade in ('F','FF',null)))
begin 
Select @exam_id = MakeUp_Exam.exam_id from MakeUp_Exam where MakeUp_Exam.course_id = @courseID
Select @instructor_id = Student_Instructor_Course_take.instructor_id from Student_Instructor_Course_take 
where Student_Instructor_Course_take.student_id = @StudentID and Student_Instructor_Course_take.course_id = @courseID 
insert into Exam_Student values (@exam_id, @StudentID, @courseID)
Update Student_Instructor_Course_take 
Set exam_type = 'first_makeup' , grade= null
where  student_id = @StudentID and course_id = @courseID and
 semester_code = @studentCurr_sem
end
end
Go

CREATE FUNCTION [FN_SemesterCodeCheck]
     (@SemesterCode varchar(40))
   RETURNs varchar(40)
   begin
   declare @output varchar(40)
if @SemesterCode like '%R1%' or  @SemesterCode like '%W%'
set @output = 'Odd'
else 
set @output =  'Even'
return @output
end

--Output: Eligible bit {0 → not eligible, 1 → eligible }
go

CREATE FUNCTION [FN_StudentCheckSMEligibility]
     (@CourseID int, @StudentID int)
   RETURNs bit
Begin
declare 
@eligable bit,
@countOfRows int,
@Student_semester int,
@course_semester varchar(40),
@StudentSemesterCode varchar(40),
@failedGradesCount int

select @countOfRows = COUNT(*) 
from Student_Instructor_Course_take where Student_Instructor_Course_take.exam_type In ( 'First_Makeup', 'Normal') and
Student_Instructor_Course_take.grade in ('F','FF',NULL) 
AND Student_Instructor_Course_take.course_id = @CourseID
AND Student_Instructor_Course_take.student_id = @StudentID

if @countOfRows = 0
return 0

else

begin
select @Student_semester = Student.semester from Student where  Student.student_id = @StudentID

if (@Student_semester % 2) = 0
set @StudentSemesterCode = 'Even'
Else 
set @StudentSemesterCode = 'Odd'

select @failedGradesCount = count(*)
from Student_Instructor_Course_take
where dbo.FN_SemesterCodeCheck(Student_Instructor_Course_take.semester_code) = @StudentSemesterCode and 
Student_Instructor_Course_take.student_id = @StudentID and Student_Instructor_Course_take.grade in ('F','FF')
group by Student_Instructor_Course_take.grade

end

if @failedGradesCount <=2
begin
set @eligable = 1
end
else
set @eligable = 0

return @eligable
END

-------------------------------------------
----------Register for second makeup exam {refer to eligibility section (2.4.1) in the description}-------
Go

SELECT DBO.FN_StudentCheckSMEligiability(@CourseID,@StudentID)
GO

Create PROC [Procedures_StudentRegisterSecondMakeup]
@StudentID int, @courseID int, @studentCurr_sem varchar(40)
AS
declare 
@exam_id int,
@instructor_id int
if dbo.FN_StudentCheckSMEligibility(@StudentID, @courseID) = 0
Print 'Your are not eligible to take 2nd makeup'

else
begin
Select @exam_id = MakeUp_Exam.exam_id from MakeUp_Exam where MakeUp_Exam.course_id = @courseID
Select @instructor_id = Student_Instructor_Course_take.instructor_id from Student_Instructor_Course_take 
where Student_Instructor_Course_take.student_id = @StudentID and Student_Instructor_Course_take.course_id = @courseID
insert into Exam_Student values (@exam_id, @StudentID, @courseID)
Update Student_Instructor_Course_take 
Set exam_type = 'Second_makeup' , grade= null
where  student_id = @StudentID and course_id = @courseID and
 semester_code = @studentCurr_sem
end
Go

Create PROC [Procedures_ViewRequiredCourses]
@StudentID int,
@current_semester_code varchar(40)
As
declare @student_semester int

select @student_semester = Student.semester FROM Student where Student.student_id = @StudentID
select Course.name, Course.course_id
from Course 
where Course.course_id in (select * from dbo.FN_StudentFailedAndNotEligibleCourse(@StudentID,@current_semester_code)) 
or Course.course_id in (select * from dbo.FN_StudentUnattendedCourses(@StudentID,@current_semester_code,@student_semester))
GO

CREATE FUNCTION [FN_StudentFailedAndNotEligibleCourse]
     (@StudentID int, @current_semester_code varchar(40))
   RETURNs table
   AS
   RETURN ( select Student_Instructor_Course_take.course_id
    from Student_Instructor_Course_take inner join Course_Semester on Student_Instructor_Course_take.course_id = Course_Semester.course_id
    where Student_Instructor_Course_take.student_id = @StudentID and 
    Student_Instructor_Course_take.grade in ('F','FF') and
    dbo.FN_StudentCheckSMEligibility(@StudentID,Student_Instructor_Course_take .course_id) = 0 
    and Course_Semester.semester_code = @current_semester_code
    )
go

CREATE FUNCTION [FN_StudentCheckSMEligibility]
     (@CourseID int, @StudentID int)
   RETURNs bit
Begin
declare 
@eligable bit,
@countOfRows int,
@Student_semester int,
@course_semester varchar(40),
@StudentSemesterCode varchar(40),
@failedGradesCount int

select @countOfRows = COUNT(*) 
from Student_Instructor_Course_take where Student_Instructor_Course_take.exam_type In ( 'First_Makeup', 'Normal') and
Student_Instructor_Course_take.grade in ('F','FF',NULL) 
AND Student_Instructor_Course_take.course_id = @CourseID
AND Student_Instructor_Course_take.student_id = @StudentID

if @countOfRows = 0
return 0

else

begin
select @Student_semester = Student.semester from Student where  Student.student_id = @StudentID

if (@Student_semester % 2) = 0
set @StudentSemesterCode = 'Even'
Else 
set @StudentSemesterCode = 'Odd'

select @failedGradesCount = count(*)
from Student_Instructor_Course_take
where dbo.FN_SemesterCodeCheck(Student_Instructor_Course_take.semester_code) = @StudentSemesterCode and 
Student_Instructor_Course_take.student_id = @StudentID and Student_Instructor_Course_take.grade in ('F','FF')
group by Student_Instructor_Course_take.grade

end

if @failedGradesCount <=2
begin
set @eligable = 1
end
else
set @eligable = 0

return @eligable
END
go

CREATE FUNCTION [FN_SemesterCodeCheck]
     (@SemesterCode varchar(40))
   RETURNs varchar(40)
   begin
   declare @output varchar(40)
if @SemesterCode like '%R1%' or  @SemesterCode like '%W%'
set @output = 'Odd'
else 
set @output =  'Even'
return @output
end
go

CREATE FUNCTION [FN_StudentFailedAndNotEligibleCourse]
     (@StudentID int, @current_semester_code varchar(40))
   RETURNs table
   AS
   RETURN ( select Student_Instructor_Course_take.course_id
    from Student_Instructor_Course_take inner join Course_Semester on Student_Instructor_Course_take.course_id = Course_Semester.course_id
    where Student_Instructor_Course_take.student_id = @StudentID and 
    Student_Instructor_Course_take.grade in ('F','FF') and
    dbo.FN_StudentCheckSMEligibility(@StudentID,Student_Instructor_Course_take .course_id) = 0 
    and Course_Semester.semester_code = @current_semester_code
    )
go

CREATE FUNCTION [FN_StudentUnattendedCourses]
     (@StudentID int,@current_semester_code varchar(40),@student_semester int)
   RETURNs table
   AS
   RETURN ( select Course_Semester.course_id
from Course_Semester inner join Course on Course_Semester.course_id = Course.course_id 
inner join Student on Student.major = Course.major
where  Student.student_id= @StudentID and   Course_Semester.semester_code = @current_semester_code and course.semester < @student_semester and Course_Semester.course_id Not In (
select Student_Instructor_Course_take.course_id
from Student_Instructor_Course_take
where Student_Instructor_Course_take.student_id = @StudentID
   ) or Course_Semester.course_id
   In (select Student_Instructor_Course_take.course_id
from Student_Instructor_Course_take
where Student_Instructor_Course_take.student_id = @StudentID and Student_Instructor_Course_take.grade = 'FA' ))
go
Create PROC [Procedures_ViewOptionalCourse]
@StudentID int,
@current_semester_code varchar(40)
As
declare @student_semester int
select @student_semester = Student.semester FROM Student where Student.student_id = @StudentID

select Course_Semester.course_id, Course.name
from Course_Semester inner join Course on Course_Semester.course_id = Course.course_id
where Course_Semester.semester_code = @current_semester_code AND  (Course.semester >= @student_semester and dbo.FN_check_prerequiste(@StudentID, Course_Semester.course_id) = 1 )
GO 


GO
CREATE FUNCTION [FN_check_prerequiste]
(@studentid int, @requestcourse_id varchar(40))
returns bit
Begin
declare 
@success bit,
@student_id_target int

set @student_id_target = -1

Select @student_id_target = Student.student_id
from Student 
where Student.student_id = @studentid AND  Student.student_id In(
SELECT Student.student_id
FROM Student
WHERE NOT EXISTS (
    (SELECT PreqCourse_course.prerequisite_course_id
    FROM PreqCourse_course
    WHERE PreqCourse_course.course_id = @requestcourse_id)

    EXCEPT

    (SELECT Student_Instructor_Course_take.course_id
    FROM Student_Instructor_Course_take
    INNER JOIN PreqCourse_course ON Student_Instructor_Course_take.course_id = PreqCourse_course.prerequisite_course_id
    where Student_Instructor_Course_take.student_id =  Student.student_id)
)
)
if @student_id_target = -1
set @success = 0
else
set @success = 1
return @success
End

go 

Create PROC [Procedures_ViewMS]
@StudentID int
As
declare @student_major varchar(40)
Select @student_major = major from Student where student_id = @StudentID 
select Course.course_id, Course.name
from Course 
where  Course.major = @student_major and   Course.course_id not in (select Student_Instructor_Course_take.course_id
from Student_Instructor_Course_take
where Student_Instructor_Course_take.student_id = @StudentID) OR course.course_id in (select Student_Instructor_Course_take.course_id
from Student_Instructor_Course_take
where Student_Instructor_Course_take.student_id = @StudentID AND grade in ('F','FF'))
GO

CREATE PROCEDURE Procedures_ChooseInstructor
@StudentID INT,
@InstructorID INT,
@CourseID INT,
@current_semester_code VARCHAR(40)
AS
	UPDATE Student_Instructor_Course_Take
	SET instructor_id = @InstructorID
	WHERE student_id = @StudentID AND course_id = @CourseID AND grade IS NULL AND semester_code = @current_semester_code
GO

---------------------------------------
-- Adding 10 records to the Course table
INSERT INTO Course(name, major, is_offered, credit_hours, semester)  VALUES
( 'Mathematics 2', 'Science', 1, 3, 2),
( 'CSEN 2', 'Engineering', 1, 4, 2),
( 'Database 1', 'MET', 1, 3, 5),
( 'Physics', 'Science', 0, 4, 1),
( 'CSEN 4', 'Engineering', 1, 3, 4),
( 'Chemistry', 'Engineering', 1, 4, 1),
( 'CSEN 3', 'Engineering', 1, 3, 3),
( 'Computer Architecture', 'MET', 0, 3, 6),
( 'Computer Organization', 'Engineering', 1, 4, 4),
( 'Database2', 'MET', 1, 3, 6);

-- Adding 10 records to the Instructor table
INSERT INTO Instructor(name, email, faculty, office) VALUES
( 'Professor Smith', 'prof.smith@example.com', 'MET', 'Office A'),
( 'Professor Johnson', 'prof.johnson@example.com', 'MET', 'Office B'),
( 'Professor Brown', 'prof.brown@example.com', 'MET', 'Office C'),
('Professor White', 'prof.white@example.com', 'MET', 'Office D'),
('Professor Taylor', 'prof.taylor@example.com', 'Mechatronics', 'Office E'),
('Professor Black', 'prof.black@example.com', 'Mechatronics', 'Office F'),
( 'Professor Lee', 'prof.lee@example.com', 'Mechatronics', 'Office G'),
( 'Professor Miller', 'prof.miller@example.com', 'Mechatronics', 'Office H'),
( 'Professor Davis', 'prof.davis@example.com', 'IET', 'Office I'),
( 'Professor Moore', 'prof.moore@example.com', 'IET', 'Office J');

-- Adding 10 records to the Semester table
INSERT INTO Semester(semester_code, start_date, end_date) VALUES
('W23', '2023-10-01', '2024-01-31'),
('S23', '2023-03-01', '2023-06-30'),
('S23R1', '2023-07-01', '2023-07-31'),
('S23R2', '2023-08-01', '2023-08-31'),
('W24', '2024-10-01', '2025-01-31'),
('S24', '2024-03-01', '2024-06-30'),
('S24R1', '2024-07-01', '2024-07-31'),
('S24R2', '2024-08-01', '2024-08-31')

-- Adding 10 records to the Advisor table
INSERT INTO Advisor(name, email, office, password) VALUES
( 'Dr. Anderson', 'anderson@example.com', 'Office A', 'password1'),
( 'Prof. Baker', 'baker@example.com', 'Office B', 'password2'),
( 'Dr. Carter', 'carter@example.com', 'Office C', 'password3'),
( 'Prof. Davis', 'davis@example.com', 'Office D', 'password4'),
( 'Dr. Evans', 'evans@example.com', 'Office E', 'password5'),
( 'Prof. Foster', 'foster@example.com', 'Office F', 'password6'),
( 'Dr. Green', 'green@example.com', 'Office G', 'password7'),
( 'Prof. Harris', 'harris@example.com', 'Office H', 'password8'),
( 'Dr. Irving', 'irving@example.com', 'Office I', 'password9'),
( 'Prof. Johnson', 'johnson@example.com', 'Office J', 'password10');

-- Adding 10 records to the Student table
INSERT INTO Student (f_name, l_name, gpa, faculty, email, major, password, financial_status, semester, acquired_hours, assigned_hours, advisor_id)   VALUES 
( 'John', 'Doe', 3.5, 'Engineering', 'john.doe@example.com', 'CS', 'password123', 1, 1, 90, 30, 1),
( 'Jane', 'Smith', 3.8, 'Engineering', 'jane.smith@example.com', 'CS', 'password456', 1, 2, 85, 34, 2),
( 'Mike', 'Johnson', 3.2, 'Engineering', 'mike.johnson@example.com', 'CS', 'password789', 1, 3, 75, 34, 3),
( 'Emily', 'White', 3.9, 'Engineering', 'emily.white@example.com', 'CS', 'passwordabc', 0, 4, 95, 34, 4),
( 'David', 'Lee', 3.4, 'Engineering', 'david.lee@example.com', 'IET', 'passworddef', 1, 5, 80, 34, 5),
( 'Grace', 'Brown', 3.7, 'Engineering', 'grace.brown@example.com', 'IET', 'passwordghi', 0, 6, 88, 34, 6),
( 'Robert', 'Miller', 3.1, 'Engineerings', 'robert.miller@example.com', 'IET', 'passwordjkl', 1, 7, 78, 34, 7),
( 'Sophie', 'Clark', 3.6, 'Engineering', 'sophie.clark@example.com', 'Mechatronics', 'passwordmno', 1, 8, 92, 34, 8),
( 'Daniel', 'Wilson', 3.3, 'Engineering', 'daniel.wilson@example.com', 'DMET', 'passwordpqr', 1, 9, 87, 34, 9),
( 'Olivia', 'Anderson', 3.7, 'Engineeringe', 'olivia.anderson@example.com', 'Mechatronics', 'passwordstu', 0, 10, 89, 34, 10);


-- Adding 10 records to the Student_Phone table
INSERT INTO Student_Phone(student_id, phone_number) VALUES
(4, '456-789-0123'),
(5, '567-890-1234'),
(6, '678-901-2345'),
(7, '789-012-3456'),
(8, '890-123-4567'),
(9, '901-234-5678'),
(10, '012-345-6789');


-- Adding 10 records to the PreqCourse_course table
INSERT INTO PreqCourse_course(prerequisite_course_id, course_id) VALUES
(2, 7),
(3, 10),
(2, 4),
(5, 6),
(4, 7),
(6, 8),
(7, 9),
(9, 10),
(9, 1),
(10, 3);


-- Adding 10 records to the Instructor_Course table
INSERT INTO Instructor_Course (instructor_id, course_id) VALUES
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


-- Adding 10 records to the Student_Instructor_Course_Take table
INSERT INTO Student_Instructor_Course_Take (student_id, course_id, instructor_id, semester_code,exam_type, grade) VALUES
(1, 1, 1, 'W23', 'Normal', 'A'),
(2, 2, 2, 'S23', 'First_makeup', 'B'),
(3, 3, 3, 'S23R1', 'Second_makeup', 'C'),
(4, 4, 4, 'S23R2', 'Normal', 'B+'),
(5, 5, 5, 'W23', 'Normal', 'A-'),
(6, 6, 6, 'W24', 'First_makeup', 'B'),
(7, 7, 7, 'S24', 'Second_makeup', 'C+'),
(8, 8, 8, 'S24R1', 'Normal', 'A+'),
(9, 9, 9, 'S24R2', 'Normal', 'FF'),
(10, 10, 10, 'S24', 'First_makeup', 'B-');



-- Adding 10 records to the Course_Semester table
INSERT INTO Course_Semester (course_id, semester_code) VALUES
(1, 'W23'),
(2, 'S23'),
(3, 'S23R1'),
(4, 'S23R2'),
(5, 'W23'),
(6, 'W24'),
(7, 'S24'),
(8, 'S24R1'),
(9, 'S24R2'),
(10, 'S24');

-- Adding 10 records to the Slot table
INSERT INTO Slot (day, time, location, course_id, instructor_id) VALUES
( 'Monday', 'First', 'Room A', 1, 1),
( 'Tuesday', 'First', 'Room B', 2, 2),
( 'Wednesday', 'Third', 'Room C', 3, 3),
( 'Thursday', 'Fifth', 'Room D', 4, 4),
( 'Saturday', 'Second', 'Room E', 5, 5),
( 'Monday', 'Fourth', 'Room F', 6, 6),
( 'Tuesday', 'Second', 'Room G', 7, 7),
( 'Wednesday', 'Fifth', 'Room H', 8, 8),
( 'Thursday', 'First', 'Room I', 9, 9),
('Sunday', 'Fourth', 'Room J', 10, 10);


-- Adding 10 records to the Graduation_Plan table
INSERT INTO Graduation_Plan (semester_code, semester_credit_hours, expected_grad_date, student_id, advisor_id) VALUES
( 'W23', 90,    '2024-01-31' ,   1, 1),
( 'S23', 85,    '2025-01-31'  ,     2, 2),
( 'S23R1', 75,  '2025-06-30' ,  3, 3),
( 'S23R2', 95,  '2024-06-30' , 4, 4),
( 'W23', 80,    '2026-01-31'   ,  5, 5),
( 'W24', 88,    '2024-06-30'   ,    6, 6),
( 'S24', 78,    '2024-06-30'    ,  7, 7),
( 'S24R1', 92,  '2025-01-31'  , 8, 8),
( 'S24R2', 87,  '2024-06-30'    ,  9, 9),
( 'S24', 89,    '2025-01-31'    ,    10, 10);

-- Adding 10 records to the GradPlan_Course table
INSERT INTO GradPlan_Course(plan_id, semester_code, course_id) VALUES
(1, 'W23', 1),
(2, 'S23', 2),
(3, 'S23R1', 3),
(4, 'S23R2', 4),
(5, 'W23', 5),
(6, 'W24', 6),
(7, 'S24', 7),
(8, 'S24R1', 8),
(9, 'S24R2', 9),
(10, 'S24', 10);

-- Adding 10 records to the Request table
INSERT INTO Request (type, comment, status, credit_hours, course_id, student_id, advisor_id) VALUES 
( 'course', 'Request for additional course', 'pending', null, 1, 1, 2),
( 'course', 'Need to change course', 'approved', null, 2, 2, 2),
( 'credit_hours', 'Request for extra credit hours', 'pending', 3, null, 3, 3),
( 'credit_hours', 'Request for reduced credit hours', 'approved', 1, null, 4, 5),
( 'course', 'Request for special course', 'rejected', null, 5, 5, 5),
( 'credit_hours', 'Request for extra credit hours', 'pending', 4, null, 6, 7),
( 'course', 'Request for course withdrawal', 'approved', null, 7, 7, 7),
( 'course', 'Request for course addition', 'rejected', null, 8, 8, 8),
( 'credit_hours', 'Request for reduced credit hours', 'approved', 2, null, 9, 8),
( 'course', 'Request for course substitution', 'pending', null, 10, 10, 10);

-- Adding 10 records to the MakeUp_Exam table
INSERT INTO MakeUp_Exam (date, type, course_id) VALUES
('2023-02-10', 'First MakeUp', 1),
('2023-02-15', 'First MakeUp', 2),
('2023-02-05', 'First MakeUp', 3),
('2023-02-25', 'First MakeUp', 4),
('2023-02-05', 'First MakeUp', 5),
('2024-09-10', 'Second MakeUp', 6),
('2024-09-20', 'Second MakeUp', 7),
('2024-09-05', 'Second MakeUp', 8),
('2024-09-10', 'Second MakeUp', 9),
( '2024-09-15', 'Second MakeUp', 10);

-- Adding 10 records to the Exam_Student table
INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (1, 1, 1);
INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (1, 2, 2);
INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (1, 3, 3);
INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (2, 2, 4);
INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (2, 3, 5);
INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (2, 4, 6);
INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (3, 3, 7);
INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (3, 4, 8);
INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (3, 5, 9);
INSERT INTO Exam_Student(exam_id, student_id,course_id) VALUES (4, 4, 10);

-- Adding 10 records to the Payment table
INSERT INTO Payment (amount, start_date,n_installments, status, fund_percentage, student_id, semester_code, deadline)  VALUES
(  500, '2023-11-22', 1, 'notPaid', 50.00, 1, 'W23', '2023-12-22'),
( 700, '2023-11-23', 1, 'notPaid', 60.00, 2, 'S23', '2023-12-23'),
( 600, '2023-11-24', 4, 'notPaid', 40.00, 3, 'S23R1', '2024-03-24'),
( 800, '2023-11-25', 1, 'notPaid', 70.00, 4, 'S23R2', '2023-12-25'),
( 550, '2023-11-26', 5, 'notPaid', 45.00, 5, 'W23', '2024-04-26'),
( 900, '2023-11-27', 1, 'notPaid', 80.00, 6, 'W24', '2023-12-27'),
( 750, '2023-10-28', 2, 'Paid', 65.00, 7, 'S24', '2023-12-28'),
( 620, '2023-08-29', 4, 'Paid', 55.00, 8, 'S24R1', '2023-12-29'),
( 720, '2023-11-30', 2, 'notPaid', 75.00, 9, 'S24R2', '2024-01-30'),
( 580, '2023-11-30', 1, 'Paid', 47.00, 10, 'S24', '2023-12-31');



-- Adding 10 records to the Installment table
INSERT INTO Installment (payment_id, start_date, amount, status, deadline) VALUES
(1, '2023-11-22', 50, 'notPaid','2023-12-22'),
(2, '2023-11-23', 70, 'notPaid','2023-12-23'),
(3, '2023-12-24', 60, 'notPaid','2024-01-24'),
( 4,'2023-11-25', 80, 'notPaid','2023-12-25'),
(5, '2024-2-26', 55, 'notPaid','2024-3-26'),
( 6,'2023-11-27', 90, 'notPaid','2023-12-06'),
(7, '2023-10-28', 75, 'Paid','2023-11-28'),
( 7,'2023-11-28', 62, 'Paid','2023-12-28'),
( 9,'2023-12-30', 72, 'notPaid','2024-01-30'),
( 10,'2023-11-30', 58, 'Paid','2023-12-30');
