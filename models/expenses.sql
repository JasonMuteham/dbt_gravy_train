{{ config(materialized='table') }}

WITH source AS (
    SELECT *
    FROM raw.expenses
    WHERE "Parliamentary ID" IS NOT NULL
)

SELECT
    "Parliamentary ID" as mp_id,
    "Constituency" as constituency,
    "Year" as financial_year,
    strptime("Date", '%d/%m/%Y')::DATE as claim_date,
    "Claim Number" as claim_number,
    Name as name,
    Category as cost_category,
    "Cost Type" as cost_type,
    "Short Description" as claim_description,
    "Details" as claim_details,
    "Journey Type" as journey_type,
    "From" as journey_from,
    "To" as journey_to,
    Nights as journey_nights,
    Mileage as journey_mileage,
    "Amount Claimed"::DECIMAL(10,2) as amount_claimed,
    "Amount Paid"::DECIMAL(10,2) as amount_paid,
    "Amount Not Paid"::DECIMAL(10,2) as amount_not_paid,
    "Amount Repaid"::DECIMAL(10,2) as amount_repaid,
    "Status" as claim_status,
    "Reason If Not Paid" as not_paid_reason
FROM source