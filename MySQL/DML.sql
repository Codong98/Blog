use blog;

### 회원가입
INSERT INTO
    user VALUES
('email@email.com','mysql@1234','nickname','01012345678','경기도 수원시 팔달구','권광로373',null);


###로그인
SELECT * FROM user WHERE email = 'email@email.com';

### 게시물 작성
INSERT INTO board (title,content,write_datetime,favorite_count ,comment_count, view_count, writer_email)
VALUES ('제목','내용입니다.',now(),'0','0','0', 'email@email.com');

INSERT INTO image VALUES (1,'url');

### 댓글작성
INSERT INTO comment (content, write_datetime, user_email, board_number)
VALUES ('안녕하세요',now(),'email@email.com', 1);
UPDATE board SET comment_count = comment_count + 1 WHERE board_number = 1;

### 좋아요
INSERT INTO favorite VALUES ('email@email.com',1);
UPDATE board SET favorite_count = favorite_count + 1 WHERE board_number = 1;

### 좋아요 취소
DELETE FROM favorite WHERE user_email = 'email@email.com' AND board_number = 1;

### 게시물 수정
UPDATE board SET title = '수정 제목입니다.', content = '수정 내용입니다.' where board_number = 1;
DELETE FROM image where board_number = 1;
INSERT INTO image VALUES (1,'url');

### 게시물 삭제
DELETE FROM comment WHERE board_number = 1;
DELETE FROM favorite WHERE board_number = 1;
DELETE FROM board WHERE board_number = 1;

### 상세 게시물 불러오기
SELECT
    B.board_number AS board_number,
    B.title AS title,
    B.content AS content,
    B.write_datetime AS write_datetime,
    B.writer_email AS write_email,
    U.nickname AS nickname,
    U.profile_image AS profile_image
FROM board AS B
INNER JOIN user AS U
ON B.writer_email = U.email
WHERE board_number = 1;

### 상세 게시물 불러오기 이미지
SELECT image
FROM image
WHERE board_number = 1;

### 상세 게시물 불러오기 좋아요리스트
SELECT
    U.email AS email,
    U.nickname AS nickname,
    U.profile_image AS profile_image
FROM favorite AS F
INNER JOIN user AS U
ON F.user_email = U.email
WHERE F.board_number = 1;

### 상세 게시물 불러오기 댓글리스트
SELECT
    U.nickname AS nickname,
    U.profile_image AS profile_image,
    C.write_datetime AS write_datetime,
    C.content AS content
FROM comment AS C
INNER JOIN user AS U
ON c.user_email = u.email
WHERE C.board_number = 1
ORDER BY write_datetime DESC;

### 최신게시물 리스트 불러오기
SELECT
    B.board_number AS board_number,
    B.title AS title,
    B.content AS content,
    I.image AS title_image,
    B.favorite_count AS favorite_count,
    B.comment_count AS comment_count,
    B.view_count AS view_count,
    B.write_datetime AS write_datetime,
    U.nickname AS writer_nickname,
    U.profile_image AS writer_profile_image
FROM board AS B
INNER JOIN user AS U
ON B.writer_email = U.email
LEFT JOIN (SELECT board_number, ANY_VALUE(image) AS image FROM image GROUP BY board_number) AS I
ON B.board_number = I.board_number
ORDER BY write_datetime DESC
LIMIT 0,5;
####################################################################################
SELECT *
FROM board_list_view
ORDER BY write_datetime DESC
LIMIT 0,5;



### 검색어 리스트 불러오기
SELECT
    B.board_number AS board_number,
    B.title AS title,
    B.content AS content,
    I.image AS title_image,
    B.favorite_count AS favorite_count,
    B.comment_count AS comment_count,
    B.view_count AS view_count,
    B.write_datetime AS write_datetime,
    U.nickname AS writer_nickname,
    U.profile_image AS writer_profile_image
FROM board AS B
         INNER JOIN user AS U
                    ON B.writer_email = U.email
         LEFT JOIN (SELECT board_number, ANY_VALUE(image) AS image FROM image GROUP BY board_number) AS I
                   ON B.board_number = I.board_number
WHERE title like '%수정%' or content LIKE '%수정%'
ORDER BY write_datetime DESC;
####################################################################################
SELECT *
FROM board_list_view
WHERE title like '%수정%' or content LIKE '%수정%'
ORDER BY write_datetime DESC;


## 최근 일주일의 주간상위 TOP3 게시물
SELECT
    B.board_number AS board_number,
    B.title AS title,
    B.content AS content,
    I.image AS title_image,
    B.favorite_count AS favorite_count,
    B.comment_count AS comment_count,
    B.view_count AS view_count,
    B.write_datetime AS write_datetime,
    U.nickname AS writer_nickname,
    U.profile_image AS writer_profile_image
FROM board AS B
INNER JOIN user AS U
ON B.writer_email = U.email
LEFT JOIN (SELECT board_number, ANY_VALUE(image) AS image FROM image GROUP BY board_number) AS I
ON B.board_number = I.board_number
WHERE B.write_datetime BETWEEN '2026-06-18 00:00:00' AND '2026-06-26 23:59:59'
ORDER BY favorite_count DESC, comment_count DESC, view_count DESC, write_datetime DESC
LIMIT 3;
####################################################################################
SELECT *
FROM board_list_view
WHERE write_datetime BETWEEN '2026-06-18 00:00:00' AND '2026-06-26 23:59:59'
ORDER BY favorite_count DESC, comment_count DESC, view_count DESC, write_datetime DESC
LIMIT 3;


### 특정 유저 게시물 불러오기
SELECT
    B.board_number AS board_number,
    B.title AS title,
    B.content AS content,
    I.image AS title_image,
    B.favorite_count AS favorite_count,
    B.comment_count AS comment_count,
    B.view_count AS view_count,
    B.write_datetime AS write_datetime,
    U.nickname AS writer_nickname,
    U.profile_image AS writer_profile_image
FROM board AS B
         INNER JOIN user AS U
                    ON B.writer_email = U.email
         LEFT JOIN (SELECT board_number, ANY_VALUE(image) AS image FROM image GROUP BY board_number) AS I
                   ON B.board_number = I.board_number
WHERE B.writer_email = 'email@email.com'
ORDER BY write_datetime DESC
LIMIT 0,5;
####################################################################################
SELECT *
FROM board_list_view
WHERE writer_email = 'email@email.com'
ORDER BY write_datetime DESC
LIMIT 0,5;




### 인기 검색어 리스트
SELECT search_word, count(search_word) AS count
FROM search_log
WHERE relation IS FALSE
GROUP BY search_word
ORDER BY count DESC
LIMIT 15;


### 관련 검색어 리스트
SELECT relation_word, count(relation_word) AS count
FROM search_log
WHERE search_word = '검색어'
GROUP BY relation_word
ORDER BY count DESC
LIMIT 15;

### 유저 정보 불러오기 / 로그인 유저 정보 불러오기
SELECT *
FROM user
WHERE email = 'email@email.com';

### 닉네임 수정
UPDATE user SET nickname = '수정 닉네임' WHERE email = ' email.email.com';
### 프로필 이미지 수정
UPDATE user SET profile_image = 'url2' WHERE email = ' email.email.com';
