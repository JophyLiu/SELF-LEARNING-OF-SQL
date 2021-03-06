
CREATE TABLE STUDENT
(SNO VARCHAR(3) NOT NULL, 
SNAME VARCHAR(4) NOT NULL,
SSEX VARCHAR(2) NOT NULL, 
SBIRTHDAY DATETIME,
CLASS VARCHAR(5));
CREATE TABLE COURSE
(CNO VARCHAR(5) NOT NULL, 
CNAME VARCHAR(10) NOT NULL, 
TNO VARCHAR(10) NOT NULL);
CREATE TABLE SCORE 
(SNO VARCHAR(3) NOT NULL, 
CNO VARCHAR(5) NOT NULL, 
DEGREE NUMERIC(10, 1) NOT NULL) ;

CREATE TABLE TEACHER 
(TNO VARCHAR(3) NOT NULL, 
TNAME VARCHAR(4) NOT NULL, TSEX VARCHAR(2) NOT NULL, 
TBIRTHDAY DATETIME NOT NULL, PROF VARCHAR(6), 
DEPART VARCHAR(10) NOT NULL);

INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (108 ,'曾华' 
,'男' ,'1977-09-01',95033);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (105 ,'匡明' 
,'男' ,'1975-10-02',95031);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (107 ,'王丽' 
,'女' ,'1976-01-23',95033);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (101 ,'李军' 
,'男' ,'1976-02-20',95033);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (109 ,'王芳' 
,'女' ,'1975-02-10',95031);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (103 ,'陆君' 
,'男' ,'1974-06-03',95031);

INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('3-105' ,'计算机导论',825);
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('3-245' ,'操作系统' ,804);
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('6-166' ,'数据电路' ,856);
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('9-888' ,'高等数学' ,100);

INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (103,'3-245',86);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (105,'3-245',75);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (109,'3-245',68);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (103,'3-105',92);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (105,'3-105',88);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (109,'3-105',76);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (101,'3-105',64);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (107,'3-105',91);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (108,'3-105',78);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (101,'6-166',85);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (107,'6-106',79);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (108,'6-166',81);

INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES (804,'李诚','男','1958-12-02','副教授','计算机系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES (856,'张旭','男','1969-03-12','讲师','电子工程系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART)
VALUES (825,'王萍','女','1972-05-05','助教','计算机系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES (831,'刘冰','女','1977-08-14','助教','电子工程系');

SELECT SNAME,SSEX,CLASS FROM STUDENT;
SELECT DISTINCT DEPART FROM TEACHER; # 选择不重复的项 DISTINCT
SELECT * FROM STUDENT;
SELECT * FROM SCORE WHERE DEGREE BETWEEN 60 AND 80; # 选择成绩在60和80之间
SELECT * FROM SCORE WHERE DEGREE IN (85,86,88); #选择成绩在（in) 85 86 88之间
SELECT * FROM STUDENT WHERE CLASS=95031 or SSEX='女';
SELECT * FROM STUDENT ORDER BY CLASS DESC; #以降序的方式
SELECT * FROM SCORE ORDER BY CNO ASC, DEGREE DESC; #CNO以升序，逗号隔开 degree以降序
SELECT COUNT(*) FROM STUDENT WHERE CLASS=95031; #计算学生人数 用count（）
SELECT SSNO,CNO FROM STUDENT WHERE DEGREE=(SELECT MAX(DEGREE) FROM SCORE); 
# 查询Score表中的最高分的学生学号和课程号 最大max 两个select

SELECT AVG(DEGREE) FROM SCORE WHERE CNO='3-105';
SELECT AVG(DEGREE) FROM SCORE WHERE CNO LIKE '3%' GROUP BY CNO HAVING COUNT(SNO)>=5;
#查询Score表中至少有5名学生选修的并以3开头的课程的平均分数
#注意GROUP BY，HAVING 必须与GROUP BY 同时使用
SELECT SNO FROM SCORE GROUP BY SNO HAVING MAX(DEGREE)<90 AND MIN(DEGREE)>70;
SELECT A.SNAME,B.CNO,B.DEGREE FROM STUDENT AS A JOIN SCORE AS B ON A.SNO=B.SNO;
#查询所有学生的Sname、Cno和Degree列。
SELECT A.SNO, B.CNAME,C.DEGREE FROM STUDENT AS A JOIN (COURSE B,SCORE C) ON A.SNO=C.SNO AND B.CNO=C.CNO; 
#查询所有学生的Sno、Cname和Degree列
SELECT A.SNAME, B.CNAME,C.DEGREE FROM STUDENT AS A JOIN (COURSE B,SCORE C) ON A.SNO=C.SNO AND B.CNO=C.CNO;
#查询所有学生的Sno、Cname和Degree列
SELECT AVG(B.DEGREE) FROM SCORE AS B JOIN STUDENT AS A ON A.SNO=B.SNO WHERE A.CLASS='95033';
#查询“95033”班所选课程的平均分。


create table grade
(low NUMERIC(3,0),
upp numERIC(3),
rank char(1));
insert into grade values(90,100,'A');
insert into grade values(80,89,'B');
insert into grade values(70,79,'C');
insert into grade values(60,69,'D');
insert into grade values(0,59,'E');
commit;
SELECT A.SNO, A.CNO, B.RANK FROM SCORE AS A JOIN GRADE AS B WHERE A.DEGREE BETWEEN B.LOW AND B.UPP;
#现查询所有同学的Sno、Cno和rank列。上面可以写成 FROM SCORE A,GRADE B 
SELECT A.* FROM SCORE A JOIN SCORE B WHERE A.CNO='3-105' AND A.DEGREE>B.DEGREE AND B.SNO='109' AND B.CNO='3-105';
#查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录

SELECT * FROM SCORE WHERE DEGREE<(SELECT MAX(DEGREE) FROM SCORE) GROUP BY SNO HAVING COUNT(SNO)>1 ORDER BY DEGREE; 
#查询score中选学一门以上课程的同学中分数为非最高分成绩的记录

SELECT * FROM SCORE WHERE DEGREE>ALL(SELECT DEGREE FROM SCORE WHERE CNO='3-105' AND SNO=109);

SELECT SNO,SNAME,SBIRTHDAY FROM STUDENT WHERE YEAR(SBIRTHDAY)=(SELECT YEAR(SBIRTHDAY) FROM STUDENT WHERE SNO=109); 
#
SELECT A.DEGREE FROM SCORE A JOIN (COURSE B, TEACHER C) ON A.CNO=B.CNO AND B.TNO AND C.TNO WHERE C.TNAME='张旭';
SELECT A.TNAME FROM TEACHER A JOIN (COURSE B, SCORE C) ON (A.TNO=B.TNO AND C.CNO=B.CNO) GROUP BY C.CNO HAVING COUNT(C.CNO)>5; 

SELECT * FROM STUDENT A JOIN (SCORE B,COURSE C, TEACHER D) ON A.SNO=B.SNO AND B.CNO=C.CNO AND C.TNO=D.TNO WHERE A.CLASS IN (95033,95031);
SELECT CNO FROM SCORE GROUP BY CNO HAVING MAX(DEGREE)>85;
SELECT A.* FROM SCORE A JOIN (COURSE B,TEACHER C) ON A.CNO=B.CNO AND B.TNO=C.TNO WHERE C.DEPART='计算机系';
SELECT * from score where cno in (select a.cno from course a join teacher b on 
a.tno=b.tno and b.depart='计算机系'); 
select tname,prof from teacher where depart='计算机系' and prof not in (select prof from 
teacher where depart='电子工程系');
#查询“计算机系”里与“电子工程系“不同职称的教师的Tname和Prof

SELECT * FROM SCORE WHERE DEGREE>ALL(SELECT DEGREE FROM SCORE WHERE CNO='3-245') ORDER BY DEGREE DESC;
#查询选修编号为“3-105”且成绩高于选修编号为“3-245”课程的同学的Cno、Sno和Degree.

SELECT SNAME AS NAME, SSEX AS SEX, SBIRTHDAY AS BIRTHDAY FROM STUDENT
UNION
SELECT TNAME AS NAME, TSEX AS SEX, TBIRTHDAY AS BIRTHDAY FROM TEACHER;
#查询所有教师和同学的name、sex和birthday
SELECT SNAME AS NAME, SSEX AS SEX, SBIRTHDAY AS BIRTHDAY FROM STUDENT WHERE SSEX='女'
UNION
SELECT TNAME AS NAME, TSEX AS SEX, TBIRTHDAY AS BIRTHDAY FROM TEACHER WHERE TSEX='女';
SELECT A.* FROM SCORE A WHERE A.DEGREE<(SELECT AVG(B.DEGREE) FROM SCORE B WHERE A.CNO=B.CNO);
#
SELECT AVG(DEGREE) FROM SCORE GROUP BY CNO;

SELECT A.TNAME,A.DEPART FROM TEACHER A JOIN COURSE B ON A.TNO=B.TNO;
select tname,depart from teacher a where exists(select * from course b where a.tno=b.tno);
#exist 
select tname,depart from teacher a where not exists(select * from course b where a.tno=b.tno);

SELECT CLASS FROM STUDENT GROUP BY CLASS HAVING COUNT(SSEX='男')>=2;
SELECT * FROM STUDENT WHERE SNAME NOT LIKE '王%';
SELECT SNAME,(YEAR(NOW())-YEAR(SBIRTHDAY)) AS AGE FROM STUDENT;
#查询Student表中每个学生的姓名和年龄

select sname,sbirthday as THEMAX from student where sbirthday =(select min(SBIRTHDAY) 

from student)
union
select sname,sbirthday as THEMIN from student where sbirthday =(select max(SBIRTHDAY) from 

student);#查询Student表中最大和最小的Sbirthday日期值

SELECT CLASS,(YEAR(NOW())-YEAR(SBIRTHDAY)) AS AGE FROM STUDENT ORDER BY CLASS DESC, AGE DESC;
SELECT A.TNAME,B.CNAME FROM TEACHER A JOIN COURSE B USING(TNO) WHERE A.TSEX='男';
SELECT A.* FROM SCORE A WHERE DEGREE=(SELECT MAX(DEGREE) FROM SCORE B );
#注意里面
SELECT SNAME FROM STUDENT A WHERE SSEX=(SELECT SSEX FROM STUDENT B WHERE B.SNAME='李军');
SELECT SNAME FROM STUDENT A WHERE SSEX=(SELECT SSEX FROM STUDENT B WHERE B.SNAME='李军') AND
CLASS=(SELECT CLASS FROM STUDENT B WHERE B.SNAME='李军');
select * from score where sno in(select sno from student where
ssex='男') and cno=(select cno from course
where cname='计算机导论');
