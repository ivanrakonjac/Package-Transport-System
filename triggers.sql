USE [SAB_Projekat]
GO
/****** Object:  Trigger [dbo].[TR_TransportOffer_DeleteAllOffersForPackage]    Script Date: 2.9.2021. 22:07:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[TR_TransportOffer_DeleteAllOffersForPackage]
   ON  [dbo].[Package]
   AFTER UPDATE
AS 
BEGIN
	declare @IdPackage int, @IdOffer int, @StatusPackage int
	declare @kursor cursor

	set @StatusPackage = (select DeliveryStatus from inserted)

	if(@StatusPackage != 1)
		return

	set @IdPackage = (select @IdPackage from inserted)

	print 'IdPackage '
	print @IdPackage

	set @kursor = cursor for
	select IdOffer
	from TransportOffer

	open @kursor

	fetch next from @kursor
	into @IdOffer

	print @IdOffer

	print 'IdOffer '
	print @IdOffer

	while @@FETCH_STATUS = 0
	begin
		 delete from TransportOffer 
		 where IdOffer=@IdOffer

		fetch next from @kursor
		into @IdOffer
	end

	close @kursor
	deallocate @kursor

END
