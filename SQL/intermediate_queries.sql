--Intermediate level

--1. Top customers by lifetime value + their % of total revenue
--Uses: JOINs, SUM(), GROUP BY, window function (optional)
--Tables: customer, salesorder, orderdetail
select c.custid, c.contactname,
sum(coalesce(o.unitprice,0)*coalesce(o.qty,0)*(1-coalesce(o.discount,0))) as life_time_revenue,
Round(
	100.0 * sum(coalesce(o.unitprice,0)*coalesce(o.qty,0)*(1-coalesce(o.discount,0)))
	/sum(sum(coalesce(o.unitprice,0)*coalesce(o.qty,0)*(1-coalesce(o.discount,0)))) over(),
	2) || '%' as pct_of_total_revenue
from customer c
join salesorder s
on c.custid::text=s.custid
join orderdetail o
on s.orderid=o.orderid
group by c.custid, c.contactname
order by pct_of_total_revenue desc
limit 10;


--2. Customers with more than 5 orders AND AOV (avg order value) above global average
--Uses: HAVING, subquery, GROUP BY
--Tables: customer, salesorder, orderdetail
SELECT 
    c.custid, 
    c.contactname,
    COUNT(s.orderid) AS order_count,
    AVG(o.unitprice * o.qty) AS aov
FROM customer c
JOIN salesorder s ON c.custid::text = s.custid
JOIN orderdetail o ON s.orderid = o.orderid
GROUP BY c.custid, c.contactname
HAVING COUNT(s.orderid) > 5 
   AND AVG(o.unitprice * o.qty) > (
       SELECT AVG(unitprice * qty) 
       FROM orderdetail
   );


--3. Top-selling product per category (1 per category)
--Uses: JOINs, GROUP BY, ROW_NUMBER()
--Tables: category, product, orderdetail
with product_sales as(
select
	c.categoryname,
	p.productname,
	sum(coalesce(o.unitprice,0)*coalesce(o.qty,0)*(1-coalesce(o.discount,0))) as revenue
	from category c
	join product p
	on c.categoryid=p.categoryid
	join orderdetail o
	on p.productid=o.productid
	group by c.categoryname, p.productname
), ranked_products as(
	select
	categoryname,
	productname,
	revenue,
	ROW_NUMBER() OVER(partition by categoryname order by revenue desc) as rn
	from product_sales
)
select
	categoryname,
	productname,
	revenue
from ranked_products
where rn=1
order by revenue desc;


--4. Top 10 customers with the most delayed shipments
--Uses: COUNT(), GROUP BY, JOINs, date comparison
--Tables: salesorder, customer, shipper
select c.custid,c.contactname,
SUM(CASE WHEN s.shippeddate > s.requireddate THEN 1 else 0 END) as delayed_shipments
from customer c
join salesorder s
on c.custid::text=s.custid
group by c.custid,c.contactname
order by delayed_shipments desc
limit 10;