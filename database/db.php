<?php
// ========================================
// ARTlance - Подключение к базе данных
// ========================================
// Этот файл подключается в начале каждого PHP-файла,
// который работает с базой данных.
//
// Пример использования:
//   require_once 'database/db.php';
//   $result = $pdo->query("SELECT * FROM users");
// ========================================

$host = 'localhost';       // Хост (для OpenServer всегда localhost)
$dbname = 'artlance';     // Имя базы данных
$username = 'root';        // Логин (по умолчанию в OpenServer - root)
$password = '';             // Пароль (по умолчанию в OpenServer - пустой)
$charset = 'utf8mb4';      // Кодировка

try {
    $pdo = new PDO(
        "mysql:host=$host;dbname=$dbname;charset=$charset",
        $username,
        $password,
        [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,    // Показывать ошибки
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,         // Возвращать ассоциативные массивы
            PDO::ATTR_EMULATE_PREPARES   => false,                     // Безопасные запросы
        ]
    );
} catch (PDOException $e) {
    // Если не удалось подключиться - показать ошибку
    die('Ошибка подключения к базе данных: ' . $e->getMessage());
}
?>
