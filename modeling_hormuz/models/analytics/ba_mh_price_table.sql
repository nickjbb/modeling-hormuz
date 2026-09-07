WITH prices as (

    SELECT
        *
    FROM
        {{ ref('stg_mh_energy_prices') }}
)

SELECT
    p.price_key,
    d.date_key,
    dp.product_key,
    u.unit_key,
    p.value,
    p.ingested_at
FROM
    prices p
JOIN {{ ref('ba_mh_date_table') }} d
    on p.period = d.period
JOIN {{ ref('ba_mh_product_table') }} dp
    on p.product_type = dp.product_type
JOIN {{ ref('ba_mh_unit_table') }} u
    on p.units = u.units