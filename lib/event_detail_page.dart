import 'package:flutter/material.dart'; // Mengimpor pustaka material dari Flutter untuk komponen UI.

class EventDetailPage extends StatelessWidget { // Mendefinisikan kelas EventDetailPage sebagai StatelessWidget.
  final Map<String, dynamic> event; // Variabel final untuk menyimpan data event dalam bentuk Map.

  const EventDetailPage({super.key, required this.event}); // Konstruktor untuk kelas EventDetailPage, memerlukan parameter event.

  @override
  Widget build(BuildContext context) { // Fungsi untuk membangun UI widget.
    return Scaffold( // Mengembalikan Scaffold sebagai root widget halaman.
      body: SingleChildScrollView( // Body halaman yang bisa di-scroll.
        child: Column( // Anak-anak widget di dalam body disusun secara vertikal.
          crossAxisAlignment: CrossAxisAlignment.start, // Ratakan anak-anak widget ke kiri.
          children: [ // Daftar anak-anak widget.
            Stack( // Widget Stack untuk menumpuk widget.
              children: [ // Daftar anak-anak widget di dalam Stack.
                Image.asset( // Menampilkan gambar dari asset.
                  event['image']!, // Path gambar dari data event.
                  width: double.infinity, // Lebar gambar selebar mungkin.
                  height: 300, // Tinggi gambar.
                  fit: BoxFit.cover, // Menyesuaikan gambar agar menutupi kontainer.
                ),
                Positioned( // Memposisikan widget di dalam Stack.
                  top: 40, // Jarak 40 dari atas.
                  left: 16, // Jarak 16 dari kiri.
                  child: CircleAvatar( // Widget avatar lingkaran.
                    backgroundColor: Colors.white, // Warna latar belakang putih.
                    child: IconButton( // Tombol ikon di dalam avatar.
                      icon: const Icon(Icons.arrow_back, color: Colors.black), // Ikon panah kembali berwarna hitam.
                      onPressed: () => Navigator.pop(context), // Aksi saat tombol ditekan, kembali ke halaman sebelumnya.
                    ),
                  ),
                ),
              ],
            ),
            Padding( // Padding di sekitar konten teks.
              padding: const EdgeInsets.all(16.0), // Padding 16 di semua sisi.
              child: Column( // Anak-anak widget di dalam Padding disusun secara vertikal.
                crossAxisAlignment: CrossAxisAlignment.start, // Ratakan anak-anak widget ke kiri.
                children: [ // Daftar anak-anak widget.
                  Text( // Teks untuk judul event.
                    event['title']!,
                    style: const TextStyle( // Gaya teks.
                      fontSize: 24, // Ukuran font 24.
                      fontWeight: FontWeight.bold, // Teks tebal.
                    ),
                  ),
                  const SizedBox(height: 16), // Spasi vertikal.
                  Row( // Anak-anak widget disusun secara horizontal.
                    children: [ // Daftar anak-anak widget.
                      const Icon(Icons.location_on, color: Colors.grey), // Ikon lokasi berwarna abu-abu.
                      const SizedBox(width: 8), // Spasi horizontal.
                      Text(event['location']!), // Teks lokasi dari data event.
                      const Spacer(), // Spacer untuk mendorong widget berikutnya ke kanan.
                      Text( // Teks untuk harga.
                        event['price']!,
                        style: const TextStyle( // Gaya teks.
                          fontSize: 18, // Ukuran font 18.
                          fontWeight: FontWeight.bold, // Teks tebal.
                          color: Colors.deepPurple, // Warna deepPurple.
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), // Spasi vertikal.
                  Row( // Anak-anak widget disusun secara horizontal.
                    children: [ // Daftar anak-anak widget.
                      const Icon(Icons.calendar_today, color: Colors.grey), // Ikon kalender berwarna abu-abu.
                      const SizedBox(width: 8), // Spasi horizontal.
                      Text(event['date']!), // Teks tanggal dari data event.
                    ],
                  ),
                  const SizedBox(height: 8), // Spasi vertikal.
                  Row( // Anak-anak widget disusun secara horizontal.
                    children: [ // Daftar anak-anak widget.
                      const Icon(Icons.people, color: Colors.grey), // Ikon orang berwarna abu-abu.
                      const SizedBox(width: 8), // Spasi horizontal.
                      Text(event['quota'] ?? '100 Tersedia'), // Teks kuota dari data event, atau default '100 Tersedia'.
                    ],
                  ),
                  const SizedBox(height: 24), // Spasi vertikal.
                  const Text( // Teks statis "Link Pendaftaran".
                    'Link Pendaftaran',
                    style: TextStyle( // Gaya teks.
                      fontSize: 16, // Ukuran font 16.
                      fontWeight: FontWeight.bold, // Teks tebal.
                    ),
                  ),
                  const SizedBox(height: 8), // Spasi vertikal.
                  Text( // Teks untuk link pendaftaran.
                    event['registration_link'] ?? 'www.pendaftaran.com', // Link pendaftaran dari data event, atau default.
                    style: const TextStyle(color: Colors.blue), // Warna teks biru.
                  ),
                  const SizedBox(height: 24), // Spasi vertikal.
                  const Text( // Teks statis "Deskripsi".
                    'Deskripsi',
                    style: TextStyle( // Gaya teks.
                      fontSize: 16, // Ukuran font 16.
                      fontWeight: FontWeight.bold, // Teks tebal.
                    ),
                  ),
                  const SizedBox(height: 8), // Spasi vertikal.
                  Text( // Teks untuk deskripsi.
                    event['description'] ?? // Deskripsi dari data event, atau default.
                        'Workshop Media Sosial merupakan...',
                  ),
                  const SizedBox(height: 16), // Spasi vertikal.
                  Align( // Widget untuk menyelaraskan anak.
                    alignment: Alignment.centerRight, // Selaraskan ke kanan tengah.
                    child: TextButton( // Tombol teks.
                      onPressed: () {}, // Aksi saat tombol ditekan (kosong).
                      child: const Text('Lihat semua'), // Teks pada tombol.
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
