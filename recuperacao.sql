-- Criação do banco de dados
CREATE DATABASE boxing_db;
USE boxing_db;

-- Criação da tabela boxers
CREATE TABLE boxers (
    boxer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    weight_class VARCHAR(50) NOT NULL,
    record VARCHAR(50) NOT NULL
);

-- Criação da tabela fights
CREATE TABLE fights (
    fight_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    boxer1_id INT NOT NULL,
    boxer2_id INT NOT NULL,
    result VARCHAR(50) NOT NULL,
    FOREIGN KEY (boxer1_id) REFERENCES boxers(boxer_id),
    FOREIGN KEY (boxer2_id) REFERENCES boxers(boxer_id)
);

-- Criação da tabela coaches
CREATE TABLE coaches (
    coach_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    specialty VARCHAR(100) NOT NULL
);

-- Criação da tabela trainings
CREATE TABLE trainings (
    training_id INT AUTO_INCREMENT PRIMARY KEY,
    boxer_id INT NOT NULL,
    coach_id INT NOT NULL,
    date DATE NOT NULL,
    duration INT NOT NULL,  -- duração em minutos
    FOREIGN KEY (boxer_id) REFERENCES boxers(boxer_id),
    FOREIGN KEY (coach_id) REFERENCES coaches(coach_id)
);

-- Criação da tabela fight_stats
CREATE TABLE fight_stats (
    stat_id INT AUTO_INCREMENT PRIMARY KEY,
    fight_id INT NOT NULL,
    boxer_id INT NOT NULL,
    punches_thrown INT NOT NULL,
    punches_landed INT NOT NULL,
    FOREIGN KEY (fight_id) REFERENCES fights(fight_id),
    FOREIGN KEY (boxer_id) REFERENCES boxers(boxer_id)
);

-- Inserir dados na tabela boxers
INSERT INTO boxers (name, birth_date, weight_class, record)
VALUES
('John Doe', '1990-05-15', 'Middleweight', '20-5-0'),
('Jane Smith', '1988-12-20', 'Lightweight', '25-3-1'),
('Mike Johnson', '1992-03-10', 'Heavyweight', '18-7-2');

-- Inserir dados na tabela fights
INSERT INTO fights (date, boxer1_id, boxer2_id, result)
VALUES
('2024-01-10', 1, 2, 'John Doe win'),
('2024-03-15', 2, 3, 'Jane Smith win');

-- Inserir dados na tabela coaches
INSERT INTO coaches (name, birth_date, specialty)
VALUES
('Coach A', '1975-09-25', 'Boxing Techniques'),
('Coach B', '1980-11-14', 'Strength Training');

-- Inserir dados na tabela trainings
INSERT INTO trainings (boxer_id, coach_id, date, duration)
VALUES
(1, 1, '2024-01-05', 90),
(2, 2, '2024-02-20', 120);

-- Inserir dados na tabela fight_stats
INSERT INTO fight_stats (fight_id, boxer_id, punches_thrown, punches_landed)
VALUES
(1, 1, 150, 80),
(1, 2, 140, 60),
(2, 2, 160, 85),
(2, 3, 155, 75);

-- Mostrar todos os lutadores
SELECT * FROM boxers;

-- Mostrar todas as lutas
SELECT * FROM fights;

-- Mostrar todos os treinadores
SELECT * FROM coaches;

-- Mostrar todos os treinamentos
SELECT * FROM trainings;

-- Mostrar todas as estatísticas de luta
SELECT * FROM fight_stats;

-- Filtrar lutas por período de data
SELECT * FROM fights
WHERE date BETWEEN '2024-01-01' AND '2024-12-31';

-- Filtrar estatísticas de luta onde punches_thrown é maior que 150
SELECT * FROM fight_stats
WHERE punches_thrown > 150;

-- Filtrar estatísticas de luta com a soma de punches_thrown e punches_landed maior que 200
SELECT fight_id, boxer_id, (punches_thrown + punches_landed) AS total_punches
FROM fight_stats
HAVING total_punches > 200;

-- Obter informações sobre lutas, incluindo os nomes dos boxers
SELECT f.date, b1.name AS Boxer1, b2.name AS Boxer2, f.result
FROM fights f
JOIN boxers b1 ON f.boxer1_id = b1.boxer_id
JOIN boxers b2 ON f.boxer2_id = b2.boxer_id;

-- Filtrar boxers com o nome contendo "John"
SELECT * FROM boxers
WHERE name LIKE '%John%';


