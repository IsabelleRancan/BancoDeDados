DROP TABLE IF EXISTS Livros_Categoria CASCADE;
DROP TABLE IF EXISTS Categoria CASCADE;
DROP TABLE IF EXISTS Livros_Autor CASCADE;
DROP TABLE IF EXISTS Livro CASCADE;
DROP TABLE IF EXISTS Autor CASCADE;

--CRIANDO MINHAS TABELAS NO BANCO DE DADOS
CREATE TABLE Autor (
	nome varchar(40) not null primary key,
	nascimento date not null,
	país varchar(15) not null,
	idioma varchar(12) not null
);

CREATE TABLE Livro (
	titulo varchar(50) not null primary key,
	paginas int not null, 
	preco numeric(5, 2) not null
);

CREATE TABLE Livros_Autor (
	autor varchar(40) not null references Autor (nome) ON DELETE CASCADE,
	livro varchar(50) not null references Livro (titulo) ON DELETE CASCADE,
	primary key (autor, livro)
);

CREATE TABLE Categoria (
	categoria varchar(20) not null primary key,
	descricao varchar(200) not null
);

CREATE TABLE Livros_Categoria (
	livro varchar(50) not null references Livro (titulo) ON DELETE CASCADE,
	categoria varchar(20) not null references Categoria (categoria) ON DELETE CASCADE,
	primary key (livro, categoria)
);

-- CRIANDO OS REGISTROS DENTRO DAS TABELAS 
INSERT INTO Autor (nome, nascimento, país, idioma) VALUES
	('C.S. Lewis', '1898-11-29', 'Reino Unido', 'Inglês'),
	('J.R.R. Tolkien', '1892-01-03', 'Reino Unido', 'Inglês'),
	('Rick Riordan', '1964-06-05', 'Estados Unidos', 'Inglês'),
	('Suzanne Collins', '1962-08-10', 'Estados Unidos', 'Inglês'),
	('Ali Hazelwood', '1985-03-24', 'Itália', 'Inglês'),
	('Taylor Jenkins Reid', '1983-12-20', 'Estados Unidos', 'Inglês'),
	('Jane Austen', '1775-12-16', 'Reino Unido', 'Inglês'),
	('Elena Armas', '1990-07-23', 'Espanha', 'Espanhol'),
	('Emily Henry', '1991-02-04', 'Estados Unidos', 'Inglês'),
	('Agatha Christie', '1890-09-15', 'Reino Unido', 'Inglês'),
	('George Orwell', '1903-06-25', 'Reino Unido', 'Inglês'),
	('J.K. Rowling', '1965-07-31', 'Reino Unido', 'Inglês'),
	('F. Scott Fitzgerald', '1896-09-24', 'Estados Unidos', 'Inglês'),
	('Gabriel García Márquez', '1927-03-06', 'Colômbia', 'Espanhol'),
	('Haruki Murakami', '1949-01-12', 'Japão', 'Japonês'),
	('Margaret Atwood', '1939-11-18', 'Canadá', 'Inglês'),
	('Chimamanda Ngozi Adichie', '1977-09-15', 'Nigéria', 'Inglês'),
	('Isabel Allende', '1942-08-02', 'Chile', 'Espanhol'),
	('Paulo Coelho', '1947-08-24', 'Brasil', 'Português'),
	('Leo Tolstoy', '1828-09-09', 'Rússia', 'Russo');
	
