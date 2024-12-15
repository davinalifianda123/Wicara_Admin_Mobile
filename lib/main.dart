import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// variabel api url
const String baseUrl = 'https://17cc-182-253-109-204.ngrok-free.app/Wicara_Admin_Web';
final loginUrl = Uri.parse('$baseUrl/api/api_login.php');
final berandaUrl = Uri.parse('$baseUrl/api/api_beranda.php');
final dosenUrl = Uri.parse('$baseUrl/api/api_dosen.php');
final mahasiswaUrl = Uri.parse('$baseUrl/api/api_mahasiswa.php');
final unitLayananUrl = Uri.parse('$baseUrl/api/api_unitLayanan.php');
final jenisPengaduanUrl = Uri.parse('$baseUrl/api/api_jenisPengaduan.php');
final pengaduanUrl = Uri.parse('$baseUrl/api/api_pengaduan.php');
final kehilanganUrl = Uri.parse('$baseUrl/api/api_kehilangan.php');
final ratingUrl = Uri.parse('$baseUrl/api/api_rating.php');
final profileUrl = Uri.parse('$baseUrl/api/api_profile.php');
final notifUrl = Uri.parse('$baseUrl/api/api_notification.php');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo Bottom Navigation Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password tidak boleh kosong')),
      );
      return;
    }

    final response = await http.post(
      loginUrl,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id_user', data['id_user'].toString());
        await prefs.setString('email', data['email']);
        await prefs.setString('nama', data['nama']);
        await prefs.setString('password', data['password']);
        await prefs.setString('profile', data['profile']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan, coba lagi nanti')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 285,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  image: AssetImage('images/Login_Image.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 36,
                      width: 120,
                      margin: const EdgeInsets.only(top: 16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset("images/Polines.png"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: Text(
                        'WICARA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          'Wadah Informasi Catatan Aspirasi & Rating Akademik',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 50.0, horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Selamat Datang Di Platform Aspirasi Dan Rating Akademik',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 15),
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Center(
                    child: SizedBox(
                      width: 110,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: Colors.amber[600],
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            'Lupa Password?',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            'Klik Disini',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.indigo,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // Default tampilan awal di Beranda

  final List<Widget> _screens = [
    const BerandaScreen(),
    const PengaduanScreen(),
    const KehilanganScreen(),
    const RatingScreen(),
    const ProfileScreen(),
  ];

  void _navigateToScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _navigateToScreen,
        selectedItemColor: const Color(0xFF060A47), // Warna saat dipilih
        unselectedItemColor: Colors.grey, // Warna saat tidak dipilih
        iconSize: 24, // Ukuran icon
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("images/Beranda.png"),
              color: _currentIndex == 0 ? const Color(0xFF060A47) : Colors.grey,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("images/pengaduan.png"),
              color: _currentIndex == 1 ? const Color(0xFF060A47) : Colors.grey,
            ),
            label: 'Pengaduan',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("images/Kehilangan.png"),
              color: _currentIndex == 2 ? const Color(0xFF060A47) : Colors.grey,
            ),
            label: 'Kehilangan',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("images/Rating.png"),
              color: _currentIndex == 3 ? const Color(0xFF060A47) : Colors.grey,
            ),
            label: 'Rating',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("images/Profile.png"),
              color: _currentIndex == 4 ? const Color(0xFF060A47) : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }
}

class LastUpdateRow extends StatelessWidget {
  final String lastUpdateDate;

  const LastUpdateRow({
    super.key,
    required this.lastUpdateDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.access_time, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          'Terakhir Diperbarui: $lastUpdateDate',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}


// ----------------------------PENGADUAN--------------------------------
class PengaduanScreen extends StatefulWidget {
  const PengaduanScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PengaduanScreenState createState() => _PengaduanScreenState();
}

class _PengaduanScreenState extends State<PengaduanScreen> {
  List<Map<String, String>> _pengaduanList = [];
  List<Map<String, String>> _filteredPengaduanList = [];
  bool _isSearching = false;
  String _searchQuery = '';
  int _unreadCount = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPengaduanData();
    _fetchUnreadCount();
  }

  Future<void> _fetchPengaduanData() async {
    setState(() {
      _isLoading = true; // Set loading state to true before fetching data
    });

    try {
      final response = await http.get(pengaduanUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          // Convert each value to a String or a default message
          _pengaduanList = List<Map<String, String>>.from(data.map((item) => {
            'id_kejadian': (item['id_kejadian'] ?? '').toString(),
            'judul': (item['judul'] ?? 'Judul tidak tersedia').toString(),
            'nama' : (item['nama'] ?? 'nama tidak tersedia').toString(),
            'tanggal': (item['tanggal'] ?? 'Tanggal tidak tersedia').toString(),
            'nama_jenis_pengaduan': (item['nama_jenis_pengaduan'] ?? 'Jenis tidak tersedia').toString(),
            'nama_status_pengaduan': (item['nama_status_pengaduan'] ?? 'Status tidak tersedia').toString(),
            'lokasi': (item['lokasi'] ?? 'lokasi tidak tersedia').toString(),
            'nama_instansi': (item['nama_instansi'] ?? 'instansi tidak tersedia').toString(),
            'deskripsi': (item['deskripsi'] ?? 'Deskripsi tidak tersedia').toString(),
            'lampiran': (item['lampiran'] ?? 'lampiran tidak tersedia').toString(),
          }));

          _filteredPengaduanList = _pengaduanList;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        _isLoading = false; // Set loading state to false even on error
      });
    }
  }

  Future<void> _fetchUnreadCount() async {
    try {
      final response = await http.get(notifUrl); // Gunakan URL notifikasi

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            _unreadCount = List<Map<String, dynamic>>.from(data['data'])
                .where((notif) => notif['status_notif'] == 0)
                .length;
          });
        }
      }
    } catch (e) {
      print("Error fetching unread notifications: $e");
    }
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = '';
      _filteredPengaduanList = _pengaduanList;
    });
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
      _filteredPengaduanList = _pengaduanList
          .where((item) => item['judul']!.toLowerCase().contains(newQuery.toLowerCase()))
          .toList();
    });
  }

  void _filterByStatus(String status) {
    setState(() {
      if (status == 'Semua') {
        _filteredPengaduanList = _pengaduanList;
      } else {
        _filteredPengaduanList = _pengaduanList
            .where((item) => item['nama_status_pengaduan'] == status)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PengaduanAppBar(
            isSearching: _isSearching,
            searchQuery: _searchQuery,
            onSearchStart: _startSearch,
            onSearchStop: _stopSearch,
            onSearchQueryChanged: _updateSearchQuery,
            unreadCount: _unreadCount,
            onUnreadCountChanged: (count) {
              setState(() {
                _unreadCount = count; // Update jumlah badge
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LastUpdateRow(
                    lastUpdateDate: _filteredPengaduanList.isNotEmpty
                        ? _filteredPengaduanList.first['tanggal'] ?? 'Tanggal tidak tersedia'
                        : 'Tanggal tidak tersedia',
                  ),
                  const SizedBox(height: 10),
                  TabBarContainerPengaduan(onStatusChanged: _filterByStatus),
                  Expanded(
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator()) // Show progress indicator while loading
                        : PengaduanList(
                      pengaduanList: _filteredPengaduanList,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PengaduanAppBar extends StatelessWidget {
  final bool isSearching;
  final String searchQuery;
  final VoidCallback onSearchStart;
  final VoidCallback onSearchStop;
  final ValueChanged<String> onSearchQueryChanged;
  final int unreadCount;
  final ValueChanged<int> onUnreadCountChanged;

  const PengaduanAppBar({
    super.key,
    required this.isSearching,
    required this.searchQuery,
    required this.onSearchStart,
    required this.onSearchStop,
    required this.onSearchQueryChanged,
    required this.unreadCount,
    required this.onUnreadCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF060A47),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: SafeArea(
        child: Row(
          children: [
            if (isSearching)
              Expanded(
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Cari Pengaduan...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onChanged: onSearchQueryChanged,
                ),
              )
            else
              Expanded(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: onSearchStart,
                    ),
                    const Spacer(),
                    const Text(
                      'Pengaduan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // Badge pada ikon notifikasi
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreen(
                                  onUnreadCountChanged: onUnreadCountChanged,
                                ),
                              ),
                            );
                          },
                        ),
                        if (unreadCount > 0)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Center(
                                child: Text(
                                  unreadCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            if (isSearching)
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: onSearchStop,
              ),
          ],
        ),
      ),
    );
  }
}

class PengaduanList extends StatelessWidget {
  final List<Map<String, String>> pengaduanList;

  const PengaduanList({super.key, required this.pengaduanList});

  @override
  Widget build(BuildContext context) {
    if (pengaduanList.isEmpty) {
      // Menampilkan gambar jika tidak ada data pengaduan
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Belum_ada_data.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: pengaduanList.length,
      itemBuilder: (context, index) {
        final pengaduan = pengaduanList[index];
        return PengaduanCard(
          id_kejadian: pengaduan['id_kejadian'] ?? '',
          judul: pengaduan['judul'] ?? '',
          nama: pengaduan['nama'] ?? '',
          tanggal: pengaduan['tanggal'] ?? '',
          nama_jenis_pengaduan: pengaduan['nama_jenis_pengaduan'] ?? '',
          nama_status_pengaduan: pengaduan['nama_status_pengaduan'] ?? '',
          lokasi: pengaduan['lokasi'] ?? '',
          nama_instansi: pengaduan['nama_instansi'] ?? '',
          deskripsi: pengaduan['deskripsi'] ?? '',
          lampiran: pengaduan['lampiran'] ?? '',
        );
      },
    );
  }
}

class TabBarContainerPengaduan extends StatefulWidget {
  final Function(String) onStatusChanged;

  const TabBarContainerPengaduan({super.key, required this.onStatusChanged});

  static const List<String> tabLabels = [
    'Semua',
    'Diajukan',
    'Diproses',
    'Selesai',
    'Ditolak',
    'Dibatalkan'
  ];

  @override
  // ignore: library_private_types_in_public_api
  _TabBarContainerPengaduanState createState() => _TabBarContainerPengaduanState();
}

class _TabBarContainerPengaduanState extends State<TabBarContainerPengaduan> {
  String selectedTab = TabBarContainerPengaduan.tabLabels[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.grey[200],
      child: DropdownButton<String>(
        value: selectedTab,
        icon: const Icon(Icons.arrow_downward),
        isExpanded: true,
        underline: Container(
          height: 2,
          color: Colors.orange,
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedTab = newValue!;
            widget.onStatusChanged(selectedTab); // Call the callback to pass selected status
          });
        },
        items: TabBarContainerPengaduan.tabLabels.map<DropdownMenuItem<String>>((String label) {
          return DropdownMenuItem<String>(
            value: label,
            child: Text(label),
          );
        }).toList(),
      ),
    );
  }
}

class PengaduanCard extends StatelessWidget {
  final String id_kejadian;
  final String judul;
  final String nama;
  final String tanggal;
  final String nama_jenis_pengaduan;
  final String nama_status_pengaduan;
  final String lokasi;
  final String nama_instansi;
  final String deskripsi;
  final String lampiran;

  const PengaduanCard({
    super.key,
    required this.id_kejadian,
    required this.judul,
    required this.nama,
    required this.tanggal,
    required this.nama_jenis_pengaduan,
    required this.nama_status_pengaduan,
    required this.lokasi,
    required this.nama_instansi,
    required this.deskripsi,
    required this.lampiran,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman detail pengaduan dengan data dari card
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPengaduanPage(
              id_kejadian: id_kejadian,
              judul: judul,
              nama: nama,
              tanggal: tanggal,
              nama_jenis_pengaduan: nama_jenis_pengaduan,
              nama_status_pengaduan: nama_status_pengaduan,
              lokasi: lokasi,
              nama_instansi: nama_instansi,
              deskripsi: deskripsi,
              lampiran: lampiran,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3, // Memberikan ruang lebih banyak untuk teks title dan date
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          judul,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tanggal,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      nama_jenis_pengaduan,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor(nama_status_pengaduan), // Memanggil fungsi untuk menentukan warna background
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      nama_status_pengaduan,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Deskripsi : $deskripsi',
                style: const TextStyle(color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk mengubah status menjadi warna background yang sesuai
  Color statusColor(String status) {
    switch (status) {
      case 'Diajukan':
        return Colors.grey.withOpacity(1);
      case 'Diproses':
        return Colors.blue.withOpacity(1);
      case 'Selesai':
        return Colors.green.withOpacity(1);
      case 'Ditolak':
        return Colors.red.withOpacity(1);
      case 'Dibatalkan':
        return Colors.red.withOpacity(1);
      default:
        return Colors.grey.withOpacity(1);
    }
  }
}

class DetailPengaduanPage extends StatelessWidget {
  final String id_kejadian;
  final String judul;
  final String nama;
  final String tanggal;
  final String nama_jenis_pengaduan;
  final String nama_status_pengaduan;
  final String lokasi;
  final String nama_instansi;
  final String deskripsi;
  final String lampiran;

  const DetailPengaduanPage({
    super.key,
    required this.id_kejadian,
    required this.judul,
    required this.nama,
    required this.tanggal,
    required this.nama_jenis_pengaduan,
    required this.nama_status_pengaduan,
    required this.lokasi,
    required this.nama_instansi,
    required this.deskripsi,
    required this.lampiran,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar mirip dengan PengaduanScreen
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF060A47),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'Detail Pengaduan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReadOnlyTextField(label: 'Id Aduan', text: id_kejadian),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'Judul', text: judul),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'User', text: nama),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'Tanggal', text: tanggal),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'Kategori', text: nama_jenis_pengaduan),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'Status', text: nama_status_pengaduan),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'Lokasi', text: lokasi),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'Instansi', text: nama_instansi),
                    const SizedBox(height: 16),
                    TextField(
                      controller: TextEditingController(text: deskripsi),
                      enabled: false,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200, // Fixed height for the image
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: lampiran.isNotEmpty
                          ? Image.network(
                        '$baseUrl/Back-end/foto-pengaduan/$lampiran',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Text('Image not available'));
                        },
                      )
                          : const Center(child: Text('No attachment available')),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: _buildActionButtons(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyTextField({required String label, required String text}) {
    return TextField(
      controller: TextEditingController(text: text),
      enabled: false,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  List<Widget> _buildActionButtons(BuildContext context) {
    if (nama_status_pengaduan == 'Diajukan') {
      return [
        TextButton(
          onPressed: () {
            _updateStatus(context, id_kejadian, 'tolak'); // For "Tolak"
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,  // Background color for "Tolak"
            foregroundColor: Colors.white, // Text color
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),  // Padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),  // Rounded corners
            ),
          ),
          child: const Text('Tolak'),
        ),
        const SizedBox(width: 8),  // Add some spacing between the buttons
        TextButton(
          onPressed: () {
            _updateStatus(context, id_kejadian, 'terima'); // For "Terima"
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,  // Background color for "Terima"
            foregroundColor: Colors.white,  // Text color
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),  // Padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),  // Rounded corners
            ),
          ),
          child: const Text('Terima'),
        ),
      ];
    } else {
      return [
        TextButton(
          onPressed: () {
            _updateStatus(context, id_kejadian, 'delete'); // For "Hapus"
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,  // Background color for "Hapus"
            foregroundColor: Colors.white, // Text color
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),  // Padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),  // Rounded corners
            ),
          ),
          child: const Text('Hapus'),
        ),
      ];
    }
  }

  Future<void> _updateStatus(BuildContext context, String idKejadian, String action) async {
    final response = await http.post(
      pengaduanUrl,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        'id_kejadian': idKejadian,
        'action': action,  // Pass action (terima, tolak, delete)
      },
    );

    // Handle response
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['status'] == 'success') {
        String statusText = (action == 'terima')
            ? "Diproses"
            : (action == 'tolak')
            ? "Ditolak"
            : "Dihapus";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status berhasil diperbarui ke $statusText')),
        );
        // Optionally, you could pop the page to return to the previous screen
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui status')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan')),
      );
    }
  }

}
// ---------------------------------------------------------------------


