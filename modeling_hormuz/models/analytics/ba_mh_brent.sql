select
    brent_id,
    value,
    product_type,
    period,
    {{ 7_unit_max('period', 'value') }} as brent_weekly_max,
    {{ 30_unit_max('period', 'value') }} as brent_monthly_max,
    {{ 7_unit_min('period', 'value') }} as brent_weekly_min,
    {{ 30_unit_min('period', 'value') }} as brent_monthly_min,
    {{ 7_unit_average('period', 'value') }} as brent_weekly_avg,
    {{ 30_unit_average('period', 'value') }} as brent_monthly_avg
from
    {{ ref('stg_mh_brent') }} as brent
order by
    period asc