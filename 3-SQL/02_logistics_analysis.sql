/* ================================================================
   LOGISTICS & SUPPLY CHAIN ANALYTICS
   SQL BUSINESS ANALYSIS
   Database: PostgreSQL
   Table: logistic

   Objective:
   Analyze delivery performance, shipping efficiency, regional risk,
   customer segments, product categories, profitability and trends.

   Tools:
   PostgreSQL | SQL | Power BI | Python
================================================================ */


/* ================================================================
   01. DATASET OVERVIEW
   ================================================================
   WHAT THIS FINDS:
   - Total number of records in the dataset.
   - Number of unique orders.
   - Number of unique customers.
   - Number of unique order items.

================================================================ */

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT "Order Id") AS unique_orders,
    COUNT(DISTINCT "Order Item Id") AS unique_order_items,
    COUNT(DISTINCT "Customer Id") AS unique_customers
FROM logistic;


/* ================================================================
   02. DATA COMPLETENESS CHECK
   ================================================================
   WHAT THIS FINDS:
   Checks whether important business columns contain missing values.

================================================================ */

SELECT
    COUNT(*) AS total_rows,

    COUNT("Order Id") AS order_id_present,

    COUNT("Shipping Mode") AS shipping_mode_present,

    COUNT("Late_delivery_risk") AS late_risk_present,

    COUNT("Sales") AS sales_present,

    COUNT("Order Profit Per Order") AS profit_present

FROM logistic;


/* ================================================================
   03. DELIVERY STATUS DISTRIBUTION
   ================================================================
   WHAT THIS FINDS:
   Shows how orders are distributed across delivery statuses.

================================================================ */

SELECT
    "Delivery Status",
    COUNT(*) AS records,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM logistic

GROUP BY "Delivery Status"

ORDER BY percentage DESC;


/* ================================================================
   04. SHIPPING MODE PERFORMANCE
   ================================================================
   WHAT THIS FINDS:
   Compares shipping modes using:
   - Order volume
   - Late delivery rate
   - Actual shipping days
   - Scheduled shipping days

================================================================ */

SELECT
    "Shipping Mode",

    COUNT(DISTINCT "Order Id") AS orders,

    ROUND(
        AVG("Late_delivery_risk") * 100,
        2
    ) AS late_rate,

    ROUND(
        AVG("Days for shipping (real)"),
        2
    ) AS avg_actual_days,

    ROUND(
        AVG("Days for shipment (scheduled)"),
        2
    ) AS avg_scheduled_days

FROM logistic

GROUP BY "Shipping Mode"

ORDER BY late_rate DESC;


/* ================================================================
   05. SHIPPING PERFORMANCE GAP
   ================================================================
   WHAT THIS FINDS:
   Measures the difference between actual shipping time
   and scheduled shipping time.

   Positive gap  = slower than scheduled
   Zero gap      = met schedule
   Negative gap  = faster than scheduled

================================================================ */

SELECT
    "Shipping Mode",

    ROUND(
        AVG(
            "Days for shipping (real)"
            - "Days for shipment (scheduled)"
        ),
        2
    ) AS avg_shipping_gap

FROM logistic

GROUP BY "Shipping Mode"

ORDER BY avg_shipping_gap DESC;


/* ================================================================
   06. SHIPPING PERFORMANCE CLASSIFICATION
   ================================================================
   WHAT THIS FINDS:
   Classifies every record into:
   - Late vs Scheduled
   - Scheduled
   - Ahead of Scheduled

================================================================ */

SELECT

    CASE
        WHEN "Days for shipping (real)"
             > "Days for shipment (scheduled)"
            THEN 'Late vs Scheduled'

        WHEN "Days for shipping (real)"
             = "Days for shipment (scheduled)"
            THEN 'Scheduled'

        WHEN "Days for shipping (real)"
             < "Days for shipment (scheduled)"
            THEN 'Ahead of Scheduled'
    END AS shipping_performance,

    COUNT(*) AS records

FROM logistic

GROUP BY shipping_performance

ORDER BY records DESC;


/* ================================================================
   07. ACTUAL LATE DELIVERY RATE
   ================================================================
   WHAT THIS FINDS:
   Calculates the actual percentage of unique orders
   marked as late delivery.

================================================================ */

