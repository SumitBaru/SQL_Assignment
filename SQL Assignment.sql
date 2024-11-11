create  database project;
use project;

-- 1
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY NOT NULL,
    emp_name VARCHAR(100) NOT NULL,
    age INTEGER CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000
);


-- 2
-- Constraints are rules applied to database columns to ensure data integrity, maintaining accuracy, consistency, and reliability of data across the database. They help prevent errors by restricting the type and range of data that can be entered, making databases more robust and dependable. Here are some common constraints with examples:
-- Primary Key: Ensures each row in a table is unique by assigning a unique identifier. For example, emp_id INTEGER PRIMARY KEY in an employees table guarantees that no two rows will have the same emp_id, making each record easily identifiable.
-- Not Null: Enforces that a column cannot contain NULL values. This is useful for essential fields. For instance, emp_name VARCHAR(100) NOT NULL ensures every employee in the employees table has a name.
-- Unique: Prevents duplicate values in a column. This is commonly used for attributes like email addresses. For example, email VARCHAR(255) UNIQUE ensures each email is unique in the employees table, preventing duplicate emails.
-- Check: Sets a condition that each entry must meet, helping ensure data quality. For example, age INTEGER CHECK (age >= 18) ensures that all employees are at least 18 years old.
-- Default: Provides a standard value for a column when none is specified. For instance, salary DECIMAL(10, 2) DEFAULT 30000 in the employees table sets a default salary of 30,000 for new records unless another salary is provided.
-- Foreign Key: Creates a link between two tables by referencing a primary key in another table, maintaining referential integrity. For example, if department_id in employees references department_id in a departments table, the foreign key constraint ensures every employee’s department exists in departments.


-- 3
-- The NOT NULL constraint is applied to a column when it is essential that every record has a valid value in that column. This constraint ensures that no record can be inserted without a value in the specified field, which is particularly important for columns that store critical information, such as names, dates, or IDs. For example, applying NOT NULL to an emp_name column in an employees table ensures that each employee has a name, preventing incomplete data entries.
-- A primary key cannot contain NULL values because it uniquely identifies each row in a table. Allowing NULL in a primary key would violate this principle, as NULL represents an unknown or missing value, which cannot serve as a unique identifier. A primary key must have a unique and non-null value for each record to ensure data integrity and make each record accessible by a distinct identifier.


-- 4
-- To modify constraints on an existing table, you can use ALTER TABLE commands to add or remove constraints. Here are the steps and SQL commands for each:

-- i> Adding a Constraint
-- Identify the Table: Determine which table and column the constraint will apply to.
-- Use ALTER TABLE Command: Add the constraint using ADD CONSTRAINT for named constraints, or specify the constraint directly if it’s a NOT NULL constraint.
-- Example: Adding a Unique Constraint.

ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

-- ii> Removing a Constraint
-- Identify the Constraint Name: You’ll need the name of the constraint to remove it. Constraints often have names like unique_email or pk_emp_id.
-- Use ALTER TABLE Command: Use DROP CONSTRAINT to remove the constraint by name.
-- Example: Removing the Unique Constraint

ALTER TABLE employees
DROP CONSTRAINT unique_email;

-- iii> Note on Removing NOT NULL Constraints
-- To remove a NOT NULL constraint, use MODIFY:

ALTER TABLE employees
MODIFY emp_name VARCHAR(100) NULL;


-- 5
-- In SQL, violating constraints during INSERT, UPDATE, or DELETE operations results in an error, preventing the operation from being executed and maintaining data integrity.

-- INSERT: Trying to insert a NULL value in a NOT NULL column:
INSERT INTO employees (emp_id, emp_name, email) VALUES (NULL, 'John Doe', 'john.doe@example.com');

-- Error:
-- ERROR 1048 (23000): Column 'emp_id' cannot be null

-- UPDATE: Trying to update a column to a duplicate value in a UNIQUE column:
UPDATE employees SET email = 'existing.email@example.com' WHERE emp_id = 2;

-- Error:
-- ERROR 1062 (23000): Duplicate entry 'existing.email@example.com' for key 'unique_email'

-- DELETE: Attempting to delete a row that is referenced by a foreign key:
DELETE FROM departments WHERE department_id = 1;

-- Error:
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`employees`, CONSTRAINT `fk_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`))


-- 6
CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));
    
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;


-- 7
SELECT s.student_name, c.class_name
FROM Students s
INNER JOIN classes c ON s.class_id = c.class_id;


