/***************************************************************
* Author:   Lario Truter
* Date:     01 June 2023
* Filename: sp_NewPetType.sql
* Description: This script file creates a stored procedure that will insert a new pet type record
****************************************************************/

# Using the tygervalleypetshelter database to create procedure
USE tygervalleypetshelter;

DELIMITER $$
# Drops the sp_NewPetType procedure if it already exists
DROP PROCEDURE IF EXISTS sp_NewPetType $$

# Creates procedure sp_NewPetType
CREATE PROCEDURE sp_NewPetType(IN new_Pet_Type VARCHAR(45), IN new_Num_Of_Pets INT, IN new_Category_ID INT)

BEGIN
	
    # Counts the number of records that have a matching category ID 
    DECLARE category_Check INT;
    SET category_Check = (
		SELECT COUNT(*)
        FROM Category
        WHERE category_ID = new_Category_ID 
    );
    
    # Raises an error and displays an error message if the number of pets is less than 0
	IF new_Num_Of_Pets < 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ERROR: Number of pets can not be less than 0';
    
    # Raises an error and displays an error message if category check finds no matching record
    ELSEIF category_Check = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ERROR: Catgory ID does not exist';
    
    # If all of the conditions evaluate to false then it's inserted into the Pets
	ELSE 
		INSERT INTO Pets(pet_Type, num_Of_Pets)
        VALUES (new_Pet_Type, new_Num_Of_Pets);
	END IF;
END$$

DELIMITER ;

# Calls the sp_NewPetType stored procedure
CALL sp_NewPetType('Hamster', 9, 3);

# Displays all records in the Pets table
SELECT * FROM Pets;