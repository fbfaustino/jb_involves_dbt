select id_coleta,
       a.id_pergunta,
       nome_campo AS pergunta,
       resposta,
       produto, 
       linha_produto,
       marca,
       categoria_produto,
       nome_pdv,
       bandeira,
       tipo_pdv,
       perfil_pdv,
       canal_pdv,
       nome_colaborador
from {{ ref('stg_fato_coleta') }} a 
left join {{ ref('stg_dim_pergunta') }} b on a.id_pergunta = b.id_pergunta
left join {{ ref('stg_dim_produto') }} c on a.id_produto = c.id_produto
left join {{ ref('stg_dim_pdv') }} d on a.id_pdv = d.id_pdv
left join {{ ref('stg_dim_colaborador') }} e on a.id_colaborador = e.id_colaborador