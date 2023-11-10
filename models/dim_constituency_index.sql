{{ config(materialized='table') }}

WITH source AS (
    SELECT *
    FROM "raw"."Ward_to_Westminster_Parliamentary_Constituency_to_Local_Authority_District_(December_2016)_Lookup_in_the_United_Kingdom"
)
SELECT

    DISTINCT("PCON16CD") as "constituency_code",
    "PCON16NM" as "constituency_name",
   
FROM source
ORDER BY "constituency_code"