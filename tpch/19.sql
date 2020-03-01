select
        sum(cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2)))) as revenue
from
        tpch l,
        tpch p
where
        (
                cast(p.data->>'p_partkey' as int) = cast(l.data->>'l_partkey' as int)
                and p.data->>'p_brand' = 'Brand#12'
                and p.data->>'p_container' in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
                and cast(l.data->>'l_quantity' as int) >= 1 and cast(l.data->>'l_quantity' as int) <= 1 + 10
                and cast(p.data->>'p_size' as int) between 1 and 5
                and l.data->>'l_shipmode' in ('AIR', 'AIR REG')
                and l.data->>'l_shipinstruct' = 'DELIVER IN PERSON'
        )
        or
        (
                cast(p.data->>'p_partkey' as int) = cast(l.data->>'l_partkey' as int)
                and p.data->>'p_brand' = 'Brand#23'
                and p.data->>'p_container' in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
                and cast(l.data->>'l_quantity' as int) >= 10 and cast(l.data->>'l_quantity' as int) <= 10 + 10
                and cast(p.data->>'p_size' as int) between 1 and 10
                and l.data->>'l_shipmode' in ('AIR', 'AIR REG')
                and l.data->>'l_shipinstruct' = 'DELIVER IN PERSON'
        )
        or
        (
                cast(p.data->>'p_partkey' as int) = cast(l.data->>'l_partkey' as int)
                and p.data->>'p_brand' = 'Brand#34'
                and p.data->>'p_container' in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
                and cast(l.data->>'l_quantity' as int) >= 20 and cast(l.data->>'l_quantity' as int) <= 20 + 10
                and cast(p.data->>'p_size' as int) between 1 and 15
                and l.data->>'l_shipmode' in ('AIR', 'AIR REG')
                and l.data->>'l_shipinstruct' = 'DELIVER IN PERSON'
        );
