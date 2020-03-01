select
        sum(cast(l.data->>'l_extendedprice' as decimal(12,2))) / 7.0 as avg_yearly
from
        tpch l,
        tpch p
where
        cast(p.data->>'p_partkey' as int) = cast(l.data->>'l_partkey' as int)
        and p.data->>'p_brand' = 'Brand#23'
        and p.data->>'p_container' = 'MED BOX'
        and cast(l.data->>'l_quantity' as int) < (
                select
                        0.2 * avg(cast(l.data->>'l_quantity' as int))
                from
                        tpch l
                where
                        cast(p.data->>'p_partkey' as int) = cast(l.data->>'l_partkey' as int)
        );
