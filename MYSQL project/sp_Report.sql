/***************************************************************
* Author:   Lario Truter
* Date:     01 June 2023
* Filename: sp_Report.sql
* Description: This script file will print a specified manufacturing company’s details and  
				all its expired products in use by using the vw_ExpiredFoodDetails view
****************************************************************/

# Using the tygervalleypetshelter database to create procedure
USE tygervalleypetshelter;

DELIMITER $$

# Drops procedure if it exists
DROP PROCEDURE IF EXISTS sp_Report $$

# Creates stored procedure sp_Report 
CREATE PROCEDURE sp_Report (IN new_Company_ID INT)
BEGIN
	# Declaring variables
    DECLARE new_Company_Name VARCHAR(45);
    DECLARE new_Contact_Number VARCHAR(10);
    DECLARE new_Email VARCHAR(45);
    DECLARE new_Food_ID INT; 
    DECLARE new_Food_Type VARCHAR(45);
    DECLARE display_Results TEXT;
    DECLARE total_Records INT;
    
    DECLARE exit_Flag INT DEFAULT FALSE;
	
    # Declares cursor and selects rows where the company ID matches and the expiry date is less than current date
    DECLARE report_Cur CURSOR FOR
        SELECT p.food_ID, p.food_Type		
        FROM PetFood AS p
        WHERE p.company_ID = new_Company_ID AND p.expiry_Date < CURDATE();

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_Flag = TRUE;
	
    # Declares exit handler and selects an error message
    DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    BEGIN
        SELECT 'Company ID does not exist';
    END;

	# Selects rows where the company ID matches
    SELECT company_Name, contact_Number, email
    INTO new_Company_Name, new_Contact_Number, new_Email
    FROM Company
    WHERE company_ID = new_Company_ID;
	
    # Concatenates various strings together and assigns the resulting values to the display_Results variable
    SET display_Results = CONCAT('EXPIRED PRODUCTS REPORT:', CHAR(13));
    SET display_Results = CONCAT(display_Results, REPEAT('_', 60), CHAR(13), CHAR(13));
    SET display_Results = CONCAT(display_Results, 'Generated: ', SPACE(11), DATE_FORMAT(NOW(), '%b %d %Y %l:%i%p'), CHAR(13), CHAR(13));
    SET display_Results = CONCAT(display_Results, 'Company ID: ', SPACE(10), new_Company_ID, CHAR(13));
    SET display_Results = CONCAT(display_Results, 'Company Name: ', SPACE(8), new_Company_Name, CHAR(13));
    SET display_Results = CONCAT(display_Results, 'Contact Number: ', SPACE(6), new_Contact_Number, CHAR(13));
    SET display_Results = CONCAT(display_Results, 'Email: ', SPACE(15), new_Email, CHAR(13), CHAR(13));

    SET display_Results = CONCAT(display_Results, '_________________________________________________________', CHAR(13));
    SET display_Results = CONCAT(display_Results, 'Food ID', SPACE(4), 'Food Type', CHAR(13));
    SET display_Results = CONCAT(display_Results, '_________________________________________________________', CHAR(13));

	# Opens the report_Cur cursor
    OPEN report_Cur;
    
    # Assigns the total records variable a value
    SET total_Records = 0;

	/* read_Loop will loop through records, assign the resulting values to display_Results variable 
    and counts the number of records processed */
    read_Loop: LOOP
        FETCH report_Cur INTO new_Food_ID, new_Food_Type;
        IF exit_Flag THEN
            LEAVE read_loop;
        END IF;

        SET display_Results = CONCAT(display_Results, new_Food_ID, SPACE(10), new_Food_Type, CHAR(13));
        SET total_Records = total_Records + 1;
    END LOOP;

	# Closes report_Cur cursor
    CLOSE report_Cur;
	
    SET display_Results = CONCAT(display_Results, '_______________________', CHAR(13));
    SET display_Results = CONCAT(display_Results, 'Total Records: ', total_Records, CHAR(13));
    SET display_Results = CONCAT(display_Results, '_______________________');

	# display_Result is exported to a text file located at the specified path
    SELECT display_Results INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Expired_Products_Report.txt';

    SELECT 'Report generated successfully' AS Message;
END $$

DELIMITER ;

# Calls the sp_Report stored procedure
CALL sp_Report(5);