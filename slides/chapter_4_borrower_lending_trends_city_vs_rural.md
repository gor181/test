---
title: 'Borrower Lending Trends: City vs. Rural'
key: ab88012e4fbc65dd89d7d2a65754c5a7
video_link:
    hls: https://s3.amazonaws.com/videos.datacamp.com/transcoded/2399_scalable_data_processing_in_r/v2/hls-2399_ch4_4.master.m3u8
    mp4: https://s3.amazonaws.com/videos.datacamp.com/transcoded_mp4/2399_scalable_data_processing_in_r/v2/2399_ch4_4.mp4
transformations:
    translateX: 62
    translateY: 0
    scale: 0.7

--- type:TitleSlide key:463bcd30d8
## Other Lending Trends

*** =lower_third
name: Simon Urbanek
title: R-core member and Lead Inventive Scientist, AT&T Labs research

*** =script

Borrower changes in Race and Ethnicity by year aren't the only trends we can look for in the data. In this section we'll take a look at two others: borrowing trends in mortgages for city vs. rural houses along with federally guaranteed loans vs. income.



--- type:FullSlide key:ef6f516f6c
## City vs. Rural

*** =part1

- City means a home is in a metropolitan areas. Otherwise urban.

- In the mortgage data set, city has `msa` value of 1, urban is 0.

- For a more precise definition see [FHFA website](https://www.fhfa.gov/DataTools/Downloads/Pages/Public-Use-Databases.aspx). 

*** =script

The comparison city vs. rural is straightforward. A home is designated city if it's in a metropolitan area and rural otherwise. This corresponds to the msa variable being equal to one in the mortgage data. If you'd like a more precise definition you can see the FHFA website.



--- type:FullSlide key:2a0f34a16b
## Federally Guaranteed Loans and Borrower Income

*** =part1

- Federally guaranteed loans protect the company issuing a loan.

- We'll use Borrower Income Ratio: borrower income divided by median income of people in the area.

*** =script

A federally guaranteed loan protects the company issuing a loan if the lender defaults. That is, if someone gets a loan, and is no longer able to repay that loan, then the government buys the loan and the person who took out the loan is responsible to the government for paying it back.

We might expect these loans are issued to people with less money because they mitigate risk for lending companies. If I'm a lender and I can issue a federally guaranteed loan, then I'm less worried about the lender defaulting since the government will buy the loan from me.

Borrower's income is not in the data set. However, annual income divided by the median income of people in the local area is. This is called the Borrower Income Ratio. 

We'll look at the proportion of federally guaranteed loans for each borrower income category to see if this relationship between the number of federally guaranteed loans and the borrower income ratio holds.




--- type:FinalSlide key:7583619500
## Let's practice!

*** =script

It's time to create some visualizations to see if there are interesting trends in borrowers in city vs. rural areas and also see if people with lower borrower income ratios tend to get more federally guaranteed loans. Ready... set... go!

