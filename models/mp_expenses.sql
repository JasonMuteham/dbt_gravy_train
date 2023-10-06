{{ config(materialized='view') }}

WITH source AS (
    SELECT *
    FROM {{ref('expenses')}}
    JOIN {{ref('mps')}} ON id = "mp_id"
)

SELECT  mp_id,
        first_name,
        last_name,
        name_full_title,
        gender,
        party_name,
        party_short,
        constituency,
        house,
        first_elected_date,
        claim_number,
        claim_date,
        financial_year,
        cost_category,
        cost_type,
        claim_describtion,
        claim_details,
        amount_claimed,
        amount_paid,
        amount_not_paid,
        claim_status,
        not_paid_reason

FROM source