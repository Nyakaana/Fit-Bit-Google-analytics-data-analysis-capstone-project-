/*
 BellaBeat Data analysis 
 
 For each dataset,extract the columns, understand the datatypes, find the number of unique users, 
 check duplicates, and check missing values
 */


--Extract the column names and their corresponding data types
select column_name,data_type
from information_schema.columns
where table_schema = 'Bellabeat'
and table_name = 'dailyactivity_merged_april';


-- Number of unique users 
select count(distinct "Id")
from "Bellabeat".dailyactivity_merged_april;

-- check rows with missing ID
select count(*) as total_rows,
count(*)- count('Id') as missing_id
from "Bellabeat".dailyactivity_merged_april

-- check the march activity data for the number of unique users 
select count(distinct "Id")
from "Bellabeat".dailyactivity_merged_march;

-- create a new table joining the March and April daily Activity datasets 
create table activity_combined as
select *
from "Bellabeat".dailyactivity_merged_april
union all 
select *
from "Bellabeat".dailyactivity_merged_march;

--Check the merged dataset
select *
from "Bellabeat".activity_combined;

-- change the datatype in activitydate column to date 
alter table "Bellabeat".activity_combined 
alter column "ActivityDate"
type date 
using to_date("ActivityDate",'MM/DD/YYYY');

-- extract the day of the week from the date and create a new  column
alter table activity_combined 
add column week_day varchar(10);

update activity_combined
set week_day = btrim(to_char("ActivityDate",'Day'))

-- calculate the time the user wore the tracker each day 
alter table "Bellabeat".activity_combined 
add column time_active int;

update activity_combined
set time_active = "VeryActiveMinutes" +
"FairlyActiveMinutes"+
"LightlyActiveMinutes"+
"SedentaryMinutes";

-- The average hours the tracker is active 
select avg(time_active)/60
from activity_combined
 

-- categorize the users by the average number of steps taken per day 

alter table activity_combined 
add column average_steps_per numeric(10,2);

-- find the average steps taken each day for the users 
with average_steps as (
select "Id"
,avg("TotalSteps") as average_steps_per_day
from "Bellabeat".activity_combined
group by "Id")

update "Bellabeat".activity_combined as c
set average_steps_per =  s.average_steps_per_day
from average_steps as s
where c."Id"=s."Id";

-- List the top 5 most active users and the top 5 least active users  based on average steps
select distinct "Id",average_steps_per as "Average daily steps"
from "Bellabeat".activity_combined
order by "Average daily steps" desc
limit 5;

select distinct "Id", average_steps_per as "Average daily steps"
from "Bellabeat".activity_combined
order by "Average daily steps" 
limit 5


-- Average steps taken on each day of the week 

select week_day, round(avg("TotalSteps")) as "Average steps taken"
from  "Bellabeat".activity_combined
group by week_day
order by "Average steps taken" desc

-- Categorize users by the average steps taken daily 
create table physical_activity_category as
select distinct "Id",
case
	when average_steps_per < 5000 then 'sedentary'
	when average_steps_per between 5000 and 7499 then 'Low Active'
	when average_steps_per between 7500 and 9999 then 'Somewhat Active'
	when average_steps_per between 10000 and 12499 then 'Active'
	else 'Highly Active'
end as Level_of_physical_activity
from "Bellabeat".activity_combined;

-- count the number of users in each category 
SELECT
    level_of_physical_activity,
    COUNT(DISTINCT "Id") AS number_of_users,
    ROUND(100.0 * COUNT(DISTINCT "Id")
        / SUM(COUNT(DISTINCT "Id")) OVER (),
        2
    ) AS percentage
FROM "Bellabeat".physical_activity_category
GROUP BY level_of_physical_activity
ORDER BY percentage DESC;


-- Analyze the sleep dataset 
select *
from sleepday_merged_april 

select count(distinct "Id")
from sleepday_merged_april;

-- Number of observations in the sleep dataset 
select count(*)
from sleepday_merged_april;

-- convert the sleepDay column to date datatype 
alter table sleepday_merged_april 
alter column "SleepDay"
type date
using to_date("SleepDay", 'mm/dd/yyyy')

-- Extract the week day from the sleepday column and create a new column week_day
alter table sleepday_merged_april 
add column "week_day" varchar(10);

update sleepday_merged_april 
set week_day = btrim(to_char("SleepDay",'Day'));

-- Find the time in bed without sleep
alter table sleepday_merged_april 
add column "time_in_bed_no_sleep" int;

update sleepday_merged_april
set time_in_bed_no_sleep = "TotalTimeInBed" - "TotalMinutesAsleep";

-- What is the average sleep for each user in the dataset 
alter table sleepday_merged_april 
add column "average_sleep_time" numeric(4,2);

ALTER TABLE sleepday_merged_april
ALTER COLUMN average_sleep_time
TYPE NUMERIC(7,2);

--The average daily minutes of sleep 
with average_sleep as(
select distinct "Id", avg("TotalMinutesAsleep") 
over(partition  by "Id")
as average_sleep_time
from sleepday_merged_april
)

update sleepday_merged_april as t
set average_sleep_time =  s.average_sleep_time
from average_sleep as s
where s."Id" = t."Id";

--The most and least hours of sleep 
select distinct "Id", round(average_sleep_time/60.0,1) as highest_average_sleep
from sleepday_merged_april
order by highest_average_sleep desc
limit 5;
 
select distinct "Id", round(average_sleep_time/60.0,1) as Lowest_average_sleep
from sleepday_merged_april
order by lowest_average_sleep 
limit 5;

-- Average sleep per  day of the week. 
select week_day, round(avg("TotalMinutesAsleep")/60,1) as average_hours_asleep
from sleepday_merged_april
group by week_day 
order by average_hours_asleep desc;

-- Explore the daily steps dataset and analyze the time of the day when users are most and least active
select count(distinct "Id")
from hourlysteps_merged_april;

--create columns for sleep_date and sleep_time
alter table hourlysteps_merged_april 
add column sleep_date date,
add column sleep_time time;

update hourlysteps_merged_april
set sleep_date = to_timestamp("ActivityHour",'MM/DD/YYYY HH12:MI:SS AM')::date,
sleep_time = to_timestamp("ActivityHour",'MM/DD/YYYY HH12:MI:SS AM')::time;

--The average steps taken on each hour of the day 
select sleep_time as time_of_day, 
round(avg("StepTotal")) as average_steps
from hourlysteps_merged_april
group by time_of_day 
order by average_steps desc;


-------------------------------------------------END------------------------------------------------------------------------