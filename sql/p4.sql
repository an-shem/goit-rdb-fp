USE pandemic;

-- 4. Обчислення різниці в роках
SELECT
    Year,
    MAKEDATE(Year, 1) AS start_date,
    CURDATE() AS today_date,
    TIMESTAMPDIFF(
        YEAR,
        MAKEDATE(Year, 1),
        CURDATE()
    ) AS year_difference
FROM infectious_cases_normalized;