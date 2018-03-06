---
title: Data frames and parallelization
key: c44e689ef45bb52159eec90d641693a2
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch3_3.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch3_3.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7


--- type:TitleSlide key:4f743d2153
## chunk.apply  

*** =lower_third
name: Simon Urbanek
title: R-core member and Lead Inventive Scientist, AT&T Labs research

*** =script
So far you have been iterating over data by creating a loop to read, parse and compute. This is like using a `for` loop. In this section you will use a new function `chunk.apply` that effectively moves us from using a `for` loop to using `apply` equivalent on the chunks. It abstracts the looping process, defines a way to collect results  and enables parallel execution. The iotools package is the basis for the `hmr` package, which allows you to process data on the Apache Hadoop infrastructure. These packages are used at places like AT&T Labs to process hundreds of terabytes of data.


--- type:FullSlide key:88e2f47237
## Processing a file in iotools in chunks

*** =part1

```{r}
# Use chunk.apply to get chunks of rows from foo.csv
chunk_col_sums <- chunk.apply("foo.csv",

 # A function to process each of the chunk.
 function(chunk) {
 
   # Turn the chunk into a matrix and return the column sums
   m <- mstrsplit(chunk, type = "numeric", sep = ",")
   colSums(m)
 })

# chunk_col_sums is a matrix where each row corresponds to a
# chunk and three columns correponding the columns in foo.csv

# Get the total sum by summing over the columns of chunk_col_sums
colSums(chunk_col_sums)
```

*** =script

Assume we have a file, foo.csv with 3 columns containing numeric values and we want to get the sum of the columns.
The code in this slide shows how we process this file in chunks using chunk.apply. The first argument is the file that we will read from. The second argument  is a function  with one argument - chunk. Here we will turn the chunk into a matrix using the mstrsplit function. Then the function processes the chunk by taking the column sums  and keeps the sums of the chunk columns  as an intermediate variable.

chunk.apply returns a matrix where each row corresponds to a chunk  and each column is the chunk-sum of foo.csv's 3 columns. You can get the total sum of all the columns with another call to colSums.


--- type:FullSlide key:92227608ff
## dstrsplit() Reads Chunks as Data Frames

*** =part1

```{r}
# Use chunk.apply to get chunks of rows from foo.csv
chunk_col_sums <- chunk.apply("foo.csv",

 # A function to process each of the chunk
 function(chunk) {
 
   # Turn the chunk into a matrix and return the column sums
   m <- dstrsplit(chunk, type = rep("integer", 3), sep = ",")
   colSums(m)
 })

# chunk_col_sums is a matrix where each row corresponds to a
# chunk and three columns correponding the columns in foo.csv

# Get the total sum by summing over the columns of chunk_col_sums
colSums(chunk_col_sums)
```

*** =script

In the previous example, we parsed each chunk into the processing function as a matrix  using `mstrsplit()`. This is fine when we are reading rectangular data where the type of element in each column is the same. When it's not, we might like to read the data in as a `data.frame`. This can be done by either  reading a chunk as a matrix and then converting it to a data.frame, or you can use the `dstrsplit()` function. This function takes a chunk, just like `mstrsplit()`, and produces a data frame with column types you specify. Moreover it allows you to pick and choose subsets of fields from the data very efficiently.


--- type:FullSlide key:7566fbb75e
## Parallelizing chunk.apply()

*** =part1

```{r}
# Use chunk.apply to get chunks of rows from foo.csv
chunk_col_sums <- chunk.apply("foo.csv",

 # A function to process each of the chunk
 function(chunk) {
 
   # Turn the chunk into a matrix and return the column sums
   m <- dstrsplit(chunk, type = rep("integer", 3), sep = ",")
   colSums(m)
 }, parallel = 2)

# chunk_col_sums is a matrix where each row corresponds to a
# chunk and three columns correponding the columns in foo.csv

# Get the total sum by summing over the columns of chunk_col_sums
colSums(chunk_col_sums)
```


*** =script

The chunk.apply function also has a parallel option to process data more quickly. When the parallel option is set on Unix to a value greater than one  multiple processors read and process data at the same time thereby reducing the execution time.

It should be noted that increasing the number of processors won't always speed up your code. This means doubling the number of processors won't necessarily half the speed of execution. There are usually diminishing returns when you add processors on a single machine to a calculation.



--- type:FinalSlide key:6b807f921a
## Let's practice!

*** =script

Now that you've seen how to read in matrices and data frames, and parallelize your chunk.apply code, let's try some exercises.

