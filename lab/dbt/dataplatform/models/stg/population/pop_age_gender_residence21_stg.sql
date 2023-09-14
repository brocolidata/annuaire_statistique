with pop_age_sex_resid21 as (
      select * from {{ source('population', 'pop_age_sex_resid21') }}
),
renamed as (
    select
        "Groupe d'âge" as groupe_âge_fr,
        ROUND(CAST("      Ensemble" AS NUMERIC), 0) as ensemble,
        ROUND(CAST("      Rural" AS NUMERIC), 0) as rural,
        ROUND(CAST("     Urbain" AS NUMERIC), 0) as urbain,
        "الفئة العمرية" as groupe_âge_ar
    from pop_age_sex_resid21
)
select * from renamed