SELECT

    COUNT(DISTINCT "Order Id") AS total_orders,

    COUNT(DISTINCT "Order Id")
        FILTER (
            WHERE "Delivery Status" = 'Late delivery'
        ) AS late_orders,

    ROUND(
        COUNT(DISTINCT "Order Id")
        FILTER (
            WHERE "Delivery Status" = 'Late delivery'
        ) * 100.0
        / COUNT(DISTINCT "Order Id"),
        2
    ) AS actual_late_rate

FROM logistic;


/* ================================================================
   08. LATE DELIVERY RISK VALIDATION
   ================================================================
   WHAT THIS FINDS:
   Compares the Late_delivery_risk flag with actual
   Delivery Status.

================================================================ */

SELECT
    "Late_delivery_risk",
    "Delivery Status",
    COUNT(*) AS records

FROM logistic

GROUP BY
    "Late_delivery_risk",
    "Delivery Status"

ORDER BY
    "Late_delivery_risk",
    records DESC;


/* ================================================================
   09. REGIONAL DELIVERY PERFORMANCE
   ================================================================
   WHAT THIS FINDS:
   Compares regions by:
   - Order volume
   - Late delivery rate
   - Sales
   - Profit

================================================================ */

SELECT

    "Order Region",

    COUNT(DISTINCT "Order Id") AS orders,

    ROUND(
        AVG("Late_delivery_risk") * 100,
        2
    ) AS late_rate,

    ROUND(
        SUM("Sales")::numeric,
        2
    ) AS sales,

    ROUND(
        SUM("Order Profit Per Order")::numeric,
        2
    ) AS profit

FROM logistic

GROUP BY "Order Region"

ORDER BY late_rate DESC;


/* ================================================================
   10. CATEGORY DELIVERY PERFORMANCE
   ================================================================
   WHAT THIS FINDS:
   Identifies product categories with higher delivery risk.

================================================================ */

SELECT

    "Category Name",

    COUNT(DISTINCT "Order Id") AS orders,

    ROUND(
        AVG("Late_delivery_risk") * 100,
        2
    ) AS late_rate,

    ROUND(
        AVG(
            "Days for shipping (real)"
            - "Days for shipment (scheduled)"
        ),
        2
    ) AS avg_shipping_gap

FROM logistic

GROUP BY "Category Name"

ORDER BY late_rate DESC;


/* ================================================================
   11. CUSTOMER SEGMENT PERFORMANCE
   ================================================================
   WHAT THIS FINDS:
   Compares delivery performance across customer segments.

================================================================ */

SELECT

    "Customer Segment",

    COUNT(DISTINCT "Order Id") AS orders,

    ROUND(
        AVG("Late_delivery_risk") * 100,
        2
    ) AS late_rate,

    ROUND(
        AVG(
            "Days for shipping (real)"
            - "Days for shipment (scheduled)"
        ),
        2
    ) AS avg_shipping_gap

FROM logistic

GROUP BY "Customer Segment"

ORDER BY late_rate DESC;


/* ================================================================
   12. SHIPPING MODE × MARKET ANALYSIS
   ================================================================
   WHAT THIS FINDS:
   Finds combinations of shipping mode and market
   where delivery performance is weak.

================================================================ */

SELECT

    "Shipping Mode",
    "Market",

    COUNT(DISTINCT "Order Id") AS orders,

    ROUND(
        AVG("Late_delivery_risk") * 100,
        2
    ) AS late_rate,

    ROUND(
        AVG(
            "Days for shipping (real)"
            - "Days for shipment (scheduled)"
        ),
        2
    ) AS avg_shipping_gap

FROM logistic

GROUP BY
    "Shipping Mode",
    "Market"

ORDER BY late_rate DESC;


/* ================================================================
   13. HIGH-VOLUME SHIPPING × MARKET SEGMENTS
   ================================================================
   WHAT THIS FINDS:
   Filters out low-volume combinations and focuses on
   segments with at least 500 orders.

================================================================ */

SELECT

    "Shipping Mode",
    "Market",

    COUNT(DISTINCT "Order Id") AS orders,

    ROUND(
        AVG("Late_delivery_risk") * 100,
        2
    ) AS late_rate,

    ROUND(
        AVG(
            "Days for shipping (real)"
            - "Days for shipment (scheduled)"
        ),
        2
    ) AS avg_shipping_gap

