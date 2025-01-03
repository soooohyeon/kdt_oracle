--2번 : 연산자

-- 연산자, 피연산자 자리에 어떤 타입의 값이 오는지
-- 연산자가 어떻게 동작하는지
-- 연산의 결과가 어떤 타입의 값인지 아는 것 중요!!!!

-- 자료형 : 문자형(CHAR, VARCHAR2), 숫자형(NUMBER), 날짜형(DATE, TIMESTAMP)

-- 1) 연결연산자 ||
-- a || b : a와 b를 연결해줌
-- 연결연산자를 사용하면 무조건 문자열

--SELECT 컬럼명 FROM 테이블명;		-- 출력시 꼭 필요한데
-- SELECT DISTINCT 10 || 20
-- FROM employees;		-- 조회 컬럼이 여러개라면 비효율적

-- dual 테이블 : 다른 테이블 참조없이 값을 확인하고 싶을 때 사용 가능한 테이블(오라클 지원)
SELECT 10, 20, 10 || 20
FROM dual;

SELECT 'a', 'b', 'a' || 'b'
FROM dual;

-- employees 테이블에서 이름과 성을 붙여서 이름이라는 별칭으로 조회
--SELECT first_name, last_name, first_name || last_name 이름	-- 띄어쓰기 없이 연결됨
SELECT first_name, last_name, first_name || ' ' || last_name 이름		-- 띄어쓰기 추가
FROM employees;

-- 날짜 타입의 값 확인
SELECT hire_date || '안녕'
FROM employees;		-- hire_date가 employees 테이블의 컬럼이므로 employees 사용

-- [실습] 사원의 이름과 메일주소를 출력하기
-- 이 때 이름은 first_name과 last_name이 띄어쓰기로 이어져서 이름이라는 컬럼명으로 있고
-- 메일 주소는 사원메일주소@koreait.com으로 메일 주소라는 컬럼명으로 되어있다
SELECT first_name || ' ' || last_name 이름,
	email || '@koreait.com' "메일 주소"
FROM employees;

-- 2) 산술연산자
-- 숫자 타입 산술연산 결과 => 숫자 타입
SELECT employee_id, employee_id + 10, employee_id - 10, employee_id * 10, employee_id / 10
FROM employees;

-- 날짜 타입과 산술연산
-- 날짜와 숫자 => 날짜 타입
SELECT hire_date, hire_date + 10, hire_date - 10
FROM employees;

-- 날짜와 날짜 => 숫자 타입 (D-DAY와 비슷)
SELECT sysdate
FROM dual;

-- 날짜 - 날짜 = 며칠이 지났는지 숫자타입으로 나옴
SELECT hire_date, sysdate, sysdate - hire_date
FROM employees;

-- 오류 발생 : 오늘 + 내일 = ? 
--SELECT hire_date, sysdate, sysdate + hire_date
--FROM employees;

-- 날짜와 숫자의 연산에서 기본적으로 숫자는 일 수를 의미하기 때문에 시간, 분 단위로 연산하고 싶다면
-- 일(24h)로 환산해야함
SELECT sysdate,
	sysdate - 0.5
-- sysdate - (12/24) 	-- 12시간
-- sysdate - (1/24) 	-- 1시간
-- sysdate - (30/60/24)	-- 30분
FROM dual;


-- 3) 관계연산자

-- 직원의 이름, 성, 급여 조회
SELECT first_name 이름, last_name 성, salary 급여
FROM employees
WHERE salary >= 10000	-- 별칭 불가, 실행순서가 별칭설정해준 SELECT 절보다 먼저기 때문
ORDER BY salary 급여;

-- 직원의 이름, 성을 조회한다
-- 단, 이름이 Peter인 직원만 골라서 조회한다
-- 값은 대소문자 비교함, 컬럼명이나 테이블명은 대소문자 상관없음
SELECT first_name 이름, LAST_name 성
FROM employees
WHERE first_name = 'Peter';
-- Peter는 문자타입이므로 반드시 ''로 감싸줘야하며 P를 소문자로 작성하면 안됨
-- 데이터의 대소문자는 정확하게 구분

-- 5) 논리연산자
-- AND, OR, NOT
-- 피연산자 자리에 조건이 옴, 여러개의 조건을 연결할 때 사용
-- employees 테이블에서 부서가 영업부서(80)이면서 급여가 10000이상인 직원들의
-- 이름, 성, 급여, 부서id를 급여 오름차순으로 조회하기
SELECT first_name 이름, last_name 성, salary 급여, department_id 부서ID
FROM employees
WHERE department_id = 80 AND salary >= 10000
ORDER BY 급여;

--UNKNOWN
SELECT 100, NULL
FROM dual
WHERE NULL = NULL;

--- 직원의 이름, 봉급, 인상 봉급, 감축 봉급을 조회하기
-- 이름은 성과 함께 띄어쓰기로 연결되어있다
-- 인상 봉급은 기존 봉급의 10% 증가되었고(1.1)
-- 감축 봉급은 기존 봉급의 10% 감소되었다(0.9)
-- 결과를 기존 봉급 오름차순으로 정렬하여 조회한다
SELECT first_name || ' ' || last_name 이름, salary 봉급,
	salary * 1.1 "인상 봉급", salary * 0.9 "감축 봉급"
FROM employees
ORDER BY 봉급;

-- 6) SQL 연산자
-- BETWEEN a AND b : a 이상 b 이하라면 true

-- employees 테이블에서 salary가 10000이상 12000이하인
-- 직원의 first_name, last_name, salary를 salary 오름차순으로 조회
SELECT first_name, last_name, salary
FROM employees
WHERE salary BETWEEN 10000 AND 12000
ORDER BY salary;

-- IN(a, b, c) : a이거나 b이거나 c일 때 true ⇒ a, b, c 중 하나라도 true면 true
SELECT first_name, last_name, salary
FROM employees
WHERE salary IN (10000, 11000, 12000)
ORDER BY salary;

-- LIKE : 문자 조건, 패턴 만들 때 사용
-- % : ~ 아무거나, _ : 자리수
SELECT first_name
FROM employees
WHERE first_name LIKE '____e';

SELECT first_name
FROM employees
WHERE first_name LIKE '%e%';		-- e를 포함한 문자열 검색

-- %e% 	: e를 포함하는 문자를 의미함
-- %en% : en을 포함하는 문자를 의미함
-- %e%n% : e와 n을 포함하는 문자를 의미함
-- %e_n% : e와 n사이에 한글자 더 있는 문자를 의미함

-- IS NULL / IS NOT NULL
-- NULL : 데이터가 없음을 나타냄
-- 0도 하나의 값, NULL의 값 자체가 없음
-- NULL은 연산하면 결과가 NULL
SELECT NULL + 10
FROM dual;

-- employees 테이블에서 commission_pct를 조회
SELECT first_name, last_name, commission_pct
FROM employees
--WHERE commission_pct = NULL;	-- 아무런 결과가 나오지 않음, NULL 값을 확인할 때는 IS NULL로 확인할 것
WHERE commission_pct IS NULL;

SELECT first_name, last_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;



SELECT * FROM employees;


