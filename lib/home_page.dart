import 'package:flutter/material.dart'; // Mengimpor pustaka material dari Flutter untuk komponen UI.
import 'package:go_router/go_router.dart'; // Mengimpor pustaka go_router untuk navigasi.
import 'package:myapp/event_card.dart'; // Mengimpor widget EventCard dari file event_card.dart.

//Halaman ini menggunakan StatefulWidget karena ada data yang bisa berubah,
//seperti hasil pencarian dan filter. Kelas utama HomePage menampilkan tampilan utama,
class HomePage extends StatefulWidget {
  // Mendefinisikan kelas HomePage sebagai StatefulWidget.
  const HomePage({super.key}); // Konstruktor untuk kelas HomePage.

  @override
  State<HomePage> createState() =>
      _HomePageState(); // Membuat state untuk HomePage.
}

//“Bagian AppBar menampilkan logo aplikasi dan teks GoEvent.
class _HomePageState extends State<HomePage> {
  // Mendefinisikan kelas state untuk HomePage.
  @override
  Widget build(BuildContext context) {
    // Fungsi untuk membangun UI widget.
    return Scaffold(
      // Mengembalikan Scaffold sebagai root widget halaman.
      appBar: AppBar(
        // AppBar di bagian atas halaman.
        title: Row(
          // Judul AppBar berisi widget Row.
          children: [
            // Daftar anak-anak widget di dalam Row.
            Image.asset(
              // Menampilkan gambar dari asset.
              'assets/images/logo.png', // Path gambar logo.
              height: 40, // Tinggi gambar.
            ),
            const SizedBox(width: 10), // Spasi horizontal.
            GestureDetector(
              // Widget untuk mendeteksi gestur.
              onTap: () {
                // Aksi saat di-tap.
                context.go(
                    '/login'); // Navigasi ke halaman login menggunakan go_router.
              },
              child: const Column(
                // Anak dari GestureDetector adalah Column.
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Ratakan anak-anak widget ke kiri.
                children: [
                  // Daftar anak-anak widget.
                  Text('GoEvent', // Teks "GoEvent".
                      style: TextStyle(
                          fontWeight: FontWeight.bold)), // Gaya teks tebal.
                  Text('Mau Cari Kegiatan?',
                      style: TextStyle(
                          fontSize:
                              12)), // Teks subtitle dengan ukuran font 12.
                ],
              ),
            ),
          ],
        ),
        actions: const [
          // Aksi di sebelah kanan AppBar.
          // IconButton( // Tombol ikon.
          //   onPressed: () {}, // Aksi saat tombol ditekan (kosong).
          // ),
        ],
      ),
      body:
          const HomePageBody(), // Body dari Scaffold adalah widget HomePageBody.
    );
  }
}

class HomePageBody extends StatefulWidget {
  // Mendefinisikan kelas HomePageBody sebagai StatefulWidget.
  const HomePageBody({super.key}); // Konstruktor untuk kelas HomePageBody.

  @override
  State<HomePageBody> createState() =>
      _HomePageBodyState(); // Membuat state untuk HomePageBody.
}

