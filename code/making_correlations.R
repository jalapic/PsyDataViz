

### Function to Create Specific Correlation:

make.cor <- function(n=20, rho=.6){
theta <- acos(rho)             # corresponding angle
x1    <- rnorm(n, 1, 1)        # fixed given data
x2    <- rnorm(n, 2, 0.5)      # new random data
X     <- cbind(x1, x2)         # matrix
Xctr  <- scale(X, center=TRUE, scale=FALSE)   # centered columns (mean 0)

Id   <- diag(n)                               # identity matrix
Q    <- qr.Q(qr(Xctr[ , 1, drop=FALSE]))      # QR-decomposition, just matrix Q
P    <- tcrossprod(Q)          # = Q Q'       # projection onto space defined by x1
x2o  <- (Id-P) %*% Xctr[ , 2]                 # x2ctr made orthogonal to x1ctr
Xc2  <- cbind(Xctr[ , 1], x2o)                # bind to matrix
Y    <- Xc2 %*% diag(1/sqrt(colSums(Xc2^2)))  # scale columns to length 1

x <- Y[ , 2] + (1 / tan(theta)) * Y[ , 1]     # final new vector
return(data.frame(x,Y)[1:2]) 
}

make.cor()


# create dataset of 4 columns:

xx<-cbind(make.cor(rho=.87),make.cor(rho=.34))


# add two more columns with specified correlations to two other columns

simcor <- function (x, ymean=0, ysd=1, correlation=0) {
  n <- length(x)
  
  y <- rnorm(n)
  z <- correlation * scale(x)[,1] + sqrt(1 - correlation^2) * 
    scale(resid(lm(y ~ x)))[,1]
  yresult <- ymean + ysd * z
  return(yresult)
}

xx$V5<-simcor(xx[,3], correlation=-0.81)
xx$V6<-simcor(xx[,3], correlation=-0.25)
xx$V7<-simcor(xx[,1], correlation=-0.75)
xx$V8<-simcor(xx[,2], correlation=-0.92)
colnames(xx)[1:4]<-paste0("V",1:4)


# rescale variables
xx[,1] <- scales::rescale(xx[,1], to=c(0,10))
xx[,2] <- scales::rescale(xx[,2], to=c(0,50))
xx[,3] <- scales::rescale(xx[,3], to=c(20,310))
xx[,4] <- scales::rescale(xx[,4], to=c(101,150))
xx[,5] <- scales::rescale(xx[,5], to=c(0,20))
xx[,6] <- scales::rescale(xx[,6], to=c(60,160))
xx[,7] <- scales::rescale(xx[,7], to=c(10,30))
xx[,8] <- scales::rescale(xx[,8], to=c(0,10))

xx <- apply(xx,2, round, 2)
write.csv(xx, "data_raw/cordata.csv", row.names=F)
