-- 1.1 Створення схеми pandemic
CREATE SCHEMA IF NOT EXISTS pandemic;
USE pandemic;

-- 1.2 Перевірка кількості імпортованих записів
SELECT COUNT(*) AS total_records
FROM infectious_cases;

-- 1.3. Заміна порожніх значень на NULL
-- Тимчасове вимкнення безпечного режиму
SET SQL_SAFE_UPDATES = 0;
-- Заміна порожніх значень на NULL
UPDATE infectious_cases
SET
    Number_yaws = NULLIF(TRIM(Number_yaws), ''),
    polio_cases = NULLIF(TRIM(polio_cases), ''),
    cases_guinea_worm = NULLIF(TRIM(cases_guinea_worm), ''),
    Number_rabies = NULLIF(TRIM(Number_rabies), ''),
    Number_malaria = NULLIF(TRIM(Number_malaria), ''),
    Number_hiv = NULLIF(TRIM(Number_hiv), ''),
    Number_tuberculosis = NULLIF(TRIM(Number_tuberculosis), ''),
    Number_smallpox = NULLIF(TRIM(Number_smallpox), ''),
    Number_cholera_cases = NULLIF(TRIM(Number_cholera_cases), '');
-- Відновлення безпечного режиму
SET SQL_SAFE_UPDATES = 1;


-- 1.4. Перевірка заміни порожніх значень на NULL
SELECT
    COUNT(*) AS total_records,
    SUM(Number_yaws = '') AS empty_yaws,
    SUM(Number_rabies = '') AS empty_rabies,
    SUM(Number_malaria = '') AS empty_malaria,
    SUM(Number_hiv = '') AS empty_hiv,
    SUM(Number_rabies IS NULL) AS null_rabies,
    SUM(Number_malaria IS NULL) AS null_malaria,
    SUM(Number_hiv IS NULL) AS null_hiv
FROM infectious_cases;


-- 1.5. Перетворення типів даних стовпців
ALTER TABLE infectious_cases
    MODIFY COLUMN Number_yaws BIGINT NULL,
    MODIFY COLUMN polio_cases BIGINT NULL,
    MODIFY COLUMN cases_guinea_worm BIGINT NULL,
    MODIFY COLUMN Number_rabies DOUBLE NULL,
    MODIFY COLUMN Number_malaria DOUBLE NULL,
    MODIFY COLUMN Number_hiv DOUBLE NULL,
    MODIFY COLUMN Number_tuberculosis DOUBLE NULL,
    MODIFY COLUMN Number_smallpox BIGINT NULL,
    MODIFY COLUMN Number_cholera_cases BIGINT NULL;


-- 1.6. Перевірка структури таблиці та кількості записів
-- Перевірка типів даних
DESCRIBE infectious_cases;

-- Перевірка кількості записів
SELECT COUNT(*) AS total_records
FROM infectious_cases;
