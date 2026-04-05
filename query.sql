-- Query to get product inventory and their warehouse information
SELECT p.productCode, p.productName, p.quantityInStock, w.warehouseName
FROM products p
JOIN warehouses w ON p.warehouseCode = w.warehouseCode;

-- Calculate inventory turnover rate for each product
SELECT
    p.productCode,
    p.productName,
    SUM(o.quantityOrdered) AS total_quantity_sold,
    p.quantityInStock,
    SUM(o.quantityOrdered) / p.quantityInStock AS inventory_turnover_rate
FROM products p
LEFT JOIN orderdetails o ON p.productCode = o.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock
ORDER BY inventory_turnover_rate ASC;

-- Find products with no recent sales
SELECT p.productCode, p.productName, p.quantityInStock
FROM products p
JOIN orderdetails o ON p.productCode = o.productCode
JOIN orders s on o.orderNumber = s.orderNumber
WHERE s.orderDate IS NULL OR s.orderDate < DATE_SUB(NOW(), INTERVAL 6 MONTH);
