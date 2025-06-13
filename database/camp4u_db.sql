-- Tabel Users (untuk Registration POST & Login GET & Profile PATCH/GET)
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    phone_number VARCHAR(20),
    profile_picture VARCHAR(255),
    address TEXT,
    city VARCHAR(50),
    province VARCHAR(50),
    postal_code VARCHAR(10),
    date_of_birth DATE,
    gender ENUM('male', 'female', 'other'),
    is_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel Categories (untuk Home GET - menampilkan kategori)
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    icon VARCHAR(255),
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    order_index INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Products (untuk Home GET, Product POST, Product Detail POST)
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    owner_id INT NOT NULL,
    category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    brand VARCHAR(50),
    condition_rating DECIMAL(2,1) DEFAULT 5.0,
    price_per_day DECIMAL(10,2) NOT NULL,
    deposit_amount DECIMAL(10,2) DEFAULT 0,
    stock_quantity INT DEFAULT 1,
    availability_status ENUM('available', 'rented', 'maintenance', 'inactive') DEFAULT 'available',
    location_city VARCHAR(50),
    location_province VARCHAR(50),
    pickup_address TEXT,
    specifications JSON,
    weight DECIMAL(5,2),
    dimensions VARCHAR(50),
    rental_terms TEXT,
    view_count INT DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Tabel Product Images (untuk Product Detail)
CREATE TABLE product_images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    order_index INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Tabel Cart (untuk Cart POST/PUT/PATCH - ngirim, update, ubah sebagian)
CREATE TABLE cart (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT DEFAULT 1,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days INT NOT NULL,
    price_per_day DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    UNIQUE KEY unique_cart_item (user_id, product_id)
);

-- Tabel Bookings (untuk Booking POST)
CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_code VARCHAR(20) UNIQUE NOT NULL,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    total_deposit DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'active', 'completed', 'cancelled') DEFAULT 'pending',
    pickup_method ENUM('pickup', 'delivery') DEFAULT 'pickup',
    delivery_address TEXT,
    delivery_fee DECIMAL(10,2) DEFAULT 0,
    pickup_date DATETIME,
    return_date DATETIME,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Tabel Booking Items (detail item dalam booking)
CREATE TABLE booking_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    product_id INT NOT NULL,
    owner_id INT NOT NULL,
    quantity INT DEFAULT 1,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days INT NOT NULL,
    price_per_day DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    deposit_amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'active', 'completed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (owner_id) REFERENCES users(id)
);

-- Tabel Payments (untuk Transfer GET/PATCH, COD GET, QRIS POST)
CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_method ENUM('transfer_bca', 'transfer_mandiri', 'transfer_bni', 'transfer_bri', 'qris', 'cod') NOT NULL,
    payment_type ENUM('rental', 'deposit', 'refund') NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'waiting_confirmation', 'completed', 'failed', 'expired') DEFAULT 'pending',
    payment_code VARCHAR(50),
    account_number VARCHAR(50),
    account_name VARCHAR(100),
    admin_fee DECIMAL(10,2) DEFAULT 0,
    unique_code INT,
    expired_at DATETIME,
    paid_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

-- Tabel Payment Proofs (untuk Bukti Transfer POST)
CREATE TABLE payment_proofs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    payment_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    bank_name VARCHAR(50),
    account_name VARCHAR(100),
    transfer_amount DECIMAL(10,2),
    transfer_date DATETIME,
    notes TEXT,
    verification_status ENUM('pending', 'verified', 'rejected') DEFAULT 'pending',
    verified_by INT NULL,
    verified_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (payment_id) REFERENCES payments(id),
    FOREIGN KEY (verified_by) REFERENCES users(id)
);

-- Tabel Reviews (untuk Ulasan GET, Tulis Ulasan POST)
CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    booking_item_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    review_images JSON,
    is_anonymous BOOLEAN DEFAULT FALSE,
    helpful_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (reviewer_id) REFERENCES users(id),
    FOREIGN KEY (booking_item_id) REFERENCES booking_items(id),
    UNIQUE KEY unique_review (booking_item_id, reviewer_id)
);

-- Tabel Messages (untuk Chat POST)
CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    booking_id INT NULL,
    message_type ENUM('text', 'image', 'document', 'system') DEFAULT 'text',
    message TEXT NOT NULL,
    attachment_url VARCHAR(255),
    attachment_name VARCHAR(255),
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (receiver_id) REFERENCES users(id),
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

