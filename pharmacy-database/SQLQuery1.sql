DROP TABLE IF EXISTS MedicineBatch_Sales;
DROP TABLE IF EXISTS MedicationType_Disease;
DROP TABLE IF EXISTS MedicineBatch;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS MedicationType;
DROP TABLE IF EXISTS Disease;
DROP TABLE IF EXISTS Cashier;
DROP TABLE IF EXISTS Manufacturer;

-- �������������
CREATE TABLE Manufacturer
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    [name] NVARCHAR(50) NOT NULL
);

-- ������
CREATE TABLE Cashier
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    [full name] NVARCHAR(100) NOT NULL 
);

-- �������
CREATE TABLE Disease
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    [name] NVARCHAR(20) NOT NULL
);

-- ��� ���������
CREATE TABLE MedicationType
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    [name] NVARCHAR(50) NOT NULL,
    [status] NVARCHAR(20) NOT NULL CHECK ([status] IN ('� �������', '����������')),
    [active substance] NVARCHAR(50) NOT NULL,
    annotation NVARCHAR(500),
    [indications for use] NVARCHAR(500),
    id_Manufacturer INT FOREIGN KEY REFERENCES Manufacturer(id)
);

-- �������
CREATE TABLE Sales
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    [date] DATE NOT NULL,
    amount MONEY NOT NULL,
    id_Cashier INT FOREIGN KEY REFERENCES Cashier(id)
);

-- ������ ���������
CREATE TABLE MedicineBatch
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    price MONEY NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),  
    [expiration date] DATE NOT NULL,
    id_MedicationType INT FOREIGN KEY REFERENCES MedicationType(id)
);

-- ��� ���������-�������
CREATE TABLE MedicationType_Disease
(
    id_Disease INT FOREIGN KEY REFERENCES Disease(id),
    id_MedicationType INT FOREIGN KEY REFERENCES MedicationType(id),
    PRIMARY KEY(id_Disease, id_MedicationType)
);

-- ������ ���������-�������
CREATE TABLE MedicineBatch_Sales
(
    id_MedicineBatch INT FOREIGN KEY REFERENCES MedicineBatch(id),
    id_Sales INT FOREIGN KEY REFERENCES Sales(id),
    quantity INT NOT NULL CHECK (quantity > 0),  
    PRIMARY KEY(id_MedicineBatch, id_Sales)
);

INSERT INTO Manufacturer ([name]) VALUES
('Bayer'),
('Pfizer'),
('Novartis'),
('Roche'),
('Sanofi'),
('GlaxoSmithKline'),
('AstraZeneca'),
('Johnson & Johnson'),
('Merck'),
('Teva');

INSERT INTO Disease ([name]) VALUES
('�����'),
('����������'),
('������'),
('�������'),
('��������'),
('������'),
('�����'),
('�������'),
('���������'),
('����������');

INSERT INTO Cashier ([full name]) VALUES
('������� ���� ���������'),
('������ ������� ������������'),
('�������� ��������� ��������'),
('������ ����� �������������'),
('�������� ����� ��������'),
('������� ������ ���������'),
('��������� ������ ����������'),
('������ ����� ��������'),
('��������� ���� ����������'),
('�������� ����� ���������');

INSERT INTO MedicationType ([name], [status], [active substance], annotation, [indications for use], id_Manufacturer) VALUES
('�������', '� �������', '���������', '�������������� � ��������������������� ��������', '�������� ����, ������ ����, ������������� ����', 1),
('����������', '����������', '������������', '����������������� �������� �������� �������', '������������� �������� ����������� �����', 2),
('���������', '� �������', '���������', '������������� ��������', '������������ �����������, ��������� ���������������', 3),
('��������', '� �������', '���������', '�������������������� ��������', '�������� ��������, ����������', 4),
('����������', '����������', '����������', '���������� ��������', '��������� �����������, ����������', 5),
('����������', '� �������', '���������', '�������������� ��������', '����������, ������� ����������', 6),
('�������', '� �������', '����������������� �������', '�������������� � ���������������������', '��������, �������� ����', 7),
('��������', '����������', '���������', '�������������� ��������', '������ � ���������������� ��������', 8),
('���������', '� �������', '���������', '����������������� ��������', '�������� ������ 2 ����', 9),
('���������', '����������', '����� �����', '����������� �������� ����', '������������ ������������', 10);

INSERT INTO Sales ([date], amount, id_Cashier) VALUES
('2024-01-15', 2450.00, 1),
('2024-01-15', 1800.50, 2),
('2024-01-16', 3200.75, 3),
('2024-01-16', 950.25, 1),
('2024-01-17', 4100.00, 4),
('2024-01-17', 1650.30, 5),
('2024-01-18', 2800.60, 2),
('2024-01-18', 1950.90, 3),
('2024-01-19', 3750.45, 1),
('2024-01-19', 2200.80, 4);

INSERT INTO MedicineBatch (price, quantity, [expiration date], id_MedicationType) VALUES
(450.00, 50, '2025-06-30', 1),
(1200.00, 0, '2024-12-15', 2),
(680.50, 100, '2025-03-20', 3),
(350.75, 80, '2024-11-30', 4),
(280.00, 0, '2025-08-10', 5),
(150.25, 200, '2024-10-25', 6),
(95.00, 150, '2025-01-15', 7),
(890.00, 0, '2025-05-30', 8),
(540.00, 60, '2024-09-20', 9),
(320.50, 0, '2025-07-15', 10);

INSERT INTO MedicationType_Disease (id_Disease, id_MedicationType) VALUES
(1, 1),
(1, 7),
(2, 3),
(3, 9),
(4, 1),
(5, 4),
(6, 1),
(7, 8),
(8, 5),
(9, 6);

INSERT INTO MedicineBatch_Sales (id_MedicineBatch, id_Sales, quantity) VALUES
(1, 1, 2),
(4, 1, 1),
(2, 2, 1),
(5, 2, 3),
(3, 3, 2),
(7, 3, 5),
(6, 4, 4),
(8, 5, 2),
(9, 6, 1),
(10, 7, 3);