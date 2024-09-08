-- Створення процедур
DELIMITER //

CREATE PROCEDURE GetProductsRunningLow(IN Threshold INT)
BEGIN
    DECLARE operation varchar(100);
    SET operation = CONCAT('EXEC GetProductsRunningLow @Threshold = ', Threshold);
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (operation, current_timestamp());

    SELECT 
        m.id AS MaterialID,
        t.`Name` AS ProductName,
        m.countOnStorage AS QuantityOnStorage,
        m.Sold AS QuantitySold,
        (m.countOnStorage - m.Sold) AS QuantityAvailable
    FROM Materials m
    JOIN `Type` t ON m.`Type` = t.id
    WHERE (m.countOnStorage - m.Sold) <= Threshold;
END;
//


DELIMITER //
CREATE PROCEDURE GenerateProductRanking()
BEGIN
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES ('EXEC GenerateProductRanking', current_timestamp());

    SELECT 
        t.id AS TypeID,
        t.`Name` AS ProductName,
        t.Price AS ProductPrice,
        t.Manufacturer AS ManufacturerID,
        mf.`Name` AS ManufacturerName,
        SUM(m.Sold) AS TotalSales
    FROM Type t
    JOIN Materials m ON t.id = m.`Type`
    JOIN Manufacturer mf ON t.Manufacturer = mf.id
    GROUP BY t.id, t.`Name`, t.Price, t.Manufacturer, mf.`Name`
    ORDER BY TotalSales DESC;
END;
//

DELIMITER //
CREATE PROCEDURE SearchProducts(
    IN GroupName VARCHAR(60),
    IN MinPrice INT,
    IN MaxPrice INT,
    IN ProductName VARCHAR(60),
    IN ManufacturerName VARCHAR(60)
)
BEGIN
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES ('EXEC SearchProducts',current_timestamp());

    SELECT 
        t.id AS TypeID,
        t.`Name` AS ProductName,
        t.Price AS ProductPrice,
        t.Manufacturer AS ManufacturerID,
        m.`Name` AS ManufacturerName
    FROM `Type` t
    JOIN Manufacturer m ON t.Manufacturer = m.id
    WHERE
        (GroupName IS NULL OR t.`Name` = GroupName)
        AND (MinPrice IS NULL OR t.Price >= MinPrice)
        AND (MaxPrice IS NULL OR t.Price <= MaxPrice)
        AND (ProductName IS NULL OR t.`Name` LIKE CONCAT('%', ProductName, '%'))
        AND (ManufacturerName IS NULL OR m.`Name` LIKE CONCAT('%', ManufacturerName, '%'));
END;
//

DELIMITER //
CREATE PROCEDURE GetProductInfo(
    IN MaterialID INT,
    IN ManufacturerID INT
)
BEGIN
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES ('EXEC GetProductInfo', current_timestamp());

    SELECT 
        t.id AS TypeID,
        t.`Name` AS ProductName,
        t.Price AS ProductPrice,
        t.Manufacturer AS ManufacturerID,
        mf.`Name` AS ManufacturerName,
        mi.`Count` AS QuantityInOrder
    FROM Type t
    JOIN Manufacturer mf ON t.Manufacturer = mf.id
    LEFT JOIN Materials ma ON t.id = ma.`Type`
    LEFT JOIN MaterialInOrder mi ON ma.id = mi.Material
    WHERE
        (MaterialID IS NULL OR t.id = MaterialID)
        AND (ManufacturerID IS NULL OR mf.id = ManufacturerID);
END;
//

-- Процедури зміни даних у таблицях
DELIMITER //
CREATE PROCEDURE InsertManufacturer(IN `Name` VARCHAR(60))
BEGIN
    INSERT INTO Manufacturer (`Name`)
    VALUES (`Name`);
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('INSERT INTO Manufacturer (Name) VALUES (', `Name`, ')'), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE UpdateManufacturer(IN Id INT, IN `Name` VARCHAR(60))
BEGIN
    UPDATE Manufacturer
    SET `Name` = `Name`
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('UPDATE Manufacturer SET Name = ', `Name`, ' WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE DeleteManufacturer(IN Id INT)
BEGIN
    DELETE FROM Manufacturer
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('DELETE FROM Manufacturer WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE InsertWorker(
    IN VisibleId VARCHAR(10),
    IN FullName VARCHAR(100),
    IN Phone VARCHAR(15),
    IN Post VARCHAR(30)
)
BEGIN
    INSERT INTO Worker (VisibleId, FullName, Phone, Post)
    VALUES (VisibleId, FullName, Phone, Post);
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('INSERT INTO Worker (VisibleId, FullName, Phone, Post) VALUES (', VisibleId, ', ', FullName, ', ', Phone, ', ', Post, ')'), CURRENT_TIMESTAMP());
END;
//

