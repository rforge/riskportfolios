\name{covEstimation}
\alias{covEstimation}
\title{
Covariance matrix estimation
}
\description{
Function which performs various estimations of covariance matrices.
}
\usage{
covEstimation(rets, control = list())
}
\arguments{
  \item{rets}{a matrix \eqn{(T \times N)}{(T x N)} of returns.}
  \item{control}{control parameters (see *Details*).}
}
\details{%
The argument \code{control} is a list that can supply any of the following components:
\describe{%
    \item{\code{type}}{method used to compute the covariance matrix, among \code{'naive'}, \code{'ewma'}, \code{'lw'}, \code{'factor'},\code{'const'}, \code{'cor'}, \code{'oneparm'}, \code{'diag'} and \code{'large'} where:
    
\code{'naive'} is used to compute the naive covariance matrix.

\code{'ewma'} is used to compute the exponential weighting moving average covariance matrix. The following 
formula is used to compute de ewma covariance matrix:

\deqn{\Sigma_t := \lambda \Sigma_{t-1} + (1-\lambda)r_{t-1}r_{t-1}}{Sigma[t] := lambda * Sigma[t-1] + (1-lambda) r[t-1]'r[t-1]}

where \eqn{r_t} is the \eqn{(N \times 1)}{(N x 1)} vector of returns at time \eqn{t}. Note that the data must be 
sorted from the oldest to the latest.

\code{'factor'} is used to compute the covariance matrix estimation using a K-factor approach.

\code{'lw'} is a weighted average of the sample covariance matrix and a "prior" or "shrinkage target". The prior is 
given by a one-factor model and the factor is equal to the cross-sectional average of all the 
random variables. See Ledoit and Wolf (2003).

\code{'const'} is a weighted average of the sample covariance matrix and a "prior" or "shrinkage target". 
The prior is given by  constant correlation matrix.

\code{'cor'} is a weighted average of the sample covariance matrix and a "prior" or "shrinkage target". 
The prior is given by the constant correlation covariance matrix given by Ledoit and Wolf (2003)

\code{'oneparm'} is a weighted average of the sample covariance matrix and a "prior" or "shrinkage target". 
The prior is given by the one-parameter matrix. All variances are the same and all covariances are zero.

\code{'diag'} is a weighted average of the sample covariance matrix and a "prior" or "shrinkage target". 
The prior is given by a diagonal matrix.

\code{'large'} This estimator is a weighted average of the sample covariance matrix and a "prior" or "shrinkage target". Here, the prior is given by a one-factor model. The factor is equal to the cross-sectional average of all the random variables. The weight, or "shrinkage intensity" is chosen to minimize quadratic loss measured by the Frobenius norm. The estimator is valid as the number of variables and/or the number of observations go to infinity, but Monte-Carlo simulations show that it works well for values as low as 10. The main advantage is that this estimator is guaranteed to be invertible and well-conditioned even if variables  outnumber observations.

\code{'bs'} is the Bayes-Stein estimator for the covariance matrix given by Jorion (1986).

Default: \code{type = 'naive'}
}

\item{\code{lambda}}{decay parameter.
Default: \code{lambda = 0.94}.}
    
\item{\code{K}}{number of factors to use when the K-factor approach is chosen to estimate the covariance matrix.
Default: \code{K = 1}.}
}
}
\value{
A \eqn{(N \times N)}{(N x N)} covariance matrix.
}
\note{
Part of the code is inspired from the Matlab code by Ledoit and Wolf.
}
\references{
  Herold, U., Maurer, R. (2006). 
  Portfolio choice and estimation risk. A comparison of bayesian to heuristic approaches
  \emph{Astin bulletin} \bold{36}(1), pp.135--160.
  
  Kolusheva, Daniela. (July 2008).
  Out-of-sample Performance of Asset Allocation Strategies
  Ledoit, O., Wolf, M. (2002).
  Improved estimation of the covariance matrix of stock returns with an application to portfolio selection
  \emph{Journal of Empirical Finance } \bold{10}, pp.603--621.
  
  Ledoit, O., Wolf, M. (2003). 
  Honey, I Shrunk the Sample Covariance Matrix. 
  \emph{The Journal of Portfolio Management} \bold{30}(4), pp.110--119.
  
  Ledoit, O., Wolf, M. (2004). 
  A well-conditioned estimator for large-dimensional covariance matrices
  \emph{Journal of Multivariate Analysis} \bold{88}, pp.365--411.
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

# Computes the naive covariance estimation.
covEstimation(rets)

#Computes the ewma estimation of the covariance with default lambda = 0.94.
covEstimation(rets, control = list(type = "ewma"))

#Computes the ewma estimation of the covariance with default lambda = 0.90.
covEstimation(rets, control = list(type = "ewma", lambda = 0.9))

#Computes the factor estimation of the covariance with dafault K = 1.
covEstimation(rets, control = list(type = "factor"))

#Computes the factor estimation of the covariance with K = 3.
covEstimation(rets, control = list(type = "factor", K = 3))

#Computes the Ledot-Wolf's estimation of the covariance.
covEstimation(rets, control = list(type = "lw"))

#Shrinkage of the covariance matrix using constant correlation matrix.
covEstimation(rets, control = list(type = "const"))

#Shrinkage of the covariance matrix towards constant correlation matrix by Ledoit-Wolf.
covEstimation(rets, control = list(type = "cor"))

#Shrinkage of the covariance matrix towards one-parameter matrix.
covEstimation(rets, control = list(type = "oneparm"))

#Shrinkage of the covaraince matrix towards diagonal matrix.
covEstimation(rets, control = list(type = "diag"))

#Shrinkage of the covariance matrix for large data set.
covEstimation(rets, control = list(type = "large"))
}
\keyword{htest}