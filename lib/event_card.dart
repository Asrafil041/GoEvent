import 'package:flutter/material.dart'; // Mengimpor pustaka material dari Flutter untuk komponen UI.

class EventCard extends StatelessWidget { // Mendefinisikan kelas EventCard sebagai StatelessWidget.
  final String image; // Variabel final untuk path gambar.
  final String title; // Variabel final untuk judul event.
  final String location; // Variabel final untuk lokasi event.
  final String date; // Variabel final untuk tanggal event.
  final String price; // Variabel final untuk harga event.
  final bool isFavorite; // Variabel final untuk status favorit.
  final VoidCallback onFavoritePressed; // Callback saat tombol favorit ditekan.

  const EventCard({ // Konstruktor untuk kelas EventCard.
    super.key, // Kunci untuk widget.
    required this.image, // Parameter wajib untuk gambar.
    required this.title, // Parameter wajib untuk judul.
    required this.location, // Parameter wajib untuk lokasi.
    required this.date, // Parameter wajib untuk tanggal.
    required this.price, // Parameter wajib untuk harga.
    required this.isFavorite, // Parameter wajib untuk status favorit.
    required this.onFavoritePressed, // Parameter wajib untuk callback favorit.
  });

  @override
  Widget build(BuildContext context) { // Fungsi untuk membangun UI widget.
    return Card( // Mengembalikan widget Card.
      child: Column( // Anak-anak widget di dalam Card disusun secara vertikal.
        crossAxisAlignment: CrossAxisAlignment.start, // Ratakan anak-anak widget ke kiri.
        children: [ // Daftar anak-anak widget.
          Stack( // Widget Stack untuk menumpuk widget.
            children: [ // Daftar anak-anak widget di dalam Stack.
              Image.asset( // Menampilkan gambar dari asset.
                image, // Path gambar.
                height: 120, // Tinggi gambar.
                width: double.infinity, // Lebar gambar selebar mungkin.
                fit: BoxFit.cover, // Menyesuaikan gambar agar menutupi kontainer.
              ),
              Positioned( // Memposisikan widget di dalam Stack.
                top: 8, // Jarak 8 dari atas.
                right: 8, // Jarak 8 dari kanan.
                child: IconButton( // Tombol ikon.
                  icon: Icon( // Ikon.
                    isFavorite ? Icons.favorite : Icons.favorite_border, // Ikon berubah berdasarkan status favorit.
                    color: isFavorite ? Colors.red : Colors.white, // Warna ikon berubah berdasarkan status favorit.
                  ),
                  onPressed: onFavoritePressed, // Aksi saat tombol ditekan.
                ),
              ),
            ],
          ),
          Padding( // Padding di sekitar konten teks.
            padding: const EdgeInsets.all(8.0), // Padding 8 di semua sisi.
            child: Column( // Anak-anak widget di dalam Padding disusun secara vertikal.
              crossAxisAlignment: CrossAxisAlignment.start, // Ratakan anak-anak widget ke kiri.
              children: [ // Daftar anak-anak widget.
                Text( // Teks untuk judul.
                  title,
                  style: const TextStyle( // Gaya teks.
                    fontWeight: FontWeight.bold, // Teks tebal.
                  ),
                ),
                const SizedBox(height: 4), // Spasi vertikal.
                Row( // Anak-anak widget disusun secara horizontal.
                  children: [ // Daftar anak-anak widget.
                    const Icon(Icons.location_on, size: 16), // Ikon lokasi.
                    const SizedBox(width: 4), // Spasi horizontal.
                    Text(location), // Teks lokasi.
                  ],
                ),
                const SizedBox(height: 4), // Spasi vertikal.
                Row( // Anak-anak widget disusun secara horizontal.
                  children: [ // Daftar anak-anak widget.
                    const Icon(Icons.calendar_today, size: 16), // Ikon kalender.
                    const SizedBox(width: 4), // Spasi horizontal.
                    Text(date), // Teks tanggal.
                  ],
                ),
                const SizedBox(height: 4), // Spasi vertikal.
                Text( // Teks untuk harga.
                  price,
                  style: const TextStyle( // Gaya teks.
                    fontWeight: FontWeight.bold, // Teks tebal.
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
