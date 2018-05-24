/* 
	@ Author 3X Statistics
	  Date - 24/05/2018
*/
*Set Path;
%let path=/folders/myfolders/MDS/SAS/3XStatistics/;

libname stat "/folders/myfolders/MDS/SAS/3XStatistics/";

*Load and Store data in workspace;
proc import datafile = '/folders/myfolders/MDS/SAS/3XStatistics/data_e.csv'
out = stat.data
dbms = csv
replace;
run;

*Exploring data;
proc means data=stat.data n nmiss min max range mean median mode var std;
run;

*Ok now trying out single method clustering on the main variables;
proc cluster data=stat.data method=single;
var Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable;
id Id;
run;
*The Single methods dendogram looks completely wrong;
*Root-Mean-Square Total-Sample Standard Deviation	3.317835;
*Mean Distance Between Observations	13.21723;


*Ok now trying out Ward method clustering on the main variables;
proc cluster data=stat.data method=ward;
var Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable;
id Id;
run;
*The Ward methods dendogram is difficult to interpret;
*Root-Mean-Square Total-Sample Standard Deviation	3.317835;
*Root-Mean-Square Distance Between Observations	14.83781;


*Ok now trying out Complete method clustering on the main variables;
proc cluster data=stat.data method=complete;
var Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable;
id Id;
run;
*The complete methods dendogram is easy to interpret however its tail is not perfect;
*Root-Mean-Square Total-Sample Standard Deviation	3.317835
*Mean Distance Between Observations	13.21723;


/*
 * We tried these 3 methods and complete linkage seems to be the best method amongst them
 * We will try running these same methods using PCA's most emplaining components
 * Beginning with PCA
 */

proc princomp data=stat.data out=stat.prinCompData;
var Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable ;
run;
* From the scree and variablity plot we conclude that 4 components can explain 90% of the variance;

*Genrating averages;
data stat.data_avgAdd;
set stat.prinCompData;
avg_i=mean(of Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable);
run;

*Checking correlation;
proc corr data=stat.data_avgAdd;
var prin1 avg_i;
run;

/*Pearson Correlation Coefficients, N = 110
*Prob > |r| under H0: Rho=0
* 	Prin1	avg_i
*Prin1	
*1.00000
*0.99997
*<.0001
*avg_i	
*0.99997
*<.0001
*1.00000
*/
*Since the output is super close to one we will standardize;

data stat.data_std;
set stat.data;
avg=mean(of Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable);
minimum=min(of Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable);
maximum=max(of Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable);
array in Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable;
array output new1-new10;
do over output;
output=.;
if in>avg then output =((in-avg)/(maximum-avg));
if in<avg then output =((in-avg)/(avg-minimum));
if in=. then output=0;
if in= avg then output=0;
end;
run;

proc princomp data=stat.data_std out=stat.prinCompData_std;
var new1-new10 ;
run;
*The results are awesome We had a big dam perception bias;


*Ok now trying out Ward method clustering on the Standardised variables;
proc cluster data=stat.prinCompData_std method=ward;
var new1-new10;
id Id;
run;
*The Ward methods dendogram is better;
*Root-Mean-Square Total-Sample Standard Deviation	0.854051
*Root-Mean-Square Distance Between Observations	3.819431;

*Ok now trying out Ward method clustering on the principal components;
proc cluster data=stat.prinCompData_std method=ward;
var prin1-prin4;
id Id;
run;

proc tree ncl=4 out=stat.cluster noprint;
id id;
run;
*The Ward methods dendogram is better;
*Root-Mean-Square Total-Sample Standard Deviation	1.348167;
*Root-Mean-Square Distance Between Observations	3.813191;

*I am now joining my clustering result as a categorical variable to my original data set;

proc sort data=stat.prinCompData_std; by id; run;
proc sort data=stat.Cluster; by id ; run;

data stat.final;
merge stat.prinCompData_std stat.Cluster;
by id;
run;

proc export data=stat.final
   outfile='/folders/myfolders/MDS/SAS/3XStatistics/clusteringResults_24_05_2018.csv'
   dbms=csv
   replace;
run;

*Great So clustering is over saving the results======================================================;
