select
        supp_nation,
        cust_nation,
        l_year,
        sum(volume) as revenue
from
        (
                select
                        n1.data->>'n_name' as supp_nation,
                        n2.data->>'n_name' as cust_nation,
                        extract(year from cast(l.data->>'l_shipdate' as date)) as l_year,
                        cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2))) as volume
                from
                        tpch s,
                        tpch l,
                        tpch o,
                        tpch c,
                        tpch n1,
                        tpch n2
                where
                        cast(s.data->>'s_suppkey' as int) = cast(l.data->>'l_suppkey' as int)
                        and cast(o.data->>'o_orderkey' as int) = cast(l.data->>'l_orderkey' as int)
                        and cast(c.data->>'c_custkey' as int) = cast(o.data->>'o_custkey' as int)
                        and cast(s.data->>'s_nationkey' as int) = cast(n1.data->>'n_nationkey' as int)
                        and cast(c.data->>'c_nationkey' as int) = cast(n2.data->>'n_nationkey' as int)
                        and (
                                (n1.data->>'n_name' = 'FRANCE' and n2.data->>'n_name' = 'GERMANY')
                                or (n1.data->>'n_name' = 'GERMANY' and n2.data->>'n_name' = 'FRANCE')
                        )
                        and cast(l.data->>'l_shipdate' as date) between date '1995-01-01' and date '1996-12-31'
        ) as shipping
group by
        supp_nation,
        cust_nation,
        l_year
order by
        supp_nation,
        cust_nation,
        l_year;
