-- -----------------------------------------------------
-- Schema online_store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema online_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `online_store` DEFAULT CHARACTER SET utf8 ;
USE `online_store` ;

-- -----------------------------------------------------
-- Table `online_store`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `region` VARCHAR(255) NULL,
  `city` VARCHAR(255) NULL,
  `street` VARCHAR(255) NULL,
  `street_type` INT NULL,
  `house_number` VARCHAR(50) NULL,
  `post_index` VARCHAR(6) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`cart` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sum` DECIMAL(13,2) NULL,
  `count` INT NULL,
  `product_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `birth_date` DATE NULL,
  `gender` INT NULL,
  `mobile_number` VARCHAR(15) NULL,
  `email` VARCHAR(50) NULL,
  `address_id` INT NOT NULL,
  `cart_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_address_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_customer_cart1_idx` (`cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `online_store`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_cart1`
    FOREIGN KEY (`cart_id`)
    REFERENCES `online_store`.`cart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `price` DECIMAL(13,2) NULL,
  `weight` DECIMAL(5,1) NULL,
  `quantity` INT NULL,
  `characteristics` JSON NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`wishlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`wishlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_wishlist_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_wishlist_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `online_store`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`order_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status_name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`delivery_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`delivery_method` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `count` INT NULL,
  `order_date` DATE NULL,
  `delivery_date` DATE NULL,
  `order_status_id` INT NOT NULL,
  `delivery_method_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_order_status1_idx` (`order_status_id` ASC) VISIBLE,
  INDEX `fk_order_delivery_method1_idx` (`delivery_method_id` ASC) VISIBLE,
  INDEX `fk_orders_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_order_status1`
    FOREIGN KEY (`order_status_id`)
    REFERENCES `online_store`.`order_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_delivery_method1`
    FOREIGN KEY (`delivery_method_id`)
    REFERENCES `online_store`.`delivery_method` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `online_store`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`order_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NULL,
  `price` DECIMAL(13,2) NULL,
  `orders_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_items_orders1_idx` (`orders_id` ASC) VISIBLE,
  INDEX `fk_order_item_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_items_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `online_store`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_item_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `online_store`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`cart_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`cart_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NULL,
  `price` DECIMAL(13,2) NULL,
  `cart_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cart_item_cart1_idx` (`cart_id` ASC) VISIBLE,
  INDEX `fk_cart_item_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_cart_item_cart1`
    FOREIGN KEY (`cart_id`)
    REFERENCES `online_store`.`cart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_item_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `online_store`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`product_has_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`product_has_category` (
  `product_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`product_id`, `category_id`),
  INDEX `fk_product_has_category_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_product_has_category_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_category_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `online_store`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `online_store`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_store`.`wishlist_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_store`.`wishlist_item` (
  `idwishlist_item` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `wishlist_id` INT NOT NULL,
  PRIMARY KEY (`idwishlist_item`, `product_id`),
  INDEX `fk_wishlist_item_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_wishlist_item_wishlist1_idx` (`wishlist_id` ASC) VISIBLE,
  CONSTRAINT `fk_wishlist_item_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `online_store`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wishlist_item_wishlist1`
    FOREIGN KEY (`wishlist_id`)
    REFERENCES `online_store`.`wishlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