class _HomePageBodyState extends State<HomePageBody> {
  // Mendefinisikan kelas state untuk HomePageBody.
  String _searchQuery = ''; // Variabel untuk menyimpan query pencarian.
  String? _selectedType; // Variabel untuk menyimpan tipe event yang dipilih.
  String? _selectedLocation; // Variabel untuk menyimpan lokasi yang dipilih.
  bool _showFilters =
      false; // Variabel boolean untuk menampilkan atau menyembunyikan filter.
  final FocusNode _searchFocusNode =
      FocusNode(); // FocusNode untuk field pencarian.

//Bagian ini adalah data dummy atau simulasi daftar event yang akan ditampilkan di beranda.
//Setiap event punya atribut seperti gambar, judul, lokasi, tanggal, harga, tipe, dan deskripsi.”
  final List<Map<String, dynamic>> _allEvents = [
    // Daftar semua event, disimulasikan sebagai data statis.
    {
      "image": "assets/images/pamflet seminar.jpg",
      "title": "Workshop Literasi Digital",
      "location": "Palembang",
      "date": "25 Mei 2025",
      "price": "Rp 100.000",
      "type": "Seminar",
      "quota": "50 Tersedia",
      "registration_link": "https://example.com/daftar",
      "description":
          "Tingkatkan pemahaman Anda tentang dunia digital melalui workshop interaktif ini.",
      "isFavorite": false,
    },
    {
      "image": "assets/images/LOMBAHSN.png",
      "title": "Lomba Poster K",
      "location": "Lampung",
      "date": "1 Agustus 2024",
      "price": "Free",
      "type": "Lomba",
      "quota": "100 Tersedia",
      "registration_link": "https://example.com/daftar-poster",
      "description":
          "Asah kreativitasmu dalam lomba desain poster dengan tema kepahlawanan.",
      "isFavorite": false,
    },
    {
      "image": "assets/images/PAMFLETSERING.jpeg",
      "title": "Sharing Session",
      "location": "Jawa Tengah",
      "date": "15 Juni 2025",
      "price": "Free",
      "type": "Bazar",
      "quota": "200 Tersedia",
      "registration_link": "https://example.com/daftar-bazar",
      "description":
          "Temukan produk-produk unik dan kreatif dari UMKM lokal di Jawa Tengah.",
      "isFavorite": false,
    },
    {
      "image": "assets/images/OPENTENANT.jpeg",
      "title": "OPEN TENANT",
      "location": "Online",
      "date": "20 Juli 2025",
      "price": "Rp 50.000",
      "type": "Webinar",
      "quota": "300 Tersedia",
      "registration_link": "https://example.com/daftar-webinar",
      "description":
          "Belajar strategi membangun bisnis dari nol bersama para ahli.",
      "isFavorite": false,
    },
    {
      "image": "assets/images/KELASBISNIS.jpeg",
      "title": "Kelas Bisnis",
      "location": "Manado",
      "date": "10 Agustus 2025",
      "price": "Rp 75.000",
      "type": "Seminar",
      "quota": "100 Tersedia",
      "registration_link": "https://example.com/daftar-seminar-karir",
      "description":
          "Dapatkan tips dan trik untuk mempersiapkan karir impianmu.",
      "isFavorite": false,
    },
    {
      "image": "assets/images/LOMBAHSN.png",
      "title": "Lomba Esai Nasional",
      "location": "Online",
      "date": "1 September 2025",
      "price": "Rp 25.000",
      "type": "Lomba",
      "quota": "150 Tersedia",
      "registration_link": "https://example.com/daftar-esai",
      "description":
          "Tuangkan gagasanmu tentang isu-isu terkini dalam Lomba Esai Nasional.",
      "isFavorite": false,
    },
    {
      "image": "assets/images/design pamflet bazar dialog.jpg",
      "title": "Bazar Makanan Nusantara",
      "location": "Palembang",
      "date": "5 Oktober 2025",
      "price": "Free",
      "type": "Bazar",
      "quota": "500 Tersedia",
      "registration_link": "https://example.com/daftar-bazar-makanan",
      "description":
          "Cicipi aneka kuliner lezat dari seluruh penjuru Indonesia.",
      "isFavorite": false,
    },
    {
      "image": "assets/images/kse.png",
      "title": "Webinar Investasi Saham",
      "location": "Online",
      "date": "12 November 2025",
      "price": "Rp 100.000",
      "type": "Webinar",
      "quota": "200 Tersedia",
      "registration_link": "https://example.com/daftar-webinar-saham",
      "description":
          "Pahami dasar-dasar investasi saham untuk masa depan finansial yang lebih baik.",
      "isFavorite": false,
    },
  ];

  late List<Map<String, dynamic>>
      _filteredEvents; // Daftar event yang sudah difilter, diinisialisasi nanti.
  final List<Map<String, dynamic>> _favoriteEvents =
      []; // Daftar event favorit.

