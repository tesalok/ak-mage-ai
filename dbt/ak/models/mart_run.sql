{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}

with new_record as (
    select
        gen_random_uuid() as id,
        current_timestamp as mart_run_time
)

select * from new_record
