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

UPDATE comment SET comment_number = comment_number + 1 WHERE board_number = 1;

### 좋아요
INSERT INTO favorite VALUES ('email@email.com',1);
### 좋아요 취소
DELETE FROM favorite WHERE user_email = 'email@email.com' AND board_number = 1;