-- 8
SELECT o.order_id, c.customer_name, p.product_name
FROM products p
LEFT JOIN Orders o ON p.order_id = o.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 9
SELECT p.product_name, SUM(s.amount) AS total_sales_amount
FROM Sales s
INNER JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;


-- 10
SELECT o.order_id, c.customer_name, od.quantity
FROM Orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id;


                                               -- SQL Commands
  use mavenmovies;    
  
-- 1
SELECT
    t.TABLE_NAME AS table_name,
    k.COLUMN_NAME AS primary_key_column
FROM
    information_schema.KEY_COLUMN_USAGE k
    JOIN information_schema.TABLES t
        ON k.TABLE_NAME = t.TABLE_NAME
WHERE
    k.CONSTRAINT_NAME = 'PRIMARY'
    AND t.TABLE_SCHEMA = 'mavenmovies'
ORDER BY
    t.TABLE_NAME, k.ORDINAL_POSITION;
    
SELECT
    kcu1.TABLE_NAME AS table_name,
    kcu1.COLUMN_NAME AS foreign_key_column,
    kcu2.TABLE_NAME AS referenced_table,
    kcu2.COLUMN_NAME AS referenced_column
FROM
    information_schema.KEY_COLUMN_USAGE kcu1
    JOIN information_schema.KEY_COLUMN_USAGE kcu2
        ON kcu1.REFERENCED_TABLE_NAME = kcu2.TABLE_NAME
        AND kcu1.REFERENCED_COLUMN_NAME = kcu2.COLUMN_NAME
WHERE
    kcu1.CONSTRAINT_NAME <> 'PRIMARY'
    AND kcu1.TABLE_SCHEMA = 'mavenmovies'
ORDER BY
    kcu1.TABLE_NAME, kcu1.COLUMN_NAME;

-- differences
-- Purpose: A primary key uniquely identifies each record in its own table, ensuring each row is distinct. A foreign key, on the other hand, is used to establish a relationship between two tables by referencing the primary key in another table.

-- Uniqueness: Primary keys must have unique values, meaning no two rows can share the same primary key. Foreign keys can have duplicate values, as they may reference the same record in the related table multiple times.

-- Nullability: Primary keys cannot contain NULL values, as every record must be identifiable. Foreign keys may allow NULLs if a relationship is optional, indicating that a specific relationship is not mandatory for a record.

-- Relationship Enforcement: Primary keys define the identity of records within their table, while foreign keys enforce referential integrity between tables, ensuring that values match valid entries in the related table.

-- Scope: Primary keys are contained within a single table and do not interact directly with other tables. Foreign keys are cross-referenced and depend on another table, linking related data across the database structure.


-- 2
select * from actor;


-- 3
select * from customer;

-- 4
SELECT DISTINCT country
FROM country;

-- 5
SELECT *
FROM customer
WHERE active = 1;

-- 6
SELECT rental_id
FROM rental
WHERE customer_id = 1;

-- 7
SELECT *
FROM film
WHERE rental_duration > 5;

-- 8
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

-- 9
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;

-- 10
SELECT *
FROM customer
LIMIT 10;

-- 11
SELECT *
FROM customer
WHERE first_name LIKE 'B%'
LIMIT 3;

-- 12
SELECT title
FROM film
WHERE rating = 'G'
LIMIT 5;

-- 13
SELECT *
FROM customer
WHERE first_name LIKE 'A%';

-- 14
SELECT *
FROM customer
WHERE first_name LIKE '%A';

-- 15
SELECT city
FROM city
WHERE city LIKE 'A%A'
LIMIT 4;

-- 16
SELECT *
FROM customer
WHERE first_name LIKE '%NI%';

-- 17
SELECT *
FROM customer
WHERE first_name LIKE '_r%';

-- 18
SELECT *
FROM customer
WHERE first_name LIKE 'A%' 
AND LENGTH(first_name) >= 5;

-- 19
SELECT *
FROM customer
WHERE first_name LIKE 'A%O';

-- 20
SELECT *
FROM film
WHERE rating IN ('PG', 'PG-13');

-- 21
SELECT *
FROM film
WHERE length BETWEEN 50 AND 100;

-- 22
SELECT *
FROM actor
LIMIT 50;

-- 23
SELECT DISTINCT film_id
FROM inventory;


											-- Functions--
use sakila;

-- 1
SELECT COUNT(*) AS total_rentals
FROM rental;

-- 2
SELECT AVG(DATEDIFF(return_date, rental_date)) AS average_rental_duration_per_day
FROM rental
WHERE return_date IS NOT NULL;

-- 3
SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS last_name_upper
FROM customer;

-- 4
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

-- 5
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

