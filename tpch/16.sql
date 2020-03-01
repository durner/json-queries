select
        p.data->>'p_brand',
        p.data->>'p_type',
        cast(p.data->>'p_size' as int),
        count(distinct cast(ps.data->>'ps_suppkey' as int)) as supplier_cnt
from
        tpch ps,
        tpch p
where
        cast(p.data->>'p_partkey' as int) = cast(ps.data->>'ps_partkey' as int)
        and p.data->>'p_brand' <> 'Brand#45'
        and p.data->>'p_type' not like 'MEDIUM POLISHED%'
        and cast(p.data->>'p_size' as int) in (49, 14, 23, 45, 19, 3, 36, 9)
        and cast(ps.data->>'ps_suppkey' as int) not in (
                select
                        cast(s.data->>'s_suppkey' as int)
                from
                        tpch s
                where
                        s.data->>'s_comment' like '%Customer%Complaints%'
        )
group by
        p.data->>'p_brand',
        p.data->>'p_type',
        cast(p.data->>'p_size' as int)
order by
        supplier_cnt desc,
        p.data->>'p_brand',
        p.data->>'p_type',
        cast(p.data->>'p_size' as int)
