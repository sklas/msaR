
<!-- README.md is generated from README.Rmd. Please edit that file -->

# msaR

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/msaR)](https://cran.r-project.org/package=msaR)

msaR is a an [htmlwidgets](https://github.com/ramnathv/htmlwidgets)
wrapper of the [BioJS MSA viewer](https://github.com/wilzbach/msa)
javascript library. msa will pass alignments to the BioJS MSA.

## Installation

You can install msaR from CRAN or github:

``` r
# CRAN
install.packages("msaR")
#github
devtools::install_github("zachcp/msaR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(msaR)

# read some sequences from a multiple sequence alignment file and display
seqfile <- system.file("sequences","AHBA.aln", package="msaR")
msaR(seqfile, seqlogo = T)
```

![](man/figures/msaR_screenshot.png)

All contributions are welcome! Please feel free to submit a pull
request.

### Support and Suggestions

If you have any problem or suggestion please open an issue
[here](https://github.com/zachcp/msaR/issues)

### License

This project is licensed under the [Boost Software License
1.0](https://github.com/wilzbach/msa/blob/master/LICENSE).

> Permission is hereby granted, free of charge, to any person or
> organization obtaining a copy of the software and accompanying
> documentation covered by this license (the “Software”) to use,
> reproduce, display, distribute, execute, and transmit the Software,
> and to prepare derivative works of the Software, and to permit
> third-parties to whom the Software is furnished to do so, all subject
> to the following:

If you use the MSAViewer on your website, it solely requires you to link
to us
