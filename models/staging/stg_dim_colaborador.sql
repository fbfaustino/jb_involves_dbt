WITH dim_colaborador AS (
    SELECT 
        ID_COLABORADOR
        ,NOME_COLABORADOR
        ,USUARIO
        ,REGIONAIS
        ,MOVEL
        ,DATA_ADMISSAO
    FROM {{ source('bronze', 'dim_colaborador') }}  
)
SELECT * FROM dim_colaborador