-- ARRAY
WITH skills AS (
    SELECT 'python' AS skill
    UNION ALL
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
), skill_array AS(
    SELECT ARRAY_AGG(skill ORDER BY skill) AS skills
    FROM skills
)
SELECT skills[1]
FROM skill_array;

-- STRUCT
SELECT
    STRUCT_PACK(
        skill := 'python',
        type := 'programming'
    ) AS structs;