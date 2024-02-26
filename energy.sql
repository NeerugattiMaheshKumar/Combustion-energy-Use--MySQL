create database energy;
use energy;
create table energy(
FACILITY_ID int,
FACILITY_NAME varchar(100),
FUEL_TYPE varchar(100),
FUEL_TYPE_BLEND varchar(100),
FUEL_TYPE_OTHER varchar(100),
OTHER_OR_BLEND_FUEL_TYPE varchar(100),
REPORTING_YEAR varchar(100),
UNIT_NAME varchar(100),
UNIT_TYPE varchar(100),
COUNTY varchar(100),
COUNTY_FIPS varchar(100),
LATITUDE varchar(100),
LONGITUDE varchar(100),
STATE varchar(100),
ZIP varchar(100),
PRIMARY_NAICS_CODE varchar(100),
PRIMARY_NAICS_TITLE varchar(300),
COGENERATION_UNIT_EMISS_IND varchar(100),
CENSUS_PLACE_NAME varchar(100),
MECS_Region varchar(100),
MMBtu_TOTAL varchar(100),
GWht_TOTAL varchar(100),
GROUPING_ varchar(300));

Drop table energy;

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Data 1.csv' into table energy character set latin1  fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 rows;

select * from energy;

-- 1 MMBtu_TOTAL for Ethane & Ethanol 

select fuel_type, sum(MMBtu_total) from energy  where fuel_type in ('ethane','ethanol (100%)') group by fuel_type;

-- 2Average GWht_TOTAL for 3M Company Facility
select FACILITY_NAME,avg(GWht_TOTAL) from energy where FACILITY_NAME = '3M company' group by FACILITY_NAME;

-- 3 Unit Name trend (1950-2020) Vs GWht_TOTAL
select unit_name, GWht_TOTAL from energy where unit_name between 1950 and 2020;

-- 4 % Share of MMBtu_TOTAL & GWht_TOTAL for each MECS_Region
select mecs_region, (mmbtu_total)*100/sum(mmbtu_total) over() as mmbtu_Perc_of_share,  
(gwht_total)*100/sum(gwht_total) over() as gwht_Perc_of_share from energy group by  mecs_region,MMBtu_TOTAL,GWht_TOTAL;
-- 5 PRIMARY_NAICS_TITLE Vs Facility Name and Fuel Type Stats

select primary_naics_title, count(distinct facility_name)as facilitynamecount, count(distinct fuel_type)as fueltypecount 
from energy group by primary_naics_title;