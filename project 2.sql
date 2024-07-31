use organisation;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, '123 Main St, City A', '123-456-7890'),
(2, 102, '456 Elm St, City B', '234-567-8901'),
(3, 103, '789 Oak St, City C', '345-678-9012');

select * from branch;


CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(255),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(101, 'Alice Johnson', 'Manager', 75000, 1),
(102, 'Bob Smith', 'Manager', 70000, 2),
(103, 'Carol White', 'Manager', 68000, 3),
(104, 'David Brown', 'Assistant', 50000, 1),
(105, 'Eve Davis', 'Librarian', 45000, 2);

select * from Employee;




CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(255),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3), -- 'Yes' for available, 'No' for not available
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('148410-0', 'Introduction to Algorithms', 'Computer Science', 30.00, 'Yes', 'Thomas H. Cormen', 'MIT Press'),
('352332-3', 'Database System Concepts', 'Database', 25.00, 'No', 'Abraham Silberschatz', 'McGraw-Hill'),
('909-4', 'The History of the Ancient World', 'History', 20.00, 'Yes', 'Susan Wise Bauer', 'W.W. Norton & Company'),
('110362-7', 'The C Programming Language', 'Programming', 15.00, 'Yes', 'Brian W. Kernighan', 'Prentice Hall'),
('06338-9', 'Python for Data Analysis', 'Data Science', 28.00, 'No', 'Wes McKinney', 'O\'Reilly Media');




CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(201, 'John Doe', '789 Pine St, City A', '2021-05-10'),
(202, 'Jane Smith', '456 Maple St, City B', '2022-01-01'),
(203, 'Michael Johnson', '123 Cedar St, City C', '2021-12-20'),
(204, 'Emily Davis', '321 Birch St, City A', '2020-11-30'),
(205, 'William Brown', '654 Oak St, City B', '2023-06-05');





CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(1300),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(301, 201, 'Database System Concepts', '2023-07-01', '352332-3'),
(302, 202, 'Python for Data Analysis', '2023-06-15', '06338-9'),
(303, 203, 'Introduction to Algorithms', '2023-05-20', '148410-0'),
(304, 204, 'The C Programming Language', '2023-06-10', '110362-7');




CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(13),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);


INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(401, 201, 'Database System Concepts', '2023-07-15', '352332-3'),
(402, 202, 'Python for Data Analysis', '2023-06-25', '06338-9'),
(403, 203, 'Introduction to Algorithms', '2023-06-10', '148410-0'),
(404, 204, 'The C Programming Language', '2023-07-05', '110362-7');


SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'Yes';

SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;

SELECT B.Book_title, C.Customer_name 
FROM IssueStatus I
JOIN Books B ON I.Isbn_book = B.ISBN
JOIN Customer C ON I.Issued_cust = C.Customer_Id;


SELECT Category, COUNT(*) AS Total_Count 
FROM Books 
GROUP BY Category;


SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;

SELECT Customer_name 
FROM Customer C
LEFT JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE Reg_date < '2022-01-01' AND I.Issue_Id IS NULL;

SELECT Branch_no, COUNT(*) AS Employee_Count 
FROM Employee 
GROUP BY Branch_no;

SELECT DISTINCT C.Customer_name 
FROM IssueStatus I
JOIN Customer C ON I.Issued_cust = C.Customer_Id
WHERE I.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%history%';

SELECT Branch_no, COUNT(*) AS Employee_Count 
FROM Employee 
GROUP BY Branch_no
HAVING COUNT(*) > 5;


SELECT E.Emp_name, B.Branch_address 
FROM Employee E
JOIN Branch B ON E.Emp_Id = B.Manager_Id;


SELECT DISTINCT C.Customer_name 
FROM IssueStatus 
JOIN Books B ON I.Isbn_book = B.ISBN
JOIN Customer C ON I.Issued_cust = C.Customer_Id
WHERE B.Rental_Price > 25;


















