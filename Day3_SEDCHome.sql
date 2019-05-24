select * from Teacher
select * from Grade
select * from Student
select * from GradeDetails
select * from AchievementType
-------------------------------------------------------------------------------------------
--Calculate the count of all grades in the system
--total grade
select  COUNT(*) as TotalGrade
from dbo.Grade g

--total grade group
select g.Grade, COUNT(*) as TotalGrade
from dbo.Grade g
group by g.Grade
order by g.Grade DESC
-------------------------------------------------------------------------------------------
--Calculate the count of all grades per Teacher in the system
select t.FirstName as TeacherFirstName, t.LastName as TeacherLastName, 
COUNT(*) as TeacherGrade
from dbo.Grade g
inner join dbo.Teacher t on t.ID= g.TeacherID
group by t.FirstName, t.LastName

-------------------------------------------------------------------------------------------
--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
select t.FirstName as TeacherFirstName, t.LastName as TeacherLastName,
COUNT(*) as TeacherGrade
from dbo.Grade g
inner join  dbo.Teacher t on t.ID = g.TeacherID
inner join dbo.Student s on s.ID = g.StudentID
where s.ID<=100
Group by t.FirstName,t.LastName

-------------------------------------------------------------------------------------------
--Find the Maximal Grade, and the Average Grade per Student on all grades in the system
select s.FirstName as StudentName, s.LastName as StudentLastName, 
MAX(Grade) as MaxGrade, AVG(Grade) as Average
from dbo.Grade g
inner join dbo.Student s on s.ID = g.StudentID 
group by s.FirstName,s.LastName
order by s.FirstName

-------------------------------------------------------------------------------------------
--Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
select t.FirstName as TeacherFirstName, t.LastName as TeacherLastName, 
COUNT(*) as TeacherGradeGreater200
from dbo.Grade g
inner join dbo.Teacher t on t.ID= g.TeacherID
group by t.FirstName, t.LastName
having COUNT(*) >200
-------------------------------------------------------------------------------------------
--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count
select t.FirstName as TeacherFirstName, t.LastName as TeacherLastName,
COUNT(*) as TeacherGrade50AndMore
from dbo.Grade g
inner join  dbo.Teacher t on t.ID = g.TeacherID
inner join dbo.Student s on s.ID = g.StudentID
where s.ID<=100
Group by t.FirstName,t.LastName
having COUNT(*)>50
-------------------------------------------------------------------------------------------
--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade
select s.FirstName as StudentName, s.LastName as StudentLastName, 
COUNT(*) as GradeCount,MAX(Grade) as MaxGrade, AVG(Grade) as Average
from dbo.Grade g
inner join dbo.Student s on s.ID = g.StudentID 
group by s.FirstName,s.LastName
having MAX(Grade) = AVG(Grade)
order by s.FirstName
-------------------------------------------------------------------------------------------
--List Student First Name and Last Name next to the other details from previous query
select s.FirstName as StudentName, s.LastName as StudentLastName, 
COUNT(*) as GradeCount,MAX(Grade) as MaxGrade, AVG(Grade) as Average
from dbo.Grade g
inner join dbo.Student s on s.ID = g.StudentID 
group by s.FirstName,s.LastName
having MAX(Grade) = AVG(Grade)
order by s.FirstName
-------------------------------------------------------------------------------------------
--Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student
Create view vv_StudentGrades
as
select StudentID, COUNT(*) as StudentGradesCount
from dbo.Grade g
group by StudentID

Select * from vv_StudentGrades
-------------------------------------------------------------------------------------------
--Change the view to show Student First and Last Names instead of StudentID
Alter view vv_StudentGrades
as
select s.FirstName,s.LastName, COUNT(*) as StudentGradesCount
from dbo.Grade g
inner join dbo.Student s on s.Id= g.StudentID
group by s.FirstName,s.LastName
-------------------------------------------------------------------------------------------
--List all rows from view ordered by biggest Grade Count
Select * from vv_StudentGrades
order by StudentGradesCount DESC
-------------------------------------------------------------------------------------------
--Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)
Create view vv_StudentGradeDetails
as
select s.FirstName,s.LastName, COUNT(*) as StudentGradesCount
from dbo.Course c
inner join dbo.Grade g on g.CourseID = c.ID
inner join dbo.Student s on s.Id= g.StudentID
group by s.FirstName,s.LastName

select * from vv_StudentGradeDetails
-------------test za predmeti-----
select s.FirstName,s.LastName,c.[Name], COUNT(*) as StudentGradesCount
from dbo.Course c
inner join dbo.Grade g on g.CourseID = c.ID
inner join dbo.Student s on s.Id= g.StudentID
group by s.FirstName,s.LastName, c.[Name]