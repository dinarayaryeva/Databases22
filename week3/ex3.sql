CREATE TABLE Airport (
  IATAcode int NOT NULL,
  PRIMARY KEY (IATAcode)
);

CREATE TABLE AircraftType(
  typeId int NOT NULL,
  PRIMARY KEY (typeId)
);

CREATE TABLE CanLand(
  typeId int NOT NULL,
  IATAcode int NOT NULL,
  PRIMARY KEY (typeId, IATAcode),
  FOREIGN KEY (typeId) REFERENCES AircraftType (typeId),
  FOREIGN KEY (IATAcode) REFERENCES Airport (IATAcode)
);

CREATE TABLE Flight (
  flightNum int NOT NULL,
  PRIMARY KEY (flightNum)
);

CREATE TABLE FlightLeg (
  flightLegId int NOT NULL,
  flightNum int NOT NULL,
  PRIMARY KEY (flightLegId),
  FOREIGN KEY (flightNum) REFERENCES Flight (flightNum)
);

CREATE TABLE DailyFlightLegCombination (
  DFLegId int NOT NULL,
  typeId int NOT NULL,
  flightLegId int NOT NULL,
  PRIMARY KEY (DFLegId),
  FOREIGN KEY (typeId) REFERENCES AircraftType (typeId),
  FOREIGN KEY (flightLegId) REFERENCES FlightLeg (flightLegId)
);

CREATE TABLE `Schedule` (
  IATAcode int NOT NULL,
  startFLId int NOT NULL,
  endFLId int NOT NULL,
  FOREIGN KEY (IATAcode) REFERENCES Airport (IATAcode),
  FOREIGN KEY (startFLId) REFERENCES FlightLeg (flightLegId),
  FOREIGN KEY (endFLId) REFERENCES FlightLeg (flightLegId)
);