-- Exploratory data analysis project

-- Let's find information about the items (prices, shipping statuses and users who bought them)

	SELECT * FROM line_items;

-- Let's display the top 10 most expensive items;

	SELECT * FROM line_items
	ORDER BY price DESC LIMIT 10;

-- Now let's filter by a specific purchase status of an item in ascending order

	SELECT * FROM line_items
	WHERE status ILIKE '%shipped'
	ORDER BY price;

-- Let's add another condition to the previous query to see
-- the quantity of the items with that status

	SELECT * FROM line_items
	WHERE status ILIKE '%shipped' AND quantity > 5;
	
-- 5. We can also find the total dollar value 
-- of all items with status 'shipped'.
	
	 SELECT SUM(price*quantity) FROM line_items
	 WHERE status = 'shipped'
	 
-- 	  Let's see now the total number of each product_id sold, this means we
--    have to exclude the product_id's with status returned and canceled
    
	  SELECT product_id, SUM(quantity) AS total_sold
	  FROM line_items
	  WHERE status != 'returned' AND status != 'canceled'
	  GROUP BY product_id
	  ORDER BY total_sold DESC;
	  
--    We can also categorize the orders as sold or not sold

	  SELECT product_id, status,
         CASE
            WHEN status IN ('pending','shipped') THEN 'Sold'
            ELSE 'Not sold'
         END AS  purchase_status
      FROM line_items
      ORDER BY purchase_status DESC;
	
-- Let's show some aggregate measures of this table
   
	SELECT max(price), min(price), avg(price) FROM line_items
	
-- We can also check which items have a bigger price than the average
	
	SELECT * FROM line_items
    WHERE price > (SELECT avg(price) FROM line_items);
	
-- Let's see now
	
-- Now let's for example extract the name and email of people who purchased a line_item worth $700 or more.
-- Since the line_items table doesn't contain this information we have to join it with 
-- the orders and users table to extract this information 
	
	 SELECT * FROM line_items li
   	 JOIN orders o
   	 ON li.order_id = o.order_id
   	 JOIN users u
   	 ON o.user_id = u.user_id;
	
	SELECT name, email FROM line_items li
   	JOIN orders o ON li.order_id = o.order_id
   	JOIN users u ON o.user_id = u.user_id
   	WHERE li.price * li.quantity >= 700
	





