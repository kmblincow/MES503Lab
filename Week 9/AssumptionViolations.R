#Examples of Assumption Violation Plots

smile_x <- seq(-0.4, 0.4, length.out = 100)
smile_y <- 2 * (smile_x)^2 - 0.4  # y = ax^2 + c

#Non-linearity
d_nonlinear <- data.frame(y = smile_y + rnorm(100, .1, .05),
                x = 1:100 + rnorm(100, 10, 5))

plot(d_nonlinear$x, d_nonlinear$y)

m1 <- lm(y ~ x, data = d_nonlinear)
plot(m1)


# Equal Variance
d_variance <- data.frame(y = c(1:20 + rnorm(20, 1, 1),
                               21:40 + rnorm(20, 1, 5),
                               41:60 + rnorm(20, 1, 10),
                               61:80 + rnorm(20, 1, 25),
                               81:100 + rnorm(20, 1, 50)),
                          x = 1:100 )

plot(d_variance$x, d_variance$y)

m2 <- lm(y ~ x, data = d_variance)
plot(m2)

