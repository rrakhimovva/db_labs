-- Добавляем маскирование к полю [full name] таблицы Cashier
ALTER TABLE Cashier
ALTER COLUMN [full name] ADD MASKED WITH (FUNCTION = 'partial(2,"xxxx",0)')

GRANT UNMASK TO Role_Manager

-- 1. Проверка для руководителя
EXECUTE AS USER = 'User_Manager'
SELECT TOP 3 [full name] FROM Cashier
GRANT SELECT ON Cashier TO Role_Employee
REVERT

-- 2. Проверка для сотрудника 
EXECUTE AS USER = 'User_Employee'
SELECT TOP 3 [full name] FROM Cashier
REVERT
GO


-- Функция для маскирования email
CREATE FUNCTION MaskEmail (
    @email NVARCHAR(100)
)
RETURNS NVARCHAR(100)
AS
BEGIN
    IF IS_MEMBER('Role_Manager') = 1
        RETURN @email
    RETURN 'orders@pharmacy.ru'
END
GO

-- Функция для маскирования адресов
CREATE FUNCTION MaskAddress (
    @address NVARCHAR(200)
)
RETURNS NVARCHAR(200)
AS
BEGIN
    IF IS_MEMBER('Role_Manager') = 1
        RETURN @address
    
    DECLARE @city NVARCHAR(50)
    
    IF @address LIKE '%Москва%' SET @city = 'Москва'
    ELSE IF @address LIKE '%Санкт-Петербург%' SET @city = 'Санкт-Петербург'
    ELSE IF @address LIKE '%Екатеринбург%' SET @city = 'Екатеринбург'
    ELSE IF @address LIKE '%Новосибирск%' SET @city = 'Новосибирск'
    ELSE IF @address LIKE '%Казань%' SET @city = 'Казань'
    ELSE IF @address LIKE '%Ростов-на-Дону%' SET @city = 'Ростов-на-Дону'
    ELSE IF @address LIKE '%Владивосток%' SET @city = 'Владивосток'
    ELSE IF @address LIKE '%Нижний Новгород%' SET @city = 'Нижний Новгород'
    ELSE SET @city = 'Город поставщика'
    
    RETURN @city
END
GO

CREATE VIEW vw_Manufacturer_Protected
AS
SELECT 
    id,
    [name],
    dbo.MaskEmail(email) AS email,
    dbo.MaskAddress([address]) AS [address]
FROM 
    Manufacturer
GO

GRANT SELECT ON vw_Manufacturer_Protected TO Role_Employee

-- Проверка для руководителя
EXECUTE AS USER = 'User_Manager'
SELECT TOP 3 * FROM Manufacturer
REVERT

-- Проверка для сотрудника 
EXECUTE AS USER = 'User_Employee'
SELECT TOP 3 * FROM Manufacturer
SELECT TOP 3 * FROM vw_Manufacturer_Protected
REVERT



