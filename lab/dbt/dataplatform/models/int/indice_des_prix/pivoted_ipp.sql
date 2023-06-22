
with ipp_stg_v1 as (
    select
        libelle_fr,
        libelle_ar,
        "2019",
        "2018",
        "2017",
        "2016"
    from {{ ref("ipp_v1_stg") }}
),

ipp_stg_v2 as (
    select
        libelle_fr,
        libelle_ar,
        "2021",
        "2020",
        "2019"
    from {{ ref("ipp_v2_stg") }}
),

pivoted_ipp_v1 as (
    unpivot ipp_stg_v1
    on columns(* exclude (libelle_fr, libelle_ar))
    into
        name year
        value value
),

pivoted_ipp_v2 as (
    unpivot ipp_stg_v2
    on columns(* exclude (libelle_fr, libelle_ar))
    into
        name year
        value value
),

ipp_v1 as (
    select
        libelle_fr,
        libelle_ar,
        year::integer as year,
        value,
        {# TODO: extract base_year from source instead of hardcoding it #}
        2010 as base_year
    from pivoted_ipp_v1
),

ipp_v2 as (
    select
        libelle_fr,
        libelle_ar,
        year::integer as year,
        value,
        {# TODO: extract base_year from source instead of hardcoding it #}
        2018 as base_year
    from pivoted_ipp_v2
),

unioned_ipp as (
    select * from ipp_v1
    union
    select * from ipp_v2
)

select * from unioned_ipp