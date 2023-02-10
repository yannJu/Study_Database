-- DDL
CREATE TABLE bit_table (
id INT,
CODE bit(7) -- int 가 들어오면 bitwise 로 변경해줌
);

SHOW TABLES;

DESC bit_table;
INSERT INTO bit_table(id, CODE)
VALUES(100, 5);

ROLLBACK; 
SELECT * FROM bit_table; 

CREATE TABLE if NOT EXISTS reservation (
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(30),
	reserve_date DATE,
	room_num SMALLINT UNSIGNED,
	room_type ENUM('single', 'double', 'triple')
);                    

DESC reservation;
ROLLBACK;

-- 예약자이름, 예약일(현재날짜), 201, room_type 은 알아서 지정
INSERT into reservation(NAME, reserve_date, room_num, room_type)
VALUES("얀조", CURDATE(), 201, 2);

SELECT * FROM reservation;

-- primary key 제약조건 주기
-- unique + not null
-- 자동으로 unique index 가 생성
-- <1> col 수준에서의 제약 : [constraint 제약조건이름(생략가능)] 제약조건 유형 -> mysql 은 안된다.
CREATE TABLE if NOT EXISTS user_tab (
	num INT PRIMARY KEY, -- 회원번호
	NAME VARCHAR(20), -- 회원이름
	passwd VARCHAR(10)
);

SELECT * FROM user_tab;
DESC USER_tab ;

-- <2> table 수준에서의 제약
CREATE TABLE user_tab2 (
	num INT,
	NAME VARCHAR(20),
	passwd VARCHAR(10),
	CONSTRAINT user_tab2_num_pk PRIMARY KEY(num) -- 제약조건 명칭은 제공이 안된다.
);

ROLLBACK;
DESC user_tab2;

-- foreign key (외래키) 제약조건
-- 부모 테이블 (master table)
CREATE TABLE dept_tab (
	deptno SMALLINT, 
	dname VARCHAR(30), 
	loc VARCHAR(20),
	
	CONSTRAINT masterTable PRIMARY KEY (deptno) 
);

DESC dept_tab;

-- 자식 테이블 (detail table)
CREATE TABLE emp_tab (
	empno INT,
	ename VARCHAR(20) NOT NULL,
	job VARCHAR(20),
	mgr INT REFERENCES emp_tab(empno), -- fk (col 수준이므로 references 로 충분)
	hiredate DATETIME DEFAULT NOW(), -- 시스템의 현재시간으로 default
	sal DECIMAL(7, 2),
	comm DECIMAL(7, 2),
	deptno SMALLINT, 
	
	PRIMARY KEY (empno),
	FOREIGN KEY (deptno) REFERENCES dept_tab(deptno) -- fk (table 수준이므로 foreign key로 명시)
);

DESC emp_tab;

-- insert test data
-- master table
INSERT INTO dept_tab(deptno, dname, loc)
VALUES(1, "R&D", "Ulsan");

INSERT INTO dept_tab(deptno, dname, loc)
VALUES(3, "HW", "Incheon");

SELECT * FROM dept_tab;

-- detail table
INSERT INTO emp_tab(empno, ename, job, sal, comm, deptno)
VALUES(1, "얀조야", "백수", 50000, 2000, 1);

INSERT INTO emp_tab(empno, ename, job, mgr, sal, comm, deptno)
VALUES(2, "삼조야", "교사", 1, 70000, 2000, 3);

SELECT * FROM emp_tab;

COMMIT;

/* -> fk deptno 이 없는 deptno을 참조하므로 에러
INSERT INTO emp_tab(empno, ename, deptno, job)
VALUES(3, "김연조", 2, "집순이");
*/

INSERT INTO emp_tab(empno, ename, job, mgr, sal, comm, deptno)
VALUES(3, "백연조", "집순이", 1, 0, 0, 1);

-- dept_tab 3번 부서를 삭제하세요 --> Err
-- 3번을 참조하는 col이 있기때문에 . . fk 로 관계가 이미 되어있으므로
/*
DELETE FROM dept_tab
WHERE deptno = 3;
*/

-- update후 delete는 가능
UPDATE emp_tab SET deptno = 3 WHERE deptno = 1;

DELETE FROM dept_tab
WHERE deptno = 1;

SELECT * FROM dept_tab; -- deptno 1이 사라짐

-- 자식 레코드가 있는 상태에서 부모 레코드를 지우려면 on delete cascade 옵션을 주면 가능하다
-- 부모 레코드를 삭제할 때 자식 레코드도 같이 삭제됨

CREATE TABLE board (
	num INT PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	content TEXT,
	wdate DATE DEFAULT NOW()
);

DESC board;

-- 댓글 : reply
CREATE TABLE reply (
	rnum INT PRIMARY KEY,
	rcontent TEXT,
	rdate DATE DEFAULT NOW(),
	num_fk INT REFERENCES board(num) ON DELETE CASCADE -- master table 이 삭제될때 같이 삭제
);

DESC reply;

-- board data insert
INSERT INTO board(num, title, content)
VALUES(1, "이연주 취업하다.", "만 22세 국민대학생 이연주가 취업에 성공했다.");