  final List<String> _eventTypes = [
    // Daftar tipe event yang tersedia untuk filter.
    'All',
    'Lomba',
    'Seminar',
    'Webinar',
    'Bazar'
  ];
  final List<String> _locations = [
    // Daftar lokasi yang tersedia untuk filter.
    'All',
    'Palembang',
    'Lampung',
    'Jawa Tengah',
    'Manado',
    'Online'
  ];

  @override
  void initState() {
    // Fungsi yang dipanggil saat state diinisialisasi.
    super.initState();
    _filteredEvents =
        _allEvents; // Mengisi daftar event terfilter dengan semua event pada awalnya.
    _selectedType = 'All'; // Mengatur filter tipe default ke 'All'.
    _selectedLocation = 'All'; // Mengatur filter lokasi default ke 'All'.
    _searchFocusNode
        .addListener(_onFocusChange); // Menambahkan listener ke FocusNode.
  }

  @override
  void dispose() {
    // Fungsi yang dipanggil saat widget di-dispose.
    _searchFocusNode
        .removeListener(_onFocusChange); // Menghapus listener dari FocusNode.
    _searchFocusNode.dispose(); // Membersihkan FocusNode.
    super.dispose();
  }

  void _onFocusChange() {
    // Fungsi yang dipanggil saat fokus pada field pencarian berubah.
    setState(() {
      // Memperbarui state.
      _showFilters = _searchFocusNode
          .hasFocus; // Menampilkan filter jika field pencarian memiliki fokus.
    });
  }

