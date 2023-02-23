-- The way the data got imported messed up the data type so this is me just reformatting them

Select Replace(Sample_size,',','') as Sample_size
From [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators];

UPDATE [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
SET Sample_Size = Replace(Sample_size,',','')

ALTER TABLE [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
ALTER COLUMN Sample_size INT; 

ALTER TABLE [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
ALTER COLUMN Data_value NUMERIC(6,2);

ALTER TABLE [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
ALTER COLUMN Confidence_limit_Low NUMERIC(6,2);

ALTER TABLE [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
ALTER COLUMN Confidence_limit_High NUMERIC(6,2);

-- Dropping columns I do not need 

ALTER TABLE [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
DROP COLUMN Data_value_unit, Data_value_type, Data_Value_Footnote_Symbol, Data_Value_Footnote, DataSource, ClassId, TopicId, LocationId, BreakoutID, BreakoutCategoryID, QuestionID, ResponseID, GeoLocation

-- Updating any null values with 0 

SELECT Data_value
FROM [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
WHERE Data_value IS NULL; 

UPDATE [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
SET Data_value = ISNULL(Data_value, 0)

UPDATE [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
SET Confidence_limit_Low = ISNULL(Confidence_limit_Low, 0)

UPDATE [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
SET Confidence_limit_High = ISNULL(Confidence_limit_High, 0)

SELECT DISTINCT(Break_Out)
FROM [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]

SELECT *
FROM [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
WHERE Question = 'Adults who have ever been told they have asthma (variable calculated from one or more BRFSS questions)'

-- TOP 10 Indicators 

SELECT Topic, SUM(Sample_size) AS Total_sample
FROM [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]
GROUP BY Topic 
ORDER BY total_sample DESC 

-- Most reported CVD by the Year

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

-- Highest illness recorded by state

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

-- Most reported by breakout category 
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

SELECT COUNT(*) 
FROM [Chronic Health Indicator].[dbo].[BRFSS__Table_of_Chronic_Health_Indicators]




		



