
### The argument `prob` in the function `sample()`

We have seen the function `sample()`, but so far, have only used it when we were sampling uniformly at random. That is, all the values are equally likely. We can sample according to a weighted probability, though, by putting in a vector of probabilities. Let's look at the example of net gain while betting on red on a roulette spin. Recall that if we bet a dollar on red, then our net gain is $+1$ with a probability of $\displaystyle \frac{18}{38}$ and $-1$ with a probability of $\displaystyle \frac{20}{38}$. 


1. Exercise: Update the code below to look at the probability of landing on a green in roulette (*N.B. There are only 2 green in roulette)

```{webr-r}

gain <- c(1,-1) # define the gain for a single spin
prob_gain <- c(18/38,20/38) #define the corresponding probabilities
exp_gain <- sum(gain*prob_gain)
exp_gain

set.seed(123)
#simulate gain from 10 spins of the wheel
sample(x = gain, size = 10, prob = prob_gain, replace = TRUE)

# simulate net gain from 10 spins of the wheel which would sum these
sum(sample(x = gain, size = 10, prob = prob_gain, replace = TRUE))

```

Here is a simulation showing the Central Limit Theorem at work, with the empirical distribution becoming gradually more bell-shaped. Net gain is the sum of $n$ draws with replacement from the vector `gain` defined above using the `prob_gain` vector. 

```{webr-r, include = FALSE}
library(ggplot2)
library(patchwork)


set.seed(123)
N = 1000
results1 <- replicate(n = N, expr =sum(sample(gain, size = 10, 
                                              prob = prob_gain, replace = TRUE)))
p1 <- data.frame(results1) |>
  ggplot(mapping = aes(x = results1)) +
  geom_histogram(mapping = aes(y = ..density..), bins = 12, color = "grey", 
                 fill = "blue",alpha = 0.8) +
  scale_x_continuous(breaks = seq(from = -10, to = 10, by = 2)) + 
  geom_vline(xintercept = exp_gain*10,lwd = 1, color = "black") +
  geom_vline(xintercept = mean(results1),lwd = 1, color = "darkred") +
  labs(title = "N = 10", 
       x = "net gain", 
       y = "probability") + theme_minimal()

set.seed(123)
results2 <- replicate(n = N, expr =sum(sample(gain, size = 100, 
                                             prob = prob_gain, replace = TRUE)))
p2 <- data.frame(results2) |>
  ggplot(mapping = aes(x = results2)) +
  geom_histogram(mapping = aes(y = ..density..), bins = 20, color = "grey", 
                 fill = "darkblue", alpha = 0.8) +
  scale_x_continuous(breaks = seq(from = -35, to = 30, by = 5)) + 
   geom_vline(xintercept = mean(results2),lwd = 1.5, color = "black") +
  geom_vline(xintercept =exp_gain*100,lwd = 1, color = "darkred") +
  labs(title = "N = 100", 
       x = "Net gain", 
       y = "probability") + theme_minimal()


set.seed(123)
results3 <- replicate(n = N, expr =sum(sample(gain, size = 1000, 
                                              prob = prob_gain, replace = TRUE)) )

p3 <- data.frame(results3) |>
  ggplot(mapping = aes(x = results3)) +
  geom_histogram(mapping = aes(y = ..density..), bins = 40,color = "grey", 
                 fill = "darkblue", alpha = 0.8) +
  scale_x_continuous(breaks = seq(from = -200, to = 100, by = 20)) + 
  geom_vline(xintercept = mean(results3),lwd = 1.5, color = "black") +
  geom_vline(xintercept =exp_gain*1000,lwd = 1, color = "darkred") +
  labs(title = "N = 1,000", 
       x = "Net gain", 
       y = "probability") + theme_minimal()


set.seed(123)
results4 <- replicate(n = N, expr =sum(sample(gain, size = 5000, 
                                              prob = prob_gain, replace = TRUE)) )

p4 <- data.frame(results4) |>
  ggplot(mapping = aes(x = results4)) +
  geom_histogram(mapping = aes(y = ..density..), bins = 50,color = "grey", 
                 fill = "darkblue", alpha = 0.8) +
  scale_x_continuous(breaks = seq(from = -600, to = 100, by = 50)) + 
  geom_vline(xintercept = mean(results4),lwd = 1.5, color = "black") +
  geom_vline(xintercept =exp_gain*5000,lwd = 1, color = "darkred") +
  labs(title = "N = 5,000", 
       x = "Net gain", 
       y = "probability") + theme_minimal()


p1 + p2 + p3 + p4 + plot_annotation(
  title = "Empirical distribution of net gain after N spins (notice the spreads!)",
  subtitle = "Expected net gain (-0.0526*N) in dollars is in red and average (from data) net gain in dollars is in black"
)
```