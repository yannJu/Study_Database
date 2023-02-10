/* 고객 테이블 */
CREATE TABLE MEMBER(
  NUM INT(11) DEFAULT '1' NOT NULL,
  USERID VARCHAR(15) NOT NULL,
  NAME VARCHAR(15) NOT NULL,
  PASSWD VARCHAR(8) NOT NULL,
  AGE INT(3) DEFAULT '1' NOT NULL,
  MILEAGE INT(8) DEFAULT '0' NOT NULL,
  JOB VARCHAR(30),
  ADDR VARCHAR(100) NOT NULL,
  REG_DATE DATE NOT NULL,
  PRIMARY KEY(NUM)
);

/* 고객 정보 저장 */
insert into member (num,userid,name,passwd,age,mileage,job,addr,reg_date) 
            values ('1','id1','홍길동','1234',25,0,'학생','부산시 동래구','2013-08-08');
insert into member (num,userid,name,passwd,age,mileage,job,addr,reg_date) 
            values ('2','id2','김길동','2345',30,1500,'직장인','서울시 강남구','2013-09-05');
insert into member (num,userid,name,passwd,age,mileage,job,addr,reg_date) 
            values ('3','id3','공성현','3456',33,10000,'직장인','부산시','2013-09-09');
insert into member (num,userid,name,passwd,age,mileage,job,addr,reg_date) 
            values ('4','id4','김영희','4321',18,3000,'학생','경상남도 마산시','2012-01-01');
insert into member (num,userid,name,passwd,age,mileage,job,addr,reg_date) 
            values ('5','id5','박말자','5555',45,5000,'주부','경기도 남양주시','2013-05-05');
insert into member (num,userid,name,passwd,age,mileage,job,addr,reg_date) 
            values ('6','id6','김철수','1234',55,0,'교수','제주도 북제주','2013-08-08');
insert into member (num,userid,name,passwd,age,mileage,job,addr,reg_date) 
            values ('7','id7','홍길동','1234',41,6000,'학생','경주시','2012-12-25');
insert into member (num,userid,name,passwd,age,job,addr,reg_date) 
            values ('8','id8','김상현','1234',31,'무직','부산시 동래구','2013-04-18');
insert into member (num,userid,name,passwd,age,mileage,job,addr,reg_date) 
            values ('9','id9','이지연','1234',25,0,'학생','강원도 철원','2013-02-06');
insert into member (num,userid,name,passwd,age,mileage,job,addr,reg_date) 
            values ('10','id10','홍길동','6712',62,10000,'주부','서울시 강북','2013-09-15');

select * from member;


/* 카테고리 저장테이블 */
CREATE TABLE CATEGORY(
  CNUM INT(5) DEFAULT '1' NOT NULL,
  CATEGORY_CODE VARCHAR(8) NOT NULL,
  CATEGORY_NAME VARCHAR(30) NOT NULL,
  DELETE_CHK CHAR(1) DEFAULT 'N' NOT NULL,
  PRIMARY KEY(CNUM)
);

/* 카테고리 저장 */
INSERT INTO CATEGORY VALUES('1','00010000','전자제품','N');
INSERT INTO CATEGORY VALUES('2','00010001','TV','N');
INSERT INTO CATEGORY VALUES('3','00010002','컴퓨터','N');
INSERT INTO CATEGORY VALUES('4','00010003','MP3','N');
INSERT INTO CATEGORY VALUES('5','00010004','에어컨','N');
INSERT INTO CATEGORY VALUES('6','00020000','의류','N');
INSERT INTO CATEGORY VALUES('7','00020001','남방','N');
INSERT INTO CATEGORY VALUES('8','00020002','속옷','N');
INSERT INTO CATEGORY VALUES('9','00020003','바지','N');
INSERT INTO CATEGORY VALUES('10','00030000','도서','N');
INSERT INTO CATEGORY VALUES('11','00030001','컴퓨터도서','N');
INSERT INTO CATEGORY VALUES('12','00030002','소설','N');

select * from category;




