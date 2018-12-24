#!/usr/bin/env Rscript
#
# Roman Moser, 12/23/18
# R Programming Test: "Automatic recognition of outage"
# run with: Rscript outage.R

library(zoo)
data <- read.csv('data.csv')

# To find outage, I calculate the  moving average to find points where average starts to 
# change in certain direction. I use a stride of 3 and a window size of 50
stride <- 3
window_size <- 50
mean_value <- rollapply(data$value, width = window_size, by = stride, align="left", FUN = mean)
# find point when mean values start to increase continuously:
mean_increase <- diff(mean_value) > 0
rle_mean_inc <- rle(mean_increase)
rle_true <- rle_mean_inc$lengths * rle_mean_inc$values
index_rle <- match(max(rle_true), rle_true)
outage_a <- (cumsum(rle_mean_inc$lengths)[index_rle] - max(rle_true)) * stride + window_size
# find point when mean values start to decrease continuously:
mean_decrease <- diff(mean_value) < 0
rle_mean_dec <- rle(mean_decrease)
rle_true <- rle_mean_dec$lengths * rle_mean_dec$values
index_rle <- match(max(rle_true), rle_true)
outage_b <- (cumsum(rle_mean_dec$lengths)[index_rle] - max(rle_true)) * stride + window_size

outage_start <- min(outage_a, outage_b)
outage_end <- max(outage_a, outage_b)
start_outage <- data$transactiondate[outage_start]
end_outage <- data$transactiondate[outage_end]

print(paste("outage start was at:", start_outage))
print(paste("outage end was at:", end_outage))

plot(data$transactiondate, data$value, main="Outage recognition", ylab="Probability score")
abline(v=start_outage, col="red")
abline(v=end_outage, col="red")
