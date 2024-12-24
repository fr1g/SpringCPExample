-- unlock tables ;
-- drop database if exists `sellcenter1`;
-- create database sellcenter1;
-- use sellcenter1;

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;

CREATE TABLE `categories` (
  `cat_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `note` text,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_id` (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;

CREATE TABLE `employees` (
  `emp_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT 'anonymous',
  `contact` varchar(128) NOT NULL,
  `date_join` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` tinyint NOT NULL DEFAULT '5',
  PRIMARY KEY (`emp_id`),
  UNIQUE KEY `emp_id` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;

CREATE TABLE `products` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `amount` int NOT NULL DEFAULT '0' COMMENT 'The amount of product and negative is for preordered',
  `package` varchar(120) NOT NULL COMMENT 'the information of packaging and storage conditions',
  `barcode` varchar(64) NOT NULL,
  `cat_id` int NOT NULL,
  `size` varchar(64) DEFAULT NULL,
  `single_weight` float DEFAULT NULL COMMENT 'by kilogram',
  `single_price` decimal(10,2) NOT NULL,
  `feature` text,
  `discount` float DEFAULT '1' COMMENT 'ordinary discount',
  `note` text,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `barcode` (`barcode`),
  KEY `products_cat__fk` (`cat_id`),
  CONSTRAINT `products_cat__fk` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `traders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;

CREATE TABLE `traders` (
  `trader_id` int NOT NULL AUTO_INCREMENT,
  `contact` varchar(96) NOT NULL,
  `name` varchar(96) NOT NULL DEFAULT 'anonymous',
  `type` tinyint NOT NULL DEFAULT '0',
  `reg_by` int NOT NULL,
  `note` text,
  UNIQUE KEY `trader_id` (`trader_id`),
  KEY `reg_by` (`reg_by`),
  CONSTRAINT `traders_ibfk_1` FOREIGN KEY (`reg_by`) REFERENCES `employees` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `transaction_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;

CREATE TABLE `transaction_list` (
  `list_id` int NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `related_trader` int NOT NULL,
  PRIMARY KEY (`list_id`),
  UNIQUE KEY `list_id` (`list_id`),
  KEY `related_trader` (`related_trader`),
  CONSTRAINT `transaction_list_ibfk_1` FOREIGN KEY (`related_trader`) REFERENCES `traders` (`trader_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;

CREATE TABLE `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `list_id` int NOT NULL,
  `amount` bigint NOT NULL DEFAULT '1',
  `logistic_info` varchar(300) NOT NULL COMMENT 'This may be a link to the post services',
  `status` tinyint DEFAULT '0' COMMENT '0: pending, 1: checking, 2: processing, 3: in affairs, 4: on the way, 5: regional affairs, 6: proceed, 7: getting received, 8: waiting to collect, 9: fullfilled, 10: rejected, 11: cancelled, 12: cancelled by provider, 13: damaged, 14: unknown, 15: ... for other 3 or 4 digits status, using firsts as primary status. like for 1001: created, pending.(since cannot be 01)',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'this is the total price of this transaction',
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `io` tinyint DEFAULT '0' COMMENT 'using 0 for in, using 1 for out, otherwise using 2 as plenty of trading.',
  `discount` float DEFAULT '1' COMMENT 'the actually price should be calculated like price * discount * amount in total.',
  `note` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `list_id` (`list_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`list_id`) REFERENCES `transaction_list` (`list_id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `product_info`; -- view
DROP VIEW IF EXISTS `product_info`;
SET @saved_cs_client     = @@character_set_client;

create view product_info as
    select pro.record_id, pro.name, pro.barcode, pro.single_price
    from products pro
        join categories on pro.cat_id = categories.cat_id;
SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `registrar`;
DROP VIEW IF EXISTS `registrar`;
SET @saved_cs_client     = @@character_set_client;

create view registrar as
    select emp_id,
           emp.type,
           emp.name as registrar,
           emp.contact as emp_contact,
           ' = is associated to => ' as association,
           t.name as trader_name,
           t.contact as trader_contact,
           trader_id as trader_id,
           note
    from employees emp left outer join traders t on emp.emp_id = t.reg_by;
SET character_set_client = @saved_cs_client;

DROP TRIGGER IF EXISTS nt_insert_u_list;
DELIMITER ;;
CREATE TRIGGER `nt_insert_u_list` AFTER INSERT ON `transactions` FOR EACH ROW begin
    declare updated_list int;
    set updated_list = NEW.list_id;
    update transaction_list set date_updated = now() where transaction_list.list_id = updated_list;
end ;;
DELIMITER ;

DROP TRIGGER IF EXISTS nt_update_u_list;
DELIMITER ;;
CREATE TRIGGER `nt_update_u_list` BEFORE UPDATE ON `transactions` FOR EACH ROW begin
    declare updated_list int;
    declare this_id int;
    if NEW.date_updated <> OLD.date_updated and NEW.note = OLD.note then
        signal sqlstate '19198' set message_text = 'Do not change updated date manually, or change the note by the time.';
    end if;
    set updated_list = NEW.list_id;
    set this_id = NEW.id;
    set NEW.date_updated = now() ;
    update transaction_list set date_updated = now() where transaction_list.list_id = updated_list;
end ;;
DELIMITER ;

DROP TRIGGER IF EXISTS nt_delete_u_list;
DELIMITER ;;
CREATE TRIGGER `nt_delete_u_list` AFTER DELETE ON `transactions` FOR EACH ROW begin
    declare updated_list int;
    set updated_list = OLD.list_id;
    update transaction_list set date_updated = now() where transaction_list.list_id = updated_list;
end ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `check_date`(created datetime, updated datetime) RETURNS tinyint(1)
    NO SQL
begin
    return created <= updated;
end ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `how_many`(trader_id int, required tinyint) RETURNS int
    READS SQL DATA
begin
    declare result int default 0;
    declare done int default false; -- wtf
    declare _temp int;
    declare _looking int;
    declare cur cursor for select transaction_list.list_id from transaction_list where related_trader = trader_id;
    declare continue handler for not found set done = TRUE;
    open cur;
        count_loop: LOOP
            fetch cur into _looking;
            if done then leave count_loop; end if; -- !
            if required = 0 or required = 1 then -- 0 is buying from and 1 is selling to
                select count(*) into _temp from transactions where list_id = _looking and io = required;
            elseif not (required = 0) and not (required = 1) then -- counting all of them
                select count(*) into _temp from transactions where list_id = _looking and required = required;
            end if;
            set result = result + _temp;
        end loop;
    close cur;
    return result;
end ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `how_much`(prod_id int, amount int) RETURNS decimal(10,2)
    READS SQL DATA
begin
    declare this_price decimal(10, 2);
    declare this_curr_discount float;
    declare _result decimal(10, 2);
    select discount into this_curr_discount from products where record_id = prod_id;
    select single_price into this_price from products where record_id = prod_id;
    set _result = this_price * this_curr_discount * amount;
    return _result;
end ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_all_date`(IN table_name varchar(20))
begin
    if table_name = 'transactions' then
        select * from transactions where not check_date(date_created, date_updated);
    else
        select * from transaction_list where not check_date(date_created, date_updated);
    end if;
end ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `inherit`(in former int, in target int)
begin
    declare done int default false;
    declare _temp int;
    declare cur cursor for select trader_id from traders where reg_by = former;
    declare continue handler for not found set done = true;
    open cur;
    trans_loop: LOOP
        fetch cur into _temp;
        if done then leave trans_loop; end if;
        update traders set reg_by = target where reg_by = former;
    end loop;
end ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_deal`(IN trader_id int, INOUT new_list_id int)
begin
    declare check_trader_exist int;
    declare check_deal_exist int;
    select traders.trader_id into check_trader_exist from traders where traders.trader_id = trader_id;
    if check_trader_exist IS NULL
        then
            rollback;
            SIGNAL SQLSTATE '11451' SET MESSAGE_TEXT = '[SCERR][404] Failed when trying to add a list onto a trader that [not exist].';
    end if;
    select list_id into check_deal_exist from transaction_list where list_id = new_list_id;
    if check_deal_exist is null and new_list_id > 0 then
        insert into transaction_list(list_id, related_trader) value(new_list_id, trader_id);
        set new_list_id = new_list_id; -- ?
    else
        insert into transaction_list(related_trader) value(trader_id);
        set new_list_id = last_insert_id();
    end if;
end ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_product`(in prod varchar(100), in init int, in packaging varchar(120), in category int, in price decimal(10, 2), in barcode varchar(64))
begin
    declare checking int;
    declare possible_message text;
    declare barcoded varchar(64);
    if barcode = '' then
        set barcoded = uuid();
    else
        set barcoded = barcode;
    end if;
    select products.record_id into checking from products where products.barcode = barcoded;
    if checking is not null then
        set possible_message = CONCAT('This with #', checking);
        set possible_message = concat(possible_message, ' named: [');
        set possible_message = concat(possible_message, (select products.name from products where record_id = checking));
        set possible_message = concat(possible_message,'] got conflict on barcode, are they same?');
        signal sqlstate '18104' set message_text = possible_message;
    end if;
    set checking = null;
    select categories.cat_id into checking from categories where cat_id = category;
    if checking is null then
        SIGNAL SQLSTATE '11451' SET MESSAGE_TEXT = '[SCERR][404] Failed when trying to add a new product into a category that [not exist].';
    end if;
    insert into products(name, amount, package, barcode, cat_id, single_price)
        value (prod, init, packaging, barcoded, category, price);
end ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost`
    PROCEDURE `new_trans`(IN prod_id int, IN for_amount bigint, IN iost int, IN list_id int,IN related_trader int)
begin
    declare check_list_exist int;
    declare check_trader_exist int;
    declare check_prod_exist int;
    declare temp int default -1;
    declare tmp decimal(10, 2);
    select products.record_id into check_prod_exist from products where record_id = prod_id;
    if check_prod_exist is null then
        rollback ;
        signal sqlstate '11451' set message_text = '[SCERR][404] No such product recorded.';
    end if;
    if list_id = -1 then
        set check_list_exist = null;
        select trader_id into check_trader_exist from traders where traders.trader_id = related_trader;
        # must have trader id while no list id exist
    else
        select transaction_list.list_id into check_list_exist from transaction_list where transaction_list.list_id = list_id;
    end if;
    if check_list_exist is null then
        if related_trader = -1 or check_trader_exist is null then # list not exist, trader not exist, then fallback
            rollback ;
            signal sqlstate '11451' set message_text = '[SCERR][404] Failed when trying to find neither the list nor the trader.';
        else # appending to exist
            set temp = list_id;
            call new_deal(related_trader, temp);
            insert into transactions(product_id, transactions.list_id, transactions.amount, logistic_info, status, price, date_created, date_updated, io, discount, note)
                value(prod_id, list_id, amount, uuid(), 0, how_much(prod_id, amount), now(), now(), iost, (select discount from products where record_id = prod_id), 'generated');
        end if;
    else # the target exists, ignore the trader.
        insert into transactions(product_id, transactions.list_id, transactions.amount, logistic_info, status, price, date_created, date_updated, io, discount, note)
            value(prod_id, list_id, for_amount, uuid(), 0, how_much(prod_id, amount), now(), now(), iost, (select discount from products where record_id = prod_id), 'generated');
    end if;
end ;;
DELIMITER ;

-- inserting info

LOCK TABLES `categories` WRITE;
INSERT INTO `categories` (`cat_id`, `name`, `note`)
    VALUES (1,'#f9aba9',NULL),
        (2,'#a8e261',NULL),
        (3,'#6ceef7',NULL),
        (4,'#65a3d8',NULL),
        (5,'#32ba8c',NULL),
        (6,'#aefce8',NULL),
        (7,'#a4daea',NULL),
        (8,'#ea3cca',NULL),
        (9,'#6cd8d1',NULL),
        (10,'#f8bbf9',NULL);
UNLOCK TABLES;

LOCK TABLES `employees` WRITE;
INSERT INTO `employees` (`emp_id`, `name`, `contact`, `date_join`, `type`)
    VALUES (2,'owx',' 333-33','2024-10-24 13:14:05',4),
        (4,'nameexample',' 114-514-1919810','2024-10-24 13:15:20',5),
        (5,'Ruth Fletcher','(334) 468-4829','2025-09-06 01:29:46',0),
        (6,'Alfreda Guerra','(647) 313-2463','2024-04-05 10:29:57',6),
        (7,'Silas Bradshaw','(508) 588-2572','2023-11-12 08:05:05',1),
        (8,'Caesar French','(926) 217-7614','2023-11-07 02:10:35',3),
        (9,'Bruno Daniel','1-154-407-1075','2024-02-05 05:25:05',1),
        (10,'Risa Keller','1-543-738-0362','2023-11-22 10:01:19',0),
        (11,'Camille Fowler','(838) 470-6543','2024-01-22 09:50:07',4),
        (12,'Zane Small','(865) 222-9752','2024-06-24 08:12:13',8),
        (13,'Roary Crosby','(896) 283-6829','2024-02-06 06:11:29',1),
        (14,'Daquan Booker','1-865-823-8580','2024-07-14 09:20:54',1),
        (15,'Keefe Patrick','1-315-549-3308','2025-05-27 06:15:07',6),
        (16,'Armand Sexton','(562) 218-7243','2024-11-07 03:46:29',4),
        (17,'Karen Hunter','1-789-542-2375','2025-10-12 06:18:43',6),
        (18,'Montana Salazar','(677) 852-2474','2025-09-22 12:43:58',1),
        (19,'Lois Barr','(645) 414-5497','2025-06-05 01:41:51',2),
        (20,'Darryl Donaldson','1-793-621-3748','2025-10-24 12:59:25',7);
UNLOCK TABLES;

LOCK TABLES `products` WRITE;
INSERT INTO `products` (`record_id`, `name`, `amount`, `package`, `barcode`, `cat_id`, `size`, `single_weight`, `single_price`, `feature`, `discount`, `note`)
    VALUES (1,'sapien imperdiet ornare.',550,'32.9852256256, -59.6117238784','037-308-3834',7,NULL,NULL,40.00,NULL,1,NULL),
           (2,'pretium et,',534,'67.6168178688, 76.5867239424','086-542-0184',8,NULL,NULL,41.35,NULL,1,NULL),
           (3,'Donec',57,'63.6232327168, -152.4783683584','066-816-6070',2,NULL,NULL,51.32,NULL,1,NULL),
           (4,'sit amet, risus.',266,'32.9828754432, -98.1138527232','071-566-3106',7,NULL,NULL,16.57,NULL,1,NULL),
           (5,'non sapien',682,'-56.92027904, 96.9988411392','077-425-1436',3,NULL,NULL,12.70,NULL,1,NULL),
           (6,'sociosqu ad',999,'6.6425096192, 73.131994112','033-618-7646',8,NULL,NULL,62.76,NULL,1,NULL),
           (7,'amet, faucibus ut,',293,'-51.3320937472, -171.6459047936','039-954-4538',7,NULL,NULL,90.08,NULL,1,NULL),
           (8,'Etiam gravida',227,'12.5931137024, 129.7457577984','075-248-6155',1,NULL,NULL,46.73,NULL,1,NULL),
           (9,'felis',489,'-42.622553088, 92.598196736','072-955-9958',5,NULL,NULL,15.16,NULL,1,NULL),
           (10,'tempus',36,'-9.6710813696, 26.968050688','034-532-6175',1,NULL,NULL,85.60,NULL,1,NULL),
           (11,'Phasellus ornare. Fusce',951,'18.874522112, 167.8912207872','011-133-2039',2,NULL,NULL,91.11,NULL,1,NULL),
           (12,'arcu.',535,'-19.6166030336, 111.0915340288','058-124-2533',7,NULL,NULL,77.99,NULL,1,NULL),
           (13,'tempor augue',11,'-34.6489500672, -179.70519296','036-656-7887',9,NULL,NULL,14.26,NULL,1,NULL),
           (14,'Aliquam erat',357,'57.0781722624, -42.4433316864','035-176-9551',4,NULL,NULL,37.76,NULL,1,NULL),
           (15,'felis purus',426,'55.3608046592, -93.5104934912','069-482-1654',4,NULL,NULL,87.16,NULL,1,NULL),
           (16,'Aenean massa.',217,'58.8022426624, 61.1124059136','033-514-1975',6,NULL,NULL,85.97,NULL,1,NULL),
           (17,'nunc ac',981,'89.4940609536, 165.0871595008','048-787-8837',2,NULL,NULL,69.91,NULL,1,NULL),
           (18,'Vivamus euismod urna.',354,'-83.0948349952, 49.8040026112','014-827-4378',1,NULL,NULL,79.67,NULL,1,NULL),
           (19,'facilisis',211,'-71.7898242048, 55.77162752','074-464-8448',6,NULL,NULL,95.44,NULL,1,NULL),
           (20,'purus. Nullam',40,'-4.8639225856, -161.4107111424','066-895-4505',5,NULL,NULL,93.59,NULL,1,NULL);
UNLOCK TABLES;

LOCK TABLES `traders` WRITE;
INSERT INTO `traders` (`trader_id`, `contact`, `name`, `type`, `reg_by`, `note`)
    VALUES (11,'01 33 88 94 19','Clinton R. Best',1,16,NULL),
        (12,'08 42 13 47 16','Ursa V. Booth',1,4,NULL),
        (13,'03 94 30 34 13','Abraham R. Vang',0,16,NULL),
        (14,'03 23 35 62 13','Arthur O. Nolan',0,6,NULL),
        (15,'04 68 36 26 87','Danielle C. Gaines',0,20,NULL),
        (16,'02 05 18 84 53','Odysseus P. Daniel',1,11,NULL),
        (17,'08 68 87 72 56','Howard E. Mosley',0,17,NULL),
        (18,'04 16 73 13 87','Herman V. Greene',0,4,NULL),
        (19,'06 84 45 12 77','Chanda X. Meadows',1,18,NULL),
        (20,'07 26 38 26 67','Shelby F. Justice',1,7,NULL),
        (31,'06 18 34 23 42','Idona I. Jefferson',0,17,NULL),
        (32,'02 97 26 67 06','Charissa G. Robbins',1,2,NULL),
        (33,'02 42 44 71 32','Nero W. Foley',1,11,NULL),
        (34,'01 36 58 73 99','Jesse L. Landry',1,15,NULL),
        (35,'08 42 33 10 44','Astra X. Clements',1,11,NULL),
        (36,'09 46 24 97 95','Ginger P. Long',1,19,NULL),
        (37,'06 31 47 16 63','Winifred X. Romero',1,13,NULL),
        (38,'05 78 84 74 99','Buckminster R. Wise',0,16,NULL),
        (39,'03 99 52 78 38','Nash B. Gross',1,13,NULL),
        (40,'02 63 11 26 02','Ross T. Bowman',0,9,NULL),
        (41,'06 21 61 01 16','Patrick M. Gross',0,11,NULL),
        (42,'08 99 96 86 01','Georgia M. Walter',1,7,NULL),
        (43,'02 15 48 28 83','Nita V. Fuentes',1,6,NULL),
        (44,'07 74 88 18 52','Lev P. Summers',1,20,NULL),
        (45,'09 73 47 64 72','Griffin S. Holloway',1,15,NULL),
        (46,'05 46 62 50 23','Maggie X. Daugherty',1,9,NULL),
        (47,'03 67 32 95 66','Brody O. Woodard',0,5,NULL),
        (48,'06 47 71 52 83','Galvin U. Doyle',1,18,NULL),
        (49,'05 31 25 08 53','Allen W. Norman',0,18,NULL),
        (50,'09 32 43 04 12','Dane M. Duke',1,12,NULL),
        (51,'09 74 45 29 61','Kiara G. Powell',0,20,NULL),
        (52,'04 79 93 20 12','Micah U. Duran',0,13,NULL),
        (53,'02 85 48 34 45','Evelyn K. Carlson',1,11,NULL),
        (54,'03 48 13 28 22','Hector U. Lucas',0,5,NULL),
        (55,'03 28 69 36 71','Meredith C. Mcintosh',0,5,NULL);
UNLOCK TABLES;

LOCK TABLES `transaction_list` WRITE;
INSERT INTO `transaction_list` (`list_id`, `date_created`, `date_updated`, `related_trader`)
    VALUES (103,'2025-10-14 06:42:26','2024-11-28 20:36:56',15),
        (104,'2024-11-30 08:44:47','2025-07-24 12:21:30',13),
        (105,'2024-08-14 08:07:56','2024-12-27 05:12:22',18),
        (106,'2025-03-14 09:27:32','2025-05-07 11:37:57',12),
        (107,'2024-08-31 01:43:42','2024-12-16 08:12:20',12),
        (108,'2025-07-17 06:46:35','2025-09-29 12:05:50',17),
        (109,'2025-01-26 02:18:53','2023-11-11 01:01:15',13),
        (110,'2023-11-15 10:57:47','2024-11-28 20:37:31',18),
        (111,'2024-11-06 13:16:26','2024-11-06 13:16:26',13),
        (113,'2024-11-24 14:39:48','2024-11-24 14:39:48',11),
        (114,'2024-11-24 17:27:25','2024-11-24 17:27:25',11),
        (115,'2024-11-24 17:27:40','2024-11-24 17:27:40',11),
        (116,'2024-11-24 17:29:46','2024-11-24 17:29:46',11),
        (121,'2024-11-24 17:40:35','2024-11-24 17:40:35',13);
UNLOCK TABLES;

LOCK TABLES `transactions` WRITE;
INSERT INTO `transactions` (`id`, `product_id`, `list_id`, `amount`, `logistic_info`, `status`, `price`, `date_created`, `date_updated`, `io`, `discount`, `note`)
    VALUES (1,6,110,12,'Ap #753-8346 Purus Av.',1,4367.90,'2025-03-28 10:06:51','2024-11-28 20:37:31',0,1,'osd'),
        (2,9,107,3,'Ap #470-7434 Non Street',2,9410.70,'2024-08-15 07:22:44','2025-02-09 08:26:50',0,1,NULL),
        (3,3,106,5,'Ap #751-7481 Neque St.',1,6873.93,'2025-05-16 06:08:28','2024-01-08 02:46:34',0,1,NULL),
        (4,3,110,7,'xx',1,111.00,'2024-11-24 16:09:45','2024-11-24 16:10:00',1,1,NULL),
        (5,9,110,33,'www',1,345345.00,'2024-11-24 16:12:31','2024-11-24 16:12:31',0,1,NULL),
        (6,1,103,33,'7559f0ac-aca5-11ef-a496-97ce45edd35b',0,1320.00,'2024-11-27 12:53:31','2024-11-27 12:53:31',0,1,'generated'),
        (7,1,103,33,'8f19f852-aca5-11ef-a496-97ce45edd35b',0,1320.00,'2024-11-27 12:54:14','2024-11-27 12:54:14',0,1,'generated'),
        (8,1,103,33,'f481e968-acb2-11ef-a496-97ce45edd35b',0,1320.00,'2024-11-27 14:30:07','2024-11-27 14:30:07',0,1,'generated'),
        (9,1,103,33,'ff22a16e-acb2-11ef-a496-97ce45edd35b',0,1320.00,'2024-11-27 14:30:25','2024-11-27 14:30:25',0,1,'generated'),
        (10,1,103,33,'06b4fc92-acb3-11ef-a496-97ce45edd35b',0,1320.00,'2024-11-27 14:30:38','2024-11-27 14:30:38',0,1,'generated'),
        (11,1,103,33,'0f4fc2e2-ad94-11ef-a496-97ce45edd35b',0,1320.00,'2024-11-28 17:21:29','2024-11-28 17:21:29',0,1,'generated'),
        (12,1,103,33,'20b2ca48-ad94-11ef-a496-97ce45edd35b',0,1320.00,'2024-11-28 17:21:58','2024-11-28 17:21:58',0,1,'generated'),
        (13,1,103,33,'f2e7783e-adac-11ef-a496-97ce45edd35b',0,1320.00,'2024-11-28 20:19:39','2024-11-28 20:19:39',0,1,'generated'),
        (14,1,103,33,'f8cb435c-adac-11ef-a496-97ce45edd35b',0,1320.00,'2024-11-28 20:19:49','2024-11-28 20:19:49',0,1,'generated'),
        (15,1,103,33,'5d47849c-adaf-11ef-a496-97ce45edd35b',0,1320.00,'2024-11-28 20:36:56','2024-11-28 20:36:56',0,1,'generated');
UNLOCK TABLES;