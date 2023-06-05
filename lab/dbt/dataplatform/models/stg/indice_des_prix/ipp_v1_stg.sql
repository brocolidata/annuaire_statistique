{{ 
    config(
        materialized='external',
        location="{{ env_var('DWH_DATA') }}/stg/indice_des_prix/base_ipp_v1.parquet"
    ) 
}}


with source as (
      select * from {{ source('indice_des_prix', 'ipp_v1') }}
),
renamed as (
    select
        libelle_fr,
        libelle_ar,
        "2019",
        "2018",
        "2017",
        "2016"
    from source
)
select * from renamed
  