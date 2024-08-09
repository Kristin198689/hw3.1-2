USE 150424_wdm_Christina;

-- Создание таблицы заказчиков
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100) NOT NULL,
    street VARCHAR(100) NOT NULL,
    zip_code VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    date_of_registration DATE
);

-- Создание таблицы заказов
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    item_name VARCHAR(100) NOT NULL,
    item_description TEXT NOT NULL,
    item_photo_url VARCHAR(255),
    item_price NUMERIC(10, 2) NOT NULL,
    discounter_price NUMERIC(10, 2),  -- Добавлено поле для скидочной стоимости
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
-- Вставка данных в таблицу заказчиков
INSERT INTO customer (
    first_name,
    last_name,
    street,
    zip_code,
    city,
    email,
    date_of_registration,
    country
) VALUES
("Alice", "Mon", "Hupstr.", "21354", "Berlin", "adgft@gmail.com", "2024-08-08", "Germany"),
("John", "Doe", "123 Main St", "12345", "Anytown", "john.doe@example.com", "2024-08-08", "Country"),
("Jane", "Smith", "456 Oak St", "67890", "Othertown", "jane.smith@example.com", "2024-08-08", "Country"),
("Alice", "Johnson", "789 Pine St", "11223", "Sometown", "alice.johnson@example.com", "2024-08-08", "Country");

-- Вставка данных в таблицу заказов
INSERT INTO orders (
    customer_id,
    order_date,
    item_name,
    item_description,
    item_photo_url,
    item_price,
    discounter_price
) VALUES
-- Заказчик 1
(1, '2024-08-08', 'Widget A', 'Description for Widget A', 'http://example.com/widget-a.jpg', 20.00, 18.00),
(1, '2024-08-10', 'Widget B', 'Description for Widget B', 'http://example.com/widget-b.jpg', 35.00, 31.50),

-- Заказчик 2
(2, '2024-08-09', 'Gadget A', 'Description for Gadget A', 'http://example.com/gadget-a.jpg', 50.00, 45.00),
(2, '2024-08-11', 'Gadget B', 'Description for Gadget B', 'http://example.com/gadget-b.jpg', 40.00, 36.00),
(2, '2024-08-12', 'Gadget C', 'Description for Gadget C', 'http://example.com/gadget-c.jpg', 60.00, 54.00),

-- Заказчик 3
(3, '2024-08-08', 'Tool A', 'Description for Tool A', 'http://example.com/tool-a.jpg', 25.00, 22.50),
(3, '2024-08-09', 'Tool B', 'Description for Tool B', 'http://example.com/tool-b.jpg', 15.00, 13.50);
SELECT * 
FROM orders
ORDER BY item_price DESC;

SELECT * 
FROM customer
WHERE email LIKE '%@gmail.com';
SELECT *, 
       CASE
           WHEN item_price < 20 THEN 'low'
           WHEN item_price BETWEEN 20 AND 50 THEN 'middle'
           ELSE 'high'
       END AS status
FROM orders;
SELECT 
    *
FROM
    customer
ORDER BY rating DESC;
SELECT 
    *
FROM
    customer
WHERE
    city = 'Berlin';
SELECT 
    product_id, COUNT(*) AS sales_count
FROM
    Orders
GROUP BY product_id
ORDER BY sales_count DESC
LIMIT 1;
SELECT 
    *
FROM
    Orders
WHERE
    discount = (SELECT 
            MAX(discount)
        FROM
            Orders);
SELECT *, 
    ((normal_price - discounted_price) / normal_price) * 100 AS процент_скидки
FROM Orders;

--Ответьте в 1 предложении: как вы определите скидку? Скидка определяется как разница между нормальной ценой товара и его ценой со скидкой.
--Ответьте в 1 предложении: может ли это быть разница между нормальной ценой и скидочной ценой? Да, скидка может быть определена как разница между нормальной ценой и скидочной ценой.
