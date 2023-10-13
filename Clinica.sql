CREATE DATABASE clinica
GO
Use clinica

--Criando as tabelas
CREATE TABLE paciente (
Num_Beneficiario		INT         	NOT NULL,
nome		            VARCHAR(60)		NOT NULL,
logradouro				VARCHAR(200)	NOT NULL,
numero					INT				NOT NULL,
cep						CHAR(8)			NOT NULL,
complemento				VARCHAR(255)	NOT NULL,
telefone				VARCHAR(11)		NOT NULL
PRIMARY KEY (Num_Beneficiario)
)
GO

CREATE TABLE especialidade (
ID_Especialidade		INT         	NOT NULL,
especialidade		    VARCHAR(100)	NOT NULL
PRIMARY KEY (ID_Especialidade)
)
GO

CREATE TABLE medico (
Cod_Medico				INT         	NOT NULL,
nome		            VARCHAR(60)		NOT NULL,
logradouro				VARCHAR(200)	NOT NULL,
numero					INT				NOT NULL,
cep						CHAR(8)			NOT NULL,
complemento				VARCHAR(255)	NOT NULL,
contato					VARCHAR(11)		NOT NULL,
ID_Especialidade        INT             NOT NULL
PRIMARY KEY (Cod_Medico)
FOREIGN KEY (ID_Especialidade) REFERENCES especialidade(ID_Especialidade)
)
GO

CREATE TABLE consulta (
Data_hora			DATE        	        NOT NULL,
observacao			VARCHAR(255)			NOT NULL,
Cod_Medico			INT						NOT NULL,
Num_Beneficiario	INT                     NOT NULL
PRIMARY KEY (Data_hora, Cod_Medico, Num_Beneficiario)
FOREIGN KEY (Cod_Medico) REFERENCES medico(Cod_Medico),
FOREIGN KEY (Num_Beneficiario) REFERENCES paciente(Num_Beneficiario)
)
GO

--Preenchendo as variaveis 
INSERT INTO paciente 
VALUES (99901, 'Washington Silva', 'R. Anhaia', 150, '02345000', 
	'Casa', '922229999')
INSERT INTO paciente 
VALUES (99902, 'Luis Ricardo', 'R.	Voluntários da Pátria', 2251, '03254010', 
	'Bloco B. Apto 25', '923450987')
INSERT INTO paciente 
VALUES (99903, 'Maria Elisa', 'Av. Aguia de Haia', 1188, '06987020', 
	'Apto 1208', '912348765')
INSERT INTO paciente 
VALUES (99904, 'José Araujo', 'R. XV de Novembro', 18, '03678000', 
	'Casa', '945674312')
INSERT INTO paciente 
VALUES (99905, 'Joana Paula', 'R. 7 de Abril', 97, '01214000', 
	'Conjunto 3 - Apto 801', '912095674')

INSERT INTO especialidade 
VALUES (1, 'Otorrinolaringologista')
INSERT INTO especialidade 
VALUES (2, 'Urologista')
INSERT INTO especialidade 
VALUES (3, 'Geriatra')
INSERT INTO especialidade 
VALUES (4, 'Pediatra')

INSERT INTO medico 
VALUES (100001, 'Ana Paula', 'R. 7 de Setembro', 256, '03698000', 
	'Casa', '915689456', '1')
INSERT INTO medico 
VALUES (100002, 'Maria Aparecida', 'Av. Brasil', 32, '02145070', 
	'Casa', '923235454', '1')
INSERT INTO medico 
VALUES (100003, 'Lucas Borges', 'Av. do Estado', 3210, '05241000', 
	'Apto 205', '963698585', '2')
INSERT INTO medico 
VALUES (100004, 'Gabriel Oliveira', 'Av. Dom Helder Camara', 350, '03145000', 
	'Apto 602', '932458745', '3')

INSERT INTO consulta 
VALUES ('2021-09-04 13:20','Infecção Urina', 100002, 99901)
INSERT INTO consulta
VALUES('2021-09-04 13:15', 'Gripe', 100003, 99902)
INSERT INTO consulta 
VALUES('2021-09-04 12:30', 'Infecção Garganta', 100001, 99903)

--Adicionando nova coluna "dia atendimento"
ALTER TABLE medico
ADD dia_atendimento VARCHAR(30) 

--Preenchendo e atualizando a nova coluna "dia atendimento"
UPDATE medico SET dia_atendimento = 'Passa a atender na 2° feira'
WHERE Cod_Medico = 100001
UPDATE medico SET dia_atendimento = 'Passa a atender na 4° feira'
WHERE Cod_Medico = 100002
UPDATE medico SET dia_atendimento = 'Passa a atender na 2° feira'
WHERE Cod_Medico = 100003
UPDATE medico SET dia_atendimento = 'Passa a atender na 5° feira'
WHERE Cod_Medico = 100004

--Alterando para NOT NULL
ALTER TABLE medico
ALTER COLUMN dia_atendimento VARCHAR(30) NOT NULL

--Excluindo a especialidade "Pediatra"
DELETE especialidade
WHERE ID_Especialidade = 4

--Renomear nome da coluna "dia_atendimeto" para "dia_semana_atendimento"
EXEC sp_rename 'medico.dia_atendimento', 'dia_semana_atendimento', 'COLUMN';

--Alterar dados do endereço do medico "Lucas Borges"
UPDATE medico
SET logradouro = 'Av. Bras Leme', numero = 876, cep = '02122000', complemento = 'Apto 504'
WHERE Cod_Medico = 100003

--Alterar tipo de dado daobservacao da tabela consulta para VARCHAR(200)
ALTER TABLE consulta
ALTER COLUMN observacao VARCHAR(200) NOT NULL







