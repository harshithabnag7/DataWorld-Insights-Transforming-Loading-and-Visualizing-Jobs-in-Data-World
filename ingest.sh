wget --no-check-certificate -O - https://drive.google.com/uc?id='1nE_6P6eiGOWbhKg-ZUkCR73MDZ7rgCYB' | aws s3 cp - s3://data-jobs-hr/input_folder/jobsdata.csv
