import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; // Mengimpor pustaka material dari Flutter untuk komponen UI.
import 'package:go_router/go_router.dart'; // Mengimpor pustaka go_router untuk manajemen navigasi.
import 'package:google_fonts/google_fonts.dart'; // Mengimpor pustaka google_fonts untuk menggunakan font kustom.
import 'package:provider/provider.dart'; // Mengimpor pustaka provider untuk manajemen state.
import 'package:myapp/add_event_page.dart'; // Mengimpor halaman tambah event.
import 'package:myapp/home_page.dart'; // Mengimpor halaman utama.
import 'package:myapp/login_page.dart'; // Mengimpor halaman login.
import 'package:myapp/register_page.dart'; // Mengimpor halaman registrasi.
import 'package:myapp/favorites_page.dart'; // Mengimpor halaman favorit.
import 'package:myapp/profile_page.dart'; // Mengimpor halaman profil.
import 'package:myapp/edit_profile_page.dart'; // Mengimpor halaman edit profil.
import 'package:myapp/event_detail_page.dart'; // Mengimpor halaman detail event.

// import 'firebase_options.dart';

Future<void> main() async { // Fungsi utama yang dieksekusi saat aplikasi dimulai.
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp( // Menjalankan aplikasi.
    ChangeNotifierProvider( // Menyediakan instance ThemeProvider ke widget di bawahnya.
      create: (context) => ThemeProvider(), // Membuat instance dari ThemeProvider.
      child: const MyApp(), // Anak widget yang akan memiliki akses ke ThemeProvider.
    ),
  );
}

class ThemeProvider with ChangeNotifier { // Kelas untuk mengelola state tema aplikasi.
  ThemeMode _themeMode = ThemeMode.system; // Mode tema awal, mengikuti sistem.

  ThemeMode get themeMode => _themeMode; // Getter untuk mendapatkan mode tema saat ini.

  void toggleTheme() { // Fungsi untuk mengganti antara tema terang dan gelap.
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light; // Logika toggle.
    notifyListeners(); // Memberi tahu listener (widget) bahwa ada perubahan state.
  }

