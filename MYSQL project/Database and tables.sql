/******************************************************************
* Author:   Lario Truter
* Date:     01 June 2023
* Filename: Database and tables.sql
* Description: This script creates the tygervalleypetshelter database and its tables
******************************************************************/

# Dropping database if there's a database with the same name and creating a new database
DROP DATABASE IF EXISTS tygervalleypetshelter;

# Creates database tygervalleypetshelter
CREATE DATABASE tygervalleypetshelter;

# Using tygervalleypetshelter database 
USE tygervalleypetshelter;

# Creating the Company table
CREATE TABLE Company (
	company_ID INT NOT NULL AUTO_INCREMENT,
    company_Name VARCHAR(45) NOT NULL,
    contact_Number VARCHAR(10) NOT NULL,
    email VARCHAR(45) NULL,
    CHECK (email LIKE '%_@_%._%'),	# Checks that the email input follows the specific pattern
	PRIMARY KEY (company_ID)
);

# Creating the PetFood table
CREATE TABLE PetFood (
	food_ID INT NOT NULL AUTO_INCREMENT,
    food_Type VARCHAR(45) NOT NULL,
    expiry_Date DATE NOT NULL,
    company_ID INT NOT NULL,
    FOREIGN KEY (company_ID) REFERENCES Company (company_ID),
	PRIMARY KEY (food_ID)
);

# Creating the Pets table
CREATE TABLE Pets (
	pet_ID INT NOT NULL AUTO_INCREMENT,
    pet_Type VARCHAR(45) NOT NULL,
    num_Of_Pets INT NOT NULL,
    UNIQUE (pet_Type),
    PRIMARY KEY (pet_ID)
);

# Creating the Category table
CREATE TABLE Category (
	category_ID	INT NOT NULL AUTO_INCREMENT,
    category_Name VARCHAR(45) NOT NULL,
    pet_ID INT NOT NULL,
	FOREIGN KEY (pet_ID) REFERENCES Pets (pet_ID),
    PRIMARY KEY (category_ID) 
);

# Creating the FoodAllocation table
CREATE TABLE FoodAllocation (
	food_ID INT NOT NULL,
    category_ID INT NOT NULL,
    food_Quantity INT NOT NULL,
	measurement_Unit VARCHAR(45) NOT NULL DEFAULT 'Grams',		# The default value for measurement unit will be Grams
    FOREIGN KEY (food_ID) REFERENCES PetFood (food_ID),
    FOREIGN KEY (category_ID) REFERENCES Category (category_ID),
    PRIMARY KEY (food_ID, category_ID)
);