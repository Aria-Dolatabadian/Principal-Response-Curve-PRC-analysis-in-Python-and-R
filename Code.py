import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA


# Read data from CSV
df = pd.read_csv('prc_data.csv')

# Perform Principal Response Curve (PRC) analysis
# Standardize the data
scaler = StandardScaler()
scaled_data = scaler.fit_transform(df.pivot_table(index='Organism', columns=['Week', 'Treatment'], values='Response', aggfunc='mean').values)

# Apply PCA
pca = PCA()
prc_data = pca.fit_transform(scaled_data)

# Visualize the results
plt.figure(figsize=(12, 6))
plt.plot(np.cumsum(pca.explained_variance_ratio_), marker='o')
plt.title('Principal Response Curve (PRC) Analysis')
plt.xlabel('Number of Principal Components')
plt.ylabel('Cumulative Variance Explained')
plt.grid(True)
plt.show()
