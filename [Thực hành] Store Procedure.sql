USE studentmng;

DELIMITER //
CREATE PROCEDURE findStudent(IN studentID INT)
BEGIN
SELECT*
FROM student
WHERE student.StudentID = studentID;
END //
DELIMITER ;

CALL findStudent(1);