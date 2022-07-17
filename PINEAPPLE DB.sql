-- Pineapple DB
CREATE CREATE pna;

-- User info
CREATE USER pna IDENTIFIED BY pna; -- owner
GRANT ALL ON SCHEMA pna TO pna;

CREATE USER pna_app IDENTIFIED BY pna_app; -- aplicativo
GRANT CONNECT TO pna_app;

-- Table User
CREATE TABLE pna_user (
    user_id     SERIAL NOT NULL,
    email       VARCHAR(100) NOT NULL,
    name        VARCHAR(80) NOT NULL,
    document    VARCHAR(30) NOT NULL,
    phone       VARCHAR(20)
);

ALTER TABLE pna_user
    ADD CONSTRAINT pna_user_pk PRIMARY KEY (user_id);
ALTER TABLE pna_user
    ADD CONSTRAINT pna_user_uk UNIQUE (email);

-- Table Address
CREATE TABLE pna_address (
    address_id      SERIAL NOT NULL,
    line1           VARCHAR(200) NOT NULL,
    line2           VARCHAR(200),
    line3           VARCHAR(100),
    city            VARCHAR(100) NOT NULL,
    state           VARCHAR(100) NOT NULL,
    country         VARCHAR(100),
    zip             VARCHAR(20),
    user_id         BIGINTEGER NOT NULL
);

ALTER TABLE pna_address
    ADD CONSTRAINT pna_address_pk PRIMARY KEY (address_id);
ALTER TABLE pna_address
    ADD CONSTRAINT pna_addr_user_fk FOREIGN KEY (user_id) REFERENCES pna_user(user_id);

-- Table Product
CREATE TABLE pna_product (
    product_id      SERIAL NOT NULL,
    name            VARCHAR(200) NOT NULL,
    descr           VARCHAR(4000),
    descr_add       VARCHAR(4000),
    model           VARCHAR(200) NOT NULL,
    price           NUMERIC(10, 2) NOT NULL,
    discount        NUMERIC(10, 2),
    weight          NUMERIC(3, 3),
    dimensions      VARCHAR(8),
    packing_weight  NUMERIC(3, 3),
    packing_dim     VARCHAR(8)
);

ALTER TABLE pna_product
    ADD CONSTRAINT pna_product_pk PRIMARY KEY (product_id);

-- Table Product Image
CREATE TABLE pna_product_image (
    product_id      BIGINTEGER NOT NULL,
    uri             VARCHAR(200) NOT NULL
);

ALTER TABLE pna_product_image
    ADD CONSTRAINT pna_product_image_pk PRIMARY KEY (product_id, uri);

-- Table Product Options
CREATE TABLE pna_product_option (
    key         VARCHAR(100) NOT NULL,
    value       VARCHAR(100) NOT NULL,
    product_id  BIGINTEGER NOT NULL
);

ALTER TABLE pna_product_option
    ADD CONSTRAINT pna_product_option_uk UNIQUE (key, value, product_id);
ALTER TABLE pna_product_option
    ADD CONSTRAINT pna_product_option_fk FOREIGN KEY (product_id) REFERENCES pna_product(product_id);

-- Table Product Feature
CREATE TABLE pna_product_feature (
    key         VARCHAR(100) NOT NULL,
    value       VARCHAR(100) NOT NULL,
    product_id  BIGINTEGER NOT NULL
);

ALTER TABLE pna_product_feature
    ADD CONSTRAINT pna_product_feature_uk UNIQUE (key, value, product_id);
ALTER TABLE pna_product_feature
    ADD CONSTRAINT pna_product_feature_fk FOREIGN KEY (product_id) REFERENCES pna_product(product_id);

-- Table Cart
CREATE TABLE pna_cart (
    user_id     BIGINTEGER NOT NULL,
    product_id  BIGINTEGER NOT NULL,
    quantity    INTEGER DEFAULT 1
);

ALTER TABLE pna_cart
    ADD CONSTRAINT pna_cart_user_fk FOREIGN KEY (user_id) REFERENCES pna_user(user_id);

ALTER TABLE pna_cart
    ADD CONSTRAINT pna_cart_product_fk FOREIGN KEY (product_id) REFERENCES pna_product(product_id);


-- Table WishList
CREATE TABLE pna_wishlist (
    user_id     BIGINTEGER NOT NULL,
    product_id  BIGINTEGER NOT NULL
);

ALTER TABLE pna_wishlist
    ADD CONSTRAINT pna_wishlist_user_fk FOREIGN KEY (user_id) REFERENCES pna_user(user_id);

ALTER TABLE pna_wishlist
    ADD CONSTRAINT pna_wishlist_product_fk FOREIGN KEY (product_id) REFERENCES pna_product(product_id);

-- Table Order
CREATE TABLE pna_order (
    order_id        SERIAL NOT NULL,
    name            VARCHAR(200) NOT NULL,
    descr           VARCHAR(4000),
    descr_add       VARCHAR(4000),
    model           VARCHAR(200) NOT NULL,
    price           NUMERIC(10, 2) NOT NULL,
    discount        NUMERIC(10, 2),
    weight          NUMERIC(3, 3),
    dimensions      VARCHAR(8),
    packing_weight  NUMERIC(3, 3),
    packing_dim     VARCHAR(8)
);

ALTER TABLE pna_order
    ADD CONSTRAINT pna_order_pk PRIMARY KEY (order_id);

-- Table Order Selected Options
CREATE TABLE pna_order_option (
    key         VARCHAR(100) NOT NULL,
    value       VARCHAR(100) NOT NULL,
    order_id    BIGINTEGER NOT NULL
);

ALTER TABLE pna_order_option
    ADD CONSTRAINT pna_order_option_uk UNIQUE (key, value, order_id);
ALTER TABLE pna_order_option
    ADD CONSTRAINT pna_order_option_fk FOREIGN KEY (order_id) REFERENCES pna_order(order_id);

-- Table Sale
CREATE TABLE pna_sale (
    sale_id             SERIAL NOT NULL,
    status              VARCHAR(50) NOT NULL,
    items_subtotal      NUMERIC(10, 2) NOT NULL,
    total_price         NUMERIC(10, 2) NOT NULL,
    delivery_total      NUMERIC(10, 2) NOT NULL,
    discount_total      NUMERIC(10, 2)
);

ALTER TABLE pna_sale 
    ADD CONSTRAINT pna_sale_pk PRIMARY KEY (sale_id);

-- Table Payment
CREATE TABLE pna_payment (
    payment_id      SERIAL NOT NULL,
    type            VARCHAR(100) NOT NULL,
    number          VARCHAR(100) NOT NULL,
    client          VARCHAR(80) NOT NULL,
    client_document VARCHAR(30) NOT NULL,
    expiration      DATETIME NOT NULL
);

ALTER TABLE pna_payment
    ADD CONSTRAINT pna_payment_pk PRIMARY KEY (payment_id);

-- Table Tracking
CREATE TABLE pna_tracking (
    tracking_id         SERIAL NOT NULL,
    tracking_code       VARCHAR(100),
    company             VARCHAR(100)
);

ALTER TABLE pna_tracking
    ADD CONSTRAINT pna_tracking_pk PRIMARY KEY (tracking_id);

-- Grants
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_address TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_user TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_product TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_product_image TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_product_option TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_product_feature TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_cart TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_wishlist TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_order TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_order_option TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_sale TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_payment TO pna_app;
GRANT SELECT, INSERT, DELETE, UPDATE ON pna_tracking TO pna_app;
