select
        nation,
        o_year,
        sum(amount) as sum_profit
from
        (
                select
                        n.data->>'n_name' as nation,
                        extract(year from cast(o.data->>'o_orderdate' as date)) as o_year,
                        cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2))) - cast(ps.data->>'ps_supplycost' as decimal(12,2)) * cast(l.data->>'l_discount' as decimal(12,2)) as amount
                from
                        tpch p,
                        tpch s,
                        tpch l,
                        tpch ps,
                        tpch o,
                        tpch n
                where
                        cast(s.data->>'s_suppkey' as int) = cast(l.data->>'l_suppkey' as int)
                        and cast(ps.data->>'ps_suppkey' as int) = cast(l.data->>'l_suppkey' as int)
                        and cast(ps.data->>'ps_partkey' as int) = cast(l.data->>'l_partkey' as int)
                        and cast(p.data->>'p_partkey' as int) = cast(l.data->>'l_partkey' as int)
                        and cast(o.data->>'o_orderkey' as int) = cast(l.data->>'l_orderkey' as int)
                        and cast(s.data->>'s_nationkey' as int) = cast(n.data->>'n_nationkey' as int)
                        and p.data->>'p_name' like '%green%'
        ) as profit
group by
        nation,
        o_year
order by
        nation,
        o_year desc;
