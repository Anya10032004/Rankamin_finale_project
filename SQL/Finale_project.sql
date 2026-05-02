
-- 1. DETERMINE THE PRIMARY KEY AND FOREIGN KEY:
-- --------------------------------------------------------------------
-- ----------------------------------------------------------------------
-- The PK and FK relationship 
-- finale_trans (FK) ---> kantor_cabang <---(FK) inventory
-- finale_trans(FK)  ---> product       <---(FK) inventory

ALTER TABLE `rakaminkfanalytics-494204.kimia_farma.final_transaction`
ADD PRIMARY KEY (transaction_id) NOT ENFORCED;

ALTER TABLE `rakaminkfanalytics-494204.kimia_farma.kantor_cabang`
ADD PRIMARY KEY (branch_id) NOT ENFORCED;

ALTER TABLE `rakaminkfanalytics-494204.kimia_farma.product`
ADD PRIMARY KEY (product_id) NOT ENFORCED;

ALTER TABLE `rakaminkfanalytics-494204.kimia_farma.inventory`
ADD PRIMARY KEY (inventory_id) NOT ENFORCED;

ALTER TABLE `rakaminkfanalytics-494204.kimia_farma.final_transaction`
ADD FOREIGN KEY (branch_id) 
REFERENCES `rakaminkfanalytics-494204.kimia_farma.kantor_cabang`(branch_id) NOT ENFORCED;

ALTER TABLE `rakaminkfanalytics-494204.kimia_farma.final_transaction`
ADD FOREIGN KEY (product_id) 
REFERENCES `rakaminkfanalytics-494204.kimia_farma.product` (product_id) NOT ENFORCED;

ALTER TABLE `rakaminkfanalytics-494204.kimia_farma.inventory`
ADD FOREIGN KEY (product_id) 
REFERENCES `rakaminkfanalytics-494204.kimia_farma.product` (product_id) NOT ENFORCED;


-- 2. MAKE A TABLE FOR OUR ANALYSIS(FROM JOIN THE 4 TABLES)
-- --------------------------------------------------------------------
-- ----------------------------------------------------------------------
CREATE TABLE rakaminkfanalytics-494204.kimia_farma.analysis_table AS 
SELECT ft.transaction_id AS transaction_id, 
ft.date AS date, 
ft.branch_id AS branch_id, 
kc.branch_name AS branch_name,
kc.kota AS kota,
kc.provinsi AS provinsi,
kc.rating AS rating_cabang,
ft.customer_name AS customer_name,
ft.product_id AS product_id, 
p.product_name AS product_name,
p.price AS actual_price,
ft.discount_percentage AS discount_percentage,
CASE 
    WHEN p.price <= 50000 THEN 0.1
    WHEN p.price > 50000 and p.price <= 100000 THEN 0.15
    WHEN p.price > 100000 and p.price <= 300000 THEN 0.2
    WHEN p.price > 300000 and p.price <= 500000 THEN 0.25
    WHEN p.price > 500000 THEN 0.3
END AS persentase_gross_laba,
p.price- p.price*ft.discount_percentage AS nett_sales,
ft.rating AS rating_transaksi
FROM rakaminkfanalytics-494204.kimia_farma.final_transaction ft 
JOIN rakaminkfanalytics-494204.kimia_farma.kantor_cabang kc 
   ON ft.branch_id = kc.branch_id
JOIN rakaminkfanalytics-494204.kimia_farma.product p 
   ON ft.product_id = p.product_id
JOIN rakaminkfanalytics-494204.kimia_farma.inventory i 
   ON ft.product_id = i.product_id and ft.branch_id = i.branch_id;



-- 3. CREATE the net_profit coulumn
-- --------------------------------------------------------------------
-- ----------------------------------------------------------------------
CREATE OR REPLACE TABLE `rakaminkfanalytics-494204.kimia_farma.analysis_table` 
AS SELECT *, actual_price - (nett_sales)  AS nett_profit
FROM `rakaminkfanalytics-494204.kimia_farma.analysis_table`;



-- 4. To see the table
-- --------------------------------------------------------------------
-- ----------------------------------------------------------------------
SELECT * FROM `rakaminkfanalytics-494204.kimia_farma.analysis_table`; 




