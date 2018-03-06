---
title: Working with increasingly large data sets
description: >-
  In this video, we cover the reasons you need to apply new techniques when data
  sets are larger than available RAM.  We show that importing and exporting data
  using the base R functions can be slow and some easy ways to remedy this.
  Finally, we introduce the bigmemory .

--- type:VideoExercise lang:r xp:50 skills:1 key:b3b5cda237
## What is Scalable Data Processing?

*** =video_link
//player.vimeo.com/video/154783078

*** =video_hls
//videos.datacamp.com/transcoded/000_placeholders/v1/hls-temp.master.m3u8

*** =projector_key
81dafd945346b18dd9d772294eefc4f8

--- type:PureMultipleChoiceExercise lang:r xp:50 skills:1 key:de496c7b96
## Why is my code slow?

Reading and writing data to the hard drive takes much longer than reading and writing to RAM. This means if you need to retrieve data from the hard drive it takes much longer to move it to the CPU - where it can be processed - compared to moving data from RAM to the CPU.
A program's use of resources, like RAM, processors, and hard drive dictate how quickly your R code runs. You can't change these resources without physically swapping them out for other hardware. However, you can often use the resources you have more efficiently. In particular, if you have a data set that is about the size of RAM, you might be better off saving most of the data set on the disk. By loading only the parts of a data set you need, you free up resources so that each part can be processed more quickly.

Which one of the following does not contribute to processing time?

*** =possible_answers

- The complexity of your analysis. 
- How much data you have to import from the hard drive. 
- How fast your CPU is. 
- [The time your code took to write.]

*** =hint
Processing time is the amount of time *your computer* needs to perform a calculation.

*** =feedbacks

- The more complex the calculation is, the longer it takes to run.
- The more data you have to import, the longer a calculation takes.
- The CPU is executes instructions in your script.
- Superb! How long it takes to write code and how long it takes to run code are independent.


--- type:NormalExercise lang:r xp:100 skills:1 key:73faf52012
## How does processing time vary by data size?

If you are processing all elements of two data sets, and one data set is bigger, then the bigger data set will take longer to process. However, it's important to realize that how much longer it takes is not always directly proportional to how much bigger it is. That is, if you have two data sets and one is two times the size of the other, it is not guaranteed that the larger one will take twice as long to process. It could take 1.5 times longer or even four times longer. It depends on which operations are used to process the data set.

To gain a little more familiarity with execution time, you are going to benchmark a few common operations. This means you are going to send data of varying sizes to an R function to see how the data size affects the time it takes the function to run. For these exercises, you'll use the `microbenchmark` package, which was covered in the [Writing Efficient R Code course](https://www.datacamp.com/courses/writing-efficient-r-code).

In the first exercise, you are going to create vectors of varying size. You are going to specify the size using scientific notation where the number $$1e5 = 1 * 10^5 = 100,000$$. 

*** =instructions

* Load the `microbenchmark` package.
* Use the `microbenchmark()` function to compare the sort times of random vectors. 
* Call `plot()` on `mb`. 

*** =hint

* To load the package `x`, use `library(x)`.
* Use `rnorm(n)` to create a vector of `n` normally distributed random numbers.
* Call `sort(x)` to sort the vector, `x`.

*** =pre_exercise_code
```{r}

```

*** =sample_code
```{r}
# Load the microbenchmark package
___

# Compare the timings for sorting different sizes of vector
mb <- microbenchmark(
  # Sort a random normal vector length 1e5
  "1e5" = ___(___(1e5)),
  # Sort a random normal vector length 2.5e5
  "2.5e5" = sort(rnorm(2.5e5)),
  # Sort a random normal vector length 5e5
  "5e5" = sort(rnorm(5e5)),
  # Sort a random normal vector length 7.5e5
  "7.5e5" = sort(rnorm(7.5e5)),
  # Sort a random normal vector length 1e6
  "1e6" = sort(rnorm(1e6)),
  times = 10
)

# Plot the resulting benchmark object
___(mb)
```

