#Setting environment
rm(list = ls())
cat("\014")
print(Sys.time())

# CRAN mirror to use. cran.rstudio.com is a CDN and the recommended mirror.
# Specifying multiple backup CRAN mirrors as Jenkins builds fails
# intermittently due to unavailability of packages in main mirror.
cran_repos = c(MAIN_CRAN_MIRROR = 'https://cran.rstudio.com',
               ALT_CRAN_MIRROR = 'http://cran.r-project.org/')

#Loading Libraries
package_ls <- c(
  "dplyr",
  "data.table",
  "randomForest",
  "filelock",
  "lubridate",
  "ids",
  "minpack.lm",
  "curl",
  "xml2",
  "rcmdcheck",
  "roxygen2",
  "rversions",
  "credentials",
  "httr",
  "gert",
  "gh",
  "usethis"
  # "pkgdown"
  # "devtools"
)


install.packages(package_ls, repos = cran_repos, Ncpus = 4)

# library(devtools)
# install_github("nagdevAmruthnath/minio.s3")