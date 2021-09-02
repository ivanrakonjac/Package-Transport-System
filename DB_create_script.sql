
DROP TABLE [Admin]
go

DROP TABLE [BecameCourierReq]
go

DROP TABLE [TransportOffer]
go

DROP TABLE [Package]
go

DROP TABLE [District]
go

DROP TABLE [City]
go

DROP TABLE [Courier]
go

DROP TABLE [Vehicle]
go

DROP TABLE [User]
go

CREATE TABLE [Admin]
( 
	[AdminUserName]      varchar(100)  NOT NULL 
)
go

CREATE TABLE [BecameCourierReq]
( 
	[UserName]           varchar(100)  NOT NULL ,
	[PlateNumber]        varchar(100)  NOT NULL 
)
go

CREATE TABLE [City]
( 
	[IdCity]             integer  IDENTITY  NOT NULL ,
	[Name]               varchar(100)  NULL ,
	[ZipCode]            integer  NULL 
	CONSTRAINT [Default_Value_0_2144165970]
		 DEFAULT  0
)
go

CREATE TABLE [Courier]
( 
	[CourierUserName]    varchar(100)  NOT NULL ,
	[NumOfDeliveredPackgs] integer  NULL 
	CONSTRAINT [Default_Value_0_550453052]
		 DEFAULT  0,
	[Profit]             decimal(10,3)  NULL 
	CONSTRAINT [Default_Value_0_910565213]
		 DEFAULT  0,
	[Status]             integer  NULL 
	CONSTRAINT [Default_Value_0_894701902]
		 DEFAULT  0
	CONSTRAINT [Status_0_OR_1_1823565681]
		CHECK  ( [Status]=0 OR [Status]=1 ),
	[PlateNumber]        varchar(100)  NULL 
)
go

CREATE TABLE [District]
( 
	[IdDistrict]         integer  IDENTITY  NOT NULL ,
	[Name]               varchar(100)  NOT NULL ,
	[xCord]              decimal(10,3)  NOT NULL 
	CONSTRAINT [Default_Value_0_913581870]
		 DEFAULT  0,
	[yCord]              decimal(10,3)  NOT NULL 
	CONSTRAINT [Default_Value_0_896804654]
		 DEFAULT  0,
	[IdCity]             integer  NOT NULL 
)
go

CREATE TABLE [Package]
( 
	[IdPackage]          integer  IDENTITY  NOT NULL ,
	[Type]               integer  NOT NULL 
	CONSTRAINT [Status_O_OR_1_OR_2_1683785485]
		CHECK  ( [Type]=0 OR [Type]=1 OR [Type]=2 ),
	[Weight]             decimal(10,3)  NULL ,
	[Price]              decimal(10,3)  NOT NULL 
	CONSTRAINT [Default_Value_0_1469695139]
		 DEFAULT  0,
	[DeliveryStatus]     integer  NULL 
	CONSTRAINT [Default_Value_0_1702972826]
		 DEFAULT  0
	CONSTRAINT [Status_0_OR_1_OR_2_OR_3_169101284]
		CHECK  ( [DeliveryStatus]=0 OR [DeliveryStatus]=1 OR [DeliveryStatus]=2 OR [DeliveryStatus]=3 ),
	[AcceptReqTime]      datetime  NULL ,
	[DistrictFrom]       integer  NOT NULL ,
	[DistrictTo]         integer  NOT NULL ,
	[UserUserName]       varchar(100)  NOT NULL ,
	[CourierUserName]    varchar(100)  NULL 
)
go

CREATE TABLE [TransportOffer]
( 
	[IdOffer]            integer  IDENTITY  NOT NULL ,
	[Share]              decimal(10,3)  NOT NULL 
	CONSTRAINT [Default_Value_0_639997326]
		 DEFAULT  0,
	[CourierUserName]    varchar(100)  NOT NULL ,
	[IdPackage]          integer  NOT NULL 
)
go

CREATE TABLE [User]
( 
	[UserName]           varchar(100)  NOT NULL ,
	[FirstName]          varchar(100)  NULL ,
	[LastName]           varchar(100)  NULL ,
	[Password]           varchar(100)  NULL ,
	[NumOfSentPackgs]    integer  NULL 
	CONSTRAINT [Default_Value_0_1124695147]
		 DEFAULT  0
)
go

