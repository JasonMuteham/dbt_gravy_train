{{ config(materialized='table') }}

WITH source AS (
    SELECT *
    FROM raw.expenses
    WHERE "Parliamentary ID" IS NOT NULL
)

SELECT
    "Parliamentary ID" as mp_id,
    "Year" as financial_year,
    "Date" as claim_date,
    "Claim Number" as claim_number,
    Name as name,
    Category as cost_category,
    "Cost Type" as cost_type,
    "Short Description" as claim_describtion,
    "Details" as claim_details,
    "Journey Type" as journey_type,
    "From" as journey_from,
    "To" as journey_to,
    Nights as journey_nights,
    Mileage as journey_mileage,
    "Amount Claimed" as amount_claimed,
    "Amount Paid" as amount_paid,
    "Amount Not Paid" as amount_not_paid,
    "Amount Repaid" as amount_repaid,
    "Status" as claim_status,
    "Reason If Not Paid" as not_paid_reason
FROM source