INSERT INTO Livro (titulo, paginas, preco) VALUES
	('As Crônicas de Nárnia', 767, 89.90),
	('Cartas de um Diabo a Seu Aprendiz', 160, 29.90),
	('O Senhor dos Anéis: A Sociedade do Anel', 576, 49.90),
	('O Hobbit', 320, 39.90),
	('Percy Jackson e o Ladrão de Raios', 400, 44.90),
	('O Herói Perdido', 432, 46.90),
	('Jogos Vorazes', 400, 45.90),
	('Em Chamas', 416, 47.90),
	('The Love Hypothesis', 384, 35.90),
	('Love on the Brain', 368, 39.90),
	('Os Sete Maridos de Evelyn Hugo', 400, 49.90),
	('Malibu Renasce', 384, 47.90),
	('Orgulho e Preconceito', 416, 29.90),
	('Razão e Sensibilidade', 336, 32.90),
	('O Encontro da Espanha', 448, 42.90),
	('O Amor por Paris', 352, 37.90),
	('Beach Read', 384, 36.90),
	('People We Meet on Vacation', 384, 38.90),
	('Assassinato no Expresso do Oriente', 256, 39.90),
	('Morte no Nilo', 320, 34.90),
	('1984', 328, 29.90),
	('A Revolução dos Bichos', 152, 19.90),
	('Harry Potter e a Pedra Filosofal', 223, 44.90),
	('Harry Potter e a Câmara Secreta', 251, 45.90),
	('O Grande Gatsby', 200, 39.90),
	('Suave é a Noite', 480, 42.90),
	('Cem Anos de Solidão', 448, 49.90),
	('O Amor nos Tempos do Cólera', 432, 46.90),
	('Norwegian Wood', 296, 39.90),
	('Kafka à Beira-mar', 656, 59.90),
	('O Conto da Aia', 368, 49.90),
	('Vulgo Grace', 480, 52.90),
	('Americanah', 496, 55.90),
	('Meio Sol Amarelo', 448, 48.90),
	('A Casa dos Espíritos', 448, 44.90),
	('Paula', 432, 39.90),
	('O Alquimista', 208, 29.90),
	('Brida', 272, 34.90),
	('Guerra e Paz', 1225, 89.90),
	('Anna Karenina', 864, 79.90),
	('Perelandra', 384, 42.90),
	('Os Quatro Amores', 200, 24.90),
	('O Retorno do Rei', 624, 54.90),
	('As Aventuras de Tom Bombadil', 296, 32.90),
	('A Marca de Atena', 608, 54.90),
	('A Sombra da Serpente', 400, 48.90),
	('A Esperança', 424, 47.90),
	('O Canto da Cornucópia', 420, 50.90),
	('Below Zero', 384, 39.90),
	('Stuck with You', 384, 38.90),
	('Daisy Jones & The Six', 368, 49.90),
	('Carrie Soto Está de Volta', 368, 47.90),
	('Mansfield Park', 480, 36.90),
	('Emma', 512, 39.90),
	('The Spanish Love Deception', 448, 49.90),
	('The American Roommate Experiment', 448, 47.90),
	('Book Lovers', 416, 38.90),
	('Happy Place', 416, 39.90),
	('O Mistério dos Sete Relógios', 320, 39.90),
	('Morte na Praia', 288, 34.90),
	('Homage to Catalonia', 288, 39.90),
	('Keep the Aspidistra Flying', 288, 32.90),
	('Harry Potter e o Prisioneiro de Azkaban', 318, 49.90),
	('Harry Potter e o Cálice de Fogo', 535, 54.90),
	('Contos da Era do Jazz', 320, 32.90),
	('O Último Magnata', 320, 34.90),
	('O Outono do Patriarca', 240, 44.90),
	('Crônica de uma Morte Anunciada', 176, 32.90),
	('1Q84', 928, 79.90),
	('Caçando Carneiros', 384, 46.90),
	('O Assassino Cego', 656, 49.90),
	('Orix e Crake', 378, 42.90),
	('No Seu Pescoço', 304, 44.90),
	('Zikora', 208, 35.90),
	('De Amor e de Sombra', 368, 46.90),
	('A Ilha Sob o Mar', 496, 48.90),
	('Diário de um Mago', 224, 29.90),
	('O Zahir', 336, 34.90),
	('A Morte de Ivan Ilitch', 160, 29.90),
	('Ressurreição', 592, 59.90),
	('A Última Batalha', 240, 34.90),
	('O Cavalo e Seu Menino', 240, 34.90),
	('Silmarillion', 416, 54.90),
	('Os Filhos de Húrin', 320, 49.90),
	('O Sangue do Olimpo', 528, 49.90),
	('A Pirâmide Vermelha', 448, 44.90),
	('A Balada dos Pássaros e das Serpentes', 624, 59.90),
	('Grega', 720, 52.90),
	('The STEMinist Novellas', 288, 29.90),
	('Missão Desastre', 384, 38.90),
	('Talvez em Outro Lugar', 368, 45.90),
	('E Se Fosse a Gente?', 464, 39.90),
	('Lady Susan', 128, 24.90),
	('Persuasão', 304, 32.90),
	('Aconteceu Um Verão', 400, 42.90),
	('O Amor que Sinto', 352, 39.90),
	('You and Me on Vacation', 384, 34.90),
	('Noivos à Força', 336, 35.90),
	('Os Elefantes Não Esquecem', 288, 36.90),
	('O Misterioso Caso de Styles', 224, 34.90);
	
