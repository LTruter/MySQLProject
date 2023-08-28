/***************************************************************
* Author:   Lario Truter
* Date:     01 June 2023
* Filename: Triggers.sql
* Description: This script file creates 2 triggers that activate after insert: 
				check_Food_Quantity: Checks that food quantity inserted is not less than 1
                check_Expiry_Date: Checks if expiry date is past
****************************************************************/

# Using the tygervalleypetshelter to create a trigger
USE tygervalleypetshelter;

DROP TRIGGER IF EXISTS check_Food_Quantity;

DELIMITER $$

# Creates trigger check_Food_Quantity

CREATE TRIGGER check_Food_Quantity AFTER INSERT ON FoodAllocation		# Only activates after insert

FOR EACH ROW	

# Gives an error and displays an error message if food quantity is less than 1

BEGIN
	
	IF NEW.food_Quantity < 1 THEN
		
        SIGNAL SQLSTATE '45000'
        
		SET MESSAGE_TEXT = 'ERROR: Food Quantity can not be less than 1';
        
	END IF;

END $$

DELIMITER ;



DROP TRIGGER IF EXISTS check_Expiry_Date;

DELIMITER $$

# Creates trigger check_Expiry_Date

CREATE TRIGGER check_Expiry_Date AFTER INSERT ON PetFood		# Only activates after insert

FOR EACH ROW

# Gives an error and displays an error message if the expiry date is less than current date

BEGIN

	IF NEW.expiry_Date < CURDATE() THEN
    
    SIGNAL SQLSTATE '45000'
    
    SET MESSAGE_TEXT = 'ERROR: Pet food is past expiration date';
    
    END IF;

END $$

# Inserts that will activate the triggers
INSERT INTO FoodAllocation
VALUES (4, 2, 0, 'KG');

INSERT INTO PetFood
VALUES (7, 'Fruits', '2023-01-28', 4);