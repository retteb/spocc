\name{occ_to_sp}
\alias{occ_to_sp}
\title{Create a spatial points dataframe from a spocc search.}
\usage{
occ_to_sp(occObj, coord_string = "+proj=longlat +datum=WGS84",
  just_coords = FALSE)
}
\arguments{
  \item{occObj}{The resuslts of a spocc search called by
  occ()}

  \item{coord_string}{A valid EPGS cooridate string from
  the sp package, the default is WSGS 84}

  \item{just_coords}{Return data frame with specios names
  and provenance or just a spatial points object, which is
  the default.}
}
\description{
Create a spatial points dataframe from a spocc search.
}
\details{
This function will return either a spatial points dataframe
or spatial points object. Conversion to spatial points
objects allows spocc searches to interact with other
spatial data sources. More coordinate system codes can be
found at the EPGS registry: http://www.epsg-registry.org/
}
\examples{
\dontrun{
library(sp) # for the spplot function below
out <- occ(query = "Populus tremuloides", from = c("inat","gbif"))
out <- fixnames(out, "query")
sp_points <- occ_to_sp(out)
spplot(sp_points)

### Or see how they line up on a map
library(maptools)
data(wrld_simpl)
plot(wrld_simpl[wrld_simpl$NAME == "United States", ],xlim=c(-70,-60))
out <- occ(query = "Accipiter striatus", from = c("inat","gbif"))
sp_points <- occ_to_sp(out,just_coords=TRUE)
points(sp_points,col=2)
}
}

