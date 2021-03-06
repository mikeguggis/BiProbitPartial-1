# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' MCMC algorithm to sample from bivariate probit with partial
#' observability
#'
#' MCMC1() produces MCMC draws from the posterior of the bivariate
#' probit with partial observability. It does not perform input validation. 
#' It is reccomended to use \code{BiProbitPartial} instead of this function.
#' \code{BiProbitPartial} performs input validation
#' and then calls this function if \code{philosophy == "bayesian"}.
#'
#' @param X1 a matrix of covariates for the first equation
#' @param X2 a matrix of covariates for the second equation
#' @param Z a matrix of response values
#' @param beta1 a matrix of starting values for beta1
#' @param beta2 a matrix of starting values for beta2
#' @param rho a numeric starting value for rho
#' @param fixrho a logical determining if rho is fixed
#' @param S a numeric for the number of MCMC iterations
#' @param beta0 a matrix of the beta prior mean parameter
#' @param B0inv a matrix of the inverse of beta prior covariance parameter
#' @param rho0 a numeric for the mu prior parameter for rho
#' @param v0 a numeric for the Sigma prior parameter for rho
#' @param nu a numeric for MCMC tuning parameter 1
#' @param P a numeric for MCMC tuning parameter 2
#' @param tauSq a numeric for MCMC tuning parameter 3
#' @param seed a numeric seed for determining the random draw sequence
#' @return a matrix of MCMC draws
MCMC1 <- function(X1, X2, Z, beta1, beta2, rho, fixrho, S, beta0, B0inv, rho0, v0, nu, P, tauSq, seed) {
    .Call(`_BiProbitPartial_MCMC1`, X1, X2, Z, beta1, beta2, rho, fixrho, S, beta0, B0inv, rho0, v0, nu, P, tauSq, seed)
}

