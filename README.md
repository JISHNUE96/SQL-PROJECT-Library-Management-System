# SQL-PROJECT-Library-Management-System
The Library Management System (LMS) is designed to manage and maintain the day-to-day operations of a library.The system includes functionalities for handling book inventories, managing customer data, tracking book issues and returns, and overseeing branch and employee information. This project involves creating a relational database named 'library' with several interrelated tables to store and manage the library's data efficiently.
Database Structure:
Branch Table:
Branch_no (PRIMARY KEY): Unique identifier for each branch.
Manager_Id: Identifier for the branch manager.
Branch_address: Physical address of the branch.
Contact_no: Contact number for the branch.
Employee Table:
Emp_Id (PRIMARY KEY): Unique identifier for each employee.
Emp_name: Name of the employee.
Position: Job position of the employee.
Salary: Salary of the employee.
Branch_no (FOREIGN KEY): References the Branch_no in the Branch table.
Books Table:
ISBN (PRIMARY KEY): Unique identifier for each book.
Book_title: Title of the book.
Category: Category or genre of the book.
Rental_Price: Rental price for borrowing the book.
Status: Availability status of the book (yes/no).
Author: Author of the book.
Publisher: Publisher of the book.
Customer Table:
Customer_Id (PRIMARY KEY): Unique identifier for each customer.
Customer_name: Name of the customer.
Customer_address: Address of the customer.
Reg_date: Registration date of the customer.
IssueStatus Table:
Issue_Id (PRIMARY KEY): Unique identifier for each book issue transaction.
Issued_cust (FOREIGN KEY): References the Customer_Id in the Customer table.
Issued_book_name: Name of the issued book.
Issue_date: Date when the book was issued.
Isbn_book (FOREIGN KEY): References the ISBN in the Books table.
ReturnStatus Table:
Return_Id (PRIMARY KEY): Unique identifier for each book return transaction.
Return_cust: Identifier for the customer returning the book.
Return_book_name: Name of the returned book.
Return_date: Date when the book was returned.
Isbn_book2 (FOREIGN KEY): References the ISBN in the Books table.