*** =solution
```{r}
# Load the microbenchmark package
library(microbenchmark)

# Compare the timings for sorting different sizes of vector 
mb <- microbenchmark(
  # Sort a random normal vector length 1e5
  "1e5" = sort(rnorm(1e5)),
  # Sort a random normal vector length 2.5e5
  "2.5e5" = sort(rnorm(2.5e5)),
  # Sort a random normal vector length 5e5
  "5e5" = sort(rnorm(5e5)),
  # Sort a random normal vector length 7.5e5
  "7.5e5" = sort(rnorm(7.5e5)),
  # Sort a random normal vector length 1e6
  "1e6" = sort(rnorm(1e6)),
  times=10
)

# Plot the resulting benchmark object
plot(mb)
```

*** =sct
```{r}

ex() %>% check_error()
success_msg("Great Job! Note that the resulting graph shows that the execution time is not the same every time. This is because while the computer was executing your R code, it was also doing other things. As a result, it is a good practice to run each operation being benchmarked mutiple times, and to look at the median execution time when evaluating the execution time of R code.")

```


--- type:VideoExercise lang:r xp:50 skills:1 key:d47a3d5715
## Working with "Out-of-Core" Objects using the Bigmemory Project

*** =video_link
//player.vimeo.com/video/154783078

*** =video_hls
//videos.datacamp.com/transcoded/000_placeholders/v1/hls-temp.master.m3u8

*** =projector_key
3c417c4d6381bc07baaaa5991effb6b6

--- type:NormalExercise lang:r xp:100 skills:1 key:a25eed3eb9
## Reading a big.matrix object

In this exercise, you'll create your first file-backed `big.matrix` object using the `read.big.matrix()` function. The function is meant to look similar to `read.table()` but, in addition, it needs to know what type of numeric values you want to read ("char", "short", "integer", "double"), it needs the name of the file that will hold the matrix's data (the backing file), and it needs the name of the file to hold information about the matrix (a descriptor file). The result will be a file on the disk holding the value read in along with a descriptor file which holds extra information (like the number of columns and rows) about the resulting `big.matrix` object.

*** =instructions
* Load the `bigmemory` package.
* Use the `read.big.matrix()` function to read a file called `"mortgage-sample.csv"`, which contains a header and is composed of integer values. In addition: 
    * Create a backingfile called `"mortgage.bin"`, and 
    * A descriptor file called `"mortgage.desc"`. 
* Find the dimensions of `x` using the `dim()` function.

*** =hint

* To load a package, use the `library()` function.
* Create an integer `big.matrix` object, called `x` by using the `read.big.matrix()` function, supplying `"mortgage-sample.csv"` as the text file. The file contains a header. The data are integers. Name the resulting binary file `"mortgage.bin"` and the resulting descriptor file `"mortgage.desc"`.

*** =pre_exercise_code
```{r}

download.file("http://s3.amazonaws.com/assets.datacamp.com/production/course_2399/datasets/mortgage-sample.csv", destfile = "mortgage-sample.csv")

```

*** =sample_code
```{r}
# Load the bigmemory package
___

# Create the big.matrix object: x
x <- ___(___, header = TRUE, 
                     type = ___,
                     backingfile = ___, 
                     descriptorfile = ___)
    
# Find the dimensions of x
___
```

*** =solution
```{r}
# Load the bigmemory package
library(bigmemory)

# Create the big.matrix object: x
x <- read.big.matrix("mortgage-sample.csv", header = TRUE, 
                     type = "integer",
                     backingfile = "mortgage-sample.bin", 
                     descriptorfile = "mortgage-sample.desc")
                    
# Find the dimensions of x
dim(x)
```

*** =sct
```{r}
success_msg("Great job! Note that this file isn't *that* big but the code will work for files that are much bigger.")
```

--- type:NormalExercise lang:r xp:100 skills:1 key:b9c3817713
## Attaching a big.matrix vs. reading a file benchmark

Now that the `big.matrix` object is on the disk, we can use the information stored in the descriptor file to instantly make it available during an R session. This means that you don't have to reimport the data set, which takes more time for larger files. You can simply point the `bigmemory` package at the existing structures on the disk and begin accessing data without the wait.

*** =instructions

* Create a new variable `y` that also points to the mortgage data by attaching to the mortgage.desc file using the `attach.big.matrix()` function.
* Make sure the dimensions of the variable y are the same as the big.matrix object you created previously.

*** =hint

