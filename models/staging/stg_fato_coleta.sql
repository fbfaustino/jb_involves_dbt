WITH fato_coleta AS (
    SELECT 
        ID_COLETA
        ,DATA
        ,ID_PDV
        ,ID_PERGUNTA
        ,ID_COLABORADOR
        ,ID_PRODUTO
        ,RESPOSTA
    FROM {{ source('bronze', 'fato_coleta') }}  
)
SELECT * FROM fato_coleta