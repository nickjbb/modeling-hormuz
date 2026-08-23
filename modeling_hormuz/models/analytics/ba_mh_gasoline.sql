select
    gas_id,
    value,
    product_type,
    period,
    {{ 2_unit_max('period', 'value') }} as 2_week_max,
    {{ 7_unit_max('period', 'value') }} as 7_week_max,
    {{ 2_unit_min('period', 'value') }} as 2_week_min,
    {{ 7_unit_min('period', 'value') }} as 7_week_min,
    {{ 2_unit_average('period', 'value') }} as 2_week_avg,
    {{ 7_unit_average('period', 'value') }} as 7_week_avg
from
    {{ ref('stg_mh_gasoline') }} as gasoline
order by
    period asc