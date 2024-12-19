/* PLAYER 테이블에서 WEIGHT가 70이상이고 80이하인 선수 검색 */
SELECT player_name 이름, weight 몸무게
FROM player
WHERE weight >= 70 AND weight <= 80;

/* PLAYER 테이블에서 TEAM_ID가 'K03'이고 HEIGHT가 180 미만인 선수 검색 */
SELECT player_name 이름, height 키
FROM player
WHERE team_id = 'K03' AND height < 180;

/* PLAYER 테이블에서 TEAM_ID가 'K06'이고 NICKNAME이 '제리'인 선수 검색 */
SELECT *
FROM player
WHERE team_id = 'K06' AND nickname = '제리';

/* PLAYER 테이블에서 HEIGHT가 170이상이고 WEIGHT가 80이상인 선수 이름 검색 */
SELECT player_name 이름
FROM player
WHERE height >= 170 AND weight >= 80;

/* STADIUM 테이블에서 SEAT_COUNT가 30000초과이고 41000이하인 경기장 검색 */
SELECT *
FROM stadium
WHERE seat_count BETWEEN 30001 AND 41000;

/* PLAYER 테이블에서 TEAM_ID가 'K02'이거나 'K07'이고 포지션은 'MF'인 선수 검색 */
SELECT *
FROM player
WHERE team_id IN ('K02', 'K07') AND POSITION = 'MF';

/* PLAYER 테이블에서 POSITION이 NULL인 선수 검색 */
SELECT *
FROM player p
WHERE POSITION IS NULL;

/* PLAYER 테이블에서 NICKNAME이 NULL인 선수를 '없음'으로 변경하여 조회하기 */
SELECT player_name 이름, NVL(nickname, '없음')
FROM player;

/* PLAYER 테이블에서 NATION이 등록되어 있으면 '등록', 아니면 '미등록'으로 검색 */
SELECT player_name 이름, NVL2(nation, '등록', '미등록') 국가
FROM player;

/* PLAYER 테이블에서 POSITION이 NULL인 선수를 '미정'으로 변경 후 검색 */
SELECT player_name 이름, NVL(POSITION, '미정') 포지션
FROM player;

/* PLAYER 테이블에서 포지션 종류 검색 */
SELECT DISTINCT POSITION
FROM player;

/* PLAYER 테이블에서 몸무게가 80이상인 선수들의 평균 키가 180초과인 포지션 검색 */
SELECT POSITION 포지션, AVG(height)
FROM player
WHERE weight >= 80
GROUP BY POSITION
HAVING AVG(height) > 180;

/* EMPLOYEES 테이블에서 JOB_ID별 평균 SALARY가 10000미만인 JOB_ID 검색 JOB_ID는 알파벳 순으로 정렬(오름차순) */
SELECT DISTINCT job_id 직업번호
FROM employees
WHERE job_id IN (SELECT job_id
				FROM employees
				GROUP BY job_id
				HAVING AVG(salary) < 10000)
ORDER BY 직업번호;

/* PLAYER_ID가 2007로 시작하는 선수들 중 POSITION별 평균 키를 조회 */
SELECT POSITION, AVG(HEIGHT)
FROM PLAYER
WHERE PLAYER_ID LIKE '2007%'
GROUP BY POSITION;

/* 선수들 중 포지션이 DF 선수들의 평균 키를 TEAM_ID 별로 조회하고 평균 키 오름차순으로 정렬하기 */
SELECT TEAM_ID, AVG(HEIGHT)
FROM player
WHERE POSITION = 'DF'
GROUP BY team_id
ORDER BY AVG(height);

/* 포지션이 MF인 선수들의 입단연도 별 평균 몸무게, 평균 키를 구한다.
 * 칼럼명은 입단연도, 평균 몸무게, 평균 키 로 표시한다.
 * 입단연도를 오름차순으로 정렬한다.
 * 단, 평균 몸무게는 70 이상 그리고 평균 키는 160 이상인 입단연도만 조회 */
SELECT join_yyyy 입단연도, AVG(weight)"평균 몸무게", AVG(height) "평균 키"
FROM player
GROUP BY join_yyyy
HAVING AVG(weight) >=70 AND AVG(height)>= 160
ORDER BY join_yyyy;

/* PLAYER 테이블에서 TEAM_ID가 'K01'인 선수 중 POSITION이 'GK'인 선수를 조회하기 SUB쿼리 사용하기 */
SELECT *
FROM PLAYER p
	JOIN (
		SELECT PLAYER_ID
		FROM PLAYER
		WHERE TEAM_ID = 'K01'
	) t
	ON t.PLAYER_ID = p.PLAYER_ID
WHERE POSITION = 'GK';

/* PLAYER 테이블에서 평균 몸무게보다 더 많이 나가는 선수들 검색 (조건에 서브쿼리 사용) */
SELECT *
FROM PLAYER
WHERE WEIGHT > (SELECT AVG(WEIGHT) FROM PLAYER);

/* PLAYER 테이블에서 정남일 선수가 소속된 팀의 선수들 조회*/
SELECT *
FROM PLAYER
WHERE TEAM_ID = (SELECT TEAM_ID FROM PLAYER WHERE PLAYER_NAME= '정남일');

/* PLAYER 테이블에서 평균 키보다 작은 선수 조회*/
SELECT *
FROM PLAYER
WHERE HEIGHT < (SELECT AVG(HEIGHT) FROM PLAYER);

/*SCHEDULE 테이블에서 경기 일정이 
 * 20120501 ~ 20120502 사이에 있는 경기장 전체 정보 조회*/
SELECT *
FROM STADIUM s
	JOIN (
		SELECT STADIUM_ID
		FROM SCHEDULE
		WHERE SCHE_DATE BETWEEN TO_DATE('2012-05-01', 'YYYY-MM-DD')
						AND TO_DATE('2012-05-02', 'YYYY-MM-DD')
	) d
	ON s.STADIUM_ID = d.STADIUM_ID
	
SELECT *
FROM STADIUM
WHERE STADIUM_ID IN (SELECT STADIUM_ID
					FROM SCHEDULE
					WHERE SCHE_DATE BETWEEN TO_DATE('2012-05-01', 'YYYY-MM-DD')
					AND TO_DATE('2012-05-02', 'YYYY-MM-DD'));
/*
 * EMPLOYEE 테이블
 * 핸드폰번호가 515로 시작하는 사원들의
 * JOB_ID별 SALARY 평균을 구한다.
 * 조회 컬럼은 부서, 평균 급여 로 표시한다.
 * 평균 급여가 높은 순으로 정렬한다.
 */
SELECT JOB_ID 부서, AVG(SALARY) "평균 급여"
FROM EMPLOYEES
WHERE PHONE_NUMBER LIKE '515%'
GROUP BY JOB_ID
ORDER BY AVG(SALARY) DESC;
					
/* COMMISSION_PCT 별 평균 급여를 조회한다.
 * COMMISSION_PCT 를 오름차순으로 정렬하며 
 * HAVING절을 사용하여 NULL은 제외한다.*/
SELECT COMMISSION_PCT, AVG(SALARY)
FROM EMPLOYEES
GROUP BY COMMISSION_PCT
HAVING COMMISSION_PCT IS NOT NULL
ORDER BY COMMISSION_PCT;


