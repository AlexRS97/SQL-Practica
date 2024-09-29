WITH aggregated_calls AS (
  SELECT
    calls.ivr_id,
    CASE
      WHEN calls.vdn_label LIKE 'ATC%' THEN 'FRONT'
      WHEN calls.vdn_label LIKE 'TECH%' THEN 'TECH'
      WHEN calls.vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
      ELSE 'RESTO'
    END AS vdn_aggregation
  FROM `keepcoding.ivr_calls` AS calls
)

SELECT
  aggregated_calls.ivr_id,
  aggregated_calls.vdn_aggregation
FROM aggregated_calls;