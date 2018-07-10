## Customer Segmentation - The different ways we use our smartphones

> *The different ways we use our smartphones* - The data has been collected from random people around the globe.  The main Business problem that is being solved here is  *to cluster our customers in order to understand what kind of cellphone do our customers need or which segment should we target*

#### The Final Script is [here](https://github.com/mmd52/3XStatistics/blob/master/3XStats_Final_ToPresent.ipynb)
#### The PPT is [here](https://github.com/mmd52/3XStatistics/blob/master/PPT.pdf)

### What was done
1. In order to start we need some data. We obtained the data by taking a survey of 18 questions. The survey was sent to different people across the globe, although most of the responses came mainly from India and Italy we decided to go ahead.
The survey sits [here](https://docs.google.com/forms/d/e/1FAIpQLSeMWT5EjAZf5cbvTpESTGIQn-WCaNTSVJsgaQfr7I8YJevusw/viewform) 
2. Well in order to segment clusters to identify what each segment wants in a phone we need to do ****clustering****. And before doing clustering we need clean data.
3. The data we obtained from the survey needed some cleaning which I did partly in excel and partly in python. The excel cleaning steps are [here](https://github.com/mmd52/3XStatistics/blob/master/DataCleaningExcelSteps.md). The python cleaning script is [here](https://github.com/mmd52/3XStatistics/blob/master/PythonArea/DataCleaning_3XStats.ipynb). The data re arrangement script in python is [here](https://github.com/mmd52/3XStatistics/blob/master/PythonArea/DataRearrangement_3XStats.ipynb).
4. After attaining clean data it was time to understand the data. *(Everything beyond this portion was done in SAS)*
5. To understand the data we made some basic visualisations and a short summary of the data.
6. The clustering was to be done mainly on the variables we got from the likert scale, the other variables would just act as a assistance to the explanation of the clusters. These variables are Brand, Color, CameraQuality, BatteryLife, OS, Price, ValueForMoney, Recom_Frnd_Fly, Trends, PromotionsAvailable.
7. On making a correlation plot we saw that all the correlations were positive and that they kind of were close to 1. This raised a flag of ****perception bias**** in our minds.
8. In order to verify the assumption of input bias on our variables we ran a ****Principal component analysis****. The first thing we noticed was that the first component had only positive values and could explain on its own 70% of the variablity. This raised the second flag for perception bias.
9. Now in order to confirm the perception bias we created an average value per users response and made a correlation matric of it with the first principal component. The output, all values were positive and were nearly 1. This confirmed that we had perception bias in our data.
10. What is the ****Perception Bias****? - Say people from 2 countries had to rate the taste of the coffee they had on a scale from 1-10. Probably the people from the first country no matter how good the coffee is they rate it 8, because in their minds 8 is the highest. Whereas people from another country rate it 10, because they believe 10 is the best. This phenomenon of people having different opinions in the same scale can be said to be as perception bias.
11. Ok now that we know there is perception bias, to remove it we standardie our data.
12. After standardising the data we notice that now the first component has both negative and positive values and that it explains now only 37% of the bias. This means we have been able to get rid of the perception bias. the top 4 components explain 75% of the variablity.
13. Great data is ready time for clustering, so here are the various combinations we tried with clustering techniques
``` 
a) Complete linkage method with standardised data 
b) Complete linkage method with top 4 components of PCA derived from standardised data
c) Wards method with standardised data
d) Wards method with top 4 components of PCA derived from standardised data
```
14. The best results were yielded by Wards method with top 4 components of PCA derived from standardised data.
15. Whats is ****Wards Method**** - Ward's method is simple it creates an optimal function to reduce variance within the cluster and increase variance between clusters. It is a highly effectve method, however it takes more time and is computationally heavy.
16. Great we have 4 clusters, but why do we have these 4 clusters? What makes them different from the population?
17. In order to do this we merge the cluster data with the population and run t-tests to understand why the clusters are different from the population.
18. So in SAS say we ran the T-test for cluster 1 and population. It generates output for each variable in which we first check the equality of variance test. If this is significant we know the variances are unequal and rely on the Satterthwaite test. I the equality of variance test is not significant means my variance is equal and we look at the Pooled test.
19. Once we select the test we see the significance and if it is significant, means that variable plays an important role in definition of that cluster. But how important it is we come to know by seeing the difference of mean if this is positive, that means that people in the cluster rely on the variable and if negative means people definitely do not refer to the variable.
20. This way we found intepretations of al our clusters, exaplained neatly with radar graphs [here](https://github.com/mmd52/3XStatistics/blob/master/3X.pdf)
21. The interpretation with external variables was done in tableau and sits [here](https://github.com/mmd52/3XStatistics/blob/master/TableauPlayArea/3X.pdf)