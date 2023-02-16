-- 다중행 서브쿼리 : In, exists
-- 업무별로 최대 급여를 받는 사원의 사번, 이름, 업무, 급여를 출력하세요.
SELECT empno, ename, job, sal
FROM emp
WHERE (job, sal) IN (
SELECT job, MAX(sal)
FROM emp
GROUP BY job)
ORDER BY 3;

-- exists 연산자
-- 사원을 관리하는 사원의 정보를 보여주세요
SELECT *
FROM emp m
WHERE EXISTS (
SELECT empno
FROM emp e
WHERE e.mgr = m.empno); -- employ의 관리자 번호와 관리자의 사번이 같은 경우들을 select

-- 다중열 subquery : 2개 이상의 컬럼을 반환하는 서브쿼리
-- 부서별로 최소급여를 받는 사원의 사번,이름,부서번호,업무,급여
-- 를 출력하세요
SELECT e.EMPNO, e.ENAME, d.DEPTNO, d.dname, e.JOB, e.sal
FROM emp e JOIN dept d
ON e.DEPTNO = d.DEPTNO
WHERE (d.deptno, e.sal) IN (
SELECT deptno, MIN(sal)
FROM emp
GROUP BY deptno);

/* 고객 테이블에 있는 고객 정보 중 마일리지가 
	가장 높은 금액의 고객 정보를 보여주세요.
*/	
SELECT * FROM member;

SELECT *
FROM member
WHERE mileage = (
SELECT max(mileage)
FROM member);

/* 상품 테이블에 있는 전체 상품 정보 중 상품의 판매가격이 
    판매가격의 평균보다 큰  상품의 목록을 보여주세요. 
    단, 평균을 구할 때와 결과를 보여줄 때의 판매 가격이
    50만원을 넘어가는 상품은 제외시키세요.
  */  
SELECT * FROM products;

SELECT *
FROM products
WHERE output_price > (
SELECT AVG(output_price)
FROM products
WHERE output_price <= 500000) AND output_price <= 500000;
	
/* 상품 테이블에 있는 판매가격에서 평균가격 이상의 상품 목록을 구하되 평균을
    구할 때 판매가격이 최대인 상품을 제외하고 평균을 구하세요.*/    
SELECT *
FROM products
WHERE output_price > (
SELECT AVG(output_price)
FROM products
WHERE output_price < (
SELECT max(output_price)
FROM products));

/* 상품 카테고리 테이블에서 카테고리 이름에 컴퓨터라는 단어가 포함된 카테고리에
	속하는 상품 목록을 보여주세요.*/
SELECT * FROM category;
SELECT * FROM products;

-- sub query
SELECT *
FROM products 
WHERE category_fk in (
SELECT category_code
FROM category
WHERE category_name LIKE "%컴퓨터%");

-- join -> data가 많은 경우 join 문이 성능에 문제가 있을 수 있음
SELECT c.*, p.products_name FROM category c JOIN products p
ON c. category_code = p.category_fk
AND category_name LIKE "%컴퓨터%";

/*고객 테이블에 있는 고객정보 중 직업의 종류별로 가장 나이가 많은 사람의 정보를
	화면에 보여주세요.*/
SELECT * from member;

SELECT *
FROM member
WHERE (job, age) in (
SELECT job, MAX(age)
FROM member
GROUP BY job);

-- EMP와 DEPT 테이블에서 업무가 MANAGER인 사원의 이름, 업무,부서명,
--	근무지를 출력하세요.
SELECT e.ename, e.job, d.DNAME, d.loc
FROM emp e JOIN dept d
ON e.DEPTNO = d.DEPTNO
WHERE e.JOB = 'MANAGER';

-- sub query (미리 sub query로 조건 테이블을 만든 후 join 했으므로 성능이 위의 쿼리보다 좋다)
SELECT e.ename, e.job, d.dname, d.loc
FROM (SELECT * FROM emp WHERE job = 'MANAGER') e JOIN dept d -- inline view라고 함
ON e.deptno = d.DEPTNO;

-- inline view = view와 같은 역할을 하므로 inline view라고 함
-- view ~> table 과 유사하나 물리적으로 존재하지는 않음

/*
 	1] 고객 테이블에 있는 고객 정보 중 마일리지가 가장 높은 금액을
	     가지는 고객에게 보너스 마일리지 5000점을 더 주는 SQL을 작성하세요.
	     
	MYSQL의 경우 UPDATE나 DELETE시  자기 테이블의 데이터를 바로 사용하지 못한다.
	그래서 서브쿼리의 결과를 별칭을 주어 임시테이블로 저장한 뒤 적용해보자.
	*/
UPDATE member SET mileage = mileage + 5000
WHERE mileage = (SELECT MAX(mileage) FROM member);

SELECT * FROM member;

ROLLBACK; 

-- mysql workbench 에서는 별칭을 꼭 주어야함 !
-- UPDATE MEMBER SET MILEAGE = MILEAGE +5000
--	WHERE MILEAGE = (SELECT a.* FROM (SELECT MAX(MILEAGE) FROM MEMBER ) a); 'a'라는 별칭을 둠
--	SELECT * FROM MEMBER;

/* 고객 테이블에서 마일리지가 없는 고객의 등록일자를 고객 테이블의 
	      등록일자 중 가장 뒤에 등록한 날짜에 속하는 값으로 수정하세요.*/
UPDATE member SET reg_date = (SELECT MAX(reg_date) FROM member)
WHERE mileage = 0;

ROLLBACK;

-- Delete 에서도 subquery 사용 가능
/* 상품 테이블에 있는 상품 정보 중 공급가가 가장 큰 상품은 삭제 시키는 
	      SQL문을 작성하세요.*/
DELETE FROM products
WHERE input_price = (SELECT MAX(input_price) FROM products);
	      
SELECT * FROM products;
	      
ROLLBACK;

/*  상품 테이블에서 상품 목록을 공급 업체별로 정리한 뒤,
	     각 공급업체별로 최소 판매 가격을 가진 상품을 삭제하세요.*/
DELETE FROM products
WHERE (ep_code_fk, output_price) in (
SELECT ep_code_fk, MIN(output_price)
FROM products
GROUP BY ep_code_fk);

ROLLBACK;