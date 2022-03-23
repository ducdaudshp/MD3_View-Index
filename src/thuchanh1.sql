use classicmodels;
SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

alter table customers add index idx_customerName(customerName);
explain select *from customers where customerName='Land of Toys Inc.';

ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' or contactFirstName = 'King';

ALTER TABLE customers DROP INDEX idx_full_name;

DELIMITER //

CREATE PROCEDURE findAllCustomers()

BEGIN

    SELECT * FROM customers;

END //

DELIMITER ;
call findAllCustomers();


DELIMITER //
DROP PROCEDURE IF EXISTS `findAllCustomers`//

CREATE PROCEDURE findAllCustomers()

BEGIN

    SELECT * FROM customers where customerNumber = 175;

END //

delimiter //
create procedure getCusById
(in cusNum int(11))
begin
    select *from customers where customerNumber = cusNum;
end //
delimiter ;
call getCusById(175);

DELIMITER //

CREATE PROCEDURE GetCustomersCountByCity(

    IN  in_city VARCHAR(50),

    OUT total INT

)

BEGIN

    SELECT COUNT(customerNumber)

    INTO total

    FROM customers

    WHERE city = in_city;

END//

DELIMITER ;

CALL GetCustomersCountByCity('Lyon',@total);
call GetCustomersCountByCity('HongKong', @total);

SELECT @total;

DELIMITER //

CREATE PROCEDURE SetCounter(

    INOUT counter INT,

    IN inc INT

)

BEGIN

    SET counter = counter + inc;

END//

DELIMITER ;
SET @counter = 1;



CALL SetCounter(@counter,1); -- 2

CALL SetCounter(@counter,1); -- 3

CALL SetCounter(@counter,5); -- 8

SELECT @counter; -- 8

CREATE VIEW customer_views AS

SELECT customerNumber, customerName, phone

FROM  customers;
select *from customer_views;

create or replace view customer_views as
    select customerNumber,customerName, contactFirstName,contactLastName,phone
from customers where city='Nantes';
select *from customer_views;

drop view customer_views;