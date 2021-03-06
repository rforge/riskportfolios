\name{optimalPortfolio}
\alias{optimalPortfolio}
\title{
Optimital portfolio}
\description{
Function wich computes the portfolio's weights}
\usage{
optimalPortfolio(Sigma, mu = NULL, semiDev = NULL, control = list())
}
\arguments{
  \item{Sigma}{a \eqn{(N \times N)}{(N x N)} covariance matrix.}
  \item{mu}{a \eqn{(N \times 1)}{(N x 1)} vector of expected returns. Default: \code{mu = NULL}.}
  \item{semiDev}{a vector \eqn{(N \times 1)}{(N x 1)} of semideviation. Default: \code{semiDev = NULL}.}
  \item{control}{control parameters (see *Details*).}
}
\details{
The argument \code{control} is a list that can supply any of the following components:
  \describe{
    \item{\code{type}}{method used to compute the optimal portfolio, 
    among \code{'mv'}, \code{'minvol'}, \code{'invvol'}, \code{'erc'}, \code{'maxdiv'} and \code{'riskeff'} where:  
    %%
    \code{'mv'} is used to compute the weights of the mean-variance portfolio. The weights are computed following this equation:
    %%
    \deqn{w = \frac{1}{\gamma} \Sigma^{-1} \mu }{ w = 1 / \gamma \Sigma^{-1} \mu}
    %%
    \code{'minvol'} is used to compute the weights of the minimum variance portfolio.
    %%
    \code{'erc'} is used to compute the weights of the equal-risk-contribution portfolio. For a portfolio \eqn{w}, 
    the percentage volatility risk contribution of the i-th asset in the portfolio is given by:
    %%
    \deqn{\% RC_i =  \frac{ w_i {[\Sigma w]}_i}{w' \Sigma w} }{ \% RC_i = w_i[\Sigma w]_i / (w' \Sigma w)}
    %%
    Then we compute the optimal portfolio by solving the following optimization problem:
    %%
    \deqn{w = argmin \left\{ \sum_{i=1}^N (\% RC_i - \frac{1}{N})^2 \right\} }{ argmin \{  \sum_{i=1}^{N} (\% RC_i - 1/N)^2\}  }
    %%
    \code{'maxdiv'} is used to compute the weights of the maximum diversification portfolio where:
    %%
    \deqn{ DR(w) = \frac{ w' \sigma}{\sqrt{w' \Sigma w} } \geq 1 }{ DR(w) = (w' \sigma)/(\sqrt(w' \Sigma w)) \ge 1}
    %%
    is used in the optimization problem.
    %%
    \code{'riskeff'} is used to compute the weights of the risk-efficient portfolio:
    %%
    \deqn{w = {argmax}\left\{ \frac{w' J \xi}{ \sqrt{w' \Sigma w}  }\right\} }{w = argmax ( w'J \xi)\sqrt(w'\Sigma w)}
    %%
    where \eqn{J} is a \eqn{(N \times 10)}{(N x 10)} matrix of zeros whose \eqn{(i,j)}-th element is one if the semi-deviation of 
    stock \eqn{i} belongs to decile \eqn{j},\eqn{\xi = (\xi_1,\ldots,\xi_{10})'}.
    %%
    Default: \code{type = 'mv'}
    }
    
    \item{\code{constraint}}{constraint used for the optimization, among \code{'none'}, \code{'lo'} and \code{'gross'} where : 

    \code{'none'} is used to compute the unconstraint portfolio
    
    \code{'lo'} is the long-only constraint.
    
    \code{'gross'} is the gross constraint.
    
    Default: \code{constraint = 'none'}.}   
    \item{\code{gross.c}}{Gross exposure constraint. Default: \code{gross.c = 1.6}.}
    \item{\code{gamma}}{Risk aversion parameter. Default: \code{gamma = 0.89}.}
    }
  }
