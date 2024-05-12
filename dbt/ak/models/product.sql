{{
    config(
        unique_key='id',
        alias='product',
        materialized='incremental',
        incremental_strategy='merge'
    )
}}
select * from product p 
-- where p.is_deleted =false 
{% if is_incremental() %}

  -- This WHERE clause filters out records that already exist in the destination table.
  -- Adjust the logic based on your needs (e.g., fetching only newer records).
  where updated_at > (SELECT MAX(updated_at) FROM {{ this }})
  or created_at > (SELECT MAX(created_at) FROM {{ this }})

{% endif %}