* Create a new variable `y` with the `attach.big.matrix()` function supplying "mortgage-sample.desc" as an argument.
* Get the dimensions of the new variable with `dim()` function.
* Look at the first few rows of `y`.


*** =pre_exercise_code
```{r}
download.file("http://s3.amazonaws.com/assets.datacamp.com/production/course_2399/datasets/mortgage-sample.csv", destfile = "mortgage-sample.csv")
library(bigmemory)
x <- read.big.matrix("mortgage-sample.csv", header = TRUE, type = "integer",
    backingfile = "mortgage-sample.bin", descriptorfile = "mortgage-sample.desc")
```

*** =sample_code
```{r}
# Attach to the mortgage-sample.desc file, creating a new variable called y
y <- ___(____)

# Verify that the dimensions are the same as the last exercise.
___

# Look at the first few rows of y.
___
```

*** =solution
```{r}
# Attach to a big.matrix using the mortgage-sample.desc file, creating a new variable called y
y <- attach.big.matrix("mortgage-sample.desc")

# Get the dimensions of y
dim(y)

# Look at the first few rows of y.
head(y)
```

*** =sct
```{r}
success_msg("Good! You've used your knowledge of base R to get information about a `big.matrix` object.") 
```


--- type:NormalExercise lang:r xp:100 skills:1 key:758129e017
## Creating tables with big.matrix objects

A final advantage to using `big.matrix` is that if you know how to use R's matrices, then you know how to use a big.matrix. big.matrix is designed to look and feel like a regular R matrix. You can subset columns and rows just as you would a regular matrix, using a numeric or character vector and the object returned is an R `matrix`. Likewise, assignments are the same as with R matrices and after those assignments are made they are stored on disk and can be used in the current and future R sessions.

One thing to remember is that `$` is not valid for getting a column of either a `matrix` or a `big.matrix`.

*** =instructions
* Create a new variable x by attaching to the "mortgage.desc" file.
* Create a table of the number of mortgages for each year in the data set. The column name in the data set is "year".

*** =hint

* Create the new variable `mort` with `attach.big.matrix()` function, supplying "mortgage-sample.desc" as the descriptor file argument.
* Look at the first 3 rows.
* Use the `table()` function, supplying `mort[, "year"])` as the matrix argument.

*** =pre_exercise_code
```{r}
download.file("http://s3.amazonaws.com/assets.datacamp.com/production/course_2399/datasets/mortgage-sample.csv", destfile="mortgage-sample.csv")
library(bigmemory)
#read.big.matrix("mortgage-sample.csv", header = TRUE, type = "integer",
#    backingfile = "mortgage-sample.bin", descriptorfile = "mortgage-sample.desc")
```

*** =sample_code
```{r}
# Create a new variable mort by attaching to the "mortgage-sample.desc" file
mort <- ___

# Look at the first 3 rows.
mort[___,]

# Create a table of the number of mortgages for each year in the data set
table(___)
```

*** =solution
```{r}
# Create a new variable mort by attaching to the "mortgage.desc" file
mort <- attach.big.matrix("mortgage-sample.desc")

# Look at the first 3 rows.
mort[1:3,]

# Create a table of the number of mortgages for each year in the data set
table(mort[, "year"])
```

*** =sct
```{r}
success_msg("Good. Don't forget that this is only a sample of the entire data set. So the values are propotional to the actual total number of mortgages. Does it seem strange that some years had proportionally more total mortgages?")
```


--- type:NormalExercise lang:r xp:100 skills:1 key:e4a2f7505c
## Data summary using bigsummary

Now that you know how to import and attach a `big.matrix` object, we are going to start exploring the data stored by this object. As mentioned before, there is a whole suite of packages designed to explore and analyze data stored as a `big.matrix` object. We'll start by using the `biganalytics` package to create summaries.


*** =instructions

* Load the `biganalytics` package.
* Create a new variable `x` by attaching to the "mortgage-sample.desc" file.
* Get the column means of the mortgage sample.
* Use biganalytics' `summary()` function to get a summary of the variables.


*** =hint

* Use the `library()` function to load the biganalytics package.
* Create a new variable, `x` with the `attach.big.matrix()` from the "mortgage-sample.desc" descriptor file.
* Use the `summary()` function to create a summary of `x`.

