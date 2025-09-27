-- CREATE DATABASE.
CREATE DATABASE OnlineBooksStore;

-- USE DATABASE
USE OnlineBooksStore;

-- CREATE TABLE INTO A DATABASE.
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

-- RETRIEVE THE DATA 
SELECT * FROM Books;

-- 2nd TABLE CREATE
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

-- RETRIEVE THE DATA
SELECT * FROM Customers;

-- 3rd TABLE CREATE
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

-- RETRIEVE THE DATA
SELECT * FROM Orders;

-- IMPORT THESE EXCEL DATA "BOOKS, CUSTOMERS, ORDERS".

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

----------------------------------------------------------- SIMPLE QUESTION --------------------------------------------------------------

-- Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE Genre ='Fiction';

-- COUNT THE TOTAL OF "Fiction" BOOKS.
SELECT COUNT(Genre) AS Total_Fiction_Books FROM Books 
WHERE Genre ='Fiction';

-- Find books published after the year 1950.
SELECT * FROM Books
WHERE Published_year > '1950';

-- COUNT THE TOTAL PUBLISHED BOOKS AFTER 1950.
SELECT COUNT(Published_Year) AS Total_Published_Books FROM Books
WHERE Published_Year > '1950';

-- List all customers from the Canada:
SELECT * FROM Customers
WHERE Country ='Canada';

-- Show order Placed in November 2023:
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- COUNT THE TOTAL ORDER PLACED IN NOVEMBER 2023:
SELECT COUNT(Order_Date) AS Total_Orders_In_Nov FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- Retrieve the total stock of books available:
SELECT SUM(Stock) AS Total_Books FROM Books;

-- Retrieve the total numbers of books available.
SELECT COUNT(Stock) AS Total_Stocks FROM Books;

-- Find the details of most expensive books:
SELECT * FROM Books ORDER BY Price DESC
LIMIT 1;

-- Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders
WHERE Quantity > 1;

-- Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE Total_Amount > 20;
        
-- List all Unique genres available in the Books Tables:
SELECT DISTINCT genre FROM Books;

-- Find the books with the lowest stocks:
SELECT * FROM Books ORDER BY Stock ASC
LIMIT 1;

-- OR
SELECT MIN(Stock) AS Lowest_Stocks FROM Books
LIMIT 1;

-- Calculate the total revenue generate from all orders:
SELECT SUM(Total_Amount) AS Revenue FROM Orders;


----------------------------------------------------------- ADVANCED QUESTION --------------------------------------------------------------

-- Retrieve the total number of books sold for each genre:
SELECT b.Genre, SUM(o.Quantity)  AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

-- Find the Average price of books in the "Fantasy" genre:
SELECT AVG(price) AS Average_Price FROM Books
WHERE Genre ='Fantasy';

-- List Customers who have placed at least 2 Orders:
SELECT o.customer_id, c.name, COUNT(o.Order_id) AS Order_Count FROM Orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >= 2;

-- Find the most frequently ordered book:
SELECT o.Book_id, b.title, COUNT(o.order_id) AS Order_count FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY o.Book_id, b.title
ORDER BY Order_count DESC 
LIMIT 1;

-- Show the top 3 most expensive books of "Fantasy"  Genre:
SELECT * FROM Books
WHERE genre ="Fantasy"
ORDER BY Price DESC
LIMIT 3;

-- Retrieve the total quantity of books sold by each author:
SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM Orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.author;

-- List the cities where customers who spent over $30 are located.
SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.total_amount > 30;
 
-- Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_Spent DESC
LIMIT 1;

-- Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_Qty, 
b.stock - COALESCE(SUM(o.quantity),0) AS Remaining_Qty
FROM Books b 
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id; 

-- Retrieve All data.
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;
