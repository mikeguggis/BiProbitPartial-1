% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BiProbitPartialR.R
\name{predict.BiProbitPartialb}
\alias{predict.BiProbitPartialb}
\title{predict method for class 'BiProbitPartialb'}
\usage{
\method{predict}{BiProbitPartialb}(object, newdata, k1, k2,
  mRule = c(0.5, 0.5), jRule = NULL, ...)
}
\arguments{
\item{object}{a object of class \code{BiProbitPartialb}}

\item{newdata}{a matrix of column dimension k1 + k2 where the first k1 columns
correspond to the predictors of the first equations and the second k2 
columns correspond to predictors of the second equation. If intercepts were
used they need to be explicitly input.}

\item{k1}{a numeric declaring the number of covariates (including intercept) in the first equation}

\item{k2}{a numeric declaring the number of covariates (including intercept) in the second equation}

\item{mRule}{a vector of length 1 or 2. This is the marginal decision rule
for classifying the outcomes for stages 1 and 2. Stage 1 is 
classified as 1 if the probability of stage 1 being 1 is greater
than or equal to \code{mRule[1]}. Likewise for stage 2.  If 
length of \code{mRule} is 1 then that value is recycled. The values of 
\code{mRule} must be between 0 and 1. The default value is \code{mRule = c(0.5,0.5)}.}

\item{jRule}{an optional numerical value between 0 and 1. If specified 
then the observable outcome (both stages being 1) is 1 if the joint
probability of both stages being 1 is greater than jRule. If jRule
is unspecified or set to \code{NULL} then the observable outcome is the product
of the marginal outcomes. The default value is \code{jRule = NULL}. Note, if
\code{jRule} is specified then the observable outcome might not equal the product of stages 1 and 2.}

\item{...}{unused}
}
\value{
method \code{predict.bBiProbitPArtial} returns a data.frame with columns
\describe{

\item{linPredict1}{Predicted mean of the first stage latent outcome. This is tyically not 
interesting for a Bayesian analysis.}

\item{linPredict2}{Predicted mean of the second stage latent outcome. This is tyically not 
interesting for a Bayesian analysis.}

\item{p1.}{Probability the outcome of the first stage is 1}

\item{p.1}{Probability the outcome of the second stage is 1}

\item{p00}{Probability the outcome of both stages is 0}

\item{p01}{Probability the outcome of the first stage is 0 and the second stage is 1}

\item{p10}{Probability the outcome of stage 1 is 1 and stage 2 is 0}

\item{p11}{Probability the outcome of both stages are 1 }

\item{yHat1}{Classification of the outcome for stage 1. This value
is 1 if \code{p1 >= mRule[1]} and 0 else}

\item{yHat2}{Classification of the outcome for stage 2. This value
is 1 if \code{p2 >= mRule[2]} and 0 else}

\item{ZHat}{Classification of the observable outcome.
If \code{jRule} is specified then this value is 1 if \code{p12 >= jRule}
 and 0 else. If \code{jRule} is unspecified then this value is the element-wise product of
 yHat1 and yHat2.}

}
}
\description{
Note this produces a 
Bayesian posterior predictive distribution. This accounts for estimation
uncertainty. If you desire a simple prediction that does not account for estimation
uncertainty then the frequentist philosophy should be used. If \code{nchains} is 
greater than 1 then the chains are combined.
}
\examples{
##
# Perform a prediction with the same covariates the model is estimated with
##

data('Mroz87',package = 'sampleSelection')
Mroz87$Z = Mroz87$lfp*(Mroz87$wage >= 5)

# Run the frequentist version first to get starting values
f1 = BiProbitPartial(Z ~ educ + age + kids5 + kids618 + nwifeinc | educ + exper + city, 
    data = Mroz87, philosophy = "frequentist")

b1 = BiProbitPartial(Z ~ educ + age + kids5 + kids618 + nwifeinc | educ + exper + city, 
    data = Mroz87, philosophy = "bayesian", 
    control = list(beta = f1$par[1:(length(f1$par)-1)], rho = tail(f1$par,1)))

library(Formula)
eqn = Formula::Formula( ~ educ + age + kids5 + kids618 + nwifeinc | educ + exper + city)
matrix1 = model.matrix(eqn, lhs = 0, rhs=1, data= Mroz87)
matrix2 = model.matrix(eqn, lhs = 0, rhs=2, data= Mroz87)
newdat = cbind(matrix1,matrix2) 
preds1 = predict(b1,newdat,k1 = dim(matrix1)[2],k2 = dim(matrix2)[2])
head(preds1)
preds2 = predict(b1,newdat,k1 = dim(matrix1)[2],k2 = dim(matrix2)[2], jRule = .25)

# Compare predicted outcome with realized outcome
head(cbind(Mroz87$Z,preds1$ZHat,preds2$ZHat),20)

}
