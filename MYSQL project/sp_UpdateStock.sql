/***************************************************************
* Author:   Lario Truter
* Date:     01 June 2023
* Filename: sp_UpdateStock.sql
* Description: This script file creates a stored procedure that will update an existing pet type record
****************************************************************/

# Using the tygervalleypetshelter database to create procedure
USE tygervalleypetshelter;

DELIMITER $$

# Drops the stored procedure if it exists
DROP PROCEDURE IF EXISTS sp_UpdateStock $$

# Creates stored procedure sp_UpdateStock
CREATE PROCEDURE sp_UpdateStock(IN new_Pet_ID INT, IN new_Pet_Type VARCHAR(45), IN new_Num_Of_Pets INT, IN new_Addition BIT)

BEGIN
	# Raises an error and displays an error message if pet ID doesn't exists in the Pets table
	BEGIN
		DECLARE EXIT HANDLER FOR SQLSTATE '42000'
        SELECT 'ERROR: Pet ID does not exist';
		IF NOT EXISTS (SELECT pet_ID
			FROM Pets
			WHERE Pets.pet_ID = new_Pet_ID) THEN
            CALL raise_error;
		END IF;
	END;

BEGIN
    DECLARE current_Num_Of_Pets INT;

	# Raises an error and displays an error message if the pet ID AND pet type don't exist in the Pets table
    IF NOT EXISTS (
        SELECT pet_ID
        FROM Pets
        WHERE Pets.pet_ID = new_Pet_ID AND Pets.pet_Type = new_Pet_Type
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Pet ID does not exist';
    END IF;

    # Get the current number of pets for the specified pet type
    SET current_Num_Of_Pets = (
        SELECT num_Of_Pets
        FROM Pets
        WHERE Pets.pet_ID = new_Pet_ID AND Pets.pet_Type = new_Pet_Type
    );

    # Updates the number of pets based on the addition/subtraction flag
    IF new_Addition = 1 THEN
        SET current_Num_Of_Pets = current_Num_Of_Pets + new_Num_Of_Pets;
    ELSE
        SET current_Num_Of_Pets = current_Num_Of_Pets - new_Num_Of_Pets;
    END IF;

    # Raises an error and displays an error message if the current number of pets is below 0
    IF current_Num_Of_Pets < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'ERROR: Number of pets cannot be below 0';
    END IF;

    # Updates the number of pets for the specified pet type
    UPDATE Pets
    SET num_Of_Pets = current_Num_Of_Pets
    WHERE Pets.pet_ID = new_Pet_ID AND Pets.pet_Type = new_Pet_Type;
END;
END $$

DELIMITER ;

# Calls the sp_UpdateStock stored procedure
CALL sp_UpdateStock(2, 'Parrot', 8, 1);

# Displays all the records in the Pets table
SELECT * FROM Pets;