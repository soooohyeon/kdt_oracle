-- 2. DDL

CREATE TABLE TBL_USER (	-- TBL을 같이 작성해서 테이블이라는 것을 명시해줌
	USER_NAME VARCHAR2(100),	-- 앞에 테이블명 같이 작성해서 테이블 구분을 위해 명시해줌
	USER_AGE NUMBER
);

SELECT * FROM TBL_USER;

-- 테이블명 수정
-- ALTER TABLE 테이블명 RENAME 새 테이블명;
ALTER TABLE TBL_USER RENAME TO TBL_MY_USER;

SELECT * FROM TBL_USER;		-- 테이블명 수정해서 해당 테이블 조회안되는 것 확인
SELECT * FROM TBL_MY_USER;

-- 컬럼명 수정
-- ALTER TABLE 테이블명 RENAEM COLUMN 기존컬럼명 TO 새 컬럼명;
ALTER TABLE TBL_MY_USER RENAME COLUMN USER_NAME TO USER_NICKNAME;

SELECT * FROM TBL_MY_USER;

-- 컬럼 타입 수정
-- ALTER TABLE 테이블명 MODIFY (컬럼명 변경할자료형(용량));
ALTER TABLE TBL_MY_USER MODIFY (USER_NICKNAME VARCHAR2(500));

-- 컬럼 추가
--	ALTER TABLE 테이블명 ADD (컬럼명 자료형(용량));
ALTER TABLE TBL_MY_USER ADD (USER_GENDER CHAR(1));
ALTER TABLE TBL_MY_USER ADD (USER_HOBBY VARCHAR2(100));

SELECT * FROM TBL_MY_USER;

-- 컬럼 삭제 - 데이터가 들어가있더라도 삭제됨
ALTER TABLE TBL_MY_USER DROP COLUMN USER_GENDER;

-- 데이터 삽입 INSER(DML)
INSERT INTO TBL_MY_USER
VALUES('짱구', 5, 'M', '액션가면 보기');
INSERT INTO TBL_MY_USER
VALUES('철수', 5, '공부하기');

-- TRUNCATE
TRUNCATE TABLE TBL_MY_USER;

-- DELETE (DML)
DELETE FROM TBL_MY_USER;

-- 테이블 삭제
-- DROP TABLE 테이블명;
DROP TABLE TBL_MY_USER;

DROP TABLE TBL_MEMBER;
DROP TABLE TBL_STUDENT;

-- [실습] 자동차 테이블 생성 TBL_CAR
--자동차 번호		NUMBER		숫자
--자동차 이름		NAME		문자(1000)
--자동차 브랜드		BRAND		문자(1000)
--출시 날짜		RELEASEDATE	날짜
--색상			COLOR		문자(1000)
--가격			PRICE		숫자
CREATE TABLE TBL_CAR (
	CAR_NUMBER NUMBER,
	CAR_NAME VARCHAR2(1000),
	CAR_BRAND VARCHAR2(1000),
	CAR_RELEASDATE DATE,
	CAR_COLOR VARCHAR2(1000),
	CAR_PRICE NUMBER
);

SELECT * FROM TBL_CAR;

-- 제약 조건 추가
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건이름(PK_테이블명) PRIMARY KEY(컬럼명)
ALTER TABLE TBL_CAR ADD CONSTRAINT PK_CAR PRIMARY KEY(CAR_NUMBER);
-- ALTER TABLE TBL_CAR : TBL_CAR 테이블을 수정하겠다.
-- ADD : 추가하다
-- CONSTRAINT : 제약조건
-- PK_CAR PRIMARY KEY(CAR_NUMBER) : PK_CAR 이름으로 PRIMARY KEY라는 (PK) 제약조건을 CAR_NUMBER 컬럼에

-- 제약조건 삭제 (PK_CAR : 제약조건 이름)
ALTER TABLE TBL_CAR DROP CONSTRAINT PK_CAR;

-- 테이블 삭제
DROP TABLE TBL_CAR;

-- 제약조건 포함한 테이블 다시 생성
CREATE TABLE TBL_CAR (
--	CAR_NUMBER NUMBER PRIMARY KEY,	-- 제약조건 명을 작성안하면 추후 수정하거나 삭제시 지정할 수가 없게됨
	CAR_NUMBER NUMBER CONSTRAINT PK_CAR PRIMARY KEY,	-- 제약조건과 제약조건 명 같이 설정
	CAR_NAME VARCHAR2(1000),
	CAR_BRAND VARCHAR2(1000),
	CAR_RELEASDATE DATE,
	CAR_COLOR VARCHAR2(1000),
	CAR_PRICE NUMBER
);

SELECT * FROM TBL_CAR;

