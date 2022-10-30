/* Exercicio 1 */

CREATE OR REPLACE VIEW vw_valores AS
SELECT 	c.id_cliente "Codigo", c.nome "Nome", 0 "Total_a_Prazo", SUM(valor) " Total_a_avista"
FROM	nf_vendas nf INNER JOIN clientes c 
ON (c.id_cliente = nf.id_cliente)
WHERE	YEAR(nf.emissao) = 2021 AND nf.id_fp IN (1,3)
GROUP BY c.id_cliente
UNION
SELECT   c.id_cliente "Codigo", c.nome "Nome", SUM(valor) "Total_a_Prazo", 0 " Total_a_avista"
FROM	 nf_vendas nf INNER JOIN clientes c 
ON (c.id_cliente = nf.id_cliente)
WHERE	 YEAR(nf.emissao) = 2021 AND nf.id_fp IN (2,4)
GROUP BY c.id_cliente

SELECT * FROM vw_valores
#Resultado "Igual a Tabela Sugerida"
SELECT  Codigo, Nome, SUM(Total_a_Prazo) "A Prazo" , SUM(Total_a_avista) "A vista", SUM(Total_a_Prazo + Total_a_avista) "Total"
FROM vw_valores
GROUP BY Codigo

#Exercicio-4
CREATE OR REPLACE VIEW vw_depedentesabaixo18 AS 
SELECT d.id_dependente "Codigo", d.nome "Nome", YEAR(CURRENT_DATE) - YEAR(DATAN) "Idade",
 f.nome"Funcionario",c.descritivo "Cargo", u.descritivo "Empresa", de.descritivo "Departamento"
FROM dependentes d INNER JOIN funcionarios f
ON(d.id_funcionario=f.id_funcionario) INNER JOIN cargos c
ON(f.id_cargo=c.id_cargo) INNER JOIN unidades u 
ON(f.id_unidade=u.id_unidade) INNER JOIN departamentos de
ON(f.id_departamento=de.id_departamento)
WHERE YEAR(CURRENT_DATE) - YEAR(DATAN) < 18
ORDER BY nome


#Exercício-3
SELECT p.id_produto"Codigo", p.descritivo, c.descritivo "Categoria",p.venda"PrecoVenda", (SELECT AVG(venda)
											FROM produtos)"PrecoVendaMedia"
FROM produtos p INNER JOIN categorias c
ON(p.id_categoria=c.id_categoria)
WHERE p.venda >= (SELECT AVG(venda)
FROM produtos)

#sub1
SELECT AVG(venda)
FROM produtos


#Exercício-2
SELECT id_vendedor "Codigo", nome, " " "NroNota"," " "Valor"," " "Emissão"
FROM vendedores
WHERE id_vendedor = 2

UNION

SELECT "", "", id_nfv, CONCAT("R$ " , FORMAT(valor,2,"de_DE")) ,DATE_FORMAT(emissao, "%d/%m-%Y")
FROM nf_vendas
WHERE id_vendedor = 2

UNION

SELECT "", "", "Total das notas", CONCAT("R$ ", FORMAT(SUM(valor), 2, "de_DE")), ""
FROM nf_vendas
WHERE id_vendedor = 2


#Exercício-5
SELECT u.id_unidade "Codigo", u.descritivo"Unidade",COUNT(f.id_funcionario)"NroFunc",AVG(f.salario)"MediaUNI" , (SELECT AVG(salario)
FROM funcionarios)"MediaGeralrede"
FROM unidades u LEFT JOIN funcionarios f
ON(u.id_unidade=f.id_unidade)
WHERE f.salario > (SELECT AVG(salario)
FROM funcionarios)
GROUP BY f.id_unidade


#sub1 MediaGeralRede
SELECT AVG(salario)
FROM funcionarios





