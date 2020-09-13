CodeBook.md
================

The **run\_analysis.R** script performs the data preparation required by
the course project’s instructions.

1.  **Downloading the dataset**

<!-- end list -->

  - Dataset downloaded and unzipped inside the **uci\_dataset** folder.

<!-- end list -->

2.  **Assigning each data to a new variable**

<!-- end list -->

  - **features** \<- features.txt : 561 rows, 2 columns. *The features
    selected for this database come from the accelerometer and gyroscope
    3-axial raw signals tAcc-XYZ and tGyro-XYZ.*
  - **activities** \<- activity\_labels.txt : 6 rows, 2 columns. *List
    of activities performed when the corresponding measurements were
    taken.*
  - **subject\_test** \<- test/subject\_test.txt : 2947 rows, 1 column.
    *Contains test data of test subjects.*
  - **x\_test** \<- test/X\_test.txt : 2947 rows, 561 columns. *Contains
    recorded test data.*
  - **y\_test** \<- test/y\_test.txt : 2947 rows, 1 columns. *Contains
    recorded test data labels.*
  - **subject\_train** \<- train/subject\_train.txt : 7352 rows, 1
    column. *Contains train data of test subjects.*
  - **x\_train** \<- train/X\_train.txt : 7352 rows, 561 columns.
    *Contains recorded train data.*
  - **y\_train** \<- train/y\_train.txt : 7352 rows, 1 columns.
    *Contains recorded train data labels.*

<!-- end list -->

3.  **Merging the training and test sets to create only one set of
    data**

<!-- end list -->

  - **x** (10299 rows, 561 columns) is created by merging *x\_train* and
    *x\_test* using the *rbind()* function
  - **y** (10299 rows, 1 column) is created by merging *y\_train* and
    *y\_test* using the *rbind()* function
  - **subject** (10299 rows, 1 column) is created by merging
    *subject\_train* and *subject\_test* using the *rbind()* function
  - **merged\_data** (10299 rows, 563 column) is created by merging
    *subject*, *y* and *x* using the *cbind()* function

<!-- end list -->

4.  **Extracting the mean and standard deviation for each measurement**

<!-- end list -->

  - **tidydata** (10299 rows, 88 columns) is created by subsetting
    *merged\_data* with the selection of only this columns: **subject**,
    **code** and the **mean** and **standard deviation** for each
    measurement.

<!-- end list -->

5.  **Using descriptive activity names to name activities**

<!-- end list -->

  - Entire numbers in **code** column of the **tidydata** replaced with
    corresponding activity taken from second column of the
    **activities** variable

6\.**Labeling the data set with descriptive variable names** \* **code**
column in tidydata renamed **activities** \* All **Acc** in column’s
name replaced by **accelerometer** \* All **Gyro** in column’s name
replaced by **gyroscope** \* All **BodyBody** in column’s name replaced
by **body** \* All **Mag** in column’s name replaced by **magnitude** \*
All start with character **f** in column’s name replaced by
**frequency** \* All start with character **t** in column’s name
replaced by **time**

7.  **From the data set in step 6, a second independent and tidy data
    set with the average of each variable for each activity and each
    subject is created.**

<!-- end list -->

  - **finaldata** (180 rows, 88 columns) is created by sumarizing
    **tidydata** taking the means of each variable for each activity and
    each subject, after groupped by subject and activity.
  - Export **finaldata** into **finaldata.txt** file.
