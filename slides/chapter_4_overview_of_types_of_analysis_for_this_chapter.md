---
title: Overview of types of analysis for this chapter
key: e76db5acf79e577a409c43afa111047b
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch4_1.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch4_1.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:8df1b95bbe
## Review and Preliminary Mortgage Analysis

*** =lower_third
name: Michael Kane
title: Assistant Professor, Yale University

*** =script

Welcome to the final chapter of Scalable Data Processing in R. In this chapter we're going to take a closer look at the mortgage data set. We'll start by adjusting our tables for race and ethnicity by population to compare proportions of people receiving mortgages. Next, we'll show you a quick check to see if there are patterns of missingness in the data. Then we'll see how the mortgage demographic proportions change over time. Finally we'll look at the proportional change in city vs urban mortgage percentage as well as changes in the proportion of people securing federally guaranteed loans. So that you get practice with both bigmemory and iotools, we'll have exercises that use both.


--- type:FullSlide key:ec88f605a9
## A Note About Race and Ethnicity

*** =part1

United States Census Bureau Race and Ethnic Proportions
- American Indian or Alaska Native 0.9%
- Asian 4.8%
- Black or African American 12.6%
- Native Hawaiian or Other Pacific Islander 0.2%
- White 72.4%
- Two or more races 2.9%
- Hispanic or Latino ethnicity 16.3%

*** =script

Here is the U.S. racial and ethnic breakdown according to the United States Census Bureau. 
These percentages do not add up to 100. The remaining race categories, "two or more races" and "other race" are not included in the data set although they make up 2.9% and 6.2% respectively. It should also be noted while the first 6 designations are considered races,  Hispanic or Latino is a designated ethnicity.




--- type:FullSlide key:fe19dac3d4
## Proportional Borrowing

*** =part1

We know that most mortgages went to people who identify as white.

> Is this group borrowing more proportionally?

*** =script

Now that we know the population proportions of the mortgage borrowers race and ethnicity we can take a look at the proportional borrowing among groups.
From the previous sections we know that most mortgages go to people who identify themselves as white. However, we also know that whites make up 72.4% of the population. So, it may not be surprising that this group has the most borrowers.
What we don't know is if whites are borrowing at a higher rate than other groups. That is, is the proportion of white people with a mortgage larger than the proportion of people with mortgages in another group? 



--- type:FinalSlide key:2e0bab5640
## Let's practice!

*** =script

Let's find out.
