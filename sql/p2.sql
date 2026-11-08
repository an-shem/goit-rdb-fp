USE pandemic;
-- 2.1. Створення таблиці entities

CREATE TABLE IF NOT EXISTS entities (
    entity_id INT AUTO_INCREMENT PRIMARY KEY,
    Entity VARCHAR(255) NOT NULL,
    Code VARCHAR(20),
    UNIQUE KEY uq_entity_code (Entity, Code)
);


-- 2.2. Заповнення таблиці entities унікальними значеннями
INSERT INTO entities (Entity, Code)
SELECT DISTINCT Entity, Code
FROM infectious_cases;

-- Перевірка кількості унікальних записів
SELECT COUNT(*) AS total_entities
FROM entities;


-- 2.3. Створення таблиці infectious_cases_normalized
CREATE TABLE infectious_cases_normalized (
    id INT AUTO_INCREMENT PRIMARY KEY,
    entity_id INT NOT NULL,
    Year INT,
    Number_yaws BIGINT,
    polio_cases BIGINT,
    cases_guinea_worm BIGINT,
    Number_rabies DOUBLE,
    Number_malaria DOUBLE,
    Number_hiv DOUBLE,
    Number_tuberculosis DOUBLE,
    Number_smallpox BIGINT,
    Number_cholera_cases BIGINT,
    FOREIGN KEY (entity_id) REFERENCES entities(entity_id)
);


-- 2.4. Заповнення нормалізованої таблиці даними
INSERT INTO infectious_cases_normalized (
    entity_id,
    Year,
    Number_yaws,
    polio_cases,
    cases_guinea_worm,
    Number_rabies,
    Number_malaria,
    Number_hiv,
    Number_tuberculosis,
    Number_smallpox,
    Number_cholera_cases
)
SELECT
    e.entity_id,
    ic.Year,
    ic.Number_yaws,
    ic.polio_cases,
    ic.cases_guinea_worm,
    ic.Number_rabies,
    ic.Number_malaria,
    ic.Number_hiv,
    ic.Number_tuberculosis,
    ic.Number_smallpox,
    ic.Number_cholera_cases
FROM infectious_cases ic
INNER JOIN entities e
    ON ic.Entity = e.Entity
    AND ic.Code <=> e.Code;
    

-- 2.5. Перевірка кількості записів після нормалізації
SELECT
    (SELECT COUNT(*) FROM infectious_cases) AS original_records,
    (SELECT COUNT(*) FROM infectious_cases_normalized) AS normalized_records;

