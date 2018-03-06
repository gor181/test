---
title: What is Scalable Data Processing?
key: 81dafd945346b18dd9d772294eefc4f8
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch1_1.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch1_1.mp4
transformations:
    translateX: 50
    translateY: 0
    scale: 0.9

--- type:TitleSlide key:dc4dde4387
## What is Scalable Data Processing?

*** =lower_third
name: Michael J. Kane and Simon Urbanek
title: Instructors, DataCamp

*** =script

Welcome to Scalable Data Processing in R. 
I'm Michael Kane an Assistant Professor at Yale University 
and I'm Simon Urbanek an R-core member and Lead Inventive Scientist at AT&T Labs research. 
With the advent of Big Data in every field, you may need to analyze increasingly large datasets. In this class, we'll teach you some of the tools and techniques for cleaning, processing, and analyzing data that may be too large for your computer. 
The approaches we'll show you are scalable in the sense that they are easily parallelized and work on discrete blocks of data. Scalable code lets you make better use of available computing resources and allows you to use more resources as they become available.


--- type:FullSlide key:e3e150f7dc
## R Stores Variables in RAM

*** =part1
![](computer-architecture-model.png)

*** =script

When you create a vector, data.frame, list, or environment in R it is stored in the computer memory, RAM. RAM stands for Random Access Memory it is where R keeps the variables it creates. Modern personal computers usually have between 8 and 16 GB of RAM. Data sets can be much bigger than this though. At AT&T Labs we routinely process hundreds of terrabytes of data in R.

In this course we won't process data sets that big but we will show you some of the tools we use to create analyses that can be run on data sets that may be too big for your computer's memory, but less than the amount of hard drive space you have available.



--- type:FullSlide key:84c5908234
## How Big Can Variables Be?

*** =part1

"R is not well-suited for working with data larger than 10-20% of a computer's RAM." - The R Installation and Administration Manual

- Swapping can be inneficient

- Scalable solution
    - move a subset into RAM
    - process the subset
    - keep the result and discard the subset


*** =script

According to the R Installation and Administration Manual, "R is not well-suited for working with data larger than 10-20% of a computer's RAM." 
When your computer runs out of RAM, data that is not being processed is moved to the disk until it is needed again. This process is called swapping. If there is not enough space to swap, the computer may simply crash. Since the disk is much slower than RAM, this can cause the execution time - which is the time needed to perform an operation - to be much longer than expected. The scalable solutions we'll show here move subsets of data into RAM, process them, and then discard them - keeping the result or writing it to the disk. This is often orders of magnitude faster than letting the computer do it and it can be used in conjunction with parallel processing or even distributed processing for faster execution times for larger data.


--- type:FullSlide key:0ad5ab41cb
## Why is my code slow?

*** =part1

It takes time to move data from the disk to RAM, contributing to the execution time. {{1}}

The complexity of the calculations you want to perform also contributes to execution time. {{2}}

You need to carefully consider disk operations as well as the complexity of the operations you want to perform to write fast, scalable code. {{3}}

*** =script

If the computation you want to perform is complex - meaning it involves many operations each of which takes a long time to perform - this can also contribute to execution time. 
Summaries, tables, and other descriptive statistics are much easier to compute compared to tasks like fitting a random forest. By carefully considering both the read and write operations and the complexity of the operations you want to perform on the data you have, you'll be able to reduce the effect of these bottlenecks and make better use of the resources you have.




--- type:FullSlide key:cf4179bb48
## Benchmarking Performance

*** =part1

```{r}
> library(microbenchmark)
> microbenchmark( rnorm(100), rnorm(10000) )

Unit: microseconds
         expr     min       lq      mean  median       uq      max neval
   rnorm(100)   8.249   8.8035  35.42713   9.118   9.8425 1806.766   100
 rnorm(10000) 690.884 694.0765 726.73457 723.243 742.8110  856.208   100
```


*** =script

In the first set of exercises, we're going to benchmark read and write performance as well as the complexity of a few different operations in R using the microbenchmark package.
A simple example is shown here. We use the microbenchmark function to benchmark the run time of two different expressions. The first one creates a vector of 100 random normals. The second expression creates a vector of 10,000 random normals. The function returns a summary of the distribution of the run times for the two different expressions. The mean runtime for the second expression is about 20 times that of the first.



--- type:FinalSlide key:cecad982f6
## Let's practice!

*** =script
Your turn to practice!