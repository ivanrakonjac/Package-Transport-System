
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
	[CourierUserName]    varchar(100)  NOT NULL 
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


CREATE TRIGGER tD_Admin ON Admin FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Admin */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /*   Admin on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000122e3", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Admin"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="AdminUserName" */
    IF EXISTS (SELECT * FROM deleted,
      WHERE
        /* %JoinFKPK(deleted,," = "," AND") */
        deleted.AdminUserName = UserName AND
        NOT EXISTS (
          SELECT * FROM Admin
          WHERE
            /* %JoinFKPK(Admin,," = "," AND") */
            Admin.AdminUserName = UserName
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Admin because  exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Admin ON Admin FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Admin */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insAdminUserName varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /*   Admin on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00015774", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Admin"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="AdminUserName" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(AdminUserName)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,
        WHERE
          /* %JoinFKPK(inserted,) */
          inserted.AdminUserName = UserName
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Admin because  does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_BecameCourierReq ON BecameCourierReq FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on BecameCourierReq */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vehicle  BecameCourierReq on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00029f91", PARENT_OWNER="", PARENT_TABLE="Vehicle"
    CHILD_OWNER="", CHILD_TABLE="BecameCourierReq"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="PlateNumber" */
    IF EXISTS (SELECT * FROM deleted,Vehicle
      WHERE
        /* %JoinFKPK(deleted,Vehicle," = "," AND") */
        deleted.PlateNumber = Vehicle.PlateNumber AND
        NOT EXISTS (
          SELECT * FROM BecameCourierReq
          WHERE
            /* %JoinFKPK(BecameCourierReq,Vehicle," = "," AND") */
            BecameCourierReq.PlateNumber = Vehicle.PlateNumber
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last BecameCourierReq because Vehicle exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* User  BecameCourierReq on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="BecameCourierReq"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="UserName" */
    IF EXISTS (SELECT * FROM deleted,User
      WHERE
        /* %JoinFKPK(deleted,User," = "," AND") */
        deleted.UserName = User.UserName AND
        NOT EXISTS (
          SELECT * FROM BecameCourierReq
          WHERE
            /* %JoinFKPK(BecameCourierReq,User," = "," AND") */
            BecameCourierReq.UserName = User.UserName
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last BecameCourierReq because User exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_BecameCourierReq ON BecameCourierReq FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on BecameCourierReq */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insUserName varchar(100), 
           @insPlateNumber varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vehicle  BecameCourierReq on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002b167", PARENT_OWNER="", PARENT_TABLE="Vehicle"
    CHILD_OWNER="", CHILD_TABLE="BecameCourierReq"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="PlateNumber" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(PlateNumber)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Vehicle
        WHERE
          /* %JoinFKPK(inserted,Vehicle) */
          inserted.PlateNumber = Vehicle.PlateNumber
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update BecameCourierReq because Vehicle does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* User  BecameCourierReq on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="BecameCourierReq"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="UserName" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(UserName)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,User
        WHERE
          /* %JoinFKPK(inserted,User) */
          inserted.UserName = User.UserName
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update BecameCourierReq because User does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_City ON City FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on City */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* City  District on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00010f84", PARENT_OWNER="", PARENT_TABLE="City"
    CHILD_OWNER="", CHILD_TABLE="District"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdCity" */
    IF EXISTS (
      SELECT * FROM deleted,District
      WHERE
        /*  %JoinFKPK(District,deleted," = "," AND") */
        District.IdCity = deleted.IdCity
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete City because District exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_City ON City FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on City */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdCity integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* City  District on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0001191d", PARENT_OWNER="", PARENT_TABLE="City"
    CHILD_OWNER="", CHILD_TABLE="District"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdCity" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdCity)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,District
      WHERE
        /*  %JoinFKPK(District,deleted," = "," AND") */
        District.IdCity = deleted.IdCity
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update City because District exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Courier ON Courier FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Courier */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Courier  Package on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00043008", PARENT_OWNER="", PARENT_TABLE="Courier"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="CourierUserName" */
    IF EXISTS (
      SELECT * FROM deleted,Package
      WHERE
        /*  %JoinFKPK(Package,deleted," = "," AND") */
        Package.CourierUserName = deleted.CourierUserName
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Courier because Package exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Courier  TransportOffer on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Courier"
    CHILD_OWNER="", CHILD_TABLE="TransportOffer"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="CourierUserName" */
    IF EXISTS (
      SELECT * FROM deleted,TransportOffer
      WHERE
        /*  %JoinFKPK(TransportOffer,deleted," = "," AND") */
        TransportOffer.CourierUserName = deleted.CourierUserName
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Courier because TransportOffer exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vehicle  Courier on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vehicle"
    CHILD_OWNER="", CHILD_TABLE="Courier"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="PlateNumber" */
    IF EXISTS (SELECT * FROM deleted,Vehicle
      WHERE
        /* %JoinFKPK(deleted,Vehicle," = "," AND") */
        deleted.PlateNumber = Vehicle.PlateNumber AND
        NOT EXISTS (
          SELECT * FROM Courier
          WHERE
            /* %JoinFKPK(Courier,Vehicle," = "," AND") */
            Courier.PlateNumber = Vehicle.PlateNumber
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Courier because Vehicle exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /*   Courier on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Courier"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="CourierUserName" */
    IF EXISTS (SELECT * FROM deleted,
      WHERE
        /* %JoinFKPK(deleted,," = "," AND") */
        deleted.CourierUserName = UserName AND
        NOT EXISTS (
          SELECT * FROM Courier
          WHERE
            /* %JoinFKPK(Courier,," = "," AND") */
            Courier.CourierUserName = UserName
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Courier because  exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Courier ON Courier FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Courier */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCourierUserName varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Courier  Package on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0004e226", PARENT_OWNER="", PARENT_TABLE="Courier"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="CourierUserName" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CourierUserName)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Package
      WHERE
        /*  %JoinFKPK(Package,deleted," = "," AND") */
        Package.CourierUserName = deleted.CourierUserName
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Courier because Package exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Courier  TransportOffer on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Courier"
    CHILD_OWNER="", CHILD_TABLE="TransportOffer"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="CourierUserName" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CourierUserName)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,TransportOffer
      WHERE
        /*  %JoinFKPK(TransportOffer,deleted," = "," AND") */
        TransportOffer.CourierUserName = deleted.CourierUserName
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Courier because TransportOffer exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Vehicle  Courier on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vehicle"
    CHILD_OWNER="", CHILD_TABLE="Courier"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="PlateNumber" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(PlateNumber)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Vehicle
        WHERE
          /* %JoinFKPK(inserted,Vehicle) */
          inserted.PlateNumber = Vehicle.PlateNumber
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.PlateNumber IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Courier because Vehicle does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /*   Courier on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Courier"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="CourierUserName" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CourierUserName)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,
        WHERE
          /* %JoinFKPK(inserted,) */
          inserted.CourierUserName = UserName
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Courier because  does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_District ON District FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on District */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* District  Package on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00030235", PARENT_OWNER="", PARENT_TABLE="District"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="DistrictTo" */
    IF EXISTS (
      SELECT * FROM deleted,Package
      WHERE
        /*  %JoinFKPK(Package,deleted," = "," AND") */
        Package.DistrictTo = deleted.IdDistrict
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete District because Package exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* District  Package on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="District"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="DistrictFrom" */
    IF EXISTS (
      SELECT * FROM deleted,Package
      WHERE
        /*  %JoinFKPK(Package,deleted," = "," AND") */
        Package.DistrictFrom = deleted.IdDistrict
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete District because Package exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* City  District on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="City"
    CHILD_OWNER="", CHILD_TABLE="District"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdCity" */
    IF EXISTS (SELECT * FROM deleted,City
      WHERE
        /* %JoinFKPK(deleted,City," = "," AND") */
        deleted.IdCity = City.IdCity AND
        NOT EXISTS (
          SELECT * FROM District
          WHERE
            /* %JoinFKPK(District,City," = "," AND") */
            District.IdCity = City.IdCity
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last District because City exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_District ON District FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on District */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdDistrict integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* District  Package on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00035374", PARENT_OWNER="", PARENT_TABLE="District"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="DistrictTo" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdDistrict)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Package
      WHERE
        /*  %JoinFKPK(Package,deleted," = "," AND") */
        Package.DistrictTo = deleted.IdDistrict
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update District because Package exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* District  Package on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="District"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="DistrictFrom" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdDistrict)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Package
      WHERE
        /*  %JoinFKPK(Package,deleted," = "," AND") */
        Package.DistrictFrom = deleted.IdDistrict
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update District because Package exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* City  District on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="City"
    CHILD_OWNER="", CHILD_TABLE="District"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdCity" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdCity)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,City
        WHERE
          /* %JoinFKPK(inserted,City) */
          inserted.IdCity = City.IdCity
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update District because City does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Package ON Package FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Package */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Package  TransportOffer on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0005a782", PARENT_OWNER="", PARENT_TABLE="Package"
    CHILD_OWNER="", CHILD_TABLE="TransportOffer"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="IdPackage" */
    IF EXISTS (
      SELECT * FROM deleted,TransportOffer
      WHERE
        /*  %JoinFKPK(TransportOffer,deleted," = "," AND") */
        TransportOffer.IdPackage = deleted.IdPackage
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Package because TransportOffer exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Courier  Package on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Courier"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="CourierUserName" */
    IF EXISTS (SELECT * FROM deleted,Courier
      WHERE
        /* %JoinFKPK(deleted,Courier," = "," AND") */
        deleted.CourierUserName = Courier.CourierUserName AND
        NOT EXISTS (
          SELECT * FROM Package
          WHERE
            /* %JoinFKPK(Package,Courier," = "," AND") */
            Package.CourierUserName = Courier.CourierUserName
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Package because Courier exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* User  Package on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="UserUserName" */
    IF EXISTS (SELECT * FROM deleted,User
      WHERE
        /* %JoinFKPK(deleted,User," = "," AND") */
        deleted.UserUserName = User.UserName AND
        NOT EXISTS (
          SELECT * FROM Package
          WHERE
            /* %JoinFKPK(Package,User," = "," AND") */
            Package.UserUserName = User.UserName
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Package because User exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* District  Package on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="District"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="DistrictTo" */
    IF EXISTS (SELECT * FROM deleted,District
      WHERE
        /* %JoinFKPK(deleted,District," = "," AND") */
        deleted.DistrictTo = District.IdDistrict AND
        NOT EXISTS (
          SELECT * FROM Package
          WHERE
            /* %JoinFKPK(Package,District," = "," AND") */
            Package.DistrictTo = District.IdDistrict
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Package because District exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* District  Package on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="District"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="DistrictFrom" */
    IF EXISTS (SELECT * FROM deleted,District
      WHERE
        /* %JoinFKPK(deleted,District," = "," AND") */
        deleted.DistrictFrom = District.IdDistrict AND
        NOT EXISTS (
          SELECT * FROM Package
          WHERE
            /* %JoinFKPK(Package,District," = "," AND") */
            Package.DistrictFrom = District.IdDistrict
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Package because District exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Package ON Package FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Package */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdPackage integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Package  TransportOffer on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00064f33", PARENT_OWNER="", PARENT_TABLE="Package"
    CHILD_OWNER="", CHILD_TABLE="TransportOffer"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="IdPackage" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdPackage)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,TransportOffer
      WHERE
        /*  %JoinFKPK(TransportOffer,deleted," = "," AND") */
        TransportOffer.IdPackage = deleted.IdPackage
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Package because TransportOffer exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Courier  Package on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Courier"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="CourierUserName" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CourierUserName)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Courier
        WHERE
          /* %JoinFKPK(inserted,Courier) */
          inserted.CourierUserName = Courier.CourierUserName
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Package because Courier does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* User  Package on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="UserUserName" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(UserUserName)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,User
        WHERE
          /* %JoinFKPK(inserted,User) */
          inserted.UserUserName = User.UserName
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Package because User does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* District  Package on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="District"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="DistrictTo" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DistrictTo)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,District
        WHERE
          /* %JoinFKPK(inserted,District) */
          inserted.DistrictTo = District.IdDistrict
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Package because District does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* District  Package on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="District"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="DistrictFrom" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DistrictFrom)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,District
        WHERE
          /* %JoinFKPK(inserted,District) */
          inserted.DistrictFrom = District.IdDistrict
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Package because District does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_TransportOffer ON TransportOffer FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on TransportOffer */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Package  TransportOffer on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00029aaf", PARENT_OWNER="", PARENT_TABLE="Package"
    CHILD_OWNER="", CHILD_TABLE="TransportOffer"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="IdPackage" */
    IF EXISTS (SELECT * FROM deleted,Package
      WHERE
        /* %JoinFKPK(deleted,Package," = "," AND") */
        deleted.IdPackage = Package.IdPackage AND
        NOT EXISTS (
          SELECT * FROM TransportOffer
          WHERE
            /* %JoinFKPK(TransportOffer,Package," = "," AND") */
            TransportOffer.IdPackage = Package.IdPackage
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last TransportOffer because Package exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Courier  TransportOffer on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Courier"
    CHILD_OWNER="", CHILD_TABLE="TransportOffer"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="CourierUserName" */
    IF EXISTS (SELECT * FROM deleted,Courier
      WHERE
        /* %JoinFKPK(deleted,Courier," = "," AND") */
        deleted.CourierUserName = Courier.CourierUserName AND
        NOT EXISTS (
          SELECT * FROM TransportOffer
          WHERE
            /* %JoinFKPK(TransportOffer,Courier," = "," AND") */
            TransportOffer.CourierUserName = Courier.CourierUserName
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last TransportOffer because Courier exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_TransportOffer ON TransportOffer FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on TransportOffer */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdOffer integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Package  TransportOffer on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002c6d1", PARENT_OWNER="", PARENT_TABLE="Package"
    CHILD_OWNER="", CHILD_TABLE="TransportOffer"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="IdPackage" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdPackage)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Package
        WHERE
          /* %JoinFKPK(inserted,Package) */
          inserted.IdPackage = Package.IdPackage
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update TransportOffer because Package does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Courier  TransportOffer on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Courier"
    CHILD_OWNER="", CHILD_TABLE="TransportOffer"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="CourierUserName" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CourierUserName)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Courier
        WHERE
          /* %JoinFKPK(inserted,Courier) */
          inserted.CourierUserName = Courier.CourierUserName
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update TransportOffer because Courier does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_User ON User FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on User */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* User  Package on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00036971", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="UserUserName" */
    IF EXISTS (
      SELECT * FROM deleted,Package
      WHERE
        /*  %JoinFKPK(Package,deleted," = "," AND") */
        Package.UserUserName = deleted.UserName
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete User because Package exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* User  BecameCourierReq on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="BecameCourierReq"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="UserName" */
    IF EXISTS (
      SELECT * FROM deleted,BecameCourierReq
      WHERE
        /*  %JoinFKPK(BecameCourierReq,deleted," = "," AND") */
        BecameCourierReq.UserName = deleted.UserName
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete User because BecameCourierReq exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /*   Admin on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Admin"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="AdminUserName" */
    DELETE Admin
      FROM Admin,deleted
      WHERE
        /*  %JoinFKPK(Admin,deleted," = "," AND") */
        Admin.AdminUserName = deleted.UserName

    /* erwin Builtin Trigger */
    /*   Courier on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Courier"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="CourierUserName" */
    DELETE Courier
      FROM Courier,deleted
      WHERE
        /*  %JoinFKPK(Courier,deleted," = "," AND") */
        Courier.CourierUserName = deleted.UserName


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_User ON User FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on User */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insUserName varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* User  Package on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0004d445", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Package"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="UserUserName" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(UserName)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Package
      WHERE
        /*  %JoinFKPK(Package,deleted," = "," AND") */
        Package.UserUserName = deleted.UserName
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update User because Package exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* User  BecameCourierReq on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="BecameCourierReq"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="UserName" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(UserName)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,BecameCourierReq
      WHERE
        /*  %JoinFKPK(BecameCourierReq,deleted," = "," AND") */
        BecameCourierReq.UserName = deleted.UserName
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update User because BecameCourierReq exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /*   Admin on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Admin"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="AdminUserName" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(UserName)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insUserName = inserted.UserName
        FROM inserted
      UPDATE Admin
      SET
        /*  %JoinFKPK(Admin,@ins," = ",",") */
        Admin.AdminUserName = @insUserName
      FROM Admin,inserted,deleted
      WHERE
        /*  %JoinFKPK(Admin,deleted," = "," AND") */
        Admin.AdminUserName = deleted.UserName
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade  update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /*   Courier on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Courier"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="CourierUserName" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(UserName)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insUserName = inserted.UserName
        FROM inserted
      UPDATE Courier
      SET
        /*  %JoinFKPK(Courier,@ins," = ",",") */
        Courier.CourierUserName = @insUserName
      FROM Courier,inserted,deleted
      WHERE
        /*  %JoinFKPK(Courier,deleted," = "," AND") */
        Courier.CourierUserName = deleted.UserName
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade  update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Vehicle ON Vehicle FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vehicle */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vehicle  Courier on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000212fc", PARENT_OWNER="", PARENT_TABLE="Vehicle"
    CHILD_OWNER="", CHILD_TABLE="Courier"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="PlateNumber" */
    IF EXISTS (
      SELECT * FROM deleted,Courier
      WHERE
        /*  %JoinFKPK(Courier,deleted," = "," AND") */
        Courier.PlateNumber = deleted.PlateNumber
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vehicle because Courier exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vehicle  BecameCourierReq on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vehicle"
    CHILD_OWNER="", CHILD_TABLE="BecameCourierReq"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="PlateNumber" */
    IF EXISTS (
      SELECT * FROM deleted,BecameCourierReq
      WHERE
        /*  %JoinFKPK(BecameCourierReq,deleted," = "," AND") */
        BecameCourierReq.PlateNumber = deleted.PlateNumber
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vehicle because BecameCourierReq exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Vehicle ON Vehicle FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Vehicle */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPlateNumber varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vehicle  Courier on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00024301", PARENT_OWNER="", PARENT_TABLE="Vehicle"
    CHILD_OWNER="", CHILD_TABLE="Courier"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="PlateNumber" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(PlateNumber)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Courier
      WHERE
        /*  %JoinFKPK(Courier,deleted," = "," AND") */
        Courier.PlateNumber = deleted.PlateNumber
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Vehicle because Courier exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Vehicle  BecameCourierReq on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vehicle"
    CHILD_OWNER="", CHILD_TABLE="BecameCourierReq"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="PlateNumber" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(PlateNumber)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,BecameCourierReq
      WHERE
        /*  %JoinFKPK(BecameCourierReq,deleted," = "," AND") */
        BecameCourierReq.PlateNumber = deleted.PlateNumber
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Vehicle because BecameCourierReq exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


