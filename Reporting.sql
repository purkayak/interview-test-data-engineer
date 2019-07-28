/*
Data Reporting
-------
One of the most important aspects to build a DWH is to deliver insights to end-users. Besides the question bellow, what extra insights you can think of can be generated from this dataset?

Can you using the designed star schema (or if you prefer the raw data), generate SQL statements to answer the following questions:

1. What are the top 5 nations in terms of revenue?

2. From the top 5 nations, what is the most common shipping mode?

3. What are the top selling months?

4. Who are the top customer in terms of revenue and/or quantity?

5. Compare the sales revenue of on current period against previous period?

*/
-- What are the top 5 nations in terms of revenue?
select top 5 * from  (
select d_nation , sum(l_revenue) from 
f_order_dtl f, d_nation d
where f.n_nationid = d.n_nationid
group by d_nation
order by 2 desc
);

 --From the top 5 nations, what is the most common shipping mode?
select top 1 l_shipmode
 from (
		select l_shipmode , count(1) from 
		(
			select top 5 * from  (
			select n_nation , sum(l_revenue) , n_nationid from 
			f_order_dtl f, d_nation d
			where f.n_nationid = d.n_nationid
			group by n_nation
			order by 2 desc
		)  t, f_order_dtl t2
		where t.n_nationid = t2.n_nationid
		group by 1
		order by 2 desc
);

--What are the top selling months

select top 10 * from (
			select MONTH(o_orderdate), sum(l_revenue)
			from 
			f_order_dtl f
			where 
			group by 1
			order by 2 desc
);


--Who are the top customer in terms of revenue and/or quantity?
select top 5 * from  (
			select c_name , sum(l_revenue)  from 
			f_order_dtl f, d_customer d
			where f.c_custid = d.c_custid
			group by c_name
			order by 2 desc
) 

--Compare the sales revenue of on current period against previous period
WITH yr_sales as
(
			select YEAR(o_orderdate) yr, sum(l_revenue) revenue
			from 
			f_order_dtl f
			group by 1
)
select a.yr, b.yr as prv_yr, 
a.revenue as curr_revenue,
b.revenue as prev_revenue,
(NVL(a.revenue,0) - NVL(b.revenue,0) ) as diff_revenue
 from 
yr_sales a , yr_sales b
where a.yr = b.yr - 1