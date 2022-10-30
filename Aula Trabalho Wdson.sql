
#===========================================
#               EXERCÍCIO 1
#===========================================

SELECT p.id_proprietario "Código", p.nome "Nome", CONCAT("R$ ", FORMAT(i.aluguel, 2, "de_DE")) "ValorRecebido",CONCAT("R$ ", FORMAT((SELECT AVG(aluguel)FROM imoveis), 2, "de_DE")) "MediaImobiliaria"
FROM proprietarios p
INNER JOIN imoveis i ON (i.id_proprietario  = p.id_proprietario)
INNER JOIN locacao l ON (l.id_imovel  = i.id_imovel)
WHERE (aluguel) > (SELECT AVG(aluguel)FROM imoveis) AND l.id_imovel IS NOT NULL
GROUP BY p.id_proprietario
ORDER BY p.nome


#===========================================
#               EXERCÍCIO 2
#===========================================

SELECT c.id_curso "Código", c.descritivo "Descritivo", (SELECT AVG(nota)FROM alunos_disciplinas INNER JOIN cursos c ON (c.id_curso  = id_curso) WHERE id_curso = 1) "Media_Curso",
(SELECT AVG(nota)FROM alunos_disciplinas)"Media_Faculdade"
FROM alunos_disciplinas ad
INNER JOIN alunos a ON (a.id_aluno  = ad.id_aluno)
INNER JOIN cursos c ON (c.id_curso  = a.id_curso)
WHERE (nota) < (SELECT AVG(nota)FROM alunos_disciplinas)
GROUP BY c.id_curso

#===========================================
#               EXERCÍCIO 3
#===========================================

UPDATE funcionarios SET salario = salario*1.1
WHERE id_funcionario IN (SELECT id_funcionario
FROM dependentes
WHERE(SELECT AVG(YEAR(CURRENT_DATE)- YEAR(datan))) >= 10
GROUP BY id_funcionario)


#===========================================
#               EXERCÍCIO 4
#===========================================

SELECT v.id_vendedor "Codigo", v.nome "Nome", IFNULL((SELECT SUM(valor) FROM nf_vendas nf WHERE nf.id_vendedor = v.id_vendedor AND id_fp IN (1,3) ),0) "Total_Avista",
IFNULL((SELECT SUM(valor) FROM nf_vendas nf WHERE nf.id_vendedor = v.id_vendedor AND id_fp IN (2,4) ),0) "Total_Aprazo",
IFNULL((SELECT SUM(valor) FROM nf_vendas nf WHERE nf.id_vendedor = v.id_vendedor ),0) "Totalgeral"    
FROM vendedores v

#===========================================
#               EXERCÍCIO 5
#===========================================

SELECT id_proprietario "Código", nome "Nome do Proprietario", " " "CodigoImovel" , " " "Aluguel", " " "Tipo" 
FROM proprietarios
WHERE id_proprietario = 1
GROUP BY id_proprietario
UNION
SELECT "", "", i.id_tipo , CONCAT("R$ ", FORMAT(i.aluguel, 2, "de_DE")), t.descritivo "Descritivo"
FROM imoveis i
INNER JOIN tipos t ON (t.id_tipo  = i.id_tipo)
INNER JOIN proprietarios p ON (p.id_proprietario  = i.id_proprietario)
WHERE i.id_proprietario = 1
UNION
SELECT "","", "Total dos Alugueis", CONCAT("R$ ", FORMAT(SUM(aluguel), 2, "de_DE")), ""
FROM imoveis i
WHERE id_proprietario = 1
UNION
SELECT "","", "Valor a Receber", CONCAT("R$ ", FORMAT(SUM(i.aluguel), 2, "de_DE")), ""
FROM imoveis i
WHERE id_proprietario = 1