--Kamila Kubala, PWi

--Zadanie 1

SELECT creationdate
FROM posts
WHERE body LIKE '%Turing%'
ORDER BY 1 DESC;


--Zadanie 2

SELECT id, title
FROM posts
WHERE (((creationdate >= '10-10-2018 00:00:00')
AND (creationdate < '01-01-2019 00:00:00')
)
OR ((creationdate >= '01-09-2019 00:00:00')
AND (creationdate < '01-01-2020 00:00:00')))
AND title IS NOT NULL
AND score > 8
ORDER BY 2;

--Zadanie 3

SELECT distinct users.displayname, users.reputation
FROM posts 
JOIN users ON (users.id = posts.owneruserid)
JOIN comments ON (comments.postid = posts.id)
WHERE posts.body LIKE '%deterministic%'
AND comments.text LIKE '%deterministic%'
ORDER BY 2 DESC;

--Zadanie 4

(SELECT distinct users.displayname, users.id
FROM posts JOIN users ON(posts.owneruserid = users.id)) 
EXCEPT
(SELECT distinct users.displayname,users.id FROM comments
JOIN users ON (comments.userid = users.id))
ORDER BY 1
LIMIT 10;





