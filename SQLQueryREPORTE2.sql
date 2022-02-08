
SELECT TOP (100) 

pp.BusinessEntityID,
c.PersonID,
pp.FirstName,
pp.LastName

  FROM 
  
 Person.Person pp
 inner join sales.Customer c on pp.BusinessEntityID = c.PersonID

 group by pp.BusinessEntityID, c.PersonID, pp.FirstName, pp.LastName
 