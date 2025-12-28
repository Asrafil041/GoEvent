import 'package:flutter/material.dart'; // Mengimpor pustaka material dari Flutter untuk komponen UI.

class FavoritesPage extends StatefulWidget { // Mendefinisikan kelas FavoritesPage sebagai StatefulWidget.
  const FavoritesPage({super.key}); // Konstruktor untuk kelas FavoritesPage.

  @override
  State<FavoritesPage> createState() => _FavoritesPageState(); // Membuat state untuk FavoritesPage.
}

class _FavoritesPageState extends State<FavoritesPage> { // Mendefinisikan kelas state untuk FavoritesPage.
  final List<Map<String, String>> favoriteEvents = [ // Daftar event favorit, disimulasikan sebagai data statis.
    {
      "image": "assets/images/LOMBAHSN.png",
      "title": "Badminton Competition",
      "location": "Manado",
      "date": "21 Juli 2025",
      "price": "Rp 1.00.000 /Tim",
    },
    {
      "image": "assets/images/kse.png",
      "title": "Scout Festival",
      "location": "Jawa Timur",
      "date": "16 November 2025",
      "price": "Rp 450.000",
    },
    {
      "image": "assets/images/design pamflet bazar dialog.jpg",
      "title": "Lomba Video Kreatif",
      "location": "Jakabaring, Palembang",
      "date": "18 Januari 2025",
      "price": "Rp 30.000 /Tim",
    },
    {
      "image": "assets/images/pamflet seminar.jpg",
      "title": "Workshop Media Sosial",
      "location": "Uin Gusdur, Jawa Timur",
      "date": "12 Agustus 2024",
      "price": "Rp 15.000",
    },
    {
      "image": "assets/images/logo.png",
      "title": "Creative Work in TV Journa;i...",
      "location": "Aula UMM, Palembang",
      "date": "22 September 2023",
      "price": "Rp 10.000",
    },
  ];

  void _removeFavorite(int index) { // Fungsi untuk menghapus item dari daftar favorit.
    setState(() { // Memperbarui state untuk merebuild UI.
      favoriteEvents.removeAt(index); // Menghapus event pada indeks tertentu.
    });
  }

  @override
  Widget build(BuildContext context) { // Fungsi untuk membangun UI widget.
    return Scaffold( // Mengembalikan Scaffold sebagai root widget halaman.
      appBar: AppBar( // AppBar di bagian atas halaman.
        leading: IconButton( // Tombol di sebelah kiri AppBar.
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Ikon panah kembali berwarna hitam.
          onPressed: () { // Aksi saat tombol ditekan.
            Navigator.pop(context); // Kembali ke halaman sebelumnya.
          },
        ),
        title: const Text('Favorite'), // Judul AppBar.
        centerTitle: true, // Menengahkan judul AppBar.
      ),
      body: ListView.builder( // Body halaman dengan daftar yang bisa di-scroll.
        itemCount: favoriteEvents.length, // Jumlah item dalam daftar.
        itemBuilder: (context, index) { // Fungsi untuk membangun setiap item dalam daftar.
          final event = favoriteEvents[index]; // Mengambil data event pada indeks saat ini.
          return Card( // Mengembalikan widget Card untuk setiap item.
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Margin di sekitar Card.
            shape: RoundedRectangleBorder( // Bentuk Card dengan sudut membulat.
              borderRadius: BorderRadius.circular(12), // Radius sudut 12.
            ),
            child: Padding( // Padding di dalam Card.
              padding: const EdgeInsets.all(12.0), // Padding 12 di semua sisi.
              child: Row( // Anak-anak widget di dalam Padding disusun secara horizontal.
                children: [ // Daftar anak-anak widget.
                  ClipRRect( // Widget untuk membulatkan sudut anak.
                    borderRadius: BorderRadius.circular(8.0), // Radius sudut 8.
                    child: Image.asset( // Menampilkan gambar dari asset.
                      event['image']!, // Path gambar dari data event.
                      width: 100, // Lebar gambar.
                      height: 100, // Tinggi gambar.
                      fit: BoxFit.cover, // Menyesuaikan gambar agar menutupi kontainer.
                    ),
                  ),
                  const SizedBox(width: 16), // Spasi horizontal.
                  Expanded( // Widget yang mengisi sisa ruang yang tersedia.
                    child: Column( // Anak-anak widget di dalam Expanded disusun secara vertikal.
                      crossAxisAlignment: CrossAxisAlignment.start, // Ratakan anak-anak widget ke kiri.
                      children: [ // Daftar anak-anak widget.
                        Text( // Teks untuk judul.
                          event['title']!,
                          style: const TextStyle( // Gaya teks.
                            fontSize: 16, // Ukuran font 16.
                            fontWeight: FontWeight.bold, // Teks tebal.
                          ),
                        ),
                        const SizedBox(height: 8), // Spasi vertikal.
                        Row( // Anak-anak widget disusun secara horizontal.
                          children: [ // Daftar anak-anak widget.
                            const Icon(Icons.location_on, // Ikon lokasi.
                                size: 16, color: Colors.grey), // Ukuran dan warna ikon.
                            const SizedBox(width: 4), // Spasi horizontal.
                            Text(event['location']!), // Teks lokasi dari data event.
                          ],
                        ),
                        const SizedBox(height: 4), // Spasi vertikal.
                        Row( // Anak-anak widget disusun secara horizontal.
                          children: [ // Daftar anak-anak widget.
                            const Icon(Icons.calendar_today, // Ikon kalender.
                                size: 16, color: Colors.grey), // Ukuran dan warna ikon.
                            const SizedBox(width: 4), // Spasi horizontal.
                            Text(event['date']!), // Teks tanggal dari data event.
                          ],
                        ),
                        const SizedBox(height: 8), // Spasi vertikal.
                        Text( // Teks untuk harga.
                          event['price']!,
                          style: const TextStyle( // Gaya teks.
                            fontSize: 16, // Ukuran font 16.
                            fontWeight: FontWeight.bold, // Teks tebal.
                            color: Colors.deepPurple, // Warna deepPurple.
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton( // Tombol ikon.
                    icon: const Icon(Icons.delete, color: Colors.red), // Ikon hapus berwarna merah.
                    onPressed: () => _removeFavorite(index), // Aksi saat tombol ditekan, memanggil fungsi _removeFavorite.
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
