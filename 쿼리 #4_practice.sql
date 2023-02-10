-- #4 Practice
-- my sql_테이블 만들기 실습.pdf

-- <1> master table
CREATE TABLE If NOT EXISTS zipcode (
	post1 CHAR(3),
	post2 CHAR(3),
	addr VARCHAR(100) not NULL,
	
	PRIMARY KEY (post1, post2)
);

DESC zipcode;
COMMIT;

-- <2> detail table
CREATE TABLE if NOT EXISTS memberDetail (
	id VARCHAR(16) PRIMARY KEY,
	NAME VARCHAR(30),
	gender CHAR(1) CHECK (gender IN ("F", "M")),
	jumin1 CHAR(6),
	jumin2 CHAR(7),
	tel VARCHAR(15),
	post1 CHAR(3),
	post2 CHAR(3),
	addr1 VARCHAR(100),
	addr2 VARCHAR(100),
	
	FOREIGN KEY (post1, post2) REFERENCES zipcode (post1, post2),
	UNIQUE (jumin1, jumin2)
);

DESC memberdetail;

INSERT INTO zipcode VALUES (111, 222, '서울 마포구');
INSERT INTO zipcode VALUES (111, 223, '서울 서대문구');

SELECT * FROM zipcode;

INSERT INTO memberdetail(id, NAME, gender, jumin1, jumin2, post1, post2)
VALUES(1, "이얀조", "F", 123456, 789012, 111, 222);
INSERT INTO memberdetail(id, NAME, gender, jumin1, jumin2, post1, post2)
VALUES(2, "삼얀조", "M", 223456, 789012, 111, 222);

SELECT * FROM memberdetail;