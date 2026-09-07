select
    md5(period::text || "product-name" || value::text) as price_key,
    period::date,
    value::numeric as "value",
    "product-name" as product_type,
    units,
    ingested_at
from
    {{ source('mh_sources', 'brent_crude') }}

UNION ALL

select
    md5(period::text || "product-name" || value::text) as price_key,
    period::date,
    value::numeric as "value",
    "product-name" as product_type,
    units,
    ingested_at
from
    {{ source('mh_sources', 'gasoline') }}

UNION ALL

select
    md5(period::text || "product-name" || value::text) as price_key,
    period::date,
    value::numeric as "value",
    "product-name" as product_type,
    units,
    ingested_at
from
    {{ source('mh_sources', 'wti_crude') }}