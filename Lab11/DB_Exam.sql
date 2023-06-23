USE [LmsTestDb]
GO

--1. List the email Ids of students who have enrolled to a course but have not submitted any assignment in that course. 
--Output schema should be as follow (EmailId, CourseName).
SELECT Email from AspNetUsers where  AspNetUsers.Id Not In (Select Studentid from SpikoAssignmentSubmission), 

--3. Sections of which course have no enrollments. List the name of courses. 
--Output schema should be as follow (CourseName).
Select CourseTitle from spikoCourse JOIN SpikoSection ON spikoCourse.CourseId = SpikoSection.Id 
where SpikoSection.Id NOT IN (Select SectionId from SpikoStudentSection)
--3b. List the name of courses whose assignments are currently open for submission. 
-- Output schema should be as follow (CourseName).
Select CourseTitle As CourseName from spikoCourse JOIN SpikoSection ON spikoCourse.CourseId = SpikoSection.Id 
JOIN SpikoAssignment ON SpikoSection.Id = SpikoAssignment.Id where DeadLine > GETDATE();

--4. Assignment submission is said to be at eleventh hour if it is submitted one hour before the deadline. List the name 
--of students who have submitted more than two assignments in any course at eleventh hour.
--Output schema should be as follow (StudentName).
--5. An assignment is said to be difficult if no more than two students can submit before the deadline. List the Ids of 
--assignments which are difficult.
--Output schema should be as follow (AssignmentId).
Select Id from SpikoAssignment JOIN SpikoAssignmentSubmission ON AssignmentId=Id where 3 < ANY (Select count(studentId) from SpikoAssignmentSubmission
where SubmittedOn <= ANY (Select DeadLine from SpikoAssignment where Id=AssignmentId) group by AssignmentId)
--6. A student is said to session fellow if they are enrolled in more than three courses together. List the pair-wise 
--registration numbers of students who are session fellow.
--Output schema should be as follow (RegistrationNumber1, RegistrationNumber2).
--7. Report the pairs of students who have submitted assignment immediately after each other for more than two times.
--Output schema should be as follow (RegistrationNumber1, RegistrationNumber2).
--8. Write a stored procedure to enroll a student in a course given input of CourseName and SectionName.
GO
CREATE OR ALTER PROC enroll @Course_name varchar(250), @course_section varchar (250)    AS   Declare @stdid int;   Declare @sectionid int;   SET @sectionid = (select CourseId from SpikoCourse where @Course_name = CourseTitle)   INSERT INTO [dbo].[SpikoStudentSection]([StudentId],[SectionId],[EnrolledOn],[IsAccepted],[IsActive])
     VALUES
           (@stdid,@sectionid,GETDate(),'False','False')   GO;
--9. Write a trigger such that if the assignment deadline has been passed and a row is inserted in 
--SpikoAssignmentSubmission to submit that assignment, that row should not be inserted.
GO
CREATE TRIGGER late_submission ON SpikoAssignmentSubmission
AFTER INSERT AS
BEGIN
    DELETE from SpikoAssignmentSubmission where SubmittedOn >GETDATE();
END
--10. Write a query to add index on Student Registration Number