-- 6
SELECT store_id, SUM(payment.amount) AS total_revenue
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
GROUP BY store_id;

-- 7
SELECT c.name AS category_name, COUNT(*) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id;

-- 8
SELECT l.name AS language_name, AVG(f.rental_rate) AS average_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.language_id;

                                           -- Joins --
 -- 9
 SELECT f.title, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

-- 10
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

-- 11
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN rental r ON p.rental_id = r.rental_id
GROUP BY c.customer_id;

-- 12
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
ORDER BY c.first_name, c.last_name;

-- 13
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 5;

-- 14
SELECT c.customer_id, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;


                                                   -- Windows Function --
-- 1
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS rank_
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY rank_;


-- 2
SELECT f.title,
       r.rental_date,
       SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.film_id, r.rental_date;


-- 3
SELECT 
    CASE 
        WHEN f.length <= 60 THEN 'Short'
        WHEN f.length BETWEEN 61 AND 120 THEN 'Medium'
        WHEN f.length > 120 THEN 'Long'
    END AS film_length_category,
    AVG(f.rental_duration) AS avg_rental_duration
FROM film f
GROUP BY film_length_category
ORDER BY film_length_category;


-- 4
WITH FilmRentals AS (
    SELECT 
        f.film_id,
        f.title,
        fc.category_id,
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY f.film_id, c.category_id
),
RankedFilms AS (
    SELECT 
        film_id,
        title,
        category_name,
        rental_count,
        RANK() OVER (PARTITION BY category_name ORDER BY rental_count DESC) AS rank_
    FROM FilmRentals
)
SELECT 
    film_id,
    title,
    category_name,
    rental_count,
    rank_
FROM RankedFilms
WHERE rank_ <= 3
ORDER BY category_name, rank_;


-- 5
WITH CustomerRentals AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        COUNT(r.rental_id) AS total_rentals
    FROM customer c
    LEFT JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id
),
AverageRentals AS (
    SELECT 
        AVG(total_rentals) AS avg_rentals
    FROM CustomerRentals
)
SELECT 
    cr.customer_id,
    cr.first_name,
    cr.last_name,
    cr.total_rentals,
    ar.avg_rentals,
    cr.total_rentals - ar.avg_rentals AS rental_difference
FROM CustomerRentals cr
CROSS JOIN AverageRentals ar
ORDER BY rental_difference DESC;


-- 6
SELECT 
    YEAR(r.rental_date) AS rental_year,
    MONTH(r.rental_date) AS rental_month,
    SUM(p.amount) AS total_revenue
FROM rental r
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY rental_year, rental_month
ORDER BY rental_year, rental_month;


-- 7
 WITH TotalSpending AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spent
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
),
RankedSpending AS (
    SELECT 
        customer_id,
        first_name,
        last_name,
        total_spent,
        NTILE(5) OVER (ORDER BY total_spent DESC) AS spending_percentile
    FROM TotalSpending
)
SELECT 
    customer_id,
    first_name,
    last_name,
    total_spent
FROM RankedSpending
WHERE spending_percentile = 1
ORDER BY total_spent DESC;


-- 8
WITH CategoryRentals AS (
    SELECT 
        cat.category_id,
        cat.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    GROUP BY cat.category_id, cat.name
)
SELECT 
    category_name,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM CategoryRentals
ORDER BY rental_count DESC;


-- 9
WITH FilmRentalCounts AS (
    SELECT 
        f.film_id,
        f.title,
        cat.category_id,
        cat.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    JOIN film f ON f.film_id = i.film_id
    GROUP BY f.film_id, cat.category_id, cat.name
),
CategoryAvgRentalCounts AS (
    SELECT 
        category_id,
        AVG(rental_count) AS avg_rental_count
    FROM FilmRentalCounts
    GROUP BY category_id
)
SELECT 
    fr.film_id,
    fr.title,
    fr.category_name,
    fr.rental_count,
    ca.avg_rental_count
FROM FilmRentalCounts fr
JOIN CategoryAvgRentalCounts ca ON fr.category_id = ca.category_id
WHERE fr.rental_count < ca.avg_rental_count
ORDER BY fr.rental_count ASC;


-- 10
SELECT 
    DATE_FORMAT(p.payment_date, '%Y-%m') AS month_year,
    SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY month_year
ORDER BY total_revenue DESC
LIMIT 5;


                                                      -- Normalisation & CTE --
 -- 1
 -- One possible table that might violate 1NF in a normalized form is the film_category table, which stores data about films and their categories.
 -- To bring a table like film_category into 1NF, we must remove any columns that contain non-atomic values (like lists or sets) and restructure the data to ensure that each column contains only single, indivisible values.

