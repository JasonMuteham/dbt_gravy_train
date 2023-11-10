{{ config(materialized='view') }}

WITH source AS (
    SELECT *
    FROM {{ref('expenses')}}
    JOIN {{ref('mps')}} ON id = "mp_id"
)

SELECT  mp_id,
        first_name,
        last_name,
        full_name,
        gender,
        party_name,
        party_short,
        party_colour_code,
        constituency_code,
        constituency,
        house,
        first_elected_date,
        claim_number,
        claim_date,
        YEAR(claim_date)::INTEGER AS claim_year,
        financial_year,
        cost_category,
        cost_type,
        claim_description,
        claim_details,
        amount_claimed::DECIMAL(10,2) AS amount_claimed,
        amount_paid::DECIMAL(10,2) AS amount_paid,
        amount_not_paid::DECIMAL(10,2) AS amount_not_paid,
        claim_status,
        not_paid_reason

FROM source