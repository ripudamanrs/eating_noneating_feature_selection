# eating_noneating_feature_selection
Data Pre-processing of eating and non-eating sensor data, feature extraction and selection using PCA

Phase 1: Data Cleaning and Preprocessing
----------------------------------------
● In this phase, we extracted 30 user’s EMG and IMU spoon sensor data and combined them together into 2
tables of 18 features each. These 2 tables signify eating and non-eating activities.
● We chose alternate rows for EMG (starting from 1) to balance the amount of data with IMG sensors. While
combining IMU and EMG feature data we padded zeros in IMU sensor data to match the number of rows
with EMG sensor data.
● At the end of this phase we got 2 CSVs: eating.csv and non_eating.csv


Phase 2: Feature Extraction
---------------------------
● In this phase we used eating.csv and non_eating.csv as our input dataset. We performed the following 5
feature extraction techniques, aggregating by action number specified by every row in the Ground Truth
dataset. These techniques are as follows:
○ Entropy
○ Mean
○ Standard Deviation
○ Minimum
○ Root Mean Square
● As a result, we obtained (5X18) 90 features for eating and non-eating activities. Every row in each feature
matrix specifies 1 action and in total we obtain 1176 eating and 1205 non-eating actions.


Phase 3: Feature Selection
--------------------------
• Subtask 1: Arranging the feature matrix
We carefully evaluated all the 90 features and selected those that showed maximum variance between
eating and non-eating actions. Our strategy involved examining how many data points are at a considerable
distance for eating and non-eating actions and also, if we can visualize a decision boundary between them.
Using this strategy, we picked 9 features that showed the most promising variance between eating and
non-eating actions.
○ GX_min
○ GX_rms
○ GX_std
○ GY_avg
○ GY_rms
○ GY_std
○ GZ_min
○ E3_min
○ E7_min
To prepare our feature matrix for PCA, we used the above 9 features as our columns and combined eating
and non-eating actions for those features. At the end of this activity we obtained our feature matrix having
dimensions: 2381 x 9.

• Subtask 2: Execution of PCA
We perform PCA on our feature matrix obtained from subtask 1 and below mentioned graph examines the
role of top 4 eigen-vectors in explaining our 9 selected features.

• Subtask 3: Make sense of the PCA eigenvectors
After performing PCA on our feature matrix we obtain a 9 x 9 matrix that corresponds to eigen-vectors
(along the columns) and eigen-values for each of the 9 features. Therefore, the first column corresponds to
the first principal component and so on. We use the explained functionality of PCA and we obtained the
following results that signify the percentage of variance obtained by each principal component:
○ Principal Component 1 : 73.70
○ Principal Component 2 : 13.60
○ Principal Component 3 : 4.70
○ Principal Component 4 : 3.33
○ Principal Component 5 : 2.08
○ Principal Component 6 : 1.70
○ Principal Component 7 : 0.85
○ Principal Component 8 : 0.07
○ Principal Component 9 : 0.03
