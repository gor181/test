library(remotes)

install_version("microbenchmark", "1.4-2.1")
install_version("bigmemory", "4.5.19")
install_version("bigtabulate", "1.1.5")
install_version("biganalytics", "1.1.14")
install_version("iotools", "0.1-12")

install_version("glmnet", "2.0-10")

install_version("tidyr", "0.6.1")
install_version("ggplot2", "2.2.1")
install_version("dplyr", "0.7.4")

# Download datasets
.data_dir <- "/usr/local/share/datasets"
dir.create(.data_dir)

download_data <- function(x) {
  download.file(
    file.path("http://s3.amazonaws.com/assets.datacamp.com/production/course_2399/datasets", x),
    file.path(.data_dir, x)
  )
}

download_data("mortgage-small.csv")
download_data("mortgage-sample.csv")
download_data("mtest.zip")
unzip(file.path(.data_dir, "mtest.zip"), exdir=.data_dir) 

write('.data_dir <- "/usr/local/share/datasets"\n', file = "/etc/R/Rprofile.site", append = TRUE)
