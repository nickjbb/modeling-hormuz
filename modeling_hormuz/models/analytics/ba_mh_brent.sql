select
    brent_id,
    value,
    product_type,
    period,
    {{ seven_unit_max('period', 'value') }} as brent_weekly_max,
    {{ thirty_unit_max('period', 'value') }} as brent_monthly_max,
    {{ seven_unit_min('period', 'value') }} as brent_weekly_min,
    {{ thirty_unit_min('period', 'value') }} as brent_monthly_min,
    {{ seven_unit_average('period', 'value') }} as brent_weekly_avg,
    {{ thirty_unit_average('period', 'value') }} as brent_monthly_avg
from
    {{ ref('stg_mh_brent') }} as brent
order by
    period asc