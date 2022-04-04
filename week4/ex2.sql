--Table creation
create table course_grades(
gradeId int primary key,
grade text not null
);

create table book(
bookId int primary key,
bookName text not null,
publisher text not null
);

create table course(
courseId int primary key,
courseName text not null,
gradeId int not null,
constraint grade_fk foreign key(gradeId) references course_grades(gradeId)
);

create table school(
schoolid int primary key,
schoolName text not null
);

create table teacher(
teacherId int primary key,
teacher text not null
);

create table course_list(
courseNum int primary key,
schoolid int not null,
courseId int not null,
teacherId int not null,
constraint course_fk foreign key(courseId) references course(courseId),
constraint school_fk foreign key(schoolid) references school(schoolId),
constraint teacher_fk foreign key(teacherid) references teacher(teacherId)
);

create table schedule(
courseNum int primary key,
room text not null,
constraint course_fk foreign key(courseNum) references course_list(courseNum)
);

create table loan_books(
courseNum int not null,
bookId int not null,
loanDate date not null,
primary key(courseNum, bookId),
constraint course_fk foreign key(courseNum) references course_list(courseNum),
constraint book_fk foreign key(bookId) references book(bookId)
);

insert into course_grades(gradeId, grade)
values (1, '1st grade'), (2, '2nd grade');

insert into book(bookId, bookName, publisher)
values (1, 'Learning and teaching in early childhood education', 'BOA Editions'), (2, 'Preschool,N56', 'Taylor & Francis'),
(3, 'Early Childhood Education N9', 'Prentice Hall'), (4, 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill');

insert into course(courseId, courseName, gradeId)
values (1, 'Logical thinking', 1), (2, 'Writing', 1), (3, 'Numerical Thinking', 1), (4, 'Spatial, Temporal and Causal Thinking', 1),
(5, 'English', 2);

insert into school(schoolid, schoolName)
values (1, 'Horizon Education Institute'), (2, 'Bright Institution');

insert into teacher(teacherId, teacher)
values (1,'Chad Russell' ), (2, 'E.F.Codd'), (3, 'Jones Smith' ), (4, 'Adam Baker');

insert into course_list(schoolid, courseId, courseNum, teacherId)
values (1, 1, 1, 1), (1, 2, 2, 1), (1, 2, 9, 3),(1, 3, 3, 1), (1, 3, 8, 2),(1, 4, 4, 2), (1, 5, 5, 3), (2, 1, 6, 4), (2, 3, 7, 4);

insert into schedule(courseNum, room)
values (1, '1.A01'), (2, '1.A01'), (3, '1.A01'), (4, '1.B01'), (8, '1.B01'), (9, '1.A01'), (5, '1.A01'), (6, '2.B01'), (7, '2.B01');

insert into loan_books(courseNum, bookId, loanDate)
values (1, 1, '2010-09-09'), (2, 2,'2010-05-05'), ( 3, 1, '2010-05-05'), (4, 3, '2010-05-06'), (8, 1, '2010-05-06'), (9, 1, '2010-09-09'),
(5, 4, '2010-05-05'), (6, 4, '2010-12-18'), (7, 1, '2010-05-06');

--query one
select cl.schoolId, b.publisher, count(b.bookid)
from loan_books lb, course_list cl, book b  
where lb.courseNum = cl.coursenum and lb.bookid = b.bookid
group by cl.schoolId, b.publisher ;
--query two
select distinct on (a.schoolId) school.schoolname , teacher.teacher, book.bookname 
from (select distinct cl2.schoolId, lb2.loandate
from loan_books lb2, book b2, course_list cl2
where lb2.bookid = b2.bookid and lb2.coursenum = cl2.coursenum
order by lb2.loandate) as a, school, teacher, book, course_list, loan_books
where a.schoolId = school.schoolid and course_list.schoolid = a.schoolId and course_list.teacherid = teacher.teacherid and loan_books.coursenum = course_list.coursenum and book.bookid = loan_books.bookid 



