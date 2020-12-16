1. ----------
USE `employees`;
CREATE  OR REPLACE VIEW `task1` AS
SELECT 
    a.max_salary, e.*
FROM
    employees e
        JOIN
    (SELECT 
        MAX(s.salary) AS max_salary, s.emp_no
    FROM
        salaries s
    GROUP BY s.emp_no) a ON e.emp_no = a.emp_no;

SELECT * FROM employees.task1;

2. ----------
USE `employees`;
DROP function IF EXISTS `find_manager`;

DELIMITER $$
USE `employees`$$
CREATE FUNCTION `find_manager` (fname varchar(255), lname varchar(255))
RETURNS INTEGER
BEGIN
RETURN (SELECT 
    e.emp_no
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    e.first_name = fname
        AND e.last_name = lname);
END$$

DELIMITER ;

select employees.find_manager('Ebru', 'Alpin');

3. ----------
DROP TRIGGER IF EXISTS `employees`.`employees_AFTER_INSERT`;

DELIMITER $$
USE `employees`$$
CREATE DEFINER = CURRENT_USER TRIGGER `employees`.`employees_AFTER_INSERT` AFTER INSERT ON `employees` FOR EACH ROW
BEGIN
INSERT INTO `employees`.`salaries` (`emp_no`, `salary`, `from_date`, `to_date`) VALUES (NEW.emp_no, '10000', CURRENT_DATE(), CURRENT_DATE());
END$$
DELIMITER ;