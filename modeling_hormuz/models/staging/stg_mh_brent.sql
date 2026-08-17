
select
    md5(period::text || "product-name" || value::text) as brent_id,
    period,
    value::numeric as "value",
    "product-name" as product_type,
    units,
    ingested_at
from
    {{ source('mh_sources', 'brent_crude') }}