select
        cast(l.data->>'l_orderkey' as int),
        sum(cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2)))) as revenue,
        cast(o.data->>'o_orderdate' as date),
        cast(o.data->>'o_shippriority' as int)
from
        tpch c,
        tpch o,
        tpch l
where
        c.data->>'c_mktsegment' = 'BUILDING'
        and cast(c.data->>'c_custkey' as int) = cast(o.data->>'o_custkey' as int)
        and cast(l.data->>'l_orderkey' as int) = cast(o.data->>'o_orderkey' as int)
        and cast(o.data->>'o_orderdate' as date) < date '1995-03-15'
        and cast(l.data->>'l_shipdate' as date) > date '1995-03-15'
group by
        cast(l.data->>'l_orderkey' as int),
        cast(o.data->>'o_orderdate' as date),
        cast(o.data->>'o_shippriority' as int)
order by
        revenue desc,
        cast(o.data->>'o_orderdate' as date)
limit
        10;
