import 'dart:io'; // Mengimpor pustaka dart:io untuk fungsionalitas file, seperti File.

import 'package:flutter/material.dart'; // Mengimpor pustaka material dari Flutter untuk komponen UI.
import 'package:image_picker/image_picker.dart'; // Mengimpor pustaka image_picker untuk memilih gambar dari galeri.

class AddEventPage extends StatefulWidget { // Mendefinisikan kelas AddEventPage sebagai StatefulWidget.
  const AddEventPage({super.key}); // Konstruktor untuk kelas AddEventPage.

  @override
  State<AddEventPage> createState() => _AddEventPageState(); // Membuat state untuk AddEventPage.
}

class _AddEventPageState extends State<AddEventPage> { // Mendefinisikan kelas state untuk AddEventPage.
  final _formKey = GlobalKey<FormState>(); // Kunci global untuk form, untuk validasi.
  final _titleController = TextEditingController(); // Controller untuk input judul event.
  final _priceController = TextEditingController(); // Controller untuk input harga pendaftaran.
  final _descriptionController = TextEditingController(); // Controller untuk input deskripsi.
  final _locationController = TextEditingController(); // Controller untuk input lokasi.
  final _dateController = TextEditingController(); // Controller untuk input tanggal pelaksanaan.
  final _registrationLinkController = TextEditingController(); // Controller untuk input link pendaftaran.

  String? _selectedCategory; // Variabel untuk menyimpan kategori yang dipilih.
  final List<String> _categories = ['Lomba', 'Seminar', 'Bazar']; // Daftar kategori yang tersedia.

  File? _image; // Variabel untuk menyimpan file gambar yang dipilih.
  final _picker = ImagePicker(); // Instance dari ImagePicker untuk memilih gambar.

  Future<void> _pickImage() async { // Fungsi asynchronous untuk memilih gambar.
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // Membuka galeri untuk memilih gambar.

    if (pickedFile != null) { // Jika gambar berhasil dipilih.
      setState(() { // Memperbarui state.
        _image = File(pickedFile.path); // Menyimpan gambar yang dipilih sebagai File.
      });
    }
  }

  void _submit() { // Fungsi untuk mensubmit form.
    if (_formKey.currentState!.validate()) { // Jika form valid.
      // Perform submit action // Lakukan aksi submit (belum diimplementasikan).
    }
  }

  @override
  void dispose() { // Fungsi yang dipanggil saat widget di-dispose.
    _titleController.dispose(); // Membersihkan controller judul.
    _priceController.dispose(); // Membersihkan controller harga.
    _descriptionController.dispose(); // Membersihkan controller deskripsi.
    _locationController.dispose(); // Membersihkan controller lokasi.
    _dateController.dispose(); // Membersihkan controller tanggal.
    _registrationLinkController.dispose(); // Membersihkan controller link pendaftaran.
    super.dispose(); // Memanggil dispose dari superclass.
  }

