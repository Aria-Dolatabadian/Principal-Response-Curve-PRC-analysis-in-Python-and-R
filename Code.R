# Load required libraries
library(tidyverse)
library(cowplot) # If not installed, install with install.packages("cowplot")

# Read data from CSV
df <- read.csv('prc_data.csv')


# Perform Principal Response Curve (PRC) analysis
# Standardize the data
scaled_data <- scale(df %>%
                       pivot_wider(names_from = c("Week", "Treatment"), 
                                   values_from = "Response", 
                                   values_fill = 0) %>%
                       select(-Organism))  # Exclude non-numeric column

# Apply PCA
pca_result <- prcomp(scaled_data)

# Visualize the results
cumulative_variance <- cumsum(pca_result$sdev^2) / sum(pca_result$sdev^2)

# Plot
options(repr.plot.width=12, repr.plot.height=6)
plot(cumulative_variance, type='o', main='Principal Response Curve (PRC) Analysis',
     xlab='Number of Principal Components', ylab='Cumulative Variance Explained',
     col='blue', lwd=2)
grid(TRUE)
