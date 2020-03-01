select
        cast(c.data->>'c_custkey' as int),
        c.data->>'c_name',
        sum(cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2)))) as revenue,
        cast(c.data->>'c_acctbal' as decimal(12,2)),
        n.data->>'n_name',
        c.data->>'c_address',
        c.data->>'c_phone',
        c.data->>'c_comment'
from
        tpch c,
        tpch o,
        tpch l,
        tpch n
where
        cast(c.data->>'c_custkey' as int) = cast(o.data->>'o_custkey' as int)
        and cast(l.data->>'l_orderkey' as int) = cast(o.data->>'o_orderkey' as int)
        and cast(o.data->>'o_orderdate' as date) >= date '1993-10-01'
        and cast(o.data->>'o_orderdate' as date) < date '1993-10-01' + interval '3' month
        and cast(l.data->>'l_returnflag' as char(1)) = 'R'
        and cast(c.data->>'c_nationkey' as int) = cast(n.data->>'n_nationkey' as int)
group by
        cast(c.data->>'c_custkey' as int),
        c.data->>'c_name',
        cast(c.data->>'c_acctbal' as decimal(12,2)),
        c.data->>'c_phone',
        n.data->>'n_name',
        c.data->>'c_address',
        c.data->>'c_comment'
order by
        revenue desc
limit
        20;
