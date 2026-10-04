CREATE DATABASE swiggy_db;

USE swiggy_db;

CREATE TABLE swiggy(
	restaurant_no INT NOT NULL,
    restaurant_name VARCHAR(50) NOT NULL,
    city VARCHAR(10) NOT NULL,
    address VARCHAR(250),
    rating DECIMAL(3,1) NOT NULL,
    cost_per_person INT,
    cuisine VARCHAR(100) NOT NULL,
    restaurant_link VARCHAR(200) NOT NULL,
    menu_category VARCHAR(100),
    item VARCHAR(200),
    price VARCHAR(20) NOT NULL,
    veg_or_nonveg VARCHAR(10)
);

-- 1. How many restaurants have a rating greater than 4.5?
SELECT COUNT(DISTINCT restaurant_no) AS high_rated_restaurants
FROM swiggy
WHERE rating > 4.5;

-- 2. Which city has the highest number of restaurants?
SELECT city,COUNT(DISTINCT restaurant_name) AS restaurant_count
FROM swiggy
GROUP BY city
ORDER BY restaurant_count DESC LIMIT 1;

-- 3. How many restaurants have the word pizza in their name ?
SELECT COUNT(DISTINCT restaurant_name) AS pizza_restaurants
FROM swiggy
WHERE restaurant_name LIKE '%pizza%';

-- 4. What is the most common cuisine among the restaurants?
SELECT cuisine, COUNT(cuisine) AS cuisine_count
FROM swiggy
GROUP BY cuisine
ORDER BY cuisine_count DESC LIMIT 1;

-- 5. What is the average rating of restaurants in each city ?
SELECT city, AVG(rating) AS average_rating
FROM swiggy
GROUP BY city;

-- 6. What is the highest-priced item under the 'recommended' menu category for each restaurant?
SELECT restaurant_name, MAX(price) AS highest_price
FROM swiggy
WHERE menu_category = 'recommended'
GROUP BY restaurant_name;

-- 7. Find the top 5 most expensive restaurants that offer cuisines other than Indian?
SELECT distinct restaurant_name, cost_per_person
FROM swiggy
WHERE cuisine != 'Indian'
ORDER BY cost_per_person DESC LIMIT 5;

-- 8. Which restaurant provides the lowest average price for all items ?
SELECT restaurant_name,AVG(cost_per_person) AS avg_price
FROM swiggy
GROUP BY restaurant_name
ORDER BY avg_price LIMIT 1;

-- 9. Which restaurant offers the most items in the 'main course' category ?
SELECT restaurant_name, COUNT(item) AS no_of_items
FROM swiggy
WHERE menu_category = 'Main Course'
GROUP BY restaurant_name
ORDER BY no_of_items DESC LIMIT 1;

-- 10. Find restaurants whose average cost is higher than the overall average cost?
SELECT DISTINCT restaurant_name, cost_per_person
FROM swiggy
WHERE cost_per_person >(SELECT AVG(cost_per_person) FROM swiggy);

-- 11. Retrieve details of restaurants with the same name but located in different cities ?
SELECT DISTINCT t1.restaurant_name, t1.city, t2.city
FROM swiggy AS t1
JOIN swiggy AS t2
ON t1.restaurant_name = t2.restaurant_name
AND t1.city != t2.city;

-- 12. Which top 5 restaurants offer the highest number of categories ?
SELECT restaurant_name, COUNT(DISTINCT menu_category) AS no_of_categories
FROM swiggy
GROUP BY restaurant_name
ORDER BY no_of_categories DESC LIMIT 5;

-- 13. List restaurants that are 100% vegetarian, ordered alphabetically ?
SELECT restaurant_name,
(COUNT(CASE WHEN veg_or_nonveg = 'Veg' THEN 1 END) * 100 / COUNT(*)) AS vegetarian_percentage
FROM swiggy
GROUP BY restaurant_name
HAVING vegetarian_percentage = 100
ORDER BY restaurant_name;

-- 14. Which restaurants provides the highest percentage of non-vegetarian food?
SELECT restaurant_name,
(COUNT(CASE WHEN veg_or_nonveg = 'Non-veg' THEN 1 END) * 100 / COUNT(*)) AS nonvegetarian_percentage
FROM swiggy
GROUP BY restaurant_name
HAVING nonvegetarian_percentage = 100
ORDER BY restaurant_name DESC LIMIT 1;

-- 15. Determine the most expensive and least expensive cities for dining?
WITH city_expense AS (
	SELECT city,
		MAX(cost_per_person) AS max_cost,
        MIN(cost_per_person) AS min_cost
	FROM swiggy
	GROUP BY city
)
SELECT city,max_cost,min_cost
FROM city_expense
ORDER BY max_cost DESC;



SELECT * FROM swiggy;