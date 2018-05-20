/* 
	@ Author MMD
	  Date - 07/02/2018
*/
*Set Path;
%let path=/folders/myfolders/MDS/SAS/3XStatistics/;

libname mmd "/folders/myfolders/MDS/SAS/3XStatistics/";

*Load and Store data in workspace;
proc import datafile = '/folders/myfolders/MDS/SAS/3XStatistics/data_c.csv'
out = mmd.data
dbms = csv
replace;
run;

proc print data= mmd.data;
run;

proc means data=mmd.data n nmiss min max range mean median mode var std;
run;

proc cluster data=mmd.data method=SINGLE;
var SmartPhoneUsagePeriod UsagePeriod NumApps Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable Call_Text PriceRange PhoneDistraction;
id Id;
run;

proc tree;
run;

proc cluster data=mmd.data method=ward;
var SmartPhoneUsagePeriod UsagePeriod NumApps Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable Call_Text PriceRange PhoneDistraction;
id Id;
run;

proc tree ncl=4 out=mmd.cluster noprint;
id id;
run;

proc freq data=mmd.cluster;
table cluster;
run;

proc sort data=mmd.data; by id; run;
proc sort data=mmd.cluster; by id ; run;

data mmd.data_2;
merge mmd.data mmd.cluster;
by id;
run;

DATA mmd.data_TRICKED;
SET mmd.data_2; 
CLUSTER=1;
RUN;

DATA mmd.data_3; SET mmd.data_2 mmd.data_TRICKED;
RUN; 

PROC TTEST DATA=mmd.data_3;
var SmartPhoneUsagePeriod UsagePeriod NumApps Brand Color CameraQuality BatteryLife OS Price ValueForMoney Recom_Frnd_Fly Trends PromotionsAvailable Call_Text PriceRange PhoneDistraction;
class cluster;
where cluster = 1 or cluster = 3;
run;

proc export data=mmd.data_2
   outfile='/folders/myfolders/MDS/SAS/3XStatistics/clusteringResults.csv'
   dbms=csv
   replace;
run;

