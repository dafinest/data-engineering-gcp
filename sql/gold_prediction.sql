CREATE OR REPLACE TABLE retail_gold.analytics_customer_segments AS
SELECT
    *
FROM ML.PREDICT(
    MODEL retail_gold.customer_segmentation_model,
    (
        SELECT *
        FROM retail_silver.cleaned_transactions
    )
);