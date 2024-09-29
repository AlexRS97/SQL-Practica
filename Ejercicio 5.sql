WITH documents AS (
  SELECT
    CAST(steps.ivr_id AS STRING) AS ivr_id,
    steps.document_type,
    steps.document_identification,
    ROW_NUMBER() OVER (PARTITION BY CAST(steps.ivr_id AS STRING) ORDER BY steps.step_sequence) AS rn
  FROM `keepcoding.ivr_steps` AS steps
  WHERE (steps.document_type IS NOT NULL AND steps.document_type != 'UNKNOWN')
    AND (steps.document_identification IS NOT NULL AND steps.document_identification != 'UNKNOWN')
)

SELECT
  calls.ivr_id,
  COALESCE(steps.document_type, 'UNKNOWN') AS document_type,
  COALESCE(steps.document_identification, 'UNKNOWN') AS document_identification
FROM `keepcoding.ivr_calls` AS calls
LEFT JOIN documents AS steps
  ON CAST(calls.ivr_id AS STRING) = steps.ivr_id
WHERE steps.rn = 1 OR steps.rn IS NULL;