  @override
  Widget build(BuildContext context) { // Fungsi untuk membangun UI widget.
    return Scaffold( // Mengembalikan Scaffold sebagai root widget halaman.
      appBar: AppBar( // AppBar di bagian atas halaman.
        title: const Text('New Post'), // Judul AppBar.
        leading: IconButton( // Tombol di sebelah kiri AppBar.
          icon: const Icon(Icons.arrow_back), // Ikon panah kembali.
          onPressed: () { // Aksi saat tombol ditekan.
            Navigator.of(context).pop(); // Kembali ke halaman sebelumnya.
          },
        ),
        actions: [ // Aksi di sebelah kanan AppBar.
          TextButton( // Tombol teks.
            onPressed: _submit, // Aksi saat tombol ditekan, memanggil fungsi _submit.
            child: const Text( // Teks pada tombol.
              'Post',
              style: TextStyle(color: Colors.blue, fontSize: 18), // Gaya teks.
            ),
          ),
        ],
      ),
      body: SingleChildScrollView( // Body halaman yang bisa di-scroll.
        padding: const EdgeInsets.all(16.0), // Padding di sekitar body.
        child: Form( // Widget form.
          key: _formKey, // Menggunakan kunci form yang telah dibuat.
          child: Column( // Anak-anak widget di dalam form disusun secara vertikal.
            crossAxisAlignment: CrossAxisAlignment.stretch, // Merentangkan anak-anak widget selebar mungkin.
            children: <Widget>[ // Daftar anak-anak widget.
              GestureDetector( // Widget untuk mendeteksi gestur.
                onTap: _pickImage, // Aksi saat di-tap, memanggil fungsi _pickImage.
                child: Container( // Kontainer untuk area pemilihan gambar.
                  height: 200, // Tinggi kontainer.
                  width: double.infinity, // Lebar kontainer selebar mungkin.
                  decoration: BoxDecoration( // Dekorasi kontainer.
                    color: Colors.grey[200], // Warna latar belakang abu-abu.
                    borderRadius: BorderRadius.circular(12), // Sudut yang membulat.
                  ),
                  child: _image == null // Jika tidak ada gambar yang dipilih.
                      ? const Column( // Tampilkan kolom.
                          mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten secara vertikal.
                          children: [ // Anak-anak widget.
                            Icon(Icons.add, size: 50), // Ikon tambah.
                            Text('Add Photos'), // Teks "Add Photos".
                          ],
                        )
                      : ClipRRect( // Jika ada gambar, gunakan ClipRRect untuk membulatkan sudut gambar.
                          borderRadius: BorderRadius.circular(12), // Sudut yang membulat.
                          child: Image.file(_image!, fit: BoxFit.cover), // Tampilkan gambar dari file.
                        ),
                ),
              ),
              const SizedBox(height: 16), // Spasi vertikal.
              TextFormField( // Input field untuk teks.
                controller: _titleController, // Menggunakan controller judul.
                decoration: const InputDecoration( // Dekorasi input field.
                  labelText: 'Judul Event', // Label untuk input field.
                  border: UnderlineInputBorder(), // Garis bawah sebagai border.
                ),
                validator: (value) { // Fungsi validasi.
                  if (value == null || value.isEmpty) { // Jika nilai kosong.
                    return 'Please enter a title'; // Kembalikan pesan error.
                  }
                  return null; // Jika valid, kembalikan null.
                },
              ),
              const SizedBox(height: 16), // Spasi vertikal.
              TextFormField( // Input field untuk teks.
                controller: _priceController, // Menggunakan controller harga.
                decoration: const InputDecoration( // Dekorasi input field.
                  labelText: 'Harga Pendaftaran', // Label untuk input field.
                  border: UnderlineInputBorder(), // Garis bawah sebagai border.
                ),
                keyboardType: TextInputType.number, // Tipe keyboard numerik.
              ),
              const SizedBox(height: 16), // Spasi vertikal.
              DropdownButtonFormField<String>( // Input field dropdown.
                decoration: const InputDecoration( // Dekorasi input field.
                  labelText: 'Kategori', // Label untuk input field.
                  border: UnderlineInputBorder(), // Garis bawah sebagai border.
                ),
                initialValue: _selectedCategory, // Nilai awal dropdown.
                items: _categories.map((String category) { // Item-item dropdown.
                  return DropdownMenuItem<String>( // Setiap item adalah DropdownMenuItem.
                    value: category, // Nilai item.
                    child: Text(category), // Teks yang ditampilkan.
                  );
                }).toList(), // Mengubah hasil map menjadi list.
                onChanged: (newValue) { // Aksi saat nilai berubah.
                  setState(() { // Memperbarui state.
                    _selectedCategory = newValue; // Mengatur kategori yang dipilih.
                  });
                },
                validator: (value) { // Fungsi validasi.
                  if (value == null) { // Jika tidak ada nilai yang dipilih.
                    return 'Please select a category'; // Kembalikan pesan error.
                  }
                  return null; // Jika valid, kembalikan null.
                },
              ),
              const SizedBox(height: 16), // Spasi vertikal.
              TextFormField( // Input field untuk teks.
                controller: _descriptionController, // Menggunakan controller deskripsi.
                decoration: const InputDecoration( // Dekorasi input field.
                  labelText: 'Deskripsi', // Label untuk input field.
                  border: UnderlineInputBorder(), // Garis bawah sebagai border.
                ),
                maxLines: 3, // Jumlah baris maksimal.
              ),
              const SizedBox(height: 16), // Spasi vertikal.
              TextFormField( // Input field untuk teks.
                controller: _locationController, // Menggunakan controller lokasi.
                decoration: const InputDecoration( // Dekorasi input field.
                  labelText: 'Lokasi', // Label untuk input field.
                  border: UnderlineInputBorder(), // Garis bawah sebagai border.
                ),
              ),
              const SizedBox(height: 16), // Spasi vertikal.
              TextFormField( // Input field untuk teks.
                controller: _dateController, // Menggunakan controller tanggal.
                decoration: const InputDecoration( // Dekorasi input field.
                  labelText: 'Tanggal Pelaksanaan', // Label untuk input field.
                  border: UnderlineInputBorder(), // Garis bawah sebagai border.
                  suffixIcon: Icon(Icons.calendar_today), // Ikon kalender di akhir.
                ),
                onTap: () async { // Aksi saat di-tap.
                  DateTime? pickedDate = await showDatePicker( // Menampilkan date picker.
                    context: context, // Konteks build.
                    initialDate: DateTime.now(), // Tanggal awal yang dipilih.
                    firstDate: DateTime(2000), // Tanggal paling awal yang bisa dipilih.
                    lastDate: DateTime(2101), // Tanggal paling akhir yang bisa dipilih.
                  );
                  if (pickedDate != null) { // Jika tanggal berhasil dipilih.
                    _dateController.text = // Mengatur teks pada controller tanggal.
                        pickedDate.toLocal().toString().split(' ')[0]; // Format tanggal menjadi YYYY-MM-DD.
                  }
                },
              ),
              const SizedBox(height: 16), // Spasi vertikal.
              TextFormField( // Input field untuk teks.
                controller: _registrationLinkController, // Menggunakan controller link pendaftaran.
                decoration: const InputDecoration( // Dekorasi input field.
                  labelText: 'Link Pendaftaran', // Label untuk input field.
                  border: UnderlineInputBorder(), // Garis bawah sebagai border.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