\value{
A \eqn{(N \times 1)}{(N x 1)} vector of optimal portfolio weights.
}
\references{
  Amenc, N., Goltz, F., Martellini, L., Retowsky, P. (2011). 
  Efficient indexation: An alternatice to cap-weightes indices.
  \emph{Journal of Investment Management} \bold{9}(4), pp.1--23.
  
  Ardia, D., Boudt, K. (2015). 
  Implied expected returns and the choice of a mean-variance efficient portfolio proxy.
  \emph{Journal of Portfolio Management} \bold{41} (4), pp.68--81.
       
  Choueifaty, Y., Coignard, Y., (2008). 
  Toward maximum diversification. 
  \emph{Journal of Portfolio Management} \bold{35} (1), pp.40--51.
  
  Choueifaty, Y., Froidure, T., Reynier, J., (2011). 
  Properties of the most diversified portfolio. 
  \emph{Working paper}.
  
  Das, S., Markowitz, H., Scheid, J., Statman, M., (2010). 
  Portfolio optimization with mental accounts.
  \emph{Journal of Financial and Quantitative Analysis} \bold{45}, pp.311--334.
  
  DeMiguel, V., Garlappi, L., Uppal, R., (2009). 
  Optimal versus naive diversification: How inefficient is the 1/n portfolio strategy.
  \emph{The Review of Financial Studies} \bold{22}(5), pp.1915--1953.
  
  Fan, J., Zhang, J., Yu, K., March (2009). 
  Asset allocation and risk assessment with gross exposure constraints for vast portfolios.
  
  Maillard, S., Roncalli, T., Teiletche, J., (2010). 
  The properties of equally weighted risk contribution portfolios. 
  \emph{Journal of Portfolio Management} \bold{36}(4), pp.60--70.
  
  Martellini, L., (2008). 
  Towards the design of better equity benchmarks. 
  \emph{Journal of Portfolio Management} \bold{34}, Summer,pp.34--41.
}
\author{
David Ardia <david.ardia@fsa.ulaval.ca> and Jean-Philippe Gagnon Fleury.
}
\examples{
# For the examples, we simply generate a 100 x 25 random matrix.
set.seed(3214)
T = 100
N = 25
rets = matrix(rnorm(T*N), nrow = T, ncol = N)

mu    = meanEstimation(rets)
Sigma = covEstimation(rets)
semiDev = semidevEstimation(rets)

#Computes the mean-variance portfolio without constraint and gamma = 0.89.
optimalPortfolio(mu = mu, Sigma = Sigma)

#Computes the mean-variance portfolio without constraint and gamma = 1.
optimalPortfolio(mu = mu, Sigma = Sigma, control = list(gamma = 1))

#Computes the mean-variance portfolio with without and gamma = 0.89.
optimalPortfolio(mu = mu, Sigma = Sigma, control = list(type = "mv"))

#Computes the mean-variance portfolio without constraint and gamma = 0.89.
optimalPortfolio(mu = mu, Sigma = Sigma, control = list(type = "mv", constraint = "none"))

#Computes the mean-variance portfolio with the long only constraint and gamma = 0.89.
optimalPortfolio(mu = mu, Sigma = Sigma, control = list(type = "mv", constraint = "lo"))

#Computes the mean-variance portfolio with the gross constraint, gross constraint parameter = 1.6 and gamma = 0.89.
optimalPortfolio(mu = mu, Sigma = Sigma, control = list(type = "mv", constraint = "gross"))

#Computes the mean-variance portfolio with the gross constraint, gross constraint parameter = 1.2 and gamma = 0.89.
optimalPortfolio(mu = mu, Sigma = Sigma, control = list(type = "mv", constraint = "gross", gross.c = 1.2))

#Computes the minimum volatility portfolio without constraint.
optimalPortfolio(Sigma = Sigma, control = list(type = "minvol"))

#Computes the minimum volatility portfolio without constraint.
optimalPortfolio(Sigma = Sigma, control = list(type = "minvol", constraint = "none"))

#Computes the minimim volatility portfolio with the long only constraint.
optimalPortfolio(Sigma = Sigma, control = list(type = "minvol", constraint = "lo"))

#Computes the minimum volatility portfolio with the gross constraint and the gross constraint parameter = 1.6.
optimalPortfolio(Sigma = Sigma, control = list(type = "minvol", constraint = "gross"))

#Computes the minimum volatility portfolio with the gross constraint and the gross parameter = 1.2.
optimalPortfolio(Sigma = Sigma, control = list(type = "minvol", constraint = "gross", gross.c = 1.2))

#Computes the equal-risk-contribution portfolio without constraint.
optimalPortfolio(Sigma = Sigma, control = list(type = "erc"))

#Computes the equal-risk-contribution portfolio without constraint.
optimalPortfolio(Sigma = Sigma, control = list(type = "erc", constraint = "none"))

#Computes the equal-risk-contribution portfolio with the long only constraint.
optimalPortfolio(Sigma = Sigma, control = list(type = "erc", constraint = "lo"))

#Computes the equal-risk-contribution portfolio with the gross constraint and the gross parameter = 1.6.
optimalPortfolio(Sigma = Sigma, control = list(type = "erc", constraint = "gross"))

#Computes the equal-risk-contribution portfolio with the gross constraint and the gross parameter = 1.2.
optimalPortfolio(Sigma = Sigma, control = list(type = "erc", constraint = "gross", gross.c = 1.2))

#Computes the maximum diversification portfolio without constraint.
optimalPortfolio(Sigma = Sigma, control = list(type = "maxdiv"))

#Computes the maximum diversification portfolio without constraint.
optimalPortfolio(Sigma = Sigma, control = list(type = "maxdiv", constraint = "none"))

#Compute the maximum diversification portoflio with the long only constraint.
optimalPortfolio(Sigma = Sigma, control = list(type = "maxdiv", constraint = "lo"))

#Computes the maximum diversification portfolio with the gross constraint and the gross parameter = 1.6.
optimalPortfolio(Sigma = Sigma, control = list(type = "maxdiv", constraint = "gross"))

#Computes the maximum diversification portfolio with the gross constraint and the gross parameter = 1.2.
optimalPortfolio(Sigma = Sigma, control = list(type = "maxdiv", constraint = "gross", gross.c = 1.2))

#Computes the risk-efficient portfolio without constraint.
optimalPortfolio(Sigma = Sigma, semiDev = semiDev, control = list(type = "riskeff"))

#Computes the risk-efficient portfolio without constraint.
optimalPortfolio(Sigma = Sigma, semiDev = semiDev, control = list(type = "riskeff", constraint = "none"))

#Computes the risk-efficient portfolio with the long only constraint.
optimalPortfolio(Sigma = Sigma, semiDev = semiDev, control = list(type = "riskeff", constraint = "lo"))

#Computes the risk-efficient portfolio with the gross constraint and the gross parameter = 1.6.
optimalPortfolio(Sigma = Sigma, semiDev = semiDev, control = list(type = "riskeff", constraint = "gross"))

#Computes the risk-efficient portfolio with the gross constraint and the gross parameter = 1.2.
optimalPortfolio(Sigma = Sigma, semiDev = semiDev, control = list(type = "riskeff", constraint = "gross", gross.c = 1.2))
}
\keyword{optimize}