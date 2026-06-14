# time-series-forecasting-R
Time series analysis and forecasting in R using the fpp3 framework. Implements data cleaning, white noise filtering, variance transformations, and comparative forecasting using ARIMA, NNAR, and baseline models.
Project Milestone:** Developed as an academic assessment and awarded a first-class mark of **89%** for technical accuracy, rigorous statistical methodology, and code execution.

This project focuses on the practical application of time series analysis to clean real-world data, stabilize variances, and build accurate predictive models. 

Using R's modern `fpp3` ecosystem, the project demonstrates a complete data pipeline—moving from raw, messy datasets to evaluating advanced machine learning forecasting methods.

---

## 📈 What This Project Does

The workflow is broken down into three logical phases:

### 1. Data Cleaning & Noise Filtering
* **Handling Dates:** Converted raw character data into true chronological timelines using the `lubridate` and `tsibble` packages.
* **Filtering Out the Noise:** Used Autocorrelation Function (ACF) plots to run statistical diagnostic checks. This allowed me to separate pure "White Noise" (random data variations with no predictive value) from true underlying market trends.
* **Simplifying the View:** Removed the useless noise columns and consolidated high-frequency daily data into a clean, weekly summary to make long-term patterns much easier to read.

### 2. Stabilizing Variance & Baseline Models
* **Fixing Wild Swings:** Real-world data often suffers from volatile fluctuations (heteroskedasticity). I tested and mapped Logarithmic, Square Root, and Cube Root transformations to stabilize this volatility.
* **Choosing the Best Approach:** Identified that a **Log Transformation** provided the most stable, consistent variance over time.
* **Setting a Benchmark:** Applied a baseline "Mean" forecasting method to historical pricing data to establish a solid ground floor for measuring future model performance.

### 3. Advanced Predictive Modeling (Statistical vs. Machine Learning)
* **Smart Data Splitting:** Divided the data chronologically (90% training / 10% testing) to ensure models were evaluated on entirely unseen future data.
* **The Classical Approach (ARIMA):** Built a seasonal ARIMA model—specifically an $ARIMA(1,0,0)(1,0,0)_{12}$—to capture short-term momentum and 12-month seasonal patterns.
* **The Machine Learning Approach (NNAR):** Implemented a Neural Network Autoregression model using the exact same seasonal and non-seasonal configurations.
* **The Showdown:** Evaluated both models against the actual test data using Root Mean Squared Error (RMSE) to determine which method generated the most accurate forecasts.

---

## 🛠️ The Tech Stack
* **Language:** R
* **Core Packages:** `tidyverse` (Data manipulation), `fpp3` & `tsibble` (Time series tools), `fable` (Forecasting engine), `feasts` (Statistical features & diagnostics).

## 🚀 Key Skills Showcased
* **Statistical Diagnostics:** Identifying randomness vs. predictable trends using ACF plots.
* **Feature Engineering:** Aggregating data, extracting time features, and applying mathematical transformations.
* **Advanced Modeling:** Training and tuning both traditional econometric models (ARIMA) and neural networks (NNETAR).
* **Model Evaluation:** Using professional accuracy metrics (RMSE) to guide business decisions.
