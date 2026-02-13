-- Create clean view with calculated delivery days
create view `my-first-project-480606.olist_dataset.clean_orders` as 
select *, 
 case
  when order_status = 'delivered'
  and order_delivered_customer_date is not null
  then DATE_DIFF
    (date(order_delivered_customer_date),
    date(order_purchase_timestamp ),
    DAY)
  else null
 end as delivery_days
from `my-first-project-480606.olist_dataset.orders`;

-- Validate delivery metrics

SELECT
  COUNT(*) AS delivered_orders,
  AVG(delivery_days) AS average_days,
  MIN(delivery_days) AS minimum_days,
  MAX(delivery_days) AS maximum_days
FROM `my-first-project-480606.olist_dataset.clean_orders`
WHERE delivery_days IS NOT NULL;