CREATE TABLE [Vehicle]
( 
	[PlateNumber]        varchar(100)  NOT NULL ,
	[FuelType]           integer  NULL 
	CONSTRAINT [FuelType_0_OR_1_OR_2_1602654895]
		CHECK  ( [FuelType]=0 OR [FuelType]=1 OR [FuelType]=2 ),
	[FuelConsumption]    decimal(10,3)  NULL 
	CONSTRAINT [Default_Value_0_1164483342]
		 DEFAULT  0
)
go

ALTER TABLE [Admin]
	ADD CONSTRAINT [XPKAdmin] PRIMARY KEY  CLUSTERED ([AdminUserName] ASC)
go

ALTER TABLE [BecameCourierReq]
	ADD CONSTRAINT [XPKBecameCourierReq] PRIMARY KEY  CLUSTERED ([UserName] ASC,[PlateNumber] ASC)
go

ALTER TABLE [City]
	ADD CONSTRAINT [XPKCity] PRIMARY KEY  CLUSTERED ([IdCity] ASC)
go

ALTER TABLE [Courier]
	ADD CONSTRAINT [XPKCourier] PRIMARY KEY  CLUSTERED ([CourierUserName] ASC)
go

ALTER TABLE [District]
	ADD CONSTRAINT [XPKDistrict] PRIMARY KEY  CLUSTERED ([IdDistrict] ASC)
go

ALTER TABLE [Package]
	ADD CONSTRAINT [XPKPackage] PRIMARY KEY  CLUSTERED ([IdPackage] ASC)
go

ALTER TABLE [TransportOffer]
	ADD CONSTRAINT [XPKTransportOffer] PRIMARY KEY  CLUSTERED ([IdOffer] ASC)
go

ALTER TABLE [User]
	ADD CONSTRAINT [XPKUser] PRIMARY KEY  CLUSTERED ([UserName] ASC)
go

ALTER TABLE [Vehicle]
	ADD CONSTRAINT [XPKVehicle] PRIMARY KEY  CLUSTERED ([PlateNumber] ASC)
go


ALTER TABLE [Admin]
	ADD CONSTRAINT [R_4] FOREIGN KEY ([AdminUserName]) REFERENCES [User]([UserName])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go


ALTER TABLE [BecameCourierReq]
	ADD CONSTRAINT [R_5] FOREIGN KEY ([UserName]) REFERENCES [User]([UserName])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [BecameCourierReq]
	ADD CONSTRAINT [R_6] FOREIGN KEY ([PlateNumber]) REFERENCES [Vehicle]([PlateNumber])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Courier]
	ADD CONSTRAINT [R_3] FOREIGN KEY ([CourierUserName]) REFERENCES [User]([UserName])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go

ALTER TABLE [Courier]
	ADD CONSTRAINT [R_10] FOREIGN KEY ([PlateNumber]) REFERENCES [Vehicle]([PlateNumber])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [District]
	ADD CONSTRAINT [R_1] FOREIGN KEY ([IdCity]) REFERENCES [City]([IdCity])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Package]
	ADD CONSTRAINT [R_13] FOREIGN KEY ([DistrictFrom]) REFERENCES [District]([IdDistrict])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Package]
	ADD CONSTRAINT [R_14] FOREIGN KEY ([DistrictTo]) REFERENCES [District]([IdDistrict])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Package]
	ADD CONSTRAINT [R_15] FOREIGN KEY ([UserUserName]) REFERENCES [User]([UserName])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Package]
	ADD CONSTRAINT [R_18] FOREIGN KEY ([CourierUserName]) REFERENCES [Courier]([CourierUserName])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [TransportOffer]
	ADD CONSTRAINT [R_16] FOREIGN KEY ([CourierUserName]) REFERENCES [Courier]([CourierUserName])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [TransportOffer]
	ADD CONSTRAINT [R_17] FOREIGN KEY ([IdPackage]) REFERENCES [Package]([IdPackage])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go