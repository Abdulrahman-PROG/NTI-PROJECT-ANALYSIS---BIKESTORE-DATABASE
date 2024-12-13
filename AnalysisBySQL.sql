--A. Explore Data
SELECT * FROM Production.brands
SELECT * FROM Production.categories
SELECT * FROM Production.Products
SELECT * FROM Production.stocks

SELECT * FROM sales.customers
SELECT * FROM sales.order_items
SELECT * FROM sales.orders
SELECT * FROM sales.staffs
SELECT * FROM sales.stores


--B. Questions
--1) Which bike is most expensive? What could be the motive behind pricing this bike at the high price?
SELECT product_name, list_price
FROM Production.products
WHERE list_price = (SELECT MAX(list_price) FROM Production.products)
--or this 
SELECT TOP 1 product_name, list_price
FROM Production.products
ORDER BY list_price DESC

--2) How many total customers does BikeStore have? Would you consider people with order status 3 as customers substantiate your answer?
--Total Customers in BikeStore
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM sales.customers
--Should Customers with Order Status 3 be Considered?
SELECT COUNT(DISTINCT customer_id) AS customers_with_status_3
FROM sales.orders
WHERE order_status = 3

--3) How many stores does BikeStore have?
SELECT COUNT(*) AS total_stores
FROM sales.stores;

--4) What is the total price spent per order?
SELECT  
    order_id,
    SUM(list_price * quantity * (1 - discount)) AS total_price
FROM 
    sales.order_items
GROUP BY 
    order_id


--5) What’s the sales/revenue per store?
SELECT 
    s.store_name,
    SUM(oi.list_price * oi.quantity * (1 - oi.discount)) AS total_revenue
FROM 
    sales.order_items oi
JOIN 
    sales.orders o ON oi.order_id = o.order_id
JOIN 
    sales.stores s ON o.store_id = s.store_id
GROUP BY 
    s.store_id, s.store_name
ORDER BY 
    total_revenue DESC

--6) Which category is most sold?
SELECT TOP 1
    c.category_name,
    SUM(oi.quantity) AS total_sold
FROM production.categories c
JOIN production.products p ON c.category_id = p.category_id
JOIN sales.order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY total_sold DESC

--7) Which category rejected more orders?

--8) Which bike is the least sold?
SELECT TOP 1
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM 
    sales.order_items oi
JOIN 
    production.products p ON oi.product_id = p.product_id
GROUP BY 
    p.product_id, p.product_name
ORDER BY 
    total_quantity_sold ASC


--9) What’s the full name of a customer with ID 259?
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM sales.customers
WHERE customer_id = 259

--10) What did the customer on question 9 buy and when? What’s the status of this order?
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    p.product_name,
    o.order_date,
    o.order_status,
    oi.quantity
FROM sales.customers c
INNER JOIN sales.orders o ON c.customer_id = o.customer_id
INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
INNER JOIN production.products p ON oi.product_id = p.product_id
WHERE c.customer_id = 259
ORDER BY o.order_date

-- 11) Which staff processed the order of customer 259? And from which store?
SELECT 
    s.first_name + ' '+s.last_name Full_Name,
    st.store_name
FROM sales.orders o
JOIN sales.staffs s ON o.staff_id = s.staff_id
JOIN sales.stores st ON s.store_id = st.store_id
WHERE o.customer_id = 259


--12) How many staff does BikeStore have? Who seems to be the lead Staff at BikeStore?
SELECT COUNT(*) AS total_staff
FROM sales.staffs

--13) Which brand is the most liked?
SELECT TOP 1
    b.brand_name,
    SUM(oi.list_price * oi.quantity * (1 - oi.discount)) AS total_revenue
FROM 
    sales.order_items oi
JOIN 
    production.products p ON oi.product_id = p.product_id
JOIN 
    production.brands b ON p.brand_id = b.brand_id
GROUP BY 
    b.brand_id, b.brand_name
ORDER BY 
    total_revenue DESC


--14) How many categories does BikeStore have, and which one is the least liked?
--Step 1: Count the Total Number of Categories
SELECT COUNT(*) AS total_categories
FROM production.categories

--Step 2: Find the Least-Liked Category
SELECT TOP 1
    c.category_name,
    SUM(oi.quantity) AS total_sold
FROM production.categories c
JOIN production.products p ON c.category_id = p.category_id
JOIN sales.order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY total_sold ASC

--15) Which store still have more products of the most liked brand?
--Step 1: Find the Most-Liked Brand
SELECT TOP 1
    b.brand_id,
    b.brand_name,
    SUM(oi.quantity) AS total_sold
FROM production.brands b
JOIN production.products p ON b.brand_id = p.brand_id
JOIN sales.order_items oi ON p.product_id = oi.product_id
GROUP BY b.brand_id, b.brand_name
ORDER BY total_sold DESC

--Step 2: Find the Store with the Most Stock for the Most-Liked Brand
SELECT TOP 1
    st.store_name,
    SUM(stk.quantity) AS total_stock
FROM sales.stores st
JOIN production.stocks stk ON st.store_id = stk.store_id
JOIN production.products p ON stk.product_id = p.product_id
WHERE p.brand_id = 1
GROUP BY st.store_name
ORDER BY total_stock DESC

--16) Which state is doing better in terms of sales?
SELECT TOP 1
    st.state,
    SUM(oi.quantity * oi.list_price) AS total_revenue
FROM sales.stores st
JOIN sales.orders o ON st.store_id = o.store_id
JOIN sales.order_items oi ON o.order_id = oi.order_id
GROUP BY st.state
ORDER BY total_revenue DESC

--17) What’s the discounted price of product id 259?

--18) What’s the product name, quantity, price, category, model year and brand name of product number 44?
SELECT 
    p.product_name,
    oi.quantity,
    oi.list_price AS price,
    c.category_name,
    p.model_year,
    b.brand_name
FROM production.products p
INNER JOIN sales.order_items oi ON p.product_id = oi.product_id
INNER JOIN production.categories c ON p.category_id = c.category_id
INNER JOIN production.brands b ON p.brand_id = b.brand_id
WHERE p.product_id = 44


--19) What’s the zip code of CA?
SELECT 
    st.store_name, 
    st.zip_code
FROM sales.stores st
WHERE st.state = 'CA'

--20) How many states does BikeStore operate in?
SELECT 
    COUNT(DISTINCT state) AS total_states
FROM 
    sales.stores

--21) How many bikes under the children category were sold in the last 8 months?
SELECT 
    SUM(oi.quantity) AS total_bikes_sold
FROM production.products p
JOIN production.categories c ON p.category_id = c.category_id
JOIN sales.order_items oi ON p.product_id = oi.product_id
JOIN sales.orders o ON oi.order_id = o.order_id
WHERE c.category_name = 'Children Bicycles'  
AND o.order_date >= DATEADD(MONTH, -8, GETDATE()) 


--22) What’s the shipped date for the order from customer 523
SELECT 
    o.shipped_date
FROM sales.orders o
WHERE o.customer_id = 523

--23) How many orders are still pending?
SELECT 
    COUNT(*) AS pending_orders
FROM 
    sales.orders
WHERE 
    shipped_date is null


--24) What’s the names of category and brand does "Electra white water 3i -2018" fall under?
SELECT 
    c.category_name,
    b.brand_name
FROM production.products p
INNER JOIN production.categories c ON p.category_id = c.category_id
INNER JOIN production.brands b ON p.brand_id = b.brand_id
WHERE p.product_name = 'Electra white water 3i - 2018'
