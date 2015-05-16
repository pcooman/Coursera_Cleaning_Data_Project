# Tidy_Data_Coursera

The analysis file performs the following order of operations:
1. Read in the training data sets (X_train, y_train and subjects_train)
2. Read in the test data sets (X_test, y_test and subjects_train)
3. Combine the training and test data sets (data, activity_labels and subjects)
4. Add the subject ID's (subjects) and activty labels (activity_labels) to the merged data
5. Extract the proper feature names from the features.txt file and assign these names to the columns of merged data file
6. Create a logic variable that equals True if the feature name contains either mean() or std()
7. USe this logic variable to select only those rows of the data table that contain mean() and std() variables
8. Replace the activity ID numbers by substituting them with their corresonding activity name (from the activity_labels.txt file)
9. Clean up the column names of the data table, replacing all instances of '-' with '.' and all instances of '()' with '' (empty space
10. Order the data table according to Subject IDs (ascending order)
11. Split the data in a list accoring to the Subject ID and activity label
12. Calculate the mean value for all features for each combination of Subject ID and activity label
13. Reconstruct a table by rowbinding the vectors of the average values
14. Recreate the SubjectId and Activity columns and add them to the table of average values
15. Move the Subject ID and Activity columns to the front of the data table
16. Save the final tidy data table to a txt file (tidy_data.txt)
17.  ???
18.  PROFIT!

