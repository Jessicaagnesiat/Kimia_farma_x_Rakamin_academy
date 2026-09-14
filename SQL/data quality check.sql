-- Final transaction table
SELECT
    -- Total data
    COUNT(*) AS total_rows,
    -- Uniqueness check
    COUNT(DISTINCT transaction_id) AS unique_transaction_id,
    -- Missing value check
    COUNTIF(transaction_id IS NULL) AS transaction_id_null,
    COUNTIF(date IS NULL) AS date_null,
    COUNTIF(branch_id IS NULL) AS branch_id_null,
    COUNTIF(customer_name IS NULL) AS customer_name_null,
    COUNTIF(product_id IS NULL) AS product_id_null,
    COUNTIF(price IS NULL) AS price_null,
    COUNTIF(discount_percentage IS NULL) AS discount_percentage_null,
    COUNTIF(rating IS NULL) AS rating_null
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction`;


-- kf kantor cabang
SELECT
    -- Total data
    COUNT(*) AS total_rows,
    -- Uniqueness check
    COUNT(DISTINCT branch_id) AS unique_branch_id,
    -- Missing value check
    COUNTIF(branch_id IS NULL) AS branch_id_null,
    COUNTIF(branch_category IS NULL) AS branch_category_null,
    COUNTIF(branch_name IS NULL) AS branch_name_null,
    COUNTIF(kota IS NULL) AS kota_null,
    COUNTIF(provinsi IS NULL) AS provinsi_null,
    COUNTIF(rating IS NULL) AS rating_null
FROM `famous-elevator-507405-q2.kf_kantor_cabang.kf_kantor_cabang`;


-- kf product
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_product_id,
    COUNTIF(product_id IS NULL) AS product_id_null,
    COUNTIF(product_name IS NULL) AS product_name_null,
    COUNTIF(product_category IS NULL) AS product_category_null,
    COUNTIF(price IS NULL) AS price_null
FROM `famous-elevator-507405-q2.kf_product.kf_product`;


-- kf Inventory
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Inventory_ID) AS unique_inventory_id,
    COUNT(DISTINCT product_id) AS unique_product_id,
    COUNTIF(Inventory_ID IS NULL) AS inventory_id_null,
    COUNTIF(branch_id IS NULL) AS branch_id_null,
    COUNTIF(product_id IS NULL) AS product_id_null,
    COUNTIF(product_name IS NULL) AS product_name_null,
    COUNTIF(opname_stock IS NULL) AS opname_stock_null
FROM `famous-elevator-507405-q2.kf_inventory.kf_inventory`;

SELECT
    branch_id,
    product_id,
    COUNT(*) AS jumlah
FROM `famous-elevator-507405-q2.kf_inventory.kf_inventory`
GROUP BY
    branch_id,
    product_id
HAVING COUNT(*) > 1
ORDER BY jumlah DESC;

SELECT
    branch_id,
    product_id,
    product_name,
    opname_stock,
    COUNT(*) AS jumlah
FROM `famous-elevator-507405-q2.kf_inventory.kf_inventory`
GROUP BY
    branch_id,
    product_id,
    product_name,
    opname_stock
HAVING COUNT(*) > 1
ORDER BY product_id DESC, branch_id DESC;

SELECT
    i.product_id,
    i.product_name AS inventory_product_name,
    p.product_name AS product_product_name
FROM `famous-elevator-507405-q2.kf_inventory.kf_inventory` AS i
LEFT JOIN `famous-elevator-507405-q2.kf_product.kf_product` AS p
    ON i.product_id = p.product_id
WHERE i.product_name != p.product_name;

-- nilai min, max discount
SELECT
    MIN(discount_percentage) AS min_discount,
    MAX(discount_percentage) AS max_discount,
    COUNT(DISTINCT discount_percentage) AS unique_discount
FROM `famous-elevator-507405-q2.kf_final_transaction.kf_final_transaction`;