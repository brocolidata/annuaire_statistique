with pop_age_sex_resid19 as (
      select * from {{ source('population', 'pop_age_sex_resid19') }}
),
renamed as (
    select
        "Groupe d'âge" as groupe_âge_fr,
        "      Ensemble" as ensemble,
        "      Rural" as rural,
        "     Urbain" as urbain,
        "الفئة العمرية" as groupe_âge_ar

    from pop_age_sex_resid19
)
select * from renamed