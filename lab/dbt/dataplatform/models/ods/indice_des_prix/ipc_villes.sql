
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
),

process_ponderation_levels_int as (
    select
        basket_order,
        code,
        element_panier
    from {{ ref("process_ponderation_levels") }}
),

joined_ipc_ponderation as (
    select 
        ipc_villes.*,
        process_ponderation_levels_int.basket_order
    from ipc_villes
    left join process_ponderation_levels_int 
        on process_ponderation_levels_int.element_panier = ipc_villes.libelle_fr
),

ordered_ipc_ponderation as (
    select * exclude (basket_order) 
    from joined_ipc_ponderation
    order by 
        basket_order asc, 
        city asc,
        base_year desc,
        year desc
)

select * from ordered_ipc_ponderation