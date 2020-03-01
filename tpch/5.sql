select
        n.data->>'n_name',
        sum(cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2)))) as revenue
from
        tpch c,
        tpch o,
        tpch l,
        tpch s,
        tpch n,
        tpch r
where
        cast(c.data->>'c_custkey' as int) = cast(o.data->>'o_custkey' as int)
        and cast(l.data->>'l_orderkey' as int) = cast(o.data->>'o_orderkey' as int)
        and cast(l.data->>'l_suppkey' as int) = cast(s.data->>'s_suppkey' as int)
        and cast(c.data->>'c_nationkey' as int) = cast(s.data->>'s_nationkey' as int)
        and cast(s.data->>'s_nationkey' as int) = cast(n.data->>'n_nationkey' as int)
        and cast(n.data->>'n_regionkey' as int) = cast(r.data->>'r_regionkey' as int)
        and r.data->>'r_name' = 'ASIA'
        and cast(o.data->>'o_orderdate' as date) >= date '1994-01-01'
        and cast(o.data->>'o_orderdate' as date) < date '1994-01-01' + interval '1' year
group by
        n.data->>'n_name'
order by
        revenue desc;
