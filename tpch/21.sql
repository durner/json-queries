select
        s.data->>'s_name',
        count(*) as numwait
from
        tpch s,
        tpch l1,
        tpch o,
        tpch n
where
        cast(s.data->>'s_suppkey' as int) = cast(l1.data->>'l_suppkey' as int)
        and cast(o.data->>'o_orderkey' as int) = cast(l1.data->>'l_orderkey' as int)
        and cast(o.data->>'o_orderstatus' as char(1)) = 'F'
        and cast(l1.data->>'l_receiptdate' as date) > cast(l1.data->>'l_commitdate' as date)
        and exists (
                select
                        *
                from
                        tpch l2
                where
                        cast(l2.data->>'l_orderkey' as int) = cast(l1.data->>'l_orderkey' as int)
                        and cast(l2.data->>'l_suppkey' as int) <> cast(l1.data->>'l_suppkey' as int)
        )
        and not exists (
                select
                        *
                from
                        tpch l3
                where
                        cast(l3.data->>'l_orderkey' as int) = cast(l1.data->>'l_orderkey' as int)
                        and cast(l3.data->>'l_suppkey' as int) <> cast(l1.data->>'l_suppkey' as int)
                        and cast(l3.data->>'l_receiptdate' as date) > cast(l3.data->>'l_commitdate' as date)
        )
        and cast(s.data->>'s_nationkey' as int) = cast(n.data->>'n_nationkey' as int)
        and n.data->>'n_name' = 'SAUDI ARABIA'
group by
        s.data->>'s_name'
order by
        numwait desc,
        s.data->>'s_name'
limit
        100;
