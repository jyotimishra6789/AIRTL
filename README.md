# LogicDepthAI

LogicDepthAI is a machine learning-based approach to analyze and predict logic depth in RTL designs. It integrates Python for data processing and visualization, along with EDA Playground for RTL simulations.

## Problem Statement
Predicting logic depth in digital circuits is crucial for performance optimization. Traditional methods require extensive simulations and manual analysis. This project automates the process using machine learning, reducing effort and improving accuracy.

## Approach Used
The model utilizes a Random Forest Regressor to predict logic depth based on features like Fan-in, Fan-out, Gate Count, Path Length, and Flip-Flops. Data is preprocessed with standard scaling, and training is done using scikit-learn. The approach ensures robustness and adaptability to different circuit configurations.

## Proof of Correctness
The model's accuracy is validated using Mean Absolute Error (MAE) and R-squared (R²) metrics. The scatter plot comparing actual vs. predicted values and the histogram of prediction errors confirm that the model reliably estimates logic depth.

## Complexity Analysis
Training complexity depends on the number of trees in the Random Forest. Each tree operates in O(n log n) time, making the overall training complexity approximately O(m * n log n), where m is the number of trees and n is the dataset size. Prediction is efficient, with an average time complexity of O(log n) per sample.

## Alternatives Considered
Other regression models like XGBoost and Neural Networks were considered but were either computationally expensive or required more data for training. Random Forest was chosen for its balance between accuracy and efficiency.

## Setup & Installation
1. Install Python (version 3.8 or higher).
2. Install required dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Ensure access to [EDA Playground](https://www.edaplayground.com/) for running RTL modules.

## Running the Code
To execute the model, run:
```bash
python DepthAnalyzer.py
```

## Running RTL Modules on EDA Playground
1. Open [EDA Playground](https://www.edaplayground.com/).
2. Select Verilog/VHDL as the HDL language.
3. Upload or write your RTL code.
4. Choose a simulator and click 'Run'.
5. Analyze the timing and verify logic depth.

## Visualization & Performance Analysis
The project includes:
- **Scatter plot**: Compares actual vs. predicted depth.
- **Histogram**: Shows prediction errors.

These help in assessing model accuracy and performance.

## Contributions & License
- Contributions are welcome! Feel free to submit pull requests.
- Licensed under the MIT License.

Let me know if you need any tweaks! 🚀

