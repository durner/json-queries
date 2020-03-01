select
        cast(ps.data->>'ps_partkey' as int),
        sum(cast(ps.data->>'ps_supplycost' as decimal(12,2)) * cast(ps.data->>'ps_availqty' as int)) as value
from
        tpch ps,
        tpch s,
        tpch n
where
        cast(ps.data->>'ps_suppkey' as int) = cast(s.data->>'s_suppkey' as int)
        and cast(s.data->>'s_nationkey' as int) = cast(n.data->>'n_nationkey' as int)
        and n.data->>'n_name' = 'GERMANY'
group by
        cast(ps.data->>'ps_partkey' as int) having
                sum(cast(ps.data->>'ps_supplycost' as decimal(12,2)) * cast(ps.data->>'ps_availqty' as int)) > (
                        select
                                sum(cast(ps.data->>'ps_supplycost' as decimal(12,2)) * cast(ps.data->>'ps_availqty' as int)) * 0.0001
                        from
                                tpch ps,
                                tpch s,
                                tpch n
                        where
                                cast(ps.data->>'ps_suppkey' as int) = cast(s.data->>'s_suppkey' as int)
                                and cast(s.data->>'s_nationkey' as int) = cast(n.data->>'n_nationkey' as int)
                                and n.data->>'n_name' = 'GERMANY'
                )
order by
        value desc;
