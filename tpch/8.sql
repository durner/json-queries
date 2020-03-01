select
        o_year,
        sum(case
                when nation = 'BRAZIL' then volume
                else 0
        end) / sum(volume) as mkt_share
from
        (
                select
                        extract(year from cast(o.data->>'o_orderdate' as date)) as o_year,
                        cast(l.data->>'l_extendedprice' as decimal(12,2)) * (1 - cast(l.data->>'l_discount' as decimal(12,2))) as volume,
                        n2.data->>'n_name' as nation
                from
                        tpch p,
                        tpch s,
                        tpch l,
                        tpch o,
                        tpch c,
                        tpch n1,
                        tpch n2,
                        tpch r
                where
                        cast(p.data->>'p_partkey' as int) = cast(l.data->>'l_partkey' as int)
                        and cast(s.data->>'s_suppkey' as int) = cast(l.data->>'l_suppkey' as int)
                        and cast(l.data->>'l_orderkey' as int) = cast(o.data->>'o_orderkey' as int)
                        and cast(o.data->>'o_custkey' as int) = cast(c.data->>'c_custkey' as int)
                        and cast(r.data->>'r_regionkey' as int) = cast(n1.data->>'n_regionkey' as int)
                        and cast(c.data->>'c_nationkey' as int) = cast(n1.data->>'n_nationkey' as int)
                        and r.data->>'r_name' = 'AMERICA'
                        and cast(s.data->>'s_nationkey' as int) = cast(n2.data->>'n_nationkey' as int)
                        and cast(o.data->>'o_orderdate' as date) between date '1995-01-01' and date '1996-12-31'
                        and p.data->>'p_type' = 'ECONOMY ANODIZED STEEL'
        ) as all_nations
group by
        o_year
order by
        o_year;
