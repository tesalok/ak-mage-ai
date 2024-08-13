{{
    config(
        unique_key='id',
        alias='orders',
        materialized='incremental',
        incremental_strategy='merge'
    )
}}
WITH orders_cte AS (
  select *,
    current_timestamp as mart_updated_at  
  from orders 
)

select *,
      CASE 
        WHEN mart_updated_at = current_timestamp THEN false 
        ELSE true 
      END as is_sf_published
from orders_cte

{% if is_incremental() %}
  where updated_at > (SELECT MAX(updated_at) FROM {{ this }})
  or created_at > (SELECT MAX(created_at) FROM {{ this }})
{% endif %}