FROM logistic

GROUP BY
    "Shipping Mode",
    "Market"

HAVING COUNT(DISTINCT "Order Id") >= 500

ORDER BY late_rate DESC;


/* ================================================================
   14. DELIVERY STATUS vs FINANCIAL PERFORMANCE
   ================================================================
   WHAT THIS FINDS:
   Compares sales and profitability across delivery statuses.

================================================================ */

SELECT

    "Delivery Status",

    COUNT(DISTINCT "Order Id") AS orders,

    ROUND(
        SUM("Sales")::numeric,
        2
    ) AS total_sales,

    ROUND(
        SUM("Order Profit Per Order")::numeric,
        2
    ) AS total_profit,

    ROUND(
        AVG("Order Profit Per Order")::numeric,
        2
    ) AS avg_profit_per_order

FROM logistic

GROUP BY "Delivery Status"

ORDER BY total_sales DESC;


/* ================================================================
   15. SHIPPING MODE × REGION PROFITABILITY
   ================================================================
   WHAT THIS FINDS:
   Combines operational performance with financial impact.

================================================================ */

SELECT

    "Shipping Mode",
    "Order Region",

    COUNT(DISTINCT "Order Id") AS total_orders,

    COUNT(DISTINCT "Order Id")
        FILTER (
            WHERE "Delivery Status" = 'Late delivery'
        ) AS late_orders,

    ROUND(
        SUM("Sales")::numeric,
        2
    ) AS total_sales,

    ROUND(
        SUM("Order Profit Per Order")::numeric,
        2
    ) AS total_profit,

    ROUND(
        AVG("Order Profit Per Order")::numeric,
        2
    ) AS avg_profit_per_order

FROM logistic

GROUP BY
    "Shipping Mode",
    "Order Region"

ORDER BY late_orders DESC;


/* ================================================================
   16. HIGH-PRIORITY OPERATIONAL SEGMENTS
   ================================================================
   WHAT THIS FINDS:
   Creates a business-priority classification.

   High Priority:
       Late rate >= 80%
       AND orders >= 500

   Medium Priority:
       Late rate >= 60%
       AND orders >= 500
================================================================ */

WITH segment AS (

    SELECT

        "Shipping Mode",
        "Order Region",

        COUNT(DISTINCT "Order Id") AS orders,

        ROUND(
            AVG("Late_delivery_risk") * 100,
            2
        ) AS late_rate,

        ROUND(
            AVG(
                "Days for shipping (real)"
                - "Days for shipment (scheduled)"
            ),
            2
        ) AS avg_gap,

        ROUND(
            SUM("Sales")::numeric,
            2
        ) AS total_sales,

        ROUND(
            SUM("Order Profit Per Order")::numeric,
            2
        ) AS profit

    FROM logistic

    GROUP BY
        "Shipping Mode",
        "Order Region"
)

SELECT

    *,

    CASE

        WHEN late_rate >= 80
             AND orders >= 500
            THEN 'High Priority'

        WHEN late_rate >= 60
             AND orders >= 500
            THEN 'Medium Priority'

        ELSE 'Normal'

    END AS priority

FROM segment

ORDER BY
    late_rate DESC;


/* ================================================================
   17. MONTHLY DELIVERY TREND
   ================================================================
   WHAT THIS FINDS:
   Tracks monthly:
   - Orders
   - Late delivery rate
   - Shipping delay
   - Sales

================================================================ */

SELECT

    DATE_TRUNC(
        'month',
        "order date (DateOrders)"
    ) AS month,

    COUNT(DISTINCT "Order Id") AS orders,

    ROUND(
        AVG("Late_delivery_risk") * 100,
        2
    ) AS late_rate,

    ROUND(
        AVG(
            "Days for shipping (real)"
            - "Days for shipment (scheduled)"
        ),
        2
    ) AS avg_shipping_gap,

    ROUND(
        SUM("Sales")::numeric,
        2
    ) AS monthly_sales

FROM logistic

GROUP BY
    DATE_TRUNC(
        'month',
        "order date (DateOrders)"
    )

ORDER BY month;


/* ================================================================
   18. MONTHLY SHIPPING MODE TREND
   ================================================================
   WHAT THIS FINDS:
   Tracks delivery performance of each shipping mode
   over time.

================================================================ */

