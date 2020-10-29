--Kamila Kubala, Pwi
--Zadanie 1 


CREATE VIEW ranking
  (displayname, liczba_odpowiedzi)
AS
SELECT u.displayname, COUNT(b.id)
FROM posts a 
JOIN posts b ON (a.acceptedanswerid = b.id)
JOIN users u ON (u.id = b.owneruserid)
GROUP BY 1
ORDER BY 2 DESC, 1;


-- Zadanie 2
WITH user_with_enl AS
(SELECT DISTINCT userid
FROM badges 
WHERE name='Enlightened')

SELECT AVG(u.upvotes)
FROM users u 
JOIN user_with_enl uwe
 ON (u.id = uwe.userid);

-- srednia to 171.2439024390243902
-- teraz mozemy ja wykorzystac


WITH bezodznaki AS
((SELECT id  FROM users)
EXCEPT
(SELECT userid FROM badges 
WHERE name='Enlightened')),

kom2020 AS
(SELECT DISTINCT u.id, COUNT(c.id) AS licz
FROM users u 
JOIN comments c ON (u.id =c.userid)
WHERE c.creationdate >= '01-01-2020 00:00:00'
GROUP BY 1)

SELECT u.id, u.displayname, u.reputation 
FROM bezodznaki b
JOIN users u ON (b.id = u.id)
JOIN kom2020 k ON (k.id = u.id)
WHERE k.licz>1
AND 
u.upvotes > 171
GROUP BY 1,2,3, u.creationdate
ORDER BY u.creationdate;

--zadanie 3

WITH RECURSIVE recurrence AS (
  SELECT u.id u_id, u.displayname, p.id 
  FROM users u 
  JOIN posts p ON (p.owneruserid = u.id)	
  WHERE p.body LIKE '%recurrence%'
UNION
  SELECT u.id, u.displayname, p.id
  FROM users u 
  JOIN comments c ON (u.id = c.userid)
  JOIN posts p ON(c.postid = p.id) 
  JOIN recurrence r ON(p.owneruserid= r.u_id)
  )

SELECT DISTINCT u_id, displayname FROM recurrence;













