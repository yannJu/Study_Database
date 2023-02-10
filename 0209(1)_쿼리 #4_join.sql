-- Join 
SELECT * FROM emp;
SELECT * FROM dept;

SELECT emp.ENAME, emp.DEPTNO
FROM dept, emp
WHERE dept.DEPTNO = emp.DEPTNO;

-- 명시적 조인절 사용 (표준 sql)
SELECT d.deptno, dname, ename, job, loc
FROM dept d JOIN emp e
ON d.deptno = e.deptno ORDER BY 1 DESC;

-- JOIN조건에  AND 를 이용해서 추가적인 조건을 준다.
-- WHERE 절을 이용해서 추가적인 조건을 줄 수도 있다.

-- SALESMAN의 사원번호,이름,급여,부서명,근무지를 출력하여라.
SELECT * FROM dept;
SELECT * FROM emp;

SELECT empno, ename, ROUND(sal) AS sal, dname, loc
FROM dept d JOIN emp e
on d.deptno = e.deptno AND e.job = 'salesman';

-- 상품 정보를 보여주되 해당 상품의 카테고리명을 함께 보여주세요
SELECT * FROM products;
SELECT * FROM category;

SELECT p.*, c.CATEGORY_NAME
FROM products p JOIN category c
ON p.CATEGORY_FK = c.CATEGORY_CODE;

-- 카테고리 테이블과 상품 테이블을 조인하여 화면에 출력하되 상품의 정보 중
-- 	      제조업체가 삼성인 상품의 정보만 추출하여 카테고리 이름과 상품이름, 상품가격
-- 	      제조사 등의 정보를 화면에 보여주세요.
SELECT * FROM category;
SELECT * FROM products;

SELECT *
FROM category c JOIN products p
ON c.CATEGORY_CODE = p.CATEGORY_FK
WHERE p.COMPANY = '삼성';


-- cross join (catresian product) : 모든 행들을 결합
SELECT dept.*, emp.*
FROM dept, emp ORDER BY 1;

-- non equ join -> 구간정보를 사용
-- 각 사원의 사번, 이름, 급여, 급여등급 정보를 보여주세요
SELECT * FROM salgrade;
SELECT * FROM emp;

SELECT empno, ename, ROUND(sal) AS sal, grade, losal, hisal
FROM emp e JOIN salgrade s
ON e.sal BETWEEN s.LOSAL AND s.HISAL
ORDER BY grade DESC;

-- outer join : equi join 으로 join 할 경우 한쪽 테이블에 일치하는 행이 없으면 출력이 안된다.
-- outer join 은 일치하지 않으면 다른 테이블을 null로 채워 출력된다.
SELECT d.DEPTNO, dname, ename, e.DEPTNO
FROM dept d JOIN emp e
ON d.DEPTNO = e.DEPTNO
ORDER BY 1;

-- 왼쪽 테이블 기준으로 출력
SELECT d.DEPTNO, dname, ename, e.DEPTNO
FROM dept d LEFT OUTER JOIN emp e
ON d.DEPTNO = e.DEPTNO
ORDER BY 1;

-- 오른쪽 테이블 기준으로 출력
SELECT d.DEPTNO, dname, ename, e.DEPTNO
FROM dept d RIGHT OUTER JOIN emp e
ON d.DEPTNO = e.DEPTNO
ORDER BY 1;

-- 양쪽 테이블 기준으로 출력 --> oracle 에서만 full outer join 
-- mysql에서는 UNION 이용
-- select *
-- from A left join B
-- union
-- select *
-- from A right join B;
/*
SELECT distinct(d.DEPTNO), dname, ename, e.DEPTNO
FROM dept d FULL OUTER JOIN emp e
ON d.DEPTNO = e.DEPTNO
ORDER BY 1;
*/

SELECT DISTINCT(e.deptno) FROM emp e
LEFT OUTER JOIN dept d ON e.deptno = d.deptno
UNION
SELECT DISTINCT(e.deptno) FROM emp e
RIGHT OUTER JOIN dept d ON e.deptno = d.deptno;