  void _filterEvents() {
    // Fungsi untuk memfilter event.
    List<Map<String, dynamic>> results =
        _allEvents; // Mulai dengan semua event.

    if (_searchQuery.isNotEmpty) {
      // Jika query pencarian tidak kosong.
      results = results
          .where((event) => event['title']!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList(); // Filter berdasarkan judul event.
    }

    if (_selectedType != null && _selectedType != 'All') {
      // Jika tipe event dipilih dan bukan 'All'.
      results = results
          .where((event) => event['type'] == _selectedType)
          .toList(); // Filter berdasarkan tipe event.
    }

    if (_selectedLocation != null && _selectedLocation != 'All') {
      // Jika lokasi dipilih dan bukan 'All'.
      results = results
          .where((event) => event['location'] == _selectedLocation)
          .toList(); // Filter berdasarkan lokasi.
    }

    setState(() {
      // Memperbarui state.
      _filteredEvents = results; // Memperbarui daftar event yang terfilter.
    });
  }

  void _toggleFavorite(Map<String, dynamic> event) {
    // Fungsi untuk mengubah status favorit.
    setState(() {
      // Memperbarui state.
      event['isFavorite'] = !event['isFavorite']; // Mengubah status favorit.
      if (event['isFavorite']) {
        // Jika menjadi favorit.
        _favoriteEvents.add(event); // Tambahkan ke daftar favorit.
      } else {
        // Jika tidak lagi favorit.
        _favoriteEvents.remove(event); // Hapus dari daftar favorit.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fungsi untuk membangun UI widget.
    return Padding(
      // Padding di sekitar body.
      padding: const EdgeInsets.all(16.0), // Padding 16 di semua sisi.
      child: Column(
        // Anak-anak widget di dalam Padding disusun secara vertikal.
        crossAxisAlignment:
            CrossAxisAlignment.start, // Ratakan anak-anak widget ke kiri.
        children: [
          // Daftar anak-anak widget.

          //“Kolom ini digunakan untuk mencari event berdasarkan judul.
//Setiap kali pengguna mengetik sesuatu, fungsi _filterEvents() dijalankan untuk memperbarui daftar hasil pencarian.”
          TextField(
            // Input field untuk pencarian.
            focusNode:
                _searchFocusNode, // Menggunakan FocusNode yang telah dibuat.
            onChanged: (value) {
              // Aksi saat nilai berubah.
              _searchQuery = value; // Memperbarui query pencarian.
              _filterEvents(); // Memanggil fungsi filter.
            },
            decoration: const InputDecoration(
              // Dekorasi input field.
              hintText: 'Cari Event Apa?', // Teks hint.
              prefixIcon: Icon(Icons.search), // Ikon di awal.
              border: OutlineInputBorder(
                // Border dengan sudut membulat.
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
          if (_showFilters) // Jika _showFilters true.
            Padding(
              // Tampilkan filter.
              padding: const EdgeInsets.only(top: 10.0), // Padding di atas.
              child: Row(
                // Anak-anak widget disusun secara horizontal.
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Beri jarak antar anak.
                children: [
                  // Daftar anak-anak widget.
                  Expanded(
                    // Widget yang mengisi sisa ruang.
                    child: DropdownButton<String>(
                      // Dropdown untuk tipe event.
                      value: _selectedType, // Nilai yang dipilih.
                      isExpanded: true, // Memperluas dropdown.
                      hint: const Text("Jenis Kegiatan"), // Teks hint.
                      onChanged: (String? newValue) {
                        // Aksi saat nilai berubah.
                        setState(() {
                          // Memperbarui state.
                          _selectedType =
                              newValue; // Memperbarui tipe yang dipilih.
                          _filterEvents(); // Memanggil fungsi filter.
                        });
                      },
                      items: _eventTypes // Item-item dropdown.
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value, // Nilai item.
                          child: Text(value), // Teks yang ditampilkan.
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 20), // Spasi horizontal.
                  Expanded(
                    // Widget yang mengisi sisa ruang.
                    child: DropdownButton<String>(
                      // Dropdown untuk lokasi.
                      value: _selectedLocation, // Nilai yang dipilih.
                      isExpanded: true, // Memperluas dropdown.
                      hint: const Text("Lokasi"), // Teks hint.
                      onChanged: (String? newValue) {
                        // Aksi saat nilai berubah.
                        setState(() {
                          // Memperbarui state.
                          _selectedLocation =
                              newValue; // Memperbarui lokasi yang dipilih.
                          _filterEvents(); // Memanggil fungsi filter.
                        });
                      },
                      items: _locations // Item-item dropdown.
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value, // Nilai item.
                          child: Text(value), // Teks yang ditampilkan.
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20), // Spasi vertikal.
          const Text('Daftar Event', // Teks statis "Daftar Event".
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)), // Gaya teks.
          const SizedBox(height: 10), // Spasi vertikal.
          Expanded(
            // Widget yang mengisi sisa ruang.
            child: _filteredEvents
                    .isEmpty // Jika tidak ada event yang terfilter.
                ? const Center(
                    child: Text(
                        "Tidak ada event yang ditemukan.")) // Tampilkan pesan.
                : GridView.builder(
                    // Jika ada, tampilkan GridView.
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      // Delegate untuk GridView.
                      crossAxisCount: 2, // 2 item per baris.
                      crossAxisSpacing: 10, // Spasi horizontal antar item.
                      mainAxisSpacing: 10, // Spasi vertikal antar item.
                      childAspectRatio: 0.7, // Rasio aspek anak.
                    ),
                    itemCount:
                        _filteredEvents.length, // Jumlah item dalam grid.
                    itemBuilder: (context, index) {
                      // Fungsi untuk membangun setiap item.
                      final event = _filteredEvents[index]; // Ambil data event.
                      return GestureDetector(
                        // Widget untuk mendeteksi gestur.
                        onTap: () {
                          // Aksi saat di-tap.
                          context.go('/event_detail',
                              extra:
                                  event); // Navigasi ke detail event dengan data event.
                        },
                        child: EventCard(
                          // Tampilkan widget EventCard.
                          image: event['image']!,
                          title: event['title']!,
                          location: event['location']!,
                          date: event['date']!,
                          price: event['price']!,
                          isFavorite: event['isFavorite']!,
                          onFavoritePressed: () => _toggleFavorite(
                              event), // Callback untuk tombol favorit.
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
