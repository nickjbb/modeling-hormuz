select
    gas_id,
    value,
    product_type,
    period,
    {{ two_unit_max('period', 'value') }} as gas_two_week_max,
    {{ seven_unit_max('period', 'value') }} as gas_seven_week_max,
    {{ two_unit_min('period', 'value') }} as gas_two_week_min,
    {{ seven_unit_min('period', 'value') }} as gas_seven_week_min,
    {{ two_unit_average('period', 'value') }} as gas_two_week_avg,
    {{ seven_unit_average('period', 'value') }} as gas_seven_week_avg
from
    {{ ref('stg_mh_gasoline') }} as gasoline
order by
    period asc