############################################
###  Portfolio Returns Graphing Utility  ###
###                                      ###
### Author: Kaspar Lee (@KasparLee)      ###
### Packages: tidyquant, dplyr, ggpplot2 ###
###                                      ###
############################################


# Import libraries
library(tidyquant)
library(dplyr)
library(ggplot2)



# Portfolio items and weightings
# *** These should be updated to include your own portfolio holdings and start date to analyse from ***
# *** Note that the tickers must be named exactly as they appear on Yahoo Finance ***
tickers <- c('VUSA.L', 'VMID.L', 'VFEM.AS', 'INRG.MI', 'STHS.L', 'VGOV.L')
weights <- c(.25, .25, .15, .1, .1, .15)
weightTable <- tibble(symbol = tickers, weights = weights)
startDate = '2013-11-16'



# Load Yahoo Finance stock price data
allStockData <- tq_get(tickers, get='stock.prices', from=startDate)

# Stock data mutated to have daily return column, and weighted daily return column
stockReturns <- allStockData %>%
	group_by(symbol) %>%
	tq_transmute(select = adjusted, mutate_fun = periodReturn, period = 'daily', col_rename = 'returns') %>%
	left_join(weightTable, by = 'symbol') %>%
	mutate(weightedReturn = weights * returns)

# Stock data with cumulative returns at each date
stockReturnsCum <- stockReturns %>%
	group_by(symbol, date) %>%
	summarise(returnsSum = sum(returns)) %>%
	mutate(cumulativeReturn = cumprod(1 + returnsSum))

# Combined/weighted cumulative portfolio returns at each date
portfolioReturns <- stockReturns %>%
	group_by(date) %>%
	summarise(portfolioReturns = sum(weightedReturn)) %>%
	mutate(cumulativeReturn = cumprod(1 + portfolioReturns))



# Function to add labels, ticks etc. to plots
addPlotLayers <- function(ggplotFunc) {
	ggplotFunc + geom_line() + labs(x = 'Date', y = 'Cumulative Returns') + scale_y_continuous(labels = function(x) paste0(x, '%'))
}

# Plot combined portfolio return line graph
portfolioPlot <- addPlotLayers(ggplot(portfolioReturns, aes(x = date, y = (cumulativeReturn - 1) * 100)))
print(portfolioPlot)

# Plot individual holdings return line graph
individualStocksPlot <- addPlotLayers(ggplot(stockReturnsCum, aes(x = date, y = (cumulativeReturn - 1) * 100, group=symbol, color=symbol)))
print(individualStocksPlot)
