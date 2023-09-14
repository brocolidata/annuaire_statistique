{{ 
    config(
        materialized='external',
        location="{{ env_var('DWH_DATA') }}/{{ model.config.database }}/{{ model.config.group }}/{{ model.name }}.csv"
    ) 
}}

with pop_fv as (
    select *
    from {{ ref("pop_age_gender_residence_int") }}
)

select * from pop_fv