-- [문제1]
--		EMP테이블에서 부서별로 인원수,평균 급여, 급여의 합, 최소 급여,
--		최대 급여를 포함하는 EMP_DEPTNO 테이블을 생성하라.
CREATE TABLE emp_deptno
AS
SELECT deptno,COUNT(*) cnt, AVG(sal) avg_sal, SUM(sal) sum_sal, MIN(sal) min_sal, MAX(sal) max_sal
FROM emp
GROUP BY deptno;

DESC emp_deptno;
SELECT * FROM emp_deptno;

DROP TABLE emp_deptno;

-- emp 테이블에서 20번 부서의 모든 컬럼을 포함하는 emp20_view를 생성해라
CREATE VIEW emp20_view
AS
SELECT *
FROM emp
WHERE deptno = 20;

SELECT * FROM emp20_view;

SET autocommit = 0;

-- emp테이블에서 30번 부서만 empno를 emp_no로 ename을 name으로
-- 	sal를 salary로 바꾸어 emp30_view를 생성하라
CREATE OR REPLACE VIEW emp30_view
AS
SELECT empno emp_no, ename NAME, sal salary
FROM emp
WHERE deptno = 30;

SELECT * FROM emp30_view;

-- 고객테이블의 고객 정보 중 나이가 19세 이상인
-- 	고객의 정보를
-- 	확인하는 뷰를 만들어보세요.
-- 	단 뷰의 이름은 member_19로 하세요
CREATE OR REPLACE VIEW member_19
AS
SELECT *
FROM member
WHERE age >= 19;

SELECT * FROM member_19;

UPDATE member_19 SET age = 15
WHERE userid = "id1";

SELECT * FROM member; -- 기존 테이블도 수정이 된다.

UPDATE member SET age = 5 -- 원본 테이블도 수정하면 view에서도 빠진다.
WHERE userid = "id2";

ROLLBACK;

-- with check option 절을 이용
CREATE OR REPLACE view member_19
AS
SELECT *
FROM member
WHERE age >= 19
WITH CHECK OPTION;

SELECT * FROM member_19;

/* Err - - > 수정 불가 ! where 절의 조건에 위배되는 update 이므로
UPDATE member_19 SET = 15
WHERE userid = "id1";
*/

-- category와 products, supply_comp 3개의 테이블을 join 하여
-- 	view 를 생성하세요. products_info_view
CREATE OR REPLACE VIEW products_info_view
AS 
SELECT c.*, products_name, output_price, s.ep_name
FROM category c JOIN products p
ON c.CATEGORY_CODE = p.CATEGORY_FK
JOIN supply_comp s
ON p.EP_CODE_FK = s.EP_CODE;

DESC products_info_view;
SELECT * FROM products_info_view;

-- index
-- CREATE INDEX 인덱스명 ON 테이블명 (컬럼명[, 컬럼명2])
-- DROP INDEX 인덱스명 on 테이블명
-- 수정은 없다!
-- 주의 : 인덱스는 not null 인 컬럼에만 사용할 수 있다.

-- 고객 테이블에서 name 컬럼의 인덱스를 만들어보자
CREATE INDEX name_idx ON member (NAME);
SELECT * FROM member WHERE NAME LIKE "%동%";

SHOW INDEX FROM member;
-- DROP INDEX name_idx ON member; Drop문으로 삭제
-- ALTER TABLE member DROP INDEX name_idx; Alter문으로 삭제