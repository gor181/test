---
title: The Bigmemory Suite of Packages
key: 856d53956516d8920d9cd2745041c67b
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch2_1.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch2_1.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:c4b0730f01
## The Bigmemory Suite of Packages

*** =lower_third
name: Michael Kane
title: Assistant Professor, Yale University

*** =script

You've made it to chapter 2 of the course. Now that you know the basics of how to import, subset, and assign values for big.matrix objects, we are going to move onto exploratory data analysis using bigmemory. In this chapter, you'll learn how to create tables and  summaries that let you see structure in the data.


--- type:TwoRowsTwoColumns key:467816b612
## Associated Packages

*** =part1
### Tables and summaries
- `bigtabulate`
- `biganalytics`

*** =part2
### Linear algebra
- `bigalgebra`
- `bigpca`

*** =part3
### Regression Models
- `bigFastLM`
- `biglasso`
- `bigrf`

*** =part4
### Process synchronization
- `synchronicity`

*** =script

The bigmemory package is not stand-alone. It is part of a suite of packages that make use of bigmemory for processing big.matrix objects. These packages include biganalytics for summarizing, bigtabulate for splitting and tabulating, and bigalgebra for linear algebra operations. Other contributed packages fit models with big.matrix object. These include bigpca for principle components, bigFastLM for linear models, biglasso for penalized linear and logistic regression, and bigrf for random forests.
For the rest of this section we will focus on how to summarize and tabulate data using biganalytics and bigtabulate.


--- type:FullSlide key:f6ba463a41
## The FHFA's Mortgage Data Set

*** =part1

- Mortgages that were held or securitized by both Federal National Mortgage Association (Fannie Mae) and Federal Home Loan Mortgage Corporation (Freddie Mac) from 2009-2015.
- FHFA Mortgage data is available online [here](https://www.fhfa.gov/DataTools/Downloads/Pages/Public-Use-Databases.aspx).
- We will focus on a random subset of 70000.

*** =script

You may have noticed when we were reading data in the last chapter we were working with a file called "mortgage-sample.csv". This is a publicly available data set from the Federal Housing Finance Agency chronicling all mortgages that were held or securitized by both the Federal National Mortgage Association (Fannie Mae) and the Federal Home Loan Mortgage Corporation (Freddie Mac) from 2009-2015. The full data set includes 10's of millions of mortgages along with demographics and financial information about the individual lenders. 
The data set is available online and, by analyzing these data, we may be able to understand the disparity in homeownership among groups from different backgrounds, assess the risk of default, or even detect events like the 2008 housing market crash.
The entire data set is a total of 2.7 gigabytes in size. While R can read this in as a data.frame and still be less than 10-20% of the size of RAM on your machine, it is above this threshold for the virtual machines that run the exercise code. Furthermore, running some of the exercises may take a little longer than you'd like to wait. So, if you'd like to run the code on the entire data set after this course, please feel free to do so by downloading from the link. However, for this class, we are going to take a random subset of 70000 loans. The code we write will work on both the subset and the full data set.


--- type:FullSlide key:4759ff1431
## A first example: using bigtabulate with bigmemory

*** =part1

```{r}
> library(bigtabulate)
> 
> # How many samples do we have per year?
> bt <- bigtable(mort, "year")
> bt
 2008  2009  2010  2011  2012  2013  2014  2015 
 8468 11101  8836  7996 10935 10216  5714  6734 
> 
> # Make sure we have the total expected number of samples
> sum(bt)
[1] 70000
```

*** =script

The examples in this section will have you creating tables to summarize the mortgage data. The code starts by loading the bigtabulate package, which provides, among other functions, bigtable. The bigtable function is very similar to R's table function but was designed to be used with bigmemory. To use the function, specify the big.matrix object as the first argument and the columns you'd like to tabulate over in the second. If you'd like to create nested tables, you'll create a vector of the column names.

--- type:FinalSlide key:6792301f50
## Let's practice!

*** =script

Lets practice!

