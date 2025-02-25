# TimeGate

TimeGate is a machine learning-based approach to analyze and predict logic depth in RTL designs. It integrates Python for data processing and visualization, along with EDA Playground for RTL simulations.

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

