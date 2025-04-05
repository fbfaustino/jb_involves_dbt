WITH dim_produto AS (
    SELECT 
        ID_PRODUTO
        ,PRODUTO
        ,LINHA_PRODUTO
        ,MARCA
        ,CATEGORIA_PRODUTO
        ,SUPER_CATEGORIA
        ,CODIGO_BARRAS
    FROM {{ source('bronze', 'dim_produto') }}  
)
SELECT * FROM dim_produto