// ----------------------------RATING--------------------------------
class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  List<Map<String, String>> _serviceList = [];
  List<Map<String, String>> _filteredServiceList = [];
  bool _isSearching = false;
  String _searchQuery = '';
  int _unreadCount = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchRatingData();
    _fetchUnreadCount();
  }

  Future<void> _fetchRatingData() async {
    setState(() {
      _isLoading = true; // Set loading state to true before fetching data
    });

    try {
      final response = await http.get(ratingUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          // Convert each value to a String or a default message
          _serviceList = List<Map<String, String>>.from(data.map((item) => {
            'id_instansi': (item['id_instansi'] ?? '').toString(),
            'nama_instansi' : (item['nama_instansi'] ?? 'nama tidak tersedia').toString(),
            'email_pic': (item['email_pic'] ?? 'email tidak tersedia').toString(),
            'image_instansi': (item['image_instansi'] ?? 'image tidak tersedia').toString(),
            'average_rating': (item['average_rating'] ?? '-').toString(),
            'review_count': (item['review_count'] ?? 'review belum ada').toString(),
          }));

          _filteredServiceList = _serviceList;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        _isLoading = false; // Set loading state to false even on error
      });
    }
  }

  Future<void> _fetchUnreadCount() async {
    try {
      final response = await http.get(notifUrl); // Gunakan URL notifikasi

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            _unreadCount = List<Map<String, dynamic>>.from(data['data'])
                .where((notif) => notif['status_notif'] == 0)
                .length;
          });
        }
      }
    } catch (e) {
      print("Error fetching unread notifications: $e");
    }
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = '';
      _filteredServiceList = _serviceList;
    });
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
      _filteredServiceList = _serviceList
          .where((service) => service['name']!.toLowerCase().contains(newQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RatingAppBar(
            isSearching: _isSearching,
            searchQuery: _searchQuery,
            onSearchStart: _startSearch,
            onSearchStop: _stopSearch,
            onSearchQueryChanged: _updateSearchQuery,
            unreadCount: _unreadCount,
            onUnreadCountChanged: (count) {
              setState(() {
                _unreadCount = count; // Update jumlah badge
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredServiceList.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/Belum_ada_data.png',
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: _filteredServiceList.length,
                itemBuilder: (context, index) {
                  final service = _filteredServiceList[index];
                  return ServiceCard(
                    id_instansi: service['id_instansi']!,
                    nama_instansi: service['nama_instansi']!,
                    email_pic: service['email_pic']!,
                    average_rating: double.tryParse(service['average_rating']!) ?? 0.0,
                    review_count: int.tryParse(service['review_count']!) ?? 0,
                    image_instansi: service['image_instansi']!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingAppBar extends StatelessWidget {
  final bool isSearching;
  final String searchQuery;
  final VoidCallback onSearchStart;
  final VoidCallback onSearchStop;
  final ValueChanged<String> onSearchQueryChanged;
  final int unreadCount;
  final ValueChanged<int> onUnreadCountChanged;

  const RatingAppBar({
    super.key,
    required this.isSearching,
    required this.searchQuery,
    required this.onSearchStart,
    required this.onSearchStop,
    required this.onSearchQueryChanged,
    required this.unreadCount,
    required this.onUnreadCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF060A47),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: SafeArea(
        child: Row(
          children: [
            if (isSearching)
              Expanded(
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Cari layanan...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onChanged: onSearchQueryChanged,
                ),
              )
            else
              Expanded(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: onSearchStart,
                    ),
                    const Spacer(),
                    const Text(
                      'Rating',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreen(
                                  onUnreadCountChanged: onUnreadCountChanged,
                                ),
                              ),
                            );
                          },
                        ),
                        if (unreadCount > 0)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Center(
                                child: Text(
                                  unreadCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            if (isSearching)
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: onSearchStop,
              ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String id_instansi;
  final String nama_instansi;
  final String email_pic;
  final double average_rating;
  final int review_count;
  final String image_instansi;

  const ServiceCard({
    super.key,
    required this.id_instansi,
    required this.nama_instansi,
    required this.email_pic,
    required this.average_rating,
    required this.review_count,
    required this.image_instansi,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke ServiceDetailPage dan mengoper data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailPage(
              service: {
                'id_instansi' : id_instansi,
                'nama_instansi': nama_instansi,
                'email_pic': email_pic,
                'average_rating': average_rating.toString(),
                'review_count': review_count.toString(),
                'image_instansi': image_instansi,
              },
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                '$baseUrl/$image_instansi',
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image not available'));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama_instansi,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email_pic,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '$average_rating/5',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Row(
                        children: List.generate(5, (index) {
                          if (index < average_rating.floor()) {
                            return const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 20,
                            );
                          } else if (index == average_rating.floor() && average_rating % 1 != 0) {
                            return const Icon(
                              Icons.star_half,
                              color: Colors.orange,
                              size: 20,
                            );
                          } else {
                            return const Icon(
                              Icons.star_border,
                              color: Colors.orange,
                              size: 20,
                            );
                          }
                        }),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$review_count Reviews',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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

class ServiceDetailPage extends StatefulWidget {
  final Map<String, dynamic> service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  // ignore: library_private_types_in_public_api
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  String selectedSort = 'Terbaru';
  List<Map<String, dynamic>> reviews = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReviewsByInstansi(widget.service['id_instansi']);
  }

  Future<void> fetchReviewsByInstansi(String idInstansi) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/api_ulasan.php?id_instansi=$idInstansi'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          reviews = data.map((item) => {
            'id_kejadian' : item['id_kejadian'],
            'id_instansi': item['id_instansi'],
            'nama': item['nama'],
            'tanggal': DateTime.parse(item['tanggal']),
            'isi_komentar': item['isi_komentar'],
            'skala_bintang': int.parse(item['skala_bintang']),
            'image': item['image'],
          }).toList();
          isLoading = false; // Set loading ke false setelah data berhasil diambil
        });
      } else {
        // Jika status code bukan 200, anggap gagal memuat
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load reviews, status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log error di console dan update `isLoading` agar berhenti loading
      print('Error fetching reviews: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sorting reviews based on selected option
    reviews.sort((a, b) {
      if (selectedSort == 'Terbaru') {
        return b['tanggal'].compareTo(a['tanggal']);
      } else {
        return a['tanggal'].compareTo(b['tanggal']);
      }
    });

    return Scaffold(
      body: Column(
        children: [
          // Navbar
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF060A47),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Detail Review',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      // Your notification screen navigation
                    },
                  ),
                ],
              ),
            ),
          ),
          // Main content area
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Your existing widgets...
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton<String>(
                        value: selectedSort,
                        items: const [
                          DropdownMenuItem(value: 'Terbaru', child: Text('Terbaru')),
                          DropdownMenuItem(value: 'Terlama', child: Text('Terlama')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedSort = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  // Display reviews
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRatingPage(
                                review: review,
                                onReviewDeleted: () {
                                  // Tampilkan pesan berhasil, lalu pop kembali ke halaman sebelumnya
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Review berhasil dihapus')),
                                  );
                                  fetchReviewsByInstansi(widget.service['id_instansi']);
                                  Navigator.pop(context); // Tutup halaman detail setelah berhasil
                                },
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: review['image'] != null && review['image'].isNotEmpty
                                          ? NetworkImage('$baseUrl${review['image']}')
                                          : AssetImage('images/Foto_profile.png'), // Gambar lokal fallback
                                      onBackgroundImageError: (exception, stackTrace) {
                                        // Optional: handle error jika gambar tidak ditemukan
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          review['nama'],
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${review['tanggal'].day}/${review['tanggal'].month}/${review['tanggal'].year}',
                                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < review['skala_bintang'] ? Icons.star : Icons.star_border,
                                      color: Colors.orange,
                                      size: 16,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  review['isi_komentar'],
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailRatingPage extends StatelessWidget {
  final Map<String, dynamic> review;
  final VoidCallback onReviewDeleted;

  const DetailRatingPage({
    Key? key,
    required this.review,
    required this.onReviewDeleted,
  }) : super(key: key);

  Future<void> deleteReview(BuildContext context, String id_kejadian) async {
    final url = '$baseUrl/api/api_ulasan.php?id_kejadian=$id_kejadian&action=delete';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        onReviewDeleted(); // Memanggil callback setelah penghapusan berhasil
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menghapus review')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan saat menghubungi server')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Data yang akan ditampilkan berdasarkan review yang diterima
    final id_kejadian = review['id_kejadian'] as String;
    final name = review['nama'] as String;
    final date = review['tanggal'] as DateTime;
    final content = review['isi_komentar'] as String;
    final rating = review['skala_bintang'] as int;

    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar mirip dengan PengaduanScreen
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF060A47),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: SafeArea(
              child: Row(
                children: [
                  // Icon Back di sebelah kiri
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  // Expanded untuk menempatkan teks di tengah
                  const Expanded(
                    child: Text(
                      'Detail Rating',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Spacer untuk menggantikan posisi icon notifikasi
                  const SizedBox(width: 48), // Mengimbangi ukuran ikon yang hilang
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: review['image'] != null && review['image'].isNotEmpty
                            ? NetworkImage('$baseUrl${review['image']}')
                            : AssetImage('images/Foto_profile.png'), // Gambar lokal fallback
                        onBackgroundImageError: (exception, stackTrace) {
                          // Optional: handle error jika gambar tidak ditemukan
                        },
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          initialValue: name,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Nama',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: '${date.day}/${date.month}/${date.year}',
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: 20,
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: content,
                    readOnly: true,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Isi Review',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Konfirmasi"),
                                content: const Text("Apakah Anda yakin ingin menghapus review ini?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Batal"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      // Memanggil fungsi deleteReview untuk menghapus ulasan
                                      deleteReview(context, id_kejadian);
                                    },
                                    child: const Text("Hapus"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Hapus',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// -------------------------------------------------------------------


// ----------------------------BERANDA--------------------------------
class BerandaService {
  static Future<Map<String, int>> fetchActivityData() async {
    try {
      final response = await http.get(berandaUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          "pengaduan": data["pengaduan"] ?? 0,
          "kehilangan": data["kehilangan"] ?? 0,
          "rating": data["rating"] ?? 0,
        };
      } else {
        print("Failed to load data: ${response.statusCode}");
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw Exception("Error fetching data: $e");
    }
  }
}

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({Key? key}) : super(key: key);

  @override
  _BerandaScreenState createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchUnreadCount(); // Ambil jumlah notifikasi belum dibaca
  }

  Future<void> _fetchUnreadCount() async {
    try {
      final response = await http.get(notifUrl); // Gunakan URL notifikasi

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            unreadCount = List<Map<String, dynamic>>.from(data['data'])
                .where((notif) => notif['status_notif'] == 0)
                .length;
          });
        }
      }
    } catch (e) {
      print("Error fetching unread notifications: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context), // Header untuk desain di atas
            _buildMenu(context), // Grid menu
            _buildActivitySection(context), // Aktivitas bagian
          ],
        ),
      ),
    );
  }

  // Fungsi _buildHeader
  Widget _buildHeader(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge, // Memotong elemen yang keluar dari Stack
        children: [
          Container(
            width: double.infinity,
            height: 285,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
              ),
              image: DecorationImage(
                image: AssetImage('images/Login_Image.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 36,
                    width: 120,
                    margin: const EdgeInsets.only(top: 16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset("images/Polines.png"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 24.0
                    ),
                    child: Text(
                      'WICARA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 2,
                    ),
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        'Wadah Informasi Catatan Aspirasi & Rating Akademik',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.italic
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
          // Ikon Notifikasi
          Positioned(
            top: 28,
            right: 20,
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white, size: 25),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(
                          onUnreadCountChanged: (count) {
                            setState(() {
                              unreadCount = count; // Perbarui jumlah badge
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi _buildMenu untuk grid menu
  Widget _buildMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Jumlah kolom grid
          childAspectRatio: 0.8, // Memberikan lebih banyak ruang vertikal
          mainAxisSpacing: 1, // Memberikan jarak vertikal antar item
          crossAxisSpacing: 16, // Memberikan jarak horizontal antar item
        ),
        children: [
          _buildMenuItem(context , 'Dosen/Tendik', Icons.person),
          _buildMenuItem(context ,'Mahasiswa', Icons.school),
          _buildMenuItem(context ,'Unit Layanan', Icons.business),
          _buildMenuItem(context ,'Jenis Pengaduan', Icons.category),
        ],
      ),
    );
  }

  // Fungsi untuk membuat item grid menu
    // Fungsi untuk membuat item grid menu
  Widget _buildMenuItem(BuildContext context,String title, IconData icon) {
    return InkWell(
      onTap: () {
        // Aksi saat item di-tap, arahkan ke screen baru
        if (title == 'Dosen/Tendik') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DosenScreen()),
          );
        } else if (title == 'Mahasiswa') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MahasiswaScreen()),
          );
        } else if (title == 'Unit Layanan') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UnitLayananScreen()),
          );
        } else if (title == 'Jenis Pengaduan') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const JenisPengaduanScreen()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color.fromARGB(255, 6, 10, 71),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi _buildActivitySection dengan FutureBuilder untuk mendapatkan data dari API
  Widget _buildActivitySection(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: BerandaService.fetchActivityData(), // Memanggil fungsi API
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Menampilkan indikator loading saat menunggu data
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Menampilkan pesan kesalahan jika terjadi error
          return const Center(child: Text('Gagal memuat data'));
        } else if (snapshot.hasData) {
          // Jika data berhasil didapatkan
          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aktivitas yang perlu ditangani',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildActivityCard('Pengaduan', data["pengaduan"] ?? 0, Icons.report, 1, context),
                const SizedBox(height: 8),
                _buildActivityCard('Laporan Kehilangan', data["kehilangan"] ?? 0, Icons.search, 2, context),
                const SizedBox(height: 8),
                _buildActivityCard('Rating', data["rating"] ?? 0, Icons.star, 3, context),
              ],
            ),
          );
        } else {
          // Jika tidak ada data
          return const Center(child: Text('Tidak ada data yang tersedia'));
        }
      },
    );
  }

  // Fungsi untuk membuat kartu aktivitas
  Widget _buildActivityCard(String title, int jumlah, IconData icon, int navigationIndex, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF060A47),
              Color.fromARGB(255, 8, 14, 97),
              Color.fromARGB(255, 4, 80, 181),
              Color.fromARGB(255, 84, 115, 254)
            ], // Gradient biru
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$jumlah Perlu diproses',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background color
                  foregroundColor: const Color(0xFF0052D4), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  final homeState =
                      context.findAncestorStateOfType<_MyHomePageState>();
                  if (homeState != null) {
                    homeState._navigateToScreen(navigationIndex);
                  }
                },
                child: const Text('Detail'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// -------------------------------------------------------------------


// ----------------------------DOSEN--------------------------------
class DosenScreen extends StatefulWidget {
  const DosenScreen({super.key});

  @override
  State<DosenScreen> createState() => _DosenScreenState();
}

class _DosenScreenState extends State<DosenScreen> {
  List<Map<String, dynamic>> dosenList = [];
  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    fetchDosen();
  }

  Future<void> fetchDosen() async {
    try {
      final response = await http.get(
        dosenUrl,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          dosenList = data.cast<Map<String, dynamic>>();
          filteredList = dosenList;
        });
      } else {
        throw Exception("Failed to load dosen data");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Dosen/Tendik'),
        backgroundColor: const Color(0xFF060A47),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DosenSearchDelegate(dosenList: dosenList),
              );
            },
          ),
        ],
      ),
      body: filteredList.isEmpty
          ? Center(
        child: Text(
          dosenList.isEmpty
              ? "Tidak ada data dosen tersedia" // Jika data kosong
              : "Pencarian tidak menemukan hasil", // Jika pencarian kosong
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final dosen = filteredList[index];
          return ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF060A47)),
            title: Text(dosen['nama'] ?? 'Unknown'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DosenDetailScreen(dosen: dosen),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DosenSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> dosenList;

  DosenSearchDelegate({required this.dosenList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = dosenList
        .where((dosen) =>
    dosen['nama'] != null &&
        dosen['nama'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final dosen = results[index];
        return ListTile(
          title: Text(dosen['nama'] ?? 'Unknown'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DosenDetailScreen(dosen: dosen),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = dosenList
        .where((dosen) =>
    dosen['nama'] != null &&
        dosen['nama'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final dosen = suggestions[index];
        return ListTile(
          title: Text(dosen['nama'] ?? 'Unknown'),
          onTap: () {
            query = dosen['nama'];
            showResults(context);
          },
        );
      },
    );
  }
}

class DosenDetailScreen extends StatefulWidget {
  final Map<String, dynamic> dosen;

  const DosenDetailScreen({super.key, required this.dosen});

  @override
  _DosenDetailScreenState createState() => _DosenDetailScreenState();
}

class _DosenDetailScreenState extends State<DosenDetailScreen> {
  late TextEditingController idUserController;
  late TextEditingController namaController;
  late TextEditingController nomorIndukController;
  late TextEditingController noTelpController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController roleController;

  @override
  void initState() {
    super.initState();
    idUserController = TextEditingController(text: widget.dosen['id_user']);
    namaController = TextEditingController(text: widget.dosen['nama']);
    nomorIndukController = TextEditingController(text: widget.dosen['nomor_induk']);
    noTelpController = TextEditingController(text: widget.dosen['nomor_telepon']);
    emailController = TextEditingController(text: widget.dosen['email']);
    passwordController = TextEditingController(text: widget.dosen['password']);
    roleController = TextEditingController(text: "Dosen");
  }

  void resetPassword() async {
    final idDosen = idUserController.text; // Ambil ID dosen dari controller

    final response = await http.post(
      dosenUrl,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"id_user": idDosen}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["success"]) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"])),
        );
        passwordController.text = "Polines123*"; // Tampilkan password default
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menghubungi server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Dosen"),
        backgroundColor: const Color(0xFF060A47),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Icon(Icons.person, size: 100, color: Color(0xFF060A47)),
              const SizedBox(height: 20),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nomorIndukController,
                decoration: const InputDecoration(
                  labelText: "Nomor Induk",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: noTelpController,
                decoration: const InputDecoration(
                  labelText: "No. Telp",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(
                  labelText: "Role",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF060A47),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: resetPassword,
                child: const Text("Reset Password", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ---------------------------------------------------------------------


// ----------------------------MAHASISWA--------------------------------
class MahasiswaScreen extends StatefulWidget {
  const MahasiswaScreen({super.key});

  @override
  State<MahasiswaScreen> createState() => _MahasiswaScreenState();
}

class _MahasiswaScreenState extends State<MahasiswaScreen> {
  List<Map<String, dynamic>> mahasiswaList = [];
  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    fetchMahasiswa();
  }

  Future<void> fetchMahasiswa() async {
    try {
      final response = await http.get(
        mahasiswaUrl,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          mahasiswaList = data.cast<Map<String, dynamic>>();
          filteredList = mahasiswaList;
        });
      } else {
        throw Exception("Failed to load mahasiswa data");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Mahasiswa'),
        backgroundColor: const Color(0xFF060A47),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MahasiswaSearchDelegate(mahasiswaList: mahasiswaList),
              );
            },
          ),
        ],
      ),
      body: filteredList.isEmpty
          ? Center(
        child: Text(
          mahasiswaList.isEmpty
              ? "Tidak ada data mahasiswa tersedia" // Jika data kosong
              : "Pencarian tidak menemukan hasil", // Jika pencarian kosong
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final mahasiswa = filteredList[index];
          return ListTile(
            leading: const Icon(Icons.school, color: Color(0xFF060A47)),
            title: Text(mahasiswa['nama'] ?? 'Unknown'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MahasiswaDetailScreen(mahasiswa: mahasiswa),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MahasiswaSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> mahasiswaList;

  MahasiswaSearchDelegate({required this.mahasiswaList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = mahasiswaList
        .where((mahasiswa) =>
    mahasiswa['nama'] != null &&
        mahasiswa['nama'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final mahasiswa = results[index];
        return ListTile(
          title: Text(mahasiswa['nama'] ?? 'Unknown'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MahasiswaDetailScreen(mahasiswa: mahasiswa),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = mahasiswaList
        .where((mahasiswa) =>
    mahasiswa['nama'] != null &&
        mahasiswa['nama'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final mahasiswa = suggestions[index];
        return ListTile(
          title: Text(mahasiswa['nama'] ?? 'Unknown'),
          onTap: () {
            query = mahasiswa['nama'];
            showResults(context);
          },
        );
      },
    );
  }
}

class MahasiswaDetailScreen extends StatefulWidget {
  final Map<String, dynamic> mahasiswa;

  const MahasiswaDetailScreen({super.key, required this.mahasiswa});

  @override
  _MahasiswaDetailScreenState createState() => _MahasiswaDetailScreenState();
}

class _MahasiswaDetailScreenState extends State<MahasiswaDetailScreen> {
  late TextEditingController idUserController;
  late TextEditingController namaController;
  late TextEditingController nomorIndukController;
  late TextEditingController noTelpController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController roleController;

  @override
  void initState() {
    super.initState();
    idUserController = TextEditingController(text: widget.mahasiswa['id_user']);
    namaController = TextEditingController(text: widget.mahasiswa['nama']);
    nomorIndukController = TextEditingController(text: widget.mahasiswa['nomor_induk']);
    noTelpController = TextEditingController(text: widget.mahasiswa['nomor_telepon']);
    emailController = TextEditingController(text: widget.mahasiswa['email']);
    passwordController = TextEditingController(text: widget.mahasiswa['password']);
    roleController = TextEditingController(text: "Mahasiswa");
  }

  void resetPassword() async {
    final idMahasiswa = idUserController.text; // Ambil ID mahasiswa dari controller

    final response = await http.post(
      mahasiswaUrl,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"id_user": idMahasiswa}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["success"]) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"])),
        );
        passwordController.text = "Polines123*"; // Tampilkan password default
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menghubungi server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Mahasiswa"),
        backgroundColor: const Color(0xFF060A47),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Icon(Icons.school, size: 100, color: Color(0xFF060A47)),
              const SizedBox(height: 20),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nomorIndukController,
                decoration: const InputDecoration(
                  labelText: "Nomor Induk",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: noTelpController,
                decoration: const InputDecoration(
                  labelText: "No. Telp",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(
                  labelText: "Role",
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF060A47),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: resetPassword,
                child: const Text("Reset Password", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ---------------------------------------------------------------------


// ----------------------------UNIT LAYANAN--------------------------------
class UnitLayananScreen extends StatefulWidget {
  const UnitLayananScreen({super.key});

  @override
  State<UnitLayananScreen> createState() => _UnitLayananScreenState();
}

class _UnitLayananScreenState extends State<UnitLayananScreen> {
  List<Map<String, dynamic>> unitLayananList = [];
  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    fetchUnitLayanan();
  }

  Future<void> fetchUnitLayanan() async {
    try {
      final response = await http.get(
        unitLayananUrl,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          unitLayananList = data.cast<Map<String, dynamic>>();
          filteredList = unitLayananList;
        });
      } else {
        throw Exception("Failed to load unit layanan data");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Unit Layanan'),
        backgroundColor: const Color(0xFF060A47),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: UnitLayananSearchDelegate(unitLayananList: unitLayananList),
              );
            },
          ),
        ],
      ),
      body: filteredList.isEmpty
          ? Center(
        child: Text(
          unitLayananList.isEmpty
              ? "Tidak ada data unit layanan tersedia" // Jika data kosong
              : "Pencarian tidak menemukan hasil", // Jika pencarian kosong
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final unitLayanan = filteredList[index];
          return ListTile(
            leading: const Icon(Icons.business, color: Color(0xFF060A47)),
            title: Text(unitLayanan['nama_instansi'] ?? 'Unknown'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UnitLayananDetailScreen(unitLayanan: unitLayanan),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UnitLayananSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> unitLayananList;

  UnitLayananSearchDelegate({required this.unitLayananList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = unitLayananList
        .where((unitLayanan) =>
    unitLayanan['nama_instansi'] != null &&
        unitLayanan['nama_instansi'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final unitLayanan = results[index];
        return ListTile(
          title: Text(unitLayanan['nama_instansi'] ?? 'Unknown'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UnitLayananDetailScreen(unitLayanan: unitLayanan),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = unitLayananList
        .where((unitLayanan) =>
    unitLayanan['nama_instansi'] != null &&
        unitLayanan['nama_instansi'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final unitLayanan = suggestions[index];
        return ListTile(
          title: Text(unitLayanan['nama_instansi'] ?? 'Unknown'),
          onTap: () {
            query = unitLayanan['nama_instansi'];
            showResults(context);
          },
        );
      },
    );
  }
}

class UnitLayananDetailScreen extends StatefulWidget {
  final Map<String, dynamic> unitLayanan;

  const UnitLayananDetailScreen({super.key, required this.unitLayanan});

  @override
  _UnitLayananDetailScreenState createState() => _UnitLayananDetailScreenState();
}

class _UnitLayananDetailScreenState extends State<UnitLayananDetailScreen> {
  late TextEditingController idInstansiController;
  late TextEditingController namaInstansiController;
  late TextEditingController emailPicController;
  late TextEditingController passwordController;
  String? qrCodeUrl;
  bool isEditMode = false;  // Variabel untuk mode edit

  @override
  void initState() {
    super.initState();
    idInstansiController = TextEditingController(text: widget.unitLayanan['id_instansi']);
    namaInstansiController = TextEditingController(text: widget.unitLayanan['nama_instansi']);
    emailPicController = TextEditingController(text: widget.unitLayanan['email_pic']);
    passwordController = TextEditingController(text: widget.unitLayanan['password']);
    qrCodeUrl = widget.unitLayanan['qr_code_url'];
  }

  @override
  void dispose() {
    idInstansiController.dispose();
    namaInstansiController.dispose();
    emailPicController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> saveChanges() async {
    final response = await http.post(
      unitLayananUrl,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "unit_id": widget.unitLayanan['id_instansi'],
        "nama_instansi": namaInstansiController.text,
        "email_pic": emailPicController.text,
        "password": passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil disimpan")),
        );
        setState(() {
          isEditMode = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menyimpan data: ${result['message']}")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan pada server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Unit Layanan"),
        backgroundColor: const Color(0xFF060A47),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Icon(Icons.business, size: 100, color: Color(0xFF060A47)),
              const SizedBox(height: 20),
              TextField(
                controller: namaInstansiController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                ),
                enabled: isEditMode,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailPicController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                enabled: isEditMode,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                enabled: isEditMode,
              ),
              const SizedBox(height: 20),
              if (qrCodeUrl != null)
                Column(
                  children: [
                    const Text(
                      "QR Code",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Image.network(
                      qrCodeUrl = "$baseUrl/api/api_showQR.php?unit_id=${widget.unitLayanan['id_instansi']}",
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text("Gagal memuat / Tidak memiliki QR Code");
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF060A47),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  if (isEditMode) {
                    saveChanges();
                  } else {
                    setState(() {
                      isEditMode = true;
                    });
                  }
                },
                child: Text(isEditMode ? "Simpan" : "Edit", style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ------------------------------------------------------------------------


// ----------------------------JENIS PENGADUAN--------------------------------
class JenisPengaduanScreen extends StatefulWidget {
  const JenisPengaduanScreen({super.key});

  @override
  State<JenisPengaduanScreen> createState() => _JenisPengaduanScreenState();
}

class _JenisPengaduanScreenState extends State<JenisPengaduanScreen> {
  List<Map<String, dynamic>> jenisPengaduanList = [];
  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    fetchJenisPengaduan();
  }

  Future<void> fetchJenisPengaduan() async {
    try {
      final response = await http.get(
        jenisPengaduanUrl,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          jenisPengaduanList = data.cast<Map<String, dynamic>>();
          filteredList = jenisPengaduanList;
        });
      } else {
        throw Exception("Failed to load unit layanan data");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Jenis Pengaduan'),
        backgroundColor: const Color(0xFF060A47),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: JenisPengaduanSearchDelegate(jenisPengaduanList: jenisPengaduanList),
              );
            },
          ),
        ],
      ),
      body: filteredList.isEmpty
          ? Center(
        child: Text(
          jenisPengaduanList.isEmpty
              ? "Tidak ada data jenis pengaduan tersedia" // Jika data kosong
              : "Pencarian tidak menemukan hasil", // Jika pencarian kosong
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final jenisPengaduan = filteredList[index];
          return ListTile(
            leading: const Icon(Icons.category, color: Color(0xFF060A47)),
            title: Text(jenisPengaduan['nama_jenis_pengaduan'] ?? 'Unknown'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JenisPengaduanDetailScreen(jenisPengaduan: jenisPengaduan),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class JenisPengaduanSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> jenisPengaduanList;

  JenisPengaduanSearchDelegate({required this.jenisPengaduanList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = jenisPengaduanList
        .where((jenisPengaduan) =>
    jenisPengaduan['nama_jenis_pengaduan'] != null &&
        jenisPengaduan['nama_jenis_pengaduan'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final jenisPengaduan = results[index];
        return ListTile(
          title: Text(jenisPengaduan['nama_jenis_pengaduan'] ?? 'Unknown'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JenisPengaduanDetailScreen(jenisPengaduan: jenisPengaduan),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = jenisPengaduanList
        .where((jenisPengaduan) =>
    jenisPengaduan['nama_jenis_pengaduan'] != null &&
        jenisPengaduan['nama_jenis_pengaduan'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final jenisPengaduan = suggestions[index];
        return ListTile(
          title: Text(jenisPengaduan['nama_jenis_pengaduan'] ?? 'Unknown'),
          onTap: () {
            query = jenisPengaduan['nama_jenis_pengaduan'];
            showResults(context);
          },
        );
      },
    );
  }
}

class JenisPengaduanDetailScreen extends StatefulWidget {
  final Map<String, dynamic> jenisPengaduan;

  const JenisPengaduanDetailScreen({super.key, required this.jenisPengaduan});

  @override
  _JenisPengaduanDetailScreenState createState() => _JenisPengaduanDetailScreenState();
}

class _JenisPengaduanDetailScreenState extends State<JenisPengaduanDetailScreen> {
  late TextEditingController idJenisPengaduanController;
  late TextEditingController namaJenisPengaduanController;
  bool isEditMode = false;  // Variabel untuk mode edit

  @override
  void initState() {
    super.initState();
    idJenisPengaduanController = TextEditingController(text: widget.jenisPengaduan['id_jenis_pengaduan']);
    namaJenisPengaduanController = TextEditingController(text: widget.jenisPengaduan['nama_jenis_pengaduan']);
  }

  Future<void> saveChanges() async {
    final response = await http.post(
      jenisPengaduanUrl,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "id_jenis_pengaduan": widget.jenisPengaduan['id_jenis_pengaduan'],
        "nama_jenis_pengaduan": namaJenisPengaduanController.text
      }),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil disimpan")),
        );
        setState(() {
          isEditMode = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menyimpan data: ${result['message']}")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan pada server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Jenis Pengaduan"),
        backgroundColor: const Color(0xFF060A47),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Icon(Icons.category, size: 100, color: Color(0xFF060A47)),
              const SizedBox(height: 20),
              TextField(
                controller: namaJenisPengaduanController,
                decoration: const InputDecoration(
                  labelText: "Nama Unit Layanan",
                  border: OutlineInputBorder(),
                ),
                enabled: isEditMode,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF060A47),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  if (isEditMode) {
                    saveChanges();
                  } else {
                    setState(() {
                      isEditMode = true;
                    });
                  }
                },
                child: Text(isEditMode ? "Simpan" : "Edit", style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ---------------------------------------------------------------------------


// ----------------------------KEHILANGAN--------------------------------
class KehilanganScreen extends StatefulWidget {
  const KehilanganScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _KehilanganScreenState createState() => _KehilanganScreenState();
}

class _KehilanganScreenState extends State<KehilanganScreen> {
  List<Map<String, String>> _kehilanganList = [];
  List<Map<String, String>> _filteredKehilanganList = [];
  bool _isSearching = false;
  String _searchQuery = '';
  int _unreadCount = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchKehilanganData();
    _fetchUnreadCount();
  }

  Future<void> _fetchKehilanganData() async {
    setState(() {
      _isLoading = true; // Set loading state to true before fetching data
    });

    try {
      final response = await http.get(kehilanganUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          // Convert each value to a String or a default message
          _kehilanganList = List<Map<String, String>>.from(data.map((item) => {
            'id_kejadian': (item['id_kejadian'] ?? '').toString(),
            'nama' : (item['nama'] ?? 'nama tidak tersedia').toString(),
            'nama_barang': (item['nama_barang'] ?? 'barang tidak tersedia').toString(),
            'tanggal': (item['tanggal'] ?? 'Tanggal tidak tersedia').toString(),
            'nama_status_kehilangan': (item['nama_status_kehilangan'] ?? 'Status tidak tersedia').toString(),
            'lokasi': (item['lokasi'] ?? 'lokasi tidak tersedia').toString(),
            'deskripsi': (item['deskripsi'] ?? 'Deskripsi tidak tersedia').toString(),
            'lampiran': (item['lampiran'] ?? 'lampiran tidak tersedia').toString(),
          }));

          _filteredKehilanganList = _kehilanganList;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        _isLoading = false; // Set loading state to false even on error
      });
    }
  }

  Future<void> _fetchUnreadCount() async {
    try {
      final response = await http.get(notifUrl); // Gunakan URL notifikasi

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            _unreadCount = List<Map<String, dynamic>>.from(data['data'])
                .where((notif) => notif['status_notif'] == 0)
                .length;
          });
        }
      }
    } catch (e) {
      print("Error fetching unread notifications: $e");
    }
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = '';
      _filteredKehilanganList = _kehilanganList;
    });
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
      _filteredKehilanganList = _kehilanganList
          .where((item) => item['judul']!.toLowerCase().contains(newQuery.toLowerCase()))
          .toList();
    });
  }

  void _filterByStatus(String status) {
    setState(() {
      if (status == 'Semua') {
        _filteredKehilanganList = _kehilanganList;
      } else {
        _filteredKehilanganList = _kehilanganList
            .where((item) => item['nama_status_kehilangan'] == status)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          KehilanganAppBar(
            isSearching: _isSearching,
            searchQuery: _searchQuery,
            onSearchStart: _startSearch,
            onSearchStop: _stopSearch,
            onSearchQueryChanged: _updateSearchQuery,
            unreadCount: _unreadCount,
            onUnreadCountChanged: (count) {
              setState(() {
                _unreadCount = count; // Update jumlah badge
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LastUpdateRow(
                    lastUpdateDate: _filteredKehilanganList.isNotEmpty
                        ? _filteredKehilanganList.first['tanggal'] ?? 'Tanggal tidak tersedia'
                        : 'Tanggal tidak tersedia',
                  ),
                  const SizedBox(height: 10),
                  TabBarContainerKehilangan(onStatusChanged: _filterByStatus),
                  Expanded(
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : KehilanganList(
                        kehilanganList: _filteredKehilanganList),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KehilanganAppBar extends StatelessWidget {
  final bool isSearching;
  final String searchQuery;
  final VoidCallback onSearchStart;
  final VoidCallback onSearchStop;
  final ValueChanged<String> onSearchQueryChanged;
  final int unreadCount;
  final ValueChanged<int> onUnreadCountChanged;

  const KehilanganAppBar({
    super.key,
    required this.isSearching,
    required this.searchQuery,
    required this.onSearchStart,
    required this.onSearchStop,
    required this.onSearchQueryChanged,
    required this.unreadCount,
    required this.onUnreadCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF060A47),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: SafeArea(
        child: Row(
          children: [
            if (isSearching)
              Expanded(
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Cari Kehilangan...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onChanged: onSearchQueryChanged,
                ),
              )
            else
              Expanded(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: onSearchStart,
                    ),
                    const Spacer(),
                    const Text(
                      'Kehilangan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreen(
                                  onUnreadCountChanged: onUnreadCountChanged,
                                ),
                              ),
                            );
                          },
                        ),
                        if (unreadCount > 0)
                          Positioned(
                            right: 6,
                            top: 6,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Center(
                                child: Text(
                                  unreadCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            if (isSearching)
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: onSearchStop,
              ),
          ],
        ),
      ),
    );
  }
}

class KehilanganList extends StatelessWidget {
  final List<Map<String, String>> kehilanganList;

  const KehilanganList({super.key, required this.kehilanganList});

  @override
  Widget build(BuildContext context) {
    if (kehilanganList.isEmpty) {
      // Menampilkan gambar jika tidak ada data pengaduan
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Belum_ada_data.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: kehilanganList.length,
      itemBuilder: (context, index) {
        final kehilangan = kehilanganList[index];
        return KehilanganCard(
          id_kejadian: kehilangan['id_kejadian'] ?? '',
          nama: kehilangan['nama'] ?? '',
          nama_barang: kehilangan['nama_barang'] ?? '',
          tanggal: kehilangan['tanggal'] ?? '',
          nama_status_kehilangan : kehilangan['nama_status_kehilangan'] ?? '',
          lokasi: kehilangan['lokasi'] ?? '',
          deskripsi: kehilangan['deskripsi'] ?? '',
          lampiran: kehilangan['lampiran'] ?? '',
        );
      },
    );
  }
}

class TabBarContainerKehilangan extends StatefulWidget {
  final Function(String) onStatusChanged;

  const TabBarContainerKehilangan({super.key, required this.onStatusChanged});

  static const List<String> tabLabels = [
    'Semua',
    'Belum Ditemukan',
    'Ditemukan',
    'Dibatalkan'
  ];

  @override
  // ignore: library_private_types_in_public_api
  _TabBarContainerKehilanganState createState() => _TabBarContainerKehilanganState();
}

class _TabBarContainerKehilanganState extends State<TabBarContainerKehilangan> {
  String selectedTab = TabBarContainerKehilangan.tabLabels[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.grey[200],
      child: DropdownButton<String>(
        value: selectedTab,
        icon: const Icon(Icons.arrow_downward),
        isExpanded: true,
        underline: Container(
          height: 2,
          color: Colors.orange,
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedTab = newValue!;
            widget.onStatusChanged(selectedTab); // Call the callback to pass selected status
          });
        },
        items: TabBarContainerKehilangan.tabLabels.map<DropdownMenuItem<String>>((String label) {
          return DropdownMenuItem<String>(
            value: label,
            child: Text(label),
          );
        }).toList(),
      ),
    );
  }
}

class KehilanganCard extends StatelessWidget {
  final String id_kejadian;
  final String nama;
  final String nama_barang;
  final String tanggal;
  final String nama_status_kehilangan;
  final String lokasi;
  final String deskripsi;
  final String lampiran;

  const KehilanganCard({
    super.key,
    required this.id_kejadian,
    required this.nama,
    required this.nama_barang,
    required this.tanggal,
    required this.nama_status_kehilangan,
    required this.lokasi,
    required this.deskripsi,
    required this.lampiran,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman detail pengaduan dengan data dari card
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailKehilanganPage(
              id_kejadian: id_kejadian,
              nama: nama,
              nama_barang: nama_barang,
              tanggal: tanggal,
              nama_status_kehilangan: nama_status_kehilangan,
              lokasi: lokasi,
              deskripsi: deskripsi,
              lampiran: lampiran,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3, // Memberikan ruang lebih banyak untuk teks title dan date
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama_barang,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tanggal,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor(nama_status_kehilangan), // Memanggil fungsi untuk menentukan warna background
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      nama_status_kehilangan,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Deskripsi : $deskripsi',
                style: const TextStyle(color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk mengubah status menjadi warna background yang sesuai
  Color statusColor(String status) {
    switch (status) {
      case 'Belum Ditemukan':
        return Colors.orange.withOpacity(1);
      case 'Ditemukan':
        return Colors.green.withOpacity(1);
      case 'Dibatalkan':
        return Colors.red.withOpacity(1);
      default:
        return Colors.grey.withOpacity(1);
    }
  }
}

class DetailKehilanganPage extends StatelessWidget {
  final String id_kejadian;
  final String nama;
  final String nama_barang;
  final String tanggal;
  final String nama_status_kehilangan;
  final String lokasi;
  final String deskripsi;
  final String lampiran;

  const DetailKehilanganPage({
    super.key,
    required this.id_kejadian,
    required this.nama,
    required this.nama_barang,
    required this.tanggal,
    required this.nama_status_kehilangan,
    required this.lokasi,
    required this.deskripsi,
    required this.lampiran,
  });

  @override
  Widget build(BuildContext context) {
    _checkAndUpdateStatus(context); // Check and update status if needed

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar similar to PengaduanScreen
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF060A47),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'Detail Kehilangan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReadOnlyTextField(label: 'Id Kehilangan', text: id_kejadian),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'Nama Barang', text: nama_barang),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'User', text: nama),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'Tanggal', text: tanggal),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'Status', text: nama_status_kehilangan),
                    const SizedBox(height: 16),
                    _buildReadOnlyTextField(label: 'Lokasi', text: lokasi),
                    const SizedBox(height: 16),
                    TextField(
                      controller: TextEditingController(text: deskripsi),
                      enabled: false,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: lampiran.isNotEmpty
                          ? Image.network(
                        '$baseUrl/Back-end/foto-kehilangan/$lampiran',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Text('Image not available'));
                        },
                      )
                          : const Center(child: Text('No attachment available')),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: _buildActionButtons(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyTextField({required String label, required String text}) {
    return TextField(
      controller: TextEditingController(text: text),
      enabled: false,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  List<Widget> _buildActionButtons(BuildContext context) {
    if (nama_status_kehilangan == 'Diajukan') {
      return [
        TextButton(
          onPressed: () {
            _updateStatus(context, id_kejadian, 'terima');
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text('Konfirmasi'),
        ),
      ];
    } else {
      return [
        TextButton(
          onPressed: () {
            _updateStatus(context, id_kejadian, 'delete');
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text('Hapus'),
        ),
      ];
    }
  }

  void _checkAndUpdateStatus(BuildContext context) async {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final DateTime currentDate = DateTime.now();
    final DateTime incidentDate = dateFormat.parse(tanggal);

    final differenceInDays = currentDate.difference(incidentDate).inDays;

    if (differenceInDays >= 90 && nama_status_kehilangan != "Hilang") {
      await _updateStatus(context, id_kejadian, 'hilang');
    }
  }

  Future<void> _updateStatus(BuildContext context, String idKejadian, String action) async {
    final response = await http.post(
      kehilanganUrl, // Replace with the actual API endpoint
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        'id_kejadian': idKejadian,
        'action': action,
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['status'] == 'success') {
        String statusText = (action == 'terima')
            ? "Belum Ditemukan"
            : action == 'hilang' ? "Hilang" : "Dihapus";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status berhasil diperbarui ke $statusText')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui status')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan')),
      );
    }
  }
}
// ------------------------------------------------------------------


// ----------------------------PROFILE--------------------------------
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isEditing = false; // State untuk menentukan mode edit atau tidak
  String? _imageUrl;
  String? _idUser;
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchUnreadCount();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _idUser = prefs.getString('id_user'); // Ambil idUser dari SharedPreferences
      _emailController.text = prefs.getString('email') ?? '';
      _namaController.text = prefs.getString('nama') ?? '';
      _passwordController.text = prefs.getString('password') ?? ''; // opsional
      final imagePath = prefs.getString('profile');
      _imageUrl = imagePath != null ? '$baseUrl$imagePath' : null;
    });
  }

  Future<void> _fetchUnreadCount() async {
    try {
      final response = await http.get(notifUrl); // Gunakan URL notifikasi

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            unreadCount = List<Map<String, dynamic>>.from(data['data'])
                .where((notif) => notif['status_notif'] == 0)
                .length;
          });
        }
      }
    } catch (e) {
      print("Error fetching unread notifications: $e");
    }
  }

  Future<void> editProfile({
    required String idUser,
    required String nama,
    required String email,
    String? password, // Password bersifat opsional
  }) async {
    final Uri url = profileUrl; // Ganti dengan URL API Anda

    final Map<String, dynamic> data = {
      'id_user': idUser,
      'nama': nama,
      'email': email,
      'password': password ?? '', // Kirimkan string kosong jika password tidak diedit
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success'] == true) {
          print("Profil berhasil diperbarui.");

          // Simpan data terbaru ke SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('nama', nama);
          await prefs.setString('email', email);
          if (password != null) {
            await prefs.setString('password', password); // Jika password diedit
          }

          // Perbarui state agar UI langsung menampilkan data terbaru
          setState(() {
            _namaController.text = nama;
            _emailController.text = email;
            if (password != null) {
              _passwordController.text = password;
            }
          });
        } else {
          print("Gagal memperbarui profil: ${responseBody['message']}");
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _namaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildProfileField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          enabled: _isEditing, // Aktifkan edit hanya jika dalam mode editing
          obscureText: label == "Password" ? !_isPasswordVisible : obscureText,
          decoration: InputDecoration(
            hintText: "Masukkan $label",
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: label == "Password" && _isEditing
                ? IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
                : null,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF060A47),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF060A47),
                    ),
                    onPressed: () {
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(
                                onUnreadCountChanged: (count) {
                                  setState(() {
                                    unreadCount = count;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      if (unreadCount > 0)
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      backgroundImage: _imageUrl != null
                          ? NetworkImage(_imageUrl!)
                          : null,
                      child: _imageUrl == null
                          ? const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      )
                          : null,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildProfileField("Nama", _namaController),
                          const SizedBox(height: 20),
                          _buildProfileField("Email", _emailController),
                          const SizedBox(height: 20),
                          _buildProfileField("Password", _passwordController, obscureText: true),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_idUser == null) {
                            print("ID user tidak ditemukan. Harap login kembali.");
                            return;
                          }

                          if (_isEditing) {
                            // Kirim data yang sudah diedit ke API
                            await editProfile(
                              idUser: _idUser ?? '',
                              nama: _namaController.text,
                              email: _emailController.text,
                              password: _passwordController.text.isNotEmpty ? _passwordController.text : null, // Hanya kirim password jika ada
                            );

                            setState(() {
                              _isEditing = false; // Nonaktifkan mode edit setelah simpan
                            });
                          } else {
                            setState(() {
                              _isEditing = true; // Aktifkan mode edit
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isEditing ? Colors.green : Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          _isEditing ? "Simpan" : "Edit",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Logika logout
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Login()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(231, 217, 37, 13),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// -------------------------------------------------------------------


// ----------------------------NOTIFIKASI--------------------------------
class NotificationScreen extends StatefulWidget {
  final ValueChanged<int> onUnreadCountChanged; // Callback untuk mengirim jumlah belum dibaca

  const NotificationScreen({Key? key, required this.onUnreadCountChanged})
      : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String filter = 'Semua';
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  int unreadCount = 0;

  Future<void> fetchNotifications() async {
    try {
      final response = await http.get(notifUrl);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            notifications = List<Map<String, dynamic>>.from(data['data']);
            // Hitung jumlah notifikasi belum dibaca
            unreadCount = notifications
                .where((notif) => notif['status_notif'] == 0)
                .length;

            widget.onUnreadCountChanged(unreadCount);
          });
        } else {
          print('Error fetching notifications: ${data['message']}');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  Future<bool> updateNotificationStatus(int id) async {
    try {
      final response = await http.post(
        notifUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );

      final responseBody = jsonDecode(response.body);
      print('Response body: ${response.body}');

      if (response.statusCode == 200 && responseBody['success'] == true) {
        return true;
      } else {
        print('Error: ${responseBody['message']}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  List<Map<String, dynamic>> getFilteredNotifications() {
    if (filter == 'Semua') {
      return notifications;
    } else {
      return notifications.where((notif) => notif['category'] == filter)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(color: Colors.white), // Warna teks putih
        ),
        backgroundColor: const Color(0xFF060A47),
        iconTheme: const IconThemeData(
            color: Colors.white), // Warna ikon back putih
      ),
      body: Column(
        children: [
          // Filter kategori
          Padding(
            padding: const EdgeInsets.all(8.0),
            // Tambahkan padding untuk seluruh filter
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'Semua',
                  'Laporan Pengaduan',
                  'Laporan Kehilangan',
                  'Ulasan'
                ]
                    .map(
                      (category) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        // Tambahkan jarak antar kategori
                        child: ChoiceChip(
                          label: Text(category),
                          selected: filter == category,
                          onSelected: (bool selected) {
                            setState(() {
                              filter = category;
                            });
                          },
                        ),
                      ),
                )
                    .toList(),
              ),
            ),
          ),
          // Daftar notifikasi
          Expanded(
            child: ListView.builder(
              itemCount: getFilteredNotifications().length,
              itemBuilder: (context, index) {
                var notif = getFilteredNotifications()[index];
                bool isUnread = notif['status_notif'] == 0;

                return Card(
                  color: isUnread ? Colors.lightBlue.shade50 : Colors.white,
                  // Warna background berbeda
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isUnread ? Colors.blue : Colors.grey,
                      child: Text(
                        notif['category'] == 'Ulasan'
                            ? notif['nama_user'][0] // Huruf pertama nama user
                            : notif['title'][0], // Huruf pertama judul
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      notif['category'] == 'Laporan Kehilangan'
                      ? notif['nama_barang'] // Nama barang untuk kategori Kehilangan
                          : (notif['category'] == 'Ulasan'
                      ? notif['nama_user'] // Nama user untuk kategori Ulasan
                          : notif['title']), // Judul untuk kategori lainnya
                      style: TextStyle(
                      fontWeight: isUnread ? FontWeight.bold : FontWeight.normal, // Bold jika belum terbaca
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${notif['time']} - ${notif['category']}'),
                        if (notif['category'] == 'Ulasan' &&
                            notif['rating'] != 0)
                          Row(
                            children: List.generate(5, (starIndex) {
                              return Icon(
                                starIndex < (notif['rating'] ?? 0)
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 16,
                              );
                            }),
                          ),
                      ],
                    ),
                    onTap: () async {
                      try {
                        final success = await updateNotificationStatus(notif['id']);
                        if (success) {
                          setState(() {
                            if (notif['status_notif'] == 0) {
                              unreadCount -= 1; // Kurangi jumlah notifikasi belum dibaca
                            }
                            notif['status_notif'] = 1; // Perbarui status notifikasi
                          });

                          // Navigasi ke screen berdasarkan kategori
                          if (notif['category'] == 'Ulasan') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RatingScreen()), // Ganti dengan screen Ulasan Anda
                            );
                          } else if (notif['category'] == 'Laporan Pengaduan') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPengaduanPage(
                                  id_kejadian: notif['id'].toString(),
                                  judul: notif['title'],
                                  nama: notif['nama_user'],
                                  tanggal: notif['tanggal'],
                                  nama_jenis_pengaduan: notif['jenis_pengaduan'],
                                  nama_status_pengaduan: notif['status_pengaduan'],
                                  lokasi: notif['location'],
                                  nama_instansi: notif['instansi'],
                                  deskripsi: notif['description'],
                                  lampiran: notif['lampiran'],
                                ),
                              ), // Ganti dengan screen Laporan Pengaduan Anda
                            );
                          } else if (notif['category'] == 'Laporan Kehilangan') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailKehilanganPage(
                                  id_kejadian: notif['id'].toString(),
                                  nama: notif['nama_user'],
                                  nama_barang: notif['nama_barang'],
                                  tanggal: notif['tanggal'],
                                  nama_status_kehilangan: notif['status_kehilangan'],
                                  lokasi: notif['location'],
                                  deskripsi: notif['description'],
                                  lampiran: notif['lampiran'],
                                ),
                              ), // Ganti dengan screen Laporan Kehilangan Anda
                            );
                          } else {
                            // Kategori default (jika diperlukan)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Kategori tidak dikenali")),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Gagal memperbarui status notifikasi")),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Terjadi kesalahan, coba lagi")),
                        );
                      }
                    },
                    isThreeLine: true,
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

// ---------------------------------------------------------------------