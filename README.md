# Stockwise — Inventory Management System

Mini Project 3 berdasarkan file **Web 4.pptx — Relational Database + Advanced PHP**. Aplikasi menggunakan PHP native, MySQL, PDO, HTML/CSS.

## Fitur yang disertakan
- Login/logout, session, password hashing, role admin dan staff.
- Dashboard: total produk, nilai inventory, stok rendah, total unit, aktivitas terbaru.
- CRUD kategori, produk, supplier (admin).
- Relasi kategori → produk dan many-to-many produk ↔ supplier melalui `product_suppliers`.
- Barang masuk/keluar; validasi stok; `SELECT ... FOR UPDATE`; transaction `COMMIT`/`ROLLBACK`; histori pergerakan stok.
- Search nama/SKU, filter kategori, sorting allowlist, pagination 10 data per halaman.
- Laporan agregat barang masuk/keluar, stok akhir, dan nilai inventory; cetak / simpan PDF lewat browser.
- Prepared statements PDO, validasi server-side, output escaping `htmlspecialchars`, CSRF token, otorisasi server-side.
- SQL schema dengan foreign key dan aturan referential integrity.

## Instalasi (XAMPP)
1. Ekstrak folder `inventory-app` ke `C:\xampp\htdocs\inventory-app`.
2. Jalankan **Apache** dan **MySQL** di XAMPP.
3. Buka `http://localhost/phpmyadmin`, pilih tab **Import**, lalu impor `database/schema.sql`.
4. Jika username/password MySQL Anda berbeda, sesuaikan `config/database.php`.
5. Buka `http://localhost/inventory-app/public/`.
6. Klik **Buat akun admin**. Buat username dan password (minimal 8 karakter), kemudian login.
7. Setelah login admin, tambahkan user staff dari menu **Pengguna**.

## Role
- **Admin**: mengelola pengguna, kategori, produk, supplier, transaksi, dan laporan.
- **Staff**: melihat produk/kategori/supplier, mencatat barang masuk/keluar, melihat dashboard dan laporan. Tidak dapat mengakses administrasi pengguna/master data.

## Aturan bisnis utama
- SKU unik.
- Harga dan stok minimum tidak negatif.
- Jumlah transaksi harus bilangan bulat positif.
- Barang keluar tidak boleh melebihi stok tersedia.
- Produk yang memiliki histori transaksi tidak dapat dihapus.
- Halaman internal memerlukan login; admin-only actions diverifikasi di server.
- Perubahan stok dan penulisan histori dijalankan dalam satu transaksi database.
- Kolom sorting dipilih dari allowlist.

## Catatan
- Data contoh kategori, supplier, dan produk akan dimasukkan oleh `schema.sql`. Data contoh belum memiliki histori barang masuk/keluar.
- Halaman setup admin disediakan untuk instalasi awal. Setelah akun admin dibuat, jangan bagikan URL setup kepada orang yang tidak dipercaya.
- Ini merupakan starter project pembelajaran. Sebelum dipakai di server publik, tambahkan HTTPS, kebijakan backup, pembatasan akses setup, logging, dan pengujian keamanan sesuai lingkungan deployment.
