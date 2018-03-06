---
title: References vs. Copies
key: 8aad911cad5804b6f6fe50cb411332dc
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch1_3.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch1_3.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:9ba8c110e3
## References vs. Copies

*** =lower_third
name: Michael Kane
title: Assistant Professor, Yale University

*** =script

As mentioned earlier, big.matrices have been designed to look and feel like a regular R matrix. You can retrieve subsets of a big.matrix just like you would a regular R matrix. You can also set values of a big.matrix like you would with a regular R matrix. However, it is sometimes important to realize that a big.matrix isn't actually an R matrix. There are a couple of differences that can be important. One difference, which you already know, is that a big.matrix object is normally stored on the disk, rather than RAM. This means that a big.matrix can persist across R sessions and can even be shared among R sessions.


--- type:FullSlide key:01c16dfe18
## R usually makes copies during assignment

*** =part1

This creates a copy of `a` and assigns it to `b`.
```{r}
> a <- 42
> b <- a
> a
[1] 42
> b
[1] 42

> a <- 43
> a
[1] 43
> b
[1] 42
```


*** =script

Another difference is that a big.matrix object is not copied like a regular matrix. When an R variable is assigned to other variables it actually gets a copy of the content. 


--- type:FullSlide key:7e0b489b57
## R usually makes copies during assignment

*** =part1

This function doesn't change the value of `a` in the global environment
```{r}
> foo <- function(a) { 
+     a <- 43 
+     paste("Inside the function a is", a) 
+ }
> 
> a <- 42
> foo(a)
[1] "Inside the function a is 43"

> paste("Outside the function a is still", a)
[1] "Outside the function a is still 42"
```

*** =script

This is also true when parameters are passed to functions. Here we assign the value 42 to the variable `a`. Next, we create a function, foo, that takes a single parameter, sets it to 43, and then outputs its value. When we call foo(a) 
The printed message tells us that `a`, inside the function is 43. When we print the value of `a` outside the function, it is still 42. This is because the function foo doesn't actually get `a`. It gets a copy of `a`. If we want to change the original a we need 
to do so outside of the function.


--- type:FullSlide key:3ea6e6ff47
## Not all R objects are copied

*** =part1

This function does change the value of `a` in the global environment
```{r}
> foo <- function(a) { 
+   a$val <- 43 
+   paste("Inside the function a is", a$val) 
+ }
> 
> a <- environment()
> a$val <- 42
>
> foo(a)
[1] "Inside the function a is 43"
> 
> paste("Outside the function a$val is", a$val)
[1] "Outside the function a$val is 43"
```

*** =script

There are other types of variables, like environments, that are not copied when they are passed to a function. For these types, if you change their values inside a function, you will see those changes after the function is finished executing. Those types of objects have reference semantics.
A big.matrix is a reference object. This means that assignments create new variables that point to the same data. If you want a copy you need to do it explicitly using the deepcopy() function. Reference behavior ensures that R won't make copies of the matrix without you knowing. This helps minimize memory usage and execution time, but it also means you need to be careful when you are making changes.


--- type:FullSlide key:32bd2f3894
## Not all R objects are copied

*** =part1

```{r}
> library(bigmemory)

> x <- big.matrix(nrow = 1, ncol = 3, type = "double", init = 0, 
+                 backingfile = "hello-bigmemory.bin", 
+                 descriptorfile = "hello-bigmemory.desc")

> x_no_copy <- x

> x[,]
[1] 0 0 0
> x_no_copy[,]
[1] 0 0 0

> x[,] <- 1
> x[,]
[1] 1 1 1
> x_no_copy[,]
[1] 1 1 1
```

*** =script

Here we have an example that shows the reference behavior of a big.matrix. We start by creating a new big.matrix, called `x`. We assign a new variable `x_no_copy` to `x`. x_no_copy now references the same data as x. If you update x, the changes will be reflected in x_no_copy as well. 

However, when you create x_copy by explicitly applying deepcopy on `x`, then x_copy has it's own copy of data in x. So if you change a value in x, it will not be reflected in x_copy.


--- type:FinalSlide key:badd7a567e
## Let's practice!

*** =script

Now that you have seen the difference between copies and references, you get to spend a little time manipulating reference objects.

