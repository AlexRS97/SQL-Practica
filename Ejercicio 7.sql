WITH billing_data AS (
  SELECT
    CAST(steps.ivr_id AS STRING) AS ivr_id,
    steps.billing_account_id,
    ROW_NUMBER() OVER (PARTITION BY CAST(steps.ivr_id AS STRING) ORDER BY steps.step_sequence) AS rn
  FROM `keepcoding.ivr_steps` AS steps
  WHERE steps.billing_account_id IS NOT NULL AND steps.billing_account_id != "UNKNOWN"
)

SELECT
  calls.ivr_id,
  billing_data.billing_account_id
FROM `keepcoding.ivr_calls` AS calls
LEFT JOIN billing_data
  ON CAST(calls.ivr_id AS STRING) = billing_data.ivr_id
WHERE billing_data.rn = 1 OR billing_data.rn IS NULL;