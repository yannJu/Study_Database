SELECT * FROM member;
-- 	고객(MEMBER) 테이블에서 이름이 홍길동이면서 직업이 학생이 정보를 
-- 	모두 보여주세요.
SELECT *
FROM member
WHERE NAME = '홍길동' AND job = '학생';

-- 	고객 테이블에서 이름이 홍길동이거나 직업이 학생이 정보를 
-- 	모두 보여주세요.
SELECT *
FROM member
WHERE NAME = '홍길동' OR job = '학생';

-- 	상품(PRODUCTS) 테이블에서 제조사(COMPANY)가 삼성 또는 대우 이면서 
-- 	   판매가가 100만원 미만의 상품 목록을 보여주세요.
SELECT * FROM products;

SELECT *
FROM products
WHERE company IN ('삼성', '대우')
AND output_price < 1000000;

--  상품 테이블에서 배송비의 내림차순으로 정렬하되, 
--  같은 배송비가 있는 경우에는 마일리지의 내림차순으로 정렬하여 보여주세요.
SELECT *
FROM products
ORDER BY trans_cost DESC, mileage desc;

-- 상품 테이블에서 공급가가 가장 비싼 순으로 TOP 3안에 드는 상품을 보여주세요
SELECT *
FROM products
ORDER BY input_price desc
LIMIT 3;

-- 사원 테이블에서 입사한 년도별로 사원 수를 보여주세요.
SELECT * FROM emp;

SELECT year(hiredate), COUNT(*)
FROM emp
GROUP BY year(hiredate);

-- 사원 테이블에서 해당년도 각 월별로 입사한 사원수를 보여주세요.
SELECT DATE_FORMAT(hiredate, '%Y/%m') IPSA, COUNT(hiredate)
FROM emp
GROUP BY IPSA;

-- 사원테이블에서 현재까지의 근무 일수가 몇 주 몇일인가를 출력하세요.
-- 단 근무일수가 많은 사람순으로 출력하세요.
SELECT ename, round(DATEDIFF(NOW(), hiredate) / 7) WEEK, MOD(hiredate , 7) DAY
FROM emp
ORDER BY DATEDIFF(NOW(), hiredate) DESC;

-- 사원 테이블에서 83년도에 입사한 사원 정보를 현재 년도 정보로 입사일을 수정하세요
SELECT *
FROM emp
WHERE YEAR(hiredate) = 1983;

UPDATE emp
SET hiredate = NOW()
WHERE YEAR(hiredate) = 1983;

SELECT *
FROM emp
WHERE ename = 'ADAMS';

ROLLBACK;
-- EMP테이블에서 입사일자가 81년도 1월에 입사한 사원의 정보를 삭제하라.
SELECT *
FROM emp
WHERE DATE_FORMAT(hiredate, '%y-%m') = '81-02';

DELETE FROM emp
WHERE year(hiredate) = 1981 AND MONTH(hiredate) = 2; 

SELECT *
FROM emp
WHERE DATE_FORMAT(hiredate, '%y-%m') = '81-02';

ROLLBACK;

 -- MEMBER테이블을 카피해서 MEMBER_20 을 만드세요. 단 테이블 구조만 복사하세요
 -- 고객 테이블에서 20세 이상인 회원정보들만 가져와서 MEMBER_20에 삽입하세요
 CREATE table memberCp
 AS SELECT * FROM member WHERE 0 = 1;

INSERT INTO memberCp
SELECT * FROM member WHERE age >= 20;

SELECT * FROM membercp;
 
-- INSERT 해서 회원정보 3명을 추가하세요
INSERT INTO membercp
VALUES(50, "id50", "얀조50", "5000", 50, 50, "백수", "인천광역시 부평구", "2023-05-05");
INSERT INTO membercp
VALUES(51, "id51", "얀조51", "5001", 51, 51, "개발자", "울산광역시 중구", "2023-05-01");
INSERT INTO membercp
VALUES(52, "id52", "얀조52", "5002", 52, 52, "엔지니어", "경기도 부천시", "2023-05-02");

SELECT * FROM memberCp;

-- PRODUCTS2 사본 테이블을   만들어 실습하세요
-- 1] 상품 테이블에 있는 상품 중 상품의 판매 가격이 10000원 이하인 상품을 모두 
-- 	      삭제하세요.
CREATE TABLE if not exists productCp AS SELECT * FROM products;
SELECT * FROM productCp;

DELETE FROM productCp 
WHERE output_price < 10000;

SELECT * FROM productCp;

SELECT @@autocommit; -- autocommit 확인 , 1 = autocommit on
SET autocommit = 0;

-- 	2] 상품 테이블에 있는 상품 중 상품의 대분류가 전자제품인 상품을 삭제하세요.
SELECT * FROM productCp;
SELECT * FROM category;

DELETE FROM productCp 
WHERE productCp.category_fk = (SELECT category_code FROM category WHERE category_name = '전자제품');
SELECT * FROM productCp;

ROLLBACK;
-- PRODUCTS2 에서 가장 비싼 판매가를 가진 상품 정보를 삭제하세요
SELECT * FROM productCp;
SELECT products_name, MAX(output_price) FROM productCp;
DELETE FROM productCp WHERE output_price = (SELECT MAX(output_price) FROM productCp);

-- PRODUCTS2 에서 가장 저렴한 판매가를 가진 상품의 판매가를 20% 인상하세요
SELECT * FROM productCp;
SELECT MIN(output_price) FROM productCp;
UPDATE productCp SET output_price = output_price * 1.2 WHERE output_price = (SELECT MIN(output_price) FROM productCp);

ROLLBACK;
