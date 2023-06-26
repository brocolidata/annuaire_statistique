with source as (
    select * from {{ source('ponderation_prix_HC', 'ponderation_ipc') }}
),

renamed as (
    select
        code::INTEGER as code, 
        element_panier::VARCHAR as element_panier,
        ponderation_2006::DOUBLE as ponderation_2006,
        ponderation_2017::DOUBLE as ponderation_2017
    from source
)

select * from renamed
  