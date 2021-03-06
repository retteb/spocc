\name{occ}
\alias{occ}
\title{Search for species occurrence data across many data sources.}
\usage{
occ(query = NULL, from = "gbif", limit = 25, geometry = NULL,
  rank = "species", type = "sci", ids = NULL, gbifopts = list(),
  bisonopts = list(), inatopts = list(), ebirdopts = list(),
  ecoengineopts = list(), antwebopts = list())
}
\arguments{
  \item{query}{(character) One to many names. Either a
  scientific name or a common name. Specify whether a
  scientific or common name in the type parameter. Only
  scientific names supported right now.}

  \item{from}{(character) Data source to get data from, any
  combination of gbif, bison, inat, ebird, and/or
  ecoengine}

  \item{limit}{(numeric) Number of records to return. This
  is passed across all sources. To specify different limits
  for each source, use the options for each source.}

  \item{geometry}{(character or nmeric) One of a Well Known
  Text (WKT) object or a vector of length 4 specifying a
  bounding box. This parameter searches for occurrences
  inside a box given as a bounding box or polygon described
  in WKT format. A WKT shape written as 'POLYGON((30.1
  10.1, 20, 20 40, 40 40, 30.1 10.1))' would be queried as
  is, i.e. http://bit.ly/HwUSif. See Details for more
  examples of WKT objects.}

  \item{rank}{(character) Taxonomic rank. Not used right
  now.}

  \item{type}{(character) Type of name, sci (scientific) or
  com (common name, vernacular). Not used right now.}

  \item{ids}{Taxonomic identifiers. This can be a list of
  length 1 to many. See examples for usage. Currently,
  identifiers for only 'gbif' and 'bison' for parameter
  'from' supported. If this parameter is used, query
  parameter can not be used - if it is, a warning is
  thrown.}

  \item{gbifopts}{(list) List of options to pass on to
  rgbif}

  \item{bisonopts}{(list) List of options to pass on to
  rbison}

  \item{inatopts}{(list) List of options to pass on to
  rinat}

  \item{ebirdopts}{(list) List of options to pass on to
  ebird}

  \item{ecoengineopts}{(list) List of options to pass on to
  ecoengine}

  \item{antwebopts}{(list) List of options to pass on to
  AntWeb}
}
\description{
Search on a single species name, or many. And search across
a single or many data sources.
}
\details{
The \code{occ} function is an opinionated wrapper around
the rgbif, rbison, rinat, rebird, AntWeb, and ecoengine
packages to allow data access from a single access point.
We take care of making sure you get useful objects out at
the cost of flexibility/options - although you can still
set options for each of the packages via the gbifopts,
bisonopts, inatopts, ebirdopts, and ecoengineopts
parameters.

When searching ecoengine, you can leave the page argument
blank to get a single page. Otherwise use page ranges or
simply "all" to request all available pages. Note however
that this may hang your call if the request is simply too
large.

WKT objects are strings of pairs of lat/long coordinates
that define a shape. Many classes of shapes are supported,
including POLYGON, POINT, and MULTIPOLYGON. Within each
defined shape define all vertices of the shape with a
coordinate like 30.1 10.1, the first of which is the
latitude, the second the longitude.

Examples of valid WKT objects: \itemize{ \item
'POLYGON((30.1 10.1, 10 20, 20 60, 60 60, 30.1 10.1))'
\item 'POINT((30.1 10.1))' \item 'LINESTRING(3 4,10 50,20
25)' \item 'MULTIPOINT((3.5 5.6),(4.8 10.5))")' \item
'MULTILINESTRING((3 4,10 50,20 25),(-5 -8,-10 -8,-15 -4))'
\item 'MULTIPOLYGON(((1 1,5 1,5 5,1 5,1 1),(2 2,2 3,3 3,3
2,2 2)),((6 3,9 2,9 4,6 3)))' \item
'GEOMETRYCOLLECTION(POINT(4 6),LINESTRING(4 6,7 10))' }

