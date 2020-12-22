# Portfolio Returns Graph Utility

![language: R](https://img.shields.io/badge/language-R-blue.svg)

A small utility to graph the historical returns of a portfolio of stocks, ETFs or other securities.

Accepts a list of tickers and respective weightings (see top of `portfolio-returns-calculator.R` file), and a start date to draw graphs from.

Generates 2 line graphs:
  - One for the combined, weighted cumulative portfolio returns from the start date
  - Another for the cumulative returns of each holding individually
 
This was built as my very first (small) project while teaching myself R.

Examples of the charts generated:


<img alt="Overall Portfolio Returns" src="/examples/overall_portfolio_returns.png" width="615" />
<img alt="Individual Holding Returns" src="/examples/individual_holding_returns.png" width="700" />
