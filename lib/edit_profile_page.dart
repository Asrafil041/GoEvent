import 'package:flutter/material.dart'; // Mengimpor pustaka material dari Flutter untuk komponen UI.
import 'package:go_router/go_router.dart'; // Mengimpor pustaka go_router untuk navigasi.

class EditProfilePage extends StatefulWidget { // Mendefinisikan kelas EditProfilePage sebagai StatefulWidget.
  const EditProfilePage({super.key}); // Konstruktor untuk kelas EditProfilePage.

  @override
  State<EditProfilePage> createState() => _EditProfilePageState(); // Membuat state untuk EditProfilePage.
}

class _EditProfilePageState extends State<EditProfilePage> { // Mendefinisikan kelas state untuk EditProfilePage.
  final _formKey = GlobalKey<FormState>(); // Kunci global untuk form, untuk validasi.
  final _nameController = TextEditingController(text: 'Santi Alya Safitri'); // Controller untuk input nama dengan nilai awal.
  final _bioController = TextEditingController(text: 'Biodata'); // Controller untuk input bio dengan nilai awal.

  @override
  void dispose() { // Fungsi yang dipanggil saat widget di-dispose.
    _nameController.dispose(); // Membersihkan controller nama.
    _bioController.dispose(); // Membersihkan controller bio.
    super.dispose(); // Memanggil dispose dari superclass.
  }

  void _saveProfile() { // Fungsi untuk menyimpan profil.
    if (_formKey.currentState!.validate()) { // Jika form valid.
      // Save profile information // Simpan informasi profil (belum diimplementasikan).
      context.pop(); // Kembali ke halaman sebelumnya.
    }
  }

  @override
  Widget build(BuildContext context) { // Fungsi untuk membangun UI widget.
    return Scaffold( // Mengembalikan Scaffold sebagai root widget halaman.
      appBar: AppBar( // AppBar di bagian atas halaman.
        title: const Text('Edit Profile'), // Judul AppBar.
        leading: IconButton( // Tombol di sebelah kiri AppBar.
          icon: const Icon(Icons.arrow_back), // Ikon panah kembali.
          onPressed: () { // Aksi saat tombol ditekan.
            context.pop(); // Kembali ke halaman sebelumnya menggunakan go_router.
          },
        ),
      ),
      body: Padding( // Padding di sekitar body.
        padding: const EdgeInsets.all(16.0), // Padding 16 di semua sisi.
        child: Form( // Widget form.
          key: _formKey, // Menggunakan kunci form yang telah dibuat.
          child: Column( // Anak-anak widget di dalam form disusun secara vertikal.
            children: [ // Daftar anak-anak widget.
              TextFormField( // Input field untuk teks.
                controller: _nameController, // Menggunakan controller nama.
                decoration: const InputDecoration( // Dekorasi input field.
                  labelText: 'Name', // Label untuk input field.
                ),
                validator: (value) { // Fungsi validasi.
                  if (value == null || value.isEmpty) { // Jika nilai kosong.
                    return 'Please enter your name'; // Kembalikan pesan error.
                  }
                  return null; // Jika valid, kembalikan null.
                },
              ),
              const SizedBox(height: 16), // Spasi vertikal.
              TextFormField( // Input field untuk teks.
                controller: _bioController, // Menggunakan controller bio.
                decoration: const InputDecoration( // Dekorasi input field.
                  labelText: 'Bio', // Label untuk input field.
                ),
                maxLines: 3, // Jumlah baris maksimal.
              ),
              const SizedBox(height: 32), // Spasi vertikal.
              ElevatedButton( // Tombol dengan latar belakang.
                onPressed: _saveProfile, // Aksi saat tombol ditekan, memanggil fungsi _saveProfile.
                child: const Text('Save'), // Teks pada tombol.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
