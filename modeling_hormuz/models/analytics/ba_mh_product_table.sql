with product_types as (
    SELECT DISTINCT
        product_type
    FROM
        {{ ref('stg_mh_energy_prices')}}
)

SELECT
    product_type,
    ROW_NUMBER() OVER (ORDER BY product_type) as product_key
FROM
    product_types