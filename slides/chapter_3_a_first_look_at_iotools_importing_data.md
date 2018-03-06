---
title: 'A first look at iotools: Importing data'
key: 9de57d84a5ba8c38e645ac39b73b7a4d
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch3_2.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch3_2.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:071d71d6d3
## A first look at iotools: Importing data

*** =lower_third
name: Simon Urbanek
title: R-core member and Lead Inventive Scientist, AT&T Labs research

*** =script

The basic components of chunk-wise processing are loading pieces of the data, converting it to native objects that we can compute on, performing the desired computation and storing the results. This sequence is repeated until you have processed all of the data. In this chapter we will discuss each of these pieces and show how the iotools package simplifies and speeds up the process.


--- type:FullSlide key:9c6fd7b5f4
## Importing data

*** =part1

> Separate raw data transfer from parsing


*** =script

One often overlooked aspect of dealing with large data is the import of data. In real applications, it often takes more time to load data than to process it. There are two contributing factors: the data has to be retrieved from disk which is a relatively slow operation, and the data has to be converted from its raw form (typically text) into native objects (vectors, matrices, data frames). In chunk-wise processing, you have to load a chunk of the data, process it, keep or store the results and discard the chunk. It means that you typically cannot re-use the loaded data later as you keep processing different chunks. This means you have to provide efficient functions for loading data.

The iotools package provides a modular approach where the physical loading of data and parsing of input into R objects are separated for better flexibility and performance. R provides raw vectors as a way to handle input data without performance penalty. This means we can separate the methods by which we obtain a chunk from the process of deriving data objects from it.


--- type:FullSlide key:2b7ebcf36d
## Foo (# TODO?)

*** =part1

 - read: `read.chunk()`, `readAsRaw()`
 - parse: `mstrstplit()` (matrix), `dstrsplit()` (data frame)

Example: `read.delim.raw()` = `readAsRaw()` + `dstrsplit()`

```{r}
> # Read a csv file named foo.csv
> x <- read.delim.raw("foo.csv", sep = ",")
```

*** =script
There are two main methods to read data: `readAsRaw` reads the entire content and `read.chunk` reads only up to a pre-defined size of the data in memory. The result of both is a raw vector that is ready to be parsed into R objects.

Parsing text-formatted file can be done using the `mstrsplit` function for reading matrices and `dstrsplit` for reading data frames. Both are optimized for speed and efficiency.

Although this design was chosen specifically to support chunk-wise processing, we can benefit from this approach even if we want to load the dataset in its entirety. For example, `read.delim.raw` is a fast replacement of the `read.delim` function by combining `readAsRaw` and `dstrsplit`.


--- type:FullSlide key:6065072d3f
## Regular Patterns of Data Access

*** =part1

# TODO

Data processing can usually be performed on contiguous chunks.

This is a special case of split-compute-combine.

Splitting is getting sequential chunks.

*** =script

Processing contiguous chunks means you don't have to go through the entire dataset ahead of time to partition it. Splitting simply means reading the next set of rows from the data source and there is no intermediate data structure (like the list returned from the split function) to store and manage.

In practice, you open a connection to the data, read a chunk, parse it into R objects, compute on it and keep or store the result. You repeat this process until you reach the end of the data. 

You can control the chunk size which will limit the amount of data processed in one iteration. R is really good at vector and matrix operations, so this approach is very efficient by processing an entire chunk at a time.


--- type:FinalSlide key:c9ad287739
## Let's practice!

*** =script

Now that you've seen how to read and parse data, let's put it to practice.
