{% snapshot product_orders_snapshot %}
{{
    config(
        target_schema='space',
        unique_key='id',
        check_cols='all',
        strategy='check',
        
    )
}}
    select p.*
    from space.product_orders_final p 

{% endsnapshot %}