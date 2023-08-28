/******************************************************************
* Author:   Lario Truter
* Date:     01 June 2023
* Filename: Sample data.sql
* Description: This script inserts sample data into the tygervalleypetshelter database
******************************************************************/

# Using the tygervalleypetshelter database to insert new records
USE tygervalleypetshelter;

INSERT INTO Company(company_ID, company_Name, contact_Number, email)
VALUES(Null, 'Pellet Paradise', '0734271817', 'pelletp@gmail.com'),
	  (Null, 'Seed Land', '0728769045', 'seedLand@gmail.com'),
      (Null, 'Vegetables for you', '0821234567', 'vegetables4u@gmail.com'),
      (Null, 'Pet Biscuits', '0626342890', 'petbiscuits@gmail.com'),
      (Null, 'Billies butchery', '0834568902', 'billiesb@gmail.com');
SELECT * FROM Company; #displays all the records from the Company table

INSERT INTO PetFood(food_ID, food_Type, expiry_Date, company_ID)
VALUES(Null, 'Pellets', '2023-09-12', 1),
	  (Null, 'Seeds', '2023-05-27', 2),
      (Null, 'Vegetables', '2023-06-07', 3),
      (Null, 'Biscuits', '2023-08-16', 4),
      (Null, 'Meats', '2023-01-23', 5);
SELECT * FROM PetFood; #displays all the records from the PetFood table

INSERT INTO Pets(pet_ID, pet_Type, num_Of_Pets)
VALUES(Null, 'Dog', '29'),
	  (Null, 'Parrot', '17'),
      (Null, 'Cat', '27'),
      (Null, 'Budgie', '11'),
      (Null, 'Snakes', '22');
SELECT * FROM Pets; #displays all the records from the Pets table

INSERT INTO Category(category_ID, category_Name, pet_ID)
VALUES(Null, 'Mammal', 1),
	  (Null, 'Bird', 2),
      (Null, 'Mammal', 3),
      (Null, 'Bird', 4),
      (Null, 'Reptile', 5);
SELECT * FROM Category; #displays all the records from the Category table

INSERT INTO FoodAllocation(food_ID, category_ID, food_Quantity, measurement_Unit)
VALUES(1, 1, '60', 'Grams'),
	  (2, 2, '20', 'Grams'),
      (3, 3, '90', 'Grams'),
      (4, 4, '50', 'Grams'),
      (5, 5, '120', 'Grams');
SELECT * FROM FoodAllocation; #displays all the records from the FoodAllocation table