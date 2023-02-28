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
![Top CHI](https://user-images.githubusercontent.com/114310913/221951365-b1121c5a-ff87-43aa-9c2d-cde6ea5ff98f.png)


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
![Most Report](https://user-images.githubusercontent.com/114310913/221951405-5d35f9e8-b8a6-4186-8936-71b8f18fbc99.png)


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
![State](https://user-images.githubusercontent.com/114310913/221951491-d578b59f-cac5-432a-a74d-dc254a6a6d68.png)

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
![Breakout](https://user-images.githubusercontent.com/114310913/221951534-5d48795a-b98e-4624-8dda-9007ac391c61.png)


