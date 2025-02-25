import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split, KFold, cross_val_score
from sklearn.ensemble import RandomForestRegressor
from sklearn.preprocessing import StandardScaler, LabelEncoder
from xgboost import XGBRegressor
from sklearn.metrics import mean_absolute_error, r2_score


data1 = {
    'Time': [30000, 50000, 70000, 90000, 110000],
    'Signal In': ['00000001', '00000101', '11111111', '00001010', '00000000'],
    'Fan-in': [3, 2, 6, 4, 0],
    'Fan-out': [2, 3, 5, 3, 0],
    'Gate Count': [5, 7, 12, 9, 0],
    'Path Length': [4, 5, 8, 7, 0],
    'Flip-Flops': [1, 2, 3, 2, 0],
    'Depth': [0, 9, 11, 19, 19],
    'Predicted Flag': [1, 0, 0, 0, 0] 
}

df1 = pd.DataFrame(data1)


data2 = {
    'Time': [30000, 50000, 70000, 90000],
    'Signal Type': ['Branch Taken', 'Branch Not Taken', 'Mispredict', 'Random Toggle'],
    'Fan-in': [3, 3, 3, 3],
    'Fan-out': [2, 2, 2, 2],
    'Gate Count': [500, 500, 500, 500],
    'Path Length': [10, 10, 10, 10],
    'Flip-Flops': [100, 100, 100, 100],
    'Depth': [175, 175, 175, 175],
    'Predicted Flag': [1, 0, 0, 0]
}

df2 = pd.DataFrame(data2)


label_encoder = LabelEncoder()
df2['Signal Type'] = label_encoder.fit_transform(df2['Signal Type'])


df2['Signal In'] = ['00000000'] * len(df2) 

def binary_to_features(binary_str):
    return [int(bit) for bit in binary_str]

df1_binary = np.array([binary_to_features(sig) for sig in df1['Signal In']])
df1_binary_df = pd.DataFrame(df1_binary, columns=[f'Bit_{i}' for i in range(df1_binary.shape[1])])

df2_binary = np.array([binary_to_features(sig) for sig in df2['Signal In']])
df2_binary_df = pd.DataFrame(df2_binary, columns=[f'Bit_{i}' for i in range(df2_binary.shape[1])])

df1 = pd.concat([df1.drop(columns=['Signal In']), df1_binary_df], axis=1)
df2 = pd.concat([df2.drop(columns=['Signal In']), df2_binary_df], axis=1)


df_combined = pd.concat([df1, df2], ignore_index=True)


X = df_combined.drop(columns=['Depth'])  
y = df_combined['Depth'] 


scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)


X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.2, random_state=42)


model = XGBRegressor(n_estimators=200, learning_rate=0.1, max_depth=5, random_state=42)
model.fit(X_train, y_train)

y_pred = model.predict(X_test)


mae = mean_absolute_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred) if len(y_test) > 1 else "N/A"

print(f"Mean Absolute Error: {mae}")
print(f"R² Score: {r2}")

plt.figure(figsize=(8, 5))
plt.scatter(y_test, y_pred, color='blue', label="Predicted vs Actual")
plt.plot([min(y_test), max(y_test)], [min(y_test), max(y_test)], color='red', linestyle='dashed', label="Ideal Fit (y=x)")
plt.xlabel("Actual Depth")
plt.ylabel("Predicted Depth")
plt.title(f"Actual vs. Predicted Depth (MAE={mae:.2f}, R²={r2})")
plt.legend()
plt.grid(True)
plt.show()
