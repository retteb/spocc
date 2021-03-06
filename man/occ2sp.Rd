\name{occ2sp}
\alias{occ2sp}
\title{Occ output or data.frame to sp SpatialPointsDataFrame class}
\usage{
occ2sp(input)
}
\arguments{
  \item{input}{Output from \code{\link{occ}} or a
  data.frame}
}
\description{
Occ output or data.frame to sp SpatialPointsDataFrame class
}
\details{
Note that you must have a column named latitude and a
column named longitude - any additional columns are fine,
but those two columns must exist. If you are using
\code{\link{occ}} this will be done for you as you pass in
the output of occ as an occdat class, but if you pass in a
data.frame you should check this.
}
\examples{
\dontrun{
spnames <- c('Accipiter striatus', 'Setophaga caerulescens', 'Spinus tristis')
out <- occ(query=spnames, from='gbif', gbifopts=list(georeferenced=TRUE))

# pass in output of occ directly to occ2sp
occ2sp(out)

# or make a data.frame first, then pass in
mydf <- occ2df(out)
occ2sp(mydf)
}
}

