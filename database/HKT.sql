CREATE DATABASE HKT
GO

USE HKT
GO

-- Bảng User
CREATE TABLE [User] (
    UserID INT PRIMARY KEY IDENTITY(1,1)  not null,
    Fullname NVARCHAR(255) not null,
    Email NVARCHAR(255) UNIQUE,
    Phone NVARCHAR(20),
    Username NVARCHAR(255) UNIQUE not null,
    [Password] NVARCHAR(255) not null,
    [role] BIT DEFAULT 0,
	[status] BIT DEFAULT 0
);
GO

-- Bảng Status
CREATE TABLE [Status] (
    StatusID INT PRIMARY KEY IDENTITY(1,1) not null,
    [Status] NVARCHAR(255)
);
GO
--Bảng Brand
CREATE TABLE Brand (
    BrandID INT PRIMARY KEY IDENTITY(1,1) not null,
    BrandName NVARCHAR(255)
);
GO

-- Bảng ProductDetail
CREATE TABLE [ProductGroup] (
    GroupID INT PRIMARY KEY IDENTITY(1,1)  not null,
    ProductName NVARCHAR(255),
    BrandID INT,
    [Description] NVARCHAR(MAX),
	img NVARCHAR(255),
    Discount INT Default 0,
	FOREIGN KEY (BrandID) REFERENCES Brand(BrandID) 
);
GO



-- Bảng Product
CREATE TABLE [Product] (
    ProductID INT PRIMARY KEY IDENTITY(1,1)  not null,
    GroupID INT,
    RAM INT,
    Color NVARCHAR(50),
    Storage INT,
	Price INT DEFAULT 0,
    FOREIGN KEY (GroupID) REFERENCES [ProductGroup](GroupID) ON DELETE CASCADE ON UPDATE CASCADE,
);
GO

CREATE TABLE [Product_img] (
    imgID INT PRIMARY KEY IDENTITY(1,1)  not null,
	img NVARCHAR(255),
);
GO

