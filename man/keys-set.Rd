% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/keys-set.R
\name{keys-set}
\alias{keys-set}
\alias{keys<-}
\alias{assign_keys}
\alias{key_by}
\alias{unkey}
\title{Set keys}
\usage{
keys(.tbl) <- value

assign_keys(.tbl, value)

key_by(.tbl, ..., .add = FALSE, .exclude = FALSE)

unkey(.tbl)
}
\arguments{
\item{.tbl}{Reference data frame .}

\item{value}{Values of keys (converted to \link[tibble:as_tibble]{tibble}).}

\item{...}{Variables to be used as keys defined in similar fashion as in
\code{\link[dplyr:select]{dplyr::select()}}.}

\item{.add}{Whether to add keys to (possibly) existing ones. If \code{FALSE} keys
will be overridden.}

\item{.exclude}{Whether to exclude key variables from \code{.tbl}.}
}
\description{
Key is a vector which goal is to provide information about rows in reference
data frame. Its length should always be equal to number of rows in
data frame. Keys are stored as \link[tibble:lst]{tibble} in attribute \code{"keys"}
and so one data frame can have multiple keys. Data frame with keys is
implemented as class \link[=keyed-df]{keyed_df}.
}
\details{
\code{key_by} ignores grouping when creating keys. Also if \code{.add == TRUE}
and names of some added keys match the names of existing keys the new ones
will override the old ones.

Value for \verb{keys<-} should not be \code{NULL} because it is converted to tibble
with zero rows. To remove keys use \code{unkey()}, \code{\link[=remove_keys]{remove_keys()}} or
\code{\link[=restore_keys]{restore_keys()}}. \code{assign_keys} is a more suitable for piping wrapper for
\verb{keys<-}.
}
\examples{
df <- dplyr::as_tibble(mtcars)

# Value is converted to tibble
keys(df) <- 1:nrow(df)

# This will throw an error
\dontrun{
keys(df) <- 1:10
}

# Use 'vs' and 'am' as keys
df \%>\% key_by(vs, am)

df \%>\% key_by(vs, am, .exclude = TRUE)

df \%>\% key_by(vs) \%>\% key_by(am, .add = TRUE, .exclude = TRUE)

# Override keys
df \%>\% key_by(vs, am) \%>\% dplyr::mutate(vs = 1) \%>\%
  key_by(gear, vs, .add = TRUE)

# Use select helpers
df \%>\% key_by(dplyr::one_of(c("vs", "am")))

df \%>\% key_by(dplyr::everything())

}
\seealso{
\link[=keys-get]{Get keys}, \link[=keys-manipulate]{Manipulate keys}

\link[=key-by-scoped]{Scoped key_by()}
}
