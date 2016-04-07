create external table weather_2007_stg
(
station string,
date_measured string,
metric string,
value int,
t1 string,
t2 string,
t3 string,
time string
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '44' 
STORED AS TEXTFILE LOCATION '/apps/predict/data/weather_2007';

create table weather_2007
(
station string,
date_measured string,
metric string,
value int,
t1 string,
t2 string,
t3 string,
time string
)stored as orc;


insert into weather_2007 select * from weather_2007_stg;
