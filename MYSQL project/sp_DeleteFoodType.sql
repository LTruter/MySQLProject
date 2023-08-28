/***************************************************************
* Author:   Lario Truter
* Date:     01 June 2023
* Filename: sp_DeleteFoodType.sql
* Description: This script file creates a stored procedure that will delete a specified food type and all dependent/child records,
				if it is contained in the vw_ExpiredFoodDetails view
****************************************************************/

# Using the tygervalleypetshelter database to create procedure
USE tygervalleypetshelter;

DELIMITER $$

# Drops procedure if it exists
DROP PROCEDURE IF EXISTS sp_DeleteFoodType $$

# Creates stored procedure sp_DeleteFoodType
CREATE PROCEDURE sp_DeleteFoodType(IN new_Food_ID INT)

BEGIN
	
    # Raises an error and displays an error message if food ID doesn't exist
	BEGIN
		DECLARE EXIT HANDLER FOR SQLSTATE '42000'
        SELECT 'This food ID does not exist';
		IF NOT EXISTS (SELECT food_ID 
			FROM PetFood
			WHERE PetFood.food_ID = new_Food_ID) THEN
			CALL raise_error;
		END IF;
    END;
    
    # Checks if any food IDs that appear in vw_ExpiredFoodDetails match any existing food IDs 
    IF EXISTS (SELECT * FROM vw_ExpiredFoodDetails
        WHERE vw_ExpiredFoodDetails.food_ID = new_Food_ID) THEN
        
        # If the food ID exists in vw_ExpiredFoodDetails then the record of it is deleted from FoodAllocation and PetFood
        DELETE 
        FROM FoodAllocation 
        WHERE FoodAllocation.food_ID = new_Food_ID;
        
        
        DELETE
        FROM PetFood
        WHERE PetFood.food_ID = new_Food_ID;
    END IF;
    
END $$

DELIMITER ;

# Calls the sp_DeleteFoodType stored procedure
CALL sp_DeleteFoodType(2);

# Displays all the records in vw_ExpiredFoodDetails view
SELECT * FROM vw_ExpiredFoodDetails;