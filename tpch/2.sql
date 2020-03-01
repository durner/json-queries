select
        cast(s.data->>'s_acctbal' as decimal(12,2)),
        s.data->>'s_name',
        n.data->>'n_name',
        cast(p.data->>'p_partkey' as int),
        p.data->>'p_mfgr',
        s.data->>'s_address',
        s.data->>'s_phone',
        s.data->>'s_comment'
from
        tpch p,
        tpch s,
        tpch ps,
        tpch n,
        tpch r
where
        cast(p.data->>'p_partkey' as int) = cast(ps.data->>'ps_partkey' as int)
        and cast(s.data->>'s_suppkey' as int) = cast(ps.data->>'ps_suppkey' as int)
        and cast(p.data->>'p_size' as int) = 15
        and p.data->>'p_type' like '%BRASS'
        and cast(s.data->>'s_nationkey' as int) = cast(n.data->>'n_nationkey' as int)
        and cast(n.data->>'n_regionkey' as int) = cast(r.data->>'r_regionkey' as int)
        and r.data->>'r_name'= 'EUROPE'
        and cast(ps.data->>'ps_supplycost' as decimal(12,2)) = (
                select
                        min(cast(ps.data->>'ps_supplycost' as decimal(12,2)))
                from
                        tpch s,
                        tpch ps,
                        tpch n,
                        tpch r
                where
                        cast(p.data->>'p_partkey' as int) = cast(ps.data->>'ps_partkey' as int)
                        and cast(s.data->>'s_suppkey' as int) = cast(ps.data->>'ps_suppkey' as int)
                        and cast(s.data->>'s_nationkey' as int)= cast(n.data->>'n_nationkey' as int)
                        and cast(n.data->>'n_regionkey' as int) = cast(r.data->>'r_regionkey' as int)
                        and r.data->>'r_name'= 'EUROPE'
        )
order by
        cast(s.data->>'s_acctbal' as decimal(12,2)) desc,
        n.data->>'n_name',
        s.data->>'s_name',
        cast(p.data->>'p_partkey' as int)
limit
        100;
