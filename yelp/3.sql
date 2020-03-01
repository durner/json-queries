with citycount (city, cnt, userid) as (
    select
       distinct b.data->>'city' as city, count(*) as cnt, cast(r.data->>'user_id' as bigint) as userid
    from
        yelp b,
        yelp r
    where
        cast(r.data->>'business_id' as bigint) = cast(b.data->>'business_id' as bigint)
        and b.data->>'city' is not null
        and cast (r.data->>'review_id' as bigint) is not null
    group by
          b.data->>'city', cast(r.data->>'user_id' as bigint)
)

select
    c.city as city, c.userid as userid, u.data->>'name' as username, c.cnt as review_cnt
from
    citycount c,
    yelp u,
    (select c2.userid as userid, c2.city as city from citycount c2 where c2.cnt = (select max(c3.cnt) from citycount c3 where c2.city = c3.city)) cj
where
    u.data->>'name' is not null
    and cast(u.data->>'average_stars' as float) is not null
    and c.userid = cj.userid
    and c.city = cj.city
    and c.userid = cast(u.data->>'user_id' as bigint)
order by
    c.cnt
desc
limit 10;
-- select the powerusers of the ten cities with the most reviews by a single user
