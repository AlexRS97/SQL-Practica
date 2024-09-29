WITH masiva_data AS (
    SELECT 
        ivr_id,
        CASE 
            WHEN ARRAY_LENGTH(SPLIT(module_aggregation, ",")) > 0 
                 AND "AVERIA_MASIVA" IN UNNEST(SPLIT(module_aggregation, ",")) 
            THEN 1
            ELSE 0
        END AS masiva_lg
    FROM 
        keepcoding.ivr_calls
)

SELECT 
    *
FROM 
    masiva_data
ORDER BY 
    masiva_lg DESC;