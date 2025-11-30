-- Создаем узлы
CREATE TABLE ManufacturerNode (
    id INT NOT NULL PRIMARY KEY,
    [name] NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    [address] NVARCHAR(200) NOT NULL
) AS NODE;

CREATE TABLE MedicationTypeNode (
    id INT NOT NULL PRIMARY KEY,
    [name] NVARCHAR(50) NOT NULL,
    [status] NVARCHAR(20) NOT NULL,
    active_substance NVARCHAR(50) NOT NULL
) AS NODE;

CREATE TABLE DiseaseNode (
    id INT NOT NULL PRIMARY KEY,
    [name] NVARCHAR(20) NOT NULL
) AS NODE;

CREATE TABLE CashierNode (
    id INT NOT NULL PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL
) AS NODE;

CREATE TABLE MedicineBatchNode (
    id INT NOT NULL PRIMARY KEY,
    price MONEY NOT NULL,
    quantity INT NOT NULL,
    expiration_date DATE NOT NULL
) AS NODE;

CREATE TABLE SalesNode (
    id INT NOT NULL PRIMARY KEY,
    [date] DATE NOT NULL,
    amount MONEY NOT NULL
) AS NODE;

-- Создаем ребра
CREATE TABLE Produces AS EDGE;

CREATE TABLE TreatsDisease AS EDGE;

CREATE TABLE BelongsToBatch AS EDGE;

CREATE TABLE SellsMedication AS EDGE;

CREATE TABLE MakesSale AS EDGE;

CREATE TABLE IncludesInSale AS EDGE;

-- Заполняем узлы информацией
INSERT INTO ManufacturerNode (id, [name], email, [address])
SELECT id, [name], email, [address] FROM Manufacturer;

INSERT INTO MedicationTypeNode (id, [name], [status], active_substance)
SELECT id, [name], [status], active_substance FROM MedicationType;

INSERT INTO DiseaseNode (id, [name])
SELECT id, [name] FROM Disease;

INSERT INTO CashierNode (id, full_name)
SELECT id, [full name] FROM Cashier;

INSERT INTO MedicineBatchNode (id, price, quantity, expiration_date)
SELECT id, price, quantity, expiration_date FROM MedicineBatch;

INSERT INTO SalesNode (id, [date], amount)
SELECT id, [date], amount FROM Sales;

-- Создаем связи между узлами
-- Производитель -> Производит -> Тип лекарства
INSERT INTO Produces ($from_id, $to_id)
SELECT 
    mn.$node_id,
    mtn.$node_id
FROM 
    Manufacturer m JOIN MedicationType mt ON m.id = mt.manufacturer_id
    JOIN ManufacturerNode mn ON m.id = mn.id
    JOIN MedicationTypeNode mtn ON mt.id = mtn.id;

-- Тип лекарства -> Лечит -> Болезнь
INSERT INTO TreatsDisease ($from_id, $to_id)
SELECT 
    mtn.$node_id,
    dn.$node_id
FROM 
    MedicationType_Disease mtd JOIN MedicationType mt ON mtd.medication_type_id = mt.id
    JOIN Disease d ON mtd.disease_id = d.id
    JOIN MedicationTypeNode mtn ON mt.id = mtn.id
    JOIN DiseaseNode dn ON d.id = dn.id;

-- Тип лекарства -> Принадлежит к -> Партия
INSERT INTO BelongsToBatch ($from_id, $to_id)
SELECT 
    mtn.$node_id,
    mbn.$node_id
FROM 
    MedicineBatch mb JOIN MedicationType mt ON mb.medication_type_id = mt.id
    JOIN MedicationTypeNode mtn ON mt.id = mtn.id
    JOIN MedicineBatchNode mbn ON mb.id = mbn.id;

-- Кассир -> Осуществляет -> Продажу
INSERT INTO MakesSale ($from_id, $to_id)
SELECT 
    cn.$node_id,
    sn.$node_id
FROM 
    Sales s JOIN Cashier c ON s.cashier_id = c.id
    JOIN CashierNode cn ON c.id = cn.id
    JOIN SalesNode sn ON s.id = sn.id;

-- Продажа -> Включает в -> Партию лекарства
INSERT INTO IncludesInSale ($from_id, $to_id)
SELECT 
    sn.$node_id,
    mbn.$node_id
FROM MedicineBatch_Sales mbs JOIN Sales s ON mbs.sales_id = s.id
    JOIN MedicineBatch mb ON mbs.medicine_batch_id = mb.id
    JOIN SalesNode sn ON s.id = sn.id
    JOIN MedicineBatchNode mbn ON mb.id = mbn.id;



