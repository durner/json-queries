select
       sum(cast(l.data->>'l_extendedprice' as decimal(12,2)) * (cast(l.data->>'l_discount' as decimal(12,2)))) as revenue
from
        tpch l
where
        cast(l.data->>'l_shipdate' as date) >= date '1994-01-01'
        and cast(l.data->>'l_shipdate' as date) < date '1994-01-01' + interval '1' year
        and cast(l.data->>'l_discount' as decimal(12,2)) between 0.06 - 0.01 and 0.06 + 0.01
        and cast(l.data->>'l_quantity' as int) < 24;
