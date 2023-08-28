/***************************************************************
* Author:   Lario Truter
* Date:     01 June 2023
* Filename: Views.sql
* Description: This script file creates 4 sample view: 
				vw_ManufacturerDetails: Selects manufacturing company details, the food type, food ID and amount per category
                vw_PetsPerType: Selects each animal type, the animal category ID, category name and adds all animals in stock together
                vw_ExpiredFoodDetails: Selects the company name, contact number, food ID, name, expiry date, amount per category, measurement and the category name and 
										only displays them if they're expired
                vw_LowestFoods: Select the category name and the sum of the total animals in the category. Only the three records with the lowest pets are displayed
****************************************************************/

# Using the tygervalleypetshelter database to create the view
USE tygervalleypetshelter;

# Drop the vw_ManufacturerDetails view if it already exists
DROP VIEW IF EXISTS vw_ManufacturerDetails;

# Create a view that displays the company_ID, company_Name, contact_Number, food_Type, food_ID, food_Quantity 
CREATE VIEW vw_ManufacturerDetails
AS
	SELECT Company.company_ID, company_Name, contact_Number, PetFood.food_ID, food_Type, FoodAllocation.food_Quantity
	FROM Company
    JOIN PetFood ON Company.company_ID = PetFood.company_ID
    JOIN FoodAllocation ON PetFood.food_ID = FoodAllocation.food_ID; 

# Testing the vw_ManufacturerDetails view
SELECT * FROM vw_ManufacturerDetails;


# Drop the vw_PetsPerType view if it already exists
DROP VIEW IF EXISTS vw_PetsPerType;

# Create a view that displays pet_Type, category_ID, category_Name and totals the num_Of_Pets
CREATE VIEW vw_PetsPerType
AS
	SELECT Pets.pet_ID, pet_Type, SUM(num_Of_Pets) AS 'Total Number of Pets', Category.category_ID, category_Name
    FROM Pets
    JOIN Category ON Pets.pet_ID = Category.pet_ID
    GROUP BY pet_ID, category_ID;
    
# Testing the vw_PetsPerType view    
SELECT * FROM vw_PetsPerType;


# Drop the vw_ExpiredFoodDetails view if it already exists
DROP VIEW IF EXISTS vw_ExpiredFoodDetails;

/* Create a view that displays company_Name, contact_Number, food_ID, food_Type, expiry_Date, 
food_Quantity, measurement_Unit, category_Name */
CREATE VIEW vw_ExpiredFoodDetails
AS
	SELECT Company.company_ID, company_Name, contact_Number, PetFood.food_ID, food_Type, expiry_Date, 
    FoodAllocation.food_Quantity, measurement_Unit, Category.category_ID, category_Name 
    FROM Company
    JOIN PetFood ON Company.company_ID = PetFood.company_ID
    JOIN FoodAllocation ON PetFood.food_ID = FoodAllocation.food_ID
    JOIN Category ON FoodAllocation.category_ID = Category.category_ID
# If the current date is greater than the expiry_Date, the record is displayed
	WHERE CURDATE() > expiry_Date;

# Testing the vw_ExpiredFoodDetails view    
SELECT * FROM vw_ExpiredFoodDetails;


# Drop the vw_LowestFoods view if it already exists
DROP VIEW IF EXISTS vw_LowestFoods;

# Create a view that displays category_name and the sum of the total animals in the category
CREATE VIEW vw_LowestFoods
AS
	SELECT Category.category_Name, SUM(num_Of_Pets) AS 'Lowest Number of Pets', Pets.pet_ID
    FROM Category
    JOIN Pets ON Pets.pet_ID = Category.pet_ID
    GROUP BY category_Name, pet_ID
#Records will be displayed in ascending order and will only display 3 records
    ORDER BY num_Of_Pets ASC LIMIT 3; 

# Testing the vw_LowestFoods view       
SELECT * FROM vw_LowestFoods;