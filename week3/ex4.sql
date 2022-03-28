CREATE TABLE Salesperson(
  sellerId int NOT NULL,
  PRIMARY KEY (sellerId)
);

CREATE TABLE Customer(
  customerId int NOT NULL,
  PRIMARY KEY (customerId)
);

CREATE TABLE Car(
  carId int NOT NULL,
  sellerId int NOT NULL,
  buyerId int,
  PRIMARY KEY (carId),
  FOREIGN KEY (sellerId) REFERENCES Salesperson (sellerId),
  FOREIGN KEY (buyerId) REFERENCES Customer (customerId)
);

CREATE TABLE Invoice(
  customerId int NOT NULL,
  sellerId int NOT NULL,
  carId int NOT NULL,
  cost int NOT NULL,
  PRIMARY KEY (customerId, sellerId, carId),
  FOREIGN KEY (customerId) REFERENCES Customer (customerId),
  FOREIGN KEY (sellerId) REFERENCES Salesperson (sellerId),
  FOREIGN KEY (carId) REFERENCES Car (carId)
);

CREATE TABLE ServiceTicket(
  ticketId int NOT NULL,
  customerId int NOT NULL,
  carId int NOT NULL,
  PRIMARY KEY (ticketId),
  FOREIGN KEY (customerId) REFERENCES Customer (customerId),
  FOREIGN KEY (carId) REFERENCES Car (carId)
);

CREATE TABLE Mechanic(
  mechanicId int NOT NULL,
  PRIMARY KEY (mechanicId)
);

CREATE TABLE `Repairs`(
  mechanicId int NOT NULL,
  carId int NOT NULL,
  PRIMARY KEY (mechanicId, carId),
  FOREIGN KEY (mechanicId) REFERENCES Mechanic (mechanicId),
  FOREIGN KEY (carId) REFERENCES Car (carId)
);

CREATE TABLE Part(
  partId int NOT NULL,
  PRIMARY KEY (partId)
);

CREATE TABLE Needed(
  partId int NOT NULL,
  ticketId int NOT NULL,
  quantity int NOT NULL,
  PRIMARY KEY (partId, ticketId),
  FOREIGN KEY (partId) REFERENCES Part (partId),
  FOREIGN KEY (ticketId) REFERENCES ServiceTicket (ticketId)
);