-- 동물 테이블 TBL_ANIMAL
-- 고유번호	NUMBER
-- 종류		KIND
-- 나이		AGE
-- 먹이		FEED
--CREATE TABLE TBL_ANIMAL (
--	ANIMAL_NUMBER NUMBER CONSTRAINT PK_ANIMAL PRIMARY KEY,
--	ANIMAL_KIND VARCHAR2(1000),
--	ANIMAL_AGE NUMBER,
--	ANIMAL_FEED VARCHAR2(1000)
--);
--DROP TABLE TBL_ANIMAL;

CREATE TABLE TBL_ANIMAL (
	ANIMAL_NUMBEr NUMBER,
	ANIMAL_KIND VARCHAR2(1000),
	ANIMAL_AGE NUMBER,
	ANIMAL_FEED VARCHAR2(1000)
);

-- 2. 테이블 생성 후 제약조건 추가
ALTER TABLE TBL_ANIMAL
ADD CONSTRAINT PK_ANIMAL PRIMARY KEY(ANIMAL_NUMBER);

-- 3. 컬럼 추가 성별 : GENDER 문자(1)
ALTER TABLE TBL_ANIMAL
ADD (ANIMAL_GENDER CHAR(1));

-- 4. 컬럼 이름 수정 (고유번호) NUMBER → ID
ALTER TABLE TBL_ANIMAL
RENAME COLUMN ANIMAL_NUMBER TO ANIMAL_ID;ㅇ

-- 5. 컬럼 삭제 (먹이)
ALTER TABLE TBL_ANIMAL DROP COLUMN ANIMAL_FEED;

-- 6. 컬럼 수정(종류컬럼을 자료형 NUMBER로 설정)
ALTER TABLE TBL_ANIMAL MODIFY(ANIMAL_KIND NUMBER);

-- RENAME CONSTRAINT은 오라클에서 지원 X
-- PK는 테이블 당 1개씩만 존재
--ALTER TABLE TBL_ANIMAL
--RENAME CONSTRAINT PK_ANIMAL PRIMARY KEY(ANIMAL_ID);

-- ANIAL 테이블에 데이터 추가 INSERT
INSERT INTO TBL_ANIMAL
VALUES (1, 1, 5, 'F');

--INSERT INTO TBL_ANIMAL	
--VALUES (NULL, 1, 2, 'M');	-- ANIMAL_ID는 PK로 NULL 불가능

--INSERT INTO TBL_ANIMAL
--VALUES (1, 2, 3, 'F');	-- ANIMAL_ID가 PK로 중복 불가능

SELECT * FROM TBL_ANIMAL;

DROP TABLE TBL_ANIMAL;
DROP TABLE TBL_CAR;

-- FK 설정
-- 학교 테이블
CREATE TABLE TBL_SCHOOL (
	SCHOOL_NUMBER NUMBER CONSTRAINT PK_SCHOOL PRIMARY KEY,
	SCHOOL_NAME VARCHAR2(1000)
);

-- 학생 테이블 (PK 설정)
-- 테이블이 관계를 맺고 있으면 상위테이블과 하위테이블로 나뉘게 됨
-- 먼저 생성해야하는 테이블 -> 상위테이블, 컬럼을 참조하려면 먼저 테이블이 생성이되어 있어야 해당 컬럼 참조가 가능하기 때문
-- ex) 학교 테이블이 생성이 되어있어야 학생이 어떤 학교를 다니는지 설정(참조)이 가능하기 때문에 학교 테이블이 먼저 생성되어야 함
-- ** FK는 중복이나 NULL 모두 가능하지만 NULL값으로 먼저 데이터를 저장할 경우 추후 수정해야하기 때문에 상위 테이블 데이터 우선 입력을 선호함
-- 참조해서 사용하는 이유, 만약 여러 테이블에 해당 컬럼을 참조하지 않고 전부 추가해둘경우 해당 데이터의 값이 수정되면 모든 테이블의 데이터를 수정해야하기떄문에
-- 유지보수성을 위해 테이블 하나로 따로 생성하고 해당 값을 참조해서 받아서 사용
CREATE TABLE TBL_STUDENT(
	STUDENT_NUMBER NUMBER,
	STUDENT_NAME VARCHAR2(1000),
	STUDENT_AGE NUMBER,
  	SCHOOL_NUMBER NUMBER,	-- 해당 컬럼에 외래키(FK)로 설정
	CONSTRAINT PK_STUDENT PRIMARY KEY(STUDENT_NUMBER),
	CONSTRAINT FK_STUDENT FOREIGN KEY(SCHOOL_NUMBER) REFERENCES TBL_SCHOOL(SCHOOL_NUMBER)
--	SCHOOL_NUMBER 컬럼을 외래키(FK)로 설정				 SCHOOL 테이블의 SCHOOL_NUMBER 컬럼 참조
);

