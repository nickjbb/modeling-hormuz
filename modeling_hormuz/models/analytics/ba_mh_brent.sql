select
    price,
    code,
    created_at,
    {{ daily_max('stg_mh_brent', 'created_at', 'price') }} as brent_daily_max,
    {{ weekly_max('stg_mh_brent', 'created_at', 'price') }} as brent_weekly_max,
    {{ monthly_max('stg_mh_brent', 'created_at', 'price') }} as brent_monthly_max,
    {{ daily_min('stg_mh_brent', 'created_at', 'price') }} as brent_daily_min,
    {{ weekly_min('stg_mh_brent', 'created_at', 'price') }} as brent_weekly_min,
    {{ monthly_min('stg_mh_brent', 'created_at', 'price') }} as brent_monthly_min,
    {{ daily_average('stg_mh_brent', 'created_at', 'price') }} as brent_daily_avg,
    {{ weekly_average('stg_mh_brent', 'created_at', 'price') }} as brent_weekly_avg,
    {{ monthly_average('stg_mh_brent', 'created_at', 'price') }} as brent_monthly_avg
from
    {{ ref('stg_mh_brent') }} as brent
order by
    created_at asc