--Kamila Kubala, pwi
--Zadanie 1

ALTER TABLE comments 
ADD COLUMN lasteditdate timestamp 
NOT NULL DEFAULT now();

UPDATE comments
SET lasteditdate = creationdate
WHERE creationdate IS NOT NULL;

CREATE TABLE commenthistory(
    id SERIAL PRIMARY KEY, commentid integer,
    creationdate timestamp, text text);



--Zadanie 2

CREATE OR REPLACE FUNCTION kontrola() RETURNS TRIGGER AS $X$
BEGIN
   NEW.creationdate := OLD.creationdate;
   IF OLD.id <> NEW.id OR OLD.postid <> NEW.postid OR OLD.lasteditdate <> NEW.lasteditdate THEN
      RAISE EXCEPTION 'Blad';
   END IF;
   IF OLD.text <> NEW.text THEN
      NEW.lasteditdate := now();
      INSERT INTO commenthistory 
         (commentid, creationdate,text) 
         VALUES (OLD.id, OLD.lasteditdate, OLD.text);
   END IF;
   RETURN NEW;
END;
$X$ LANGUAGE 'plpgsql';

CREATE TRIGGER wyzwalacz
AFTER UPDATE 
    ON comments
   FOR EACH ROW
EXECUTE PROCEDURE kontrola();


-- Zadanie 3
CREATE OR REPLACE FUNCTION kontrolka() 
RETURNS TRIGGER 
AS $Y$
BEGIN
    NEW.lasteditdate := NEW.creationdate;
    RETURN NEW;
END;
$Y$ LANGUAGE 'plpgsql';

CREATE TRIGGER wyz_up_com
BEFORE INSERT 
    ON comments
   FOR EACH ROW
EXECUTE PROCEDURE kontrolka();



