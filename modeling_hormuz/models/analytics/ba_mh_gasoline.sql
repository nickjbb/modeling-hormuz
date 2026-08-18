select
    gas_id,
    value,
    product_type,
    period,
    {{ weekly_max('period', 'value') }} as gas_weekly_max,
    {{ monthly_max('period', 'value') }} as gas_monthly_max,
    {{ weekly_min('period', 'value') }} as gas_weekly_min,
    {{ monthly_min('period', 'value') }} as gas_monthly_min,
    {{ weekly_average('period', 'value') }} as gas_weekly_avg,
    {{ monthly_average('period', 'value') }} as gas_monthly_avg
from
    {{ ref('stg_mh_gasoline') }} as gasoline
order by
    period asc