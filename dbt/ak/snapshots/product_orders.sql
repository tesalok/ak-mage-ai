{% snapshot product_orders_snapshot %}
{{
    config(
        target_schema='space',
        unique_key='id',
        check_cols='all',
        strategy='check',
        
    )
}}
    select p.*,
        o.id as order_id,
        o.quantity as order_quantity,
        o.shipping_address,
        o.created_at as o_created_at,
        o.updated_at as o_updated_at,
        pom.id as product_orders_mapping_id,
        pom.created_at as pom_created_at,
        pom.updated_at as pom_updated_at
    from product p 
        left join product_orders_mapping pom on pom.product_id = p.id 
        left join orders o on o.id  = pom.order_id and o.is_deleted =false
        where p.is_deleted =false
{% if is_incremental() %}

  -- This WHERE clause filters out records that already exist in the destination table.
  -- Adjust the logic based on your needs (e.g., fetching only newer records).
  and ( p.updated_at > (SELECT MAX(updated_at) FROM {{ this }})
  or p.created_at > (SELECT MAX(created_at) FROM {{ this }})
  or o.created_at > (SELECT MAX(o_created_at) FROM {{ this }})
  or o.updated_at > (SELECT MAX(o_updated_at) FROM {{ this }}) 
  or pom.created_at > (SELECT MAX(pom_created_at) FROM {{ this }})
  or pom.updated_at > (SELECT MAX(pom_updated_at) FROM {{ this }})
  )
{% endif %}
{% endsnapshot %}