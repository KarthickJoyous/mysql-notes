/*
Summary: Understanding LEFT JOIN Before Writing a Query

When writing queries involving multiple tables, understanding relationships and data dependencies is crucial to decide where LEFT JOIN is required:

    Analyze Relationships:
        Identify how tables are related (e.g., users ↔ orders, orders ↔ products).
        Determine if some data might be missing in the related tables (e.g., users without orders, orders without products).

    Define Requirements:
        Do you need all users, regardless of whether they have orders? Use LEFT JOIN for users ↔ orders.
        Should all products exist in the result? Use an INNER JOIN with the products table to enforce this.

    Simulate Missing Data:
        Think about scenarios like a user with no orders or an order with no products. If you must include such cases, use LEFT JOIN.
        If you want to exclude such cases, use INNER JOIN.

    Rule of Propagation:
        In a LEFT JOIN chain, if a match fails at one join, all subsequent joins will result in NULL. Ensure this behavior aligns with your requirements.

    Validate Cascading Conditions:
        Use WHERE clauses carefully to include/exclude specific cases. For instance, WHERE op.product_id IS NULL OR p.id IS NOT NULL ensures all users are included, but only valid products are shown.

By understanding relationships and simulating edge cases, you can structure LEFT JOIN queries effectively to meet the requirements.
*/

/*

Scenario 1: User Without Orders

    users is included.
    orders, order_products, products, and categories columns will all be NULL.

Scenario 2: Order Without Order Products

    User and order details are included.
    order_products, products, and categories columns will be NULL.

Scenario 3: Product Without a Category

    User, order, and product details are included.
    categories columns will be NULL.
    
*/

/*
    Return all users with details of order(with/without), product, category.
*/
SELECT 
    u.user_id,
    u.username,
    op.product_id,
    p.name AS "Product",
    p.category_id,
    c.name AS "Category",
    op.order_id,
    o.order_amount,
    o.order_date
FROM users AS u
LEFT JOIN orders AS o ON u.user_id = o.user_id
LEFT JOIN order_products AS op ON o.order_id = op.order_id
LEFT JOIN products AS p ON op.product_id = p.id
LEFT JOIN categories AS c ON p.category_id = c.id;

/*
    Return all users with details of order(with), product, category.
    Return product even don't have category.
*/
SELECT
    u.user_id AS user_id,
    u.username AS username,
    u.email AS email,
    o.order_id AS order_id,
    o.order_amount AS order_amount,
    o.order_date AS order_date,
    p.name AS product_name,
    p.category_id AS category_id,
    c.name AS category_name,
    op.id AS order_product_id
FROM
    users u
INNER JOIN orders o ON u.user_id = o.user_id
INNER JOIN order_products op ON o.order_id = op.order_id
INNER JOIN products p ON op.product_id = p.id
LEFT JOIN categories c ON p.category_id = c.id;