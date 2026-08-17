select
    md5(period::text || "product-name" || value::text) as gas_id,
    period,
    value::numeric as "value",
    "product-name" as product_type,
    units,
    ingested_at,
    units
from
    {{ source('mh_sources', 'wti_usd') }}