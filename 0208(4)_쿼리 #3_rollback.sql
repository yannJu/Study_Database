-- 1. 고객 중 13/09/01 이후 등록한 고객들의 마일리지를 350점 씩 올려주세요
show variables like 'autocommit%';
SET AUTOCOMMIT = FALSE;

UPDATE member
SET mileage = mileage + 350 
WHERE reg_date > '2013-09-01';

SELECT *
FROM member;

ROLLBACK;

SELECT * from member;

ROLLBACK;

-- 2. 등록되어 있는 고객 정보 중 이름에 '김'자가 들어있는 모든 이름을 '최'로 변경하세요
UPDATE member
SET NAME = REPLACE(NAME, '김', '최')
WHERE 1=1;

SELECT * FROM member;

ROLLBACK;

SELECT * FROM member;