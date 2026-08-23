select
    wti_id,
    value,
    product_type,
    period,
    {{ 7_unit_max('period', 'value') }} as wti_weekly_max,
    {{ 30_unit_max('period', 'value') }} as wti_monthly_max,
    {{ 7_unit_min('period', 'value') }} as wti_weekly_min,
    {{ 30_unit_min('period', 'value') }} as wti_monthly_min,
    {{ 7_unit_average('period', 'value') }} as wti_weekly_avg,
    {{ 30_unit_average('period', 'value') }} as wti_monthly_avg
from
    {{ ref('stg_mh_wti') }} as wti
order by
    period asc