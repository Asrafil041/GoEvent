// Mengimpor pustaka dasar dari Flutter untuk membangun UI.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Mengimpor widget kartu acara kustom.
import 'package:myapp/event_card.dart';

// ProfilePage adalah StatefulWidget, artinya dapat menyimpan state (keadaan) yang bisa berubah.
class ProfilePage extends StatefulWidget {
  // Konstruktor untuk ProfilePage.
  const ProfilePage({super.key});

  // Membuat dan mengembalikan state (keadaan) untuk widget ini.
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

// _ProfilePageState adalah kelas state untuk ProfilePage, tempat semua logika dan UI berada.
class _ProfilePageState extends State<ProfilePage> {
  // Daftar (list) data dummy untuk postingan acara pengguna.
  final List<Map<String, String>> _posts = [
    {
      'image': 'assets/images/pamflet seminar.jpg', // Path gambar acara
      'title': 'Seminar Digital Marketing', // Judul acara
      'location': 'Palembang', // Lokasi acara
      'date': '25 Mei 2025', // Tanggal acara
      'price': 'Rp 100.000', // Harga tiket
    },
    {
      'image': 'assets/images/LOMBAHSN.png',
      'title': 'Lomba Poster K',
      'location': 'Lampung',
      'date': '1 Agustus 2024',
      'price': 'Free',
    },
    {
      'image': 'assets/images/design pamflet bazar dialog.jpg',
      'title': 'Bazar Dialog',
      'location': 'Online',
      'date': '10 Juli 2024',
      'price': 'Free',
    },
    {
      'image': 'assets/images/kse.png',
      'title': 'KSE Scholarship',
      'location': 'Online',
      'date': '1 Januari 2025',
      'price': 'Free',
    },
  ];

  // Metode 'build' untuk merender UI halaman profil.
  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar halaman (app bar, body, dll).
    return Scaffold(
      // AppBar di bagian atas layar.
      appBar: AppBar(
        title: const Text('Profile'), // Judul AppBar
        leading: IconButton(
          // Tombol di sisi kiri AppBar
          icon: const Icon(Icons.arrow_back), // Ikon panah kembali
          onPressed: () {
            // Aksi saat tombol ditekan
            context.pop(); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      // DefaultTabController mengatur TabBar dan TabBarView.
      body: DefaultTabController(
        length: 1, // Jumlah tab yang akan ditampilkan.
        // NestedScrollView memungkinkan adanya header yang bisa di-scroll bersama dengan konten tab.
        child: NestedScrollView(
          // headerSliverBuilder membangun bagian header yang bisa di-scroll.
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // SliverToBoxAdapter digunakan untuk menempatkan widget biasa (non-sliver) di dalam area sliver.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(
                      16.0), // Padding di sekitar konten profil.
                  child: Column(
                    // Menata widget anak secara vertikal.
                    children: [
                      // Lingkaran untuk menampilkan avatar atau ikon pengguna.
                      const CircleAvatar(
                        radius: 40, // Ukuran radius lingkaran avatar.
                        child: Icon(Icons.person,
                            size: 40), // Ikon pengguna di dalam avatar.
                      ),
                      const SizedBox(height: 16), // Spasi vertikal.
                      // Teks untuk nama pengguna.
                      const Text(
                        'Santi Alya Safitri',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8), // Spasi vertikal.
                      const Text('Biodata'), // Teks biodata singkat.
                      const SizedBox(height: 16), // Spasi vertikal.
                      // Tombol untuk mengedit profil.
                      ElevatedButton(
                        onPressed: () {
                          // Aksi saat tombol ditekan.
                          // Navigasi ke halaman EditProfilePage.
                          context.go('/edit_profile');
                        },
                        child: const Text('Edit Profile'), // Teks pada tombol.
                      ),
                    ],
                  ),
                ),
              ),
              // SliverPersistentHeader membuat header (dalam hal ini, TabBar) tetap terlihat di atas saat di-scroll.
              const SliverPersistentHeader(
                // delegate mengatur bagaimana header ini dibangun dan ukurannya.
                delegate: _SliverAppBarDelegate(
                  // TabBar yang akan ditampilkan sebagai header yang 'menempel'.
                  TabBar(
                    tabs: [
                      Tab(
                          text:
                              'Postingan'), // Satu-satunya tab dengan teks 'Postingan'.
                    ],
                  ),
                ),
                pinned:
                    true, // `true` berarti header akan menempel di atas saat di-scroll.
              ),
            ];
          },
          // body dari NestedScrollView adalah konten dari tab.
          body: TabBarView(
            children: [
              // GridView.builder untuk menampilkan postingan dalam format grid.
              GridView.builder(
                padding: const EdgeInsets.all(8.0), // Padding di sekitar grid.
                // gridDelegate mengatur layout dari grid.
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Menampilkan 2 item per baris.
                  crossAxisSpacing: 8.0, // Spasi horizontal antar item.
                  mainAxisSpacing: 8.0, // Spasi vertikal antar item.
                  childAspectRatio:
                      0.7, // Rasio aspek lebar-tinggi dari setiap item grid.
                ),
                itemCount: _posts.length, // Jumlah total item dalam grid.
                // itemBuilder membangun setiap item grid satu per satu.
                itemBuilder: (context, index) {
                  final post = _posts[
                      index]; // Mendapatkan data postingan untuk indeks saat ini.
                  // Menggunakan widget EventCard kustom untuk menampilkan data postingan.
                  return EventCard(
                    image: post['image']!,
                    title: post['title']!,
                    location: post['location']!,
                    date: post['date']!,
                    price: post['price']!,
                    isFavorite: false, // Status favorit default.
                    onFavoritePressed:
                        () {}, // Fungsi kosong untuk tombol favorit.
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// _SliverAppBarDelegate adalah kelas kustom untuk mengontrol perilaku SliverPersistentHeader.
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  // Konstruktor yang menerima TabBar.
  const _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar; // Widget TabBar yang akan ditampilkan.

  // Tinggi minimum dari header (tinggi TabBar).
  @override
  double get minExtent => _tabBar.preferredSize.height;
  // Tinggi maksimum dari header (sama dengan tinggi minimum karena ukurannya tetap).
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  // Metode untuk membangun widget header.
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Mengembalikan Container yang berisi TabBar, dengan warna latar belakang sesuai tema.
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  // Menentukan apakah header perlu dibangun ulang. `false` untuk optimasi jika kontennya statis.
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
