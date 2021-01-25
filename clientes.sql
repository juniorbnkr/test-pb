select
  tc.nome,
  endereco,
  estado,
  `data` as data_mudanca
from
  cliente_timeline ct
  left join tb_cliente tc on tc.ID = tb_cliente_ID
where
  ct.data >= '2019-01-01'
  and ct.data < '2020-01-01'
  and tipo = 'PJ'
order by
  estado
 ;