INSERT INTO Categoria (categoria, descricao) VALUES
	('Ficção Científica', 'Livros que exploram conceitos futuristas e tecnológicos.'),
	('Fantasia', 'Histórias que envolvem magia e mundos imaginários.'),
	('Romance', 'Narrativas focadas em relações amorosas.'),
	('Mistério', 'Histórias que giram em torno de crimes e mistérios a serem resolvidos.'),
	('Histórico', 'Livros que se passam em períodos históricos específicos.'),
	('Suspense', 'Histórias que criam tensão e ansiedade no leitor.'),
	('Não-ficção', 'Livros baseados em fatos reais e informações documentadas.'),
	('Biografia', 'Histórias da vida de pessoas reais.'),
	('Literatura Clássica', 'Obras literárias que são consideradas clássicas e influentes.'),
	('Terror', 'Livros que provocam medo e inquietação.');
	
INSERT INTO Livros_Autor (autor, livro) VALUES
	('C.S. Lewis', 'As Crônicas de Nárnia'),
	('C.S. Lewis', 'Cartas de um Diabo a Seu Aprendiz'),
	('J.R.R. Tolkien', 'O Senhor dos Anéis: A Sociedade do Anel'),
	('J.R.R. Tolkien', 'O Hobbit'),
	('Rick Riordan', 'Percy Jackson e o Ladrão de Raios'),
	('Rick Riordan', 'O Herói Perdido'),
	('Suzanne Collins', 'Jogos Vorazes'),
	('Suzanne Collins', 'Em Chamas'),
	('Ali Hazelwood', 'The Love Hypothesis'),
	('Ali Hazelwood', 'Love on the Brain'),
	('Taylor Jenkins Reid', 'Os Sete Maridos de Evelyn Hugo'),
	('Taylor Jenkins Reid', 'Malibu Renasce'),
	('Jane Austen', 'Orgulho e Preconceito'),
	('Jane Austen', 'Razão e Sensibilidade'),
	('Elena Armas', 'O Encontro da Espanha'),
	('Elena Armas', 'O Amor por Paris'),
	('Emily Henry', 'Beach Read'),
	('Emily Henry', 'People We Meet on Vacation'),
	('Agatha Christie', 'Assassinato no Expresso do Oriente'),
	('Agatha Christie', 'Morte no Nilo'),
	('George Orwell', '1984'),
	('George Orwell', 'A Revolução dos Bichos'),
	('J.K. Rowling', 'Harry Potter e a Pedra Filosofal'),
	('J.K. Rowling', 'Harry Potter e a Câmara Secreta'),
	('F. Scott Fitzgerald', 'O Grande Gatsby'),
	('F. Scott Fitzgerald', 'Suave é a Noite'),
	('Gabriel García Márquez', 'Cem Anos de Solidão'),
	('Gabriel García Márquez', 'O Amor nos Tempos do Cólera'),
	('Haruki Murakami', 'Norwegian Wood'),
	('Haruki Murakami', 'Kafka à Beira-mar'),
	('Margaret Atwood', 'O Conto da Aia'),
	('Margaret Atwood', 'Vulgo Grace'),
	('Chimamanda Ngozi Adichie', 'Americanah'),
	('Chimamanda Ngozi Adichie', 'Meio Sol Amarelo'),
	('Isabel Allende', 'A Casa dos Espíritos'),
	('Isabel Allende', 'Paula'),
	('Paulo Coelho', 'O Alquimista'),
	('Paulo Coelho', 'Brida'),
	('Leo Tolstoy', 'Guerra e Paz'),
	('Leo Tolstoy', 'Anna Karenina'),
	('C.S. Lewis', 'Perelandra'),
	('C.S. Lewis', 'Os Quatro Amores'),
	('J.R.R. Tolkien', 'O Retorno do Rei'),
	('J.R.R. Tolkien', 'As Aventuras de Tom Bombadil'),
	('Rick Riordan', 'A Marca de Atena'),
	('Rick Riordan', 'A Sombra da Serpente'),
	('Suzanne Collins', 'A Esperança'),
	('Suzanne Collins', 'O Canto da Cornucópia'),
	('Ali Hazelwood', 'Below Zero'),
	('Ali Hazelwood', 'Stuck with You'),
	('Taylor Jenkins Reid', 'Daisy Jones & The Six'),
	('Taylor Jenkins Reid', 'Carrie Soto Está de Volta'),
	('Jane Austen', 'Mansfield Park'),
	('Jane Austen', 'Emma'),
	('Elena Armas', 'The Spanish Love Deception'),
	('Elena Armas', 'The American Roommate Experiment'),
	('Emily Henry', 'Book Lovers'),
	('Emily Henry', 'Happy Place'),
	('Agatha Christie', 'O Mistério dos Sete Relógios'),
	('Agatha Christie', 'Morte na Praia'),
	('George Orwell', 'Homage to Catalonia'),
	('George Orwell', 'Keep the Aspidistra Flying'),
	('J.K. Rowling', 'Harry Potter e o Prisioneiro de Azkaban'),
	('J.K. Rowling', 'Harry Potter e o Cálice de Fogo'),
	('F. Scott Fitzgerald', 'Contos da Era do Jazz'),
	('F. Scott Fitzgerald', 'O Último Magnata'),
	('Gabriel García Márquez', 'O Outono do Patriarca'),
	('Gabriel García Márquez', 'Crônica de uma Morte Anunciada'),
	('Haruki Murakami', '1Q84'),
	('Haruki Murakami', 'Caçando Carneiros'),
	('Margaret Atwood', 'O Assassino Cego'),
	('Margaret Atwood', 'Orix e Crake'),
	('Chimamanda Ngozi Adichie', 'No Seu Pescoço'),
	('Chimamanda Ngozi Adichie', 'Zikora'),
	('Isabel Allende', 'De Amor e de Sombra'),
	('Isabel Allende', 'A Ilha Sob o Mar'),
	('Paulo Coelho', 'Diário de um Mago'),
	('Paulo Coelho', 'O Zahir'),
	('Leo Tolstoy', 'A Morte de Ivan Ilitch'),
	('Leo Tolstoy', 'Ressurreição'),
	('C.S. Lewis', 'A Última Batalha'),
	('C.S. Lewis', 'O Cavalo e Seu Menino'),
	('J.R.R. Tolkien', 'Silmarillion'),
	('J.R.R. Tolkien', 'Os Filhos de Húrin'),
	('Rick Riordan', 'O Sangue do Olimpo'),
	('Rick Riordan', 'A Pirâmide Vermelha'),
	('Suzanne Collins', 'A Balada dos Pássaros e das Serpentes'),
	('Suzanne Collins', 'Grega'),
	('Ali Hazelwood', 'The STEMinist Novellas'),
	('Ali Hazelwood', 'Missão Desastre'),
	('Taylor Jenkins Reid', 'Talvez em Outro Lugar'),
	('Taylor Jenkins Reid', 'E Se Fosse a Gente?'),
	('Jane Austen', 'Lady Susan'),
	('Jane Austen', 'Persuasão'),
	('Elena Armas', 'Aconteceu Um Verão'),
	('Elena Armas', 'O Amor que Sinto'),
	('Emily Henry', 'You and Me on Vacation'),
	('Emily Henry', 'Noivos à Força'),
	('Agatha Christie', 'Os Elefantes Não Esquecem'),
	('Agatha Christie', 'O Misterioso Caso de Styles');
	
