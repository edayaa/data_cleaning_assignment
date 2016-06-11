#  Human Activity Recognition Using Smartphones Dataset - Code Book 

## Inclusion of appropriate Libraries data.table , plyr , dplyr and data.table 
## Setup the working directory ( in case if the working directory is not set-up ) 
## Downloading of Input datasets  (UCI HAR dataset.zip ) folder and unzip them 

## Reading of input datasets ( test ) 
	
### Read column headings from features.txt prior to reading Test and Training datasets.
    This would help us to get column list in hand.
	1. Read the subject ( subject_test.txt ) who performed the activity for each window sample. 
	2. Read the labels ( y_test.txt ) which has respective work labels for each activity.
	3. Merge the subject and labels to map each work label to respective subject.
	3. Read the activities/measurements ( x_test.txt) dataset.
	4. Merge the acivities , subject and lables vertically to map everything into single dataset which has work activity observation performed by different 
	individuals ( Test ) . 
	5. Read all Training datasets ( subject , Labels and Activity ) 
## Reading of input datasets (Training ) 
	Follow all above said steps for Training datasets. We should have single dataset which has work activity observation performed by different 
	individuals ( Training ). 
	
## Merge both Test and Training datasets together one single data input for analysis - We can use rbind to achieve horizontal merge.


## Furter data cleaning steps to keep only Mean , STD cloumns 
	1. Extract only the column names contain the Mean or STD ( Standard deviation ) from the dataset received from earlier steps. - "grep" function can be used to achieve this step
   	2. Adding subject and activity_lables column along with Mean and STD columns.
   	3. Get the respective label description from "activity_labels.txt" and populate it dataset from previous step.
   	4. Exclude Activility_lable col and keep the final dataset ready for Analytical processing. 
   	5. Convert Dataframe into Data table to achive mean for all column rather than specifying all columns in the lapply function.
   	6. Calculate the mean for all columns in the dataset except the group columns subject & Activity . This is being achived by using 
   	   .SD ( Subset ) function in lapply.
   	7. Writing the results into output dataset.
   	



	








	
	
	   
    	







