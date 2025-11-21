USE northwind;

#query for retriving all the data from the table Categories
SELECT * 
FROM categories;

#query for retriving all the data from the table Customers
SELECT * 
FROM customers;

#query for retriving all the data from the table Employees
SELECT * 
FROM employees;

##Number of orders for customers with frieght charges according to the companyname
SELECT o.CustomerID,
	   COUNT(o.OrderID) AS orders_per_customer,
       SUM(o.Freight) AS freight_charges
FROM orders o
LEFT JOIN shippers s 
          ON o.ShipVia = s.ShipperID          
GROUP BY CustomerID;

#orders and charges for each shipper groupby CompanyName
SELECT COUNT(o.OrderID) AS orders_per_each_shipper,
       SUM(o.Freight) AS freight_charges,
       s.ShipperID,
       s.CompanyName
FROM orders o
LEFT JOIN shippers s 
          ON o.ShipVia = s.ShipperID
GROUP BY ShipperID;


##Orders and order_details join and to retrieve data for orders table
SELECT o.OrderID,
       o.CustomerID,
       o.EmployeeID,
       o.OrderDate,
       o.RequiredDate,
       SUM(UnitPrice) AS unit_price_per_order,
       SUM(Quantity) AS quantity_per_order,
	   SUM(Quantity * UnitPrice) AS sales
FROM orders o
LEFT JOIN order_details od
          ON o.OrderID = od.OrderID
GROUP BY o.OrderID;


##To retrieve data for order shipping details table 
SELECT o.OrderID,
       o.ShippedDate,
       o.ShipVia,
       o.Freight,
       o.ShipName,
       o.ShipAddress,
       o.ShipCity,
       o.ShipRegion,
       o.ShipPostalCode,
       o.ShipCountry
FROM orders o;


##order details with product Id & product Name
SELECT od.ID AS OrderDetailID,
	   od.OrderID,
       od.ProductID,
       od.UnitPrice,
       od.Quantity,
       (od.Quantity * od.UnitPrice) AS sales_per_od,
       od.Discount,
       p.ProductName
FROM order_details od
LEFT JOIN products p
          ON od.ProductID = p.ProductID;

#Order details with Product price & profit per order
SELECT od.ID as orderdetailID,
	   OrderID,
       p.ProductID,
       p.ProductName,
       od.UnitPrice as od_unit_price,
       p.UnitPrice as product_unit_price,
       p.UnitPrice - od.UnitPrice as profit_per_ODID
FROM order_details od
LEFT JOIN products p
         ON od.ProductID = p.ProductID;

#To retreive the data for the table Shippers 
SELECT * 
FROM shippers;

#To retreive the data for the table Suppliers
SELECT * 
FROM suppliers;
         
         
##Swapping unitprice column in od and p 
SELECT od.ID AS OrderDetailID,
       od.OrderID,
       od.ProductID,
       p.ProductName,
       p.UnitPrice,
       od.Quantity,
       od.Discount
FROM northwind.order_details od
LEFT JOIN products p
ON od.ProductID = p.ProductID;


SELECT p.ProductID,
       p.ProductName,
       p.SupplierID,
       p.CategoryID,
       p.QuantityPerUnit,
       MIN(od.UnitPrice) AS UnitPrice,
       p.UnitsInStock,
       p.UnitsOnOrder,
       p.ReorderLevel,
       p.Discontinued
FROM products p
JOIN order_details od
ON p.ProductID = od.ProductID
GROUP BY p.ProductID;



SELECT o.OrderID,
       o.CustomerID,
       o.EmployeeID,
       o.OrderDate,
       o.RequiredDate,
       SUM(p.UnitPrice) AS unit_price_per_order,
       SUM(od.Quantity) AS quantity_per_order,
	   SUM(od.Quantity * p.UnitPrice) AS sales
FROM orders o
LEFT JOIN order_details od
          ON o.OrderID = od.OrderID
LEFT JOIN products p
          ON od.ProductID = p.ProductID
GROUP BY o.OrderID;	   


##Data for Hypothesis testing
SELECT od.ID AS OrderDetailID,
       od.OrderID,
       od.ProductID,
       p.ProductName,
       p.UnitPrice,
       od.Quantity,
       od.Discount,
       o.ShipCountry
FROM northwind.order_details od
LEFT JOIN orders o
ON od.OrderID = o.OrderID
LEFT JOIN products p
ON od.ProductID = p.ProductID;


##Query for calulating netsales and productcost
SELECT o.OrderID,
       o.CustomerID,
       o.OrderDate,
	   SUM(od.Quantity * p.UnitPrice * (1 - od.Discount)) AS Net_sales,
       SUM(od.Quantity * od.UnitPrice) AS Product_cost
FROM orders o
LEFT JOIN order_details od
          ON o.OrderID = od.OrderID
LEFT JOIN products p
          ON p.ProductID = od.ProductID
GROUP BY o.OrderID;





