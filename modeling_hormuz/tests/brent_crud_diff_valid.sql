select
    *
from
    {{ref('brent_crude_diff')}}
where
    brent_wti_diff is null
or
    date(period) > current_date
or
    date(period) < date('2000-01-01')