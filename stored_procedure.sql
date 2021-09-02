USE [SAB_Projekat]
GO
/****** Object:  StoredProcedure [dbo].[spGrantRequest]    Script Date: 2.9.2021. 22:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spGrantRequest]
	@username varchar(100)
AS
BEGIN
	declare @vehicle varchar(100)
	declare @tmpUsername varchar(100)

	set @tmpUsername= (select UserName from BecameCourierReq where UserName=@username)

	if(@tmpUsername = @username)
	begin
		set @vehicle= (select PlateNumber from BecameCourierReq where Username=@username)

		delete from BecameCourierReq where UserName=@username

		insert into Courier(CourierUsername, PlateNumber) values (@username, @vehicle)
	end
	
END

GO

USE [SAB_Projekat]
GO
/****** Object:  StoredProcedure [dbo].[sp_emptyDB]    Script Date: 3.9.2021. 01:25:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_emptyDB]
AS
BEGIN

EXEC sp_MSforeachtable 'DISABLE TRIGGER ALL ON ?'
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
EXEC sp_MSforeachtable 'DELETE FROM ?'
EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL'
EXEC sp_MSforeachtable 'ENABLE TRIGGER ALL ON ?'



END


