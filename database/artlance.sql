-- ========================================
-- ARTlance - База данных
-- Импортировать в phpMyAdmin через вкладку "Импорт"
-- ========================================

-- Создание базы данных
CREATE DATABASE IF NOT EXISTS `artlance` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `artlance`;

-- ========================================
-- Таблица: users (Пользователи)
-- Хранит всех пользователей сайта
-- user_role: 'заказчик' или 'художник'
-- ========================================
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_name` TEXT NOT NULL,
  `user_tel` TEXT DEFAULT NULL,
  `user_role` ENUM('заказчик', 'художник') NOT NULL,
  `user_registration_date` TEXT DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- Таблица: categories (Категории услуг)
-- Например: 3D-моделирование, Графический дизайн
-- ========================================
CREATE TABLE IF NOT EXISTS `categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categories` TEXT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- Таблица: services (Услуги художников)
-- Каждая услуга принадлежит художнику и категории
-- ========================================
CREATE TABLE IF NOT EXISTS `services` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `service` TEXT NOT NULL,
  `artist_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `price` DECIMAL(10,0) NOT NULL DEFAULT 0,
  `sales` INT NOT NULL DEFAULT 0,
  `creation_date` TEXT DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_services_artist` (`artist_id`),
  KEY `fk_services_category` (`category_id`),
  CONSTRAINT `fk_services_artist` FOREIGN KEY (`artist_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_services_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- Таблица: orders (Заказы)
-- Связывает заказчика, художника и услугу
-- status: 'в работе', 'выполнено', 'отменено'
-- ========================================
CREATE TABLE IF NOT EXISTS `orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `service_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  `price` DECIMAL(10,0) NOT NULL DEFAULT 0,
  `status` ENUM('в работе', 'выполнено', 'отменено') NOT NULL DEFAULT 'в работе',
  `order_date` TEXT DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orders_service` (`service_id`),
  KEY `fk_orders_artist` (`artist_id`),
  KEY `fk_orders_client` (`client_id`),
  CONSTRAINT `fk_orders_service` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_artist` FOREIGN KEY (`artist_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_client` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- Таблица: reviews (Отзывы)
-- Привязаны к пользователю через user_id
-- ========================================
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `reviews` TEXT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reviews_user` (`user_id`),
  CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- Таблица: transactions (Транзакции / Финансы)
-- type: 'перевод средств', 'пополнение счета', 'вывод средств'
-- status: 'успешно', 'отменено'
-- ========================================
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `type` ENUM('перевод средств', 'пополнение счета', 'вывод средств') NOT NULL,
  `amount` DECIMAL(10,0) NOT NULL DEFAULT 0,
  `transaction_date` TEXT DEFAULT NULL,
  `status` ENUM('успешно', 'отменено') NOT NULL DEFAULT 'успешно',
  `payment_details` TEXT DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transactions_user` (`user_id`),
  CONSTRAINT `fk_transactions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- Тестовые данные
-- ========================================

-- Пользователи
INSERT INTO `users` (`user_name`, `user_tel`, `user_role`, `user_registration_date`) VALUES
('Екатерина Кравчук', '+7 (999) 123-45-67', 'художник', '2025-01-15'),
('Иван Петров', '+7 (999) 765-43-21', 'заказчик', '2025-02-01'),
('Ермакова Мария', '+7 (999) 111-22-33', 'заказчик', '2025-02-10'),
('Елько Александр', '+7 (999) 444-55-66', 'заказчик', '2025-03-01'),
('Строгая Наталья', '+7 (999) 777-88-99', 'заказчик', '2025-03-15'),
('Лисицин Ванечка', '+7 (999) 000-11-22', 'заказчик', '2025-04-01'),
('Анна Смирнова', '+7 (999) 333-44-55', 'художник', '2025-01-20');

-- Категории
INSERT INTO `categories` (`categories`) VALUES
('3D-моделирование и визуализация'),
('Графический дизайн'),
('Цифровая живопись'),
('Иллюстрация'),
('Анимация');

-- Услуги
INSERT INTO `services` (`service`, `artist_id`, `category_id`, `price`, `sales`, `creation_date`) VALUES
('3D-моделирование персонажа', 1, 1, 30000, 5, '2025-02-01'),
('Дизайн логотипа', 1, 2, 15000, 12, '2025-02-15'),
('Цифровой портрет', 7, 3, 10000, 8, '2025-03-01'),
('Иллюстрация для книги', 7, 4, 20000, 3, '2025-03-10');

-- Заказы
INSERT INTO `orders` (`service_id`, `artist_id`, `client_id`, `price`, `status`, `order_date`) VALUES
(1, 1, 2, 30000, 'выполнено', '2025-03-01'),
(2, 1, 3, 15000, 'в работе', '2025-04-01'),
(3, 7, 4, 10000, 'выполнено', '2025-04-05'),
(1, 1, 5, 30000, 'в работе', '2025-04-10');

-- Отзывы
INSERT INTO `reviews` (`reviews`, `user_id`) VALUES
('Большое спасибо! Выполнено все быстро качественно. Буду обращаться еще.', 3),
('Большое спасибо!', 4),
('Выполнено все быстро качественно. Буду обращаться еще.', 5),
('СУПЕР КЛАСС ЛАЙК РЕСПЕКТ. ОЧЕНЬ КРУТО СДЕЛАЛА И НЕ ДОРОГО. БЕРИТЕ НЕ ПОЖАЛЕЕТЕ!!!!!!!!!!!', 6);

-- Транзакции
INSERT INTO `transactions` (`user_id`, `type`, `amount`, `transaction_date`, `status`, `payment_details`) VALUES
(2, 'пополнение счета', 50000, '2025-03-01', 'успешно', 'Банковская карта **** 1234'),
(2, 'перевод средств', 30000, '2025-03-01', 'успешно', 'Оплата заказа #1'),
(3, 'пополнение счета', 20000, '2025-04-01', 'успешно', 'Банковская карта **** 5678'),
(1, 'вывод средств', 25000, '2025-04-02', 'успешно', 'На карту **** 9012');
