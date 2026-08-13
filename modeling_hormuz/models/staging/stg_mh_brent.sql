
select
    md5(created_at::text || code || price::text) as brent_id,
    price,
    code,
    created_at,
    unit,
    stale
from
    {{ source('mh_sources', 'brent_crude_usd') }}