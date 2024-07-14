CREATE DATABASE library;
USE library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15));
select *from branch;  
  
    CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no));
select *from employee;  
  
    CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255));
select *from books;    
    
    CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE);
select *from customer;    
    
    CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(13),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN));
select *from issuestatus;    
    
    CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(13),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN));
select *from returnstatus;    
    
-- Branch
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES 
(1, 101, '123 KL IND', '1234567890'),
(2, 102, '456 TN IND', '2345678901'),
(3, 103, '789 KA IND', '3456789012');
select *from branch;  

-- Employee
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES 
(101, 'Alice', 'Manager', 60000, 1),
(104, 'Bob', 'Staff', 45000, 1),
(102, 'Charlie', 'Manager', 70000, 2),
(105, 'David', 'Staff', 50000, 2),
(103, 'Eve', 'Manager', 75000, 3),
(106, 'Roi', 'Staff', 45000, 3),
(107, 'ali', 'Staff', 40000, 3);
select *from employee; 

-- Books
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES 
('1234567890123', 'The Sound of Us', 'Fiction', 30, 'yes', 'Sarah Castille ', 'Laura Bradford'),
('2345678901234', 'What Is History', 'History', 25, 'no', 'Edward Hallett Carr', 'University of Cambridge'),
('3456789012345', 'The Life of Galileo', 'Science', 20, 'yes', 'Bertolt Brecht', 'Arcade Publishing'),
('4567890123456', 'Love,Theoretically', 'Romantic', 35, 'yes', 'Ali Hazelwood', 'Penguin Publishing'),
('5678901234567', 'The AI Edge', 'Technology', 40, 'no', 'Anthony Iannarino', 'O-Reilly Media'),
('6789012345678', 'Harry Potter', 'Fiction', 50, 'no', 'J. K. Rowling', 'Bloomsbury'),
('7890123456789', 'India After Gandhi', 'non-fiction', 40, 'yes', 'Ramachandra Guha', 'HarperCollins'),
('8901234567890', 'The Kalki Trilogy', 'Historical Fiction', 70, 'yes', 'Kevin Missal', 'Fingerprint Publishing'),
('9012345678901', 'Generation 14', 'Science Fiction', 50, 'no', 'Priya Sarukkai Chabria', 'Zubaan'),
('0123456789012', 'The God of Small Things', 'Novel', 40, 'no', 'Arundhati Roy', 'RST IndiaInk & Penguin Books');
select *from books;

-- Customer
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES 
(1, 'TOM', 'KL IND', '2020-12-01'),
(2, 'JERRY', 'KA IND', '2021-11-15'),
(3, 'DORA', 'TN IND', '2022-05-20'),
(4, 'JACOB', 'TS IND', '2023-03-10'),
(5, 'CHRISTY', 'DL IND', '2021-01-30');
select *from customer;

-- IssueStatus
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES 
(1, 1, 'The Sound of Us', '2020-12-01', '1234567890123'),
(2, 2, 'The Life of Galileo', '2021-11-15', '3456789012345'),
(3, 3, 'Love,Theoretically', '2022-05-20', '4567890123456');
select *from IssueStatus;

-- ReturnStatus
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES 
(1, 1, 'The Sound of Us', '2021-02-01', '1234567890123'),
(2, 2, 'The Life of Galileo', '2022-02-10', '3456789012345'),
(3, 3, 'Love,Theoretically', '2022-08-15', '4567890123456');
select *from ReturnStatus;

-- Retrieve the book title, category, and rental price of all available books
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'no';

-- List the employee names and their respective salaries in descending order of salary
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC; 

-- Retrieve the book titles and the corresponding customers who have issued those books
SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

-- Display the total count of books in each category
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs. 50,000
SELECT Emp_name, Position
FROM Employee
WHERE Salary >= 50000;

-- List the customer names who registered before '2022-01-01' and have not issued any books yet
SELECT Customer_id, Customer_name,  Reg_date
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- Display the branch numbers and the total count of employees in each branch
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- Display the names of customers who have issued books in the month of 2021-10-01
SELECT DISTINCT Customer.Customer_name
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Issue_date BETWEEN '2021-10-01' AND '2023-06-30';

--  Retrieve book_title from book table containing history
SELECT Book_title, Category
FROM Books
WHERE Book_title LIKE '%history%';

-- Retrieve the branch numbers along with the count of employees for branches having more than 2 employees
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 2;

-- Retrieve the names of employees who manage branches and their respective branch addresses
SELECT Employee.Emp_name, Employee.position, Branch.Branch_address
FROM branch
JOIN Employee ON Branch.Manager_Id = Employee.Emp_Id;

-- Display the names of customers who have issued books with a rental price higher than Rs. 25
SELECT DISTINCT Customer.Customer_name, Books.book_title, Books.rental_Price
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 25; 









 


    






