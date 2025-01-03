-- 계정명 : test01
-- 비밀번호 : 1234
-- 권한 create session, create table, create view, resource;

-- 계정 만들고 a1~a4 테이블 등록 후 문제 풀기

/* 1. JOBS 테이블에서 JOB_ID로 직원들의 JOB_TITLE, EMAIL, 성, 이름 조회 */
SELECT job_title 직업, email 이메일, first_name || ' ' || last_name 이름
FROM jobs j JOIN employees e
ON j.job_id = e.job_id;

/* 2. EMPLOYEES 테이블에서 HIREDATE가 2003~2004년까지인 사원의 정보와 부서명 검색 */
SELECT e.*, d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id 
	AND TO_CHAR(e.hire_date, 'YYYY') BETWEEN '2003' AND '2004';

SELECT e.*, d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id 
	AND hire_date BETWEEN TO_DATE('2003-01-01', 'yyyy-mm-dd') AND TO_DATE('2004-12-31', 'yyyy-mm-dd');

/* 3. EMP 테이블에서 ENAME에 L이 있는 사원들의 DNAME과 LOC 검색 */
SELECT e.ename, d.dname, d.loc
FROM dept d JOIN (SELECT * FROM emp WHERE ename LIKE '%L%') e
ON e.deptno = d.deptno;

/* 4. SCHEDULE 테이블에서 경기 일정이 20120501 ~ 20120502 사이에 있는 경기장 전체 정보 조회 */
SELECT st.*
FROM stadium st
WHERE stadium_id IN (
	SELECT stadium_id
	FROM schedule
	WHERE sche_date IN ('20120501', '20120502'));

SELECT S.SCHE_DATE, S.STADIUM_ID, ST.HOMETEAM_ID, ST.SEAT_COUNT, ST.ADDRESS, ST.DDD, ST.TEL
FROM STADIUM ST JOIN SCHEDULE S 
ON S.STADIUM_ID = ST.STADIUM_ID AND S.SCHE_DATE >= '20120501' AND S.SCHE_DATE <= '20120502';
--ON S.SALARY = (D.DEPARTMENT_ID > 10); ON절에서 테이블간 적절한 관계를 만들지 못하는 경우는 사용 불가능

/* 5. 축구 선수들 중에서 각 팀 별로 키가 가장 큰 선수들의 전체 정보 조회 */
/* 위 문제를 JOIN없이 풀기
 * (A,B) IN (C, D) : A = C AND B = D */
SELECT *
FROM player
WHERE (team_id, height) IN (
	SELECT team_id, MAX(height) FROM player
	GROUP BY team_id);

/* 6. EMP 테이블의 SAL을 이용, SALGRAED 테이블을 참고하여 모든 사원의 정보를 GRADE를 포함하여 조회 */
SELECT e.*, s.grade
FROM emp e
	JOIN (SELECT * FROM salgrade) s
	ON e.sal BETWEEN s.losal AND s.hisal;

/* 7. EMP 테이블에서 각 사원의 매니저 이름 조회 */
SELECT e.ename "사원명", NVL(e2.ename, '최고 직급') "담당 매니저명"
FROM emp e LEFT OUTER JOIN emp e2
ON e.mgr = e2.empno;

/* 8. 축구 선수들 중에서 각 팀 별로 키가 가장 큰 선수들의 전체 정보 조회 */
SELECT p.*
FROM player p JOIN (
	SELECT team_id, MAX(height) 최대키
	FROM player
	GROUP BY team_id) p2
	ON p.team_id = p2.team_id AND HEIGHT = p2.최대키;

