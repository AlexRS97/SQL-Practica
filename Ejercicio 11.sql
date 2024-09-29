WITH phone_re_data AS (
    SELECT 
        ivr_id,
        phone_number,
        start_date
    FROM 
        keepcoding.ivr_calls
),

repeated_calls_24h AS (
    SELECT 
        phone_re_data.ivr_id,
        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM phone_re_data AS phone_re_data_inner
                WHERE phone_re_data_inner.phone_number = phone_re_data.phone_number
                  AND phone_re_data_inner.start_date BETWEEN phone_re_data.start_date - INTERVAL 24 HOUR AND phone_re_data.start_date
                  AND phone_re_data_inner.ivr_id != phone_re_data.ivr_id
            ) 
            THEN 1 
            ELSE 0 
        END AS repeated_phone_24H
    FROM phone_re_data
),

cause_recall_24h AS (
    SELECT 
        phone_re_data.ivr_id,
        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM phone_re_data AS phone_re_data_inner
                WHERE phone_re_data_inner.phone_number = phone_re_data.phone_number
                  AND phone_re_data_inner.start_date BETWEEN phone_re_data.start_date AND phone_re_data.start_date + INTERVAL 24 HOUR
                  AND phone_re_data_inner.ivr_id != phone_re_data.ivr_id
            ) 
            THEN 1 
            ELSE 0 
        END AS cause_recall_phone_24H
    FROM phone_re_data
)

SELECT 
    phone_re_data.ivr_id,
    phone_re_data.phone_number,
    repeated_calls_24h.repeated_phone_24H,
    cause_recall_24h.cause_recall_phone_24H
FROM 
    phone_re_data
LEFT JOIN 
    repeated_calls_24h ON phone_re_data.ivr_id = repeated_calls_24h.ivr_id
LEFT JOIN 
    cause_recall_24h ON phone_re_data.ivr_id = cause_recall_24h.ivr_id
ORDER BY 
    phone_re_data.start_date;