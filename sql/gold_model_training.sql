CREATE OR REPLACE MODEL retail_gold.customer_segmentation_model
OPTIONS(
    MODEL_TYPE='KMEANS',
    NUM_CLUSTERS=4,
    STANDARDIZE_FEATURES=TRUE
) AS

SELECT
    amount,
    item_category
FROM retail_silver.cleaned_transactions;