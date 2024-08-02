{{
    config(
        alias='product_orders_data',
    )
}}
    select p.id as product_id,
        p.name as product_name,
        p.order_id,
        p.order_quantity,
        p.shipping_address
    from {{ target.schema }}.product_orders_final p 
