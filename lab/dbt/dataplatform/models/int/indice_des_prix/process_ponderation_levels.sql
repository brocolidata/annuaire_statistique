{{ 
    config(
        pre_hook="CREATE TEMPORARY SEQUENCE basket_order START 1"
    ) 
}}

with ponderation_ipc as (
    select * from {{ ref('ponderation_ipc_stg') }}
),

ponderation_keep_2_levels as (
    select
        element_panier,
        code,
        length(code) as level,
        nextval('basket_order') as basket_order,
        ponderation_2006,
        ponderation_2017
    from ponderation_ipc
    where length(code) < 3
),

ponderation_parents as (
    select
        code,
        element_panier,
        level,
        basket_order,
        case
            when level > 1 then left(
                code::VARCHAR,
                level-1
            )::INTEGER
            else null
        end as parent,
        ponderation_2006,
        ponderation_2017
    from ponderation_keep_2_levels
    order by basket_order
)

select * from ponderation_parents