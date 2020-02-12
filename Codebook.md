# Code book

Following are the list of defined variables and their function:

1. activity.labels: Links the class labels with their activity name.
2. all.data: Merged training and testing data.
3. all.data.bc: Backup of the above
4. all.data.stat: Subset of all.data with only mean measurements and standard deviation measurements.
5. all.data.stat.tbl: all.data.stat as a tibble.
6. all.data.stat.tidy: all.data.stat.tbl grouped by each activity and each subject and averaged w.r.t the grouping.
7. feature.cols: Links the feature labels (i.e. column indices) with their feature name.
8. feature.cols.names: List of all features.
9. keycolnums: Key columns of "Type" (Train/Test), ActivityLabel (one of activity.labels), and Subject (the subject who performed the activity for each window sample).
10. list.data: list of sub-files in the unzipped directory of the data.
11. list.of.packages: list of packages for installing (if not installed) and required loading.
12. meancolnums: column indices corresponding to mean measurements.
13. new.packages: list of list.of.packages that have not yet been installed.
14. stdcolnums: column indices corresponding to standard deviation measurements.
15. temp: temporary file holder for the zip data.
16. testing.data: Test set.
17. testing.data.labels: Test labels.
18. testing.data.subjects: Each row identifies the subject who performed the activity for each window sample in the test set. Its range is from 1 to 30.
19. training.data: Training set.
20. training.data.labels: Training labels.
21. training.data.subjects: Each row identifies the subject who performed the activity for each window sample in the training set. Its range is from 1 to 30.
22. wantcolnums: Combined list of keycolnums, meancolnums, and stdcolnums.