-- Tabel Notifications (untuk Notifikasi GET di Promo, POST di Payment)
CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    type ENUM('booking', 'payment', 'chat', 'promo', 'system', 'review') NOT NULL,
    title VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    image_url VARCHAR(255),
    action_url VARCHAR(255),
    data JSON,
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Tabel Promotions (untuk Promo GET di Notifikasi)
CREATE TABLE promotions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    promo_code VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    discount_type ENUM('percentage', 'fixed') NOT NULL,
    discount_value DECIMAL(10,2) NOT NULL,
    min_transaction DECIMAL(10,2) DEFAULT 0,
    max_discount DECIMAL(10,2),
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    usage_limit INT,
    usage_limit_per_user INT DEFAULT 1,
    used_count INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel User Promotions (tracking penggunaan promo)
CREATE TABLE user_promotions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    promotion_id INT NOT NULL,
    booking_id INT,
    discount_amount DECIMAL(10,2) NOT NULL,
    used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (promotion_id) REFERENCES promotions(id),
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

-- Tabel Rental History (untuk Profile GET - Riwayat Penyewaan)
CREATE TABLE rental_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    booking_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    rental_start DATE NOT NULL,
    rental_end DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('completed', 'cancelled') NOT NULL,
    rating_given DECIMAL(2,1),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Tabel FAQ (untuk Panduan GET)
CREATE TABLE faqs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category ENUM('rental', 'payment', 'return', 'damage', 'general') NOT NULL,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    order_index INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Guides (untuk Panduan GET - tips dan tutorial)
CREATE TABLE guides (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    image_url VARCHAR(255),
    category ENUM('setup', 'maintenance', 'tips', 'safety') NOT NULL,
    order_index INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Wishlist/Favorites
CREATE TABLE wishlist (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    UNIQUE KEY unique_wishlist (user_id, product_id)
);

-- Tabel Bank Accounts (untuk Transfer GET)
CREATE TABLE bank_accounts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    bank_code ENUM('bca', 'mandiri', 'bni', 'bri') NOT NULL,
    bank_name VARCHAR(50) NOT NULL,
    account_number VARCHAR(50) NOT NULL,
    account_name VARCHAR(100) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert data bank accounts
INSERT INTO bank_accounts (bank_code, bank_name, account_number, account_name) VALUES
('bca', 'Bank Central Asia', '1234567890', 'PT Camping Rental'),
('mandiri', 'Bank Mandiri', '1370012345678', 'PT Camping Rental'),
('bni', 'Bank Negara Indonesia', '1234567890', 'PT Camping Rental'),
('bri', 'Bank Rakyat Indonesia', '123456789012345', 'PT Camping Rental');

-- Insert data kategori
INSERT INTO categories (name, description, icon, image_url, order_index) VALUES
('Tenda', 'Tenda untuk camping dan outdoor', 'tent_icon.png', 'tent_category.jpg', 1),
('Sleeping Bag', 'Kantong tidur untuk outdoor', 'sleeping_bag_icon.png', 'sleeping_bag_category.jpg', 2),
('Backpack', 'Tas gunung dan carrier', 'backpack_icon.png', 'backpack_category.jpg', 3),
('Peralatan Masak', 'Kompor, panci, dan peralatan masak', 'cooking_icon.png', 'cooking_category.jpg', 4),
('Lampu', 'Headlamp, lantern, dan penerangan', 'light_icon.png', 'light_category.jpg', 5),
('Climbing Gear', 'Peralatan panjat tebing', 'climbing_icon.png', 'climbing_category.jpg', 6);

-- Insert sample FAQ
INSERT INTO faqs (category, question, answer, order_index) VALUES
('rental', 'Bagaimana cara menyewa peralatan?', 'Pilih produk → Masukkan tanggal → Tambah ke keranjang → Checkout → Bayar → Ambil barang', 1),
('payment', 'Metode pembayaran apa saja yang tersedia?', 'Transfer Bank (BCA, Mandiri, BNI, BRI), QRIS, dan COD', 2),
('return', 'Bagaimana cara mengembalikan barang?', 'Kembalikan barang sesuai jadwal dalam kondisi bersih dan tidak rusak', 3),
('damage', 'Apa yang terjadi jika barang rusak?', 'Biaya perbaikan akan dipotong dari deposit sesuai tingkat kerusakan', 4);

-- Indexes untuk optimasi
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_location ON products(location_city, location_province);
CREATE INDEX idx_products_featured ON products(is_featured, availability_status);
CREATE INDEX idx_cart_user ON cart(user_id);
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_payments_booking ON payments(booking_id);
CREATE INDEX idx_messages_conversation ON messages(sender_id, receiver_id);
CREATE INDEX idx_notifications_user ON notifications(user_id, is_read);
CREATE INDEX idx_reviews_product ON reviews(product_id);
CREATE INDEX idx_rental_history_user ON rental_history(user_id);