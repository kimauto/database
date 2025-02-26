select * from employees;
-- 1. 연봉이 12000 이상되는 직원들의 LAST_NAME 및 연봉을 조회한다.
	select last_name, salary
    from employees;
 
-- 2. 사원번호가 176 인 사람의 LAST_NAME 과 부서 번호를 조회한다.
	 	select last_name, job_id
		from employees
		where employee_id = 176;
        
-- 3. 연봉이 5000 에서 12000의 범위 이외인 사람들의 LAST_NAME 및 연봉을 조회힌다.
	  select last_name, salary
	  from employees
	  where salary between 5000 and 12000;
      
-- 4. 1998/02/20 일부터 1998/05/01 사이에 고용된 사원들의 LAST_NAME 사번, 고용일자를 조회한다.  단, 고용일자 순으로 정렬한다.
	  select last_name, hire_date
      from employees
      where hire_date between str_to_date('1998/02/20','%Y/%m/%d') and str_to_date('1998/05/01','%Y/%m/%d')
      order by hire_date;
 
 
-- 5. 20 번 및 50 번 부서에서 근무하는 모든 사원들의 LAST_NAME 및 부서 번호를 알파벳순으로 조회한다.
	  select last_name, department_id
      from employees
      where department_id = 20 or department_id = 50
      order by last_name;
 
-- 6. 20 번 및 50 번 부서에 근무하며, 연봉이 5000 ~ 12,000 사이인 사원들의 LAST_NAME 및 연봉을 조회한다.
		 select last_name, salary
      from employees
      where department_id = 20 or department_id = 50 and salary between 5000 and 120000;
      
 
-- 7. 1994년도에 고용된 모든 사람들의 LAST_NAME 및 고용일을 조회한다.
	  
      select last_name, hire_date
      from employees
      where YEAR(hire_date) = '1994'; 
      

-- 8. 매니저가 없는 사람들의 LAST_NAME 및 JOB_ID 를 조회한다.
	select last_name, job_id
    from employees
    where manager_id is null;
 
-- 9. 매니저가 있는 사람들의 LAST_NAME 및 JOB_ID 를 조회한다.
    select last_name, job_id
    from employees
    where manager_id is not null;
 
-- 10. 커미션을 버는 모든 사원들의 LAST_ANME, 연봉 및 커미션을 조회한다.   연봉 역순, 커미션 역순차로 정렬한다.
	 select last_name, salary, commission_pct
     from employees
     where commission_pct is not null
     order by salary desc, commission_pct desc;
 
-- 11. LAST_NAME 의 네번째 글자가 a 인 사원들의 LAST_NAME 을 조회한다.
      select last_name
      from employees
      where SUBSTRING(last_name,4,1) = 'a';
 
-- 12. LAST_NAME 에 a 및(OR) e 글자가 있는 사원들의 LAST_NAME 을 조회한다.
	  select last_name
      from employees
      where SUBSTRING(last_name,4,1) = 'a' or  SUBSTRING(last_name,4,1) = 'e';

-- 13. 연봉이 2,500, 3,500, 7000 이 아니며 직업이 SA_REP 이나 ST_CLERK 인 사람들을 조회한다.
	 select *
     from employees
	where salary not in (2500, 3500, 7000) and  job_id = 'SA_REP' OR job_id = 'ST_CLERK';
    
-- 14. 모든 사원들의 LAST_NAME, 부서 이름 및 부서 번호을 조회한다.
	select o.last_name, d.department_name, d.department_id
    from employees o, departments d
	where o.department_id = d.department_id;
    
-- 15. 부서번호 30 내의 모든 직업들을 조회한다. 90 부서 또한 포함한다.
	select job_id
    from employees 
    where department_id < 30 or department_id = 90;
	
    
      
-- 16. 커미션을 버는 모든 사람들의 LAST_NAME, 부서 명, 지역 ID 및 도시 명을 조회한다.
	  select o.last_name, d.department_name, l.location_id, l.city
      from employees o, departments d,  locations l
      where o.department_id = d.department_id and d.location_id = l.location_id and o.commission_pct is not null; 
      
-- 17.  hr 스키마에 존재하는 Employees, Departments, Locations 테이블의 구조를 파악한 후 Oxford에 근무하는 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 도시명을 출력하시오. 이때 첫 번째 열은 회사명인 ‘신세계’라는 상수 값이 출력되도록 하시오
	  select '신세계' as 회사명, concat(o.first_name, ' ',o.last_name), o.job_id, d.department_name, l.city
      from employees o, departments d,  locations l
      where o.department_id = d.department_id and d.location_id = l.location_id and l.state_province = 'Oxford';
      
-- 18.  hr 스키마에 있는 Employees, Departments 테이블의 구조를 파악한 후 사원 수가 다섯명 이상인 부서의 부서명과 사원 수를 출력하시오. 이때 사원 수가 많은 순으로 정렬하시오
		select d.department_name, count(o.employee_id) as '사원 수'
        from employees o, departments d
        where o.department_id = d.department_id
        group by o.department_id
        having  count(o.employee_id) >= 5;
        
-- 19.  hr 스키마의 Job_Grades 테이블을 사용하여 각 사원의 급여에 따른 급여 등급을 보고하려고 한다. 급여 등급은 Job_Grades 테이블에 표시된다. 
-- 해당 테이블의 구조를 살펴본 후 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 입사일, 급여, 급여 등급을 출력하시오
	
    
	   
-- 20. 각 사원과 직속 상사와의 관계를 이용하여 다음과 같은 형식의 보고서를 작성하고자 한다.예) 홍길동은 허균에게 보고한다 → Neena Kochhar report to STEVEN KING 어떤 사원이 어떤 사원에게 보고하는지 위 예를 참고하여 출력하시오. 단, 보고할 상사가 없는 사원이 있다면 그 정보도 포함하여 출력하고, 상사의 이름은 대문자로 출력하시오
		SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS Employee,  
    CONCAT(UCASE(m.first_name), ' ', UCASE(m.last_name)) AS Manager
    FROM employees e LEFT JOIN employees m 
	ON e.manager_id = m.employee_id
   ORDER BY Manager DESC;  