INSERT INTO Livros_Categoria (livro, categoria) VALUES
	('As Crônicas de Nárnia', 'Fantasia'),
	('Cartas de um Diabo a Seu Aprendiz', 'Ficção Científica'),
	('O Senhor dos Anéis: A Sociedade do Anel', 'Fantasia'),
	('O Hobbit', 'Fantasia'),
	('Percy Jackson e o Ladrão de Raios', 'Fantasia'),
	('O Herói Perdido', 'Fantasia'),
	('Jogos Vorazes', 'Ficção Científica'),
	('Em Chamas', 'Ficção Científica'),
	('The Love Hypothesis', 'Romance'),
	('Love on the Brain', 'Romance'),
	('Os Sete Maridos de Evelyn Hugo', 'Romance'),
	('Malibu Renasce', 'Romance'),
	('Orgulho e Preconceito', 'Literatura Clássica'),
	('Razão e Sensibilidade', 'Literatura Clássica'),
	('O Encontro da Espanha', 'Histórico'),
	('O Amor por Paris', 'Romance'),
	('Beach Read', 'Romance'),
	('People We Meet on Vacation', 'Romance'),
	('Assassinato no Expresso do Oriente', 'Mistério'),
	('Morte no Nilo', 'Mistério'),
	('1984', 'Ficção Científica'),
	('A Revolução dos Bichos', 'Ficção Científica'),
	('Harry Potter e a Pedra Filosofal', 'Fantasia'),
	('Harry Potter e a Câmara Secreta', 'Fantasia'),
	('O Grande Gatsby', 'Literatura Clássica'),
	('Suave é a Noite', 'Literatura Clássica'),
	('Cem Anos de Solidão', 'Histórico'),
	('O Amor nos Tempos do Cólera', 'Histórico'),
	('Norwegian Wood', 'Romance'),
	('Kafka à Beira-mar', 'Ficção Científica'),
	('O Conto da Aia', 'Ficção Científica'),
	('Vulgo Grace', 'Suspense'),
	('Americanah', 'Histórico'),
	('Meio Sol Amarelo', 'Histórico'),
	('A Casa dos Espíritos', 'Histórico'),
	('Paula', 'Biografia'),
	('O Alquimista', 'Ficção Científica'),
	('Brida', 'Fantasia'),
	('Guerra e Paz', 'Literatura Clássica'),
	('Anna Karenina', 'Literatura Clássica'),
	('Perelandra', 'Ficção Científica'),
	('Os Quatro Amores', 'Não-ficção'),
	('O Retorno do Rei', 'Fantasia'),
	('As Aventuras de Tom Bombadil', 'Fantasia'),
	('A Marca de Atena', 'Fantasia'),
	('A Sombra da Serpente', 'Fantasia'),
	('A Esperança', 'Ficção Científica'),
	('O Canto da Cornucópia', 'Ficção Científica'),
	('Below Zero', 'Romance'),
	('Stuck with You', 'Romance'),
	('Daisy Jones & The Six', 'Romance'),
	('Carrie Soto Está de Volta', 'Romance'),
	('Mansfield Park', 'Literatura Clássica'),
	('Emma', 'Literatura Clássica'),
	('The Spanish Love Deception', 'Romance'),
	('The American Roommate Experiment', 'Romance'),
	('Book Lovers', 'Romance'),
	('Happy Place', 'Romance'),
	('O Mistério dos Sete Relógios', 'Mistério'),
	('Morte na Praia', 'Mistério'),
	('Homage to Catalonia', 'Histórico'),
	('Keep the Aspidistra Flying', 'Literatura Clássica'),
	('Harry Potter e o Prisioneiro de Azkaban', 'Fantasia'),
	('Harry Potter e o Cálice de Fogo', 'Fantasia'),
	('Contos da Era do Jazz', 'Literatura Clássica'),
	('O Último Magnata', 'Literatura Clássica'),
	('O Outono do Patriarca', 'Histórico'),
	('Crônica de uma Morte Anunciada', 'Histórico'),
	('1Q84', 'Ficção Científica'),
	('Caçando Carneiros', 'Ficção Científica'),
	('O Assassino Cego', 'Mistério'),
	('Orix e Crake', 'Ficção Científica'),
	('No Seu Pescoço', 'Histórico'),
	('Zikora', 'Histórico'),
	('De Amor e de Sombra', 'Histórico'),
	('A Ilha Sob o Mar', 'Histórico'),
	('Diário de um Mago', 'Ficção Científica'),
	('O Zahir', 'Ficção Científica'),
	('A Morte de Ivan Ilitch', 'Literatura Clássica'),
	('Ressurreição', 'Literatura Clássica'),
	('A Última Batalha', 'Fantasia'),
	('O Cavalo e Seu Menino', 'Fantasia'),
	('Silmarillion', 'Fantasia'),
	('Os Filhos de Húrin', 'Fantasia'),
	('O Sangue do Olimpo', 'Fantasia'),
	('A Pirâmide Vermelha', 'Fantasia'),
	('A Balada dos Pássaros e das Serpentes', 'Ficção Científica'),
	('Grega', 'Ficção Científica'),
	('The STEMinist Novellas', 'Romance'),
	('Missão Desastre', 'Romance'),
	('Talvez em Outro Lugar', 'Romance'),
	('E Se Fosse a Gente?', 'Romance'),
	('Lady Susan', 'Literatura Clássica'),
	('Persuasão', 'Literatura Clássica'),
	('Aconteceu Um Verão', 'Romance'),
	('O Amor que Sinto', 'Romance'),
	('You and Me on Vacation', 'Romance'),
	('Noivos à Força', 'Romance'),
	('Os Elefantes Não Esquecem', 'Mistério'),
	('O Misterioso Caso de Styles', 'Mistério');

