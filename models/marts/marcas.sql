SELECT 
    c.marca,
    COUNT(*) AS total_produtos,
    
    -- Cálculo da Ruptura considerando os diferentes tipos
    SUM(CASE WHEN a.id_pergunta = 216 AND a.resposta IN ('Ruptura', 'Ruptura Total', 'Ruptura de Gôndola', 'Ruptura de Estoque') THEN 1 ELSE 0 END) AS total_rupturas,
    ROUND(
        (SUM(CASE WHEN a.id_pergunta = 216 AND a.resposta IN ('Ruptura', 'Ruptura Total', 'Ruptura de Gôndola', 'Ruptura de Estoque') THEN 1 ELSE 0 END) * 100.0) / NULLIF(COUNT(*), 0), 
        2
    ) AS percentual_ruptura,

    -- Cálculo da Ruptura de Estoque
    SUM(CASE WHEN a.id_pergunta = 216 AND a.resposta = 'Ruptura de Estoque' THEN 1 ELSE 0 END) AS total_ruptura_estoque,

    -- Cálculo da Ruptura de Gôndola
    SUM(CASE WHEN a.id_pergunta = 216 AND a.resposta = 'Ruptura de Gôndola' THEN 1 ELSE 0 END) AS total_ruptura_gondola,

    -- Produtos presentes
    SUM(CASE WHEN a.id_pergunta = 215 AND a.resposta IN ('Sim', 'Presente') THEN 1 ELSE 0 END) AS produtos_presentes,

    -- Espaço ocupado pela marca (convertendo resposta para FLOAT)
    SUM(CASE WHEN a.id_pergunta = 340 THEN CAST(a.resposta AS FLOAT) ELSE 0 END) AS espaco_ocupado_cm,

    -- Total de espaço disponível na categoria
    SUM(CASE WHEN a.id_pergunta = 339 THEN CAST(a.resposta AS FLOAT) ELSE 0 END) AS espaco_total_categoria,

    -- Percentual do espaço ocupado pela marca na categoria
    ROUND(
        (SUM(CASE WHEN a.id_pergunta = 340 THEN CAST(a.resposta AS FLOAT) ELSE 0 END) * 100.0) /
        NULLIF(
            SUM(CASE WHEN a.id_pergunta = 339 THEN CAST(a.resposta AS FLOAT) ELSE 0 END), 0), 
        2
    ) AS percentual_espaco_marca,
    
    -- Análise de Promoção
    SUM(CASE WHEN a.id_pergunta = 271 AND a.resposta = 'Sim' THEN 1 ELSE 0 END) AS produtos_em_promocao,
    COUNT(CASE WHEN a.id_pergunta = 270 AND REGEXP_LIKE(a.resposta, '^[0-9]+(\.[0-9]+)?$') THEN 1 ELSE NULL END) AS produtos_com_preco

from {{ ref('stg_fato_coleta') }} a 
inner join {{ ref('stg_dim_produto') }} c on a.id_produto = c.id_produto
inner join {{ ref('stg_dim_pdv') }} d on a.id_pdv = d.id_pdv
inner join {{ ref('stg_dim_colaborador') }} e on a.id_colaborador = e.id_colaborador

WHERE MARCA IS NOT NULL
GROUP BY c.marca
