CREATE DATABASE IF NOT EXISTS conectapet CHARACTER SET utf8mb4;
USE conectapet;

-- Tabela de Usuários Administrativos (Coordenadores/Voluntários)
CREATE TABLE Usuario (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  senha_hash VARCHAR(255) NOT NULL,
  perfil ENUM('admin', 'voluntario') DEFAULT 'voluntario',
  ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de Doadores
CREATE TABLE Doador (
  id_doador INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  cpf VARCHAR(14) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  telefone VARCHAR(20),
  data_cadastro DATE NOT NULL,
  ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de Categorias (Alimentação, Higiene, Medicamentos)
CREATE TABLE Categoria (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  descricao TEXT,
  ativa BOOLEAN DEFAULT TRUE
);

-- Tabela de Itens (Sachês, Areia, Vacinas)
CREATE TABLE Item (
  id_item INT AUTO_INCREMENT PRIMARY KEY,
  id_categoria INT NOT NULL,
  nome VARCHAR(150) NOT NULL,
  quantidade INT NOT NULL DEFAULT 0,
  prioridade ENUM('baixa', 'media', 'alta') DEFAULT 'media',
  ativo BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- Tabela de Registro de Doações
CREATE TABLE Doacao (
  id_doacao INT AUTO_INCREMENT PRIMARY KEY,
  id_doador INT NOT NULL,
  data_doacao DATE NOT NULL,
  descricao TEXT NOT NULL,
  status ENUM('pendente', 'entregue', 'cancelada') DEFAULT 'pendente',
  data_entrega DATE,
  data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_doador) REFERENCES Doador(id_doador)
);

-- Tabela Intermediária (Relacionamento N:N entre Doação e Item)
CREATE TABLE Doacao_Item (
  id_doacao INT NOT NULL,
  id_item INT NOT NULL,
  quantidade INT NOT NULL,
  data_adicao DATE,
  PRIMARY KEY (id_doacao, id_item),
  FOREIGN KEY (id_doacao) REFERENCES Doacao(id_doacao),
  FOREIGN KEY (id_item) REFERENCES Item(id_item)
);
