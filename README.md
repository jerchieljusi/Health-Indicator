# Health Indicator

## About the data 
The Behavioral Risk Factor Surveillance System (BRFSS) is the nation’s premier system of health-related telephone surveys that collect state data about U.S. residents regarding their health-related risk behaviors, chronic health conditions, and use of preventive services. Established in 1984 with 15 states, BRFSS now collects data in all 50 states as well as the District of Columbia and three U.S. territories. BRFSS completes more than 400,000 adult interviews each year, making it the largest continuously conducted health survey system in the world. 

This dataset in particular was last updated in October 2022, and has 460856 rows. Since this is a big dataset, I used Microsoft SQL Server for cleaning and formatting before using Tableau to calculate and create visualizations. 

You can access the dataset [here](https://chronicdata.cdc.gov/Behavioral-Risk-Factors/Behavioral-Risk-Factor-Surveillance-System-BRFSS-P/dttw-5yxu/data) 

## What are we looking for? 
- What are the leading chronic illnesses in the US? 
- What factors contributed to the highest recorded chronic illness?
- What's the leading chronic illness by state?
- Who reported most in each break out category?

## Findings
- Cardiovascular disease (CVD), arthritis, and asthma are the leading illnesses in the United. CVD leads with 101M sample size from 2011 to present. 
- Individuals were asked various questions, and 5.9M were reported to being told/having CVD. 
- CVD is the highest amongst all the states, with New York having the highest record with 4M followed by Nebraska and Kansas. 
- For each breakout category, those in the groups of 65+, college graduate, female, $50,000+ income, and White, non-Hispanic had the highest report recorded across all topics. 

## Data Wrangling 
- I used the Import Wizard on Microsoft SQL to import the data. Due to the large size of it, the schema was altered when being uploaded. I had to fix the format and schema to what's appropriate before analysis. 
- I replaced the NULL values with 0 for the integer values. 

## Tableau 
- I created a dashboard using the Navigation tool to let viewers browse my data while having only one sheet on the dashboard. 

You can access the dashboard [here](https://public.tableau.com/views/ChronicHealthIndicator/Explore?:language=en-US&:display_count=n&:origin=viz_share_link)!

<div class='tableauPlaceholder' id='viz1677177950805' style='position: relative'><noscript><a href='#'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ch&#47;ChronicHealthIndicator&#47;Explore&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='ChronicHealthIndicator&#47;Explore' /><param name='tabs' value='yes' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ch&#47;ChronicHealthIndicator&#47;Explore&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>              
