\name{spocc_gist}
\alias{spocc_gist}
\title{Post a file as a Github gist}
\usage{
spocc_gist(gist, description = "", public = TRUE, browse = TRUE)
}
\arguments{
  \item{gist}{An object}

  \item{description}{brief description of gist (optional)}

  \item{public}{whether gist is public (default: TRUE)}

  \item{browse}{If TRUE (default) the map opens in your
  default browser.}
}
\value{
Posts your file as a gist on your account, and prints out
the url for the gist itself in the console.
}
\description{
You will be asked ot enter you Github credentials
(username, password) during each session, but only once for
each session. Alternatively, you could enter your
credentials into your .Rprofile file with the entries

\enumerate{ \item options(github.username =
'your_github_username') \item options(github.password =
'your_github_password') }

then \code{gist} will simply read those options.

\code{gist} was modified from code in the rCharts package
by Ramnath Vaidyanathan
}
\examples{
\dontrun{
library(plyr)
splist <- c('Accipiter erythronemius', 'Junco hyemalis', 'Aix sponsa')
keys <- sapply(splist, function(x) gbif_lookup(name=x, kingdom='plants')$speciesKey, USE.NAMES=FALSE)
out <- occ_search(keys, georeferenced=TRUE, limit=50, return='data')
dat <- ldply(out)
datgeojson <- spocc_stylegeojson(input=dat, var='name', color=c('#976AAE','#6B944D','#BD5945'), size=c('small','medium','large'))
write.csv(datgeojson, '~/my.csv')
spocc_togeojson(input='~/my.csv', method='web', outfilename='my')
spocc_gist('~/my.geojson', description = 'Occurrences of three bird species mapped')
}
}

