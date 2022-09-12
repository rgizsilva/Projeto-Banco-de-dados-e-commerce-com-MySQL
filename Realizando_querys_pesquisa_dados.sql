-- Quantos pedidos foram feitos por cada cliente?

SELECT c.id, concat(c.pnome,' ',c.unome) as Nome_Sobrenome, SUM(IF(p.cliente_id IS NULL, 0, 1)) as Total_de_Pedidos from cliente c left join pedido p on c.id = p.cliente_id
GROUP BY c.pnome
ORDER BY c.pnome;


-- Algum vendedor também é fornecedor?

SELECT count(*) as quantos_vendedores_em_fornecedores from terceiro_vendedor t , fornecedor f Where t.razao_social in (f.razao_social);


-- Relação de produtos fornecedores e estoques;

select f.id,f.razao_social,f.cnpj,f.contato,p.nome as produto,e.local,e.quantidade as qnt_estoque from fornecedor f left JOIN produto_fornecedor pr
ON pr.fornecedor_id = f.id
JOIN produto p 
ON pr.produto_id = p.id
JOIN produto_em_estoque pro 
JOIN estoque e
ON pro.estoque_id = e.id
WHERE pro.estoque_id = e.id AND pro.produto_id = p.id
ORDER BY f.id;

--  Criando view Relação dos Clientes, nome,valor e descrição do produto adquirido, tipo de pagamento e id do pedido.


CREATE VIEW relatorio_cliente_pedido AS 
SELECT CONCAT(c.pnome,' ', c.unome) as Nome_completo, pro.nome as produto, pro.descricao,pro.valor, pa.tipo 
as tipo_de_pagamento, pe.id as id_pedido from pedido p JOIN produto_pedido pr
ON pr.pedido_id = p.id
JOIN produto pro
on pr.produto_id = produto_id
JOIN cliente c
on p.cliente_id = c.id
JOIN pagamento pa
ON pa.cliente_id = c.id
JOIN pedido pe
ON pe.cliente_id = c.id
where pr.pedido_id = p.id and pr.produto_id = pro.id
GROUP BY pe.id;

SELECT * FROM relatorio_cliente_pedido;