-- 2
-- The rental table in Sakila contains the following columns: rental_id (Primary Key), rental_date, inventory_id (Foreign Key), customer_id (Foreign Key), return_date, staff_id (Foreign Key), and last_update. Since the primary key of this table is rental_id, we can use it to assess functional dependencies and check for potential normalization issues.
-- The first step in achieving 2NF is ensuring that the table meets the requirements for First Normal Form (1NF). For a table to be in 1NF, it must have a primary key, and each column should contain only atomic values—meaning there should be no repeating groups or arrays within any column. In the rental table, each column contains atomic values, and each row is uniquely identifiable by the primary key, rental_id, which means it complies with 1NF.
-- To be in 2NF, a table must not only be in 1NF but also avoid partial dependencies. This means there should be no situation where a non-key attribute is dependent on only a part of a composite primary key. In the case of the rental table, since rental_id is a single-column primary key, partial dependencies don’t apply here. Nonetheless, we should still examine whether there are any dependencies where non-key attributes depend on other non-key columns. In our analysis, we find that rental_date, return_date, customer_id, inventory_id, and staff_id are all fully dependent on the primary key rental_id, indicating that no partial dependency exists. Therefore, the table meets 2NF requirements.
-- If hypothetically, the rental table did violate 2NF due to partial dependencies, we would need to normalize it. In that case, we would start by identifying any columns that have dependencies on only part of a composite primary key. Next, we would create a new table for these partially dependent columns, using the attribute they depend on as the primary key in the new table, along with any related attributes. Finally, we would link the new tables with foreign keys to maintain the relationships and eliminate redundancy. However, since the rental table has a single-column primary key and no partial dependencies, it already meets 2NF without further normalization steps.


-- 3
-- The address table contains the columns: address_id (Primary Key), address, address2, district, city_id (Foreign Key), postal_code, phone, and last_update. The address table also has a relationship with the city table, referenced by the city_id foreign key
-- To verify whether the address table violates 3NF, we first need to understand the functional dependencies within the table. For a table to be in 3NF, it must meet the requirements for Second Normal Form (2NF) and also contain no transitive dependencies. A transitive dependency occurs when a non-key attribute depends on another non-key attribute, rather than directly on the primary key. In the address table, columns such as address, address2, district, postal_code, and phone are directly dependent on the primary key address_id. However, city_id is a foreign key that references the city table, which stores additional information about the city and links to a country_id.
-- The column city_id in the address table indirectly determines both the city name and the country via the city and country tables. For instance, address_id determines city_id, and city_id in turn determines the city’s name and associated country. This creates a transitive dependency, where non-key information (such as city name or country) depends on city_id rather than directly on address_id, leading to a 3NF violation.
-- To eliminate this violation and bring the table into 3NF, we need to break down the transitive dependency by restructuring the data. First, we should separate any information related to the city into the city table, ensuring that the address table does not store or depend on city and country details indirectly. The address table should only retain address_id, address, address2, district, city_id, postal_code, phone, and last_update, with city_id referencing the city table. This allows the city and country details to be stored independently in the city table without a transitive dependency.
-- With this normalization step, the address table would comply with 3NF requirements. Now, each non-key attribute depends solely on the primary key, address_id, and there are no transitive dependencies on other non-key attributes. By structuring the tables in this way, we achieve a cleaner and more efficient design that maintains data integrity and minimizes redundancy.

-- 4
-- In the initial unnormalized form (0NF), data in the payment table lacks a structured format. Each row might contain all payment details concatenated into a single text string, without distinct columns. For example, one column might store values like payment_id:1, customer_id:3, staff_id:2, rental_id:4, amount:5.99, payment_date:2023-11-11. In this structure, each row represents all data for a payment, but without separation into columns. This format lacks atomicity, meaning fields are not broken down into the smallest possible values, making querying and managing the data challenging.
-- To bring the table into First Normal Form (1NF), we need to ensure that each field contains atomic values and that each row is uniquely identifiable. We achieve this by separating each data element into distinct columns and adding a primary key, payment_id, to uniquely identify each row. The resulting table structure now has columns for payment_id, customer_id, staff_id, rental_id, amount, and payment_date. In this format, each column contains a single, atomic value, ensuring that the table meets 1NF requirements. Additionally, by using payment_id as the primary key, each row is distinct, preventing duplicate entries.
-- To progress to Second Normal Form (2NF), the table must already be in 1NF and have no partial dependencies. Partial dependencies occur when a non-key attribute is dependent on only part of a composite primary key. In the payment table, however, payment_id is a single-column primary key, so there is no composite key. This means that partial dependencies are not possible in this case. Each non-key attribute—customer_id, staff_id, rental_id, amount, and payment_date—fully depends on payment_id, ensuring that the table adheres to 2NF requirements.
-- In summary, we normalized the payment table through the following steps. First, in its unnormalized form, data was stored in a single column, with all payment details concatenated, lacking atomicity and consistency. Next, to achieve 1NF, we separated data into individual columns and introduced payment_id as a primary key to uniquely identify each row. Finally, to achieve 2NF, we verified that no partial dependencies existed, as each non-key attribute was fully dependent on the single-column primary key payment_id.
-- Through this normalization process, we structured the payment table up to 2NF, ensuring minimal redundancy and clear relationships between data fields. Further normalization to Third Normal Form (3NF) would involve analyzing for any transitive dependencies—dependencies between non-key attributes—and resolving them if present. Up to 2NF, however, the table is efficiently organized, reducing redundancy and ensuring data integrity.