*** =pre_exercise_code
```{r}
download.file("http://s3.amazonaws.com/assets.datacamp.com/production/course_2399/datasets/mortgage-sample.csv", destfile="mortgage-sample.csv")
library(bigmemory)
read.big.matrix("mortgage-sample.csv", header = TRUE, type = "integer",
    backingfile = "mortgage-sample.bin", descriptorfile = "mortgage-sample.desc")
```

*** =sample_code
```{r}
# Load the biganalytics package
___

# Attach to the mortgage-sample.desc file
x <- ___

# Get the column means of the mortgage sample.
colmean(___)

# Use biganalytics' summary function to get a summary of the data
___
```

*** =solution
```{r}
# Load the biganalytics package
library(biganalytics)

# Attach to the mortgage-sample.desc file
x <- attach.big.matrix("mortgage-sample.desc")

# Get the column means of the mortgage sample.
colmean(x)

# Use biganalytics' summary function to get a summary of the data
summary(x)
```

*** =sct
```{r}
success_msg("Well done! Note that although there are no NA's listed, some of categorical variables are already encoded with another value. In a few sections, we'll go through how to fix this ")
```



--- type:VideoExercise lang:r xp:50 skills:1 key:6508ec6402
## References vs. Copies

*** =video_link
//player.vimeo.com/video/154783078

*** =video_hls
//videos.datacamp.com/transcoded/000_placeholders/v1/hls-temp.master.m3u8

*** =projector_key
8aad911cad5804b6f6fe50cb411332dc

--- type:NormalExercise lang:r xp:100 skills:1 key:bf191a5fec
## Copying matrices and big matrices

If you really want to copy a `big.matrix` then you need to use the `deepcopy()` function. This can be useful, especially if you want to create smaller `big.matrix` objects. In this exercise, you'll copy a `big.matrix` object and show the reference behavior for these types of objects.

*** =instructions

* Create a new variable, `first_three`, using the `deepcopy()` function that consists of the first 3 columns of `mort`.
* Set another variable, `first_three_2` to `first_three`.
* Set the value in the first row and first column of `first_three` to `NA`.
* Verify the change shows up in `first_three_2` but not in `mort`.

*** =hint

* Create the new variable `first_three` using `deepcopy()` to create a copy of the first three columns of `mort`. Call the backingfile of the copy `"first_three.bin"` and the descriptor file `"first_three.desc"`.
* Set `first_three_2` to `first_three`.
* Set the value in the first column and first row of `first_three` to `NA`.
* Verify the change with `first_three_2[1, 1]` and no change with `mort[1, 1]`.

*** =pre_exercise_code
```{r}
download.file("http://s3.amazonaws.com/assets.datacamp.com/production/course_2399/datasets/mortgage-sample.csv", destfile="mortgage-sample.csv")
library(bigmemory)
mort <- read.big.matrix("mortgage-sample.csv", header = TRUE, type = "integer",
    backingfile = "mortgage-sample.bin", descriptorfile = "mortgage-sample.desc")
```

*** =sample_code
```{r}
# Use deepcopy() to create first_three
first_three <- ___(___, cols = ___, 
                        backingfile = "first_three.bin", 
                        descriptorfile = "first_three.desc")

# Set first_three_2 equal to first_three
___ <- ___

# Set the value in the first row and first column of first_three to NA
first_three[___, ___] <- NA

# Verify the change shows up in first_three_2
first_three_2[___, ___]

# but not in mort
mort[___, ___]
```

*** =solution

```{r}
# Use deepcopy() to create first_three
first_three <- deepcopy(mort, cols = 1:3, 
                        backingfile = "first_three.bin", 
                        descriptorfile = "first_three.desc")

# Set first_three_2 equal to first_three
first_three_2 <- first_three

# Set the value in the first row and first column of first_three to NA
first_three[1, 1] <- NA

# Verify the change shows up in first_three_2
first_three_2[1, 1]

# but not in mort
mort[1, 1]
```

*** =sct
```{r}
success_msg("Great! You know the basics of loading, attaching, subsetting, and copying `big.matrix` objects. In the next section we'll explore and begin analyzing the data set.") 
```