-- self join : 자기 테이블과 join 하는 경우
-- 사원정보를 보여주되 사번, 사원이름, 사원의 관리자이름을 함꼐 보여주세요
SELECT empno, ename, mgr FROM emp;

SELECT e.EMPNO, e.ENAME, e.mgr, m.empno, m.ename
FROM emp e JOIN emp m
ON e.mgr = m.empno;

--  상품테이블의 모든 상품을 공급업체, 공급업체코드, 상품이름, 
--  		  상품공급가, 상품 판매가 순서로 출력하되 공급업체가 없는
--  		  상품도 출력하세요(상품을 기준으로).
SELECT * FROM supply_comp;
SELECT * FROM products;

SELECT s.EP_NAME, s.EP_CODE, p.PRODUCTS_NAME, p.INPUT_PRICE, p.OUTPUT_PRICE 
FROM products p left outer JOIN supply_comp s
ON p.EP_CODE_FK = s.EP_CODE
ORDER BY 1;

-- 상품테이블의 모든 상품을 공급업체, 카테고리명, 상품명, 상품판매가
-- 	순서로 출력하세요. 단, 공급업체나 상품 카테고리가 없는 상품도
-- 	출력합니다.
SELECT * FROM category;

SELECT s.EP_NAME, c.CATEGORY_NAME, p.PRODUCTS_NAME, p.OUTPUT_PRICE
FROM category c right outer JOIN products p
ON c.category_code = p.CATEGORY_FK
left outer JOIN supply_comp s
ON p.EP_CODE_FK = s.EP_CODE
ORDER BY 1;

-- emp테이블에서 "누구의 관리자는 누구이다"는 내용을 출력하세요.
-- "SMITH의 관리자는 FORD입니다"
SELECT CONCAT(e.ENAME, '의 관리자는', p.ENAME, '입니다.')
FROM emp e JOIN emp p
ON e.MGR = p.EMPNO;

-- [종합문제]
-- 1. emp테이블에서 모든 사원에 대한 이름,부서번호,부서명을 출력하는 
--    문장을 작성하세요.
SELECT * FROM emp;
SELECT * FROM dept;

SELECT e.ENAME, d.DEPTNO, d.DNAME
FROM emp e JOIN dept d
ON e.DEPTNO = d.DEPTNO;

-- 2. emp테이블에서 NEW YORK에서 근무하고 있는 사원에 대하여 이름,업무,급여,
--     부서명을 출력하는 SELECT문을 작성하세요.
SELECT e.ENAME, e.JOB, e.SAL, d.DNAME
FROM emp e JOIN dept d
ON e.deptno = d.DEPTNO
WHERE d.LOC = 'NEW YORK';

-- 3. EMP테이블에서 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력하는
--     SELECT문을 작성하세요.
SELECT e.ENAME, d.DNAME, d.LOC
FROM emp e JOIN dept d
ON e.deptno = d.DEPTNO
WHERE e.COMM IS NOT NULL AND e.COMM > 0;

-- 4. EMP테이블에서 이름 중 L자가 있는 사원에 대해 이름,업무,부서명,위치를 
--    출력하는 문장을 작성하세요.
SELECT e.ENAME, e.JOB, d.DNAME, d.LOC
FROM emp e JOIN dept d
ON e.deptno = d.DEPTNO
WHERE e.ENAME LIKE "%L%";

/*5. 아래의 결과를 출력하는 문장을 작성하에요(관리자가 없는 King을 포함하여
	모든 사원을 출력)
	---------------------------------------------
	Emplyee		Emp#		Manager	Mgr#
	---------------------------------------------
	KING		7839
	BLAKE		7698		KING		7839
	CKARK		7782		KING		7839
	.....
	---------------------------------------------
*/
SELECT * FROM emp;

SELECT e.ENAME as Emplyee, e.EMPNO AS "Emp#", m.ENAME AS Manager, m.EMPNO AS "Mgr#"  
FROM emp e left outer JOIN emp m
ON e.mgr = m.EMPNO;
