
{{ 
    config(
        materialized='external',
        location="{{ env_var('DWH_DATA') }}/{{ model.config.database }}/{{ model.config.group }}/{{ model.name }}.csv"
    ) 
}}

with pivoted_ipc_national as (
    select
        libelle_fr,
        libelle_ar,
        year,
        value,
        base_year
    from {{ ref("pivoted_ipc_national") }}
)

select * from pivoted_ipc_national