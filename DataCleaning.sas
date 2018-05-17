/* 
	@ Author MMD
	  Date - 07/02/2018
*/
%let path=/folders/myfolders/MDS/SAS/3XStatistics/;

libname MMD_Dir "/folders/myfolders/MDS/SAS/3XStatistics/";

proc import datafile = '/folders/myfolders/MDS/SAS/3XStatistics/data.csv'
out = data
dbms = csv
replace;
run;

proc print data=MMD_Dir.data;
run;

PROC SGPLOT DATA=MMD_Dir.data;
        HBAR SmartPhoneBrand;
RUN;
