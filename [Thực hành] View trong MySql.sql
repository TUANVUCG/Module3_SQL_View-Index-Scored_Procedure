	create view studentID_view AS
    select*
    from student
    where studentID = 1;
    
    drop view studentID_view;