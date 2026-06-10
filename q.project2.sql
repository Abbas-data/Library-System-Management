

select *from books;
select *from branch;
select *from employees;
select *from issued_status;
select *from return_status;
select *from members;

-- Project Tast

--Q.1 Create a new book record --'978-1-60129-2','to kill a mockingirb', 'Classic',6.00,'yes','harper lee','J.B. lippincott & co.')

insert into books(isbn,book_title,category,rental_price,status,author,publisher)
values ('978-1-60129-456-2', 'to kill a mockingirb', 'Classic', 6.00, 'yes' ,'harper lee', 'J.B. lippincott & co.');
select * from books

--Q.2 Update an existing Member's Address.

UPDATE MEMBERS
SET
	MEMBER_ADDRESS = ' 125 Main St'
WHERE
	MEMBER_ID = 'C101'
SELECT
	*
FROM
	MEMBERS
--Q.3 delete a record from the issued status table 
  --Objective: Delete the record with issued_id = 'IS104' from the issued_status table.
DELETE FROM ISSUED_STATUS
WHERE
	ISSUED_ID = 'IS104' 

--Q.4 Retrive all books issued by a Specific employee
-- objective: select all books issued by the employee with emp_id ='E101'. 

SELECT
	*
FROM
	ISSUED_STATUS
WHERE
	ISSUED_EMP_ID = 'E101';	
	
--Q.5 List member who have issued more than one book  
--Objective :use group by to find member who have issued more than one book.

SELECT
	ISSUED_EMP_ID
FROM
	ISSUED_STATUS
GROUP BY
	ISSUED_EMP_ID
HAVING
	COUNT(ISSUED_EMP_ID) > 1

--Q.6 Create Summary Table: Used CTAS to generate new tables based on query results 
-- each book and total book_issued_cnt.

CREATE TABLE BOOK_CNT AS
SELECT
	B.ISBN,
	B.BOOK_TITLE,
	COUNT(IST.ISSUED_ID) AS NO_ISUED
FROM
	BOOKS AS B
	JOIN ISSUED_STATUS AS IST ON IST.ISSUED_BOOK_ISBN = B.ISBN
GROUP BY
	1,
	2

--Q.7 Retrieve All Books in a specific category.
SELECT
	*
FROM
	BOOKS
WHERE
	CATEGORY = 'Literary Fiction'

--Q.8 Find Total Rental Income By Category.
SELECT
	CATEGORY,
	SUM(RENTAL_PRICE) AS TO_RE_IN_,
	COUNT(*)
FROM
	BOOKS
GROUP BY
	CATEGORY
 --Q.9 list employees with their branch Manager's Name and their branch details.
SELECT
	*
FROM
	EMPLOYEES AS EL
	JOIN BRANCH AS B ON B.BRANCH_ID = EL.BRANCH_ID
	JOIN EMPLOYEES AS E2 ON B.MANAGER_ID = E2.EMP_ID

--Q.10 Create table of books with retail price above a certain 7usd.

create table books_price_gr
as
select * from books where rental_price > 7
select * from books_price_gr

--Q.11 retrieve the list of books not yet returned

SELECT
	*
FROM
	ISSUED_STATUS
	LEFT JOIN RETURN_STATUS ON ISSUED_STATUS.ISSUED_ID = RETURN_STATUS.ISSUED_ID
WHERE
	RETURN_STATUS.RETURN_ID IS NULL

  INSERT INTO issued_status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id)
VALUES
('IS151', 'C118', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL '24 days',  '978-0-553-29698-2', 'E108'),
('IS152', 'C119', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL '13 days',  '978-0-553-29698-2', 'E109'),
('IS153', 'C106', 'Pride and Prejudice', CURRENT_DATE - INTERVAL '7 days',  '978-0-14-143951-8', 'E107'),
('IS154', 'C105', 'The Road', CURRENT_DATE - INTERVAL '32 days',  '978-0-375-50167-0', 'E101');

 -- Adding new column in return_status

ALTER TABLE return_status
ADD Column book_quality VARCHAR(15) DEFAULT('Good');

UPDATE return_status
SET book_quality = 'Damaged'
WHERE issued_id 
    IN ('IS112', 'IS117', 'IS118');
SELECT * FROM return_status;

/* Q.12 Identify Members with Overdue Books Write a query to
identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue*/

SELECT
	MEMBER_ID,
	MEMBER_NAME,
	ISSUED_DATE,
	ISSUED_BOOK_NAME AS BOOK_TITLE,
	CURRENT_DATE - ISSUED_STATUS.ISSUED_DATE AS OVER_DUES_DAYS
FROM
	MEMBERS
	JOIN ISSUED_STATUS ON MEMBERS.MEMBER_ID = ISSUED_STATUS.ISSUED_MEMBER_ID

