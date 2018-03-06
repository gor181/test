---
title: Working with "Out-of-Core" Objects using the Bigmemory Project
key: 3c417c4d6381bc07baaaa5991effb6b6
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch1_2.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch1_2.mp4
transformations:
    translateX: 40
    translateY: 0
    scale: 0.9

--- type:TitleSlide key:75bd7f67b5
## Working with "Out-of-Core" Objects using the Bigmemory Project


*** =lower_third
name: Michael Kane
title: Assistant Professor, Yale University

*** =script 

In this section we're going to cover the use of the bigmemory package. This is a package I wrote to store, manipulate, and process dense matrices - called big matrices - that may be larger than a computer's RAM.
We are going to cover how to create, retrieve subsets, and summarize big matrices.


--- type:FullSlide key:c7723a00fd
## What does "out-of-core" mean?

*** =part1

R objects are kept in RAM

When you run out of RAM
    - Things get moved to disk
    - Programs keep running (slowly) or crash

You are better off moving data to RAM only when the data are needed for processing.

This is sometimes called "out-of-core" processing.

*** =script

As mentioned before, R objects are kept in RAM. This is much faster than using the disk but there is less RAM than disk. When you run out of RAM your machine may start moving things to disk to make space. Your programs may keep running but they will become slow. In most cases, you are better off moving data to RAM only when it is necessary for processing. This is sometimes called "out-of-core" computing and it's the strategy we're going to use to process data.


--- type:FullSlide key:73ea394c87
## An Overview of bigmemory

*** =part1

bigmemory is R package for working with large dense matrices. These are matrices where most of the elements are not zero.

Data are kept on the disk and moved to RAM implicitly.

bigmemory implements the `big.matrix` data type, which is used to create, store, access, and manipulate matrices stored on the disk.

A `big.matrix` object looks like a regular R matrix.

A `big.matrix` object only need to be imported once.

*** =script

For data sets that are at least 20% of the size of RAM and are also represented as dense matrices - matrices where most of the values are not zero - you should consider using a big.matrix, which is implemented in the bigmemory package. By default, a big.matrix keeps data on the disk and only moves it to RAM when it is needed. As a result, it won't bog down your machine when you run out of RAM.
The movement of data from the disk to RAM is implicit - meaning that users don't have to make function calls to move the data. The package detects when needed data reside on disk and moves them.
Another advantage of using a big.matrix object is that, since it is stored on disk, it only needs to be imported once. You read in a big.matrix object, similar to reading a data.frame. However, doing this creates a "backing" file that holds the data in binary format along with a "descriptor" file that tells R how to load it. In a subsequent session, you simply point R at these two files and they are instantly available, without having to go through the import process again.


--- type:FullSlide key:492acecf50
## An example using bigmemory

*** =part1

```{r}
> library(bigmemory)
> 
> # Create a new big.matrix object
> x <- big.matrix(nrow = 1, ncol = 3, type = "double", init = 0, 
+                 backingfile = "hello_big_matrix.bin",
+                 descriptorfile = "hello_big_matrix.desc")

```

*** =script

Here's a first example of creating a big.matrix object. First, we load the bigmemory package using the library function. Then, we create a big.matrix object. The six parameters specify the number of rows, number of columns, the type of elements the big.matrix will hold, the initial value for all elements in the matrix, the name of the backing file and the name of the descriptor file. The backing file holds the binary representation of the matrix on the disk. The descriptor file holds other information about the big.matrix, like the number of rows, number of columns, type, and column and row names (if there are any).



--- type:FullSlide key:6a9a65ebab
## An example using bigmemory

*** =part1

```{r}
> # See what's in it
> x[,]
     [,1] [,2] [,3]
[1,]    0    0    0
>
> 
> x
An object of class "big.matrix"
Slot "address":
<pointer: 0x108e2a9a0>
```

*** =script

To print the elements of the big.matrix object, you need to explicitly state that you want to see the elements. If you simply type x then you'll see other information including its type and the handle it holds to it's underlying C++ data structure. 

--- type:FullSlide key:4ebf07eb99
## Similarities with matrices

*** =part1

```{r}
> # Change the value in the first row and column
> x[1, 1] <- 3
> 
> # Verify the change has been made
> x[,]
     [,1] [,2] [,3]
[1,]    3    0    0
```

*** =script

big.matrix behaves like a regular R matrix. To change the value in the first row and first column to 3, assign 3 to x[1, 1]. We can verify that this change has taken place by once again looking at all of its elements.

--- type:FinalSlide key:62b0980fa2
## Let's practice!

*** =script

Time to put this into practice.

