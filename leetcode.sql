#customers who never order
# select c.name as Customers  from customers c left outer join orders o
# on c.id = o.customerId where o.customerId IS NULL;

# select c.name as 'Customers' 
# from customers c 
# where c.id not in 
# (select customerId from orders);

select c.name as 'Customers'
from customers c
where not exists (select o.customerId from orders o where o.customerId = c.id);