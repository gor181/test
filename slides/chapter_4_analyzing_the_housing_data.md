---
title: Analyzing the Housing Data
key: bc664814516955de1c311f06bfc2442b
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch4_3.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch4_3.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:18fa22c00f
## Analyzing the Housing Data

*** =lower_third
name: Simon Urbanek
title: R-core member and Lead Inventive Scientist, AT&T Labs research

*** =script

In the first section of this chapter, we showed how to make fair comparisons between different demographic groups in the data. In the second we created a quick check to see if data are missing at random, which might bias subsequent analyses.

In this section we'll see how the adjusted counts and proportions change over time.
 


--- type:FullSlide key:fdc40beb5c
## Adjusted Counts and Proportional Change by Year

*** =part1

- Adjusting group size lets you compare them as if they were the same size.

- Proportional change shows growth (or decline) of a group.

*** =script

Adjusted counts allow us to compare groups as if they were the same size. In the next exercises, we'll plot adjusted counts by year to see how groups are represented relative to other groups.

Growth or decline affecting the proportional change of all groups equally can often be attributed to overall economic conditions. When one group's growth or decline is different than others it is often for cultural or social reasons.



--- type:FinalSlide key:2bbbb2c9a2
## Let's practice!

*** =script

Now it's your turn to calculate the adjusted group size and proportional change for the mortgage data.
