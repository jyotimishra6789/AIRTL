# TimeGate

## Problem Statement
The goal of this project is to analyze and predict the logic depth of circuits based on various parameters such as Fan-in, Fan-out, Gate Count, Path Length, and Flip-Flops. By leveraging machine learning techniques, the model aims to provide insights into circuit behavior and optimize performance.

## Approach
The project uses a dataset containing circuit parameters and their respective depth values. A **RandomForestRegressor** model is trained on this dataset after standardizing the features. The model's performance is evaluated using **Mean Absolute Error (MAE)** and **R-squared (R²)**. Visualizations like scatter plots and histograms are used to interpret the results.

To set up the environment for running the code, follow these steps:

1. Install Python (version 3.8 or higher).
2. Ensure you have **EDA Playground** access to run RTL modules.

### Dependencies
- **Python 3.8+**
- **NumPy**
- **Pandas**
- **Matplotlib**
- **Scikit-learn**
- **XGBoost**

## Running the Code
To execute the model, run the following command:
```bash
python DepthAnalyzer.py
```

## Running RTL Modules using EDA Playground
EDA Playground is an online tool to simulate RTL modules. Follow these steps to run RTL modules:
1. Open [EDA Playground](https://www.edaplayground.com/).
2. Select the appropriate HDL language (Verilog/VHDL).
3. Upload or write your RTL code in the editor.
4. Choose a simulator and click 'Run' to execute the design.
5. Review the timing analysis and verify logic depth.

## Visualization
The project includes data visualization using **Matplotlib**. The script generates:
- A **scatter plot** comparing actual vs. predicted depth.
- A **histogram** displaying prediction errors.

These help in understanding the model’s accuracy and performance.

## Contributions
Contributions are welcome. Feel free to submit pull requests or report issues.

## License
This project is licensed under the **MIT License**.

