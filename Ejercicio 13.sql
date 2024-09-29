CREATE OR REPLACE FUNCTION limpieza_de_enteros(input_value INT64)
RETURNS INT64
AS (
    CASE
        WHEN input_value IS NULL THEN -999999
        ELSE input_value
    END
);