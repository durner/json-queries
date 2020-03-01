select
        cast(l.data->>'l_returnflag' as char(1)),
        cast(l.data->>'l_linestatus' as char(1)),
        sum(cast(l.data->>'l_quantity' as Integer)) as sum_qty,
        sum(cast(l.data->>'l_extendedprice' as decimal(12,2))) as sum_base_price,
        sum(cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2)))) as sum_disc_price,
        sum(cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2))) * (1 + cast(l.data->>'l_tax' as decimal(12,2)))) as sum_charge,
        avg(cast(l.data->>'l_quantity' as Integer)) as avg_qty,
        avg(cast(l.data->>'l_extendedprice' as decimal(12,2))) as avg_price,
        avg(cast(l.data->>'l_discount' as decimal(12,2))) as avg_disc,
        count(*) as count_order
from
        tpch l
where
        cast(l.data->>'l_shipdate' as date) <= date '1998-12-01' - interval '90' day
group by
        cast(l.data->>'l_returnflag' as char(1)),
        cast(l.data->>'l_linestatus' as char(1))
order by
        cast(l.data->>'l_returnflag' as char(1)),
        cast(l.data->>'l_linestatus' as char(1));
