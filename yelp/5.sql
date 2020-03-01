select
    b.data->>'city' as city, count(cast(r.data->>'review_id' as bigint))/count(distinct cast(r.data->>'business_id' as bigint)) as avg_reviews_per_business, count(cast(r.data->>'review_id' as bigint)) as reviews, count(distinct cast(r.data->>'business_id' as bigint)) as businesses
from
    yelp b,
    yelp r
where
    cast(r.data->>'business_id' as bigint) = cast(b.data->>'business_id' as bigint)
    and b.data->>'city' is not null
    and cast (r.data->>'review_id' as bigint) is not null
group by
    b.data->>'city'
order by
    avg_reviews_per_business
desc
limit 100;
-- select the 100 cities with the most reviews per businesses
