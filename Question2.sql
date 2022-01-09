-- Question2:

-- How many orders were shipped by Speedy Express in total?
-- Answer: 54
SELECT Count(*)
FROM   orders,
       shippers
WHERE  orders.shipperid = shippers.shipperid
       AND shippers.shippername = 'Speedy Express' 



-- What is the last name of the employee with the most orders?
-- Answer: Peacock
SELECT employees.lastname
FROM   employees,
       orders
WHERE  employees.employeeid = orders.employeeid
GROUP  BY employees.employeeid
HAVING Count(*) = (SELECT Max(ordernum)
                   FROM   (SELECT Count(*) AS ordernum
                           FROM   orders
                           GROUP  BY employeeid)) 



-- What product was ordered the most by customers in Germany?
-- Answer: the product called Boston Crab Meat with productid = 40

SELECT products.productid,
       products.productname
FROM   products,
       customers,
       orders,
       orderdetails
WHERE  orderdetails.orderid = orders.orderid
       AND products.productid = orderdetails.productid
       AND customers.customerid = orders.customerid
       AND customers.country = 'Germany'
GROUP  BY products.productid
HAVING Sum(quantity) = (SELECT Max(orderquantity)
                        FROM   (SELECT Sum(quantity) AS orderquantity
                                FROM   products,
                                       customers,
                                       orders,
                                       orderdetails
                                WHERE  orderdetails.orderid = orders.orderid
                                       AND products.productid =
                                           orderdetails.productid
                                       AND customers.customerid =
                                           orders.customerid
                                       AND customers.country = 'Germany'
                                GROUP  BY products.productid)) 