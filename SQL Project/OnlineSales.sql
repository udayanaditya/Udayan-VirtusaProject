-- Creating a relational database for an online store
    -- Customers Table
    CREATE TABLE Customers (
        customer_id INT PRIMARY KEY,
        name VARCHAR(100),
        city VARCHAR(100)
    );

    -- Products Table
    CREATE TABLE Products (
        product_id INT PRIMARY KEY,
        name VARCHAR(100),
        category VARCHAR(100),
        price DECIMAL(10,2)
    );

    -- Orders Table
    CREATE TABLE Orders (
        order_id INT PRIMARY KEY,
        customer_id INT,
        date DATE,
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    );

    -- Order Items Table
    CREATE TABLE Order_Items (
        order_id INT,
        product_id INT,
        quantity INT,
        PRIMARY KEY (order_id, product_id),
        FOREIGN KEY (order_id) REFERENCES Orders(order_id),
        FOREIGN KEY (product_id) REFERENCES Products(product_id)
    );
-- Storing customer, product, and order data
    INSERT INTO Customers VALUES
    (1, 'Udayan', 'Doghar'),
    (2, 'Rishav', 'Delhi'),
    (3, 'Sumit', 'Hyderabad');

    INSERT INTO Products VALUES
    (101, 'Phone', 'Electronics', 50000),
    (102, 'Rice', 'Food', 1000),
    (103, 'Shirt', 'Fashion', 3000);

    INSERT INTO Orders VALUES
    (1001, 1, '2026-04-08'),
    (1002, 2, '2026-04-05'),
    (1003, 1, '2026-04-02');

    INSERT INTO Order_Items VALUES
    (1001, 101, 1),
    (1001, 103, 2),
    (1002, 102, 1),
    (1003, 102, 2);

-- SQL Queries

    -- Query for top-selling products
    SELECT 
        p.product_id,
        p.name,
        SUM(oi.quantity) AS total_sold
    FROM Order_Items oi
    JOIN Products p ON oi.product_id = p.product_id
    GROUP BY p.product_id, p.name
    ORDER BY total_sold DESC;

    -- Query to identify most valuable customers
    SELECT 
        c.customer_id,
        c.name,
        SUM(p.price * oi.quantity) AS total_spent
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN Order_Items oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.name
    ORDER BY total_spent DESC;

    -- Query for monthly revenue calculation
    SELECT 
        DATE_FORMAT(o.date, '%Y-%m') AS month,
        SUM(p.price * oi.quantity) AS revenue
    FROM Orders o
    JOIN Order_Items oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    GROUP BY month
    ORDER BY month;

    -- Query for category-wise sales analysis
    SELECT 
        p.category,
        SUM(p.price * oi.quantity) AS total_sales
    FROM Products p
    JOIN Order_Items oi ON p.product_id = oi.product_id
    GROUP BY p.category
    ORDER BY total_sales DESC;

    -- Query to detect inactive customers
    SELECT 
        c.customer_id,
        c.name
    FROM Customers c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id
    WHERE o.order_id IS NULL;