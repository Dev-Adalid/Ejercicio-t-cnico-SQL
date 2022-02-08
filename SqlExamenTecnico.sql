select top 7 -- tomar los ultimo 7 dias 

--selecionamos los campos 
CONVERT(varchar,soh.OrderDate,103) as 'FECHA DE VENTA',
(p.FirstName + ' ' + p.LastName) as 'NOMBRE DE VENDEDOR',
soh.SalesOrderID as 'ID_VENTA',
(p2.FirstName + ' ' + p2.LastName) as 'NOMBRE DE CLIENTE', 
sum(sod.OrderQty) AS 'CANTIDAD DE PRODUCTOS VENDIDOS',
count(sod.ProductID) as  'Cantidad de distintos productos vendidos',
soh.TotalDue as 'MONTO TOTAL DE VENTA', 
cc.CardType as 'TIPO DE TARJETA PARA PAGAR',
sod.SpecialOfferID as 'PRODUCTO EN OFERTA'


from sales.SalesOrderHeader soh 

-- USAR cláusula join 

inner join Sales.SalesOrderDetail sod on soh.SalesOrderID=sod.SalesOrderID 

inner join sales.CreditCard cc on soh.CreditCardID=cc.CreditCardID 

inner join sales.Customer c on c.CustomerID = soh.CustomerID

inner join Sales.SalesPerson sp on sp.BusinessEntityID = soh.SalesPersonID
inner join Person.Person p on p.BusinessEntityID = sp.BusinessEntityID -- vendedores de aca saco las personas que se encuentra registrada en la tabla sales person
inner join Person.Person p2 on p2.BusinessEntityID = c.PersonID

--no mostrar ventas que se pagaron con tarjeta del tipo "colonial voice"
where  cc.CardType not like 'ColonialVoice' --- operador like (comodin) de esa tabla no buscar colonial en esa tabla */  




-- AND v.OrderDate>= dateadd(DAY,-7,@fecha) 


---No debe haber dos filas con mismo id de venta en el reporte.

group by soh.SalesOrderID, sod.SpecialOfferID, soh.OrderDate, soh.SalesPersonID,soh.TotalDue, soh.CustomerID, cc.CardType,p.FirstName, p.LastName, p2.FirstName,p2.LastName

---Que se ordene el reporte por Fecha, descendiente.
order by soh.OrderDate desc
