{{ config(materialized='table') }}

WITH source AS (
    SELECT *
    FROM raw.dim_dates
)

select *
FROM source