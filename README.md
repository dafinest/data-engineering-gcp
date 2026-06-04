Data Engineering Screening Challenge
Overview

This project implements a Medallion Architecture (Bronze, Silver, Gold) in Google BigQuery using a retail transactions dataset.

The solution ingests raw transaction data then applies data quality and transformation logic and finaly uses BigQuery Machine Learning to generate customer segmentation insights using a K-Means clustering model.




Architecture
Raw CSV
    ↓

Bronze Layer
retail_bronze.raw_transactions

    ↓

Silver Layer
retail_silver.cleaned_transactions

    ↓

BQML K-Means Model

    ↓

Gold Layer
retail_gold.analytics_customer_segments

Bronze Layer

The raw CSV file was loaded into BigQuery without transformation. All columns were loaded as STRING types to preserve source formatting .

Dataset:

retail_bronze

Table:

raw_transactions
Silver Layer

The Silver layer performs data cleansing and transformation.

Implemented transformations:

Type casting of dates and numeric fields
Defaulting NULL signup_date values to purchase_date
Defaulting NULL is_returned values to FALSE
Removal of invalid transactions where amount <= 0
Feature engineering of days_to_first_purchase

Dataset:

retail_silver

Table:

cleaned_transactions
Gold Layer

A BigQuery ML K-Means clustering model was trained to segment customers using:

amount
item_category

Predictions were generated using ML.PREDICT and stored in:

retail_gold.analytics_customer_segments
AI Usage

AI tools (Chatgpt) were used to assist with:

Understanding BigQuery ML syntax
Reviewing/Refactoring SQL transformation logic
Discussing Medallion Architecture best practices in production deployment 

All SQL code was reviewed, executed and validated within BigQuery prior to submission.

Production Orchestration Approach 

In a production environment I would orchestrate this pipeline using Dataform and BigQuery scheduled executions.The Bronze layer would ingest source data, followed by dependency-driven transformations into the Silver and Gold layers. Data quality validations would be incorporated into the Silver layer, with invalid records routed to quarantine tables for investigation. Monitoring and alerting would be implemented using Cloud Monitoring and Cloud Logging. For larger enterprise workloads, Cloud Composer (managed Apache Airflow) could be used to coordinate ingestion, transformation, validation, and model retraining workflows.

Potential Production Enhancements

Incremental loading instead of full refreshes
Data quality monitoring and quarantine tables
Table partitioning on purchase_date
Table clustering on customer_id and item_category
CI/CD deployment using GitHub Actions and Dataform.