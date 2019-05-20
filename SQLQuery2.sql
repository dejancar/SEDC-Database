select * from Student
where FirstName ='Antonio'

select * from Student
where DateOfBirth > '1999-01-01'

select * from Student
where Gender = 'M'

select * from Student
where LastName like 'T%'

select * from Student
where EnrolledDate>='1998-01-01' and EnrolledDate <='1998-01-31'

select * from Student
where LastName like 'J%' and
EnrolledDate>='1998.01.01' and EnrolledDate <='1998.01.31'

select * from Student
where FirstName ='Antonio' 
order by LastName

select * from Student
order by FirstName

select * from Student 
where Gender ='M'
order by EnrolledDate DESC

--List all Teacher First Names and Student First Names in single result set with duplicates

select s.FirstName, t.FirstName
from Student s
left join dbo.Teacher t on t.FirstName = s.FirstName


--List all Teacher Last Names and Student Last Names in single result set. Remove duplicates

select distinct s.LastName as StudentLastName, t.LastName as TeacherLastName
from Student s
left join dbo.Teacher t on t.LastName = s.LastName
group by s.LastName, t.LastName

--List all common First Names for Teachers and Students
select t.FirstName as TeacherName, s.FirstName as StudentName
from dbo.Teacher t
inner join dbo.Student s on t.FirstName = s.FirstName
group by t.FirstName, s.FirstName


--Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert
alter table GradeDetails 
add constraint DF_GradeDetails_AchievementMaxPoints
default 100 for [AchievementMaxPoints]
GO

--Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints
ALTER TABLE GradeDetails
WITH CHECK
ADD CONSTRAINT CHK_GradeDetails_AchievementMaxPoints
CHECK (AchievementMaxPoints<=100);
GO

--Change AchievementType table to guarantee unique names across the Achievement types
ALTER TABLE AchievementType
WITH CHECK
ADD CONSTRAINT AchievementType_UC_Name 
UNIQUE ([Name])
GO

--Create Foreign key constraints from diagram or with script
USE SEDCHome;
ALTER TABLE Grade
  ADD CONSTRAINT FK_StudentID FOREIGN KEY (StudentId)     
      REFERENCES dbo.Student (Id)
      ON DELETE CASCADE    
      ON UPDATE CASCADE
  ;
GO

ALTER TABLE Grade
  ADD CONSTRAINT FK_TeacherID FOREIGN KEY (TeacherId)     
      REFERENCES dbo.Teacher (Id)
      ON DELETE CASCADE    
      ON UPDATE CASCADE
  ;
GO

ALTER TABLE Grade
  ADD CONSTRAINT FK_CourseID FOREIGN KEY (CourseId)     
      REFERENCES dbo.Course (Id)
      ON DELETE CASCADE    
      ON UPDATE CASCADE
  ;
GO

ALTER TABLE GradeDetails
  ADD CONSTRAINT FK_GradeID FOREIGN KEY (GradeId)     
      REFERENCES dbo.Grade (Id)
      ON DELETE CASCADE    
      ON UPDATE CASCADE
  ;
GO

select s.FirstName, s.LastName, g.Grade
from Grade g
inner join dbo.Student s on s.ID = g.StudentID
group by s.FirstName, s.LastName, g.Grade

--List all possible combinations of Courses names and AchievementType names that can be passed by student OK
select c.Name, a.Name
from Course c
cross join dbo.AchievementType a
group by c.Name, a.Name

--List all Teachers that has any exam Grade-OK
select t.FirstName,t.LastName
from Teacher t
inner join dbo.Grade g on t.ID = g.TeacherID
group by t.FirstName,t.LastName


select t.FirstName,t.LastName, g.Grade
from Teacher t
inner join dbo.Grade g on t.ID = g.TeacherID
group by t.FirstName,t.LastName, g.Grade

--List all Teachers without exam Grade - OK

select t.FirstName,t.LastName, g.Grade
from Teacher t
left join dbo.Grade g on t.ID= g.TeacherID
where g.TeacherID is null



--List all Students without exam Grade (using Right Join)
select s.FirstName, s.LastName, g.Grade
from dbo.Grade g
right join Student s on s.Id= g.StudentID
where g.StudentID is null