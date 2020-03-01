select
        c_count,
        count(*) as custdist
from
        (
                select
                        cast(c.data->>'c_custkey' as int),
                        count(cast(o.data->>'o_orderkey' as int))
                from
                        tpch c left outer join tpch o on
                                cast(c.data->>'c_custkey' as int) = cast(o.data->>'o_custkey' as int)
                                and o.data->>'o_comment' not like '%special%requests%'
                group by
                        cast(c.data->>'c_custkey' as int)
        ) as c_orders (c_custkey, c_count)
group by
        c_count
order by
        custdist desc,
        c_count desc;
