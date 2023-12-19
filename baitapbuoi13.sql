--bai 1
WITH job_count_cte as
(SELECT company_id, title,description,
COUNT(job_id) AS job_count  
FROM job_listings
GROUP BY company_id, title,description
ORDER BY company_id)
SELECT COUNT(DISTINCT company_id) as duplicate_companies
FROM job_count_cte
WHERE job_count >=2
--bai 2
--bai 3
WITH cte AS
(SELECT policy_holder_id, count(case_id) as times_of_call, calL_category
FROM callers
GROUP BY policy_holder_id,calL_category)
SELECT count (DISTINCT policy_holder_id) as member_count
FROM cte
WHERE times_of_call >=3
--bai 4
SELECT a.page_id 
FROM pages a left join page_likes b 
ON a.page_id =b.page_id
WHERE b.liked_date is NULL
--bai 5
--bai 6
SELECT 
Date_format (trans_date, '%Y-%m') as month,
country,
count(id) as trans_count,
sum(case when state = 'approved' then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
SUM(case WHEN state = 'approved' THEN amount ELSE 0 END) as approved_total_amount
FROM Transactions
group by Date_format (trans_date, '%Y-%m'),
country
--bai 7
select product_id, year as first_year, quantity, price
from Sales
Where (product_id, year) IN 
(Select product_id, min(year) from Sales 
group by product_id)
--bai 8
Select customer_id 
From Customer
Group by customer_id
Having Count(Distinct product_key) = (Select Count(Distinct product_key) as total_product From Product)
--bai 9
Select employee_id 
From Employees
Where salary <30000 
and manager_id not in 
(Select employee_id from Employees 
Group by Employee_id )
--bai 10
WITH job_count_cte as
(SELECT company_id, title,description,
COUNT(job_id) AS job_count  
FROM job_listings
GROUP BY company_id, title,description
ORDER BY company_id)
SELECT COUNT(DISTINCT company_id) as duplicate_companies
FROM job_count_cte
WHERE job_count >=2
--bai 11
select results from
(select a.name results from Users a 
JOIN MovieRating b
on a.user_id = b.user_id
group by a.name
order by count(b.rating) DESC, a.name 
limit 1) as ratings
union all
select results from
(select c.title results from Movies c
JOIN MovieRating b
on c.movie_id= b.movie_id
where date_format (b.created_at, '%Y-%m') = '2020-02'
group by c.title
order by AVG(b.rating) DESC, c.title 
limit 1) as movie_ratings
--bai 12
select id, count(*) as num 
from (select requester_id as id 
from RequestAccepted 
union all
select accepter_id from RequestAccepted) AS friends_count
group by id
order by count(*) desc limit 1
