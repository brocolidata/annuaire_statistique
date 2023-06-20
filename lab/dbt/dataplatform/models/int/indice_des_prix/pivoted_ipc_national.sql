with ipc_national_stg_v1 as (
    select
        libelle_fr,
        libelle_ar,
        "2018",
        "2017",
        "2016"
    from {{ ref("ipc_national_v1_stg") }}
),

ipc_national_stg_v2 as (
    select
        libelle_fr,
        libelle_ar,
        "2021",
        "2020",
        "2019",
        "2018"
    from {{ ref("ipc_national_v2_stg") }}
),

pivoted_v1 as (
    unpivot ipc_national_stg_v1
    on columns(* exclude (libelle_fr, libelle_ar))
    into
        name year
        value value
),

pivoted_v2 as (
    unpivot ipc_national_stg_v2
    on columns(* exclude (libelle_fr, libelle_ar))
    into
        name year
        value value
),

ipc_national_v1 as (
    select
        libelle_fr,
        libelle_ar,
        year::integer as year,
        value,
        {# TODO: extract base_year from source instead of hardcoding it #}
        2006 as base_year
    from pivoted_v1
),

ipc_national_v2 as (
    select
        libelle_fr,
        libelle_ar,
        year::integer as year,
        value,
        {# TODO: extract base_year from source instead of hardcoding it #}
        2017 as base_year
    from pivoted_v2
),

unioned_ipc_national as (
    select * from ipc_national_v1
    union
    select * from ipc_national_v2
)

select * from unioned_ipc_national