USE HardwareStore_DB;

INSERT INTO Manufacturer (`Name`) VALUES
('Cemex'),
('Holcim'),
('Lafarge');

INSERT INTO Worker (VisibleId, FullName, Phone, Post) VALUES
('W001', 'John Doe', '1234567890', 'Manager'),
('W002', 'Jane Smith', '0987654321', 'Salesperson'),
('W003', 'Alice Johnson', '1231231234', 'Technician'),
('W004', 'Bob Brown', '3213214321', 'Accountant'),
('W005', 'Charlie Davis', '4564564567', 'Salesperson'),
('W006', 'Eve White', '7897897890', 'Technician'),
('W007', 'Frank Black', '1112223334', 'Manager'),
('W008', 'Grace Green', '4445556667', 'Salesperson'),
('W009', 'Hank Yellow', '7778889990', 'Technician'),
('W010', 'Ivy Blue', '2223334445', 'Accountant');

INSERT INTO Type (`Name`, Price, Manufacturer, typeOfPackaging, `description`) VALUES
('Cement', 100, 1, 'Bag', 'Portland cement'),
('Sand', 50, 2, 'Bag', 'Fine river sand'),
('Gravel', 70, 3, 'Bag', 'Coarse gravel'),
('Bricks', 500, 1, 'Pallet', 'Red clay bricks'),
('Lime', 150, 2, 'Bag', 'Hydrated lime'),
('Steel Rebars', 600, 3, 'Bundle', 'Steel reinforcing bars'),
('Concrete Blocks', 800, 1, 'Pallet', 'Concrete masonry units'),
('Plywood', 200, 2, 'Sheet', 'Construction-grade plywood'),
('Glass Wool', 300, 3, 'Roll', 'Insulation material'),
('Paint', 50, 1, 'Can', 'Acrylic paint');

INSERT INTO Materials (`Type`, countOnStorage, Sold) VALUES
(1, 200, 150),
(2, 300, 250),
(3, 100, 80),
(4, 50, 40),
(5, 150, 120),
(6, 70, 50),
(7, 80, 60),
(8, 90, 70),
(9, 60, 40),
(10, 110, 90);

INSERT INTO Shipment (Ordered, MaterialType, `count`, ClaimedDate, OrderedBy) VALUES
('2023-01-01', 1, 50, '2023-01-05', 1),
('2023-01-02', 2, 60, '2023-01-06', 2),
('2023-01-03', 3, 40, '2023-01-07', 3),
('2023-01-04', 4, 30, '2023-01-08', 4),
('2023-01-05', 5, 70, '2023-01-09', 5),
('2023-01-06', 6, 50, '2023-01-10', 6),
('2023-01-07', 7, 60, '2023-01-11', 7),
('2023-01-08', 8, 40, '2023-01-12', 8),
('2023-01-09', 9, 50, '2023-01-13', 9),
('2023-01-10', 10, 60, '2023-01-14', 10);

INSERT INTO ClientFeedBack (Material, `Date`, Score, `Text`) VALUES
(1, '2023-02-01', 8, 'High quality cement'),
(2, '2023-02-02', 9, 'Excellent sand'),
(3, '2023-02-03', 7, 'Good gravel'),
(4, '2023-02-04', 6, 'Decent bricks'),
(5, '2023-02-05', 10, 'Very good lime'),
(6, '2023-02-06', 5, 'Mediocre steel rebars'),
(7, '2023-02-07', 8, 'Nice concrete blocks'),
(8, '2023-02-08', 9, 'Good plywood'),
(9, '2023-02-09', 7, 'Fine glass wool'),
(10, '2023-02-10', 10, 'Amazing paint');

INSERT INTO ClientOrder (IdForClient, IdWorker, `Date`, Claimed) VALUES
('C001', 1, '2023-03-01', '2023-03-05'),
('C002', 2, '2023-03-02', '2023-03-06'),
('C003', 3, '2023-03-03', '2023-03-07'),
('C004', 4, '2023-03-04', '2023-03-08'),
('C005', 5, '2023-03-05', '2023-03-09'),
('C006', 6, '2023-03-06', '2023-03-10'),
('C007', 7, '2023-03-07', '2023-03-11'),
('C008', 8, '2023-03-08', '2023-03-12'),
('C009', 9, '2023-03-09', '2023-03-13'),
('C010', 10, '2023-03-10', '2023-03-14');

INSERT INTO MaterialInOrder (Material, `Count`, ToOrder) VALUES
(1, 10, 1),
(2, 20, 2),
(3, 15, 3),
(4, 5, 4),
(5, 25, 5),
(6, 30, 6),
(7, 8, 7),
(8, 18, 8),
(9, 12, 9),
(10, 22, 10);
