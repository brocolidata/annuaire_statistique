with source as (
      select * from {{ source('indice_des_prix', 'ipp_v2') }}
),
renamed as (
    select
        libelle_fr::varchar as libelle_fr,
        libelle_ar::varchar as libelle_ar,
        round("2021", 1) as "2021",
        round("2020", 1) as "2020",
        round("2019", 1) as "2019"
    from source
)
select * from renamed
  