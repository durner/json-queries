select
    count(cast(u.data->>'user_id' as bigint)) as cnt, cast(u.data->>'user_id' as bigint) as uid, u.data->>'name', cast(u.data->>'average_stars' as float) as avg_stars
from
    yelp u, yelp r
where
    cast(r.data->>'user_id' as bigint) = cast(u.data->>'user_id' as bigint)
    and u.data->>'name' is not null
    and cast(u.data->>'average_stars' as float) is not null
    and cast (r.data->>'review_id' as bigint) is not null
group by
    cast(u.data->>'user_id' as bigint), u.data->>'name', cast(u.data->>'average_stars' as float)
order by
    cnt
desc
limit 10;
-- select the 10 users with the most reviews since 2017
