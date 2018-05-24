## 3X Statistics Project

3X Statistics is a statistics project created by 4 students completing their Masters in Data Science at the Bologna Business School

> The topic for 3X is *The different ways we use our smartphones*. The data has been collected from random people around the globe.  The main Business problem that is being solved here is  *to cluster our customers in order to understand what kind of cellphone do our customers need or which segment should we target*

The project members are

* Mohammed Topiwalla
* Fernanda De Oliveira Guimarae
* Patricia Londono
* Abraham Chandy

##### Thought
> Whatever data goes into clustering needs to be numeric.
> The professor used few columns for clustering and few to explain those clusters.
> He finally used the hierarchical clustering (Single linkage and ward).
> He then compared each cluster with the entire population to see what makes the cluster unique.

 
#### In order to recreate this -
 
* I wrote some code in python (please look at it and comment on the column's selected by me for clustering and the columns left out for explanation) -> https://github.com/mmd52/3XStatistics/blob/master/DataRearrangement_3XStats.ipynb
* Next like the professor did I ran clustering using single and ward method. And got better results using ward method ->  https://github.com/mmd52/3XStatistics/blob/master/NitroScript.sas
* The new data file we will refer to is known as data_d 

#### What is expected? 
* Use PCA and see if we get a better clustering result
* Label rows with cluster names and for each cluster understand important variables defining the cluster. Simultaneously comparing each cluster with the population
* Use columns that we left out to understand what defines the cluster using vis tools like Tableau/Power BI Etc Etc