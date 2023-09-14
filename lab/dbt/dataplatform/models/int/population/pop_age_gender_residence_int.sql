WITH concatenated_data AS (
  SELECT *, 
         2018 as year
         FROM {{ ref("pop_age_gender_residence18_stg") }}
  UNION ALL
  SELECT *, 
        2019 as year
        FROM {{ ref("pop_age_gender_residence19_stg") }}
  UNION ALL
  SELECT *,
        2020 as year 
        FROM {{ ref("pop_age_gender_residence20_stg") }}
  UNION ALL
  SELECT *,
        2021 as year
         FROM {{ ref("pop_age_gender_residence21_stg") }}
         ),
split_data as (
    SELECT
    *,
    CASE
      WHEN groupe_âge_fr LIKE '%Masculin%' THEN 'Masculin'
      WHEN groupe_âge_fr LIKE '%Féminin%' THEN 'Féminin'
      ELSE NULL
    END AS gender_fr,
    CASE
      WHEN groupe_âge_ar LIKE '%ذكور%' THEN 'ذكور'
      WHEN groupe_âge_ar LIKE '% إناث%' THEN 'إناث'
      ELSE NULL
    END AS gender_ar
  FROM
    concatenated_data
),
ordered_data AS (
  SELECT
    *,
    ROW_NUMBER() OVER () AS row_num
  FROM split_data
),

final_split AS (
  SELECT
    *,
    CASE
      WHEN gender_fr LIKE '%Masculin%' THEN LAG(groupe_âge_fr) OVER (ORDER BY row_num)
      WHEN gender_fr LIKE '%Féminin%' THEN LAG(groupe_âge_fr) OVER (ORDER BY row_num)
      ELSE groupe_âge_fr
    END AS age_group_fr,
    CASE
      WHEN gender_ar LIKE '%ذكور%' THEN LAG(groupe_âge_ar) OVER (ORDER BY row_num)
      WHEN gender_ar LIKE '%إناث%' THEN LAG(groupe_âge_ar) OVER (ORDER BY row_num)
      ELSE groupe_âge_ar
    END AS age_group_ar
  FROM ordered_data
)

-- Select age_group columns (age_group_fr and age_group_ar)
SELECT
  CASE
    WHEN age_group_fr LIKE '%Masculin%' THEN LAG(age_group_fr) OVER (ORDER BY row_num)
    WHEN age_group_fr LIKE '%Féminin%' THEN LAG(age_group_fr) OVER (ORDER BY row_num)
    ELSE age_group_fr
  END AS age_group_fr,
  gender_fr,
  ensemble,
  rural,
  urbain,
  CASE
    WHEN age_group_ar LIKE '%ذكور%' THEN LAG(age_group_ar) OVER (ORDER BY row_num)
    WHEN age_group_ar LIKE '%إناث%' THEN LAG(age_group_ar) OVER (ORDER BY row_num)
    ELSE age_group_ar
  END AS age_group_ar,
  gender_ar,
  year
FROM
  final_split
WHERE gender_fr IS NOT NULL


 