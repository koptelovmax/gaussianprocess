#install.packages("pbkrtest", dependencies=TRUE)
#install.packages("hexbin")

library(hexbin)

set.seed(123)
x <- rnorm(200, 0, 100) # n, mean, sd
x2 <- rnorm(200, 0, 100) # n, mean, sd
hist(x1, xlab="x1", ylab="N", breaks="FD")
hist(x2, xlab="x2", ylab="N", breaks="FD")
hist(x1, freq=FALSE, xlab="x", ylab="relative frequency",breaks="FD", main="Histogram und normal PDF")
rug(jitter(x1))
curve(dnorm(x, mean(x), sd(x)), lwd=2, col="blue", add=TRUE)

hist(x, freq=FALSE, xlab="x", breaks="FD",main="Histogram and density estimate")
lines(density(x), lwd=2, col="blue")
rug(jitter(x))

plot(x,x2)
IV  <- gl(2, 5)
plot(x,x2,pch=c(4,16)[unclass(IV)],lwd=2,col=c("black","blue")[unclass(IV)],main="Joint distribution per group")

xx <- seq(-100, -100, 0)
plot(x,xx)

library(car)
dataEllipse(x,x2)
