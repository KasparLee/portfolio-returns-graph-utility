# Portfolio Returns Graph Utility

![language: R](https://img.shields.io/badge/language-R-blue.svg)

A small utility to graph the historical returns of a portfolio of stocks, ETFs or other securities.

Accepts a list of tickers and respective weightings (see top of `portfolio-returns-calculator.R` file), and a start date to draw graphs from.
Generates 2 line graphs:
  - One for the combined, weighted cumulative portfolio returns from the start date
  - Another for the cumulative returns of each holding individually
 
This was build as my very first (small) project while teaching myself R.

Examples of the charts generated:

![Overall Portfolio Returns](/examples/overall_portfolio_returns.png)
![Individual Holding Returns](/examples/individual_holding_returns.png)
