# FITBIT DATA ANALYSIS 

## DESCRIPTION 

This project Analyzes smart device data to gain insight into how consumers are using their smart devices. The insights gained will help guide the marketing strategy for Bellabeat. 

Both SQL and python  were used to extract and aggregate raw data, while Python and tableau were used for deeper analysis and visualization.

The analysis will answer the following questions:

-What are some trends in smart device usage? 

-How could these trends apply to Bellabeat customers? 

-How could these trends help influence Bellabeat marketing strategy? 

## CODE 
The links to Python and SQL code used for the analysis are posted below.

- [Python analysis code.ipynb](Bellabeat_case_study_3.ipynb)

- [PostgreSQL analysis code.sql](Bellabeat%20Data%20Analysis.sql)

## SKILLS 
-Data cleaning and preprocessing

-Exploratory data analysis (EDA)

-SQL querying and joins/aggregations

-Data visualization

-Statistical analysis

## TECHNOLOGY 

-Python (pandas, matplotlib, and seaborn)

-SQL (PostgreSQL)

-Google sheets

-Google collab

-Tableau 

## RESULTS AND RECOMMENDATIONS

### Key insights 
-On average users wear the tracker for 20 hours a day. Meaning the tracker is active and able to collect user data for most of the day.

-The users wear the tracker consistently. There is no preference on the day of the week when the users wear the tracker.

-Majority (37%)of the users live a sedentary lifestyle, taking less than 5000 average steps a day. Only 6% of users are highly active, taking more than 12500 steps a day.

-On average, users make 7000 steps a day, except on Sundays.(This average daily steps could be skewed by those taking more steps).
![Average steps by day of the week](images/Average%20daily%20steps.png)
Average steps by day of the week showing users take less steps on sunday

-Users are most active between 9am and 8pm, taking the most steps during this time. The steps taken peak at noon, and between 6-7pm.
![Average steps by hour](images/Average%20steps%20taken%20per%20hour.png)
Hourly steps average showing 9am to 8pm as the most active time range.

-Users sleep less than the recommended time(atleast 7 hours of sleep), except on Sunday and Wednesday where they hit more than 7 hours of sleep. They spend an average of 40 minutes in bed without sleeping.

-There is a positive relationship between steps taken and calories expended.The more steps taken, the more calories expended.

## Recommendations 

-The CEO should commission another analysis using the data collected from Bellabeat users that is more representative of Bellabeat clients. The fitbit data is unreliable, lacks demographic information, and only follows 30 users over a short time period. For the best insights, another analysis using data from a longer timeframe and more Bellabeat product users should be conducted.

-The chief creative officer should include a reminder/notification feature in the bellabeat app for users who live a sedentary lifestyle to remind them to take extra steps whenever they are at risk of falling short of the recommended 7000 steps, because the analysis shows they take fewer than 5000 steps a day.

-The chief Creative Officer should design features that encourage bellabeat app users to sleep early or to sleep longer. The findings show the users sleep less than the recommended hours a day. This feature should target to reduce on the average 40 minutes that users spend in bed without sleeping.





