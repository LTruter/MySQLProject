/***************************************************************
* Author:   Lario Truter
* Date:     01 June 2023
* Filename: Indexes.sql
* Description: This script file creates indexes that are use to speed up searches
               done on the tygervalleypetshelter database
****************************************************************/

# Using the tygervalleypetshelter database to create indexes
USE tygervalleypetshelter;

# Create indexes to speed up searches on the Company table
CREATE INDEX company_Name_Index ON Company (company_Name);

# Create indexes to speed up searches on the PetFood table
CREATE INDEX food_Type_Index ON PetFood (food_Type);

# Create indexes to speed up searches on the Pets table
CREATE INDEX pet_Type_Index ON Pets (pet_Type);

# Create indexes to speed up searches on the Category table
CREATE INDEX category_Name_Index ON Category (category_Name);  

# Create indexes to speed up searches on the FoodAllocation table
CREATE INDEX food_Quantity_Index ON FoodAllocation (food_Quantity);