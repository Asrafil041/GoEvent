import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// LoginPage adalah StatelessWidget yang menampilkan halaman login.
class LoginPage extends StatelessWidget {
  // Konstruktor untuk LoginPage.
  const LoginPage({super.key});

  @override
  // Metode build dipanggil untuk membuat antarmuka pengguna halaman.
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar untuk halaman, seperti app bar dan body.
    return Scaffold(
      // SingleChildScrollView memungkinkan konten untuk digulir jika melebihi ukuran layar.
      body: SingleChildScrollView(
        // Padding memberikan ruang di sekitar konten.
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          // Column menyusun widget anaknya secara vertikal.
          child: Column(
            // Pusatkan konten utama di tengah secara vertikal.
            mainAxisAlignment: MainAxisAlignment.center,
            // Rentangkan anak-anak untuk mengisi lebar horizontal.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox menambahkan ruang vertikal.
              const SizedBox(height: 80),
              // Image.asset menampilkan gambar dari folder assets.
              Image.asset(
                'assets/images/logo.png',
                height: 80,
              ),
              // SizedBox menambahkan ruang vertikal.
              const SizedBox(height: 8),
              // Text menampilkan nama aplikasi.
              const Text(
                'GoEvent',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB71C1C),
                ),
              ),
              // SizedBox menambahkan ruang vertikal.
              const SizedBox(height: 40),
              // Text menampilkan judul "Login".
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox menambahkan ruang vertikal.
              const SizedBox(height: 24),
              // TextField untuk input email.
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email ID',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              // SizedBox menambahkan ruang vertikal.
              const SizedBox(height: 16),
              // TextField untuk input password.
              TextField(
                // obscureText menyembunyikan teks (untuk password).
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              // SizedBox menambahkan ruang vertikal.
              const SizedBox(height: 8),
              // Align menyelaraskan widget anaknya ke kanan.
              const Align(
                alignment: Alignment.centerRight,
                // Text untuk tautan "Lupa password?".
                child: Text(
                  'Lupa password?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              // SizedBox menambahkan ruang vertikal.
              const SizedBox(height: 24),
              // ElevatedButton adalah tombol dengan latar belakang.
              ElevatedButton(
                // onPressed adalah fungsi yang dipanggil saat tombol ditekan.
                onPressed: () {
                  // Menggunakan GoRouter untuk navigasi ke halaman utama.
                  context.go('/home');
                },
                // style untuk menyesuaikan tampilan tombol.
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                // child adalah widget yang ditampilkan di dalam tombol.
                child: const Text(
                  'Masuk',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              // SizedBox menambahkan ruang vertikal.
              const SizedBox(height: 24),
              // Row menyusun widget anaknya secara horizontal.
              const Row(
                children: [
                  // Expanded membuat Divider mengisi ruang yang tersedia.
                  Expanded(child: Divider()),
                  // Padding memberikan ruang di sekitar teks "Atau".
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Atau'),
                  ),
                  // Expanded membuat Divider mengisi ruang yang tersedia.
                  Expanded(child: Divider()),
                ],
              ),
              // SizedBox menambahkan ruang vertikal.
              const SizedBox(height: 24),
              // OutlinedButton adalah tombol dengan garis tepi.
              OutlinedButton.icon(
                onPressed: () {},
                // icon adalah ikon yang ditampilkan di sebelah label.
                icon: SvgPicture.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png',
                  height: 20,
                  width: 20,
                ),
                // label adalah teks yang ditampilkan di sebelah ikon.
                label: const Text('Masuk dengan Google'),
                // style untuk menyesuaikan tampilan tombol.
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              // SizedBox menambahkan ruang vertikal.
              const SizedBox(height: 24),
              // Row menyusun widget anaknya secara horizontal.
              Row(
                // Pusatkan konten utama di tengah secara horizontal.
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text menampilkan "Belum punya akun?".
                  const Text('Belum punya akun?'),
                  // TextButton adalah tombol teks.
                  TextButton(
                    // onPressed adalah fungsi yang dipanggil saat tombol ditekan.
                    onPressed: () {
                      // Menggunakan GoRouter untuk navigasi ke halaman registrasi.
                      context.go('/register');
                    },
                    // child adalah widget yang ditampilkan di dalam tombol.
                    child: const Text('Daftar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