-- 5
WITH actor_film_count AS (
    SELECT 
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM 
        actor a
    JOIN 
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY 
        a.actor_id, a.first_name, a.last_name
)
SELECT 
    actor_name,
    film_count
FROM 
    actor_film_count
ORDER BY 
    film_count DESC;


-- 6
WITH film_language_info AS (
    SELECT 
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM 
        film f
    JOIN 
        language l ON f.language_id = l.language_id
)
SELECT 
    film_title,
    language_name,
    rental_rate
FROM 
    film_language_info
ORDER BY 
    film_title;


-- 7
WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM 
        customer c
    JOIN 
        payment p ON c.customer_id = p.customer_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name
)
SELECT 
    customer_name,
    total_revenue
FROM 
    customer_revenue
ORDER BY 
    total_revenue DESC;


-- 8
WITH film_ranking AS (
    SELECT 
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank
    FROM 
        film
)
SELECT 
    title,
    rental_duration,
    rental_rank
FROM 
    film_ranking
ORDER BY 
    rental_rank;


-- 9
WITH rental_count AS (
    SELECT 
        p.customer_id,
        COUNT(p.rental_id) AS rental_count
    FROM 
        payment p
    GROUP BY 
        p.customer_id
    HAVING 
        COUNT(p.rental_id) > 2
)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    rc.rental_count
FROM 
    rental_count rc
JOIN 
    customer c ON rc.customer_id = c.customer_id
ORDER BY 
    rc.rental_count DESC;


-- 10
WITH monthly_rentals AS (
    SELECT 
        YEAR(r.rental_date) AS rental_year,
        MONTH(r.rental_date) AS rental_month,
        COUNT(r.rental_id) AS total_rentals
    FROM 
        rental r
    GROUP BY 
        YEAR(r.rental_date), MONTH(r.rental_date)
)
SELECT 
    rental_year,
    rental_month,
    total_rentals
FROM 
    monthly_rentals
ORDER BY 
    rental_year DESC, rental_month DESC;


-- 11
WITH actor_pairs AS (
    SELECT 
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        fa1.film_id
    FROM 
        film_actor fa1
    JOIN 
        film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE 
        fa1.actor_id < fa2.actor_id
)
SELECT 
    a1.first_name || ' ' || a1.last_name AS actor1_name,
    a2.first_name || ' ' || a2.last_name AS actor2_name,
    ap.film_id
FROM 
    actor_pairs ap
JOIN 
    actor a1 ON ap.actor1_id = a1.actor_id
JOIN 
    actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY 
    actor1_name, actor2_name;
select * from staff;


-- 12
ALTER TABLE staff
ADD COLUMN reports_to INT;
UPDATE staff 
SET reports_to = 1 
WHERE staff_id IN (2, 3, 4);
WITH RECURSIVE staff_hierarchy AS (
    SELECT 
        staff_id,
        CONCAT(first_name, ' ', last_name) AS employee_name,
        reports_to
    FROM 
        staff
    WHERE 
        staff_id = 1  
    
    UNION ALL
    SELECT 
        s.staff_id,
        CONCAT(s.first_name, ' ', s.last_name) AS employee_name,
        s.reports_to
    FROM 
        staff s
    JOIN 
        staff_hierarchy sh ON s.reports_to = sh.staff_id
    WHERE 
        s.staff_id != sh.staff_id  
)
SELECT 
    employee_name
FROM 
    staff_hierarchy
WHERE 
    staff_id != 1  
ORDER BY 
    employee_name;



