SELECT

    DATE_TRUNC(
        'month',
        "order date (DateOrders)"
    ) AS month,

    "Shipping Mode",

    COUNT(DISTINCT "Order Id") AS orders,

    ROUND(
        AVG("Late_delivery_risk") * 100,
        2
    ) AS late_rate,

    ROUND(
        AVG(
            "Days for shipping (real)"
            - "Days for shipment (scheduled)"
        ),
        2
    ) AS avg_shipping_gap,

    ROUND(
        SUM("Sales")::numeric,
        2
    ) AS monthly_sales

FROM logistic

GROUP BY
    DATE_TRUNC(
        'month',
        "order date (DateOrders)"
    ),
    "Shipping Mode"

ORDER BY
    month,
    "Shipping Mode";


/* ================================================================
   19. TOP 5 HIGH-RISK REGIONS
   ================================================================
   WHAT THIS FINDS:
   Ranks regions based on late delivery rate.

================================================================ */

WITH region_performance AS (

    SELECT

        "Order Region",

        COUNT(DISTINCT "Order Id") AS orders,

        ROUND(
            AVG("Late_delivery_risk") * 100,
            2
        ) AS late_rate,

        RANK() OVER (
            ORDER BY AVG("Late_delivery_risk") DESC
        ) AS late_rank

    FROM logistic

    GROUP BY "Order Region"
)

SELECT *

FROM region_performance

WHERE late_rank <= 5

ORDER BY late_rank;


/* ================================================================
   20. TOP 10 HIGH-RISK SHIPPING × REGION SEGMENTS
   ================================================================
   WHAT THIS FINDS:
   Identifies the worst-performing combinations of
   shipping mode and region.

================================================================ */

WITH segment_performance AS (

    SELECT

        "Shipping Mode",
        "Order Region",

        COUNT(DISTINCT "Order Id") AS orders,

        ROUND(
            AVG("Late_delivery_risk") * 100,
            2
        ) AS late_rate,

        ROUND(
            AVG(
                "Days for shipping (real)"
                - "Days for shipment (scheduled)"
            ),
            2
        ) AS avg_gap

    FROM logistic

    GROUP BY
        "Shipping Mode",
        "Order Region"
),

ranked_segments AS (

    SELECT

        *,

        RANK() OVER (
            ORDER BY late_rate DESC
        ) AS risk_rank

    FROM segment_performance
)

SELECT *

FROM ranked_segments

WHERE risk_rank <= 10

ORDER BY risk_rank;


/* ================================================================
   21. ESTIMATED NUMBER OF LATE ORDERS
   ================================================================
   WHAT THIS FINDS:
   Converts late percentage into estimated number of
   affected orders.

   BUSINESS QUESTION:
   Which segment creates the largest absolute number
   of late orders?

================================================================ */

WITH segments AS (

    SELECT

        "Shipping Mode",
        "Order Region",

        COUNT(DISTINCT "Order Id") AS orders,

        ROUND(
            AVG("Late_delivery_risk") * 100,
            2
        ) AS late_rate

    FROM logistic

    GROUP BY
        "Shipping Mode",
        "Order Region"
)

SELECT

    *,

    ROUND(
        orders * late_rate / 100.0,
        0
    ) AS estimated_late_orders

FROM segments

ORDER BY estimated_late_orders DESC;


/* ================================================================
   22. ORDER DUPLICATION CHECK
   ================================================================
   WHAT THIS FINDS:
   Identifies Order IDs appearing in multiple rows.

================================================================ */

SELECT

    "Order Id",

    COUNT(*) AS rows_per_order,

    COUNT(DISTINCT "Order Item Id") AS unique_order_items

FROM logistic

GROUP BY "Order Id"

HAVING COUNT(*) > 1

ORDER BY rows_per_order DESC

LIMIT 20;


/* ================================================================
   23. ORDER ID DUPLICATION SUMMARY
   ================================================================
   WHAT THIS FINDS:
   Calculates how many repeated Order ID occurrences exist.
   
================================================================ */

SELECT

    COUNT("Order Id")
    - COUNT(DISTINCT "Order Id")
    AS repeated_order_id_occurrences

FROM logistic;


/* ================================================================
   24. PROFIT CONSISTENCY CHECK
   ================================================================
   WHAT THIS FINDS:
   Checks whether repeated rows for an order contain
   different profit values.

================================================================ */

