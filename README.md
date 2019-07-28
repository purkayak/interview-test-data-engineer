
--------------
Choice of DB used MySQL
--------------


1. The data for this exercise can be found on the `data.zip` file. Can you describe the file format?
File format is pipe delimited. All files have additional | at end of line. Hence used |\n as End of Line.

2. Code you scripts to load the data into a database.
Created new set of table for the transaction database with size based on data profile

3. Design a star schema model which the data should flow.
Desgined a Star Schema for Order details. 

4. Build your process to load the data into the star schema 
Scripts included for loading star schema

**Bonus** point: 
- add a fields to classify the customer account balance in 3 groups 
Included a new field.
- add revenue per line item 
Included a new field
- convert the dates to be distributed over the last 2 years
Added partition to Fact table on o_orderdate

5. How to schedule this process to run multiple times per day?
 
**Bonus**: What to do if the data arrives in random order and times via streaming?
Schedling can be attained through a cron job or shell scripting.
Or if there are other tools being used such as Talend (open source free tier), job scheduling can be attained.

6. How to deploy this code?

**Bonus**: Can you make it to run on a container like process (Docker)? 

Data Reporting
-------

---Seperate file created for the queries.

One of the most important aspects to build a DWH is to deliver insights to end-users. Besides the question bellow, what extra insights you can think of can be generated from this dataset?

Can you using the designed star schema (or if you prefer the raw data), generate SQL statements to answer the following questions:

1. What are the top 5 nations in terms of revenue?

2. From the top 5 nations, what is the most common shipping mode?

3. What are the top selling months?

4. Who are the top customer in terms of revenue and/or quantity?

5. Compare the sales revenue of on current period against previous period?


Data profilling
----   
Data profiling are bonus.
Tables have been crated based on Data profiling

What tools or techniques you would use to profile the data?
You can either use Talend Or Informatica for data profiling.
 
What results of the data profiling can impact on your analysis and design?   
Based on results, you can change partitioning strategy. Also, identify the correct index format or distribution (clustering) of the data for optimal performace of queries.



Architecture
-----
If this pipeline is to be build for a real live environment.
What would be your recommendations in terms of tools and process?
Woudl  recommend schedulign of jobs. Back up strategy for maintenance. Also implement processes in place to load data with quality.

Would be a problem if the data from the source system is growing at 6.1-12.7% rate a month?
You might want to consider changing partition stratey in future based on data growth.


