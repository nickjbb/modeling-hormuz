select
    wti_id,
    value,
    product_type,
    period,
    {{ weekly_max('period', 'value') }} as wti_weekly_max,
    {{ monthly_max('period', 'value') }} as wti_monthly_max,
    {{ weekly_min('period', 'value') }} as wti_weekly_min,
    {{ monthly_min('period', 'value') }} as wti_monthly_min,
    {{ weekly_average('period', 'value') }} as wti_weekly_avg,
    {{ monthly_average('period', 'value') }} as wti_monthly_avg
from
    {{ ref('stg_mh_wti') }} as wti
order by
    period asc