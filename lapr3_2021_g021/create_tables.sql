-- drop existing tables to avoid naming conflicts
DROP TABLE StorageType CASCADE CONSTRAINTS PURGE;
DROP TABLE Storage CASCADE CONSTRAINTS PURGE;
DROP TABLE Container CASCADE CONSTRAINTS PURGE;
DROP TABLE Container_CargoManifest CASCADE CONSTRAINTS PURGE;
DROP TABLE Storage_User_Staff CASCADE CONSTRAINTS PURGE;
DROP TABLE Role CASCADE CONSTRAINTS PURGE;
DROP TABLE SystemUser CASCADE CONSTRAINTS PURGE;
DROP TABLE User_Shipment CASCADE CONSTRAINTS PURGE;
DROP TABLE Shipment CASCADE CONSTRAINTS PURGE;
DROP TABLE CargoManifest CASCADE CONSTRAINTS PURGE;
DROP TABLE Truck CASCADE CONSTRAINTS PURGE;
DROP TABLE Fleet CASCADE CONSTRAINTS PURGE;
DROP TABLE Ship CASCADE CONSTRAINTS PURGE;
DROP TABLE DynamicData CASCADE CONSTRAINTS PURGE;

-- create tables
CREATE TABLE StorageType
(
    storageType_id INT GENERATED ALWAYS AS IDENTITY
        CONSTRAINT pkStorageType PRIMARY KEY,
    name           VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Storage
(
    identification INT(10)
        CONSTRAINT pkIdentification PRIMARY KEY,
    name           VARCHAR(20)  NOT NULL,
    continent      VARCHAR(20)  NOT NULL,
    country        VARCHAR(20)  NOT NULL,
    latitude       NUMBER(4, 2) NOT NULL,
    CONSTRAINT ckLatitude CHECK (latitude BETWEEN -90 AND 91),
    longitude      NUMBER(5, 2) NOT NULL,
    CONSTRAINT ckLongitude CHECK (longitude BETWEEN -180 AND 181),
    CONSTRAINT ckStorageLocation UNIQUE (latitude, longitude)
);

CREATE TABLE Container
(
    container_num INT(10)
        CONSTRAINT pkContainerNum PRIMARY KEY,
    check_digit   INT(1)       NOT NULL,
    iso_code      VARCHAR(4)   NOT NULL,
    gross_weight  INT(7)       NOT NULL,
    CONSTRAINT ckGrossWeight CHECK (gross_weight >= 0),
    tare_weight   INT(7)       NOT NULL,
    CONSTRAINT ckTareWeight CHECK (tare_weight >= 0),
    payload       INT(7)       NOT NULL,
    CONSTRAINT ckPayload CHECK (payload >= 0),
    max_volume    NUMBER(4, 1) NOT NULL,
    CONSTRAINT ckMaxVolume CHECK (max_volume >= 0),
    refrigerated  INT(1)       NOT NULL,
    CONSTRAINT ckRefrigerated CHECK (refrigerated BETWEEN 0 AND 1)
);

CREATE TABLE Container_CargoManifest
(
    container_position_x INT(10) NOT NULL,
    container_position_y INT(10) NOT NULL,
    container_position_z INT(10) NOT NULL
);

CREATE TABLE Storage_User_Staff
(
);

CREATE TABLE Role
(
    role_id INT(10) GENERATED ALWAYS AS IDENTITY
        CONSTRAINT pkRoleId PRIMARY KEY,
    name    VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE SystemUser
(
    user_id INT(10) GENERATED ALWAYS AS IDENTITY
        CONSTRAINT pkUserId PRIMARY KEY,
    name    VARCHAR(20) NOT NULL,
    email   VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE User_Shipment
(
);

CREATE TABLE Shipment
(
    shipment_id INT(10) GENERATED ALWAYS AS IDENTITY
        CONSTRAINT pkShipmentId PRIMARY KEY
);

CREATE TABLE CargoManifest
(
    manifest_id  INT(10) GENERATED ALWAYS AS IDENTITY
        CONSTRAINT pkManifestId PRIMARY KEY,
    loading_flag INT(1) NOT NULL,
    CONSTRAINT ckLoadingFlag CHECK (loading_flag BETWEEN 0 AND 1)
);

CREATE TABLE Truck
(
    truck_id INT(10) GENERATED ALWAYS AS IDENTITY
        CONSTRAINT pkTruckId PRIMARY KEY
);

CREATE TABLE Fleet
(
    fleet_id INT(10) GENERATED ALWAYS AS IDENTITY
        CONSTRAINT pkFleetId PRIMARY KEY
);

CREATE TABLE Ship
(
    mmsi          INT(9)
        CONSTRAINT pkMMSI PRIMARY KEY,
    CONSTRAINT ckMMSI CHECK (mmsi BETWEEN 100000000 AND 999999999),
    name          VARCHAR(20)  NOT NULL,
    imo           INT(7)       NOT NULL UNIQUE,
    CONSTRAINT ckIMO CHECK (imo BETWEEN 1000000 AND 9999999),
    num_generator INT(3)       NOT NULL,
    CONSTRAINT ckNumGenerator CHECK (num_generator >= 0),
    gen_power     NUMBER(5, 2) NOT NULL,
    CONSTRAINT ckGenPower CHECK (gen_power >= 0),
    callsign      VARCHAR(8)   NOT NULL UNIQUE,
    vessel_type   INT(2)       NOT NULL,
    ship_length   NUMBER(5, 2) NOT NULL,
    CONSTRAINT ckLength CHECK (ship_length >= 0),
    ship_width    NUMBER(5, 2) NOT NULL,
    CONSTRAINT ckWidth CHECK (ship_width >= 0),
    capacity      NUMBER(5, 2) NOT NULL,
    CONSTRAINT ckCapacity CHECK (capacity >= 0),
    draft         NUMBER(5, 2) NOT NULL,
    CONSTRAINT ckDraft CHECK (draft >= 0)
);

CREATE TABLE DynamicData
(
    data_id           INT(10) GENERATED ALWAYS AS IDENTITY
        CONSTRAINT pkDataId PRIMARY KEY,
    base_date_time    TIMESTAMP    NOT NULL,
    latitude          NUMBER(4, 2) NOT NULL,
    CONSTRAINT ckLatitude CHECK (latitude BETWEEN -90 AND 91),
    longitude         NUMBER(5, 2) NOT NULL,
    CONSTRAINT ckLongitude CHECK (longitude BETWEEN -180 AND 181),
    sog               NUMBER(5, 2) NOT NULL,
    CONSTRAINT ckSOG CHECK(sog >= 0),
    cog               NUMBER(5, 2) NOT NULL,
    -- CONSTRAINTS MISSING
    heading           NUMBER(5, 2) NOT NULL,
    position          INT(10) NOT NULL,
    transceiver_class VARCHAR(1)
);
