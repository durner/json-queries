select
    count(distinct cast(r.data->>'user_id' as bigint)) as cnt, cast(r.data->>'business_id' as bigint) as bid
from
    yelp r
where
    cast (r.data->>'date' as date) > date '2017-01-01'
    and cast (r.data->>'date' as date) < date '2018-01-01'
    and cast(r.data->>'review_id' as int) is not null
group by
    cast(r.data->>'business_id' as bigint)
order by
    cnt
desc
limit 10;
-- select the businesses with the most unique user reviews between 2017 and 2018
