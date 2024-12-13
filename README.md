# NTI-PROJECT-ANALYSIS---BIKESTORE-BikeStore Database Analysis
Overview

This project involves analyzing data from the BikeStore database using SQL queries. The goal is to extract, manipulate, and analyze business data to derive actionable insights for the BikeStore company. The database contains various tables related to products, orders, customers, sales, staff, and stores.
Steps and Questions
A. Explore Data

    Display all data in the tables to understand the structure and contents of the BikeStore database.

B. Questions

    Most Expensive Bike: Identify the most expensive bike and discuss potential reasons behind its high pricing.
    Total Customers: Find the total number of customers and discuss whether customers with order status 3 (Rejected) should be considered customers.
    Number of Stores: Determine how many stores BikeStore operates.
    Total Price per Order: Calculate the total price spent per order using the formula:
        Total Price = [list_price] * [quantity] * (1 - [discount])
    Sales per Store: Calculate the sales/revenue for each store using the formula:
        Sales Revenue = [list_price] * [quantity] * (1 - [discount])
    Most Sold Category: Identify the category that has the highest number of sold items.
    Category with Most Rejected Orders: Identify which category had the most rejected orders.
    Least Sold Bike: Identify the bike with the lowest number of sales.
    Full Name of Customer (ID 259): Retrieve the full name of customer with ID 259.
    Purchases of Customer 259: Determine what the customer bought, when, and the order status.
    Staff Processing Order for Customer 259: Identify which staff member processed the order for customer 259 and from which store.
    Total Staff and Lead Staff: Determine the total number of staff and identify the lead staff at BikeStore.
    Most Liked Brand: Identify the most popular brand at BikeStore.
    Number of Categories and Least Liked Category: Find out how many categories BikeStore has and identify the least liked category.
    Store with Most Products of Most Liked Brand: Determine which store still has the most products of the most liked brand.
    Best Performing State in Sales: Identify which state is performing the best in terms of sales.
    Discounted Price of Product 259: Calculate the discounted price of product with ID 259.
    Details of Product 44: Retrieve the product name, quantity, price, category, model year, and brand name of product number 44.
    Zip Code of CA: Find the zip code for California (CA).
    Number of States BikeStore Operates In: Determine how many states BikeStore operates in.
    Bikes Sold in the Last 8 Months (Children Category): Find how many bikes under the children category were sold in the last 8 months.
    Shipped Date for Order from Customer 523: Retrieve the shipped date for the order from customer 523.
    Pending Orders: Determine how many orders are still pending.
    Category and Brand of "Electra white water 3i - 2018": Identify the category and brand that the "Electra white water 3i - 2018" bike falls under.

Tools & Technologies Used

    SQL Server Management Studio (SSMS) for running queries.
    BikeStore Database provided for analysis.

Instructions

    Use the attached .sql file from the BikeStore database to load the data and execute queries.
    Connect the databases and execute the solution script on SSMS.
    All answers are derived by running SQL queries and extracting insights from the database.

Notes

    Order Status:
        1 = Pending
        2 = Processing
        3 = Rejected
        4 = Completed