/* 상품 상세 정보 테이블 */
CREATE TABLE PRODUCTS(
 PNUM INT(11) DEFAULT '1' NOT NULL,
 CATEGORY_FK VARCHAR(8) NOT NULL,
 PRODUCTS_NAME VARCHAR(50) NOT NULL,
 EP_CODE_FK VARCHAR(5) NOT NULL,
 INPUT_PRICE INT(10) DEFAULT '0' NOT NULL,
 OUTPUT_PRICE INT(10) DEFAULT '0' NOT NULL,
 TRANS_COST INT(5) DEFAULT '0' NOT NULL,
 MILEAGE INT(6) DEFAULT '0' NOT NULL,
 COMPANY VARCHAR(30),
 STATUS CHAR(1) DEFAULT '1' NOT NULL,
 PRIMARY KEY(PNUM)
);


/* 상품 내용 저장 */
INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
     OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
   VALUES
    ('1','00010001','S 벽걸이 TV','00001','5000000','8000000','0','100000','삼성','1');

INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,COMPANY,STATUS)
  VALUES
    ('2','00010001','D TV','00002','300000','400000','대우','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
   OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('3','00010004','S 에어컨','00001','1000000','1100000','5000','10000','삼성','2');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('4','00010000','C 밥솥','00003','200000','200000','5500','0','현대','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('5','00010004','L 에어컨','00003','1200000','1300000','0','0','LG','1');

INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
     OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
    ('6','00020001','남성남방','00002','100000','150000','2500','0','','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,STATUS)
  VALUES
   ('7','00020001','여성남방','00002','120000','200000','0','0','3');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
   OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('8','00020002','사각팬티','00002','10000','20000','0','0','보디가드','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,STATUS)
  VALUES
   ('9','00020003','멜빵바지','00002','5000','8000','0','0','1');

INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
     OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('10','00030001','무따기시리즈','00001','25000','30000','2000','0','길벗','1');

select * from products;



/* 공급업체 정보 테이블 */
CREATE TABLE SUPPLY_COMP(
  NUM INT(11) DEFAULT '1' NOT NULL,
  EP_CODE VARCHAR(5) NOT NULL,
  EP_NAME VARCHAR(30) NOT NULL,
  EP_ADDR VARCHAR(100), 
  EP_PHONE VARCHAR(15),
  EP_CHARGE VARCHAR(10),
  REG_DATE DATE NOT NULL,
  PRIMARY KEY(NUM)
);

show tables;
select * from supply_comp;
/* 공급업체 정보 저장 */
INSERT INTO SUPPLY_COMP (NUM,EP_CODE,EP_NAME,EP_ADDR,
                                   EP_PHONE,EP_CHARGE,REG_DATE)
   VALUES('1','00001','공급업체A','부산시 동구','111-2345-3333','공성현',now());

INSERT INTO SUPPLY_COMP( NUM,EP_CODE,EP_NAME,EP_ADDR,
                                   EP_PHONE,EP_CHARGE,REG_DATE) 
   VALUES('2','00002','공급업체B','서울시 종로구','333-3322-399','공성현',now());
   


INSERT INTO SUPPLY_COMP( NUM,EP_CODE,EP_NAME,EP_ADDR,
                                   EP_PHONE,EP_CHARGE,REG_DATE)
   VALUES('3','00004','공급업체C','서울시 강남구','444-233-3385','공성현',now());

INSERT INTO SUPPLY_COMP( NUM,EP_CODE,EP_NAME,EP_ADDR,
                                   EP_PHONE,EP_CHARGE,REG_DATE)
   VALUES('4','00005','공급업체D','인천시 동구','15-1222-3313','공성현',now());

INSERT INTO SUPPLY_COMP( NUM,EP_CODE,EP_NAME,EP_ADDR,
                                   EP_PHONE,EP_CHARGE,REG_DATE)
   VALUES('5','00006','공급업체F','광주시 남구','134-2312-3444','공성현',now());


select * from  category;
select * from  products;
select * from  SUPPLY_COMP;



