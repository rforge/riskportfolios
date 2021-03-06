\name{semidevEstimation}
\alias{semidevEstimation}
\title{
Estimation of the semideviation
}
\description{
Function which computes the semideviation
}
\usage{
semidevEstimation(rets, control = list())
}
\arguments{
  \item{rets}{a \eqn{(T \times N)}{(T x N)} matrix of past returns.}
  \item{control}{control parameters (see *Details*).}
}

\details{%
  The argument \code{control} is a list that can supply any of the following components:

  \describe{%
    \item{\code{type}}{method used to compute the semideviation vector, among \code{'naive'} and \code{'ewma'} where:
   
   \code{'naive'} is used to compute the simple semideviation.
   
   \code{'ewma'} is used to compute the exponential weighted moving average semideviation. The data 
   must be sorted from the oldest to the latest.
   
   The semideviation for one stock is computed as follows. First we select the returns which are smaller than 
   the average of the past returns; we get a new vector of dimension \eqn{K \times 1, K \le N}. Then, 
   the weight \eqn{w_i} for each observation at its corresponding time \eqn{t} is computed
   as \eqn{w = \lambda^{t}}. We obtain a \eqn{K \times 1}{Kx1} vector. The vector of weights is then normalized. 
   Finally, the semideviation is obtained as the weighted standard deviation.

   Default: \code{type = 'naive'}.}
    
   \item{\code{lambda}}{decay parameter. Default: \code{lambda = 0.94}.}
  }
}
\value{
A \eqn{(N \times 1)}{(N x 1)} vector of semideviations.
}
\author{
David Ardia <david.ardia@unifr.ch> and Jean-Philippe Gagnon Fleury.
}
\examples{
set.seed(3214)
T = 100
N = 25
rets = matrix(rnorm(T*N), nrow = T, ncol = N)

#Computes the naive semideviation estimation.
semidevEstimation(rets)

#Computes the naive estimation of the semideviation.
semidevEstimation(rets, control = list(type = "naive"))

#Computes the ewma estimation of the semideviation. Default lambda = 0.94.
semidevEstimation(rets, control = list(type = "ewma"))

#Computes the ewma estimation of the semideviation. Lambda = 0.9.
semidevEstimation(rets, control = list(type = "ewma", lambda = 0.9))
}
\keyword{htest}