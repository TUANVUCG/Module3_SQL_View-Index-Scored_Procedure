SELECT * FROM studentmng.student;

ALTER TABLE class 
ADD INDEX index_class(ClassID);

EXPLAIN SELECT*
FROM class
WHERE ClassID = 1;

alter table class
drop index index_class;
