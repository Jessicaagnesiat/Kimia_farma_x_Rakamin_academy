-- top 10 provinsi
SELECT
    provinsi,
    COUNT(transaction_id) AS total_transactions
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
GROUP BY provinsi
ORDER BY total_transactions DESC;

-- top 10 nett sales by provinsi
SELECT
    provinsi,
    SUM(nett_sales) AS total_nett_sales,
    COUNT(transaction_id) AS total_transaksi,
    COUNT(DISTINCT branch_id) AS jumlah_cabang
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
GROUP BY provinsi
ORDER BY total_nett_sales DESC
LIMIT 10;

-- top 5 provinsi
SELECT
    EXTRACT(MONTH FROM date) AS month,
    provinsi,
    ROUND(SUM(nett_profit), 2) AS total_nett_profit
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
WHERE EXTRACT(YEAR FROM date) = 2020
  AND provinsi IN (
      'Jawa Barat',
      'Sumatera Utara',
      'Jawa Tengah',
      'Jawa Timur',
      'Sulawesi Utara'
  )
GROUP BY month, provinsi
ORDER BY month, provinsi;

--2021
SELECT
    EXTRACT(MONTH FROM date) AS month,
    provinsi,
    ROUND(SUM(nett_profit), 2) AS total_nett_profit
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
WHERE EXTRACT(YEAR FROM date) = 2021
  AND provinsi IN (
      'Jawa Barat',
      'Sumatera Utara',
      'Jawa Tengah',
      'Jawa Timur',
      'Sulawesi Utara'
  )
GROUP BY month, provinsi
ORDER BY month, provinsi;

-- rating cabangnya tinggi tapi rating transaksinya rendah
SELECT
    branch_id,
    branch_name,
    kota,
    provinsi,
    rating_cabang,
    ROUND(AVG(rating_transaksi), 2) AS rata_rata_rating_transaksi,
    COUNT(transaction_id) AS total_transaksi
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
GROUP BY
    branch_id,
    branch_name,
    kota,
    provinsi,
    rating_cabang
ORDER BY
    rating_cabang DESC,
    rata_rata_rating_transaksi ASC
LIMIT 5;

-- rank product
WITH monthly_product_sales AS (
    SELECT
        EXTRACT(YEAR FROM date) AS year,
        EXTRACT(MONTH FROM date) AS month,
        product_id,
        product_name,
        COUNT(transaction_id) AS total_transactions
    FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
    GROUP BY
        year,
        month,
        product_id,
        product_name
),

ranked_products AS (
    SELECT
        year,
        month,
        product_id,
        product_name,
        total_transactions,
        ROW_NUMBER() OVER (
            PARTITION BY year, month
            ORDER BY total_transactions DESC
        ) AS rank
    FROM monthly_product_sales
)

SELECT
    year,
    month,
    product_id,
    product_name,
    total_transactions
FROM ranked_products
WHERE rank = 1
ORDER BY year, month;

-- kontribusi sales dan profit
SELECT
    DATE_TRUNC(date, MONTH) AS month,
    ROUND(SUM(nett_sales), 2) AS total_nett_sales
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
GROUP BY month
ORDER BY month;

WITH province_sales AS (
    SELECT
        provinsi,
        SUM(nett_sales) AS total_nett_sales,
        SUM(nett_profit) AS total_nett_profit
    FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
    GROUP BY provinsi
)

SELECT
    provinsi,

    ROUND(total_nett_sales, 2) AS total_nett_sales,

    ROUND(
        SAFE_DIVIDE(
            total_nett_sales,
            SUM(total_nett_sales) OVER ()
        ) * 100,
        2
    ) AS sales_contribution_percentage,

    ROUND(total_nett_profit, 2) AS total_nett_profit,

    ROUND(
        SAFE_DIVIDE(
            total_nett_profit,
            SUM(total_nett_profit) OVER ()
        ) * 100,
        2
    ) AS profit_contribution_percentage

FROM province_sales
ORDER BY total_nett_sales DESC;

-- profit perbulan
SELECT
    month,
    provinsi,
    ROUND(AVG(monthly_profit), 2) AS avg_monthly_profit
FROM (
    SELECT
        EXTRACT(YEAR FROM date) AS year,
        EXTRACT(MONTH FROM date) AS month,
        provinsi,
        SUM(nett_profit) AS monthly_profit
    FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
    WHERE provinsi IN (
        'Jawa Barat',
        'Sumatera Utara',
        'Jawa Tengah',
        'Jawa Timur',
        'Sulawesi Utara'
    )
    GROUP BY
        year,
        month,
        provinsi
)
GROUP BY
    month,
    provinsi
ORDER BY
    month,
    provinsi;

SELECT
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    ROUND(SUM(nett_profit), 2) AS total_nett_profit
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
WHERE provinsi = 'Jawa Barat'
GROUP BY
    year,
    month
ORDER BY
    year,
    month;

-- profit tidak ada yang negatif
SELECT
    product_id,
    product_name,
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(nett_sales), 2) AS total_nett_sales,
    ROUND(SUM(nett_profit), 2) AS total_nett_profit
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
GROUP BY
    product_id,
    product_name
HAVING SUM(nett_profit) < 0
ORDER BY total_nett_profit ASC;

SELECT
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    product_id,
    product_name,
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(nett_sales), 2) AS total_nett_sales,
    ROUND(SUM(nett_profit), 2) AS total_nett_profit,
    ROUND(
        SAFE_DIVIDE(SUM(nett_profit), SUM(nett_sales)) * 100,
        2
    ) AS profit_margin_percentage
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
GROUP BY
    year,
    month,
    product_id,
    product_name
ORDER BY
    year ASC,
    month ASC,
    profit_margin_percentage ASC;

-- profit by branch category
SELECT
    kota,
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(nett_sales), 2) AS total_nett_sales,
    ROUND(SUM(nett_profit), 2) AS total_nett_profit
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
WHERE branch_category = 'Apotek'
GROUP BY kota
ORDER BY total_nett_profit ASC;


SELECT
    branch_category,
    kota,
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(nett_sales), 2) AS total_nett_sales,
    ROUND(SUM(nett_profit), 2) AS total_nett_profit
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction_clean`
WHERE branch_category IN ('Klinik', 'Apotek')
GROUP BY
    branch_category,
    kota
ORDER BY
    total_nett_profit ASC;

