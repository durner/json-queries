select
        o.data->>'o_orderpriority',
        count(*) as order_count
from
        tpch o
where
        cast(o.data->>'o_orderdate' as date) >= date '1993-07-01'
        and cast(o.data->>'o_orderdate' as date) < date '1993-07-01' + interval '3' month
        and exists (
                select
                        *
                from
                        tpch l
                where
                        cast(l.data->>'l_orderkey' as int) = cast(o.data->>'o_orderkey' as int)
                        and cast(l.data->>'l_commitdate' as date) < cast(l.data->>'l_receiptdate' as date)
        )
group by
        o.data->>'o_orderpriority'
order by
        o.data->>'o_orderpriority';
