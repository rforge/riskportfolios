\name{meanEstimation}
\alias{meanEstimation}
\title{
Estimation of mean returns
}
\description{
Function which is used to compute the estimation of the mean returns}
\usage{
meanEstimation(rets, control = list())
}
\arguments{
  \item{rets}{a \eqn{(T \times N)}{(T x N)} matrix of past returns.}
  \item{control}{control parameters (see *Details*).}
}
\details{
  The argument \code{control} is a list that can supply any of the following components:

  \describe{%
    \item{\code{type}}{method used to estimate the mean returns, 
    among \code{'naive'}, \code{'ewma'}, \code{'bs'} and \code{'mart'} where:
   
   \code{'naive'} is used to compute the arithmetic mean of the returns.
   
   \code{'ewma'} is used to compute the exponential weighted moving average mean of the returns. 
   The data must be sorted from the oldest to the latest.
   
   \code{'bs'} is used to compute the Bayes-Stein estimation.
   
   \code{'mart'} is used to compute the Martinelli implied returns.
   
   Default: \code{type = 'naive'}.}
    
   \item{\code{lambda}}{decay parameter. Default: \code{lambda = 0.94}.}
  }
}
\value{
A \eqn{(N \times 1)}{(N x 1)} vector of expected returns. 
}
\references{
  Jorion, P. (2004). 
  Bayes-Stein Estimation for Portfolio Analysis
  \emph{Journal of Finance and Quantitative Analysis} \bold{21}(3), pp.279--292.
}
\author{
David Ardia <david.ardia@unifr.ch> and Jean-Philippe Gagnon Fleury.
}
\examples{
# For the examples, we simply generate a 100 x 25 random matrix.
set.seed(3214)
T = 100
N = 25
rets = matrix(rnorm(T*N), nrow = T, ncol = N)

#Computes the naive estimation of the mean.
meanEstimation(rets)

#Computes the naive estimation of the mean.
meanEstimation(rets, control = list(type = "naive"))

#Computes the ewma estimation of the mean with default lambda = 0.94.
meanEstimation(rets, control = list(type = "ewma"))

#Computes the ewma estimation of the mean with lambda = 0.9.
meanEstimation(rets, control = list(type = "ewma", lambda = 0.9))

#Computes the Martinelli's estimation of the mean.
meanEstimation(rets, control = list(type = "mart"))

#Computes the Bayes-Stein's estimation of the mean.
meanEstimation(rets, control = list(type = "bs"))
}
\keyword{htest}