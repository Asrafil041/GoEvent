// Mengimpor pustaka dasar dari Flutter untuk membangun UI.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// RegisterPage adalah StatefulWidget, artinya dapat menyimpan state (keadaan) yang bisa berubah (seperti visibility password).
class RegisterPage extends StatefulWidget {
  // Konstruktor untuk RegisterPage.
  const RegisterPage({super.key});

  // Membuat dan mengembalikan state (keadaan) untuk widget ini.
  @override
  RegisterPageState createState() => RegisterPageState();
}

// RegisterPageState adalah kelas state untuk RegisterPage.
class RegisterPageState extends State<RegisterPage> {
  // GlobalKey untuk mengelola state dari Form.
  final _formKey = GlobalKey<FormState>();
  // Controller untuk setiap TextField untuk mendapatkan nilainya.
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  // Variabel boolean untuk mengontrol apakah teks password disembunyikan atau tidak.
  bool _obscureText = true;

  @override
  void dispose() {
    // Membersihkan controller saat widget di-dispose untuk menghindari memory leak.
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _register() {
    // Memvalidasi form. Jika valid, maka lanjutkan.
    if (_formKey.currentState!.validate()) {
      // Di sini, Anda akan menambahkan logika untuk mengirim data ke server/Firebase.
      // Untuk saat ini, kita hanya akan menampilkan SnackBar dan menavigasi.

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran berhasil! Silakan masuk.')),
      );

      // Navigasi ke halaman login setelah pendaftaran berhasil.
      context.go('/login');
    }
  }

  // Metode 'build' untuk merender UI halaman pendaftaran.
  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar halaman.
    return Scaffold(
      // AppBar di bagian atas layar.
      appBar: AppBar(
        // Tombol di sisi kiri AppBar (untuk kembali).
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ikon panah kembali.
          onPressed: () {
            // Aksi saat tombol ditekan.
            context
                .pop(); // Kembali ke halaman sebelumnya menggunakan GoRouter.
          },
        ),
        backgroundColor: Colors.transparent, // Membuat AppBar transparan.
        elevation: 0, // Menghilangkan bayangan di bawah AppBar.
      ),
      // SingleChildScrollView memungkinkan konten untuk di-scroll jika ukurannya melebihi layar.
      body: SingleChildScrollView(
        // Memberi padding horizontal pada konten.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          // Form widget untuk mengelola validasi input.
          child: Form(
            key: _formKey,
            // Column untuk menata widget anak secara vertikal.
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Menengahkan anak secara vertikal.
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, // Merentangkan anak agar memenuhi lebar horizontal.
              children: <Widget>[
                const SizedBox(height: 20), // Spasi vertikal.
                // Menampilkan gambar logo aplikasi.
                Image.asset(
                  'assets/images/logo.png', // Path ke file gambar logo.
                  height: 100, // Tinggi gambar.
                ),
                const SizedBox(height: 10), // Spasi vertikal.
                // Teks nama aplikasi.
                const Text(
                  'GoEvent',
                  textAlign: TextAlign.center, // Teks ditengahkan.
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB71C1C), // Warna teks merah tua.
                  ),
                ),
                const SizedBox(height: 40), // Spasi vertikal.
                // Teks judul form.
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20), // Spasi vertikal.
                // Input field untuk nama.
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person_outline), // Ikon di awal field.
                    border: UnderlineInputBorder(), // Gaya border bawah.
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20), // Spasi vertikal.
                // Input field untuk email.
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email ID',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType
                      .emailAddress, // Menampilkan keyboard tipe email.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Masukkan format email yang valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20), // Spasi vertikal.
                // Input field untuk password.
                TextFormField(
                  controller: _passwordController,
                  obscureText:
                      _obscureText, // Menyembunyikan teks jika _obscureText true.
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const UnderlineInputBorder(),
                    // Ikon di akhir field untuk mengubah visibilitas password.
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Mengubah ikon berdasarkan state _obscureText.
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        // Aksi saat ikon ditekan.
                        // Memanggil setState untuk membangun ulang widget dengan nilai _obscureText yang baru.
                        setState(() {
                          _obscureText = !_obscureText; // Membalik nilai boolean.
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    if (value.length < 6) {
                      return 'Password minimal 6 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20), // Spasi vertikal.
                // Input field untuk nomor telepon.
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_outlined),
                    border: UnderlineInputBorder(),
                    prefixText:
                        '+62 ', // Teks awalan (kode negara) yang tidak bisa diubah.
                  ),
                  keyboardType: TextInputType
                      .phone, // Menampilkan keyboard tipe nomor telepon.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20), // Spasi vertikal.
                // Padding untuk teks Syarat & Ketentuan.
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  // RichText digunakan untuk menampilkan teks dengan gaya yang berbeda dalam satu widget.
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                          color: Colors.grey, fontSize: 12), // Gaya default.
                      children: [
                        TextSpan(text: 'Dengan mendaftar, Anda menyetujui '),
                        TextSpan(
                          text: 'Syarat & Ketentuan',
                          style: TextStyle(color: Colors.blue),
                          // recognizer bisa ditambahkan untuk membuat teks bisa di-tap.
                        ),
                        TextSpan(text: ' dan '),
                        TextSpan(
                          text: 'Kebijakan Privasi',
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(text: ' Kami'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Spasi vertikal.
                // Tombol untuk mendaftar.
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFB71C1C), // Warna latar tombol.
                    padding: const EdgeInsets.symmetric(
                        vertical: 16), // Padding vertikal.
                    shape: RoundedRectangleBorder(
                      // Bentuk tombol.
                      borderRadius:
                          BorderRadius.circular(8), // Sudut yang membulat.
                    ),
                  ),
                  onPressed: _register, // Memanggil fungsi _register saat ditekan.
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                        fontSize: 18, color: Colors.white), // Gaya teks tombol.
                  ),
                ),
                const SizedBox(height: 20), // Spasi vertikal.
                // Row untuk menata teks dan tombol 'Masuk' secara horizontal.
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Menengahkan anak secara horizontal.
                  children: [
                    const Text("Sudah punya akun?"),
                    // Tombol teks untuk navigasi ke halaman login.
                    TextButton(
                      onPressed: () {
                        // Menggunakan GoRouter untuk kembali ke halaman login.
                        context.go('/login');
                      },
                      child: const Text('Masuk'),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Spasi vertikal.
              ],
            ),
          ),
        ),
      ),
    );
  }
}