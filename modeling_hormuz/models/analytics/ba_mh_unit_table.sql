with distinct_units as (
    SELECT DISTINCT
        units
    FROM
        {{ ref('stg_mh_energy_prices')}}
)

SELECT
    units,
    ROW_NUMBER() OVER (ORDER BY units) as unit_key
FROM
    distinct_units