INSERT INTO board(num, title, content)
VALUES(2, "딸기맛 바나나킥 출시!", "어렵게 만들어낸 신상과자! 세븐일레븐에서 먼저 맛보세요 ~ ");

INSERT INTO board(num, title, content)
VALUES(3, "양재역까지 단 30분 !", "새로운 지하철이 개통되었습니다. 확인해주세요");

SELECT * FROM board;

-- reply data insert
INSERT INTO reply(rnum, rcontent, num_fk)
VALUES(1, "ㅋㅋ 아무나 취업하냐", 1);

INSERT INTO reply(rnum, rcontent, num_fk)
VALUES(2, "축하드려요 ~~! ", 1);

INSERT INTO reply(rnum, rcontent, num_fk)
VALUES(3, "인절미맛 뭐도 나왔든데 ", 2);

-- 현재 1번 게시글 댓글 2개, 2번 게시글 댓글 1개
SELECT * FROM reply;

-- board 와 reply 를 join 해서 같이 보여주세요.
SELECT * 
FROM board b left outer JOIN reply r
ON b.num = r.num_fk;

-- 1번 게시글을 지워보자 . .
-- fk(참조)더라도 on delete cascade 를 주었기 때문에 괜찮다.
DELETE FROM board
WHERE num = 1;

ROLLBACK;

-- unique key : 데이터 중복을 허용하지 않는다 ! -> PK와 차이점 = Null을 허용한다는 점
CREATE TABLE uni_tab (
	dno INT UNIQUE, -- unique col 수준
	dname CHAR(20),
	loc CHAR(20),
	UNIQUE (dname) -- table 수준에서의 제약 (아마 자동으로 constraint 명이 들어갈 것)
);

DESC uni_tab;

INSERT INTO uni_tab(dno, dname, loc)
VALUES (1, null, "Incheon");

INSERT INTO uni_tab(dno, dname, loc)
VALUES (2, null, "Incheon");

SELECT  * FROM uni_tab;

INSERT INTO uni_tab(dno, dname, loc)
VALUES (null, null, "Incheon");

-- not null : null값을 허용하지 않음 -> col수준에서만 제약 가능! !! (table 수준에선 불가)
CREATE TABLE nn_tab (
	dno INT NOT NULL,
	dname CHAR(20),
	loc CHAR(20)
	-- NOT NULL (loc) : table 수준 불가
);

DESC nn_tab;

-- insert not null -> Err
/*
INSERT INTO nn_tab(dno, dname, loc)
VALUES(NULL, "얀조", "Seoul");
*/

-- check 제약조건 : 행이 만족해야 하는 조건을 기술
-- col 수준
CREATE TABLE ckMember_tab (
	idx INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20) NOT NULL,
	hp1 CHAR(3) CHECK (hp1 IN ("010", "011")),
	hp2 CHAR(4) NOT NULL,
	hp3 CHAR(4) NOT NULL
);

DESC ckMember_tab;

INSERT INTO ckMember_tab (NAME, hp1, hp2, hp3)
VALUES("이연조", "010", "9236", "4170");

INSERT INTO ckMember_tab (NAME, hp1, hp2, hp3)
VALUES("삼연조", "010", "3236", "3170");

/* hp1이 잘못 입력 (Err)
INSERT INTO ckMember_tab (NAME, hp1, hp2, hp3)
VALUES("사연조", "019", "4236", "4170");
*/

SELECT * FROM ckmember_tab;

-- table 수준
CREATE TABLE ckmember_tab2 (
	idx INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20) NOT NULL,
	hp1 CHAR(3) ,
	hp2 CHAR(4) NOT NULL,
	hp3 CHAR(4) NOT NULL
	
	CHECK (hp1 IN ("010", "011"))
);

DESC ckmember_tab2;

-- ALTER 문장 
-- 컬럼 추가/ 변경 / 삭제하고자 할 때 사용

-- ALTER TABLE 테이블명 ADD 추가할 컬럼정보
-- ALTER TABLE 테이블명 MODIFY 수정할 컬럼정보
-- ALTER TABLE 테이블명 DROP COLUMN 삭제할 컬럼명
-- ALTER TABLE 테이블명 RENAME COLUMN 예전컬럼명 TO 새컬럼명
DROP TABLE ckmember_tab2;
SHOW TABLES;

-- (Err) 없는 테이블 select : SELECT * FROM ckmember_tab2;
-- data 가 별로 없는 경우 -> drop 하고 다시 만들어도 돼!
-- 하지만 data가 많다면 . .  Alter를 이용하여 변경하자 ^ __ ^

-- demo tab 을 생성하되 name varchar(20)
CREATE table demo_tab (
	NAME VARCHAR(20)
);
DESC demo_tab;

-- demo_tab 에 no int 컬럼 추가
ALTER TABLE demo_tab
ADD NO INT;

-- NO 컬럼의 자료형을 CHAR(11)로 수정하세요
ALTER TABLE demo_tab
MODIFY NO CHAR(11);

-- NAME컬럼을 삭제하세요
ALTER TABLE demo_tab
DROP COLUMN NAME;

-- NO 컬럼의 이름을 NUM으로 변경하세요
ALTER TABLE demo_tab
RENAME column NO TO num;