### This excercise is to play around weather and airline delay data, and making prediction using spark mllib 

1.  Download weather datasets  *2007.csv.gz*  and *2008.csv.gz* from
<http://www1.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/>

	To visualize weather data of  2007 for airport KORD follow <https://public.tableau.com/profile/publish/weather_2007_KORD/Sheet2#!/publish-confirm>
	

2.  Download airline delay history

	<http://stat-computing.org/dataexpo/2009/2007.csv.bz2>

	<http://stat-computing.org/dataexpo/2009/2008.csv.bz2>

3.  Pre-process data using pig from following location
	*scripts/preprocess.pig*

4.  Analyze the correlation between weather and airline dealy.
5.  Use spark mllib, to build a predictive system, the architecture should take current weather as feed and predict airline delay.

[To view results](/doc/iteration_1.md)

This excercise is based on

	http://nbviewer.jupyter.org/github/ofermend/IPython-notebooks/blob/master/blog-part-2.ipynb
	
	http://hortonworks.com/blog/data-science-apacheh-hadoop-predicting-airline-delays/




