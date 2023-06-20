
{{ 
    config(
        materialized='external',
        location="{{ env_var('DWH_DATA') }}/{{ model.config.database }}/{{ model.config.group }}/{{ model.name }}.csv"
    ) 
}}

with pivoted_ipp as (
    select
        libelle_fr,
        libelle_ar,
        year,
        value,
        base_year
    from {{ ref("pivoted_ipp") }}
)

select * from pivoted_ipp