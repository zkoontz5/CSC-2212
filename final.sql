#Zach Koontz
#Final Exam Part 2

#1
select major, GPA
from student
where transfer = 'y'
order by GPA desc limit 1;

#2
select count(student.studentid)
from student 
join enroll on student.studentid = enroll.studentid
where enroll.enrollGrade >= 'C' 
and enroll.enrollSemester = 1;

#3
select firstName, count(firstName) c
from student
group by firstName
having count(firstName)>1
order by c desc;

#4
select student.major, count(student.studentid) as "Students", course.courseCredit
from student 
join enroll on student.studentid = enroll.studentid
join class on class.classCode = enroll.classCode
join course on course.courseCode = class.courseCode
where course.courseCredit = 4
and student.transfer = 'n'
group by student.major
order by count(student.studentid) desc;

#5
select round(avg(student.GPA),3) as "Average GPA"
from student
join enroll on student.studentid = enroll.studentid
join class on class.classCode = enroll.classCode
where enrollSemester = 1
and classTime like 'Wed%';

#6
select class.courseCode, count(enroll.studentid) as "Number of Students"
from enroll
join class on class.classCode = enroll.classCode
where enrollSemester = 2
group by class.courseCode
order by count(enroll.studentid) desc;
