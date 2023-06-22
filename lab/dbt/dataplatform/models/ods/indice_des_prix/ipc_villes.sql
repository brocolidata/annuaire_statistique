
{{ 
    config(
        materialized='external',
        location="{{ env_var('DWH_DATA') }}/{{ model.config.database }}/{{ model.config.group }}/{{ model.name }}.csv"
    ) 
}}

with ipc_villes as (
    select
        libelle_fr,
        libelle_ar,
        year,
        value,
        city,
        base_year
    from {{ ref("pivoted_ipc_villes") }}
)

select * from ipc_villes