DELIMITER //
CREATE PROCEDURE UpdateWorker(
    IN Id INT,
    IN VisibleId VARCHAR(10),
    IN FullName VARCHAR(100),
    IN Phone VARCHAR(15),
    IN Post VARCHAR(30)
)
BEGIN
    UPDATE Worker
    SET VisibleId = VisibleId, FullName = FullName, Phone = Phone, Post = Post
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('UPDATE Worker SET VisibleId = ', VisibleId, ', FullName = ', FullName, ', Phone = ', Phone, ', Post = ', Post, ' WHERE id = ', Id), CURRENT_TIMESTAMP());
END;
//

DELIMITER //
CREATE PROCEDURE DeleteWorker(IN Id INT)
BEGIN
    DELETE FROM Worker
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('DELETE FROM Worker WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE InsertType(
    IN `Name` VARCHAR(60),
    IN Price INT,
    IN Manufacturer INT,
    IN TypeOfPackaging VARCHAR(40),
    IN `Description` VARCHAR(200)
)
BEGIN
    INSERT INTO Type (`Name`, Price, Manufacturer, TypeOfPackaging, `Description`)
    VALUES (`Name`, Price, Manufacturer, TypeOfPackaging, `Description`);
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('INSERT INTO Type (Name, Price, Manufacturer, TypeOfPackaging, Description) VALUES (', `Name`, ', ', Price, ', ', Manufacturer, ', ', TypeOfPackaging, ', ', `Description`, ')'), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE UpdateType(
    IN Id INT,
    IN `Name` VARCHAR(60),
    IN Price INT,
    IN Manufacturer INT,
    IN TypeOfPackaging VARCHAR(40),
    IN `Description` VARCHAR(200)
)
BEGIN
    UPDATE Type
    SET `Name` = `Name`, Price = Price, Manufacturer = Manufacturer, TypeOfPackaging = TypeOfPackaging, `Description` = `Description`
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('UPDATE Type SET Name = ', `Name`, ', Price = ', Price, ', Manufacturer = ', Manufacturer, ', TypeOfPackaging = ', TypeOfPackaging, ', Description = ', `Description`, ' WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE DeleteType(IN Id INT)
BEGIN
    DELETE FROM `Type`
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('DELETE FROM Type WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE InsertMaterials(
    IN Type INT,
    IN CountOnStorage INT,
    IN Sold INT
)
BEGIN
    INSERT INTO Materials (`Type`, CountOnStorage, Sold)
    VALUES (`Type`, CountOnStorage, Sold);
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('INSERT INTO Materials (Type, CountOnStorage, Sold) VALUES (', `Type`, ', ', CountOnStorage, ', ', Sold, ')'), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE UpdateMaterials(
    IN Id INT,
    IN `Type` INT,
    IN CountOnStorage INT,
    IN Sold INT
)
BEGIN
    UPDATE Materials
    SET `Type` = `Type`, CountOnStorage = CountOnStorage, Sold = Sold
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('UPDATE Materials SET Type = ', `Type`, ', CountOnStorage = ', CountOnStorage, ', Sold = ', Sold, ' WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE DeleteMaterials(IN Id INT)
BEGIN
    DELETE FROM Materials
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('DELETE FROM Materials WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE InsertShipment(
    IN Ordered DATE,
    IN MaterialType INT,
    IN `Count` INT,
    IN ClaimedDate DATE,
    IN OrderedBy INT
)
BEGIN
    INSERT INTO Shipment (Ordered, MaterialType, Count, ClaimedDate, OrderedBy)
    VALUES (Ordered, MaterialType, Count, ClaimedDate, OrderedBy);
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('INSERT INTO Shipment (Ordered, MaterialType, Count, ClaimedDate, OrderedBy) VALUES (', Ordered, ', ', MaterialType, ', ', Count, ', ', ClaimedDate, ', ', OrderedBy, ')'), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE UpdateShipment(
    IN Id INT,
    IN Ordered DATE,
    IN MaterialType INT,
    IN `Count` INT,
    IN ClaimedDate DATE,
    IN OrderedBy INT
)
BEGIN
    UPDATE Shipment
    SET Ordered = Ordered, MaterialType = MaterialType, Count = Count, ClaimedDate = ClaimedDate, OrderedBy = OrderedBy
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('UPDATE Shipment SET Ordered = ', Ordered, ', MaterialType = ', MaterialType, ', Count = ', `Count`, ', ClaimedDate = ', ClaimedDate, ', OrderedBy = ', OrderedBy, ' WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE DeleteShipment(IN Id INT)
BEGIN
    DELETE FROM Shipment
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('DELETE FROM Shipment WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE InsertClientFeedBack(
    IN Material INT,
    IN `Date` DATE,
    IN Score INT,
    IN Text VARCHAR(500)
)
BEGIN
    INSERT INTO ClientFeedBack (Material, `Date`, Score, `Text`)
    VALUES (Material, `Date`, Score, `Text`);
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('INSERT INTO ClientFeedBack (Material, Date, Score, Text) VALUES (', Material, ', ', `Date`, ', ', Score, ', ', `Text`, ')'), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE UpdateClientFeedBack(
    IN Id INT,
    IN Material INT,
    IN `Date` DATE,
    IN Score INT,
    IN `Text` VARCHAR(500)
)
BEGIN
    UPDATE ClientFeedBack
    SET Material = Material, `Date` = `Date`, Score = Score, `Text` = `Text`
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('UPDATE ClientFeedBack SET Material = ', Material, ', Date = ', `Date`, ', Score = ', Score, ', Text = ', `Text`, ' WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE DeleteClientFeedBack(IN Id INT)
BEGIN
    DELETE FROM ClientFeedBack
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('DELETE FROM ClientFeedBack WHERE id = ', Id), current_timestamp());
END;
//

CREATE PROCEDURE InsertClientOrder(
    IN IdForClient VARCHAR(30),
    IN IdWorker INT,
    IN `Date` DATE,
    IN Claimed DATE
)
BEGIN
    INSERT INTO ClientOrder (IdForClient, IdWorker, `Date`, Claimed)
    VALUES (IdForClient, IdWorker, `Date`, Claimed);
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('INSERT INTO ClientOrder (IdForClient, IdWorker, Date, Claimed) VALUES (', IdForClient, ', ', IdWorker, ', ', `Date`, ', ', Claimed, ')'), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE UpdateClientOrder(
    IN Id INT,
    IN IdForClient VARCHAR(30),
    IN IdWorker INT,
    IN `Date` DATE,
    IN Claimed DATE
)
BEGIN
    UPDATE ClientOrder
    SET IdForClient = IdForClient, IdWorker = IdWorker, Date = Date, Claimed = Claimed
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('UPDATE ClientOrder SET IdForClient = ', IdForClient, ', IdWorker = ', IdWorker, ', Date = ', `Date`, ', Claimed = ', Claimed, ' WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE DeleteClientOrder(IN Id INT)
BEGIN
    DELETE FROM ClientOrder
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('DELETE FROM ClientOrder WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE InsertMaterialInOrder(
    IN Material INT,
    IN `Count` INT,
    IN ToOrder INT
)
BEGIN
    INSERT INTO MaterialInOrder (Material, `Count`, ToOrder)
    VALUES (Material, `Count`, ToOrder);
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('INSERT INTO MaterialInOrder (Material, Count, ToOrder) VALUES (', Material, ', ', Count, ', ', ToOrder, ')'), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE UpdateMaterialInOrder(
    IN Id INT,
    IN Material INT,
    IN `Count` INT,
    IN ToOrder INT
)
BEGIN
    UPDATE MaterialInOrder
    SET Material = Material, `Count` = `Count`, ToOrder = ToOrder
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('UPDATE MaterialInOrder SET Material = ', Material, ', Count = ', Count, ', ToOrder = ', ToOrder, ' WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER //
CREATE PROCEDURE DeleteMaterialInOrder(IN Id INT)
BEGIN
    DELETE FROM MaterialInOrder
    WHERE id = Id;
    
    INSERT INTO HistoryLog (Operation, `Date`)
    VALUES (CONCAT('DELETE FROM MaterialInOrder WHERE id = ', Id), current_timestamp());
END;
//

DELIMITER ;