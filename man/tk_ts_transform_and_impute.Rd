% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tk-ts-transform-and-impute.R
\name{tk_ts_transform_and_impute}
\alias{tk_ts_transform_and_impute}
\title{Time Series Transformation and Imputation}
\usage{
tk_ts_transform_and_impute(data.tbl, ano_LAST_censo, ano_FIRST_censo)
}
\arguments{
\item{data.tbl}{\code{tibble} agrupado contendo a série histórica de uma
etapa de ensino/escola.}

\item{ano_LAST_censo}{\code{vector} do tipo \code{numeric} contendo o ano
final da série, retornado pela função \code{\link{get_year_LAST_censo}}.}

\item{ano_FIRST_censo}{\code{vector} do tipo \code{numeric} contendo o ano
inicial da série, retornado pela função \code{\link{get_year_FIRST_censo}}.}
}
\value{
Objeto \code{timetk::tk_ts} com a série histórica reordenada e com
    os valores imputados
}
\description{
Ordena a série temporal de cada etapa de ensino/escola e realiza
    a imputação de dados para os valores faltantes, utilizando Exponential
    Weighted Average quando há pelos menos dois valores e Next Observation
    Carried Backwards - NOCB quando hpa apenas o valor do último censo na série.
}
\seealso{
Other forecast: \code{\link{ets_forecast_censo}}
}
\concept{forecast}
\keyword{internal}
