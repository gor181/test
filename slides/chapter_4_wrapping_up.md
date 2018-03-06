---
title: Congratulations!
key: e76db5acf79e577a409c43afa111047b
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch4_5.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch4_5.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:a188a86aa1
## Congratulations!

*** =lower_third
name: Firstname Lastname
title: Instructor

*** =script
At this point, we've shown you how to write code that lets you scale your computations to larger data sets.

--- type:FullSlide key:13cb878a2b
## split-compute-combine

*** =part1

Steps:
- Break the data into parts.
- Compute on the parts.
- Combine the results

Benefits:
- Manageable parts don't overwhelm your computer.
- Approach is easy to parallelize.

*** =script

The examples we showed you break the data into parts, computes on the parts, and combines the results. We called the approach split-compute-combine.

By splitting the data we guarantee we are working with manageable subsets that don't overwhelm the available computing resources. This approach also makes our tasks easy to parallelize since we can process each of the parts independently of each other. These operations can be executed sequentially, in parallel on a single machine, or over many machines in a cluster.

--- type:FullSlide key:3e28ceace3
## Advanced R Functionality

*** =part1

`split()` partitions set of row numbers or `data.frame`.

`Map()` operations on parts.

`Reduce()` combine results from `Map()`

Mutable closures are functions with their own variables.

*** =script

We showed you a few things about base R you may not have known about. We showed how you can use the split function to partition row numbers of data frame into parts, then use the Map function to perform some operation on those parts, and then use the Reduce function to combine the results.



--- type:FullSlide key:7faff515ee
## bigmemory and iotools

*** =part1

bigmemory
- Good for larger data sets that can be represented as dense matrices and might be too big for RAM.
- Looks like and R matrix.

iotools
- Good for much larger data that can be processed in sequential chunks.
- Supports `data.frame` or `matrix`.

*** =script

We've also covered two tools for processing data using split-compute-combine. The first tool we covered was bigmemory. If your data is big compared to the amount of RAM your computer has, and you can represent the data as a dense matrix, then bigmemory may be a good fit. It stores data on the disk, only moving it into RAM when needed. You access and manipulate the data in almost the same way as you would with a regular R matrix. Data are moved from and to the disk automatically.

The second tool we covered was iotools. The iotools package reads data from the disk, or another location, in contiguous chunks. A chunk is processed, an intermediate value is stored, the next chunk is retrieved, and the process continues until we've processed the entire file. While iotools doesn't allow you to directly retrieve any value in the file without processing the entire file, it is more flexibile than bigmemory in that it can be used with data.frames, it doesn't require you to store a single data structure on the disk, and it can process a greater variety of inputs.

We've used both of these tools to create various tables and visualizations of the Federal Housing Finance Associations mortgage data set. 

--- type:FinalSlide key:2a4a00c0d0
## Thanks!

*** =script

Thank you for taking the course. Good luck working with "Big Data" in R.