--CRIAÇÃO DE VIEWS
CREATE OR REPLACE VIEW Livros_Autores_Categorias AS 
SELECT 
	l.titulo AS Livro, 
    a.nome AS Autor, 
    c.categoria AS Categoria
FROM 
	Livro l
JOIN 
	Livros_Categoria lc ON l.titulo = lc.livro
JOIN 
	Livros_Autor la ON l.titulo = la.livro
JOIN 
	Autor a ON la.autor = a.nome
JOIN 
    Categoria c ON lc.categoria = c.categoria
ORDER BY Livro;
	
-- CRIANDO FUNÇÃO 
CREATE OR REPLACE FUNCTION qnt_livros_autor(nome_autor VARCHAR)
RETURNS TABLE (autor_nome VARCHAR, quantidade_livros INT)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        la.autor, 
        CAST(COUNT(la.livro) AS INT) -- Convertendo o valor retornado de bigint para int
    FROM 
        Livros_Autor la
    WHERE 
        la.autor = nome_autor
    GROUP BY 
        la.autor;
END;
$$ LANGUAGE plpgsql;

-- SEGUNDA FUNÇÃO
CREATE OR REPLACE FUNCTION Total_Paginas_Autor(nome_autor VARCHAR)
RETURNS INT
AS $$
DECLARE
    total_paginas INT;
