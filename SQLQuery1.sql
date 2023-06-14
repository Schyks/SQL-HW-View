CREATE VIEW Teacher_Book AS
SELECT  CONCAT(Teacher.first_name +'  ', Teacher.last_name) AS 'Teacher full name', Book.Name AS 'Book name'
FROM Teacher, T_Cards, Book WHERE Teacher.id=T_Cards.id_teacher AND T_Cards.id_book=Book.id;

CREATE VIEW Student_Book_Debt AS
SELECT  CONCAT(Student.first_name +'  ', Student.last_name) AS 'Student full name'
FROM Student JOIN S_Cards ON Student.id=S_Cards.id_student WHERE S_Cards.date_in IS NULL

CREATE VIEW Student_Not_Book AS
SELECT  CONCAT(Student.first_name +'  ', Student.last_name) AS 'Student full name'
FROM Student WHERE Student.id NOT IN (SELECT  Student.id FROM Student, S_Cards WHERE Student.id=S_Cards.id_student group by Student.id)



CREATE VIEW Librarian_Best AS
SELECT CONCAT(Librarian.first_name +'  ', Librarian.last_name) AS 'Librarian full name' FROM Librarian, 
(SELECT id_librarian as id, COUNT(id_librarian) AS 'Cnt'  FROM 
(SELECT * FROM T_Cards UNION ALL SELECT * FROM S_Cards) AS Cards group by id_librarian HAVING COUNT(id_librarian)=
(SELECT MAX(C.Count) FROM (SELECT id_librarian as id, COUNT(*) AS 'Count'  FROM 
(SELECT * FROM T_Cards UNION ALL SELECT * FROM S_Cards) AS Cards group by id_librarian) as C)) as C 
where Librarian.id = C.id

CREATE VIEW Librarian_Responsible AS
SELECT CONCAT(Librarian.first_name +'  ', Librarian.last_name) AS 'Librarian full name' FROM Librarian WHERE Librarian.id=
(SELECT id FROM (SELECT id_librarian AS id, COUNT(id_librarian) AS 'Count' FROM
(SELECT * FROM  (SELECT * FROM T_Cards UNION ALL SELECT * FROM S_Cards) AS Cards WHERE date_in IS NOT NULL) AS A group by id_librarian) AS C WHERE Count=
(SELECT  MAX(Count) FROM (SELECT id_librarian AS id, COUNT(id_librarian) AS 'Count' FROM (SELECT * FROM 
(SELECT * FROM T_Cards UNION ALL SELECT * FROM S_Cards) AS Cards WHERE date_in IS NOT NULL) AS A group by id_librarian) AS B))



SELECT  * FROM Teacher_Book
SELECT  * FROM Student_Book_Debt 
SELECT  * FROM Student_Not_Book 
SELECT  * FROM Librarian_Best 
SELECT  * FROM Librarian_Responsible

SELECT  * FROM Author
SELECT  * FROM Book
SELECT  * FROM Category
SELECT  * FROM Department;
SELECT  * FROM Group;
SELECT  * FROM Librarian
SELECT  * FROM Publishment
SELECT  * FROM S_Cards
SELECT  * FROM T_Cards
SELECT  * FROM Teacher
SELECT  * FROM Theme
SELECT  * FROM Student
