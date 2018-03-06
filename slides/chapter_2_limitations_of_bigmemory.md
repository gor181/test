---
title: Limitations of bigmemory
key: 953ec14e2010ec40df4e71959b328899
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch2_4.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch2_4.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:fb4771c1ba
## Limitations of bigmemory

*** =lower_third
name: Michael Kane
title: Assistant Professor, Yale University

*** =script

--- type:FullSlide key:7880e96b2e
## Where can you use bigmemory?

*** =part1

- You can use bigmemory when your data are
    - matrices
    - dense
    - numeric
- Underlying data structures are compatible with low-level linear algebra libraries for fast model fitting.
- If you have different column types, you could try the `ff` package.

*** =script

The bigmemory package is useful when your data are represented as a dense, numeric matrix and you can store the entire matrix on your hard drive. It is also compatible with optimized, low-level linear algebra libraries written in C, like Intel's Math Kernel Library. So, you can use bigmemory directly in your C and C++ programs for better performance.
If your data isn't numeric - if you have string variables - or if you need a greater range of numeric types - like 1-bit integers-  then you might consider trying the `ff` package. It is similar to bigmemory but includes structures similar to a `data.frame`.


--- type:FullSlide key:73d9eada43
## Understanding disk access

*** =part1

> A big.matrix is a data structure designed for random access

*** =script

After creating a big.matrix object you can instantly access any of it's elements. If the elements are stored in RAM - or cached - then they are returned immediately. If they are not in RAM then they are moved from the disk to RAM and returned. Since a big.matrix can access any of it's elements equally quickly we call it a random access data structure.
However, this ability to quickly access any element comes with other associated challenges. For example, if we want to add columns or rows we have to create an entirely new big.matrix object with the appropriate size, copy the old big.matrix elements to their appropriate positions, and add the new values. This also means we need enough disk space to hold the entire matrix in one big block.
In practice, many of the larger data sets you encounter won't require random access and storing all data in a single file is not feasible. It may be sufficient to retrieve contiguous "chunks" of rows from different locations, process them, and move on to the next chunk.




--- type:FinalSlide key:6a4d05ac39
## Let's practice!

*** =script

In the next chapter we'll take a look at tools for processing data in contiguous chunks. But first, we are going to finish up this chapter with one more exercise.

