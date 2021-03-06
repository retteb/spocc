\name{mapggplot}
\alias{mapggplot}
\title{ggplot2 visualization of species occurences}
\usage{
mapggplot(df, zoom = 5, point_color = "#86161f")
}
\arguments{
  \item{df}{Input \code{data.frame}}

  \item{zoom}{zoom level for map. Adjust depending on how
  your data look.}

  \item{point_color}{Default color of your points}
}
\description{
ggplot2 visualization of species occurences
}
\examples{
\dontrun{
ecoengine_data <- occ(query = 'Lynx rufus californicus', from = 'ecoengine')
mapggplot(ecoengine_data)
gbif_data <- occ(query = 'Accipiter striatus', from = 'gbif')
mapggplot(gbif_data)
bison_data <- occ(query = 'Accipiter striatus', from = 'bison', bisonopts=list(count=100))
mapggplot(bison_data)
}
}

