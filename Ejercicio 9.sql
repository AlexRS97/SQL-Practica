WITH info_data AS (
    SELECT 
        ivr_id,
        CASE 
            WHEN step_name = "CUSTOMERINFOBYPHONE.TX" 
                 AND step_result = "OK"
            THEN 1
            ELSE 0
        END AS info_by_phone_lg
    FROM 
        keepcoding.ivr_steps
    WHERE 
        ivr_id IS NOT NULL
)

SELECT 
    ivr_id,
    MAX(info_by_phone_lg) AS info_by_phone_lg
FROM 
    info_data
GROUP BY 
    ivr_id
ORDER BY 
    info_by_phone_lg DESC;