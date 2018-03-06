---
title: Split-compute-combine 
key: 45f7dc2ee7b1586f0b6d2726264db4fc
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch2_2.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch2_2.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:6b70a7308b
## Split-Compute-Combine Use Case: Table Proportions

*** =lower_third
name: Michael Kane
title: Assistant Professor, Yale University

*** =script

Simple tabulations don't always give us the answers we are looking for. To get the ones we want, we may need to group or split data ourselves, perform our own calculations, and return the results. We'll refer to this generically as split compute and combine but it goes by other, similar names including divide and recombine, split apply combine, and even software alchemy when it's used in statistical analyses.
In this section you'll learn how to create more sophisticated summaries using split, Map and Reduce.



--- type:FullSlide key:eb714be9d4
## Partition Using the split Function

*** =part1

The `split()` function partitions data
- First argument is a vector or `data.frame` to split
- Second argument is a `factor` or `integer` whose values define the paritions


*** =script

In the first step - the split. Rows of a data set are partitioned. These partitions could be random or they could be levels from a categorical variable in the data set we're working with.
Let's use R's split function to partition data. The first argument to the split function is a vector or data frame containing the data that will be split. The second argument is a factor variable, whose length should be the same as the first argument's. Each level of this factor variable corresponds to one of the partitions. 


--- type:FullSlide key:c4e53db532
## Partition Using the split Function

*** =part1

```{r}
> # Get the rows corresponding to each of the years in the mortgage data
> year_splits <- split(1:nrow(mort), mort[,"year"])

# year_splits is a list
> class(year_splits)
[1] "list"

> # The years that we've split over
> names(year_splits)
[1] "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015"

> # The first few rows corresponding to the year 2010
> year_splits[["2010"]][1:10]
 [1]  1  6  7 10 21 23 24 27 29 38
```

*** =script

The split function returns a named list. Names correspond to levels of the factor variable used to partition the data. Each element of the list contains the partition data we split over. In this case, we're splitting the rows of the mortgage data by year. The result is a list, whose names are years and whose elements contains the rows corresponding to mortgages.



--- type:FullSlide key:2cc859b5a7
## Compute Using the Map Function


*** =part1

The `Map()` function processes the partitions
- First argument is the function to apply to each parition
- Second argument is the partitions


*** =script

Now that we have the data partitioned, we'll compute on each partition. In this second step, each data partition is sent to a function that processes the data. Our example uses the Map function to do this. Map takes two arguments. The first is a function that will be applied to each element of the list supplied in the second argument. 


--- type:FullSlide key:3863566307
## Compute Using the Map Function


*** =part1

```{r}
> # Map example
>
> col_missing_count <- function(mort) {
+   apply(mort, 2, function(x) sum(x == 9))
+ }
> 
> # For each of the years count the number of missing values for all columns
> missing_by_year <- Map(
+   function(x) col_missing_count(mort[x, ]),
+   year_splits)
> 
> missing_by_year[["2008"]]
           enterprise         record_number                   msa 
                    0                    12                     0 
# ...
```

*** =script

In this case the function counts the number missing values for each column of the mortgage data, by year.
The result of the Map function is another named list where the names once again correspond to the levels of the factor variable. Each element of the list contains whatever was calculated in the Map function. In this case, a vector of numeric values with the number of missing values per column, per year.



--- type:FullSlide key:d4acb27c71
## Combine Using the Reduce Function

*** =part1

The `Reduce()` function combines the results for all partitions.
- First argument is the function to combine with.
- Second argument is the partitioned data.

*** =script

Now that we have the results in a list we may want to combine them so that they can be used in subsequent analyses. This is often done with the Reduce function. Like Map, Reduce takes a function and then a list. The function describes how a result is combined.


--- type:FullSlide key:786911ed77
## Combine Using the Reduce Function

*** =part1

```{r}
> # Calculate the total missing by column
> Reduce(`+`, missing_by_year)
           enterprise         record_number                   msa 
                    0                    64                     0 
# ...
> 
> # Label the rownames with the year
> mby <- Reduce(rbind, missing_by_year)
> row.names(mby) <- names(year_splits)
> mby[1:3, 1:3]
     enterprise record_number msa
2008          0            12   0
2009          0             8   0
2010          0            10   0

```

*** =script

Returning to our example, suppose we want get the total count of missing values by column. We can do this by reducing the list returned by Map using the `+` operator, which adds up the vectors.
We could also use reduce to create a new matrix with the count of missing values for each column by year. In this case we Reduce the list using rbind, resulting in a matrix where each row corresponds to a year and each column corresponds to a mortgage variable.


--- type:FinalSlide key:da6f0f079c
## Let's practice!

*** =script

Now that you've seen how to perform split-compute-combine operations with R we'll practice them with the mortgage data.

