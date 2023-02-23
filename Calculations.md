# SQL analysis 
Apart from using Tableau mainly to obtain the calculations, I wanted to also use SQL to practice writing complex queries to obtain the calculations I need. 

## Functions used 
- Creating CTE were used to create temporary tables when accessing rank 
- RANK () and OVER(PARTITION BY) were used to rank each values to have highest output

### TOP 10 Indicators 
``` sql 
SELECT Topic, SUM(Sample_size) AS Total_sample
FROM [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
GROUP BY Topic 
ORDER BY total_sample DESC 
```

### Most reported CVD By Year
``` sql 
WITH rank AS 
(
SELECT Question, Response, Year, 
	SUM(Sample_size) Total_sample, 
	RANK() OVER(PARTITION BY Question ORDER BY SUM(Sample_size) DESC) AS ranking
FROM [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
WHERE Topic = 'Cardiovascular Disease' AND Response IN ('Yes', 'Reported having MI or CHD')
GROUP BY Question, Response, Year)
SELECT *
FROM rank
WHERE ranking = 1;
```

### Highest recorded by state
``` sql 
WITH rank_state AS 
(
SELECT Locationdesc, Topic, 
	SUM(Sample_size) AS Total_sample, 
	RANK() OVER(PARTITION BY Locationdesc ORDER BY SUM(Sample_size) DESC) AS ranking
FROM [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
GROUP BY Locationdesc, Topic) 
SELECT * 
FROM rank_state
WHERE ranking = 1
ORDER BY Total_sample DESC; 
```
### Most reported by breakout category
``` sql 
WITH rank_breakout AS
(
SELECT Break_Out_Category, Break_Out, 
	SUM(Sample_size) AS Total_sample, 
	RANK() OVER(PARTITION BY Break_Out_Category ORDER BY SUM(Sample_size) DESC) AS ranking
FROM [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
GROUP BY Break_Out_Category, Break_Out) 
SELECT * 
FROM rank_breakout
WHERE ranking = 1; 
```
