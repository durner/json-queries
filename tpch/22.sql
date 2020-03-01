select
        cntrycode,
        count(*) as numcust,
        sum(c_acctbal) as totacctbal
from
        (
                select
                        substring(c.data->>'c_phone' from 1 for 2) as cntrycode,
                        cast(c.data->>'c_acctbal' as decimal(12,2)) as c_acctbal
                from
                        tpch c
                where
                        substring(c.data->>'c_phone' from 1 for 2) in
                                ('13', '31', '23', '29', '30', '18', '17')
                        and cast(c.data->>'c_acctbal' as decimal(12,2)) > (
                                select
                                        avg(cast(c.data->>'c_acctbal' as decimal(12,2)))
                                from
                                        tpch c
                                where
                                        cast(c.data->>'c_acctbal' as decimal(12,2)) > 0.00
                                        and substring(c.data->>'c_phone' from 1 for 2) in
                                                ('13', '31', '23', '29', '30', '18', '17')
                        )
                        and not exists (
                                select
                                        *
                                from
                                        tpch o
                                where
                                        cast(o.data->>'o_custkey' as int) = cast(c.data->>'c_custkey' as int)
                        )
        ) as custsale
group by
        cntrycode
order by
        cntrycode;
