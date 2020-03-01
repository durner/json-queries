with revenue (supplier_no, total_revenue) as (
        select
                cast(l.data->>'l_suppkey' as int),
                sum(cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2))))
        from
               tpch l
        where
                cast(l.data->>'l_shipdate' as date) >= date '1996-01-01'
                and cast(l.data->>'l_shipdate' as date) < date '1996-01-01' + interval '3' month
        group by
                cast(l.data->>'l_suppkey' as int))
select
        cast(s.data->>'s_suppkey' as int),
        s.data->>'s_name',
        s.data->>'s_address',
        s.data->>'s_phone',
        total_revenue
from
        tpch s,
        revenue
where
        cast(s.data->>'s_suppkey' as int) = supplier_no
        and total_revenue = (
                select
                        max(total_revenue)
                from
                        revenue
        )
order by
        cast(s.data->>'s_suppkey' as int);
