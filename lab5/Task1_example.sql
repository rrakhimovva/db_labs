EXECUTE AS USER = 'User_Manager'

SELECT * FROM Manufacturer         
SELECT * FROM Cashier              
EXEC GetExpiringMedications1      

GRANT SELECT ON Disease TO User_Employee  

REVERT


EXECUTE AS USER = 'User_Employee'


SELECT * FROM MedicationType                    
SELECT * FROM Manufacturer                   
SELECT * FROM GetMedicationsForDisease('Грипп') 
SELECT * FROM Disease                  


SELECT * FROM Cashier                          
UPDATE Sales SET amount = 2000 WHERE id = 1    
DELETE FROM Sales WHERE id = 1                  

REVERT