CREATE OR REPLACE TABLE retail_silver.cleaned_transactions AS

WITH cleaned_data AS (
    SELECT
        transaction_id,
        customer_id,
        SAFE_CAST(signup_date AS DATE) AS signup_date,
        SAFE_CAST(purchase_date AS DATE) AS purchase_date,
        SAFE_CAST(amount AS FLOAT64) AS amount,
        TRIM(item_category) AS item_category,
        SAFE_CAST(is_returned AS BOOL) AS is_returned
    FROM retail_bronze.raw_transactions
)

SELECT
    transaction_id,
    customer_id,
    COALESCE(signup_date, purchase_date) AS signup_date,
    purchase_date,
    amount,
    item_category,
    COALESCE(is_returned, FALSE) AS is_returned,
    DATE_DIFF(
        purchase_date,
        COALESCE(signup_date, purchase_date),
        DAY
    ) AS days_to_first_purchase
FROM cleaned_data
WHERE amount > 0;