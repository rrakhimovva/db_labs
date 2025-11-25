-- Создаем пользователей 
CREATE LOGIN User_Manager WITH PASSWORD = '1234567'
CREATE USER User_Manager FOR LOGIN User_Manager

CREATE LOGIN User_Employee WITH PASSWORD = '1234567'
CREATE USER User_Employee FOR LOGIN User_Employee

-- Создаем две роли
CREATE ROLE Role_Manager
CREATE ROLE Role_Employee

-- Добавляем пользователей к ролям 
ALTER ROLE Role_Manager ADD MEMBER User_Manager
ALTER ROLE Role_Employee ADD MEMBER User_Employee

-- Выдаем права руководителю 
GRANT SELECT, INSERT, UPDATE, DELETE ON Manufacturer TO Role_Manager
GRANT SELECT, INSERT, UPDATE, DELETE ON Cashier TO Role_Manager
GRANT SELECT, INSERT, UPDATE, DELETE ON Disease TO Role_Manager
GRANT SELECT, INSERT, UPDATE, DELETE ON MedicationType TO Role_Manager
GRANT SELECT, INSERT, UPDATE, DELETE ON Sales TO Role_Manager
GRANT SELECT, INSERT, UPDATE, DELETE ON MedicineBatch TO Role_Manager
GRANT SELECT, INSERT, UPDATE, DELETE ON MedicationType_Disease TO Role_Manager
GRANT SELECT, INSERT, UPDATE, DELETE ON MedicineBatch_Sales TO Role_Manager

GRANT EXECUTE ON CalculateAverageMedicationsCount TO Role_Manager
GRANT EXECUTE ON FindCheapestAnalog TO Role_Manager
GRANT EXECUTE ON GetExpiringMedications1 TO Role_Manager
GRANT EXECUTE ON GetMedicationsByActiveSubstance TO Role_Manager
GRANT EXECUTE ON GetSalesWithAboveAverageMedications TO Role_Manager
GRANT SELECT ON GetMedicationsForDisease TO Role_Manager
GRANT SELECT ON GetSoldMedicationsByDate TO Role_Manager
GRANT EXECUTE ON GetDailyRevenue TO Role_Manager

GRANT SELECT ON Manufacturer TO Role_Manager WITH GRANT OPTION
GRANT EXECUTE ON GetDailyRevenue TO Role_Manager WITH GRANT OPTION

-- Выдаем права сотруднику
GRANT SELECT ON MedicationType TO Role_Employee
GRANT SELECT ON MedicineBatch TO Role_Employee
GRANT SELECT ON Disease TO Role_Employee
GRANT SELECT ON MedicationType_Disease TO Role_Employee
GRANT SELECT ON Manufacturer TO Role_Employee

GRANT SELECT, INSERT ON Sales TO Role_Employee
GRANT SELECT, INSERT ON MedicineBatch_Sales TO Role_Employee

DENY SELECT ON Cashier TO Role_Employee

REVOKE SELECT ON Disease FROM Role_Employee

GRANT EXECUTE ON GetDailyRevenue TO Role_Employee
GRANT SELECT ON GetSoldMedicationsByDate TO Role_Employee
GRANT SELECT ON GetMedicationsForDisease TO Role_Employee

DENY UPDATE, DELETE ON Sales TO Role_Employee
DENY UPDATE, DELETE ON MedicineBatch_Sales TO Role_Employee
DENY UPDATE, DELETE ON MedicineBatch TO Role_Employee