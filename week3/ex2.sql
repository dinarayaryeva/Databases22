CREATE TABLE `Group` (
  groupId int NOT NULL,
  PRIMARY KEY (groupId)
);

CREATE TABLE Company (
  companyId int NOT NULL,
  parentId int,
  groupId int NOT NULL,
  PRIMARY KEY (companyId),
  FOREIGN KEY (groupId) REFERENCES `Group` (groupId)
);

CREATE TABLE Plant (
  plantId int NOT NULL,
  companyId int NOT NULL,
  PRIMARY KEY (plantId),
  FOREIGN KEY (companyId) REFERENCES Company (companyId)
);

CREATE TABLE Item (
  itemId int NOT NULL,
  plantId int NOT NULL,
  PRIMARY KEY (itemId),
  FOREIGN KEY (plantId) REFERENCES Plant (plantId)
); 