SELECT

    "Order Id",

    COUNT(*) AS rows_per_order,

    COUNT(
        DISTINCT "Order Profit Per Order"
    ) AS distinct_profit_values

FROM logistic

GROUP BY "Order Id"

HAVING COUNT(*) > 1

ORDER BY rows_per_order DESC

LIMIT 20;


/* ================================================================
   25. DATABASE SCHEMA CHECK
   ================================================================
   WHAT THIS FINDS:
   Shows all columns and their PostgreSQL data types.

================================================================ */

SELECT

    ordinal_position,

    column_name,

    data_type

FROM information_schema.columns

WHERE table_name = 'logistic'

ORDER BY ordinal_position;


/* ================================================================
   26. DATE COLUMN VALIDATION
   ================================================================
   WHAT THIS FINDS:
   Checks the data type of the order date column.

================================================================ */

SELECT

    column_name,

    data_type

FROM information_schema.columns

WHERE table_name = 'logistic'

AND column_name = 'order date (DateOrders)';


/* ================================================================
   27. HIGH-VOLUME SHIPPING MODE RISK
   ================================================================
   WHAT THIS FINDS:
   Removes low-volume shipping modes and focuses on
   modes with at least 500 orders.

================================================================ */

WITH mode_performance AS (

    SELECT

        "Shipping Mode",

        COUNT(DISTINCT "Order Id") AS orders,

        ROUND(
            AVG("Late_delivery_risk") * 100,
            2
        ) AS late_rate

    FROM logistic

    GROUP BY "Shipping Mode"
)

SELECT *

FROM mode_performance

WHERE orders >= 500

ORDER BY late_rate DESC;


/* ================================================================
   28. BUSINESS IMPACT PRIORITIZATION
   ================================================================
   WHAT THIS FINDS:
   Combines:
   - Order volume
   - Late rate
   - Estimated late orders
   - Sales
   - Profit

================================================================ */

WITH segment_analysis AS (

    SELECT

        "Shipping Mode",
        "Order Region",

        COUNT(DISTINCT "Order Id") AS orders,

        ROUND(
            AVG("Late_delivery_risk") * 100,
            2
        ) AS late_rate,

        ROUND(
            COUNT(DISTINCT "Order Id")
            * AVG("Late_delivery_risk"),
            0
        ) AS estimated_late_orders,

        ROUND(
            SUM("Sales")::numeric,
            2
        ) AS total_sales,

        ROUND(
            SUM("Order Profit Per Order")::numeric,
            2
        ) AS total_profit

    FROM logistic

    GROUP BY
        "Shipping Mode",
        "Order Region"
)

SELECT

    *,

    CASE

        WHEN late_rate >= 80
             AND orders >= 1000
            THEN 'Critical'

        WHEN late_rate >= 70
             AND orders >= 500
            THEN 'High'

        WHEN late_rate >= 50
             AND orders >= 500
            THEN 'Medium'

        ELSE 'Normal'

    END AS business_priority

FROM segment_analysis

ORDER BY
    estimated_late_orders DESC;


/* ================================================================
   29. FINAL MANAGEMENT VIEW
   ================================================================
   WHAT THIS FINDS:
   Creates one concise management-level view containing
   the most important operational KPIs.

================================================================ */

SELECT

    COUNT(DISTINCT "Order Id") AS total_orders,

    COUNT(DISTINCT "Customer Id") AS total_customers,

    ROUND(
        SUM("Sales")::numeric,
        2
    ) AS total_sales,

    ROUND(
        SUM("Order Profit Per Order")::numeric,
        2
    ) AS total_profit,

    ROUND(
        AVG("Late_delivery_risk") * 100,
        2
    ) AS overall_late_rate,

    ROUND(
        AVG("Days for shipping (real)"),
        2
    ) AS avg_actual_shipping_days,

    ROUND(
        AVG("Days for shipment (scheduled)"),
        2
    ) AS avg_scheduled_shipping_days,

    ROUND(
        AVG(
            "Days for shipping (real)"
            - "Days for shipment (scheduled)"
        ),
        2
    ) AS avg_shipping_gap

FROM logistic;


/* ================================================================
   END OF SQL BUSINESS ANALYSIS
================================================================ */