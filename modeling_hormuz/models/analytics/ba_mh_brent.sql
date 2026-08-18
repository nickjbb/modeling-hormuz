select
    brent_id,
    value,
    product_type,
    period,
    {{ weekly_max('period', 'value') }} as brent_weekly_max,
    {{ monthly_max('period', 'value') }} as brent_monthly_max,
    {{ weekly_min('period', 'value') }} as brent_weekly_min,
    {{ monthly_min('period', 'value') }} as brent_monthly_min,
    {{ weekly_average('period', 'value') }} as brent_weekly_avg,
    {{ monthly_average('period', 'value') }} as brent_monthly_avg
from
    {{ ref('stg_mh_brent') }} as brent
order by
    period asc