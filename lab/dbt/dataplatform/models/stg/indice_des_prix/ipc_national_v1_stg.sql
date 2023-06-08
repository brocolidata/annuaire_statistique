{{ 
    config(
        materialized='external',
        location="{{ env_var('DWH_DATA') }}/{{ model.config.database }}/{{ model.config.group }}/{{ model.name }}.parquet"
    ) 
}}


with source as (
      select * from {{ source('indice_des_prix', 'ipc_national_v1') }}
),
renamed as (
    select
        libelle_fr::varchar as libelle_fr,
        libelle_ar::varchar as libelle_ar,
        round("2018", 1) as "2018",
        round("2017", 1) as "2017",
        round("2016", 1) as "2016"
    from source
)
select * from renamed
  