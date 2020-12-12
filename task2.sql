SELECT 
    a.avg_salary, d.*
FROM
    departments d,
    (SELECT 
        AVG(s.salary) AS avg_salary, de.dept_no
    FROM
        dept_emp de
    JOIN salaries s ON de.emp_no = s.emp_no
    where s.to_date = '9999-01-01'
    and de.to_date = '9999-01-01'
    GROUP BY de.dept_no) a
WHERE
    d.dept_no = a.dept_no

----------------------------------------------
SELECT 
    a.max_salary, e.*
FROM
    employees e
        JOIN
    (SELECT 
        MAX(s.salary) AS max_salary, s.emp_no
    FROM
        salaries s
    GROUP BY s.emp_no) a ON e.emp_no = a.emp_no

----------------------------------------------
SET @emp := null;
SELECT 
    s.emp_no
INTO @emp FROM
    salaries s
WHERE
    s.salary = (SELECT 
            MAX(s2.salary)
        FROM
            salaries s2)
LIMIT 1;
delete from dept_emp de where de.emp_no = @emp;
delete from dept_manager dm where dm.emp_no = @emp;
delete from salaries s where s.emp_no = @emp;
delete from titles t where t.emp_no = @emp;
delete from employees e where e.emp_no = @emp;

----------------------------------------------
SELECT 
    a.count_emp, d.*
FROM
    departments d,
    (SELECT 
        COUNT(de.emp_no) AS count_emp, de.dept_no
    FROM
        dept_emp de
    WHERE
        de.to_date = '9999-01-01'
    GROUP BY de.dept_no) a
WHERE
    d.dept_no = a.dept_no;

----------------------------------------------
SELECT 
    a.sum_salary, a.count_emp, d.*
FROM
    departments d,
    (SELECT 
        SUM(s.salary) AS sum_salary,
            COUNT(s.emp_no) AS count_emp,
            de.dept_no
    FROM
        dept_emp de
    JOIN salaries s ON de.emp_no = s.emp_no
    WHERE
        s.to_date = '9999-01-01'
            AND de.to_date = '9999-01-01'
    GROUP BY de.dept_no) a
WHERE
    d.dept_no = a.dept_no