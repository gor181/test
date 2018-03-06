---
title: Visulize your results using Tidyverse
key: 12ee302114a29cbebd34c3c1779692ec
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch2_3.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch2_3.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:4a9460392d
## Visulize your results using Tidyverse

*** =lower_third
name: Michael Kane
title: Assistant Professor, Yale University

*** =script

Let's use tidyr, dplyr, and ggplot2 to visualize the number of male and female mortgage borrowers by year. Since functions in the bigmemory package take data as the first argument we can use the pipe operator to combine various steps when performing data analysis.


--- type:FullSlide key:708ce9cc3a
## Missingness by Year

*** =part1

```{r}
library(ggplot2)
library(tidyr)
library(dplyr)

mort %>% 
    bigtable(c("borrower_gender", "year")) %>% 
    as.data.frame
```

*** =script

The pipe operator takes the mortgage data set and passes it as the first argument to bigtable, tabulating on borrower_gender and year. The result is a table which is then converted into a data frame.
 


--- type:FullSlide key:dd0233d198
## Missingness by Year

*** =part1

```{r}
library(ggplot2)
library(tidyr)
library(dplyr)

mort %>% 
    bigtable(c("borrower_gender", "year")) %>% 
    as.data.frame %>% 
    mutate(Category = c("Male", "Female", "Not Provided", 
                        "Not Applicable", "Missing"))
```

*** =script
Now we can use the mutate function from the dplyr package to create a new column in the data frame. The first argument is the data frame which is forwarded by the pipe operator, and the second argument is the column we want to create, called Category. We assign the new Category column to a character vector with strings indicating the different gender categories. At this point we have a short-formatted data.frame.
 


--- type:FullSlide key:0500ce1270
## Missingness by Year

*** =part1

```{r}
library(ggplot2)
library(tidyr)
library(dplyr)

mort %>% 
    bigtable(c("borrower_gender", "year")) %>% 
    as.data.frame %>% 
    mutate(Category = c("Male", "Female", "Not Provided", 
                        "Not Applicable", "Missing")) %>%
    gather(Year, Count, -Category)
```

*** =script
To plot it with ggplot we'll convert it to the long format using the function gather from the tidyr package. The first argument to gather is also a data frame, which is again forwarded by the pipe opeartor. Then we specify the names of the columns we want in the long data frame, Year and Count. To gather on all of the columns except Category, we use -Category. 
The columns of our new, long-formatted data frame will be the year-wise count for each category.



--- type:FullSlide key:ac702f241b
## Missingness by Year

*** =part1

```{r}
library(ggplot2)
library(tidyr)
library(dplyr)

mort %>% 
    bigtable(c("borrower_gender", "year")) %>% 
    as.data.frame %>% 
    mutate(Category = c("Male", "Female", "Not Provided", 
                        "Not Applicable", "Missing")) %>%
    gather(Year, Count, -Category) %>% 
    ggplot(aes(x = Year, y = Count, group = Category, color = Category)) + 
    geom_line()
```

*** =script
Finally, we will use the ggplot2 package to visualize the number of male and female borrowers per year. 
First, we set up the plot by piping the data frame into ggplot and mapping the x-axis to Year, y-axis to Count, and then group and color by Category. To draw a line chart we will add a call to geom_line. Note that we use the plus operator to add layers to ggplot and not the pipe!


--- type:FullImageSlide key:b2d6b553f8
## Plot

*** =part1
![](http://s3.amazonaws.com/assets.datacamp.com/production/course_2399/datasets/ch2_v3.png)


*** =script
From the plot you can see that there are more male borrowers than female borrowers for every year. 

--- type:FinalSlide key:57060d162b
## Let's practice!

*** =script
It's your turn to write some tidy code! 