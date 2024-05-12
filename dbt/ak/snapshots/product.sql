{% snapshot product_snapshot %}

{{
    config(
        target_schema='space',
        unique_key='id',
        updated_at='updated_at',
        strategy='timestamp',
        )
       
}}
select * from space.product p 
-- where p.is_deleted =false 
{% if is_incremental() %}

  -- This WHERE clause filters out records that already exist in the destination table.
  -- Adjust the logic based on your needs (e.g., fetching only newer records).
  where updated_at > (SELECT MAX(updated_at) FROM {{ this }})
  or created_at > (SELECT MAX(created_at) FROM {{ this }})

{% endif %}

{% endsnapshot %}