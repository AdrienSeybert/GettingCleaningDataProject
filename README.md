GettingCleaningDataProject
==========================

GettingCleaningDataProject

---
title: "ReadMe"
author: "Adrien Seybert"
date: "08/24/2014"
output: html_document
---

This ReadMe document contains comments about run_Analysis.R

1. Read in Data
a. I read them in as singular files so as not to clutter things up, especially my brain. Sure, I could be more efficient here but making a tidy data file is my main goal right now.

2. Combined with rbind X_test with X_train, y_test with y_train, and subject_test with subject_train

3. Subsetted features file to include only actually variable not indices.

4. Converted features subset to colnames for combined X_train/X_test file

5. Used grep function to extract variable columents relating to Mean() and Std()

6. Put complete data file together

7. Skipped activity IDs to descriptions for time reasons

8. Kept variable names because they seemed descriptive enough. If I changed them arbitrarily without more knowledge, I would be compromising the data. 

9. Performed a Melt To Find Averages For Variables By Subject ID, Activity ID

10. Outputted Data File
