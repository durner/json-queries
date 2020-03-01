select
    count(*) as cnt, cast(r.data->>'stars' as float)  as stars
from
    yelp r
where
    cast(r.data->>'review_id' as int) is not null
group by
    cast(r.data->>'stars' as float)
order by
    stars
desc;
-- select the number of x star reviews
