USE HardwareStore_DB;

-- Триггер для таблиці Manufacturer
DELIMITER //

CREATE TRIGGER trg_Manufacturer_Log
AFTER INSERT ON Manufacturer
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('INSERT on Manufacturer', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_Manufacturer_Log_Update
AFTER UPDATE ON Manufacturer
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('UPDATE on Manufacturer', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_Manufacturer_Log_Delete
AFTER DELETE ON Manufacturer
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('DELETE on Manufacturer', CURRENT_TIMESTAMP());
END //

-- Триггер для таблиці Worker
CREATE TRIGGER trg_Worker_Log
AFTER INSERT ON Worker
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('INSERT on Worker', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_Worker_Log_Update
AFTER UPDATE ON Worker
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('UPDATE on Worker', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_Worker_Log_Delete
AFTER DELETE ON Worker
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('DELETE on Worker', CURRENT_TIMESTAMP());
END //

-- Триггер для таблиці Type
CREATE TRIGGER trg_Type_Log
AFTER INSERT ON `Type`
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('INSERT on Type', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_Type_Log_Update
AFTER UPDATE ON `Type`
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('UPDATE on Type', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_Type_Log_Delete
AFTER DELETE ON `Type`
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('DELETE on Type', CURRENT_TIMESTAMP());
END //

-- Триггер для таблиці Materials
CREATE TRIGGER trg_Materials_Log
AFTER INSERT ON Materials
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('INSERT on Materials', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_Materials_Log_Update
AFTER UPDATE ON Materials
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('UPDATE on Materials', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_Materials_Log_Delete
AFTER DELETE ON Materials
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('DELETE on Materials', CURRENT_TIMESTAMP());
END //

-- Триггер для таблиці Shipment
CREATE TRIGGER trg_Shipment_Log
AFTER INSERT ON Shipment
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('INSERT on Shipment', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_Shipment_Log_Update
AFTER UPDATE ON Shipment
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('UPDATE on Shipment', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_Shipment_Log_Delete
AFTER DELETE ON Shipment
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('DELETE on Shipment', CURRENT_TIMESTAMP());
END //

-- Триггер для таблиці ClientFeedBack
CREATE TRIGGER trg_ClientFeedBack_Log
AFTER INSERT ON ClientFeedBack
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('INSERT on ClientFeedBack', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_ClientFeedBack_Log_Update
AFTER UPDATE ON ClientFeedBack
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('UPDATE on ClientFeedBack', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_ClientFeedBack_Log_Delete
AFTER DELETE ON ClientFeedBack
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('DELETE on ClientFeedBack', CURRENT_TIMESTAMP());
END //

-- Триггер для таблиці ClientOrder
CREATE TRIGGER trg_ClientOrder_Log
AFTER INSERT ON ClientOrder
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('INSERT on ClientOrder', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_ClientOrder_Log_Update
AFTER UPDATE ON ClientOrder
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('UPDATE on ClientOrder', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_ClientOrder_Log_Delete
AFTER DELETE ON ClientOrder
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('DELETE on ClientOrder', CURRENT_TIMESTAMP());
END //

-- Триггер для таблиці MaterialInOrder
CREATE TRIGGER trg_MaterialInOrder_Log
AFTER INSERT ON MaterialInOrder
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('INSERT on MaterialInOrder', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_MaterialInOrder_Log_Update
AFTER UPDATE ON MaterialInOrder
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('UPDATE on MaterialInOrder', CURRENT_TIMESTAMP());
END //

CREATE TRIGGER trg_MaterialInOrder_Log_Delete
AFTER DELETE ON MaterialInOrder
FOR EACH ROW
BEGIN
    INSERT INTO HistoryLog (Operation, Date)
    VALUES ('DELETE on MaterialInOrder', CURRENT_TIMESTAMP());
END //

DELIMITER ;