-- 상위 테이블의 값부터 채워줌
INSERT INTO TBL_SCHOOL
--VALUES(1, 'DBMS 고등학교');
--VALUES(2, 'JAVA 고등학교');
VALUES(3, 'PYTHON 고등학교');

-- 하위 테이블의 값을 채워줌
INSERT INTO TBL_STUDENT
--VALUES (1, '김철수', 17, 5); -- 오류발생!, FK인 상위 테이블의 SCHOOL_NUMBER에 존재하지 않는 값을 저장하려했기 때문
--VALUES (1, '김철수', 17, 1);
--VALUES (2, '신유리', 17, 1);
--VALUES (3, '신짱구', 17, 2);
VALUES (4, '맹구', 19, 3);

SELECT * FROM TBL_SCHOOL;
SELECT * FROM TBL_STUDENT;
DROP TABLE TBL_STUDENT;

-- 제약조건 UK(UNIQUE) : 고유한 값이지만 NULL도 허용
-- ** UNIQUE는 KEY를 같이 작성하지 않음 > 오류 발생
-- ** PK, FK, UK를 제외하고는 컬럼 옆에 작성해줌
-- 학생 테이블 STU
CREATE TABLE TBL_STU (
	STU_NUMBER NUMBER,
	STU_NAME VARCHAR2(1000),
	STU_MAJOR VARCHAR2(100),
	STU_ID NUMBER,	-- 학번
	STU_GENDER CHAR(1) DEFAULT 'M' NOT NULL CONSTRAINT CHECK_GEN CHECK(STU_GENDER = 'M' OR STU_GENDER = 'F'),
	CONSTRAINT PK_STU PRIMARY KEY (STU_NUMBER),
	CONSTRAINT UK_STU UNIQUE (STU_ID)
);
-- STU_GENDER CHAR(1) DEFAULT 'M' NOT NULL CHECK(STU_GENDER = 'M' OR STU_GENDER = 'F'),
-- 1) DEFAULT 'M' : 데이터가 들어오지 않으면 무조건 'M'이 기본값으로 들어가게 설정
-- 2) NOT NULL : 디폴트 값을 M으로 설정했으니 혹시라도 NULL 값을 강제로 넣는 것을 막기위해 사용
-- 3) CHECK(STU_GENDER = 'M' OR STU_GENDER = 'F') : 해당 컬럼에 M 또는 F만 입력하도록 설정

--DROP TABLE TBL_STU;

INSERT INTO TBL_STU (STU_NUMBER, STU_NAME, STU_MAJOR, STU_ID)
VALUES(1, '짱구', NULL, '1111');	-- GENDER에 기본값 M 들어간것 확인 됨
INSERT INTO TBL_STU 
--VALUES(2, '철수', '컴공', '2222', 'M');
VALUES(3, '유리', '컴공', 333, 'F');

SELECT * FROM TBL_STU;
-- 조합키
-- PK를 2개의 컬럼으로 조합하여 설정한 것을 의미
CREATE TABLE TBL_FLOWER (
	FLOWER_NAME VARCHAR2(1000),
	FLOWER_COLOR VARCHAR2(1000),
	FLOWER_PRICE NUMBER,
	CONSTRAINT PK_FLOWER PRIMARY KEY(FLOWER_NAME, FLOWER_COLOR)
);

INSERT INTO TBL_FLOWER
VALUES('튤립', '노랑', 9000);
INSERT INTO TBL_FLOWER
VALUES('튤립', '빨강', 9000);
INSERT INTO TBL_FLOWER
--VALUES('튤립', NULL, 9000); 	-- PK NULL 값 입력 불가	
VALUES('튤립', '파랑', 9000);
INSERT INTO TBL_FLOWER
VALUES('해바라기', '노랑', 9000);
INSERT INTO TBL_FLOWER
VALUES('해바라기', '빨강', 9000);
INSERT INTO TBL_FLOWER
VALUES('해바라기', '파랑', 9000);

SELECT * FROM TBL_FLOWER;

CREATE TABLE TBL_USER (
	USER_NUMBER NUMBER,
	USER_NAME VARCHAR2(1000),
	USER_AGE NUMBER,
	CONSTRAINT PK_USER PRIMARY KEY (USER_NUMBER)
);

-- 유저 시퀀스 생성
CREATE SEQUENCE SEQ_USER;

-- PK에 시퀀스 사용하여 값 넣기
INSERT INTO TBL_USER
--VALUES(SEQ_USER.NEXTVAL, '짱구', 5);
VALUES(SEQ_USER.NEXTVAL, '철수', 5);

-- USER_NUMBER에 값을 직접 넣어주지 않더라도 자동으로 증가되는 것 확인 가능
SELECT * FROM TBL_USER;