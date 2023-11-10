{{ config(materialized='table') }}

with source as (
    SELECT * EXCLUDE (links, value_thumbnailUrl) 
    REPLACE (
        CASE 
            WHEN starts_with(value_nameDisplayAs,'Mrs ') THEN replace(value_nameDisplayAs, 'Mrs ', '')
            WHEN starts_with(value_nameDisplayAs,'Dame ') THEN replace(value_nameDisplayAs, 'Dame ', '')
            WHEN starts_with(value_nameDisplayAs,'Ms ') THEN replace(value_nameDisplayAs, 'Ms ', '') 
            WHEN starts_with(value_nameDisplayAs,'Dr ') THEN replace(value_nameDisplayAs, 'Dr ', '')
            WHEN starts_with(value_nameDisplayAs,'Mr ') THEN replace(value_nameDisplayAs, 'Mr ', '')
            WHEN starts_with(value_nameDisplayAs,'Sir ') THEN replace(value_nameDisplayAs, 'Sir ', '')            
            ELSE value_nameDisplayAs
        END
        AS value_nameDisplayAs, 
        CASE
            WHEN contains(value_latestParty_name,'(Co-op)') THEN replace(value_latestParty_name, '(Co-op)','')
            ELSE  value_latestParty_name
        END
        AS value_latestParty_name,
        value_latestHouseMembership_membershipStartDate::DATE AS value_latestHouseMembership_membershipStartDate,
        value_latestHouseMembership_membershipStatus_statusStartDate::DATE AS value_latestHouseMembership_membershipStatus_statusStartDate,
        CASE
            WHEN value_latestHouseMembership_house = 1 THEN 'Commons'
            ELSE 'Lords'
        END 
        AS value_latestHouseMembership_house
            
    )
    FROM raw.mp
    JOIN {{ref("dim_constituency_index")}} ON constituency_name = value_latestHouseMembership_membershipFrom
)

SELECT  value_id AS id,
        CASE 
            WHEN starts_with(split_part(value_nameListAs, ',', 2),' Dame') THEN replace(split_part(value_nameListAs, ',', 2), ' Dame', '')
            WHEN starts_with(split_part(value_nameListAs, ',', 2),' Ms') THEN replace(split_part(value_nameListAs, ',', 2), ' Ms', '') 
            WHEN starts_with(split_part(value_nameListAs, ',', 2),' Mrs') THEN replace(split_part(value_nameListAs, ',', 2), ' Mrs', '')             
            WHEN starts_with(split_part(value_nameListAs, ',', 2),' Dr') THEN replace(split_part(value_nameListAs, ',', 2), ' Dr', '')
            WHEN starts_with(split_part(value_nameListAs, ',', 2),' Mr') THEN replace(split_part(value_nameListAs, ',', 2), ' Mr', '')
            WHEN starts_with(split_part(value_nameListAs, ',', 2),' Sir') THEN replace(split_part(value_nameListAs, ',', 2), ' Sir', '')            
            ELSE split_part(value_nameListAs, ',', 2)
        END
        AS first_name,
        split_part(value_nameListAs, ',', 1) as last_name,
        value_nameDisplayAs as full_name,
        value_nameFullTitle as name_full_title,
        value_gender as gender,
        value_latestParty_name as party_name,
        value_latestParty_abbreviation as party_short,
        value_latestParty_backgroundColour as party_colour_code,
        value_latestHouseMembership_membershipFrom as constituency,
        constituency_code,
        value_latestHouseMembership_house as house,
        value_latestHouseMembership_membershipStartDate as first_elected_date,
        value_latestHouseMembership_membershipEndDate::DATE as member_end_date,
        value_latestHouseMembership_membershipEndReason as member_end_reason,
        value_latestHouseMembership_membershipEndReasonNotes as membershipEndReasonNotes,
        value_latestHouseMembership_membershipEndReasonId as membershipEndReasonId,
        value_latestHouseMembership_membershipStatus_statusIsActive as statusIsActive,
        value_latestHouseMembership_membershipStatus_statusDescription as statusDescription,
        value_latestHouseMembership_membershipStatus_statusNotes as statusNotes,
        value_latestHouseMembership_membershipStatus_statusId as statusId,
        value_latestHouseMembership_membershipStatus_status as status,
        value_latestHouseMembership_membershipStatus_statusStartDate as last_elected_date
from source