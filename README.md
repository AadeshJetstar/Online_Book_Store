# Online_Book_Store

🔹 1. Project Title

Online Bookstore Management System

🔹 2. Objective

To design and implement a relational database system for an online bookstore that manages books, customers, orders, payments, and reviews efficiently.

🔹 3. Tools & Technologies

Database: MySQL / PostgreSQL / SQL Server / MySQL Workbench

🔹 4. Database Schema Design

Customers
user_id (PK)
name
email (unique)
phone
address
password

🔹 Books
book_id (PK)
title
author
publisher
category
price
stock

🔹 Orders
order_id (PK)
user_id (FK → Users.user_id)
order_date
status (Pending, Shipped, Delivered, Cancelled)
Order_Details
order_id (FK → Orders.order_id)
book_id (FK → Books.book_id)
quantity
price

The Online Book Store project is a database management system that allows users to browse, search, and purchase books online. It maintains records of books, authors, publishers, customers, and orders. The system supports key operations such as adding new books, managing inventory, tracking customer, processing orders, and generating invoices. 
