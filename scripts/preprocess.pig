register 'util.py' USING jython as util;

-- Helper macro to load data and join into a feature vector per instance
DEFINE preprocess(year_str, airport_code) returns data
{
	-- load airline data from specified year (need to specify fields since it's not in HCat)
	airline = load '/workout/airline/$year_str.csv' using PigStorage(',') as (Year: int, Month: int, DayOfMonth: int, DayOfWeek: int, DepTime: chararray, CRSDepTime, ArrTime, CRSArrTime, Carrier: chararray, FlightNum, TailNum, ActualElapsedTime, CRSElapsedTime, AirTime, ArrDelay, DepDelay: int, Origin: chararray, Dest: chararray, Distance: int, TaxiIn, TaxiOut, Cancelled: int, CancellationCode, Diverted, CarrierDelay, WeatherDelay, NASDelay, SecurityDelay, LateAircraftDelay);

	-- keep only instances where flight was not cancelled
	airline_flt = filter airline by Cancelled == 0;

	-- Keep only fields I need
	airline2 = foreach airline_flt generate Year as year, Month as month, DayOfMonth as day, DayOfWeek as dow,
    			Carrier as carrier, Origin as origin, Dest as dest, Distance as distance, 
    			DepTime as time, DepDelay as delay,
    			util.to_date(Year, Month, DayOfMonth) as date;

	-- load weather data
	weather = load '/workout/weather/$year_str.csv' using PigStorage(',') as (station: chararray, date: chararray, metric, value, t1, t2, t3, time);

	-- keep only TMIN and TMAX weather observations from ORD
	weather_tmin = filter weather by station == 'USW00094846' and metric == 'TMIN';
	weather_tmax = filter weather by station == 'USW00094846' and metric == 'TMAX';
	
	joined = join airline2 by date, weather_tmin by date, weather_tmax by date;
        joined2 = filter joined by dest == '$airport_code';
	$data = foreach joined generate delay, month, day, dow, util.discretize_tod(airline2::time) as tod, distance, weather_tmin::value as temp_min, weather_tmax::value as temp_max; 
};

ORD_2007 = preprocess('2007', 'ORD');
--rmf ord_2007;
store ORD_2007 into '/workout/ord_2007' using PigStorage(',');

ORD_2008 = preprocess('2008', 'ORD');
--rmf ord_2008;
store ORD_2008 into '/workout/ord_2008' using PigStorage(',');
