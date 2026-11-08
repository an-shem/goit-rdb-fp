USE pandemic;

-- 3. Аналіз даних за кількістю випадків сказу
SELECT
    e.Entity,
    e.Code,
    AVG(ic.Number_rabies) AS avg_rabies,
    MIN(ic.Number_rabies) AS min_rabies,
    MAX(ic.Number_rabies) AS max_rabies,
    SUM(ic.Number_rabies) AS sum_rabies
FROM infectious_cases_normalized ic
INNER JOIN entities e ON ic.entity_id = e.entity_id
-- Порожні значення попередньо замінено на NULL,
-- тому додаткова перевірка на порожні рядки не потрібна.
WHERE ic.Number_rabies IS NOT NULL
GROUP BY e.entity_id, e.Entity, e.Code
ORDER BY avg_rabies DESC
LIMIT 10;