CREATE OR REPLACE TABLE
`famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean` AS

SELECT
    -- Transaction
    t.transaction_id,
    t.date,
    t.branch_id,
    -- Branch
    c.branch_category,
    c.branch_name,
    c.kota,
    c.provinsi,
    -- Customer
    t.customer_name,
    -- Product
    t.product_id,
    p.product_name,
    p.product_category,
    t.price AS actual_price,
    -- Discount
    t.discount_percentage,
    -- Gross Profit Percentage
    CASE
        WHEN t.price <= 50000 THEN 0.10
        WHEN t.price <= 100000 THEN 0.15
        WHEN t.price <= 300000 THEN 0.20
        WHEN t.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,
    -- Nett Sales
   ROUND(
        t.price * (1 - t.discount_percentage),
        2
    ) AS nett_sales,
    -- Nett Profit
    ROUND(
        (
            t.price * (1 - t.discount_percentage)
        )
        *
        CASE
            WHEN t.price <= 50000 THEN 0.10
            WHEN t.price <= 100000 THEN 0.15
            WHEN t.price <= 300000 THEN 0.20
            WHEN t.price <= 500000 THEN 0.25
            ELSE 0.30
        END,
        2
    ) AS nett_profit,
    -- Rating
    c.rating AS rating_cabang,
    t.rating AS rating_transaksi

FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction` AS t

LEFT JOIN `famous-elevator-507405-q2.kf_kantor_cabang.kf_kantor_cabang` AS c
    ON t.branch_id = c.branch_id

LEFT JOIN `famous-elevator-507405-q2.kf_product.kf_product` AS p
    ON t.product_id = p.product_id;