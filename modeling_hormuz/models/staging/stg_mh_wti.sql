select
    md5(created_at::text || code || price::text) as wti_id,
    price,
    created_at,
    code,
    currency,
    unit,
    stale
from
    {{ source('mh_sources', 'wti_usd') }}