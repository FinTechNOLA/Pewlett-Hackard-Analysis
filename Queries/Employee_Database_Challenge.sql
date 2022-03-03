--Create Temp Table
Select em.emp_no,
    em.first_name, 
    em.last_name, 
    t.title, 
    t.from_date, 
    t.to_date
INTO RetireesByTitle
From employees as em
INNER Join titles as t
ON em.emp_no = t.emp_no
WHERE em.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
Order By em.emp_no

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) 
rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM RetireesByTitle AS rt
WHERE to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.emp_no DESC;

Select COUNT(ut.emp_no), 
title
INTO Retiring_Titles
FROM unique_titles as ut
Group By title
Order By Count(title) DESC;

--Create temp table for mentorship
Select em.emp_no,
em.first_name,
em.last_name,
em.birth_date
INTO mentorship_eligibility
From employees as em
WHERE em.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY em.emp_no

--join tables 
Select DISTINCT ON (me.emp_no)
me.emp_no,
me.first_name,
me.last_name,
me.birth_date,
d.from_date, 
d.to_date,
t.title
INTO mentorship_joined
From mentorship_eligibility AS me
INNER Join dept_emp as d
ON me.emp_no = d.emp_no
INNER Join titles as t
ON me.emp_no = t.emp_no
WHERE d.to_date = '9999-01-01'
ORDER BY me.emp_no
;



