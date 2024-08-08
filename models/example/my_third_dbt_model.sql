/*
    Extended version of your first dbt model
    This version includes more dbt features for testing
*/

{{ config(materialized='table') }}

with source_data as (

    select 1 as id, 'A' as category
    union all
    select null as id, 'B' as category
    union all
    select 2 as id, 'A' as category
    union all
    select 3 as id, 'C' as category

),

filtered_data as (

    select *
    from source_data
    where id is not null

),

categorized_data as (

    select
        *,
        case
            when category = 'A' then 'Group 1'
            when category = 'B' then 'Group 2'
            else 'Group 3'
        end as category_group
    from filtered_data

)

select
    id,
    category,
    category_group,
    '{{ run_started_at }}' as model_run_at
from categorized_data