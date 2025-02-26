-- HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. Tucker 사원보다 급여 를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오
  select * from employees;
  
  select concat(first_name,' ' ,last_name) as Name, job_id, salary
  from employees
  where salary > (
	select salary
    from employees
    where last_name = 'Tucker'
  );

-- 사원의 급여 정보 중 업무별 최소 급여를 받는 사원의 성과 이름(Name으로 별칭), 업무,급여, 입사일을 출력하시오
   
	select concat(first_name,' ' ,last_name) as Name, job_id, salary, hire_date
    from employees e
    where job_id in (
		select job_id
        from jobs j
        where e.salary = j.min_salary 
	);
 
-- 소속 부서의 평균 급여보다 많은 급여를 받는 사원의 성과 이름(Name으로 별칭), 급여,부서번호, 업무를 출력하시오
	SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS Name,  
	e.salary,                                       
    e.department_id,                                 
    e.job_id                                    
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary) 
    FROM employees 
    WHERE department_id = e.department_id  
);
-- 사원들의 지역별 근무 현황을 조회하고자 한다. 도시 이름이 영문 ‘O’로 시작하는 지역에 살고 있는 사원의 사번, 성과 이름(Name으로 별칭), 업무, 입사일을 출력하시오
 -- 조인 방식으로 
    select e.employee_id, concat(e.first_name, ' ',e.last_name), e.job_id, e.hire_date
    from employees e, locations l, departments d
    where e.department_id = d.department_id and d.location_id = l.location_id and l.city like 'O%' ;
    -- 서브쿼리로 
    SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS Name, e.job_id, e.hire_date
	FROM employees e
	WHERE e.department_id IN (
		SELECT d.department_id
		FROM departments d
		WHERE d.location_id IN (
			SELECT l.location_id
			FROM locations l
			WHERE l.city LIKE 'O%'
    )
);
-- 시애틀에 사는 사람 중 커미션을 버는 모든 사람들의 LAST_NAME, 부서 명, 지역 ID 및 도시 명을 조회한다.
SELECT e.last_name, d.department_name, l.location_id, l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE e.commission_pct IS NOT NULL 
AND l.city = 'Seattle';
  
-- LAST_NAME 이 DAVIES 인 사람보다 후에 고용된 사원들의 LAST_NAME 및 HIRE_DATE 을 조회한다.
select last_name, hire_date
from employees
where hire_date > (
	select hire_date
    from employees
    where last_name = 'DAVIES' 
);
-- 매니저로 근무하는 사원들의 총 수를 조회한다.
   select count(distinct manager_id)
   from employees
   where manager_id is not null;

-- LAST_NAME 이 Zlotkey 와 동일한 부서에 근무하는 모든 사원들의 사번 및 고용날짜를 조회한다.
 select employee_id, hire_date
 from employees
 where department_id = (
		select department_id
        from employees
        where last_name = 'Zlotkey'
 );