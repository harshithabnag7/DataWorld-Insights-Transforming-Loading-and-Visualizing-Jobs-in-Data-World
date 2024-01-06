
create warehouse yourwarehousename
    warehouse_size = 'X-SMALL'
    auto_suspend = 1800 
    auto_resume = true;  
    
drop database if exists s3_to_snowflake;

use role accountadmin;
--Database Creation 
create database if not exists s3_to_snowflake;


use s3_to_snowflake;




create or replace stage s3_to_snowflake.PUBLIC.snow_simple url="s3://data-jobs-hr/output_folder/" 
credentials=(aws_key_id={'your key'}
aws_secret_key={'your secret key'});



list @s3_to_snowflake.PUBLIC.snow_simple;

--File Format Creation
create or replace file format my_parquet_format
type = parquet;



--Table Creation
CREATE OR REPLACE EXTERNAL TABLE s3_to_snowflake.PUBLIC.Jobs_dataset (
   
  
    work_year VARCHAR(20) AS (VALUE:work_year::VARCHAR(20)),
    job_title VARCHAR(100) AS (VALUE:job_title::VARCHAR(100)),
    job_category VARCHAR(50) AS (VALUE:job_category::VARCHAR(50)),
    salary_currency VARCHAR(20) AS (VALUE:salary_currency::VARCHAR(20)),
    salary VARCHAR(50) AS (VALUE:salary::VARCHAR(50)),
    salary_in_usd VARCHAR(50) AS (VALUE:salary_in_usd::VARCHAR(50)),
    employee_residence VARCHAR(50) AS (VALUE:employee_residence::VARCHAR(50)),
    experience_level VARCHAR(20) AS (VALUE:experience_level::VARCHAR(20)),
    employment_type VARCHAR(20) AS (VALUE:employment_type::VARCHAR(20)),
    work_setting VARCHAR(20) AS (VALUE:work_setting::VARCHAR(20)),
    company_location VARCHAR(50) AS (VALUE:company_location::VARCHAR(50)),
    company_size VARCHAR(20) AS (VALUE:company_size::VARCHAR(20)),
    salary_experience_ratio NUMBER AS (VALUE:salary_experience_ratio::NUMBER),
    experience_level_numeric INT AS (VALUE:experience_level_numeric::INT),
    salary_bin VARCHAR(50) AS (VALUE:salary_bin::VARCHAR(50)),
    salary_bin_label VARCHAR(50) AS (VALUE:salary_bin_label::VARCHAR(50))
  )
WITH LOCATION = @s3_to_snowflake.PUBLIC.snow_simple
FILE_FORMAT = 'my_parquet_format';


select * from s3_to_snowflake.PUBLIC.Jobs_dataset;