CREATE TABLE [Group_img] (
    imgID INT,
	ProductID INT,  
	PRIMARY KEY(imgID,ProductID),
    FOREIGN KEY (ProductID) REFERENCES [Product](ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (imgID) REFERENCES [Product_img](imgID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO
--bảng Product_Details
CREATE TABLE [Product_Detail] (
    DetailID INT PRIMARY KEY IDENTITY(1,1) not null,
    GroupID INT,
	screen NVARCHAR(255),
	OS NVARCHAR(255),	
	After_cam NVARCHAR(255),
	Front_cam NVARCHAR(255),
	Chip NVARCHAR(255),
	SIM NVARCHAR(255),
	Pin NVARCHAR(255),
    FOREIGN KEY (GroupID) REFERENCES [ProductGroup](GroupID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Bảng ContactUs
CREATE TABLE [ContactUs] (
    ContactID INT PRIMARY KEY IDENTITY(1,1)  not null,
    [Date] DATETIME DEFAULT GETDATE(),
    UserID INT,
    [Message] NVARCHAR(MAX),
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
);
GO

-- Bảng Order
CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY IDENTITY(1,1)  not null,
    UserID INT,
    Amount INTEGER CHECK (Amount >= 1 AND Amount <= 100),
    [Date] DATETIME DEFAULT GETDATE(),
    [Address] NVARCHAR(255),
    [StatusID] INT Default 1,
    FOREIGN KEY (UserID) REFERENCES [User](UserID) ,
    FOREIGN KEY (StatusID) REFERENCES [Status](StatusID)
);
GO

-- Bảng OrderDetail
CREATE TABLE [OrderDetail] (
    OrderID INT,
    ProductID INT,
    UnitPrice INT DEFAULT 0,/* DECIMAL(10,2)*/
    Quantity INT DEFAULT 0,
	TotalPrice INT DEFAULT 0,
    PRIMARY KEY(OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (ProductID) REFERENCES [Product](ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (Quantity > 0)
);
GO



-- Bảng Feedback
CREATE TABLE [Feedback] (
    FeedbackID INT PRIMARY KEY IDENTITY(1,1)  not null,
    UserID INT,
    ProductID INT,
    [Date] DATETIME DEFAULT GETDATE(),
    [Message] NVARCHAR(MAX),
    Rate INT CHECK (Rate >= 1 AND Rate <= 5),
    FOREIGN KEY (UserID) REFERENCES [User](UserID) ,
    FOREIGN KEY (ProductID) REFERENCES [Product](ProductID) 
);
GO

/*CREATE TABLE Responses (
    ResponseID INT IDENTITY(1,1) PRIMARY KEY not null,
    ContactID INT NOT NULL,
    UserID INT NOT NULL,
    response TEXT NOT NULL,
    FOREIGN KEY (ContactID) REFERENCES [ContactUs](ContactID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
);
GO
*/

--add admin
INSERT INTO [User] (Fullname, Email, Phone, Username ,[Password],[role])
VALUES				
(N'Thien','thiennhse182297@fpt.edu.vn','0938440277','Thiennhse182297','123456789',1)
GO
					
					
--add customer
INSERT INTO [User] (Fullname, Email, Phone, Username, [Password])
VALUES 
('John Doe', 'john.doe@example.com', '123-456-7890', 'user1', '123'),
('Jane Smith', 'jane.smith@example.com', '098-765-4321', 'user2', '123'),
('Alice Johnson', 'alice.johnson@example.com', '555-123-4567', 'user3', '123'),
('Bob Brown', 'bob.brown@example.com', '444-555-6666', 'user4', '123'),
('Charlie White', 'charlie.white@example.com', '333-444-5555', 'user5', '123');
GO

UPDATE [User]
SET [status]=1
WHERE UserID=3

-- Sample insertion for the ContactUs table
INSERT INTO [ContactUs] (UserID, [Message])
VALUES 
(2, 'I would like to reset my password.'),
(3, 'Can you provide more information about your services?'),
(4, 'I need help with my recent order.'),
(5, 'I am experiencing technical difficulties with your website.');
GO



INSERT INTO Brand (BrandName)
VALUES 
('Apple'),
('Samsung'),
('Google'),
('Sony'),
('OnePlus');
GO
--Insert Samsung product
INSERT INTO [ProductGroup] (ProductName, img, BrandID, [Description])
VALUES 
('Samsung Galaxy A05s', 'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galaxy-a05s-sliver-thumbnew-200x200.jpg' ,2, 'The Samsung Galaxy A05s 6GB was launched in the Vietnamese market in September 2023. The phone is notable for its reasonable price, decent specs with Snapdragon 680 octa-core chip, and a quality 50 MP camera system.'),
('Samsung Galaxy A15 5G', 'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-duong-nhat-thumb-200x200.jpg', 2, 'Samsung improved its budget segment product line in 2023 with the introduction of the Samsung Galaxy A15 5G. With a unique and modern design, the product meets all criteria for performance and value with stable configuration and reasonable price.'),
('Samsung Galaxy A25 5G', 'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-5g-xanh-duong-thumb-200x200.jpg', 2, 'Samsung Galaxy A25 5G 8GB, one of the newest mid-range phones from Samsung, was launched in December 2023. The phone features a youthful design, vibrant Super AMOLED display, quality 50 MP camera, and a 5000 mAh battery for long-lasting usage.'),
('Samsung Galaxy A34 5G', 'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-5g-bac-thumb-1-200x200.jpg', 2, 'Samsung Galaxy A34 5G is a new mid-range phone introduced by Samsung in March 2023. With a perfect combination of attractive appearance and powerful configuration, the device is a perfect choice catering to the diverse needs of todays users.'),
('Samsung Galaxy A35 5G', 'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-5g-xanh-thumb-1-200x200.jpg', 2, 'Samsung Galaxy A35 5G is one of the notable mid-range smartphones from Samsung. The phone boasts powerful performance, sharp display, and a large battery, promising a diverse and excellent experience for users.'),
('Samsung Galaxy A55 5G', 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-xanh-thumb-1-200x200.jpg', 2, 'Samsung Galaxy A55 5G, the new phone in the Galaxy A series, introduces cutting-edge technologies with fast 5G connectivity. Positioned as a versatile, high-quality device at a reasonable price, it promises to be a noteworthy product in the market.'),
('Samsung Galaxy M54 5G', 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-bac-thumb-200x200.jpg', 2, 'Following the success of the Galaxy M53 5G, Samsung continues to release the Samsung Galaxy M54 5G. This time, Samsung has upgraded performance and battery capacity while improving the design to deliver the best product for you.'),
('Samsung Galaxy S23 FE 5G', 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-mint-thumbnew-200x200.jpg', 2, 'Samsung continues to dominate the smartphone market with the introduction of the Samsung Galaxy S23 FE 5G. Equipped with a 50 MP camera capable of 8K video recording and a 120 Hz display, it promises to provide an excellent experience, meeting all user needs.'),
('Samsung Galaxy S23 Ultra 5G', 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-green-thumbnew-200x200.jpg', 2, 'Samsung Galaxy S23 Ultra 5G 8GB 256GB in Moss Green, Black, Light Purple, Cream. Dynamic AMOLED 2X 6.8" display, Snapdragon 8 Gen 2 for Galaxy chip, 8 GB RAM, 5000 mAh battery.'),
('Samsung Galaxy S24 5G', 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-grey-thumb-1-200x200.jpg', 2, 'At the Unpacked 2024 event on January 18, Samsung officially launched the Samsung Galaxy S24. This product brings many unique improvements, including the use of Samsungs new chip, integrating many smart features using artificial intelligence, and significantly improving camera performance.'),
('Samsung Galaxy S24 Ultra 5G', 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-grey-thumb-200x200.jpg', 2, 'Samsung Galaxy S24 Ultra 5G 12GB 256GB in Blue, Black, Purple, Gold. Dynamic AMOLED 2X 6.8" Quad HD+ display, Snapdragon 8 Gen 3 for Galaxy chip, 12 GB RAM, 5000 mAh battery.'),
('Samsung Galaxy S24+ 5G', 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-black-thumb-200x200.jpg', 2, 'Samsung Galaxy S24+ 5G 12GB 256GB in Black, Purple, Gray, Gold. Dynamic AMOLED 2X 6.7" Quad HD+ display, Exynos 2400 chip, 12 GB RAM, 4900 mAh battery.'),
('Samsung Galaxy Z Flip5 5G', 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-z-flip5-mint-thumbnew-200x200.jpg', 2, 'Samsung Galaxy Z Flip5 5G 8GB 256GB in Mint Green, Light Purple, Cream, Gray. Dynamic AMOLED 2X 6.7" & Super AMOLED 3.4" Full HD+ display, Snapdragon 8 Gen 2 for Galaxy chip, 8 GB RAM, 3700 mAh battery.'),
('Samsung Galaxy Z Fold5 5G', 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-z-fold5-blue-thumbnew-200x200.jpg', 2, 'Samsung Galaxy Z Fold5 5G 12GB 256GB in Dark Blue, Black, Cream. Dynamic AMOLED 2X Main 7.6" & Sub 6.2" Quad HD+ (2K+) display, Snapdragon 8 Gen 2 for Galaxy chip, 12 GB RAM, 4400 mAh battery.');

GO

INSERT INTO Product_Detail(GroupID, screen, OS, [After_cam], [Front_cam], [Chip], [SIM], [Pin])
VALUES
(1, 'PLS LCD 6.7" Full HD+', 'Android 13', 'Main 50 MP & Secondary 2 MP, 2 MP', '13 MP', 'Snapdragon 680', '2 Nano SIM Support 4G', '5000 mAh 25 W'),
(2, 'Super AMOLED 6.5" Full HD+', 'Android 14', 'Main 50 MP & Secondary 5 MP, 2 MP', '13 MP', 'MediaTek Dimensity 6100+', '2 Nano SIM Support 5G', '5000 mAh 25 W'),
(3, 'Super AMOLED 6.5" Full HD+', 'Android 14', 'Main 50 MP & Secondary 8 MP, 2 MP', '13 MP', 'Exynos 1280', '2 Nano SIM Support 5G', '5000 mAh 25 W'),
(4, 'Super AMOLED 6.6" Full HD+', 'Android 13', 'Main 48 MP & Secondary 8 MP, 5 MP', '13 MP', 'MediaTek Dimensity 1080 8-core', '2 Nano SIM Support 5G', '5000 mAh 25 W'),
(5, 'Super AMOLED 6.6" Full HD+', 'Android 14', 'Main 50 MP & Secondary 8 MP, 5 MP', '13 MP', 'Exynos 1380 8-core', '2 Nano SIM Support 5G', '5000 mAh 25 W'),
(6, 'Super AMOLED 6.6" Full HD+', 'Android 14', 'Main 50 MP & Secondary 12 MP, 5 MP', '32 MP', 'Exynos 1480 8-core', '2 Nano SIM + 1 eSIM Support 5G', '5000 mAh 25 W'),
(7, 'Super AMOLED Plus 6.7" Full HD+', 'Android 13', 'Main 108 MP & Secondary 8 MP, 2 MP', '32 MP', 'Exynos 1380 8-core', '2 Nano SIM (SIM 2 shared with memory card slot) Support 5G', '6000 mAh 25 W'),
(8, 'Dynamic AMOLED 2X 6.4" Full HD+', 'Android 13', 'Main 50 MP & Secondary 12 MP, 8 MP', '10 MP', 'Exynos 2200 8-core', '2 Nano SIM or 1 Nano SIM + 1 eSIM Support 5G', '4500 mAh 25 W'),
(9, 'Dynamic AMOLED 2X 6.8" Quad HD+ (2K+)', 'Android 13', 'Main 200 MP & Secondary 12 MP, 10 MP, 10 MP', '12 MP', 'Snapdragon 8 Gen 2 for Galaxy', '2 Nano SIM or 1 Nano SIM + 1 eSIM', '5000 mAh 45 W'),
(10, 'Dynamic AMOLED 2X 6.2" Full HD+', 'Android 14', 'Main 50 MP & Secondary 12 MP, 10 MP', '12 MP', 'Exynos 2400', '2 Nano SIM or 2 eSIM or 1 Nano SIM + 1 eSIM', '4000 mAh 25 W'),
(11, 'Dynamic AMOLED 2X 6.8" Quad HD+ (2K+)', 'Android 14', 'Main 200 MP & Secondary 50 MP, 12 MP, 10 MP', '12 MP', 'Snapdragon 8 Gen 3 for Galaxy', '2 Nano SIM or 2 eSIM or 1 Nano SIM + 1 eSIM', '5000 mAh 45 W'),
(12, 'Dynamic AMOLED 2X 6.7" Quad HD+ (2K+)', 'Android 14', 'Main 50 MP & Secondary 12 MP, 10 MP', '12 MP', 'Exynos 2400', '2 Nano SIM or 2 eSIM or 1 Nano SIM + 1 eSIM', '4900 mAh 45 W'),
(13, 'Main: Dynamic AMOLED 2X, Secondary: Super AMOLED Main 6.7" & Secondary 3.4" Full HD+', 'Android 13', '2 cameras 12 MP', '10 MP', 'Snapdragon 8 Gen 2 for Galaxy', '1 Nano SIM & 1 eSIM', '3700 mAh 25 W'),
(14, 'Dynamic AMOLED 2X Main 7.6" & Secondary 6.2" Quad HD+ (2K+)', 'Android 13', 'Main 50 MP & Secondary 12 MP, 10 MP', '10 MP & 4 MP', 'Snapdragon 8 Gen 2 for Galaxy', '2 Nano SIM or 1 Nano SIM + 1 eSIM', '4400 mAh 25 W');


-- Inserting data into the Status table
INSERT INTO [Status] ([Status])
VALUES 
('Not confirmed'),
('Confirmed'),
('Cancelled');
GO

-- Inserting data into the Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price)
VALUES 
(1, 6, N'Silver', 128,176), --productID=1
(1, 6, N'Black', 128,176), --productID=2
(1, 6, N'Green', 128,176); --productID=3
GO
--
INSERT INTO [Product_img]  (img)
VALUES 
-- BẠC
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galaxy-a05s-sliver-thumbnew-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galary-a05s-bac-glr-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galary-a05s-bac-glr-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galary-a05s-bac-glr-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galary-a05s-bac-glr-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galary-a05s-bac-glr-7.jpg'),

--ĐEN
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galaxy-a05s-black-thumbnew-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galary-a05s-den-glr-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galary-a05s-den-glr-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galary-a05s-den-glr-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galary-a05s-den-glr-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galary-a05s-den-glr-6.jpg'),

--XANH LÁ
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galaxy-a05s-green-thumbnew-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galaxy-a05s-xanh-la-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galaxy-a05s-xanh-la-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galaxy-a05s-xanh-la-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galaxy-a05s-xanh-la-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/317530/samsung-galaxy-a05s-xanh-la-7.jpg');

-- Liên kết sản phẩm BẠC với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (1, 1); -- sản phẩm BẠC
INSERT INTO [Group_img] (imgID, ProductID) VALUES (2, 1);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (3, 1);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (4, 1);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (5, 1);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (6, 1);

-- Liên kết sản phẩm ĐEN với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (7, 2); -- sản phẩm ĐEN
INSERT INTO [Group_img] (imgID, ProductID) VALUES (8, 2);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (9, 2);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (10, 2);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (11, 2);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (12, 2);

-- Liên kết sản phẩm XANH LÁ với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (13, 3); -- sản phẩm XANH LÁ
INSERT INTO [Group_img] (imgID, ProductID) VALUES (14, 3);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (15, 3);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (16, 3);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (17, 3);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (18, 3);





-- Inserting data into the Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage,Price)
VALUES 
(2, 8, N'Light blue', 256,239), -- ProductID=4
(2, 8, N'Dark blue', 256,239), -- ProductID=5
(2, 8, N'Black', 256,239); -- ProductID=6

-- Inserting data into the Product_img table
INSERT INTO [Product_img] ( img)
VALUES 
-- Xanh dương nhạt
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-duong-nhat-thumb-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-nhat-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-nhat-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-nhat-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-nhat-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-nhat-7.jpg'),

--Xanh dương đậm
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-duong-dam-thumb-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-duong-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-duong-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-duong-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-duong-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-duong-7.jpg'),

--Đen
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-den-thumb-1-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-den-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-den-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-den-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-den-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319584/samsung-galaxy-a15-5g-xanh-den-7.jpg');

-- Liên kết sản phẩm Xanh dương nhạt với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (19, 4); -- sản phẩm Xanh dương nhạt
INSERT INTO [Group_img] (imgID, ProductID) VALUES (20, 4);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (21, 4);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (22, 4);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (23, 4);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (24, 4);

-- Liên kết sản phẩm Xanh dương đậm với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (25, 5); -- sản phẩm Xanh dương đậm
INSERT INTO [Group_img] (imgID, ProductID) VALUES (26, 5);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (27, 5);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (28, 5);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (29, 5);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (30, 5);

-- Liên kết sản phẩm Đen với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (31, 6); -- sản phẩm Đen
INSERT INTO [Group_img] (imgID, ProductID) VALUES (32, 6);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (33, 6);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (34, 6);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (35, 6);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (36, 6);




-- Inserting data into the Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price)
VALUES 
(3, 8,N'Blue', 128,274), -- ProductID=7
(3, 8, N'Yellow', 128,274), -- ProductID=8
(3, 8, N'Black', 128,274); -- ProductID=9

-- Inserting data into the Product_img table
INSERT INTO [Product_img] ( img)
VALUES 
-- Xanh dương
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-5g-xanh-duong-thumb-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-5g-xanh-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-5g-xanh-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-5g-xanh-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-5g-xanh-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-5g-xanh-7.jpg'),
 
--Vàng
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-5g-vang-thumb-1-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-vang-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-vang-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-vang-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-vang-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-vang-7.jpg'),
 
--Đen
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-5g-den-thumb-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-xanh-den-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-xanh-den-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-xanh-den-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-xanh-den-7.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/319904/samsung-galaxy-a25-xanh-den-10.jpg');

-- Liên kết sản phẩm Xanh dương với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (37, 7); -- sản phẩm Xanh dương
INSERT INTO [Group_img] (imgID, ProductID) VALUES (38, 7);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (39, 7);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (40, 7);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (41, 7);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (42, 7);

-- Liên kết sản phẩm Vàng với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (43, 8); -- sản phẩm Vàng
INSERT INTO [Group_img] (imgID, ProductID) VALUES (44, 8);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (45, 8);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (46, 8);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (47, 8);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (48, 8);

-- Liên kết sản phẩm Đen với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (49, 9); -- sản phẩm Đen
INSERT INTO [Group_img] (imgID, ProductID) VALUES (50, 9);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (51, 9);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (52, 9);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (53, 9);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (54, 9);


-- Inserting data into the Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price)
VALUES 
(4, 8, N'Silver', 256,258), -- ProductID=10
(4, 8, N'Black', 256,258), -- ProductID=11
(4, 8, N'Green', 256,258); -- ProductID=12

-- Inserting data into the Product_img table
INSERT INTO [Product_img] ( img)
VALUES 
-- Bạc
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-5g-bac-thumb-1-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-bac-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-bac-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-bac-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-bac-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-bac-7.jpg'),

--đen
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-5g-den-thumb-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-den-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-den-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-den-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-den-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-den-7.jpg'),

--xanh lá mạ
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-5g-xanh-la-ma-thumb-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-xanh-glr-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-xanh-glr-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-xanh-glr-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-xanh-glr-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-xanh-glr-7.jpg');

-- Liên kết sản phẩm Bạc với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (55, 10); -- sản phẩm Bạc
INSERT INTO [Group_img] (imgID, ProductID) VALUES (56, 10);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (57, 10);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (58, 10);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (59, 10);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (60, 10);

-- Liên kết sản phẩm Đen với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (61, 11); -- sản phẩm Đen
INSERT INTO [Group_img] (imgID, ProductID) VALUES (62, 11);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (63, 11);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (64, 11);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (65, 11);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (66, 11);

-- Liên kết sản phẩm Xanh lá mạ với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (67, 12); -- sản phẩm Xanh lá mạ
INSERT INTO [Group_img] (imgID, ProductID) VALUES (68, 12);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (69, 12);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (70, 12);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (71, 12);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (72, 12);


-- Inserting data into the Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage,Price)
VALUES 
(5, 8, N'Blue', 256,345), -- ProductID=13
(5, 8, N'Black', 256,345), -- ProductID=14
(5, 8, N'Yellow', 256,345); -- ProductID=15

-- Inserting data into the Product_img table
INSERT INTO [Product_img] ( img)
VALUES 
-- Xanh
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-5g-xanh-thumb-1-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-xanh-nhat-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-xanh-nhat-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-xanh-nhat-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-xanh-nhat-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-xanh-nhat-7.jpg'),
 
--đen
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-5g-den-thumb-1-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-xanh-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-xanh-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-xanh-5.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-xanh-6.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-xanh-7.jpg'),
 
--vàng
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-5g-vang-thumb-1-200x200.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-5g-vang-1.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-5g-vang-2.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-5g-vang-3.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-5g-vang-4.jpg'),
( N'https://cdn.tgdd.vn/Products/Images/42/321772/samsung-galaxy-a35-5g-vang-5.jpg');

-- Liên kết sản phẩm Xanh với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (73, 13); -- sản phẩm Xanh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (74, 13);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (75, 13);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (76, 13);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (77, 13);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (78, 13);

-- Liên kết sản phẩm Đen với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (79, 14); -- sản phẩm Đen
INSERT INTO [Group_img] (imgID, ProductID) VALUES (80, 14);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (81, 14);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (82, 14);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (83, 14);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (84, 14);

-- Liên kết sản phẩm Vàng với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (85, 15); -- sản phẩm Vàng
INSERT INTO [Group_img] (imgID, ProductID) VALUES (86, 15);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (87, 15);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (88, 15);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (89, 15);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (90, 15);

-- Thêm thông tin vào bảng Product
INSERT INTO Product (GroupID, RAM, Color, Storage,Price)
VALUES 
(6, 12, N'Blue', 256,459), -- ProductID=16
(6, 12, N'Purple', 256,459), -- ProductID=17
(6, 12, N'Black', 256,459); -- ProductID=18

-- Thêm thông tin vào bảng Product_img
INSERT INTO Product_img ( img)
VALUES 
-- Xanh
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-xanh-thumb-1-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-xanh-1-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-xanh-4-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-xanh-5-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-xanh-6.jpg'),

--tím
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-tim-thumb-1-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-tim-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-tim-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-tim-3.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-tim-5.jpg'),

--đen
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-den-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-den-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-den-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-den-3.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/322096/samsung-galaxy-a55-5g-den-5.jpg');

-- Liên kết sản phẩm Xanh với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (91, 16); -- sản phẩm Xanh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (92, 16);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (93, 16);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (94, 16);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (95, 16);

-- Liên kết sản phẩm Tím với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (96, 17); -- sản phẩm Tím
INSERT INTO [Group_img] (imgID, ProductID) VALUES (97, 17);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (98, 17);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (99, 17);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (100, 17);

-- Liên kết sản phẩm Đen với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (101, 18); -- sản phẩm Đen
INSERT INTO [Group_img] (imgID, ProductID) VALUES (102, 18);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (103, 18);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (104, 18);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (105, 18);

-- Thêm thông tin vào bảng Product
INSERT INTO Product (GroupID, RAM, Color, Storage,Price)
VALUES 
(7, 8, N'Silver', 256,353), -- ProductID=19
(7, 8, N'Dark blue', 256,353); -- ProductID=20

-- Thêm thông tin vào bảng Product_img
INSERT INTO Product_img ( img)
VALUES 
-- Bạc
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-bac-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-1-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-4.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-7.jpg'),

--xanh Dương Đậm
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-bac-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-den-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-den-4.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-den-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-den-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/275953/samsung-galaxy-m54-den-7.jpg');

-- Liên kết sản phẩm Bạc với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (106, 19); -- sản phẩm Bạc
INSERT INTO [Group_img] (imgID, ProductID) VALUES (107, 19);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (108, 19);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (109, 19);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (110, 19);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (111, 19);

-- Liên kết sản phẩm Xanh Dương Đậm với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (112, 20); -- sản phẩm Xanh Dương Đậm
INSERT INTO [Group_img] (imgID, ProductID) VALUES (113, 20);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (114, 20);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (115, 20);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (116, 20);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (117, 20);

-- Thêm thông tin vào bảng Product
INSERT INTO Product (GroupID, RAM, Color, Storage, Price)
VALUES 
(8, 8, N'Blue-Mint', 128,565), -- ProductID=21
(8, 8, N'White', 128,565); -- ProductID=22

-- Thêm thông tin vào bảng Product_img
INSERT INTO Product_img ( img)
VALUES 
-- Xanh Mint
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-mint-thumbnew-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-xanh-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-xanh-4.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-xanh-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-xanh-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-xanh-7.jpg'),
 
--trắng
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-kem-thumbnew-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-kem-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-kem-4.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-kem-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-kem-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-kem-7.jpg');

-- Liên kết sản phẩm Xanh Mint với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (118, 21); -- sản phẩm Xanh Mint
INSERT INTO [Group_img] (imgID, ProductID) VALUES (119, 21);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (120, 21);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (121, 21);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (122, 21);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (123, 21); 

-- Liên kết sản phẩm Trắng với các hình ảnh-- sản phẩm Trắng
INSERT INTO [Group_img] (imgID, ProductID) VALUES (124, 22);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (125, 22);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (126, 22);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (127, 22);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (128, 22); 
INSERT INTO [Group_img] (imgID, ProductID) VALUES (129, 22); 


-- Thêm thông tin vào bảng Product
INSERT INTO Product (GroupID, RAM, Color, Storage,Price)
VALUES 
(9, 8,N'Green', 256,900), -- ProductID=23
(9, 8, N'Black', 256,900), -- ProductID=24
(9, 8, N'Light Purple', 256,900), -- ProductID=25
(9, 8,N'Vanila', 256,900); -- ProductID=26

-- Thêm thông tin vào bảng Product_img
INSERT INTO Product_img ( img)
VALUES 
-- Xanh Rêu
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-green-thumbnew-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-xanh-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-xanh-4.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-xanh-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-xanh-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-xanh-7.jpg'),

--đen
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-thumb-den-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-1-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-4-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-5-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-7.jpg'),

--tím Nhạt
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-thumb-hong-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s-ultra-tim-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s-ultra-tim-4.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s-ultra-tim-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s-ultra-tim-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s-ultra-tim-7.jpg'),

-- Kem
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-thumb-trang-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-kem-1-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-kem-4-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-kem-5-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-kem-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-kem-7.jpg');

-- Liên kết sản phẩm Xanh Rêu với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (130, 23);
INSERT INTO Group_img (imgID, ProductID) VALUES (131, 23);
INSERT INTO Group_img (imgID, ProductID) VALUES (132, 23);
INSERT INTO Group_img (imgID, ProductID) VALUES (133, 23);
INSERT INTO Group_img (imgID, ProductID) VALUES (134, 23); -- sản phẩm Xanh Rêu
INSERT INTO Group_img (imgID, ProductID) VALUES (135, 23);

-- Liên kết sản phẩm Đen với các hình ảnh

INSERT INTO Group_img (imgID, ProductID) VALUES (136, 24);
INSERT INTO Group_img (imgID, ProductID) VALUES (137, 24);
INSERT INTO Group_img (imgID, ProductID) VALUES (138, 24);
INSERT INTO Group_img (imgID, ProductID) VALUES (139, 24);
INSERT INTO Group_img (imgID, ProductID) VALUES (140, 24); -- sản phẩm Đen
INSERT INTO Group_img (imgID, ProductID) VALUES (141, 24);

-- Liên kết sản phẩm Tím Nhạt với các hình ảnh

INSERT INTO Group_img (imgID, ProductID) VALUES (142, 25);
INSERT INTO Group_img (imgID, ProductID) VALUES (143, 25);
INSERT INTO Group_img (imgID, ProductID) VALUES (144, 25);
INSERT INTO Group_img (imgID, ProductID) VALUES (145, 25);
INSERT INTO Group_img (imgID, ProductID) VALUES (146, 25); -- sản phẩm Tím Nhạt
INSERT INTO Group_img (imgID, ProductID) VALUES (147, 25);

-- Liên kết sản phẩm Kem với các hình ảnh

INSERT INTO Group_img (imgID, ProductID) VALUES (148, 26);
INSERT INTO Group_img (imgID, ProductID) VALUES (149, 26);
INSERT INTO Group_img (imgID, ProductID) VALUES (150, 26);
INSERT INTO Group_img (imgID, ProductID) VALUES (151, 26);
INSERT INTO Group_img (imgID, ProductID) VALUES (152, 26); -- sản phẩm Kem
INSERT INTO Group_img (imgID, ProductID) VALUES (153, 26);



-- Thêm thông tin vào bảng Product
INSERT INTO Product (GroupID, RAM, Color, Storage,Price)
VALUES 
(10, 8,N'Grey', 256,930), -- ProductID=27
(10, 8, N'Black', 256,930), -- ProductID=28
(10, 8, N'Purple', 256,930), -- ProductID=29
(10, 8, N'Yellow', 256,930); -- ProductID=30

-- Thêm thông tin vào bảng Product_img
INSERT INTO Product_img ( img)
VALUES 
-- Xám
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-grey-thumb-1-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-xam-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-xam-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-xam-3.jpg'),

--đen
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-black-thumb-1-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-den-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-den-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-den-3.jpg'),

--tím
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-purple-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-tim-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-tim-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-tim-3.jpg'),

--vàng
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-yellow-thumb-200x200.png'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-vang-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-vang-4.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-vang-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-vang-6-180x125.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-vang-7-180x125.jpg');

-- Liên kết sản phẩm Xám với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (154, 27); -- sản phẩm Xám
INSERT INTO [Group_img] (imgID, ProductID) VALUES (155, 27);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (156, 27);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (157, 27);

-- Liên kết sản phẩm Đen với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (158, 28); -- sản phẩm Đen
INSERT INTO [Group_img] (imgID, ProductID) VALUES (159, 28);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (160, 28);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (161, 28);

-- Liên kết sản phẩm Tím với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (162, 29); -- sản phẩm Tím
INSERT INTO [Group_img] (imgID, ProductID) VALUES (163, 29);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (164, 29);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (165, 29);

-- Liên kết sản phẩm Vàng với các hình ảnh
INSERT INTO [Group_img] (imgID, ProductID) VALUES (166, 30); -- sản phẩm Vàng
INSERT INTO [Group_img] (imgID, ProductID) VALUES (167, 30);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (168, 30);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (169, 30);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (170, 30);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (171, 30);



-- Thêm thông tin vào bảng Product
INSERT INTO Product (GroupID, RAM, Color, Storage,Price)
VALUES 
(11, 12, N'Blue', 256,1296), -- ProductID=31
(11, 12, N'Black', 256,1296), -- ProductID=32
(11, 12, N'Purple', 256,1296), -- ProductID=33
(11, 12, N'Yellow', 256,1296); -- ProductID=34

-- Thêm thông tin vào bảng Product_img
INSERT INTO Product_img ( img)
VALUES 
-- Xanh
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-grey-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-xam-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-xam-4.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-xam-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-xam-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-xam-7.jpg'),

--đen
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-black-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-den-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-den-4.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-den-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-den-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-den-7.jpg'),

--tím
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-violet-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-tim-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-tim-4.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-tim-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-tim-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-tim-7.jpg'),

-- Vàng
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-gold-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-vang-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-vang-4.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-vang-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-vang-7.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-vang-9.jpg');

-- Liên kết sản phẩm Xanh với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (172, 31); -- sản phẩm Xanh
INSERT INTO Group_img (imgID, ProductID) VALUES (173, 31);
INSERT INTO Group_img (imgID, ProductID) VALUES (174, 31);
INSERT INTO Group_img (imgID, ProductID) VALUES (175, 31);
INSERT INTO Group_img (imgID, ProductID) VALUES (176, 31);
INSERT INTO Group_img (imgID, ProductID) VALUES (177, 31);

-- Liên kết sản phẩm Đen với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (178, 32); -- sản phẩm Đen
INSERT INTO Group_img (imgID, ProductID) VALUES (179, 32);
INSERT INTO Group_img (imgID, ProductID) VALUES (180, 32);
INSERT INTO Group_img (imgID, ProductID) VALUES (181, 32);
INSERT INTO Group_img (imgID, ProductID) VALUES (182, 32);
INSERT INTO Group_img (imgID, ProductID) VALUES (183, 32);

-- Liên kết sản phẩm Tím với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (184, 33); -- sản phẩm Tím
INSERT INTO Group_img (imgID, ProductID) VALUES (185, 33);
INSERT INTO Group_img (imgID, ProductID) VALUES (186, 33);
INSERT INTO Group_img (imgID, ProductID) VALUES (187, 33);
INSERT INTO Group_img (imgID, ProductID) VALUES (188, 33);
INSERT INTO Group_img (imgID, ProductID) VALUES (189, 33);

-- Liên kết sản phẩm Vàng với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (190, 34); -- sản phẩm Vàng
INSERT INTO Group_img (imgID, ProductID) VALUES (191, 34);
INSERT INTO Group_img (imgID, ProductID) VALUES (192, 34);
INSERT INTO Group_img (imgID, ProductID) VALUES (193, 34);
INSERT INTO Group_img (imgID, ProductID) VALUES (194, 34);
INSERT INTO Group_img (imgID, ProductID) VALUES (195, 34);




-- Thêm thông tin vào bảng Product
INSERT INTO Product (GroupID, RAM, Color, Storage,Price)
VALUES 
(12, 12, N'Black', 256,1060), -- ProductID=35
(12, 12, N'Purple', 256,1060), -- ProductID=36
(12, 12,N'Grey', 256,1060), -- ProductID=37
(12, 12, N'Yellow', 256,1060); -- ProductID=38

-- Thêm thông tin vào bảng Product_img
INSERT INTO Product_img ( img)
VALUES 
-- Đen
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-black-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-den-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-den-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-den-3.jpg'),

-- Tím
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-violet-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-tim-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-tim-2.jpg'),

-- Xám
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-grey-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-bac-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-bac-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-bac-3.jpg'),

-- Vàng
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-gold-thumb-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-vang-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-vang-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/307172/samsung-galaxy-s24-plus-vang-10.jpg');

-- Liên kết sản phẩm Đen với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (196, 35); -- sản phẩm Đen
INSERT INTO Group_img (imgID, ProductID) VALUES (197, 35);
INSERT INTO Group_img (imgID, ProductID) VALUES (198, 35);
INSERT INTO Group_img (imgID, ProductID) VALUES (199, 35);

-- Liên kết sản phẩm Tím với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (200, 36); -- sản phẩm Tím
INSERT INTO Group_img (imgID, ProductID) VALUES (201, 36);
INSERT INTO Group_img (imgID, ProductID) VALUES (202, 36);

-- Liên kết sản phẩm Xám với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (203, 37); -- sản phẩm Xám
INSERT INTO Group_img (imgID, ProductID) VALUES (204, 37);
INSERT INTO Group_img (imgID, ProductID) VALUES (205, 37);
INSERT INTO Group_img (imgID, ProductID) VALUES (206, 37);


-- Liên kết sản phẩm Vàng với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (207, 38); -- sản phẩm Vàng
INSERT INTO Group_img (imgID, ProductID) VALUES (208, 38);
INSERT INTO Group_img (imgID, ProductID) VALUES (209, 38);
INSERT INTO Group_img (imgID, ProductID) VALUES (210, 38);


-- Thêm thông tin vào bảng Product
INSERT INTO Product (GroupID, RAM, Color, Storage,Price)
VALUES 
(13, 8, N'Blue-Mint', 256,667), -- ProductID=39
(13, 8, N'Light Purple', 256,667), -- ProductID=40
(13, 8,N'Vanila', 256,667), -- ProductID=41
(13, 8,N'Grey', 256,667); -- ProductID=42

-- Thêm thông tin vào bảng Product_img
INSERT INTO Product_img ( img)
VALUES 
-- Xanh Mint
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-z-flip5-mint-thumbnew-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip5-xanh-256gb-1-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip5-xanh-256gb-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip5-xanh-256gb-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip5-xanh-256gb-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip5-xanh-256gb-7.jpg'),

-- Tím Nhạt
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-z-flip5-tim-thumbnew-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-tim-256gb-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-tim-256gb-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-tim-256gb-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-tim-256gb-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-tim-256gb-7.jpg'),

-- Kem
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-z-flip5-kem-thumbnew-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-kem-512gb-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-kem-256gb-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-kem-256gb-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-kem-256gb-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-kem-256gb-7.jpg'),

-- Xám
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-flip5-xam-thumbnew-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-xam-256gb-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-xam-256gb-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-xam-256gb-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-xam-256gb-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-zflip-5-xam-256gb-7.jpg');

-- Liên kết sản phẩm Xanh Mint với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (211, 39); -- sản phẩm Xanh Mint
INSERT INTO Group_img (imgID, ProductID) VALUES (212, 39);
INSERT INTO Group_img (imgID, ProductID) VALUES (213, 39);
INSERT INTO Group_img (imgID, ProductID) VALUES (214, 39);
INSERT INTO Group_img (imgID, ProductID) VALUES (215, 39);
INSERT INTO Group_img (imgID, ProductID) VALUES (216, 39);

-- Liên kết sản phẩm Tím Nhạt với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (217, 40); -- sản phẩm Tím Nhạt
INSERT INTO Group_img (imgID, ProductID) VALUES (218, 40);
INSERT INTO Group_img (imgID, ProductID) VALUES (219, 40);
INSERT INTO Group_img (imgID, ProductID) VALUES (220, 40);
INSERT INTO Group_img (imgID, ProductID) VALUES (221, 40);
INSERT INTO Group_img (imgID, ProductID) VALUES (222, 40);

-- Liên kết sản phẩm Kem với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (223, 41); -- sản phẩm Kem
INSERT INTO Group_img (imgID, ProductID) VALUES (224, 41);
INSERT INTO Group_img (imgID, ProductID) VALUES (225, 41);
INSERT INTO Group_img (imgID, ProductID) VALUES (226, 41);
INSERT INTO Group_img (imgID, ProductID) VALUES (227, 41);
INSERT INTO Group_img (imgID, ProductID) VALUES (228, 41);

-- Liên kết sản phẩm Xám với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (229, 42); -- sản phẩm Xám
INSERT INTO Group_img (imgID, ProductID) VALUES (230, 42);
INSERT INTO Group_img (imgID, ProductID) VALUES (231, 42);
INSERT INTO Group_img (imgID, ProductID) VALUES (232, 42);
INSERT INTO Group_img (imgID, ProductID) VALUES (233, 42);
INSERT INTO Group_img (imgID, ProductID) VALUES (234, 42);



-- Thêm thông tin vào bảng Product
INSERT INTO Product (GroupID, RAM, Color, Storage, Price)
VALUES 
(14, 12, N'Light Blue', 256,1138), -- ProductID=43
(14, 12, N'Black', 256,1138), -- ProductID=44
(14, 12,N'Vanila', 256,1138), -- ProductID=45
(14, 12, N'Light Blue', 512,1300), -- ProductID=46
(14, 12, N'Black', 512,1300), -- ProductID=47
(14, 12,N'Vanila', 512,1300); -- ProductID=48

-- Thêm thông tin vào bảng Product_img
INSERT INTO Product_img ( img)
VALUES 
-- Xanh da trời nhạt
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-z-fold5-blue-thumbnew-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-xanh-256gb-1-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-xanh-256gb-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-xanh-256gb-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-xanh-256gb-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-xanh-256gb-7.jpg'),

-- Đen
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-z-fold5-black-thumbnew-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-den-256gb-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-den-256gb-2.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-den-256gb-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-den-256gb-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-den-256gb-7.jpg'),

-- Kem
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-z-fold5-kem-thumbnew-200x200.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-kem-256gb-1-1.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-kem-256gb-5.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-kem-256gb-6.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-kem-256gb-7.jpg'),
( 'https://cdn.tgdd.vn/Products/Images/42/301608/samsung-galaxy-zfold5-kem-256gb-8.jpg');

-- Liên kết sản phẩm Xanh da trời nhạt 256GB với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (235, 43);
INSERT INTO Group_img (imgID, ProductID) VALUES (236, 43);
INSERT INTO Group_img (imgID, ProductID) VALUES (237, 43);
INSERT INTO Group_img (imgID, ProductID) VALUES (238, 43);
INSERT INTO Group_img (imgID, ProductID) VALUES (239, 43);
INSERT INTO Group_img (imgID, ProductID) VALUES (240, 43);

-- Liên kết sản phẩm Đen 256GB với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (241, 44);
INSERT INTO Group_img (imgID, ProductID) VALUES (242, 44);
INSERT INTO Group_img (imgID, ProductID) VALUES (243, 44);
INSERT INTO Group_img (imgID, ProductID) VALUES (244, 44);
INSERT INTO Group_img (imgID, ProductID) VALUES (245, 44);
INSERT INTO Group_img (imgID, ProductID) VALUES (246, 44);

-- Liên kết sản phẩm Kem 256GB với các hình ảnh
INSERT INTO Group_img (imgID, ProductID) VALUES (247, 45);
INSERT INTO Group_img (imgID, ProductID) VALUES (248, 45);
INSERT INTO Group_img (imgID, ProductID) VALUES (249, 45);
INSERT INTO Group_img (imgID, ProductID) VALUES (250, 45);
INSERT INTO Group_img (imgID, ProductID) VALUES (251, 45);
INSERT INTO Group_img (imgID, ProductID) VALUES (252, 45);

-- Liên kết sản phẩm Xanh da trời nhạt 512GB với các hình ảnh (sử dụng lại từ 235 đến 240)
INSERT INTO Group_img (imgID, ProductID) VALUES (235, 46);
INSERT INTO Group_img (imgID, ProductID) VALUES (236, 46);
INSERT INTO Group_img (imgID, ProductID) VALUES (237, 46);
INSERT INTO Group_img (imgID, ProductID) VALUES (238, 46);
INSERT INTO Group_img (imgID, ProductID) VALUES (239, 46);
INSERT INTO Group_img (imgID, ProductID) VALUES (240, 46);

-- Liên kết sản phẩm Đen 512GB với các hình ảnh (sử dụng lại từ 241 đến 246)
INSERT INTO Group_img (imgID, ProductID) VALUES (241, 47);
INSERT INTO Group_img (imgID, ProductID) VALUES (242, 47);
INSERT INTO Group_img (imgID, ProductID) VALUES (243, 47);
INSERT INTO Group_img (imgID, ProductID) VALUES (244, 47);
INSERT INTO Group_img (imgID, ProductID) VALUES (245, 47);
INSERT INTO Group_img (imgID, ProductID) VALUES (246, 47);

-- Liên kết sản phẩm Kem 512GB với các hình ảnh (sử dụng lại từ 247 đến 252)
INSERT INTO Group_img (imgID, ProductID) VALUES (247, 48);
INSERT INTO Group_img (imgID, ProductID) VALUES (248, 48);
INSERT INTO Group_img (imgID, ProductID) VALUES (249, 48);
INSERT INTO Group_img (imgID, ProductID) VALUES (250, 48);
INSERT INTO Group_img (imgID, ProductID) VALUES (251, 48);
INSERT INTO Group_img (imgID, ProductID) VALUES (252, 48);




-- Insert Apple
-- Insert into ProductGroup table
INSERT INTO [ProductGroup] (ProductName, img, BrandID, [Description])
VALUES 
('iPhone 11', 
'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-trang-600x600.jpg', 
1, 
'iPhone 11 with two color options, outstanding camera capabilities, long battery life, and the most powerful processor ever, promising an excellent experience for you.');

-- Insert into Product_Detail table
INSERT INTO Product_Detail (GroupID, screen, OS, After_cam, Front_cam, Chip, SIM, Pin)
VALUES
(15, 'IPS LCD, 6.1", Liquid Retina', 'iOS 15', '2 camera 12 MP', '12 MP', 'Apple A13 Bionic', '1 Nano SIM & 1 eSIM , Hỗ trợ 4G', '3110 mAh, 20 W');

-- Insert into Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price)
VALUES 
(15, 4, N'White', 64, 599),  -- productID=49
(15, 4, N'White', 128, 649), -- productID=50
(15, 4, N'Black', 64, 599),    -- productID=51
(15, 4, N'Black', 128, 649);   -- productID=52

-- Insert into Product_img table
INSERT INTO [Product_img] (img)
VALUES 
-- TRẮNG
(N'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-trang-1-2-org.jpg'), 
(N'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-trang-4-1-org.jpg'), 
(N'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-trang-5-1-org.jpg'),
(N'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-trang-2-1-org.jpg'), 
(N'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-trang-6-org.jpg'),   

-- ĐEN
(N'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-den-1-1-1-org.jpg'), -- imgID = 252
(N'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-den-4-1-org.jpg'), 
(N'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-den-5-1-org.jpg'),   
(N'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-den-2-1-org.jpg'),   
(N'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-den-6-org.jpg');    

-- TRẮNG 64GB
-- Đen 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (253, 49);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (254, 49);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (255, 49);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (256, 49);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (257, 49);

-- Trắng 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (253, 50);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (254, 50);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (255, 50);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (256, 50);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (257, 50);

-- Đen 64GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (258, 51);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (259, 51);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (260, 51);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (261, 51);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (262, 51);

-- Đen 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (258, 52);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (259, 52);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (260, 52);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (261, 52);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (262, 52);

GO


-- Insert into ProductGroup table
INSERT INTO [ProductGroup] (ProductName, img, BrandID, [Description])
VALUES 
('iPhone 12', 
'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-trang-13-600x600.jpg', 
1, 
'Apple has equipped the latest chip (as of November 2020) for iPhone 12, the A14 Bionic, manufactured on a 5nm process for improved performance stability compared to the A13 chip in the previous iPhone 11 model.');

-- Insert into Product_Detail table
INSERT INTO Product_Detail (GroupID, screen, OS, After_cam, Front_cam, Chip, SIM, Pin)
VALUES
(16, 'OLED, 6.1", Super Retina XDR', 'iOS 15', '2 camera 12 MP', '12 MP', 'Apple A14 Bionic', '1 Nano SIM & 1 eSIM , Hỗ trợ 5G', '2815 mAh, 20 W');

-- Insert into Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price)
VALUES 
(16, 4,N'Red', 64, 699),   -- productID=53
(16, 4,N'Red', 128, 749),  -- productID=54
(16, 4, N'White', 64, 699),-- productID=55
(16, 4, N'White', 128, 749),-- productID=56
(16, 4, N'Black', 64, 699),  -- productID=57
(16, 4, N'Black', 128, 749), -- productID=58
(16, 4,N'Blue', 64, 699),-- productID=59
(16, 4,N'Blue', 128, 749),-- productID=60
(16, 4, N'Green', 64, 699),-- productID=61
(16, 4, N'Green', 128, 749),-- productID=62
(16, 4, N'Purple', 64, 699),  -- productID=63
(16, 4, N'Purple', 128, 749); -- productID=64

-- Insert into Product_img table
INSERT INTO [Product_img] (img)
VALUES 
-- ĐỎ
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-do-1-1-org.jpg'), -- imgID = 263
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-do-4-org.jpg'),   -- imgID = 258
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-do-5-1-org.jpg'), -- imgID = 259
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-do-2-org.jpg'),   -- imgID = 260
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-do-9-org.jpg'),   -- imgID = 261

-- TRẮNG
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-trang-1-1-org.jpg'), -- imgID = 26
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-trang-4-org.jpg'),   -- imgID = 263
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-trang-5-1-org.jpg'), -- imgID = 264
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-trang-2-org.jpg'),   -- imgID = 265
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-trang-11-org.jpg'),  -- imgID = 266

-- ĐEN
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-den-1-1-org.jpg'),   -- imgID = 267
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-den-4-org.jpg'),     -- imgID = 268
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-den-5-1-org.jpg'),   -- imgID = 269
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-den-2-org.jpg'),     -- imgID = 270
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-den-6-org.jpg'),     -- imgID = 271

-- XANH DƯƠNG
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-xanh-duong-1-1-org.jpg'), -- imgID = 272
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-xanh-duong-4-1-org.jpg'), -- imgID = 273
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-xanh-duong-5-1-org.jpg'), -- imgID = 274
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-xanh-duong-2-org.jpg'),   -- imgID = 275
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-xanh-duong-6-org.jpg'),   -- imgID = 276

-- XANH LÁ
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-xanh-la-1-1-org.jpg'),    -- imgID = 277
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-xanh-la-4-org.jpg'),      -- imgID = 278
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-xanh-la-5-1-org.jpg'),    -- imgID = 279
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-xanh-la-2-org.jpg'),      -- imgID = 280
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-xanh-la-6-org.jpg'),      -- imgID = 281

-- TÍM
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-1-2.jpg'),                -- imgID = 282
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-4-1.jpg'),                -- imgID = 283
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-5-1.jpg'),                -- imgID = 284
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-2-1.jpg'),                -- imgID = 285
(N'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-6.jpg');                  -- imgID = 286

-- ĐỎ 64GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (263, 53);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (264, 53);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (265, 53);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (266, 53);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (267, 53);

-- ĐỎ 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (263, 54);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (264, 54);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (265, 54);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (266, 54);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (267, 54);

-- TRẮNG 64GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (268, 55);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (269, 55);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (270, 55);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (271, 55);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (272, 55);



-- TRẮNG 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (268, 56);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (269, 56);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (270, 56);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (271, 56);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (272, 56);


-- ĐEN 64GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (273, 57);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (274, 57);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (275, 57);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (276, 57);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (277, 57);


-- ĐEN 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (273, 58);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (274, 58);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (275, 58);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (276, 58);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (277, 58);

-- XANH DƯƠNG 64GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (278, 59);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (279, 59);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (280, 59);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (281, 59);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (282, 59);

-- XANH DƯƠNG 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (278, 60);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (279, 60);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (280, 60);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (281, 60);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (282, 60);

-- XANH LÁ 64GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (283, 61);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (284, 61);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (285, 61);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (286, 61);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (287, 61);

-- XANH LÁ 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (283, 62);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (284, 62);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (285, 62);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (286, 62);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (287, 62);

-- TÍM 64GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (288, 63);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (289, 63);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (290, 63);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (291, 63);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (292, 63);

-- TÍM 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (288, 64);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (289, 64);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (290, 64);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (291, 64);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (292, 64);




GO

-- Insert into ProductGroup table
INSERT INTO [ProductGroup] (ProductName, img, BrandID, [Description])
VALUES 
('iPhone 13', 
'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-pink-2-600x600.jpg', 
1, 
'iPhone 13 will come in 4 different versions with unchanged dimensions compared to the current iPhone 12 series. While the iPhone 12 underwent a design change from rounded edges (a design maintained from iPhone 6 to iPhone 11 Pro Max) to a more squared-off design (previously seen on iPhone 4 to iPhone 5S, SE).');

-- Insert into Product_Detail table
INSERT INTO Product_Detail (GroupID, screen, OS, After_cam, Front_cam, Chip, SIM, Pin)
VALUES
(17, 'OLED, 6.1", Super Retina XDR', 'iOS 15', '2 camera 12 MP', '12 MP', 'Apple A15 Bionic', '1 Nano SIM & 1 eSIM , Hỗ trợ 5G', '3240 mAh, 20 W');

-- Insert into Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price)
VALUES 
(17, 4, N'HỒNG', 128, 799),    -- productID=65
(17, 4, N'HỒNG', 256, 899),    -- productID=66
(17, 4, N'White', 128, 799),   -- productID=67
(17, 4, N'White', 256, 899),   -- productID=68
(17, 4, N'Black', 128, 799),     -- productID=69
(17, 4, N'Black', 256, 899),     -- productID=70
(17, 4,N'Blue', 128, 799), -- productID=71
(17, 4,N'Blue', 256, 899), -- productID=72
(17, 4, N'Green', 128, 799); -- productID=73

-- Insert into Product_img table
INSERT INTO [Product_img] (img)
VALUES 
-- HỒNG
(N'https://cdn.tgdd.vn/Products/Images/42/250258/iphone-13-1.jpg'),    -- imgID = 287
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-4-2.jpg'), -- imgID = 288
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-5-2.jpg'), -- imgID = 289
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-2-2.jpg'), -- imgID = 290
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-6-2.jpg'), -- imgID = 291

-- TRẮNG
(N'https://cdn.tgdd.vn/Products/Images/42/250258/iphone-13-1-2.jpg'), -- imgID = 292
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-4-3.jpg'), -- imgID = 293
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-5-3.jpg'), -- imgID = 294
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-2-3.jpg'), -- imgID = 295
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-6-3.jpg'), -- imgID = 296

-- ĐEN
(N'https://cdn.tgdd.vn/Products/Images/42/250258/iphone-13-1-1.jpg'), -- imgID = 297
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-4-1.jpg'), -- imgID = 298
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-5-1.jpg'), -- imgID = 299
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-2-1.jpg'), -- imgID = 300
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-6-1.jpg'), -- imgID = 301

-- XANH DƯƠNG
(N'https://cdn.tgdd.vn/Products/Images/42/250258/iphone-13-xanh-1.jpg'), -- imgID = 302
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-4.jpg'), -- imgID = 303
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-5.jpg'), -- imgID = 304
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-2.jpg'), -- imgID = 305
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-6.jpg'), -- imgID = 306

-- XANH LÁ
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-1.jpg'), -- imgID = 307
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-2.jpg'), -- imgID = 308
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-4.jpg'), -- imgID = 309
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-5.jpg'), -- imgID = 310
(N'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-6.jpg'); -- imgID = 311

-- Insert into Group_img table
-- HỒNG 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (293, 65);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (294, 65);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (295, 65);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (296, 65);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (297, 65);

-- TRẮNG 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (293, 66);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (294, 66);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (295, 66);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (296, 66);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (297, 66);

-- TRẮNG 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (298, 67);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (299, 67);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (300, 67);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (301, 67);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (302, 67);

-- ĐEN 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (298, 68);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (299, 68);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (300, 68);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (301, 68);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (302, 68);

-- ĐEN 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (303, 69);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (304, 69);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (305, 69);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (306, 69);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (307, 69);

-- XANH DƯƠNG 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (308, 70);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (309, 70);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (310, 70);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (311, 70);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (312, 70);

-- XANH DƯƠNG 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (308, 71);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (309, 71);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (310, 71);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (311, 71);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (312, 71);

-- XANH LÁ 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (313, 72);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (314, 72);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (315, 72);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (316, 72);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (317, 72);
GO

-- Insert into ProductGroup table
-- Insert into ProductGroup table
INSERT INTO [ProductGroup] (ProductName, img, BrandID, [Description])
VALUES 
('iPhone 14 Plus', 
'https://cdn.tgdd.vn/Products/Images/42/245545/iPhone-14-thumb-tim-200x200.jpg', 
1, 
'iPhone 14 Plus features a Super Retina XDR OLED display with a notch design, 6.7-inch size, incorporating True Tone, HDR, and Haptic Touch technologies. The product is equipped with a powerful A15 Bionic chip, 6GB of RAM, 128GB of internal storage, and runs on iOS 16. The dual 12MP camera improves low-light shooting capabilities, and the True Depth 12MP front camera features autofocus.');

-- Insert into Product_Detail table
INSERT INTO Product_Detail (GroupID, screen, OS, After_cam, Front_cam, Chip, SIM, Pin)
VALUES
(18, 'OLED, 6.7", Super Retina XDR', 'iOS 16', '2 camera 12 MP', '12 MP', 'Apple A15 Bionic', '1 Nano SIM & 1 eSIM , Hỗ trợ 5G', '4325 mAh, 20 W');

-- Insert into Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price)
VALUES 
(18, 6, N'Light Purple', 128, 1199),  -- productID=74
(18, 6, N'Light Purple', 256, 1299), -- productID=75
(18, 6, N'White', 128, 1199),    -- productID=76
(18, 6, N'White', 256, 1299),    -- productID=77
(18, 6, N'Black', 128, 1199),      -- productID=78
(18, 6, N'Black', 256, 1299),      -- productID=79
(18, 6,N'Blue', 128, 1199), -- productID=80
(18, 6,N'Blue', 256, 1299); -- productID=81

-- Insert into Product_img table
INSERT INTO [Product_img] (img)
VALUES 
-- Tím nhạt
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-ti-4-1.jpg'), -- imgID = 312
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-ti-5-1.jpg'), -- imgID = 313
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-ti-2-1.jpg'), -- imgID = 314
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-ti-6-1.jpg'), -- imgID = 315

-- Trắng
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-trang-4.jpg'), -- imgID = 316
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-trang-5.jpg'), -- imgID = 317
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-trang-2.jpg'), -- imgID = 318
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-trang-6.jpg'), -- imgID = 319

-- Đen
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-den-4.jpg'), -- imgID = 320
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-den-5.jpg'), -- imgID = 321
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-den-2.jpg'), -- imgID = 322
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-den-6.jpg'), -- imgID = 323

-- Xanh dương
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-xanh-4.jpg'), -- imgID = 324
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-xanh-5.jpg'), -- imgID = 325
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-xanh-2.jpg'), -- imgID = 326
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-xanh-6.jpg'); -- imgID = 327

-- Insert into Group_img table
-- Tím nhạt 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (318, 74);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (319, 74);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (320, 74);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (321, 74);

-- Tím nhạt 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (318, 75);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (319, 75);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (320, 75);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (321, 75);

-- Trắng 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (322, 76);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (323, 76);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (324, 76);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (325, 76);

-- Trắng 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (322, 77);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (323, 77);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (324, 77);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (325, 77);

-- Đen 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (326, 78);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (327, 78);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (328, 78);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (329, 78);

-- Đen 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (326, 79);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (327, 79);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (328, 79);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (329, 79);

-- Xanh dương 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (330, 80);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (331, 80);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (332, 80);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (333, 80);

-- Xanh dương 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (330, 81);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (331, 81);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (332, 81);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (333, 81);



GO

-- Insert into ProductGroup table
INSERT INTO [ProductGroup] (ProductName, img, BrandID, [Description], Discount)
VALUES 
('iPhone 14 Pro Max', 
'https://cdn.tgdd.vn/Products/Images/42/289700/iphone-14-pro-max-tim-thumb-200x200.jpg', 
1, 
'iPhone 14 Pro Max features an impressive Dynamic Island display design along with a 6.7-inch OLED screen that supports always-on display. It delivers outstanding performance with the A16 Bionic chip. Additionally, the device includes camera upgrades with a 48MP rear camera and a 12MP front camera, paired with 6GB of RAM for superior multitasking.',
30);

-- Insert into Product_Detail table
INSERT INTO Product_Detail (GroupID, screen, OS, After_cam, Front_cam, Chip, SIM, Pin)
VALUES
(19, N'OLED, 6.7 ,Super Retina XDR', N'iOS 16', N'Chính 48 MP & Phụ 12 MP, 12 MP', N'12 MP', N'Apple A16 Bionic', N'1 Nano SIM & 1 eSIM , Hỗ trợ 5G', N'4323 mAh, 20 W');

-- Insert into Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price)
VALUES 
(19, 6, N'Purple', 128, 1399),   -- productID=82
(19, 6, N'Purple', 256, 1499),   -- productID=83
(19, 6, N'Purple', 512, 1699),   -- productID=84
(19, 6, N'Purple', 1024, 1999),  -- productID=85
(19, 6, N'Silver', 128, 1399),   -- productID=86
(19, 6, N'Silver', 256, 1499),   -- productID=87
(19, 6, N'Silver', 512, 1699),   -- productID=88
(19, 6, N'Silver', 1024, 1999);  -- productID=89

-- Insert into Product_img table
INSERT INTO [Product_img] (img)
VALUES 
-- Tím
(N'https://cdn.tgdd.vn/Products/Images/42/289700/iphone-14-pro-max-purple-4.jpg'), -- imgID = 328
(N'https://cdn.tgdd.vn/Products/Images/42/289700/iphone-14-pro-max-purple-5.jpg'), -- imgID = 329
(N'https://cdn.tgdd.vn/Products/Images/42/289700/iphone-14-pro-max-purple-2.jpg'), -- imgID = 330
(N'https://cdn.tgdd.vn/Products/Images/42/289700/iphone-14-pro-max-purple-6.jpg'), -- imgID = 331

-- Bạc
(N'https://cdn.tgdd.vn/Products/Images/42/289700/iphone-14-pro-max-bac-4.jpg'), -- imgID = 332
(N'https://cdn.tgdd.vn/Products/Images/42/289700/iphone-14-pro-max-bac-5.jpg'), -- imgID = 333
(N'https://cdn.tgdd.vn/Products/Images/42/289700/iphone-14-pro-max-bac-2.jpg'), -- imgID = 334
(N'https://cdn.tgdd.vn/Products/Images/42/289700/iphone-14-pro-max-bac-6.jpg'); -- imgID = 335

-- Insert into Group_img table
-- Tím 128GB
-- Tím 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (334, 82);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (335, 82);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (336, 82);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (337, 82);

-- Tím 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (334, 83);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (335, 83);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (336, 83);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (337, 83);

-- Tím 512GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (334, 84);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (335, 84);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (336, 84);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (337, 84);

-- Tím 1TB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (334, 85);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (335, 85);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (336, 85);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (337, 85);

-- Bạc 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (338, 86);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (339, 86);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (340, 86);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (341, 86);

-- Bạc 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (338, 87);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (339, 87);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (340, 87);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (341, 87);

-- Bạc 512GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (338, 88);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (339, 88);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (340, 88);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (341, 88);

-- Bạc 1TB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (338, 89);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (339, 89);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (340, 89);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (341, 89);


GO

-- Insert into ProductGroup table
-- Insert into ProductGroup table
INSERT INTO [ProductGroup] (ProductName, img, BrandID, [Description], Discount)
VALUES 
(N'iPhone 14 Pro', 
N'https://minhtuanmobile.com/uploads/products/220908112351-iphone-14-pro-128gb1.jpg',
1, 
N'Apple always brings improvements to its iPhone models year after year, and this year iPhone 14 Pro sees significant upgrades in performance and design, promising users the most complete experience for the iPhone 14 series.',
20);


-- Insert into Product_Detail table
INSERT INTO Product_Detail (GroupID, screen, OS, After_cam, Front_cam, Chip, SIM, Pin)
VALUES
(20, N'OLED, 6.1", Super Retina XDR', N'iOS 16', N'Chính 48 MP & Phụ 12 MP, 12 MP', N'12 MP', N'Apple A16 Bionic', N'1 Nano SIM & 1 eSIM , Hỗ trợ 5G', N'3200 mAh, 20 W');

-- Insert into Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price)
VALUES 
(20, 6, N'Purple', 128, 1299),   -- productID=90
(20, 6, N'Purple', 256, 1399),   -- productID=91
(20, 6, N'Purple', 512, 1599),   -- productID=92
(20, 6, N'Purple', 1024, 1899),  -- productID=93
(20, 6, N'Silver', 128, 1299),   -- productID=94
(20, 6, N'Silver', 256, 1399),   -- productID=95
(20, 6, N'Silver', 512, 1599),   -- productID=96
(20, 6, N'Silver', 1024, 1899),  -- productID=97
(20, 6, N'Yellow', 128, 1299),  -- productID=98
(20, 6, N'Yellow', 256, 1399),  -- productID=99
(20, 6, N'Yellow', 512, 1599),  -- productID=100
(20, 6, N'Yellow', 1024, 1899), -- productID=101
(20, 6, N'Black', 128, 1299),   -- productID=102
(20, 6, N'Black', 256, 1399),   -- productID=103
(20, 6, N'Black', 512, 1599),   -- productID=104
(20, 6, N'Black', 1024, 1899);  -- productID=105

-- Insert into Product_img table
INSERT INTO [Product_img] (img)
VALUES 
-- Tím
(N'https://minhtuanmobile.com/uploads/products/220908112351-iphone-14-pro-128gb1.jpg'), -- imgID = 336
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-tim-4.jpg'), -- imgID = 337
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-tim-1-1.jpg'), -- imgID = 338
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-tim-2.jpg'), -- imgID = 339
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-tim-3.jpg'), -- imgID = 340

-- Bạc
(N'https://ionevn.vn/wp-content/uploads/2022/11/iphone-14-pro-max-512gb-mau-bac-ione-vn.png'), -- imgID = 341
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-trang-4.jpg'), -- imgID = 342
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-trang-5.jpg'), -- imgID = 343
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-trang-2.jpg'), -- imgID = 344
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-trang-6.jpg'), -- imgID = 345

-- Vàng
(N'https://chamsocdidongviet.com/upload/product/cham-soc-di-dong-viet-iphone14-pro-1-4856.jpeg'), -- imgID = 346
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone14-pro-4.jpg'), -- imgID = 347
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone14-pro-5.jpg'), -- imgID = 348
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone14-pro-2.jpg'), -- imgID = 349
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone14-pro-6.jpg'), -- imgID = 350

-- Đen
(N'https://2tmobile.com/wp-content/uploads/2022/09/iphone-14-pro-6-1inch-space-black-2tmobile.jpg'), -- imgID = 351
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-den-4.jpg'), -- imgID = 352
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-den-1-1.jpg'), -- imgID = 353
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-den-2.jpg'), -- imgID = 354
(N'https://cdn.tgdd.vn/Products/Images/42/289694/iphone-14-pro-den-3.jpg'); -- imgID = 355

-- Insert into Group_img table for Tím
-- Tím 128GB
-- Insert into Group_img table for Tím
-- Tím 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (342, 90);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (343, 90);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (344, 90);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (345, 90);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (346, 90);

-- Tím 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (342, 91);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (343, 91);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (344, 91);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (345, 91);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (346, 91);

-- Tím 512GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (342, 92);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (343, 92);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (344, 92);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (345, 92);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (346, 92);

-- Tím 1TB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (342, 93);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (343, 93);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (344, 93);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (345, 93);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (346, 93);


-- Bạc 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (347, 94);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (348, 94);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (349, 94);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (350, 94);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (351, 94);

-- Bạc 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (347, 95);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (348, 95);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (349, 95);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (350, 95);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (351, 95);

-- Bạc 512GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (347, 96);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (348, 96);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (349, 96);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (350, 96);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (351, 96);

-- Bạc 1TB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (347, 97);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (348, 97);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (349, 97);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (350, 97);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (351, 97);


-- Vàng 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (352, 98);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (353, 98);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (354, 98);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (355, 98);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (356, 98);

-- Vàng 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (352, 99);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (353, 99);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (354, 99);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (355, 99);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (356, 99);

-- Vàng 512GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (352, 100);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (353, 100);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (354, 100);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (355, 100);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (356, 100);

-- Vàng 1TB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (352, 101);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (353, 101);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (354, 101);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (355, 101);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (356, 101);


-- Đen 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (357, 102);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (358, 102);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (359, 102);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (360, 102);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (361, 102);

-- Đen 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (357, 103);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (358, 103);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (359, 103);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (360, 103);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (361, 103);

-- Đen 512GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (357, 104);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (358, 104);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (359, 104);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (360, 104);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (361, 104);

-- Đen 1TB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (357, 105);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (358, 105);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (359, 105);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (360, 105);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (361, 105);



-- Insert into ProductGroup table
-- Insert into ProductGroup table
INSERT INTO [ProductGroup] (ProductName, img, BrandID, [Description], Discount)
VALUES 
(N'iPhone 14', 'https://cdn.tgdd.vn/Products/Images/42/240259/iPhone-14-thumb-tim-1-200x200.jpg', 1, N'iPhone 14 features a 6.1-inch Retina XDR OLED display with outstanding brightness up to 1200 nits. The phone is equipped with dual 12 MP rear cameras and a large pixel sensor, achieving 1.9-micron pixel size to improve low-light photography. The new iPhone 14 also houses the Apple A15 Bionic chip with a 5-core GPU, delivering superior performance.', 20);

-- Insert into Product_Detail table
-- Insert into Product_Detail table
INSERT INTO Product_Detail (GroupID, screen, OS, After_cam, Front_cam, Chip, SIM, Pin)
VALUES
(21, N'OLED, 6.1, Super Retina XDR', N'iOS 16', N'Main 12 MP & Secondary 12 MP', '12 MP' ,N'Apple A15 Bionic', N'1 Nano SIM & 1 eSIM, 5G support', N'4325 mAh, 20 W');
-- Insert into Product table
INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price)
VALUES 
(21, 6, N'Light Purple', 128, 1299),   -- productID=106
(21, 6, N'Light Purple', 256, 1399),   -- productID=107
(21, 6, N'White', 128, 1299),   -- productID=108
(21, 6, N'White', 256, 1399),   -- productID=109
(21, 6, N'Black', 128, 1299),   -- productID=110
(21, 6, N'Black', 256, 1399),   -- productID=111
(21, 6,N'Blue', 128, 1299),   -- productID=112
(21, 6,N'Blue', 256, 1399);   -- productID=113

-- Insert into Product_img table
-- Tím nhạt
INSERT INTO [Product_img] (img)
VALUES 
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iPhone-14-thumb-tim-1-200x200.jpg'), -- full
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-ti-4-1.jpg'), -- front
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-tim-1-3.jpg'), -- behind
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-tim-2-1.jpg'), -- side
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-tim-3-1.jpg'), -- camera

-- Trắng
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iPhone-14-thumb-trang-200x200.jpg'), -- full
(N'https://cdn.tgdd.vn/Products/Images/42/289710/iphone-14-plus-trang-4.jpg'), -- front
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-trang-1-1.jpg'), -- behind
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-trang-2.jpg'), -- side
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-trang-3.jpg'), -- camera

-- Đen
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iPhone-14-plus-thumb-den-200x200.jpg'), -- full
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-den-glr-4.jpg'), -- front
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-den-glr-5.jpg'), -- behind
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-den-glr-2.jpg'), -- side
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-den-glr-6.jpg'), -- camera

-- Xanh dương
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iPhone-14-plus-thumb-xanh-200x200.jpg'), -- full
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-xanh-4.jpg'), -- front
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-xanh-5.jpg'), -- behind
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-xanh-2.jpg'), -- side
(N'https://cdn.tgdd.vn/Products/Images/42/240259/iphone-14-xanh-6.jpg'); -- camera

-- Insert into Group_img table for Tím nhạt 128GB

INSERT INTO [Group_img] (imgID, ProductID) VALUES (362, 106);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (363, 106);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (364, 106);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (365, 106);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (366, 106);

-- Insert into Group_img table for Tím nhạt 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (362, 107);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (363, 107);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (364, 107);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (365, 107);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (366, 107);

-- Insert into Group_img table for Trắng 128GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (367, 108);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (368, 108);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (369, 108);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (370, 108);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (371, 108);

-- Insert into Group_img table for Trắng 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (367, 109);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (368, 109);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (369, 109);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (370, 109);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (371, 109);

-- Insert into Group_img table for Đen 128GB

INSERT INTO [Group_img] (imgID, ProductID) VALUES (372, 110);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (373, 110);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (374, 110);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (375, 110);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (376, 110);

-- Insert into Group_img table for Đen 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (372, 111);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (373, 111);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (374, 111);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (375, 111);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (376, 111);

-- Insert into Group_img table for Xanh dương 128GB

INSERT INTO [Group_img] (imgID, ProductID) VALUES (377, 112);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (378, 112);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (379, 112);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (380, 112);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (381, 112);

-- Insert into Group_img table for Xanh dương 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (377, 113);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (378, 113);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (379, 113);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (380, 113);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (381, 113);



-- Insert into ProductGroup table for iPhone 15
INSERT INTO [ProductGroup] (ProductName, img, BrandID, [Description],[Discount])
VALUES 
(N'iPhone 15', 
N'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/iphone-15-plus_1__1.png', 
1, 
N'iPhone 15 is equipped with a 6.1-inch Dynamic Island display with Super Retina XDR technology, providing superior image experience. The phone features a frosted glass back to resist sweat and comes in 4 color options: Light Pink, Black, Light Blue, and Light Green. The camera is upgraded to a 48 MP main sensor with 2x optical zoom capability. iPhone 15 also has a USB-C charging port and a 3349 mAh battery capacity.'
,10);

INSERT INTO Product_Detail (GroupID, screen, OS, After_cam, Front_cam, Chip, SIM, Pin)
VALUES
(22, N'OLED, 6.1", Super Retina XDR', N'iOS 17', N'Main 48 MP & Secondary 12 MP', N'12 MP', N'Apple A16 Bionic', N'1 Nano SIM & 1 eSIM, 5G support', N'3349 mAh, 20 W');

-- Insert into Product table for iPhone 15
INSERT INTO [Product] (GroupID, RAM, Color, Storage, Price)
VALUES 
(22, 6, N'Light Pink', 128, 1399),   -- productID=114
(22, 6, N'Light Pink', 256, 1499),   -- productID=115
(22, 6, N'Black', 128, 1399),   -- productID=116
(22, 6, N'Black', 256, 1499),   -- productID=117
(22, 6, N'Light blue', 128, 1399),   -- productID=118
(22, 6, N'Light blue', 256, 1499),   -- productID=119
(22, 6, N'Light Green', 128, 1399),   -- productID=120
(22, 6, N'Light Green', 256, 1499);   -- productID=121

-- Insert into Product_img table for iPhone 15
-- Hồng nhạt
INSERT INTO [Product_img] (img)
VALUES 
(N'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/iphone-15-plus_1__1.png'), -- full
(N'https://cdn2.cellphones.com.vn/x/media/catalog/product/v/n/vn_iphone_15_pink_pdp_image_position-2_design_2.jpg'), -- behind
(N'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-128gb-hong-2.jpg'), -- side
(N'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-128gb-hong-3-1.jpg'); -- camera

-- Đen
INSERT INTO [Product_img] (img)
VALUES 
(N'https://cdn.tgdd.vn/Products/Images/42/303716/iphone-15-den-thumb-200x200.jpg'), -- full
(N'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/n/vn_iphone_15_black_pdp_image_position-1b_black_color.jpg'), -- front
(N'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/n/vn_iphone_15_black_pdp_image_position-2_design.jpg'), -- behind
(N'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-den-2.jpg'), -- side
(N'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-den-6.jpg'); -- camera

-- Xanh dương nhạt
INSERT INTO [Product_img] (img)
VALUES 
(N'https://cdn.tgdd.vn/Products/Images/42/303716/iphone-15-xanh-thumb-200x200.jpg'), -- full
(N'https://cdn2.cellphones.com.vn/x/media/catalog/product/v/n/vn_iphone_15_blue_pdp_image_position-1b_blue_color.jpg'), -- front
(N'https://cdn2.cellphones.com.vn/x/media/catalog/product/v/n/vn_iphone_15_blue_pdp_image_position-2_design.jpg'), -- behind
(N'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-128gb-xanh-2.jpg'), -- side
(N'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-128gb-xanh-3.jpg'); -- camera

-- Xanh lá nhạt
INSERT INTO [Product_img] (img)
VALUES 
(N'https://cdn.tgdd.vn/Products/Images/42/303716/iphone-15-xanh-la-thumb-200x200.jpg'), -- full
(N'https://cdn2.cellphones.com.vn/x/media/catalog/product/v/n/vn_iphone_15_green_pdp_image_position-1b_green_color.jpg'), -- front
(N'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/n/vn_iphone_15_green_pdp_image_position-1a_green_color_1_4.jpg'), -- behind
(N'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-128gb-xanh-la-2.jpg'), -- side
(N'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-128gb-xanh-la-3.jpg'); -- camera

-- Insert into Group_img table for Hồng nhạt 128GB

INSERT INTO [Group_img] (imgID, ProductID) VALUES (382, 114);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (383, 114);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (384, 114);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (385, 114);

-- Insert into Group_img table for Hồng nhạt 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (382, 115);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (383, 115);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (384, 115);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (385, 115);

-- Insert into Group_img table for Đen 128GB

INSERT INTO [Group_img] (imgID, ProductID) VALUES (386, 116);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (387, 116);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (388, 116);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (389, 116);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (390, 116);

-- Insert into Group_img table for Đen 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (386, 117);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (387, 117);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (388, 117);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (389, 117);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (390, 117);

-- Insert into Group_img table for Xanh dương nhạt 128GB


INSERT INTO [Group_img] (imgID, ProductID) VALUES (391, 118);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (392, 118);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (393, 118);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (394, 118);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (395, 118);
-- Insert into Group_img table for Xanh dương nhạt 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (390, 119);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (391, 119);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (392, 119);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (393, 119);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (394, 119);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (395, 119);

-- Insert into Group_img table for Xanh lá nhạt 128GB

INSERT INTO [Group_img] (imgID, ProductID) VALUES (396, 120);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (397, 120);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (398, 120);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (399, 120);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (400, 120);

-- Insert into Group_img table for Xanh lá nhạt 256GB
INSERT INTO [Group_img] (imgID, ProductID) VALUES (396, 121);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (397, 121);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (398, 121);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (399, 121);
INSERT INTO [Group_img] (imgID, ProductID) VALUES (400, 121);


-- Inserting data into the Order table
INSERT INTO [Order] (UserID, Amount, [Address], [StatusID])
VALUES 
(2, 2, '123 Elm Street, Springfield', 1),
(3, 1, '456 Oak Street, Shelbyville', 2),
(4, 1, '789 Pine Street, Capital City', 3),
(5, 1, '101 Maple Avenue, Ogdenville', 2),
(6, 1, '202 Birch Road, North Haverbrook', 3);
GO

-- Inserting data into the OrderDetail table
INSERT INTO [OrderDetail] (OrderID, ProductID, UnitPrice, Quantity)
VALUES 
(1, 1, 352, 2),
(1, 2, 176, 1),
(2, 3, 528, 3),
(3, 4, 239, 1),
(4, 5, 478, 2);




-- Inserting data into the Feedback table
INSERT INTO [Feedback] (UserID, ProductID, [Message], Rate)
VALUES 
(1, 1, 'Great product, highly recommended!', 5),
(2, 1, 'Good quality but could improve in some areas.', 4),
(3, 1, 'Average product, not too impressed.', 3),
(4, 1, 'Excellent service and product!', 5),
(5, 1, 'Disappointed with the product quality.', 2);

-- Insert feedback data for ProductID 2 to 22, each with 5 users
INSERT INTO Feedback (UserID, ProductID, Date, Message, Rate)
VALUES 
    (2, 2, GETDATE(), 'Good quality but a bit expensive.', 4),
    (3, 2, GETDATE(), 'Average performance.', 3),
    (4, 2, GETDATE(), 'Exceeded my expectations!', 5),
    (5, 2, GETDATE(), 'Not satisfied with the battery life.', 2),
    
    (2, 3, GETDATE(), 'Value for money.', 4),
    (3, 3, GETDATE(), 'Could be better.', 3),
    (4, 3, GETDATE(), 'Fantastic product, will buy again.', 5),
    (5, 3, GETDATE(), 'Had some issues with the software.', 3),
    

    (2, 4, GETDATE(), 'Decent product for the price.', 4),
    (3, 4, GETDATE(), 'Not up to the mark.', 2),
    (4, 4, GETDATE(), 'Highly efficient and user-friendly.', 5),
    (5, 4, GETDATE(), 'Had high expectations but disappointed.', 2),

    (2, 5, GETDATE(), 'Satisfactory performance.', 4),
    (3, 5, GETDATE(), 'Could have been better.', 3),
    (4, 5, GETDATE(), 'Very happy with the purchase.', 5),
    (5, 5, GETDATE(), 'Not worth the price.', 2),
    
    (2, 6, GETDATE(), 'Quite good but can be improved.', 4),
    (3, 6, GETDATE(), 'Mediocre experience.', 3),
    (4, 6, GETDATE(), 'Love the design!', 5),
    (5, 6, GETDATE(), 'Battery life is not as expected.', 2),

    -- Continue for ProductID 7 to 21
    (2, 7, GETDATE(), 'Happy with the purchase.', 4),
    (3, 7, GETDATE(), 'Average, not too impressive.', 3),
    (4, 7, GETDATE(), 'Outstanding product!', 5),
    (5, 7, GETDATE(), 'Disappointed with the performance.', 2);
	go 
	CREATE PROCEDURE DeleteOrder
    @OrderID INT
AS
BEGIN
    -- Start a transaction
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- Delete the order details
        DELETE FROM OrderDetail WHERE OrderID = @OrderID;
        
        -- Delete the order
        DELETE FROM [Order] WHERE OrderID = @OrderID;
        
        -- Commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction in case of an error
        ROLLBACK TRANSACTION;
        
        -- Throw the error
        THROW;
    END CATCH
END;
go 
CREATE PROCEDURE DeleteUserAndRelatedData
    @userID INT
AS
BEGIN
    -- Bắt đầu một giao dịch
    BEGIN TRANSACTION;

    -- Xóa các bản ghi từ bảng OrderDetail trước
    DELETE FROM OrderDetail
    WHERE OrderID IN (SELECT OrderID FROM [Order] WHERE UserID = @userID);

    -- Xóa từ bảng Order
    DELETE FROM [Order]
    WHERE UserID = @userID;

    -- Xóa từ các bảng liên quan khác

    DELETE FROM feedback
    WHERE UserID = @userID;

    DELETE FROM contactUs
    WHERE UserID = @userID;

    -- Cuối cùng xóa từ bảng User
    DELETE FROM [User]
    WHERE UserID = @userID;

    -- Commit giao dịch
    COMMIT TRANSACTION;
END;
