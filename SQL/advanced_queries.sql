--Advance level

--1. Customer churn: customers who ordered in year N but not in year N+1
--Uses: CTEs, NOT EXISTS, date extraction
--Tables: customer, salesorder
with customer_orders_by_year as(
	select c.custid,
	c.contactname,
	EXTRACT(YEAR from s.orderdate) as order_year,
	COUNT(*) as order_count
from customer c
join salesorder s
on c.custid::text=s.custid
group by c.custid,c.contactname,EXTRACT(YEAR from s.orderdate)
),
churn_analysis as(
	select custid,
	contactname,
	order_year
from customer_orders_by_year
where order_count > 0
)
select distinct
	ca1.custid,
	ca1.contactname,
	ca1.order_year as last_active_year
from churn_analysis ca1
where NOT EXISTS (
	select 1
	from churn_analysis ca2
	where ca2.custid=ca1.custid
	and ca2.order_year=ca1.order_year+1
)
order by last_active_year desc;


--2. Employee performance ranking + change vs previous year
--Uses: window functions (RANK, LAG), conditional aggregation
--Tables: employee, salesorder,orderdetail
with employee_yearly_sales as(
	select e.empid,
	e.lastname,
	e.firstname,
	extract(year from s.orderdate) as sales_year,
	sum(coalesce(o.unitprice,0)*coalesce(o.qty,0)*(1-coalesce(o.discount,0))) as total_sales
from employee e
	join salesorder s
	on e.empid=s.empid
	join orderdetail o
	on s.orderid=o.orderid
group by 1,2,3,4	
),
ranked_performance as(
	select empid,
	lastname,
	firstname,
	sales_year,
	total_sales,
	Rank() over(partition by sales_year order by total_sales desc) as yearly_rank,
	lag(total_sales) over(partition by empid order by sales_year) as prev_year_sales,
	lag(sales_year) over(partition by empid order by sales_year) as prev_year
from employee_yearly_sales
)
select
	empid,
	lastname || ', ' || firstname as employee_name,
	sales_year,
	total_sales,
	yearly_rank,
	prev_year,
	prev_year_sales,
case 
	when prev_year_sales is not null
	then Round(((total_sales-prev_year_sales)/prev_year_sales*100::numeric),2)|| '%'
	else null
end as  yoy_pct_change
from ranked_performance
where prev_year_sales is not null
order by sales_year desc, yearly_rank;
