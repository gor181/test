# Working with Big Data in R

## Chapter 1: Working with datasets that don't fit in RAM 

* Big Data Challenges
    * Data may not fit in memory
    * Data movement: Importing and Exporting can be slow
    * Data Processing: Split-Compute-Combine and Parallelization
* Exercise
    * Introduce a data set?
    * Time and size to load a small data set
    * Time and size to load a bigger data set
    * readlines vs. read.table
* Working with "Out-of-Core" Objects using the Bigmemory Project
    * Where should you use ```bigmemory```?
    * How does a ```big.matrix``` work?
* You already know how to use it (compare with regular matrix)
    * Reading Matrices from Files
    * Subsetting
    * Writing
* Exploring and Fitting Models with ```bigmemory```
    * ```bigtabulate```
    * ```bigrf```
* Where shouldn't you use ```bigmemory```? (Motivates next chapter)
    * Only works for dense matrices
    * Slow if you need all of a large data set

## Chapter 2: Chunk-wise Processing and Streaming 

* Motivation: ```tapply``` 
    * Equivalents: data.table, dplyr, SQL
    * This is a "chunked" calculation
    * ```bigsplit``` (with exercises)
* Processing Data in Chunks
    * ```chunk.apply``` (mention ctapply)
    * Converting chunks into R objects for analysis 
        * Was implicit in bigmemory now the user has control
        * ```mstrsplit```
        * ```dstrsplit```
    * Handling factor variables
    * Exercises with chunk.apply (try different chunk sizes)
* Streaming Analytics 
    * What is it and why chunking works for streaming
* Processing Chunks in Parallel
    * When should you parallelize chunks?
    * Exercise (try different numbers of cores)

## Chapter 3: ```foreach``` for Parallelizing and Distributing Computations

* A Problem with Parallel and Distributed Computing
* ```foreach``` a Solution to the "Many API" Problem
* Sequential Loops with ```foreach```
    * Defining a Loop
    * Combining Your Results
    * Filtering Loop Conditions
    * Nested Loops
* Parallelizing and Distributing Your Loop - Take the split example from before and iterate over multiple files
    * Why parallelize?
    * Parallel backends
    * Distributed backends

## Chapter 4: Advanced Parallelization 
* ```iterators``` for Abstracting Input 
    * What is an iterator?
    * Defining iterators in R
    * Adding iterators to ```foreach``` loops
* Nesting Parallel Computations
    * How are the computations parallelized?
    * Which loop do you want to parallelize over?
* RNG
    * How are random numbers generated? - Example where parallel RNG not used.
    * How do you parallelize random number generation?
* Exercise (Include Writing Intermediate Results)

