-- Примеры для руководителя
EXECUTE AS USER = 'User_Manager'

SELECT * FROM Manufacturer         
SELECT * FROM Cashier              
EXEC GetExpiringMedications1      

REVERT

-- Примеры для сотрудника
EXECUTE AS USER = 'User_Employee'

SELECT * FROM MedicationType                    
SELECT * FROM Manufacturer                   
SELECT * FROM GetMedicationsForDisease('Грипп') 
                     
UPDATE Sales SET amount = 2000 WHERE id = 1    
DELETE FROM Sales WHERE id = 1                  

REVERT



