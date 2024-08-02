
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_name VARCHAR(255) NOT NULL,
    shipping_address TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO orders (order_name, shipping_address, created_at, quantity, updated_at, is_deleted) VALUES
('Order1', '123 Maple Street', '2024-07-31 10:00:00', 10, '2024-07-31 10:00:00', FALSE),
('Order2', '456 Oak Avenue', '2024-07-31 11:00:00', 20, '2024-07-31 11:00:00', FALSE),
('Order3', '789 Pine Road', '2024-07-31 12:00:00', 30, '2024-07-31 12:00:00', FALSE),
('Order4', '101 Birch Boulevard', '2024-07-31 13:00:00', 40, '2024-07-31 13:00:00', TRUE),
('Order5', '202 Cedar Lane', '2024-07-31 14:00:00', 50, '2024-07-31 14:00:00', FALSE);

CREATE TABLE product (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);



INSERT INTO product (product_name, description, price, created_at, updated_at) VALUES
('Product1', 'Description for Product1', 19.99, '2024-07-31 10:00:00', '2024-07-31 10:00:00'),
('Product2', 'Description for Product2', 29.99, '2024-07-31 11:00:00', '2024-07-31 11:00:00'),
('Product3', 'Description for Product3', 39.99, '2024-07-31 12:00:00', '2024-07-31 12:00:00'),
('Product4', 'Description for Product4', 49.99, '2024-07-31 13:00:00', '2024-07-31 13:00:00'),
('Product5', 'Description for Product5', 59.99, '2024-07-31 14:00:00', '2024-07-31 14:00:00');

-- Create product_orders_mapping table
CREATE TABLE product_orders_mapping (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID,
    order_id UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_deleted bool default false,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);