Only POLYGON objects are currently supported.
}
\examples{
\dontrun{
# Single data sources
occ(query = 'Accipiter striatus', from = 'gbif')
occ(query = 'Accipiter striatus', from = 'ecoengine')
occ(query = 'Danaus plexippus', from = 'inat')
occ(query = 'Bison bison', from = 'bison')
# Data from AntWeb
# By species
by_species <- occ(query = "acanthognathus brevicornis", from = "antweb")
# or by genus
by_genus <- occ(query = "acanthognathus", from = "antweb")

occ(query = 'Setophaga caerulescens', from = 'ebird', ebirdopts = list(region='US'))
occ(query = 'Spinus tristis', from = 'ebird', ebirdopts =
   list(method = 'ebirdgeo', lat = 42, lng = -76, dist = 50))

# Many data sources
out <- occ(query = 'Pinus contorta', from=c('gbif','inat'))

## Select individual elements
out$gbif
out$gbif$data

## Coerce to combined data.frame, selects minimal set of columns (name, lat, long)
occ2df(out)

# Pass in limit parameter to all sources. This limits the number of occurrences
# returned to 10, in this example, for all sources, in this case gbif and inat.
occ(query='Pinus contorta', from=c('gbif','inat'), limit=10)

# Geometry
## Pass in geometry parameter to all sources. This constraints the search to the
## specified polygon for all sources, gbif and bison in this example.
occ(query='Accipiter striatus', from='gbif',
   geometry='POLYGON((30.1 10.1, 10 20, 20 60, 60 60, 30.1 10.1))')
occ(query='Helianthus annuus', from='bison',
   geometry='POLYGON((-111.06 38.84, -110.80 39.37, -110.20 39.17, -110.20 38.90, -110.63 38.67, -111.06 38.84))')

## Or pass in a bounding box, which is automatically converted to WKT (required by GBIF)
## via the bbox2wkt function
occ(query='Accipiter striatus', from='gbif', geometry=c(-125.0,38.4,-121.8,40.9))

## Bounding box constraint with ecoengine
occ(query='Accipiter striatus', from='ecoengine', limit=10, geometry=c(-125.0,38.4,-121.8,40.9))

## You can pass in geometry to each source separately via their opts parameter, at
## least those that support it. Note that if you use rinat, you reverse the order, with
## latitude first, and longitude second, but here it's the reverse for consistency across
## the spocc package
bounds <- c(-125.0,38.4,-121.8,40.9)
occ(query = 'Danaus plexippus', from="inat", inatopts=list(bounds=bounds))

## Same, but passing in via the global geometry parameter
occ(query = 'Danaus plexippus', from="inat", geometry=bounds)

## Passing geometry with multiple sources
occ(query = 'Danaus plexippus', from=c("inat","gbif","ecoengine"), geometry=bounds)

# Specify many data sources, another example
ebirdopts = list(region = 'US'); gbifopts  =  list(country = 'US')
out <- occ(query = 'Setophaga caerulescens', from = c('gbif','inat','bison','ebird'),
gbifopts = gbifopts, ebirdopts = ebirdopts)
occ2df(out)

# Pass in many species names, combine just data to a single data.frame, and
# first six rows
spnames <- c('Accipiter striatus', 'Setophaga caerulescens', 'Spinus tristis')
out <- occ(query = spnames, from = 'gbif', gbifopts = list(georeferenced = TRUE))
df <- occ2df(out)
head(df)


# taxize integration: Pass in taxonomic identifiers
library(taxize)
ids <- get_ids(names=c("Chironomus riparius","Pinus contorta"), db = c('itis','gbif'))
occ(ids = ids[[1]], from='bison')
occ(ids = ids, from=c('bison','gbif'))

ids <- get_ids(names="Chironomus riparius", db = 'gbif')
occ(ids = ids, from='gbif')

ids <- get_gbifid("Chironomus riparius")
occ(ids = ids, from='gbif')

ids <- get_tsn('Accipiter striatus')
occ(ids = ids, from='bison')
}
}

