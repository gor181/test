---
title: Are the data missing at random?
key: e9eb2919148269d719cace8cb52203cc
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch4_2.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch4_2.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:7374b0b6f2
## Are the data missing at random?

*** =lower_third
name: Michael Kane
title: Assistant Professor, Yale University

*** =script

Along with the overlapping racial and ethnic demographic categories, we also have missing data. This issue is pervasive in data science and can be difficult to deal with properly. In this chapter we'll introduce approaches to analyzing missing data and show how you can deal with missing data in bigmemory and iotools.



--- type:FullSlide key:bbf2f09380
## Types of Missing Data

*** =part1

1. Missing Completely at Random (MCAR): 
    - There is no way to predict which values are missing.
    - Can drop missing data.
2. Missing at Random (MAR):
    - Missingness is dependent on variables in the data set.
    - Use multiple imputation to sample what values could be.
3. Missing Not at Random (MNAR):
    - Not MCAR or MAR.
    - Deterministic relationship between variable.

*** =script

Generally speaking, missing data falls into one of three categories: missing completely at random, missing at random, and missing not at random. When data are missing completely at random there is no way to predict where in the data set we'll see a missing value. In an analysis this can often be handled by simply dropping rows of a data set with missing values.

When missingness is associated with other variables we call it missing at random. This name is a misnomer. We really mean that conditioned on some of the variables in the data set, the data are missing completely at random. To deal with MAR data we generally predict values for the missing data several times to create multiple data sets that capture the statistical structure of the relationships between the variables and then perform an analysis on the data sets. This procedure is called multiple imputation.

The last category, missing not at random is for the case where data is neither MAR nor MCAR. It is usually caused by deterministic relationships between missingness and other measurements.




--- type:FullSlide key:8756dd6914
## A Quick Check for MAR

*** =part1

Full treatment of missingness is beyond the scope of this course.

We will check to see if it's plausible data are MCAR and drop missing values.

Steps:
1. Recode a column with missingness zero if not missing and one if missing.
2. Regress other variables onto it using a logistic regression.
3. Significant p-value indicate MAR.
4. Repeat for other columns with missingness.

Some p-values can be significant by chance.

*** =script

A full analysis of missing data and strategies for dealing with them are beyond the scope of this course. There is no direct way to check if the data are MCAR, so, we are going to check if the data are MAR, and if they are not, we will assume that the data are missing completely at random.

To check if your data are MAR, take each column with missingness and recode it as one if it is missing and zero otherwise. Then regress each of the the other variables onto it using a logistic regression. A significant p-value indicates an association between the regressor and missingness, meaning your data are MAR. If none are significant, then it's plausible that the data are missing completely at random. 

Because you are testing multiple hypotheses you will likely get some p-values that are small by chance. As a result you may need to adjust your cutoff for significance based on how many regressions you perform.


--- type:FullSlide key:49f2e7a3e2
## MAR Quick Check Example

*** =part1

```{r}
> # Our dependent variable
> is_missing <- rbinom(1000, 1, 0.5)

> # Our independent variables
> data_matrix <- matrix(rnorm(1000*10), nrow = 1000, ncol = 10)

> # A vector of p-values we'll fill in
> p_vals <- rep(NA, ncol(data_matrix))

> # Regress each independent variable onto the dependent variable
> for (j in 1:ncol(data_matrix)) {
+   s <- summary(glm(is_missing ~ data_matrix[,j]), family = binomial)
+   p_vals[j] <- s$coefficients[2, 4]
+ }
 
> # Show the p-values
> p_vals
 [1] 0.5930082 0.7822695 0.7560343 0.3689330 0.8757048 0.8812320 0.8281008
 [8] 0.4888898 0.4781299 0.5655739

```

*** =script

This slide shows how to look for MAR data using R. We create a binary is_missing variable with 1,000 elements indicating where values are missing. To generate 10 independent variables, we randomly sample them from a normal distribution and place them in a matrix, with 1,000 rows.
Then we regress each column in the matrix onto the is_missing variable with
a logistic regression, using R's glm function. The p-value for this variable is in the regression summary, in the coefficients matrix, at position 2, 4.

Each of these p-values is stored and outputted to the screen. In this case, all of the p-values are large indicating that there is not a significant association between the regressors and missingness. We therefore have found that the data are not MAR. This should not come as a surprise though, since all of the data we used were generated at random.

--- type:FinalSlide key:75ec91f30d
## Let's practice!

*** =script

Now you'll check to see if the mortgage data set has data missing at random.
