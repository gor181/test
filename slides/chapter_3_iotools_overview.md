---
title: Introduction to chunk-wise processing
key: f3b386f5069c924041215ddb7334d849
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch3_1.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch3_1.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:6f6a7d9e8b
## Introduction

*** =lower_third
name: Simon Urbanek
title: R-core member and Lead Inventive Scientist, AT&T Labs research

*** =script

bigmemory is a good solution for processing large datasets, but it has two limitations. The data must all be stored on a single disk, and it must be representable as a matrix. If your data is better represented as a data.frame, or you want to split it across multiple machines, then you need an alternative solution.

To scale beyond the resource limits of a single machine, you can process the data in pieces. The iotools package provides a way to do this by processing data chunk by chunk. It can also be extended to entire clusters. In this chapter, you'll learn when and how to use this package to process large files.


--- type:FullSlide key:10d3cd6d35
## Chunk-wise processing

*** =part1

### process one chunk at a time sequentially
 - limits resource usege by contolling chunk size
 - allows results to be carried over

&nbsp;

### process each chunk independently
 - corresponds to split-compute-combine
 - no information can be shared between chunks
 - allows parallel and distributed processing 


*** =script

When you split your dataset into pieces - sometimes called chunks - there are two ways to process each chunk: sequential processing and independent processing.

Sequential processing means processing each chunk one after the other. R sees only part of the data at a time, but can keep arbitrary information in the workspace between chunks. Code for sequential processing is typically easier to write than for independent processing, but the computations cannot be parallelized. 

Independent processing allows operations to be performed in parallel by arbitrarily many cores or machines, but requires an additional step, because the final result has to be combined from all the individual results for each chunk at the end. Hence this approach fits into split-compute-combine and is similar to map-reduce.




--- type:FullSlide key:8f99de4526
## Mapping and Reducing for More Complex Operations

*** =part1

```{r}
> # Create a random vector
> x <- rnorm(100)
 
> # Find the mean
> mean(x)
[1] -0.01996644
 
> # Take the sum of chunks of the vector
> sl <- Map( 
+   function(v) {
+     c(sum(v), length(v))
+   }, 
+   list(x[1:25], x[26:100]))
   
> # Add the sums and lengths
> slr <- Reduce(`+`, sl)
 
> # Find the mean
> slr[1]/slr[2]
[1] -0.01996644
```

*** =script

Some operations can be trivially used on chunks. For example, computing the maximum of each chunk - and then maximum of the chunk results - yields the maximum of the entire dataset.

Calculating the mean of a vector is a little trickier. For example, if your chunk sizes are different, taking the mean  of the mean of the chunks may not give the mean of the vector. However, if for each chunk you record both the sum of the values  and the size of the chunk, then you can find the mean  by taking the sum of the chunk sums  divided by  the sum of chunk sizes.



--- type:FullSlide key:0f2e9fc8ba
## Not everything can be split-compute-combined


*** =part1

- It's not possible to find the median using split-compute-combine without having all of the data in a single location.

- In general, calculations that involve looking at relationships between data points don't fit into split-compute-combine.

> Summaries and many regressions can be written using split-compute-combine.


*** =script

Finally, there are some things you can't easily compute using split-compute-combine. A good example is the median of a vector. If you take the median  of the median of chunks, you cannot guarantee that the result is the median of the entire vector. You also can't compute the median by keeping a small amount of extra information like you did with the mean. The problem is that, to calculate the median, you have to sort the vector and take the middle value. That is not an operation that can be performed in the split-compute-combine framework alone.

Fortunately most regression routines, including the linear and generalized linear models, can be written in terms of split-compute-combine.



--- type:FinalSlide key:aecb2f777c
## Let's practice!

*** =script

In this chapter you'll take a look at how we perform these calculations as sequential chunks, usually on large files, without creating other files like we did with bigmemory. Let's start by doing this in base R.

