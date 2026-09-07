with distinct_dates as (
    SELECT DISTINCT period::date as period
    FROM {{ ref('stg_mh_energy_prices')}}
)

SELECT
    period,
    ROW_NUMBER() OVER (ORDER BY period) as date_key
FROM
    distinct_dates