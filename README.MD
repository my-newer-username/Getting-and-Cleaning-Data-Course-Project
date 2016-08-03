# Getting and Cleaning Data Course Project

This is a course project. Run "run_analysis.R" will download the data and clean the data, and write a "tidy.txt" file.

1. The program downloads a zip file, and unzipped in the current working directory.
2. The file contains information of 30 people performing 6 different activities. The activities have different features. The whole information is divided into train and test folders.
3. Load the activities categories and features. Tidy the features' names.
4. Load the dataset of test and train, and merge them together.
5. calclulate the mean value of features for the 30 people of 6 different activities. Write the information into "tidy.txt"