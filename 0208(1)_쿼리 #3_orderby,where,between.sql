SELECT empno, ename, sal, job
FROM emp
ORDER BY sal DESC
LIMIT 3; # my sql 만 가진 명령어

SELECT empno, ename, sal, job
FROM emp
ORDER BY sal DESC
LIMIT 3 OFFSET 6;

-- 미리 출력
SELECT * 
FROM emp;


-- 사원테이블에서 입사일이 81.02.20 ~ 81.05.01 사이에 입사한 사원의 이름, 업무, 입사일을 출력하되 입사일 순으로 출력
SELECT ENAME, JOB, HIREDATE
FROM emp
WHERE HIREDATE BETWEEN '1981-02-20' AND '1981-05-01'
ORDER BY HIREDATE;

-- 사원 테이블에서 보너스가 급여보다 10% 많은 사원의 이름, 급여, 보너르를 출력
SELECT ENAME, SAL, COMM
FROM emp
WHERE COMM >= SAL * 1.1;

-- 사원테이블에서 이름에 L이 두자가 있고 부서가 30이거나 관리자(MGR)가 7782번인 사원의 정보를 출력
SELECT *
FROM emp
WHERE ENAME LIKE "%LL%" AND DEPTNO = 30 OR MGR = 7782;