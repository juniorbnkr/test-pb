select
  MONTHNAME(tt.data) as mes,
  tc.tipo as tipo,
  ct.estado,
  ta.nome as nome_app,
  count(t.ID) as total_transacoes,
  sum(t.valor) as valor_total
from
  tb_transacoes t
  left join transacao_timeline tt on tt.tb_transacoes_ID = t.ID
  left join tb_cliente tc on tc.ID = t.tb_cliente_ID
  left join cliente_timeline ct on ct.tb_cliente_ID = tc.ID
  left join tb_aplicacoes ta on ta.ID = t.tb_aplicacoes_ID
WHERE
  tt.status = 'aprovado'
  and tt.data >= '2019-01-01'
  and tt.data < '2020-01-01'
  and ct.is_actual = 1
group by
  1,
  2,
  3,
  4,
  month(tt.data)
order by
  month(tt.data);