WITH dim_pergunta AS (
    SELECT 
        ID_PERGUNTA
        ,NOME_CAMPO
        ,ROTULO_WEB
        ,FL_TIPO
        ,TIPO_CAMPO
        ,FL_REFERENCIA
        ,OBJETIVO_CAMPO
        ,OBRIGATORIO
    FROM {{ source('bronze', 'dim_pergunta') }}  
)
SELECT * FROM dim_pergunta