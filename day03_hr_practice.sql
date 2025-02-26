--  문제 1 모든 사원은 직속 상사 및 직속 직원을 갖는다. 단, 최상위 또는 최하위 직원은 직속 상사 및 직원이 없다. 소속된 사원 중 어떤 사원의 상사로 근무 중인 사원의 총수를 출력하시오(1행)
SELECT COUNT(distinct manager_id) "직속 상사"
FROM Employees;

select employee_id, last_name  , manager_id from employees;

-- 문제2 
-- 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최댓값, 급여 최솟값을 집계하고자 한다. 계산된 출력 값은 여섯 자리와 세 자리 구분기호, $ 표시와 함께 출력하고 부서번호의 오름차순 정렬하시오. 단, 부서에 소속되지 않은 사원에 대한 정보는 제외하고, 
-- 출력 시 머리글은 부서아이디, 급여합계, 급여평균, 급여최댓값, 급여최솟값 별칭(alias) 처리하시오(11행)


SELECT department_id as 부서아이디,
CONCAT('$', FORMAT(SUM(salary), 0)) as "급여 합계",
CONCAT('$', FORMAT(AVG(salary), 1)) as "급여 평균",
CONCAT('$', FORMAT(MAX(salary), 0)) as "급여 최댓값",
CONCAT('$', FORMAT(MIN(salary), 0)) as "급여 최솟값"
FROM Employees
WHERE department_id is NOT NULL
GROUP BY department_id;



-- 문제 3
-- 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시오. 단 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시오(7행)

 SELECT job_id, avg(salary) as "급여평균"
 FROM Employees
 WHERE  job_id NOT LIKE '%CLERK%'
 GROUP BY job_id
 HAVING avg(salary) > 10000
 ORDER BY avg(salary) DESC;
 


-- 9. 이번 분기에 60번 IT 부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하였다. 이에 해당 부서의 사원 급여를 12.3% 인상하기로 하였다. 60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만(반올림) 표시하는 보고서를 작성하시오. 출력 형식은 사번, 이름과 성(Name으로 별칭), 급여, 인상된 급여(Increased Salary로 별칭) 순으로 출력한다
-- 10. 이름이 ‘s’로 끝나는 각 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한다. 출력시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 머리글은 EmployeeJOBs.로 표시하시오  예) Sigal Tobias is a PU_CLERK
-- 11. 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 보고서에 사원의 성과 이름(Name으로 별칭), 급여, 수당 여부에 따른 연봉을 포함하여 출력하시오. 수당 여부는 수당이 있으면 “Salary + Commission”, 수당이 없으면 “Salary only”라고 표시하고, 별칭은 적절히 붙인다. 또한 출력 시 연봉이 높은 순으로 정렬한다 
-- 12. 모든 사원의 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이었는지 출력하시오. 이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오


desc employees;
-- 인사부서 데이터베이스 
select first_name, last_name from employees;