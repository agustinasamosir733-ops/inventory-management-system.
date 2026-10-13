CREATE DATABASE IF NOT EXISTS inventory_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE inventory_app;

CREATE TABLE IF NOT EXISTS users (
 id INT AUTO_INCREMENT PRIMARY KEY,
 username VARCHAR(60) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL,
 full_name VARCHAR(120) NOT NULL,
 role ENUM('admin','staff') NOT NULL DEFAULT 'staff',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS user_profiles (
 id INT AUTO_INCREMENT PRIMARY KEY,
 user_id INT NOT NULL UNIQUE,
 phone VARCHAR(30) NULL,
 address VARCHAR(255) NULL,
 CONSTRAINT fk_profile_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS categories (
 id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(100) NOT NULL UNIQUE,
 description VARCHAR(255) NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS suppliers (
 id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(150) NOT NULL,
 phone VARCHAR(40) NULL,
 email VARCHAR(120) NULL,
 address VARCHAR(255) NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS products (
 id INT AUTO_INCREMENT PRIMARY KEY,
 category_id INT NOT NULL,
 sku VARCHAR(50) NOT NULL UNIQUE,
 name VARCHAR(150) NOT NULL,
 price DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK(price >= 0),
 stock INT NOT NULL DEFAULT 0 CHECK(stock >= 0),
 minimum_stock INT NOT NULL DEFAULT 5 CHECK(minimum_stock >= 0),
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_product_category FOREIGN KEY(category_id) REFERENCES categories(id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS product_suppliers (
 product_id INT NOT NULL,
 supplier_id INT NOT NULL,
 supplier_price DECIMAL(12,2) NULL,
 PRIMARY KEY(product_id,supplier_id),
 CONSTRAINT fk_ps_product FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE,
 CONSTRAINT fk_ps_supplier FOREIGN KEY(supplier_id) REFERENCES suppliers(id) ON DELETE RESTRICT
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS stock_movements (
 id BIGINT AUTO_INCREMENT PRIMARY KEY,
 product_id INT NOT NULL,
 user_id INT NOT NULL,
 type ENUM('IN','OUT') NOT NULL,
 quantity INT NOT NULL CHECK(quantity > 0),
 note VARCHAR(255) NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_movement_product FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE RESTRICT,
 CONSTRAINT fk_movement_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE RESTRICT,
 INDEX idx_movement_date(created_at), INDEX idx_movement_product(product_id)
) ENGINE=InnoDB;

INSERT IGNORE INTO categories(name,description) VALUES ('Elektronik','Perangkat elektronik'),('Alat Tulis','Perlengkapan alat tulis'),('Kebutuhan Rumah','Barang kebutuhan rumah');
INSERT IGNORE INTO suppliers(name,phone,email,address) VALUES ('Supplier Utama','081234567890','supplier@example.com','Medan');
INSERT IGNORE INTO products(category_id,sku,name,price,stock,minimum_stock) VALUES
((SELECT id FROM categories WHERE name='Elektronik'),'ELK-001','Mouse Wireless',85000,25,5),
((SELECT id FROM categories WHERE name='Elektronik'),'ELK-002','Keyboard USB',125000,12,5),
((SELECT id FROM categories WHERE name='Alat Tulis'),'ATK-001','Buku Tulis',5000,40,10);
INSERT IGNORE INTO product_suppliers(product_id,supplier_id,supplier_price)
SELECT p.id,s.id,p.price FROM products p CROSS JOIN suppliers s;
