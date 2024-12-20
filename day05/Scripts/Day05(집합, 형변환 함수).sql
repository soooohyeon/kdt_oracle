-- 2. 집합, 형변환 함수

-- 집합
-- 결과 6개 행
SELECT * FROM EMP e
WHERE DEPTNO = 30;

-- 결과 3개 행
SELECT * FROM EMP e
WHERE DEPTNO = 10;

-- EMP 테이블에서 DEPTNO가 30 또는 10인 데이터 조회
-- 두 테이블을  UNION(합칩합)으로 연결
SELECT * FROM EMP e
WHERE DEPTNO = 30
UNION
SELECT * FROM EMP
WHERE DEPTNO = 10

-- EMP 테이블에서 SAL 1000 이상 2000이하, 1500 이상 3000 이하의 결과 같이 조회
SELECT * FROM EMP e
WHERE SAL BETWEEN 1000 AND 2000
UNION
SELECT * FROM EMP e2
WHERE SAL BETWEEN 1500 AND 3000;

SELECT * FROM EMP;
SELECT * FROM DEPT;

-- 오류 발생 : 열의 수가 다르다면 UNION 사용 불가
--SELECT * FROM EMP
--UNION
--SELECT * FROM DEPT;

-- 오류 발생 : 열의 타입이 다르면 UNION 사용 불가
--SELECT EMPNO, DEPTNO, JOB
--FROM EMP
--UNION
--SELECT * FROM DEPT;

-- 열의 수와 타입이 일치한다면 UNION 가능
-- 
SELECT SAL, ENAME, JOB FROM EMP
UNION
SELECT * FROM DEPT;
-- 
SELECT DEPTNO 숫자, DNAME 문자, LOC 문자 FROM DEPT
UNION
SELECT SAL, ENAME, JOB FROM EMP;

-- UNION이 두 테이블을 합치고 ORDER BY가 실행되므로
-- 만약 별칭을 사용했다면 ORDER BY 절에 작성한 별칭으로 사용해줘야함
-- = 합쳐지기 이전의 컬럼명이나 소속을 이용해도 정령 X
SELECT EMPNO 번호, ENAME 이름, JOB 직장
FROM EMP E
UNION
SELECT * FROM DEPT D
--ORDER BY E.ENAME;
ORDER BY 이름;


-- 교집합
SELECT * FROM PLAYER p;

SELECT PLAYER_NAME 이름, TEAM_ID 팀, HEIGHT 키, WEIGHT 몸무게
FROM PLAYER
WHERE HEIGHT BETWEEN 177 AND 185
INTERSECT 
SELECT PLAYER_NAME 이름, TEAM_ID 팀, HEIGHT 키, WEIGHT 몸무게
FROM PLAYER p2
WHERE WEIGHT BETWEEN 76 AND 78;


-- 차집합

SELECT PLAYER_NAME 이름, TEAM_ID 팀, HEIGHT 키, WEIGHT 몸무게
FROM PLAYER
WHERE HEIGHT BETWEEN 185 AND 186
MINUS 
SELECT PLAYER_NAME 이름, TEAM_ID 팀, HEIGHT 키, WEIGHT 몸무게
FROM PLAYER p2
WHERE WEIGHT BETWEEN 76 AND 78;



-- 형 변환 함수
-- TO_CHAR()
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"년 "MM"월 "DD"일"') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD-HH24:MI') FROM DUAL;

-- TO_NUMBER()
SELECT '1234', TO_NUMBER('1234') FROM DUAL;

-- 타입은 문자이나 값은 숫자로 자동 형변환
SELECT '123' + '123' FROM DUAL;

-- TO_DATE()
SELECT '2300-12-25', TO_DATE('2300-12-25','YYYY-MM-DD') FROM DUAL



