--Exam 2 pracice 
--3.11a
select distinct name --we use distince because we dont want duplicates and we just want name 
FROM takes t, student s --we are using two tables fom this dtabse becuase studentstaken courses are on the takes table and the name is under studnts
WHERE takes.t = student.s -- we need to combine them both using the primary key ID 
    AND course_id ='CS' -- we also only want the courses that are CS so we do this as well


--3.11b
select ID, name --finsifn the id and name 
from takes t, student s -- these two tables are thr location of the informaton 
WHERE takes.t = student.s --joining these two using primary key 
--Having year > --before spring 2009

--3.11c
select dept_name, max(salary)
from instructors
group by dept_name
order by dept_name DESC

--3.11d

select dept_name, min(maxsal) 
from (
    select dept_name, max(salary) as maxsal
    from instructors
    group by dept_name
    order by dept_name DESC
) sub

with minofmax (dept_name, min(maxsal)) as --idk
(
    select dept_name, max(salary) as maxsal
    from instructors
    group by dept_name
)

--3.12.a
insert into course (course_id, title, dept_name, credits)
VALUES ('CS', 'Weekly Sem', 'Computer Science', '0' )

--SAMPLE SQL Queries
--1
SELECT title, c.course_id, dept_name --everythign that is common u tell it which on ur using 
FROM section s JOIN course c on s.course_id=c.course_id
WHERE year = 2010;
--2
select d.dept_name , budget, count(course_id)
from department d, course c, section s
where d.dept_name = c.dept_name AND -- common gorund to be joined by
c.course_id = s.course_id AND s.year = 2010
group by d.dept_name, budget
--3
select d.dept_name , budget, count(course_id)
from department d, course c, section s
where d.dept_name = c.dept_name AND -- common gorund to be joined by
c.course_id = s.course_id AND s.year = 2010
group by d.dept_name, budget
having count(course_id) > 1
order by c.course_id desc
--4



--1 
select title, c.course_id, dept_name
from course c JOIN section s ON c.course_id = s.course_id --we need to joinbeiase course does nto have year 
where year = 2010

--2 
select d.dept_name, budget, count(course_id) as num
from d department, c course, s section
where d.dept_name = c.dept_name AND
    c.course_id = s.course_id AND 
    year = 2010
group by d.dept_name, budget

--3
select d.dept_name, budget, count(course_id) as num
from d department, c course, s section
where d.dept_name = c.dept_name AND
    c.course_id = s.course_id AND 
    year = 2010
group by d.dept_name, budget
having num > 1
order by num desc


--4
select distinct name, id 
from s student, t takes, s section 
WHERE s.id = t.id AND t.course_id = c.course_id
AND dept_name = 'Comp. Sci'
EXCEPT  
select distinct name, id 
from s student, t takes, s section
WHERE s.id = t.id AND t.course_id = c.course_id
AND dept_name = 'MATH'



--1
select title, c.course_id, dept_name
from course c JOIN section s ON c.course_id = s.course_id
where year = 2010

--2
select dept_name, budget, count(course_id)
from department d, course_id c, section s
where d.dept_name = c.dept_name AND c.course_id = course_id
AND year = 2010
group by dept_name, budget

--3
select dept_name, budget, count(course_id) as num
from department d, course_id c, section s
where d.dept_name = c.dept_name AND c.course_id = course_id
AND year = 2010
group by dept_name, budget
having num > 1
order by num DESC

--4
select distinct names, s.ID
from takes t, student s, course c
where t.ID = s.ID AND c.course_id = t.course_id
AND c.dept_name = 'Comp Sci.'
EXCEPT
select distinct names, s.ID
from takes t, student s, course c
where t.ID = s.ID AND c.course_id = t.course_id
AND c.dept_name = 'MATH'

   
--5 
WITH CS(ID, sec_id, semester, year) AS (
    SELECT t.ID, t.sec_id, t.semester, t.year
    FROM takes t, course c
    WHERE t.course_id=c.course_id 
    AND c.dept_name='Comp. Sci.'    --- this returns a table of studnts that take classes of the computer scince department 
)


SELECT s.name, s.ID, COUNT(CS.sec_id) as CNT --connecting sec_id of cs where its takign the coutnof sec_id of that sepecific table
FROM student s left outer join CS ON s.ID=CS.ID  --left outer join joins cs to matvh studntssso all studnts are listed 
GROUP BY s.name, s.ID
ORDER BY CNT;


--5 
With my_with (ID, sec_id) as (     -- creating a with called my_with using the attributes ID and sec_id
    select t.id, t.sec_id -- selcting in the with id and sec_id sepcifcyign which one were using from the two (takes)
    from course c, takes t -- usign course and takes tables
    where c.course_id = t.course_id -- joining tables by id primary key 
    AND c.dept_name = 'Comp. Sci'   --specifing condotion in which we are only outputting the rows with the dapartent names comp sci 
)
--my_with gives us a object table that outputs the columns id and sec_id that 

select title, course_id
from course
where course_id LIKE 'A%'

--5
GO 

with cs_count(id) as (-- with named cs_count and gets id
      select t.id --selecting id 
      from takes t, course c -- useing attributes takes and course 
      where t.course_id = c.course_id and c.dept_name = 'Comp. Sci.' --joining and giving each row has to be deptname 
--this is outputting a table that gives a column of id's of students that is of the computer sceince department 
)

select name, s.id, count(cs.id) cnt -- cnt is the count of 
from student s left join cs_count cs on s.id = cs.id
group by name, s.id
order by cnt;


--8
create table department
    (dept_name varchar(20),
    building varchar(15),
    budget numeric(12,2) check (budget > 0),
    primary key (dept_name)
);
create table instructor
    (ID varchar(5),
    name varchar(20) not null,
    dept_name varchar(20),
    salary numeric(8,2) check (salary > 29000),
    primary key (ID),
    foreign key (dept_name) references department
        on delete set null

);

--8 instructor and department relations
--department 
create table department 
    (
        dept_name varchar(20),
        building varchar (20),
        budget  numeric(12,2), check (budget > 0), --#puts up a restiction so it cant go below zero
        primary key (dept_name)--dont forget commas 
    )
---------------------------------------------------
--instructor
create table istructor 
(
    ID    varchar(20),
    name   varchar(20) not null,
    dept_name  varchar(20), 
    salray     numeric(8,2) check (salray > 29000),
    primary key (ID), 
    foreign key (dept_name) references department 
        on delete set null
);
