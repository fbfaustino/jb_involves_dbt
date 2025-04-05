WITH dim_pdv AS (
    SELECT 
        ID_PDV
        ,NOME_PDV
        ,NOME_FANTASIA
        ,RAZAO_SOCIAL
        ,BANDEIRA
        ,REDE
        ,TIPO_PDV
        ,PERFIL_PDV
        ,CANAL_PDV
        ,REGIONAL
        ,MACRO_REGIONAL
        ,CNPJ
    FROM {{ source('bronze', 'dim_pdv') }}  
)
SELECT * FROM dim_pdv