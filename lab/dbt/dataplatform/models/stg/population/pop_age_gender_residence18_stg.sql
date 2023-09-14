with pop_age_sex_resid18 as (
      select * from {{ source('population', 'pop_age_sex_resid18') }}
),
renamed as (
    select
        "Groupe d'âge"::varchar as groupe_âge_fr,
        "      Ensemble" as ensemble,
        "      Rural" as rural,
        "     Urbain" as urbain,
        "الفئة العمرية"::varchar as groupe_âge_ar

    from pop_age_sex_resid18
)
select * from renamed