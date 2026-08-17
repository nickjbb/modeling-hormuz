select
    value,
    product_type,
    period,
    {{ weekly_max('stg_mh_wti', 'created_at', 'price') }} as wti_weekly_max,
    {{ monthly_max('stg_mh_wti', 'created_at', 'price') }} as wti_monthly_max,
    {{ weekly_min('stg_mh_wti', 'created_at', 'price') }} as wti_weekly_min,
    {{ monthly_min('stg_mh_wti', 'created_at', 'price') }} as wti_monthly_min,
    {{ weekly_average('stg_mh_wti', 'created_at', 'price') }} as wti_weekly_avg,
    {{ monthly_average('stg_mh_wti', 'created_at', 'price') }} as wti_monthly_avg
from
    {{ ref('stg_mh_wti') }} as wti
order by
    created_at asc