BEGIN
    SELECT SUM(l.paginas) INTO total_paginas
    FROM Livro l JOIN Livros_Autor la ON l.titulo = la.livro
    WHERE la.autor = nome_autor;
    RETURN COALESCE(total_paginas, 0); -- Se não encontrar livros, retorna 0.
END;
$$ LANGUAGE plpgsql;

--CRIANDO UMA VIEW SOBRE O AUTO QUE UTILIZA OS DADOS DA FUNÇÃO ANTERIOR
CREATE OR REPLACE VIEW Informacoes_Autor AS
SELECT 
    a.nome AS Autor,
    EXTRACT(YEAR FROM AGE(a.nascimento)) AS Idade,
    COUNT(la.livro) AS Quantidade_Livros,
    Total_Paginas_Autor(a.nome) AS Total_Paginas
FROM 
    Autor a
JOIN 
    Livros_Autor la ON a.nome = la.autor
GROUP BY 
    a.nome, a.nascimento
ORDER BY nome;

-- CRIANDO TRIGGER 
-- Mostra a data em que novos livros foram adicionados 
CREATE OR REPLACE FUNCTION Atualiza_Data_Modificacao()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza a coluna data_modificacao com a data e hora atuais
    NEW.data_modificacao := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualiza_data_modificacao
BEFORE UPDATE ON Livro
FOR EACH ROW
EXECUTE FUNCTION Atualiza_Data_Modificacao();

-- verifica se um novo autor possui mais de 18 anos 
CREATE OR REPLACE FUNCTION Verifica_Idade_Autor()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a idade do autor é menor que 18 anos
    IF EXTRACT(YEAR FROM AGE(NEW.data_nascimento)) < 18 THEN
        RAISE EXCEPTION 'O autor deve ter pelo menos 18 anos';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verifica_idade_autor
BEFORE INSERT OR UPDATE ON Autor
FOR EACH ROW
EXECUTE FUNCTION Verifica_Idade_Autor();


SELECT * FROM Autor;
SELECT * FROM Livro;
SELECT * FROM Categoria;
SELECT * FROM Livros_Autor;
SELECT * FROM Livros_Categoria;
SELECT * FROM Livros_Autores_Categorias;
SELECT * FROM Qnt_Livros_Autor('C.S. Lewis');
SELECT * FROM Qnt_Livros_Autor('Agatha Christie');
SELECT * FROM Qnt_Livros_Autor('J.K. Rowling');
SELECT * FROM Qnt_Livros_Autor('J.R.R. Tolkien');
SELECT Total_Paginas_Autor('Taylor Jenkins Reid');
SELECT * FROM Informacoes_Autor;