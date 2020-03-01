select
        l.data->>'l_shipmode',
        sum(case
                when o.data->>'o_orderpriority' = '1-URGENT'
                        or o.data->>'o_orderpriority' = '2-HIGH'
                        then 1
                else 0
        end) as high_line_count,
        sum(case
                when o.data->>'o_orderpriority' <> '1-URGENT'
                        and o.data->>'o_orderpriority' <> '2-HIGH'
                        then 1
                else 0
        end) as low_line_count
from
        tpch o,
        tpch l
where
        cast(o.data->>'o_orderkey' as int) = cast(l.data->>'l_orderkey' as int)
        and l.data->>'l_shipmode' in ('MAIL', 'SHIP')
        and cast(l.data->>'l_commitdate' as date) < cast(l.data->>'l_receiptdate' as date)
        and cast(l.data->>'l_shipdate' as date) < cast(l.data->>'l_commitdate' as date)
        and cast(l.data->>'l_receiptdate' as date) >= date '1994-01-01'
        and cast(l.data->>'l_receiptdate' as date) < date '1994-01-01' + interval '1' year
group by
        l.data->>'l_shipmode'
order by
        l.data->>'l_shipmode';
