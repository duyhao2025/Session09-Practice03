CREATE DATABASE clustered_nonclustered_practice;

\c clustered_nonclustered_practice

CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL
);

INSERT INTO Products (category_id, price, stock_quantity)
SELECT
    (RANDOM() * 20)::INT + 1,
    ROUND((RANDOM() * 1000)::NUMERIC, 2),
    (RANDOM() * 100)::INT
FROM generate_series(1, 100000);

CREATE INDEX idx_products_category
ON Products(category_id);

CLUSTER Products USING idx_products_category;

CREATE INDEX idx_products_price
ON Products(price);

EXPLAIN ANALYZE
SELECT *
FROM Products
WHERE category_id = 5
ORDER BY price;