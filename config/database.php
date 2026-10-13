<?php
// Sesuaikan dengan konfigurasi MySQL di komputer Anda.
$host = '127.0.0.1'; $db = 'inventory_app'; $user = 'root'; $pass = '';
$dsn = "mysql:host=$host;dbname=$db;charset=utf8mb4";
try { $pdo = new PDO($dsn, $user, $pass, [PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC, PDO::ATTR_EMULATE_PREPARES=>false]); }
catch (PDOException $e) { http_response_code(500); exit('Koneksi database gagal. Periksa config/database.php dan pastikan MySQL aktif.'); }
