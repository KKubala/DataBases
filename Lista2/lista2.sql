--Kamila Kubala, pwi 

--Zadanie 1

SELECT u.id, u.displayname, u.reputation, count(pl.postid)
FROM posts p
JOIN postlinks pl ON (pl.postid = p.id)
JOIN users u ON (p.owneruserid = u.id)
WHERE pl.linktypeid = 3
GROUP BY 1,2,3
ORDER BY 4 DESC, 2
LIMIT 20;

--Zadanie 2

SELECT u.id, u.displayname, u.reputation, count(c.id), avg(c.score)
FROM users u
JOIN badges b ON (u.id = b.userid)
LEFT JOIN posts p ON (u.id = p.owneruserid)
LEFT JOIN comments c ON (c.postid = p.id)
WHERE b.name = 'Fanatic'
GROUP BY 1,2,3
HAVING COUNT(c.id)<101
ORDER BY 4 DESC, 2
LIMIT 20;

--ZAdanie3

ALTER TABLE users 
ADD PRIMARY KEY (id);

ALTER TABLE badges
ADD FOREIGN KEY (userid)
REFERENCES users (id);

ALTER TABLE posts DROP COLUMN viewcount;

DELETE from posts where body = '' or body IS NULL;


--Zadanie 4


CREATE SEQUENCE post_id_seq;

SELECT setval('post_id_seq',max(id))
FROM posts;


ALTER TABLE posts ALTER COLUMN id
SET DEFAULT nextval('post_id_seq');

ALTER SEQUENCE post_id_seq OWNED BY posts.id;

INSERT INTO posts    
   (posttypeid,parentid, creationdate, score, body, owneruserid)
   SELECT 3, c.postid, c.creationdate, c.score, c.text, c.userid
      FROM comments c;












