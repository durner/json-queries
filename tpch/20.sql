select
        s.data->>'s_name',
        s.data->>'s_address'
from
        tpch s,
        tpch n
where
        cast(s.data->>'s_suppkey' as int) in (
                select
                        cast(ps.data->>'ps_suppkey' as int)
                from
                        tpch ps
                where
                        cast(ps.data->>'ps_partkey' as int) in (
                                select
                                        cast(p.data->>'p_partkey' as int)
                                from
                                        tpch p
                                where
                                        p.data->>'p_name' like 'forest%'
                        )
                        and cast(ps.data->>'ps_availqty' as int) > (
                                select
                                        0.5 * sum(cast(l.data->>'l_quantity' as int))
                                from
                                        tpch l
                                where
                                        cast(l.data->>'l_partkey' as int) = cast(ps.data->>'ps_partkey' as int)
                                        and cast(l.data->>'l_suppkey' as int) = cast(ps.data->>'ps_suppkey' as int)
                                        and cast(l.data->>'l_shipdate' as date) >= date '1994-01-01'
                                        and cast(l.data->>'l_shipdate' as date) < date '1994-01-01' + interval '1' year
                        )
        )
        and cast(s.data->>'s_nationkey' as int) = cast(n.data->>'n_nationkey' as int)
        and n.data->>'n_name' = 'CANADA'
order by
        s.data->>'s_name';
