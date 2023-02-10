-- DCL
-- root 계정 : 관리자 계정 -> root passwd 함부로 공개하면 안돼. . . 
SHOW DATABASES;

-- mysql : 전체 db를 관리하는 database
-- 	root 관리자만 사용가능
-- 	mysql 에는 user 테이블, 즉 사용자에 대한 정보를 가지고 있다
USE mysql;
SHOW TABLES;

SELECT * FROM USER; -- user 정보를 확인할 수 있음

-- 	db 테이블 => 사용자가 이용할 데이터 베이스 정보를 가짐
SELECT * FROM db;

-- 사용자 추가
-- CREATE USER 사용자명@(~에 위치하다)HOST(db서버의 id OR NAME) IDENTIFIED BY '비밀번호'
CREATE USER yannju@127.0.0.1 IDENTIFIED BY 'dlduswn';
SELECT * FROM USER;

-- 외부에서도 접근이 가능하도록 하려면 host에 '%'로 하여 똑같은 계정을 추가한다
CREATE USER 'yannju'@'%' IDENTIFIED BY 'dlduswn';
DROP USER yannju@'%';
SELECT * FROM USER;

-- 사용자 삭제
-- DROP USER 사용자명
CREATE USER king@localhost IDENTIFIED BY '1234';
CREATE USER 'king'@'%' IDENTIFIED BY '1234';
DROP USER king@localhost;
DROP USER 'king'@'%';

-- database 생성
SHOW DATABASES;
CREATE DATABASE multidb;

-- yannju 사용자에게 multidb 사용 권한을 부여
-- dcl : grant, revoke
-- 	all privileges 전체 권한 부여
-- 	flush privileges 권한 부여 적용
-- 	show grants for 계정아이디@host 권한 확인
GRANT ALL PRIVILEGES ON multidb.* TO yannju@127.0.0.1; -- all privileges 를 하면 전체 권한
SHOW GRANTS FOR yannju@127.0.0.1;

USE mysql;
SELECT * FROM db;

-- 권한 회수
REVOKE ALL ON multidb.* FROM yannju@127.0.0.1;