  void setSystemTheme() { // Fungsi untuk mengatur tema kembali mengikuti sistem.
    _themeMode = ThemeMode.system; // Mengatur mode tema ke sistem.
    notifyListeners(); // Memberi tahu listener tentang perubahan.
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>(); // Kunci global untuk navigator utama (root).
final _shellNavigatorKey = GlobalKey<NavigatorState>(); // Kunci global untuk navigator di dalam shell route.

final GoRouter _router = GoRouter( // Konfigurasi router aplikasi menggunakan go_router.
  initialLocation: '/login', // Rute awal saat aplikasi dibuka.
  navigatorKey: _rootNavigatorKey, // Menggunakan kunci navigator root.
  routes: [ // Daftar rute aplikasi.
    GoRoute( // Rute untuk halaman login.
      path: '/login',
      builder: (context, state) => const LoginPage(), // Widget yang akan dibangun untuk rute ini.
    ),
    GoRoute( // Rute untuk halaman registrasi.
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    ShellRoute( // Rute shell yang memiliki UI bersama (seperti BottomNavigationBar).
      navigatorKey: _shellNavigatorKey, // Menggunakan kunci navigator shell.
      builder: (context, state, child) { // Membangun UI shell.
        return MainPage(child: child); // MainPage adalah shell, child adalah halaman aktif saat ini.
      },
      routes: [ // Rute-rute yang berada di dalam shell.
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesPage(),
        ),
        GoRoute(
          path: '/add_event',
          builder: (context, state) => const AddEventPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
    GoRoute( // Rute untuk halaman edit profil (di luar shell).
      path: '/edit_profile',
      parentNavigatorKey: _rootNavigatorKey, // Menggunakan navigator root agar halaman ini menutupi shell.
      builder: (context, state) => const EditProfilePage(),
    ),
    GoRoute( // Rute untuk halaman detail event (di luar shell).
      path: '/event_detail',
      parentNavigatorKey: _rootNavigatorKey, // Menggunakan navigator root.
      builder: (context, state) {
        if (state.extra is Map<String, dynamic>) {
          final event = state.extra as Map<String, dynamic>;
          return EventDetailPage(event: event);
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Event data is missing or invalid.'),
            ),
          );
        }
      },
    ),
  ],
);

class MyApp extends StatelessWidget { // Kelas utama aplikasi, merupakan StatelessWidget.
  const MyApp({super.key}); // Konstruktor.

  @override
  Widget build(BuildContext context) { // Fungsi untuk membangun UI aplikasi.
    const MaterialColor primarySeedColor = Colors.red; // Warna dasar untuk tema.

    final TextTheme appTextTheme = TextTheme( // Mendefinisikan tema teks kustom.
      displayLarge:
          GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.openSans(fontSize: 14),
    );

    final ThemeData lightTheme = ThemeData( // Mendefinisikan tema terang.
      useMaterial3: true, // Menggunakan Material 3.
      colorScheme: ColorScheme.fromSeed( // Skema warna dibuat dari warna dasar.
        seedColor: primarySeedColor,
        brightness: Brightness.light, // Mode terang.
      ),
      textTheme: appTextTheme, // Menggunakan tema teks yang telah didefinisikan.
      appBarTheme: AppBarTheme( // Tema untuk AppBar.
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        titleTextStyle:
            GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData( // Tema untuk ElevatedButton.
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primarySeedColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle:
              GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );

    final ThemeData darkTheme = ThemeData( // Mendefinisikan tema gelap.
      useMaterial3: true, // Menggunakan Material 3.
      colorScheme: ColorScheme.fromSeed( // Skema warna dibuat dari warna dasar.
        seedColor: primarySeedColor,
        brightness: Brightness.dark, // Mode gelap.
      ),
      textTheme: appTextTheme, // Menggunakan tema teks yang sama.
      appBarTheme: AppBarTheme( // Tema AppBar untuk mode gelap.
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        titleTextStyle:
            GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData( // Tema ElevatedButton untuk mode gelap.
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: primarySeedColor.shade200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle:
              GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );

    return Consumer<ThemeProvider>( // Menggunakan Consumer untuk mendapatkan instance ThemeProvider.
      builder: (context, themeProvider, child) { // Builder yang akan membangun ulang saat ThemeProvider berubah.
        return MaterialApp.router( // Menggunakan MaterialApp yang terintegrasi dengan router.
          routerConfig: _router, // Menggunakan konfigurasi router yang telah dibuat.
          title: 'GoEvent', // Judul aplikasi.
          theme: lightTheme, // Mengatur tema terang.
          darkTheme: darkTheme, // Mengatur tema gelap.
          themeMode: themeProvider.themeMode, // Mode tema dikontrol oleh ThemeProvider.
          debugShowCheckedModeBanner: false, // Menyembunyikan banner debug.
        );
      },
    );
  }
}

class MainPage extends StatelessWidget { // Widget untuk UI shell utama dengan BottomNavigationBar.
  final Widget child; // Widget anak yang akan ditampilkan di body (halaman aktif).

  const MainPage({super.key, required this.child}); // Konstruktor.

  @override
  Widget build(BuildContext context) { // Fungsi untuk membangun UI.
    return Scaffold( // Mengembalikan Scaffold.
      body: child, // Menampilkan halaman aktif di body.
      bottomNavigationBar: BottomNavigationBar( // Bar navigasi di bagian bawah.
        items: const <BottomNavigationBarItem>[ // Daftar item navigasi.
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Add Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context), // Item yang aktif saat ini.
        selectedItemColor: Colors.red, // Warna item yang dipilih.
        unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih.
        onTap: (int idx) => _onItemTapped(idx, context), // Aksi saat item di-tap.
        type: BottomNavigationBarType.fixed, // Jenis bar navigasi, agar semua label terlihat.
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) { // Fungsi untuk menentukan indeks item yang aktif berdasarkan rute saat ini.
    final String location = GoRouterState.of(context).uri.toString(); // Mendapatkan path URI saat ini.
    if (location.startsWith('/home')) { // Jika path dimulai dengan /home.
      return 0; // Indeks 0 (Home).
    } else if (location.startsWith('/favorites')) { // Jika path dimulai dengan /favorites.
      return 1; // Indeks 1 (Favorites).
    } else if (location.startsWith('/add_event')) { // Jika path dimulai dengan /add_event.
      return 2; // Indeks 2 (Add Event).
    } else if (location.startsWith('/profile')) { // Jika path dimulai dengan /profile.
      return 3; // Indeks 3 (Profile).
    }
    return 0; // Default ke indeks 0.
  }

  void _onItemTapped(int index, BuildContext context) { // Fungsi yang dipanggil saat item navigasi di-tap.
    switch (index) { // Switch berdasarkan indeks yang di-tap.
      case 0:
        context.go('/home'); // Navigasi ke /home.
        break;
      case 1:
        context.go('/favorites'); // Navigasi ke /favorites.
        break;
      case 2:
        context.go('/add_event'); // Navigasi ke /add_event.
        break;
      case 3:
        context.go('/profile'); // Navigasi ke /profile.
        break;
    }
  }
}
