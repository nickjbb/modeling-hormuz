select
	bc.period as period,
	bc.value - wc.value as brent_wti_diff
from
	{{ ref('stg_mh_brent') }} bc
join
	{{ ref('stg_mh_wti') }} wc
on
	bc.period = wc.period
order by
	bc."period";