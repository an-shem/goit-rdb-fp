USE pandemic;

-- 5. Створення власної функції для обчислення різниці в роках
DROP FUNCTION IF EXISTS calculate_year_difference;

DELIMITER //
CREATE FUNCTION calculate_year_difference(input_year INT)
RETURNS INT
NOT DETERMINISTIC
NO SQL
BEGIN
    RETURN TIMESTAMPDIFF(
        YEAR,
        MAKEDATE(input_year, 1),
        CURDATE()
    );
END //
DELIMITER ;

-- Використання функції для обчислення різниці в роках
SELECT
    Year,
    calculate_year_difference(Year) AS year_difference
FROM infectious_cases_normalized;
