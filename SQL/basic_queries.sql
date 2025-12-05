--Business Questions

--Basic level

--1. Top 10 products by total revenue
--Uses: JOIN, SUM, GROUP BY, ORDER BY
--Tables: product, orderdetail
select p.productname,sum(o.unitprice*o.qty) as total_revenue
from product p
join orderdetail o
on p.productid=o.productid
group by p.productname
order by total_revenue desc
limit 10;

--2. Monthly revenue trend for the last year
--Uses: DATE_TRUNC(), SUM(), GROUP BY
--Tables: orderdetail, salesorder
SELECT DISTINCT EXTRACT(YEAR FROM orderdate) AS years
FROM salesorder
ORDER BY years;

select DATE_TRUNC('month',s.orderdate) as Month,
sum(coalesce(o.unitprice,0)*coalesce(o.qty,0)*(1-coalesce(o.discount,0))) as Revenue
from orderdetail o
join salesorder s
on o.orderid=s.orderid
where s.orderdate>='2007-01-01'
and s.orderdate<'2008-01-01'
group by month
order by month desc;

--3. Products that have never been ordered
--Uses: LEFT JOIN + IS NULL
--Tables: product, orderdetail
select p.productid,p.productname
from product p
left join 
orderdetail o
on p.productid=o.productid
where o.productid is null;

--4. Identify delayed orders
--Uses: simple date comparison
--Tables: salesorder
SELECT orderid,orderdate, requireddate, shippeddate,
       shippeddate - requireddate AS delay_days
FROM salesorder
WHERE shippeddate > requireddate;
