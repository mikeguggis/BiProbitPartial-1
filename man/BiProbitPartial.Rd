% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BiProbitPartialR.R
\name{BiProbitPartial}
\alias{BiProbitPartial}
\title{Bivariate probit with partial observability}
\usage{
BiProbitPartial(formula, data, subset, na.action,
  philosophy = "bayesian", control = list())
}
\arguments{
\item{formula}{an object of class \link[Formula]{Formula}: a symbolic
description of the model to be fitted. The details of model specification
are given under 'Details'.}

\item{data}{an optional data frame, list or environment (or object coercible
by \link{as.data.frame} to a data frame) containing the variables in the 
model. If not found in \code{data}, the variables are taken from 
\code{environment(formula)}, typically the environment from which 
\code{BiProbitPartial} is called.}

\item{subset}{an optional vector specifying a subset of observations to be
used in the fitting process.}

\item{na.action}{a function which indicates what should happen when the data
contain \code{NA} observations. The default is set by the \code{na.action} setting of
\link{options}, and is \link{na.fail} if that is unset. The 'factory-fresh'
default is \link{na.omit}. Another possible value is \code{NULL}, no action.
Value \link{na.exclude} can be useful.}

\item{philosophy}{a character string indicating the philosophy to be used
for estimation. For Bayesian MCMC estimation \code{philosophy =
 "bayesian"} should be used. For frequentist maximum likelihood estimation 
 \code{philosophy = "frequentist"} should be used. The default is Bayesian
  MCMC estimation.}

\item{control}{a list of control parameters. See 'Details'.}
}
\value{
\code{BiProbitPartial} returns an \eqn{S \times (k_1+k_2+1)
 \times nchains}{S x (k[1]+k[2]+1) x nchains} array of MCMC draws of primary 
 class \code{mcmc.list} and secondary class \code{BiProbitPartialb}, if 
 \code{philosophy = "bayesian"}. Each element in the 
 first dimension represents a MCMC draw. The first \eqn{k_1}{k[1]} elements 
 in the second dimension are draws for the coefficientss in the first 
 equation. The next \eqn{k_2}{k[2]} elements of the second dimension are draws 
 for the coefficients in the second equation. The last element of the second 
 dimension are draws for the correlation parameter. The elements of the 
 third dimension are the chains. If \eqn{\rho} was fixed 
 (\code{fixrho = TRUE}) then each draw for the last element in the second 
 dimension is returned as the value it was fixed at (the starting value, 
 \code{rho}).

If \code{philosophy = "frequentist"} a list equivalent to the
 output \link[optimr]{optimr} with primary class \code{optimrml} and secondary
 class \code{BiProbitPartialf}.
}
\description{
\code{BiProbitPartial} estimates a bivariate probit with partial 
observability model. 

The bivariate probit with partial observability model is defined as follows.
Let \eqn{i} denote the \eqn{i}th observation which takes values from \eqn{1}
to \eqn{N}, \eqn{X_1}{X[1]} be a covariate matrix of dimension 
\eqn{N \times k_1}{N x k[1]}, \eqn{X_2}{X[2]} be a covariate matrix of 
dimension \eqn{N \times k_2}{N x k[2]}, \eqn{X_{1i}}{X[1i]} be the \eqn{i}th
row of \eqn{X_1}{X[1]}, \eqn{X_{2i}}{X[2i]} be the \eqn{i}th row of 
\eqn{X_2}{X[2]}, \eqn{\beta_1}{\beta[1]} be a coefficient vector of length 
\eqn{k_1}{k[1]} and \eqn{\beta_2}{\beta[2]} be a coefficient vector of length 
\eqn{k_2}{k[2]}. Define the latent response for stage one to be 
\deqn{y_{1i}^\star = X_{1i} \beta_1 + \epsilon_{1i}}{y[1i]* = X[1i] \beta[1] + \epsilon[1i]} 
and stage two to be 
\deqn{y_{2i}^\star = X_{2i} \beta_2 + \epsilon_{2i}.}{y[2i]* = X[2i] \beta[2] + \epsilon[2i].} 
Note the stages do not need to occur sequentially. Define the outcome of 
the first stage to be
\eqn{y_{1i} = 1}{y[1i] = 1} if \eqn{y_{1i}^\star > 0}{y[1i]* > 0} and 
\eqn{y_{1i} = 0}{y[1i] = 0} if \eqn{y_{1i}^\star \leq 0}{y[1i]* <= 0}. 
Define the outcome of the second stage to be 
\eqn{y_{2i} = 1}{y[2i] = 1} if \eqn{y_{2i}^\star > 0}{y[2i]* > 0} and 
\eqn{y_{2i} = 0}{y[2i] = 0} if \eqn{y_{2i}^\star \leq 0}{y[2i]* <= 0}.
 The observed outcome is the product of the outcomes from the two stages 
 \deqn{z_{i} = y_{1i} y_{2i}.}{z[i] = y[1i] y[2i].} The pair 
 \eqn{(\epsilon_{1i},\epsilon_{2i})}{(\epsilon[1i],\epsilon[2i])} is distributed independently 
 and identically multivariate normal with means 
 \eqn{E[\epsilon_{1i}] = E[\epsilon_{2i}] = 0}{E(\epsilon[1i]) = E(\epsilon[2i]) = 0}, 
 variances 
 \eqn{Var[\epsilon_{1i}] = Var[\epsilon_{2i}] = 1}{Var(\epsilon[1i]) = Var(\epsilon[2i]) = 1},
 and correlation (or equivalently covariance) 
 \eqn{Cov(\epsilon_{1i},\epsilon_{2i}) = \rho}{Corr(\epsilon[1i],\epsilon[2i]) = \rho}.
 A more general structural representation is presented in Poirier (1980).
 
 The model can be estimated by Bayesian Markov Chain Monte Carlo (MCMC) or 
 frequentist maximum likelihood methods. The correlation parameter \eqn{\rho} can be
 estimated or fixed. The MCMC algorithm used is a
 block Gibbs sampler within Metropolis-Hastings scheme developed by 
 Rajbhandari (2014). The default maximum likelihood method is based off the 
 Broyden–Fletcher–Goldfarb–Shanno (BFGS) algorithm. 
 A modification of the algorithm is 
 used to include box constraints for when \eqn{\rho} is estimated. See 
 \link[optimr]{optimr} for details.
}
\details{
Models for \code{BiProbitPartial} are specified symbolically. A typical
 model has the form \code{response ~ terms1 | terms2} where \code{response}
 is the name of the (numeric binary) response vector and \code{terms1} and \code{terms2}
 are each a series of terms which specifies a linear predictor for latent response 
 equations 1 and 2. A \code{terms1} specification of the form \code{first + second} 
 indicates all the terms in \code{first} together with all the terms
 in \code{second} with duplicates removed. A specification of the form
 \code{first:second} indicates the set of terms obtained by taking the
 interactions of all terms in \code{first} with all terms in \code{second}.
 The specification \code{first*second} indicates the cross of
 \code{first} and \code{second}. This is the same as 
 \code{first + second + first:second}. Likewise for \code{terms2}.

A Formula has an implied intercept term for both equations. To remove the
 intercept from equation 1 use either \code{response ~ terms1 - 1 | terms2}
 or \code{response ~ 0 + terms1 | terms2}. It is analgous to remove the
 intercept from the equation 2.
 
If \code{philosophy = "bayesian"} is specified then the model is
 estimated by MCMC methods based on Rajbhandari (2014). The prior for the
 parameters in equations 1 and 2 is multivariate normal with mean \code{beta0}
 and covariance \code{B0}. The prior for \eqn{\rho} is truncated normal on the 
 interval \eqn{[-1,1]} with mean parameter \code{rho0} and variance parameter
 \code{v0} and is assumed to be apriori independent of the parameters in 
 equations 1 and 2. 
 
 If \code{philosophy = "frequentist"} then the model is
 estimated by frequentist maximum likelihood using \code{optimr} from the package
 \pkg{optimr}.

The \code{control} argument is a list that can supply the tuning parameters
 of the Bayesian MCMC estimation and frequentist maximum likelihood
 estimation algorithms. For frequentist maximum likelihood the \code{control} 
 argument is passed directly to \code{control} in the function \code{optimr}
  from the package \pkg{optimr}. If one wants to specify the \code{method} for
  the function \code{optimr} then \code{method} must be passed as an element 
  of \code{control}. See \link[optimr]{optimr} for further details.
  
 The 
 \code{control} argument can supply any of the following components for 
 Bayesian MCMC estimation.
 
 \describe{
 
 \item{beta}{Numeric vector or list of \code{nchains} 
  elements each a numeric vector supplying starting values for the coefficients
  in equations 1 and 2. For each vector, the first \eqn{k_1}{k[1]} values are for the 
  coefficients in the first equation. The second \eqn{k_2}{k[2]} values are for 
  the coefficients in the second equation. Default is \code{beta = numeric( k1 + k2 )}, 
  a vector of zeros.}
  
 \item{rho}{Numeric or list of \code{nchains} elements each a numeric starting 
 value for \eqn{\rho}. Default is \code{rho = 0}.}
 
 \item{fixrho}{Logical value to determine if \eqn{\rho} is estimated. If 
  \code{fixrho = TRUE} then \eqn{\rho} is fixed at value \code{rho}. Default 
  is \code{fixrho = FALSE}.}
 
 \item{S}{Number of MCMC iterations. Default is \code{S = 1000}. For
  \code{philosophy = "bayesian"} only.}
  
 \item{burn}{Number of initial pre-thinning MCMC iterations to remove after
  estimation. Default is \code{burn = floor(S/2)}, the floor of the number 
  of MCMC iterations divided by 2. For \code{philosophy = "bayesian"} only.}
  
 \item{thin}{Positive integer to keep every \code{thin} post-burn in MCMC draw
  and drop all others. Default is \code{thin = 1}, keep all post burn-in draws. 
  For \code{philosophy = "bayesian"} only.}
  
  \item{seed}{Positive integer for \code{nchains = 1} or list of \code{nchains} 
  elements each a positive integer fixing the seed of the random number generator. 
  Typically used for replication. Default is \code{seed = NULL}, no seed. For 
  \code{philosophy = "bayesian"} only.}
  
  \item{nchains}{Positive integer specifying the number of MCMC chains. Default is 
  \code{nchains = 1}. For \code{philosophy = "bayesian"} only.}
  
 \item{beta0}{Numeric vector supplying the prior mean for the coefficients of
  equations 1 and 2. The first \eqn{k_1}{k[1]} components are for the coefficients
  of equation 1. The second \eqn{k_2}{k[2]} components are for the coefficients of
  equation 2. Default is \code{beta0 = numeric( k1 + k2 )}, a vector of zeros. 
  For \code{philosophy = "bayesian"} only.}
 
 \item{B0}{Numeric matrix supplying the prior covariace of the parameters of
  equations 1 and 2. The first \eqn{k_1}{k[1]} rows are for the parameters of 
  equation 1. The second \eqn{k_2}{k[2]} rows are for the parameters of equation 
  2. Likewise for columns. If unspecified the default is set such that the
  inverse of \eqn{B0} is a zero matrix of dimension \eqn{(k_1+k_2) \times 
  (k_1+k_2)}{(k[1]+k[2]) x (k[1]+k[2])}, a 'flat' prior. For 
  \code{philosophy = "bayesian"} only.}
 
 \item{rho0}{Numeric value supplying a prior parameter for \eqn{\rho} which is
  the mean of a normal distribution that is truncated to the interval
  \eqn{[-1,1]}. Default is \code{rho0 = 0}. For
  \code{philosophy = "bayesian"} only.}
  
  \item{v0}{Numeric value supplying a prior parameter for \eqn{\rho} which is
  the variance of a normal distribution that is truncated to the interval
  \eqn{[-1,1]}. Default is \code{v0 = 1}. For
  \code{philosophy = "bayesian"} only.}
  
 \item{nu}{Numeric degrees of freedom parameter for setting the degrees of 
 freedom for \eqn{\rho}'s proposal t-distribution. Default is \code{nu = 10}.}
 
 \item{tauSq}{Numeric scaling parameter for scaling \eqn{\rho}'s proposal t-distribution.
 Default is \code{tauSq = 1}.}
 
 \item{P}{Determines how aggressive proposal draws for \eqn{\rho} are.
  Set to \code{P = 0} normal or \code{P = -1} for aggresive. See Rajbhandari
  (2014) and for details. Default is \code{P = 0}. For \code{philosophy =
  "bayesian"} only.}
  
  \item{trace}{Numeric value determining the value of intermediate reporting.
  A negative value is no reporting, larger positive values provide higher 
  degrees of reporting.}
 
 }
 
 Note: If the Bayesian MCMC chains appear to not be converging and/or frequentist
 maximum likelihood produces errors with \code{summary}, the model may be
 unidentified. One possible solution is to add regressors to the first equation 
 that are exluded from the second equation or visa-versa. See Poirier (1980) for
 more details.
}
\examples{
data('Mroz87',package = 'sampleSelection')
Mroz87$Z = Mroz87$lfp*(Mroz87$wage >= 5)

f1 = BiProbitPartial(Z ~ educ + age + kids5 + kids618 + nwifeinc | educ + exper + city, 
     data = Mroz87, philosophy = "frequentist")
summary(f1)

# Use the estimates from the frequenist philosophy as starting values
b1 = BiProbitPartial(Z ~ educ + age + kids5 + kids618 + nwifeinc | educ + exper + city, 
    data = Mroz87, philosophy = "bayesian", 
    control = list(beta = f1$par[1:(length(f1$par)-1)], rho = tail(f1$par,1)))
summary(b1)

\dontrun{#The example used in the package sampleSelection is likely unidentified for 
this model
f2 = BiProbitPartial(Z ~ educ + age + kids5 + kids618 + nwifeinc | educ, 
     data = Mroz87, philosophy = "frequentist") #crashes
summary(f2) #crashes (f2 non-existent)

# Bayesian methods typically still work for unidentified models
b2 = BiProbitPartial(Z ~ educ + age + kids5 + kids618 + nwifeinc | educ, 
    data = Mroz87, philosophy = "bayesian", 
    control = list(beta = f1$par[1:(length(f1$par)-3)], rho = tail(f1$par,1)))
summary(b2)   
}

}
\references{
\cite{Poirier, Dale J. (1980). "Partial Observability in bivariate probit models" Journal of Econometrics 12, 209-217. (Identification)}

\cite{Rajbhandari, Ashish (2014). "Identification and MCMC estimation of bivariate probit model with partial observability." Bayesian Inference in Social Sciences (eds I. Jeliazkov and X. Yang). (MCMC algorithm)}
}
\author{
\code{BiProbitPartial} was written by Michael Guggisberg. The majority of
 the MCMC estimation was written by Amrit Romana based on Rajbhandari
  (2014). The development of this package was partially funded by the 
  Institude for Defense Analyses (IDA).
}
