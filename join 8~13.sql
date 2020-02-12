--join8
SELECT r.region_id,r.region_name,c.country_name
FROM regions r JOIN countries c ON (r.region_id = c.region_id)
WHERE region_name = 'Europe';

--join9
SELECT r.region_id, r.region_name,c.country_name, l.city
FROM regions r JOIN countries c ON (r.region_id = c.region_id)
JOIN locations l ON (c.country_id = l.country_id)
WHERE r.region_name = 'Europe';

--join10
SELECT r.region_id, r.region_name,c.country_name, l.city, d.department_name
FROM regions r JOIN countries c ON (r.region_id = c.region_id)
JOIN locations l ON (c.country_id = l.country_id)
JOIN departments d ON (l.location_id = d.location_id)
WHERE r.region_name = 'Europe';

--join11
SELECT r.region_id, r.region_name,c.country_name, l.city, d.department_name, e.first_name||e.last_name
FROM regions r JOIN countries c ON (r.region_id = c.region_id)
JOIN locations l ON (c.country_id = l.country_id)
JOIN departments d ON (l.location_id = d.location_id)
JOIN employees e ON (e.department_id = d.department_id)
WHERE r.region_name = 'Europe';

--join12
SELECT e.employee_id, e.first_name || e.last_name name,j.job_id, j.job_title
FROM employees e JOIN jobs j ON (j.job_id = e.job_id);

--join13  다시풀어 두번풀어

SELECT e.employee_id,e.first_name || e.last_name,e2.employee_id,e2.first_name || e2.last_name,j.job_id,job_title
FROM employees e JOIN employees e2 ON (e.employee_id = e2.manager_id) JOIN jobs j ON (e2.job_id = j.job_id);

