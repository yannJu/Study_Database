-- day03_function.sql

-- 단일행 함수 : 숫자형 함수
-- 절대값 : SELECT ABS(1), ABS(-1);
-- 반올림 : SELECT ROUND(3.1415921); -> round(값, n) 이면 n째 자리에서 반올림 (default는 첫번째자리)
SELECT ROUND(3.1415921);
SELECT ROUND(3.1415921, 3);

SELECT ROUND(4567.567);
SELECT ROUND(4567.567, 2);
SELECT ROUND(4567.567, -2);

-- 올림 : ceil()
-- 내림 : floor()
-- 랜덤 : rand()
SELECT RAND();

-- row_number() over (분석절) : 분석절에 대한 각 행의 번호를 반환
-- rank() over(분석절) : 파티션에 대한 순위 값을 매긴다

/*
rnum 을 찾지 못해서 err가 나는 하위 쿼리
SELECT row_nuber() over(ORDER BY sal DESC) rnum, emp.* FROM emp
WHERE rnum >= 5 AND rnum <= 10
*/

SELECT ROW_NUMBER() over (ORDER BY sal DESC), e.* FROM emp e LIMIT 5 OFFSET 5; -- 월급이 많은 사람 5명 (offset 5로 지정해서 6부터 rnum)
SELECT RANK() over(ORDER BY comm DESC) rnk, e.* FROM emp e LIMIT 3; -- 보너스(COMM)를 제일 많이 받는 사람 3명

-- 문자열 함수
-- concat() : 문자열 결합
SELECT CONCAT(ename, job)
FROM emp;

-- #실습
-- 사원의 사원명, 급여정보를 보여주되 '$'기호를 붙여서 보여주세요
/*
SELECT CONCAT('$', ename) AS ENAME, CONCAT('$', job) AS JOB
FROM emp;
*/

SELECT ename AS ENAME, CONCAT('$', job) AS JOB
FROM emp;

-- left(문자열, len) : 문자열의 왼쪽부터 명시한 개수(len) 만큼의 문자를 추출해서 반환
-- Right(문자열, len) : 오른쪽 부터

SELECT LEFT('mysql python html css', 5), RIGHT('mysql python html css', 5);

-- dayname() : 요일정보
-- 오늘을 기준으로 보름뒤 날짜를 구하고자 할때? -> adddate() : 더한 날짜를 반환
-- 오늘을 기준으로 보름전 날짜를 구하고자 할때? -> subdate() : 뺸 날짜를 반환

SELECT ADDDATE('2023-02-08', INTERVAL 15 DAY);
SELECT SUBDATE('2023-02-08', INTERVAL 1 MONTH);

-- emp 테이블에서 모든 salesman에 대해 급여의 평균, 최고액, 최저액, 합계를 구하여 출력
SELECT AVG(salempempemp) avgSal, MAX(sal) maxSal, MIN(sal) minSal, SUM(sal) sumSal
FROM emp
WHERE job = 'salesman';

-- emp테이블에 등록되어 있는 인원수, 보너스에 nuull이 아닌 인원수, 보너스의 평균, 등록되어있는 부서의 수를 구하여 출력하세요