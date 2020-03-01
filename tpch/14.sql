select
        100.00 * sum(case
                when p.data->>'p_type' like 'PROMO%'
                        then cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2)))
                else 0
        end) / sum(cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2)))) as promo_revenue
from
        tpch l,
        tpch p
where
        cast(l.data->>'l_partkey' as int) = cast(p.data->>'p_partkey' as int)
        and cast(l.data->>'l_shipdate' as date) >= date '1995-09-01'
        and cast(l.data->>'l_shipdate' as date) < date '1995-09-01' + interval '1' month;
