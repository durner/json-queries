select
        c.data->>'c_name',
        cast(c.data->>'c_custkey' as int),
        cast(o.data->>'o_orderkey' as int),
        cast(o.data->>'o_orderdate' as date),
        cast(o.data->>'o_totalprice' as decimal(12,2)),
        sum(cast(l.data->>'l_quantity' as int))
from
        tpch c,
        tpch o,
        tpch l
where
        cast(o.data->>'o_orderkey' as int) in (
                select
                        cast(l.data->>'l_orderkey' as int)
                from
                        tpch l
                group by
                        cast(l.data->>'l_orderkey' as int) having
                                sum(cast(l.data->>'l_quantity' as int)) > 300
        )
        and cast(c.data->>'c_custkey' as int) = cast(o.data->>'o_custkey' as int)
        and cast(o.data->>'o_orderkey' as int) = cast(l.data->>'l_orderkey' as int)
group by
        c.data->>'c_name',
        cast(c.data->>'c_custkey' as int),
        cast(o.data->>'o_orderkey' as int),
        cast(o.data->>'o_orderdate' as date),
        cast(o.data->>'o_totalprice' as decimal(12,2))
order by
        cast(o.data->>'o_totalprice' as decimal(12,2)) desc,
        cast(o.data->>'o_orderdate' as date)
limit
        100;
