import 'package:flutter/material.dart';

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

class Login extends StatelessWidget {
  const Login({super.key});

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
            Padding(padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 4
                    ),
                    child: Text(
                      'Selamat Datang Di Platform Aspirasi Dan Rating Akademik',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'
                      ),
                    ),
                  ),
                  Container (
                    margin: const EdgeInsets.only(top: 30),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.0))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 20)
                      ),
                    ),
                  ),
                  Container (
                    margin: const EdgeInsets.only(top: 16),
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0))
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2
                            ),
                          ),
                          contentPadding: EdgeInsets.only(left: 20)
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
                        onPressed: () {
                          // Misalkan validasi berhasil, pindah ke MyHomePage
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MyHomePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: Colors.amber[600]
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
                              fontWeight: FontWeight.w600
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
  final List<Map<String, String>> _pengaduanList = [
    {
      'title': 'Dibully sama teman',
      'date': '15/9/2024 19:00',
      'category': 'Bullying',
      'status': 'Diajukan',
      'description': 'Aku dibilang wibu sama temen-temen. Saya hanya diam...'
    },
    {
      'title': 'Dosen',
      'date': '15/9/2024 20:00',
      'category': 'Dosen',
      'status': 'Diproses',
      'description': 'Aku dibilang wibu sama temen-temen. Saya hanya diam...'
    },
    {
      'title': 'Akademik',
      'date': '15/9/2024 20:00',
      'category': 'Akademik',
      'status': 'Ditolak',
      'description': 'Aku dibilang wibu sama temen-temen. Saya hanya diam...'
    },
    {
      'title': 'Fasilitas',
      'date': '15/9/2024 20:00',
      'category': 'Fasilitas',
      'status': 'Selesai',
      'description': 'Aku dibilang wibu sama temen-temen. Saya hanya diam...'
    },
    {
      'title': 'Pelecehan Seksual',
      'date': '15/9/2024 20:00',
      'category': 'Pelecehan Seksual',
      'status': 'Dibatalkan',
      'description': 'Aku dibilang wibu sama temen-temen. Saya hanya diam...'
    },
    // Tambahkan lebih banyak data dummy atau real di sini
  ];

  List<Map<String, String>> _filteredPengaduanList = [];
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredPengaduanList = _pengaduanList;
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
          .where((item) => item['title']!.toLowerCase().contains(newQuery.toLowerCase()))
          .toList();
    });
  }

  void _filterByStatus(String status) {
    setState(() {
      if (status == 'Semua') {
        _filteredPengaduanList = _pengaduanList;
      } else {
        _filteredPengaduanList = _pengaduanList
            .where((item) => item['status'] == status)
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LastUpdateRow(
                    lastUpdateDate: _filteredPengaduanList.isNotEmpty
                        ? _filteredPengaduanList.first['date'] ?? 'Tanggal tidak tersedia'
                        : 'Tanggal tidak tersedia',
                  ),
                  const SizedBox(height: 10),
                  TabBarContainerPengaduan(onStatusChanged: _filterByStatus),
                  Expanded(
                    child: PengaduanList(
                      pengaduanList: _filteredPengaduanList),
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

  const PengaduanAppBar({
    super.key,
    required this.isSearching,
    required this.searchQuery,
    required this.onSearchStart,
    required this.onSearchStop,
    required this.onSearchQueryChanged,
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
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.white, size: 25,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotificationScreen()),
                        );
                      },
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
    return ListView.builder(
      itemCount: pengaduanList.length,
      itemBuilder: (context, index) {
        final pengaduan = pengaduanList[index];
        return PengaduanCard(
          title: pengaduan['title'] ?? '',
          date: pengaduan['date'] ?? '',
          category: pengaduan['category'] ?? '',
          status: pengaduan['status'] ?? '',
          description: pengaduan['description'] ?? '',
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
  final String title;
  final String date;
  final String category;
  final String status;
  final String description;

  const PengaduanCard({
    super.key,
    required this.title,
    required this.date,
    required this.category,
    required this.status,
    required this.description,
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
              title: title,
              date: date,
              category: category,
              status: status,
              description: description,
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
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date,
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
                      category,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor(status), // Memanggil fungsi untuk menentukan warna background
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Deskripsi : $description',
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
        return Colors.orange.withOpacity(1);
      default:
        return Colors.grey.withOpacity(1);
    }
  }
}

class DetailPengaduanPage extends StatelessWidget {
  final String title;
  final String date;
  final String category;
  final String status;
  final String description;

  const DetailPengaduanPage({
    super.key,
    required this.title,
    required this.date,
    required this.category,
    required this.status,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
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
                      'Detail Pengaduan',
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReadOnlyTextField(label: 'Judul', text: title),
                  const SizedBox(height: 16),
                  _buildReadOnlyTextField(label: 'Tanggal', text: date),
                  const SizedBox(height: 16),
                  _buildReadOnlyTextField(label: 'Kategori', text: category),
                  const SizedBox(height: 16),
                  _buildReadOnlyTextField(label: 'Status', text: status),
                  const SizedBox(height: 16),
                  TextField(
                    controller: TextEditingController(text: description),
                    enabled: false,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi',
                      border: OutlineInputBorder(),
                    ),
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
    );
  }

  // Membuat TextField yang hanya bisa dilihat (read-only)
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

  // Membuat tombol aksi berdasarkan status pengaduan
  List<Widget> _buildActionButtons(BuildContext context) {
    if (status == 'Diajukan') {
      return [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red, // Red background
            foregroundColor: Colors.white, // White text
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: () {
            _showConfirmationDialog(
              context,
              title: "Konfirmasi",
              content: "Apakah Anda yakin ingin menolak pengaduan ini?",
              onConfirm: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.pop(context); // Kembali ke halaman sebelumnya
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pengaduan berhasil ditolak')),
                );
              },
            );
          },
          child: const Text('Tolak'),
        ),
        const SizedBox(width: 10),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green, // Green background
            foregroundColor: Colors.white, // White text
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: () {
            _showConfirmationDialog(
              context,
              title: "Konfirmasi",
              content: "Apakah Anda yakin ingin menerima pengaduan ini?",
              onConfirm: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.pop(context); // Kembali ke halaman sebelumnya
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pengaduan berhasil diterima')),
                );
              },
            );
          },
          child: const Text('Terima'),
        ),
      ];
    } else {
      return [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red, // Red background
            foregroundColor: Colors.white, // White text
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: () {
            _showConfirmationDialog(
              context,
              title: "Konfirmasi",
              content: "Apakah Anda yakin ingin menghapus pengaduan ini?",
              onConfirm: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.pop(context); // Kembali ke halaman sebelumnya
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pengaduan berhasil dihapus')),
                );
              },
            );
          },
          child: const Text('Hapus'),
        ),
      ];
    }
  }

  // Menampilkan dialog konfirmasi
  void _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: onConfirm,
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
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
  final List<Map<String, String>> _serviceList = [
    {
      'name': 'Poliklinik',
      'email': 'PIC@gmail.com',
      'rating': '4',
      'reviews': '273',
      'imageUrl': 'images/poliklinik_image.png',
    },
    {
      'name': 'Radiologi',
      'email': 'PIC@gmail.com',
      'rating': '4',
      'reviews': '273',
      'imageUrl': 'images/poliklinik_image.png',
    },
    {
      'name': 'Makanan',
      'email': 'PIC@gmail.com',
      'rating': '4',
      'reviews': '273',
      'imageUrl': 'images/poliklinik_image.png',
    },
    // Add more services as needed
  ];

  List<Map<String, String>> _filteredServiceList = [];
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredServiceList = _serviceList;
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: ListView.builder(
                itemCount: _filteredServiceList.length,
                itemBuilder: (context, index) {
                  final service = _filteredServiceList[index];
                  return ServiceCard(
                    name: service['name']!,
                    email: service['email']!,
                    rating: int.parse(service['rating']!),
                    reviews: int.parse(service['reviews']!),
                    imageUrl: service['imageUrl']!,
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

  const RatingAppBar({
    super.key,
    required this.isSearching,
    required this.searchQuery,
    required this.onSearchStart,
    required this.onSearchStop,
    required this.onSearchQueryChanged,
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
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.white, size: 25),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotificationScreen()),
                        );
                      },
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
  final String name;
  final String email;
  final int rating;
  final int reviews;
  final String imageUrl;

  const ServiceCard({
    super.key,
    required this.name,
    required this.email,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
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
                'name': name,
                'email': email,
                'rating': rating.toString(),
                'reviews': reviews.toString(),
                'imageUrl': imageUrl,
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
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '$rating/5',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.orange,
                            size: 20,
                          );
                        }),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$reviews Reviews',
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
  final Map<String, String> service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  // ignore: library_private_types_in_public_api
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  String selectedSort = 'Terbaru'; // Default sort
  List<Map<String, dynamic>> reviews = [
    {
      'name': 'Melia Apriani',
      'date': DateTime(2023, 4, 15),
      'content': 'Ac nya dingin beuttt...serasa di kutub mungkin lain kali bisa diganti AC nya jadi Angin Cepoi Cepoi xixixixixi',
      'rating': 5,
      'helpfulCount': 56,
      'avatar': 'images/Foto_profile.png',
    },
    {
      'name': 'Danu Alamansyah',
      'date': DateTime(2008, 10, 15),
      'content': 'Ac nya dingin beuttt...serasa di kutub mungkin lain kali bisa diganti AC nya jadi Angin Cepoi Cepoi xixixixixi',
      'rating': 5,
      'helpfulCount': 56,
      'avatar': 'images/Foto_profile.png',
    },
    {
      'name': 'Melia Apriani',
      'date': DateTime(2009, 10, 15),
      'content': 'Ac nya dingin beuttt...serasa di kutub mungkin lain kali bisa diganti AC nya jadi Angin Cepoi Cepoi xixixixixi',
      'rating': 5,
      'helpfulCount': 56,
      'avatar': 'images/Foto_profile.png',
    },
    {
      'name': 'Melia Apriani',
      'date': DateTime(2011, 10, 15),
      'content': 'Ac nya dingin beuttt...serasa di kutub mungkin lain kali bisa diganti AC nya jadi Angin Cepoi Cepoi xixixixixi',
      'rating': 5,
      'helpfulCount': 56,
      'avatar': 'images/Foto_profile.png',
    },
    // Tambahkan contoh data lainnya sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    // Sorting the reviews based on the selected sort option
    reviews.sort((a, b) {
      if (selectedSort == 'Terbaru') {
        return b['date'].compareTo(a['date']); // Sort by newest first
      } else {
        return a['date'].compareTo(b['date']); // Sort by oldest first
      }
    });

    return Scaffold(
      body: Column(
        children: [
          // Navbar atas
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
                      'Detail Review',
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
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Area yang bisa digulir di bawah navbar
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Detail layanan
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.asset(
                            widget.service['imageUrl']!,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.service['name']!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    '${widget.service['rating']}/5',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Row(
                                    children: List.generate(5, (index) {
                                      return index < int.parse(widget.service['rating']!)
                                          ? const Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.star_border,
                                              color: Colors.orange,
                                              size: 20,
                                            );
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${widget.service['reviews']} Reviews',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Dropdown untuk sorting
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton<String>(
                        value: selectedSort,
                        items: const [
                          DropdownMenuItem(
                            value: 'Terbaru',
                            child: Text('Terbaru'),
                          ),
                          DropdownMenuItem(
                            value: 'Terlama',
                            child: Text('Terlama'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedSort = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  // Daftar Review
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRatingPage(
                                review: reviews[index], // Kirim review sesuai indeks yang dipilih
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
                                      backgroundImage: AssetImage(review['avatar']),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          review['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${review['date'].day}/${review['date'].month}/${review['date'].year}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
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
                                      index < review['rating']
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.orange,
                                      size: 16,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  review['content'],
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${review['helpfulCount']} orang merasa ulasan ini berguna',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
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

  const DetailRatingPage({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    // Data yang akan ditampilkan berdasarkan review yang diterima
    final name = review['name'] as String;
    final date = review['date'] as DateTime;
    final content = review['content'] as String;
    final rating = review['rating'] as int;
    final helpfulCount = review['helpfulCount'] as int;
    final avatar = review['avatar'] as String;

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
                        backgroundImage: AssetImage(avatar),
                        radius: 30,
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
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: '$helpfulCount orang merasa ulasan ini berguna',
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah yang Menilai Bermanfaat',
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
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Review berhasil dihapus')),
                                      );
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
class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

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
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white, size: 25),
              onPressed: () {
                // Implementasikan fungsionalitas notifikasi di sini
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
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


  // Fungsi _buildActivitySection untuk bagian aktivitas
  Widget _buildActivitySection(BuildContext context) {
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
          _buildActivityCard('Pengaduan', 150, Icons.report, 1,
              context), // Menggunakan ikon baru
          const SizedBox(height: 8),
          _buildActivityCard(
              'Laporan Kehilangan', 150, Icons.search, 2, context),
          const SizedBox(height: 8),
          _buildActivityCard('Rating', 150, Icons.star, 3, context),
        ],
      ),
    );
  }

  // Fungsi untuk membuat kartu aktivitas
  Widget _buildActivityCard(String title, int jumlah, IconData icon,
      int navigationIndex, BuildContext context) {
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
  final List<String> dosenList = [
    "Dr. John Doe",
    "Prof. Jane Smith",
    "Dr. Alice Johnson",
    "Dr. Robert Brown",
    "Dr. Emily Davis",
  ];

  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = dosenList;
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
      body: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF060A47)), // Ikon dosen
            title: Text(filteredList[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DosenDetailScreen(name: filteredList[index]),
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
  final List<String> dosenList;

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
        .where((dosen) => dosen.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DosenDetailScreen(name: results[index]),
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
        .where((dosen) => dosen.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class DosenDetailScreen extends StatefulWidget {
  final String name;

  const DosenDetailScreen({super.key, required this.name});

  @override
  // ignore: library_private_types_in_public_api
  _DosenDetailScreenState createState() => _DosenDetailScreenState();
}

class _DosenDetailScreenState extends State<DosenDetailScreen> {
  late TextEditingController namaController;
  late TextEditingController nomorIndukController;
  late TextEditingController noTelpController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController roleController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Menginisialisasi controller dengan nilai default
    namaController = TextEditingController(text: widget.name);
    nomorIndukController = TextEditingController(text: "123456789");
    noTelpController = TextEditingController(text: "081234567890");
    emailController = TextEditingController(text: "dosen@example.com");
    passwordController = TextEditingController(text: "password123");
    roleController = TextEditingController(text: "Dosen");
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
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nomorIndukController,
                decoration: const InputDecoration(
                  labelText: "Nomor Induk",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: noTelpController,
                decoration: const InputDecoration(
                  labelText: "No. Telp",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(
                  labelText: "Role",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF060A47),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  // Simpan perubahan data atau lakukan aksi lainnya
                },
                child: const Text("Simpan", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// -------------------------------------------------------------------


// ----------------------------MAHASISWA--------------------------------
class MahasiswaScreen extends StatefulWidget {
  const MahasiswaScreen({super.key});

  @override
  State<MahasiswaScreen> createState() => _MahasiswaScreenState();
}

class _MahasiswaScreenState extends State<MahasiswaScreen> {
  final List<String> mahasiswaList = [
      "Davin Alifianda Adytia",
      "Melia Apriani",
      "Rizky Setiawan",
      "Dinda Putri Ananda",
      "Rizky Setiawan",
      "Dedi Kurniawan",
      "Dinda Putri Ananda",
  ];

  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = mahasiswaList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Mahasiswa"),
        backgroundColor: const Color(0xFF060A47), // Warna biru tua
        iconTheme: const IconThemeData(
          color: Colors.white, // Warna ikon back menjadi putih
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white, // Warna teks judul menjadi putih
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
      body: ListView.builder(
        itemCount: mahasiswaList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.school, color: Color(0xFF060A47)), // Ikon mahasiswa
            title: Text(mahasiswaList[index]),
            onTap: () {
              // Aksi ketika item di-tap, misal navigasi ke detail dosen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MahasiswaDetailScreen(name: mahasiswaList[index]),
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
  final List<String> mahasiswaList;

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
        .where((mahasiswa) => mahasiswa.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MahasiswaDetailScreen(name: results[index]),
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
        .where((mahasiswa) => mahasiswa.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class MahasiswaDetailScreen extends StatefulWidget {
  final String name;

  const MahasiswaDetailScreen({super.key, required this.name});

  @override
  // ignore: library_private_types_in_public_api
  _MahasiswaDetailScreenState createState() => _MahasiswaDetailScreenState();
}

class _MahasiswaDetailScreenState extends State<MahasiswaDetailScreen> {
  late TextEditingController namaController;
  late TextEditingController nomorIndukController;
  late TextEditingController noTelpController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController roleController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Menginisialisasi controller dengan nilai default
    namaController = TextEditingController(text: widget.name);
    nomorIndukController = TextEditingController(text: "987654321");
    noTelpController = TextEditingController(text: "081234567890");
    emailController = TextEditingController(text: "mahasiswa@example.com");
    passwordController = TextEditingController(text: "password123");
    roleController = TextEditingController(text: "Mahasiswa");
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
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nomorIndukController,
                decoration: const InputDecoration(
                  labelText: "Nomor Induk",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: noTelpController,
                decoration: const InputDecoration(
                  labelText: "No. Telp",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(
                  labelText: "Role",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF060A47),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  // Simpan perubahan data atau lakukan aksi lainnya
                },
                child: const Text("Simpan", style: TextStyle(color: Colors.white)),
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
  final List<String> unitLayananList = [
      "Poliklinik",
      "Biro Akademik",
      "Biro Administrasi Umum",
      "Biro Keuangan",
      "Biro Perencanaan dan Sistem Informasi",
      "Biro Umum",
      "Biro Kerjasama dan Hubungan Masyarakat",
  ];

  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = unitLayananList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Unit Layanan"),
        backgroundColor: const Color(0xFF060A47), // Warna biru tua
        iconTheme: const IconThemeData(
          color: Colors.white, // Warna ikon back menjadi putih
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white, // Warna teks judul menjadi putih
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
      body: ListView.builder(
        itemCount: unitLayananList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.business, color: Color(0xFF060A47)), // Ikon unit layanan
            title: Text(unitLayananList[index]),
            onTap: () {
              // Aksi ketika item di-tap, misal navigasi ke detail dosen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UnitLayananDetailScreen(name: unitLayananList[index]),
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
  final List<String> unitLayananList;

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
        .where((unitLayanan) => unitLayanan.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UnitLayananDetailScreen(name: results[index]),
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
        .where((unitLayanan) => unitLayanan.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class UnitLayananDetailScreen extends StatefulWidget {
  final String name;

  const UnitLayananDetailScreen({super.key, required this.name});

  @override
  // ignore: library_private_types_in_public_api
  _UnitLayananDetailScreenState createState() => _UnitLayananDetailScreenState();
}

class _UnitLayananDetailScreenState extends State<UnitLayananDetailScreen> {
  late TextEditingController namaController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    // Menginisialisasi controller dengan nilai default
    namaController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: "pic@example.com");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Unit Layanan"),
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
              const Icon(Icons.business, size: 100, color: Color(0xFF060A47)),
              const SizedBox(height: 20),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Unit Layanan",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF060A47),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  // Simpan perubahan data atau lakukan aksi lainnya
                },
                child: const Text("Simpan", style: TextStyle(color: Colors.white)),
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
  final List<String> jenisPengaduanList = [
      "Pelecehan Seksual",
      "Bullying",
      "Dosen",
      "Fasilitas",
      "Akademik",
  ];
  
  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = jenisPengaduanList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Jenis Pengaduan"),
        backgroundColor: const Color(0xFF060A47), // Warna biru tua
        iconTheme: const IconThemeData(
          color: Colors.white, // Warna ikon back menjadi putih
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white, // Warna teks judul menjadi putih
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
      body: ListView.builder(
        itemCount: jenisPengaduanList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.category, color: Color(0xFF060A47)), // Ikon jenis pengaduan
            title: Text(jenisPengaduanList[index]),
            onTap: () {
              // Aksi ketika item di-tap, misal navigasi ke detail dosen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JenisPengaduanDetailScreen(name: jenisPengaduanList[index]),
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
  final List<String> jenisPengaduanList;

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
        .where((jenisPengaduan) => jenisPengaduan.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JenisPengaduanDetailScreen(name: results[index]),
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
        .where((jenisPengaduan) => jenisPengaduan.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class JenisPengaduanDetailScreen extends StatefulWidget {
  final String name;

  const JenisPengaduanDetailScreen({super.key, required this.name});

  @override
  // ignore: library_private_types_in_public_api
  _JenisPengaduanDetailScreenState createState() => _JenisPengaduanDetailScreenState();
}

class _JenisPengaduanDetailScreenState extends State<JenisPengaduanDetailScreen> {
  late TextEditingController namaController;

  @override
  void initState() {
    super.initState();
    // Menginisialisasi controller dengan nilai default
    namaController = TextEditingController(text: widget.name);
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
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Unit Layanan",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF060A47),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  // Simpan perubahan data atau lakukan aksi lainnya
                },
                child: const Text("Simpan", style: TextStyle(color: Colors.white)),
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
  final _kehilanganList = [
    {
      'title': 'Hp Samsung Hilang',
      'date': '15/9/2024 19:00',
      'jenisBarang': 'Elektronik',
      'status': 'Belum Ditemukan',
      'description': 'Hp Samsung Galaxy A50 warna hitam hilang di kantin.',
    },
    {
      'title': 'Dompet Hilang',
      'date': '15/9/2024 19:00',
      'jenisBarang': 'Dompet',
      'status': 'Ditemukan',
      'description': 'Dompet warna coklat, berisi KTP dan uang 50 ribu.',
    },
    {
      'title': 'Kunci Motor Hilang',
      'date': '15/9/2024 19:00',
      'jenisBarang': 'Kunci',
      'status': 'Hilang',
      'description': 'Kunci motor Honda Beat warna hitam hilang di parkiran.',
    },
    {
      'title': 'Tas Laptop Hilang',
      'date': '15/9/2024 19:00',
      'jenisBarang': 'Tas',
      'status': 'Belum Ditemukan',
      'description': 'Tas laptop warna hitam hilang di perpustakaan.',
    },
    {
      'title': 'Buku Hilang',
      'date': '15/9/2024 19:00',
      'jenisBarang': 'Buku',
      'status': 'Ditemukan',
      'description': 'Buku berjudul "Pemrograman Flutter" hilang di ruang kuliah.',
    },
  ];

  List<Map<String, String>> _filteredKehilanganList = [];
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredKehilanganList = _kehilanganList;
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
        .where((item) => item['title']!.toLowerCase().contains(newQuery.toLowerCase()))
        .toList();
    });
  }

  void _filterByStatus(String status) {
    setState(() {
      if (status == 'Semua') {
        _filteredKehilanganList = _kehilanganList;
      } else {
        _filteredKehilanganList = _kehilanganList
            .where((item) => item['status'] == status)
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LastUpdateRow(
                    lastUpdateDate: _filteredKehilanganList.isNotEmpty
                        ? _filteredKehilanganList.first['date'] ?? 'Tanggal tidak tersedia'
                        : 'Tanggal tidak tersedia',  
                  ),
                  const SizedBox(height: 10), // Menambahkan sedikit jarak sebelum TabBarContainer
                  TabBarContainerKehilangan(onStatusChanged: _filterByStatus),
                  Expanded(
                    child: KehilanganList(
                      kehilanganList: _filteredKehilanganList,
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

class KehilanganAppBar extends StatelessWidget {
  final bool isSearching;
  final String searchQuery;
  final VoidCallback onSearchStart;
  final VoidCallback onSearchStop;
  final ValueChanged<String> onSearchQueryChanged;

  const KehilanganAppBar({
    super.key,
    required this.isSearching,
    required this.searchQuery,
    required this.onSearchStart,
    required this.onSearchStop,
    required this.onSearchQueryChanged,
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
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.white, size: 25,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotificationScreen()),
                        );
                      },
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
    return ListView.builder(
      itemCount: kehilanganList.length,
      itemBuilder: (context, index) {
        final kehilangan = kehilanganList[index];
        return KehilanganCard(
          title: kehilangan['title'] ?? '',
          date: kehilangan['date'] ?? '',
          jenisBarang: kehilangan['jenisBarang'] ?? '',
          status: kehilangan['status'] ?? '',
          description: kehilangan['description'] ?? '',
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
    'Hilang'
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
  final String title;
  final String date;
  final String jenisBarang;
  final String status;
  final String description;

  const KehilanganCard({
    super.key,
    required this.title,
    required this.date,
    required this.jenisBarang,
    required this.status,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman detail Kehilangan dengan data dari card
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailKehilanganPage(
              title: title,
              date: date,
              jenisBarang: jenisBarang,
              status: status,
              description: description,
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
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date,
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
                      jenisBarang,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor(status), // Memanggil fungsi untuk menentukan warna background
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Deskripsi : $description',
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
        return Colors.grey.withOpacity(1);
      case 'Ditemukan':
        return Colors.green.withOpacity(1);
      case 'Hilang':
        return Colors.red.withOpacity(1);
      default:
        return Colors.grey.withOpacity(1);
    }
  }
}

class DetailKehilanganPage extends StatelessWidget {
  final String title;
  final String date;
  final String jenisBarang;
  final String status;
  final String description;

  const DetailKehilanganPage({
    super.key,
    required this.title,
    required this.date,
    required this.jenisBarang,
    required this.status,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
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
                      'Detail Kehilangan',
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReadOnlyTextField(label: 'Judul', text: title),
                  const SizedBox(height: 16),
                  _buildReadOnlyTextField(label: 'Tanggal', text: date),
                  const SizedBox(height: 16),
                  _buildReadOnlyTextField(label: 'Jenis Barang', text: jenisBarang),
                  const SizedBox(height: 16),
                  _buildReadOnlyTextField(label: 'Status', text: status),
                  const SizedBox(height: 16),
                  TextField(
                    controller: TextEditingController(text: description),
                    enabled: false,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi',
                      border: OutlineInputBorder(),
                    ),
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
    );
  }

  // Membuat TextField yang hanya bisa dilihat (read-only)
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

  // Membuat tombol aksi berdasarkan status pengaduan
  List<Widget> _buildActionButtons(BuildContext context) {
    return [
      TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.red, // Red background
          foregroundColor: Colors.white, // White text
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        onPressed: () {
          _showConfirmationDialog(
            context,
            title: "Konfirmasi",
            content: "Apakah Anda yakin ingin menghapus kehilangan ini?",
            onConfirm: () {
              Navigator.of(context).pop(); // Tutup dialog
              Navigator.pop(context); // Kembali ke halaman sebelumnya
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kehilangan berhasil dihapus')),
              );
            },
          );
        },
        child: const Text('Hapus'),
      ),
    ]; 
  }

  // Menampilkan dialog konfirmasi
  void _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: onConfirm,
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
  }
}
// ------------------------------------------------------------------


// ----------------------------PROFILE--------------------------------
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Controllers to get the input values
  final TextEditingController _emailController = TextEditingController();

  bool _isPasswordVisible = false; // State to control password visibility
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textField = TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: "Masukkan email",
      ),
    );
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
                  // Icon Back di sebelah kiri
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  // Expanded untuk menempatkan teks di tengah
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
                  // Icon Notification di sebelah kanan
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Implement notifications functionality here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              // Makes the content scrollable
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // Aksi untuk ubah avatar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Ubah Avatar ditekan!")),
                        );
                      },
                      child: const Text(
                        "Ubah Avatar",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ),
                          const SizedBox(height: 5),
                          textField,
                          const Divider(),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "No Telp",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              hintText: "Masukkan nomor telepon",
                            ),
                          ),
                          const Divider(),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: _passwordController,
                            obscureText:
                                !_isPasswordVisible, // Toggle password visibility
                            decoration: InputDecoration(
                              hintText: "Masukkan password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20), // Space before the logout button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Misalkan validasi berhasil, pindah ke MyHomePage
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
                            color: Colors.white, // Warna teks putih
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
  const NotificationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String filter = 'Semua';

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Notifikasi'),
          content:
              const Text('Apakah Anda yakin ingin menghapus notifikasi ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Hapus', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
                // Logika penghapusan notifikasi di sini
              },
            ),
          ],
        );
      },
    );
  }

  // ignore: unused_element
  void _showActionConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Aksi'),
          content: const Text('Apakah Anda yakin?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ya', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
                // Logika aksi di sini
              },
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> notifications = [
    {
      'title': 'Kamar mandi Kotor',
      'category': 'Pengaduan',
      'time': '2h ago',
      'description': 'Pengaduan',
    },
    {
      'title': 'Admin PBM Judes',
      'category': 'Pengaduan',
      'time': '2h ago',
      'description': 'Pengaduan',
    },
    {
      'title': 'Dosen suka bolos',
      'category': 'Pengaduan',
      'time': '2h ago',
      'description': 'Pengaduan',
    },
    {
      'title': 'Poliklinik',
      'category': 'Rating',
      'time': '2h ago',
      'description': 'Rating',
      'rating': 4 // Rating dari 5
    },
    {
      'title': 'Pacar ku Hilang',
      'category': 'Kehilangan',
      'time': '2h ago',
      'description': 'Kehilangan',
    },
  ];

  List<Map<String, dynamic>> getFilteredNotifications() {
    if (filter == 'Semua') {
      return notifications;
    } else {
      return notifications
          .where((notif) => notif['category'] == filter)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF060A47),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Semua', 'Pengaduan', 'Kehilangan', 'Rating']
                  .map((category) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: filter == category,
                          onSelected: (bool selected) {
                            setState(() {
                              filter = category;
                            });
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: getFilteredNotifications().length,
              itemBuilder: (context, index) {
                var notif = getFilteredNotifications()[index];
                return Card(
                    child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      notif['title'][0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(notif['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${notif['time']} - ${notif['category']}'),
                      if (notif['category'] == 'Rating')
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < notif['rating']
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            );
                          }),
                        ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => _showDeleteConfirmation(context),
                  ),
                  onTap: () {
                    // Navigasi ke halaman detail sesuai kategori
                    // Contoh: Navigator.pushNamed(context, '/detail_pengaduan');
                    if (notif['title'] == 'Poliklinik' &&
                        notif['category'] == 'Rating') {
                      // Buat instance Service dengan data yang relevan untuk navigasi

                      // Navigasi ke halaman detail Service
                    }
                    // Navigasi ke halaman detail lain sesuai kategori (jika diperlukan)
                    // Contoh:
                    // else if (notif['category'] == 'Pengaduan') { ... }
                  },
                  isThreeLine: true,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
// ---------------------------------------------------------------------