/*         
From the international breweries data recorded for a duration of three years, you are directed to do the following analyses to aid better decision making in order to maximize profit and reduce loss to the lowest minimum.
Session A
PROFIT ANALYSIS*/
--1. Within the space of the last three years, what was the profit worth of the breweries, inclusive of the anglophone and the francophone territories?--

SELECT countries, SUM(profit) AS Profit_worth
FROM breweries
GROUP BY countries
ORDER BY Profit_worth DESC;

SELECT SUM (profit) AS Profit_Worth,
CASE
    WHEN Countries IN ('Ghana','Nigeria') THEN 'Anglophone'
	ELSE 'Francophone'
END AS Language_Territory
FROM breweries
GROUP BY Language_Territory
ORDER BY Profit_Worth DESC;

--2. Compare the total profit between these two territories in order for the territory manager, Mr. Stone made a strategic decision that will aid profit maximization in 2020.--

SELECT SUM (profit) AS Total_Profit,
CASE
    WHEN Countries IN ('Ghana','Nigeria') THEN 'Anglophone'
	ELSE 'Francophone'
END AS Language_Territory
FROM breweries
GROUP BY Language_Territory
ORDER BY Total_Profit DESC;



--3. Country that generated the highest profit in 2019--
SELECT countries, SUM(profit) AS Profit
FROM breweries
WHERE years = 2019
GROUP BY countries
ORDER BY SUM(profit) DESC;
LIMIT 1

--4. Help him find the year with the highest profit.--

SELECT years, SUM(profit) AS Profit
FROM Breweries
GROUP BY years
ORDER BY SUM(profit) DESC
LIMIT 1

--5. Which month in the three years was the least profit generated?--

SELECT months, years, SUM(profit) AS Profit
FROM breweries
GROUP BY months, years
ORDER BY SUM(profit) ASC
LIMIT 1

--6. What was the minimum profit in the month of December 2018?--
SELECT months, years, profit 
FROM Breweries
WHERE months = 'December' 
AND years = 2018
GROUP BY months, years, profit
ORDER BY profit ASC
LIMIT 1

--7. Compare the profit in percentage for each of the month in 2019-- WURUWURU TO THE ANSWER

SELECT months, SUM(profit), SUM(profit) * 100.0 / SUM(SUM(profit)) OVER () AS percentage
FROM breweries
WHERE years = 2019
GROUP BY months
ORDER BY 3 DESC;

--8. Which particular brand generated the highest profit in Senegal?--

SELECT brands, SUM(profit) AS Profit
FROM Breweries
WHERE countries = 'Senegal'
GROUP BY brands
ORDER BY SUM(profit) DESC
LIMIT 1


/*Session B
BRAND ANALYSIS*/
--1. Within the last two years, the brand manager wants to know the top three brands consumed in the francophone countries--
SELECT brands, SUM(quantity)
FROM breweries
WHERE Countries IN ('Togo','Benin','Senegal')
AND years IN (2018, 2019)
GROUP BY brands
ORDER BY SUM(quantity) DESC
LIMIT 3

--2. Find out the top two choice of consumer brands in Ghana--
SELECT SUM(Quantity),brands
FROM BREWERIES
WHERE countries = 'Ghana'
GROUP BY brands
ORDER BY SUM(quantity) DESC
LIMIT 2

--3. Find out the details of beers consumed in the past three years in the most oil reached (rich) country in West Africa.--
SELECT brands, SUM(profit) AS Profit_earned, SUM(quantity) AS Quantity_Sold
FROM breweries
WHERE countries = 'Nigeria' 
AND brands NOT LIKE '%malt'
GROUP BY 1

			--ALTERNATE ENCOMPASSSING ANSWER (NOT MY PREFERENCE AS ITS NOT STRUCTURED PER SE)--
SELECT * 
FROM breweries
WHERE countries = 'Nigeria' 
AND brands NOT LIKE '%malt'


--4. Favorites malt brand in Anglophone region between 2018 and 2019-- 
SELECT brands, SUM(quantity) AS Quantity_Sold
FROM breweries
WHERE Countries IN ('Nigeria','Ghana')
AND brands ILIKE '%malt'
AND years IN (2018, 2019)
GROUP BY brands
ORDER BY 2 DESC

--5. Which brands sold the highest in 2019 in Nigeria?-- 
SELECT brands, SUM(quantity) AS Sales
FROM breweries
WHERE countries = 'Nigeria'
AND years = 2019
GROUP BY brands
ORDER BY sales DESC

--6. Favorites brand in South_South region in Nigeria--
SELECT brands, SUM(quantity) AS Sales
FROM breweries
WHERE region= 'southsouth'
AND countries = 'Nigeria'
GROUP BY brands
ORDER BY sales DESC

--7. Beer consumption in Nigeria--
SELECT brands, SUM(quantity) AS Total_Quantity_Sold
FROM breweries
WHERE countries = 'Nigeria' 
AND brands NOT LIKE '%malt'
GROUP BY 1

SELECT countries, SUM(quantity) AS Total_Quantity_Sold
FROM breweries
WHERE countries = 'Nigeria' 
AND brands NOT LIKE '%malt'
GROUP BY 1

--8. Level of consumption of Budweiser in the regions in Nigeria--
SELECT region, SUM(quantity) AS Total_Quantity_Sold
FROM breweries
WHERE countries = 'Nigeria' 
AND brands = 'budweiser'
GROUP BY 1


--9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)--
SELECT region, SUM(quantity) AS Consumption_level
FROM breweries
WHERE countries = 'Nigeria' 
AND brands = 'budweiser'
AND years = 2019
GROUP BY 1


/*Session C
1. Country with the highest consumption of beer.*/
SELECT countries, SUM(quantity) AS Total_Quantity
FROM breweries
WHERE brands NOT LIKE '%malt'
GROUP BY countries
ORDER BY 2 DESC
LIMIT 1

SELECT countries, SUM(quantity)
FROM breweries
WHERE brands IN('eagle lager', 'hero', 'castle lite', 'budweiser', 'trophy') 
GROUP BY countries
ORDER BY SUM(quantity) DESC
LIMIT 1;


--2. Highest sales personnel of Budweiser in Senegal--
SELECT Sales_rep, SUM(quantity) AS Sales
FROM breweries
WHERE countries = 'Senegal' 
AND brands = 'budweiser'
GROUP BY sales_rep
ORDER BY Sales DESC
LIMIT 1


--3. Country with the highest profit of the fourth quarter in 2019--
SELECT countries, SUM(profit) AS Total_Profit
FROM breweries
WHERE months IN ('October','November','December') 
AND years = 2019
GROUP BY countries
ORDER BY Profit DESC
LIMIT 1
