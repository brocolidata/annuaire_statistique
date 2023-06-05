
{{ 
    config(
        materialized='external',
        location="{{ env_var('DWH_DATA') }}/ods/indice_des_prix/ipp.parquet"
    ) 
}}

with ipp_v1 as (
    select
        libelle_fr,
        libelle_ar,
        "2019",
        "2018",
        "2017",
        "2016"
    from {{ ref("ipp_v1_stg") }}
),

pivoted_ipp as (
    unpivot ipp_v1
    on columns(* exclude (libelle_fr, libelle_ar))
    into
        name year
        value value
),

ipp as (
    select
        libelle_fr,
        libelle_ar,
        year::integer as year,
        value
    from pivoted_ipp
)

select * from ipp