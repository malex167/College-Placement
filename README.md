# Executive Summary
Using R Studio, the machine learning algorithms Random Forest and XGboost were utilized towards examining college admissions for prospective graduate students targeting programs in Marketing, HR, or Finance at Jain University Bangalore via the campus recruitement data set gathered from Kaggle. Overall, the Random Forest model produced greater accuracy towards predicting whether someone was admitted into college. Accordingly, for prospective students, I would advice that using one's own information in regard to the variables presented in the model serves as a good indicator as to whether or not admissions is likely. 

## Problem

For individuals looking to pursue higher education, applying to college can be a daunting task. Through an analysis of various contributing factors potentially influencing college admissions, a model predicting acceptance would be a worthwhile tool for an individual to utilize and assess whether their current credentials are viable towards getting accepted or if additional work might be required. 

## Methodology

The primary variable in question from the data set is "status" indicating whether an individual placed or didn't place when applying to schools. Accordingly, this served as the predicted variable while the remainder of the data set in question were the predictors. Machine learning algorithms, via the ensemble methods Random Forest and XGboost, were targeted as high performing systems capable of developing classification models. This was achieved, for both machine learning methods, by performing a 70:30 split of the data in R Studio, training the respective model with the majority of the split, testing the model's accuracy via the remaining data portion along with a confusion matrix, and then finally a visualization towards how influential each variable was on their respective model. 

## Skills

1. R Studio
2. Machine Learning Models (Random Forest)
3. Data Wrangling
4. Data Visualization


## Results and Recommendation

From the XGboost model, as shown in Figure 1 below, the largest contributing variables towards predicting college placement (in descending order are) scoring percentage of the 12th grade, scoring percentage of the 10th grade, scoring percentage in their undergraduate degree, and scoring percentage in an MBA program. 

<img width="545" height="545" alt="image" src="https://github.com/user-attachments/assets/1568c689-29e2-499e-8be3-9e535bd4b4b5" />

**Figure 1: XGboost plot of variable importance.**

From the resulting confusion matrix, shown in Figure 2 below, the model was 81.58% accurate in predicting the testing data set after utilizing the training data set. 

<img width="545" height="213" alt="image" src="https://github.com/user-attachments/assets/795520a7-9628-499e-9773-9fa4e7cdea71" />

**Figure 2: Confusion matrix and corresponding accuracy with confidence interval for XGboost model.**

The Random Forest model, with variable significance shown in Figure 3 below, indicates that virtually identical results to that of the XGboost model in which scoring percentage for the 12th grade was the largest indicator of admissions followed by equal weighting in undergraduate degree and 10th grade scoring percentages, this is followed by the scoring percentage when receiving an MBA. 

<img width="545" height="545" alt="image" src="https://github.com/user-attachments/assets/ae3d4c5c-f0f6-4fd1-b021-9851f9bb927b" />

**Figure 3: Visual plot of largest contributing factors in Random Forest model.**


The resulting confusion matrix, shown in Figure 4 below, concludes that the Random Forest model was 86.84% accurate in predicting college admissions based on the training data set when then applied to the testing data set. 

<img width="520" height="217" alt="image" src="https://github.com/user-attachments/assets/22728a19-8664-4687-822e-a46755847331" />

**Figure 4: Confusion matrix and corresponding accuracy with confidence interval for Random Forest model.**

Overall, the Random Forest model proved to be the superior alternative when assessing potential college placement at Jain University Bangalore's graduate programs in Marketing, HR, or Finance. Accordingly, this model serves as a better alternative when trying to determine if one's credentials are potentially adequate when applying. 

## Next Steps

The analysis conducted provided the framework for assessing potential college admissions, additional work could benefit others on a larger scale if similar practices and methodologies were applied to other universities of interest for a given prospective student. Additionally, tuning on either model yields the potential of greater accuracy and reduced error. 
