# Scalable Data Processing in R

* Course admin page: https://www.datacamp.com/teach/repositories/721
* Course dev documentation: https://www.datacamp.com/create/how
* Technical documentation: https://www.datacamp.com/teach/documentation

## Description

Datasets are often larger than available RAM but small enough to fit on the disk of a single machine. R users are often challenged by this situation since, by default, variables are stored in memory. This course introduces tools for processing, exploring, and analyzing data directly from disk.  You'll
make use of R's scalable computing libraries to create analyses of 
the Federal Housing Finance Agency's data, which includes  
10's of millions of individuals. In the process, you'll learn 
how to extract useful information from data sets that are bigger than RAM using the `bigmemory` and `iotools` packages and how to write analyses that run in parallel using the `foreach` package.


## Learning objectives

* Learn principles of scalable data exploration and analysis.
* Learn how to work with matrices larger than RAM using the `bigmemory` package.
* Understand how to process more general large objects in chunks using `iotools`.
* Discover easy parallelization techniques using the `foreach` package.

## Prerequisites

* Introduction to R
* Intermediate R
* Efficient R Programming
