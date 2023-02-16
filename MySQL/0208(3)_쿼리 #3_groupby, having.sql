-- all print
SELECT * FROM member;
SELECT * FROM products;
SELECT * FROM emp;

-- 고객(member) 테이블에서 직업(job) 별 최대 마일리지(Mileage) 정보를 출력하세요
select job, max(mileage)
FROM member
GROUP BY job;

-- 상품(product) 테이블에서 카테고리(category_fk)로 총 몇개의 상품이 있는지 보여주세요
-- 또한 최대 판매가(output_price)와 최소 판매가를 함께 보여주세요
SELECT category_fk, COUNT(*), MAX(output_price) maxPrice, MIN(output_price) minPrice
FROM products
GROUP BY category_fk;

-- 부서별로 인원수가 4명 이상인 부서정보
SELECT deptno, COUNT(empno) 
FROM emp
GROUP BY deptno 
HAVING COUNT(empno) >= 4;

-- 고객 테이블에서 직업의 종류와 각 직업에 속한 사람의 수가  3명 이상인 직업군
--       의 정보를 보여주시오.
SELECT job, COUNT(*)
FROM member
GROUP BY job
HAVING COUNT(*) >= 3;

-- 고객 테이블에서 직업의 종류와 각 직업에 속한 최대 마일리지 정보를 보여주세요.
--       단, 직업군의 최대 마일리지가 0인 경우는 제외시킵시다.
SELECT job, MAX(mileage)
FROM member
GROUP BY job
HAVING not MAX(mileage) = 0;

--  상품 테이블에서 각 카테고리별로 상품을 묶은 경우, 해당 카테고리의 상품이 2개인 
--  상품군의 정보를 보여주세요.
SELECT *
FROM products
GROUP BY category_fk
HAVING COUNT(*) = 2;      

--  상품 테이블에서 각 공급업체 코드별로 상품 판매가의 평균값 중 단위가 100단위로 떨어
--       지는 항목의 정보를 보여주세요.
--       ** 나머지값 구하는 연산자: %, mod(값1, 값2)함수
SELECT *, AVG(output_price)
FROM products
GROUP BY EP_CODE_FK
HAVING AVG(output_price) % 100 = 0;