WITH phone_data AS (
  SELECT
    CAST(steps.ivr_id AS STRING) AS ivr_id,
    steps.customer_phone,
    ROW_NUMBER() OVER (PARTITION BY CAST(steps.ivr_id AS STRING) ORDER BY steps.step_sequence) AS rn
  FROM `keepcoding.ivr_steps` AS steps
  WHERE steps.customer_phone IS NOT NULL AND steps.customer_phone != "UNKNOWN"
)

SELECT
  calls.ivr_id,
  phone_data.customer_phone
FROM `keepcoding.ivr_calls` AS calls
LEFT JOIN phone_data
  ON CAST(calls.ivr_id AS STRING) = phone_data.ivr_id
WHERE phone_data.rn = 1 OR phone_data.rn IS NULL;