CREATE TABLE Customer (
  clientId int NOT NULL,
  balance int NOT NULL,
  discount int NOT NULL,
  creditLimit int NOT NULL,
  PRIMARY KEY (clientId)
);

CREATE TABLE ShippingAddress (
  addrId int NOT NULL,
  clientId int NOT NULL,
  houseNum int NOT NULL,
  street char(20) NOT NULL,
  district char(20),
  city char(20) NOT NULL,
  PRIMARY KEY (addrId),
  FOREIGN KEY (clientId) REFERENCES Customer (clientId)
);

CREATE TABLE `Order` (
  orderId int NOT NULL,
  ordDate date NOT NULL,
  addrId int NOT NULL,
  PRIMARY KEY (orderId),
  FOREIGN KEY (addrId) REFERENCES ShippingAddress (addrId)
);

CREATE TABLE PlaceA (
  clientId int NOT NULL,
  orderId int NOT NULL,
  PRIMARY KEY (clientId, orderId),
  FOREIGN KEY (clientId) REFERENCES Customer (clientId),
  FOREIGN KEY (orderId) REFERENCES `Order` (orderId)
);

CREATE TABLE Item (
  itemId int NOT NULL,
  description char(50),
  PRIMARY KEY (itemId)
);

CREATE TABLE Includes (
  itemId int NOT NULL,
  orderId int NOT NULL,
  quantity int NOT NULL,
  PRIMARY KEY (itemId, orderId),
  FOREIGN KEY (itemId) REFERENCES Item (itemId),
  FOREIGN KEY (orderId) REFERENCES `Order`(orderId)
);

CREATE TABLE Manufacturer (
  manufacturerId int NOT NULL,
  phoneNumber char(11),
  PRIMARY KEY (manufacturerId)
);

CREATE TABLE Produces (
  manufacturerId int NOT NULL,
  itemId int NOT NULL,
  quantity int NOT NULL,
  PRIMARY KEY (itemId, manufacturerId),
  FOREIGN KEY (itemId) REFERENCES Item (itemId),
  FOREIGN KEY (manufacturerId) REFERENCES Manufacturer (manufacturerId)
);