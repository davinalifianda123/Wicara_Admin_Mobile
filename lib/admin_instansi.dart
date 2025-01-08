import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

// variabel api url
const String baseUrl = 'https://6135-66-96-225-100.ngrok-free.app/Wicara/Wicara_Admin_Web';
final loginUrl = Uri.parse('$baseUrl/api/api_login_instansi.php');
final berandaUrl = Uri.parse('$baseUrl/api/api_beranda.php');
final pengaduanUrl = Uri.parse('$baseUrl/api/api_pengaduan.php');
final profileUrl = Uri.parse('$baseUrl/api/api_profile_instansi.php');
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
      home: const MyHomePageAdminInstansi(),
    );
  }
}

class MyHomePageAdminInstansi extends StatefulWidget {
  const MyHomePageAdminInstansi({super.key});

  @override
  State<MyHomePageAdminInstansi> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageAdminInstansi> {
  int _currentIndex = 0; // Default tampilan awal di Beranda

  final List<Widget> _screens = [
    const BerandaScreen(),
    const PengaduanScreen(),
    const ProfileScreen()
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
              const AssetImage("images/Profile.png"),
              color: _currentIndex == 2 ? const Color(0xFF060A47) : Colors.grey,
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
          // Filter hanya status dengan nilai 3 atau 4
          _pengaduanList = List<Map<String, String>>.from(
            data
                .where((item) =>
            (item['status_pengaduan'] == '3' || item['status_pengaduan'] == '5'))
                .map((item) => {
              'id_kejadian': (item['id_kejadian'] ?? '').toString(),
              'judul': (item['judul'] ?? 'Judul tidak tersedia').toString(),
              'nama': (item['nama'] ?? 'Nama tidak tersedia').toString(),
              'tanggal': (item['tanggal'] ?? 'Tanggal tidak tersedia').toString(),
              'nama_jenis_pengaduan': (item['nama_jenis_pengaduan'] ?? 'Jenis tidak tersedia').toString(),
              'nama_status_pengaduan': (item['nama_status_pengaduan'] ?? 'Status tidak tersedia').toString(),
              'lokasi': (item['lokasi'] ?? 'Lokasi tidak tersedia').toString(),
              'nama_instansi': (item['nama_instansi'] ?? 'Instansi tidak tersedia').toString(),
              'deskripsi': (item['deskripsi'] ?? 'Deskripsi tidak tersedia').toString(),
              'lampiran': (item['lampiran'] ?? 'Lampiran tidak tersedia').toString(),
            }),
          );

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
                        ? const Center(child: CircularProgressIndicator()) // Show progress indicator while loading
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
    'Diproses',
    'Selesai',
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
    if (nama_status_pengaduan == 'Diproses') {
      return [
        TextButton(
          onPressed: () {
            _updateStatus(context, id_kejadian, 'selesai'); // For "Selesai"
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,  // Background color for "Selesai"
            foregroundColor: Colors.white,  // Text color
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),  // Padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),  // Rounded corners
            ),
          ),
          child: const Text('Selesai'),
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
        String statusText = (action == 'selesai')
            ? "Selesai"
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

// ----------------------------BERANDA--------------------------------
class BerandaService {
  static Future<Map<String, int>> fetchActivityData() async {
    try {
      final response = await http.get(berandaUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          "pengaduan": data["pengaduan"] ?? 0,
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
  const BerandaScreen({super.key});

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
                const SizedBox(height: 16),
                const Text(
                  'Aktivitas yang perlu ditangani',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildActivityCard('Pengaduan', data["pengaduanInstansi"] ?? 0, Icons.report, 1, context),
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


// ----------------------------PROFILE--------------------------------
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailPicController = TextEditingController();
  final TextEditingController _namaInstansiController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isEditing = false; // State untuk menentukan mode edit atau tidak
  String? _imageUrl;
  String? _idInstansi;
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _loadInstansiData();
    _fetchUnreadCount();
  }

  Future<void> _loadInstansiData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _idInstansi = prefs.getString('id_instansi'); // Ambil idUser dari SharedPreferences
      _emailPicController.text = prefs.getString('email_pic') ?? '';
      _namaInstansiController.text = prefs.getString('nama_instansi') ?? '';
      _passwordController.text = prefs.getString('password') ?? ''; // opsional
      final imagePath = prefs.getString('gambar_instansi');
      _imageUrl = imagePath != null ? '$baseUrl/../Wicara_User_Web/assets/images/instansi/$imagePath' : null;
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

  Future<void> editInstansiProfile({
    required String idInstansi,
    required String namaInstansi,
    required String emailPic,
    String? password, // Password bersifat opsional
  }) async {
    final Uri url = profileUrl; // Ganti dengan URL API Anda

    final Map<String, dynamic> data = {
      'id_instansi': idInstansi,
      'nama_instansi': namaInstansi,
      'email_pic': emailPic,
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
          await prefs.setString('nama_instansi', namaInstansi);
          await prefs.setString('email_pic', emailPic);
          if (password != null) {
            await prefs.setString('password', password); // Jika password diedit
          }

          // Perbarui state agar UI langsung menampilkan data terbaru
          setState(() {
            _namaInstansiController.text = namaInstansi;
            _emailPicController.text = emailPic;
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
    _emailPicController.dispose();
    _namaInstansiController.dispose();
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
                          : null, // Jika _imageUrl null, tidak ada gambar
                      child: _imageUrl == null
                          ? const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      )
                          : null, // Menampilkan ikon jika _imageUrl null
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
                          _buildProfileField("Nama Instansi", _namaInstansiController),
                          const SizedBox(height: 20),
                          _buildProfileField("Email", _emailPicController),
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
                          if (_idInstansi == null) {
                            print("ID user tidak ditemukan. Harap login kembali.");
                            return;
                          }

                          if (_isEditing) {
                            // Kirim data yang sudah diedit ke API
                            await editInstansiProfile(
                              idInstansi: _idInstansi ?? '',
                              namaInstansi: _namaInstansiController.text,
                              emailPic: _emailPicController.text,
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

  const NotificationScreen({super.key, required this.onUnreadCountChanged});

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
            // Filter notifikasi dengan status_pengaduan 3 atau 5
            notifications = List<Map<String, dynamic>>.from(data['data'])
                .where((notif) => notif['status_pengaduan'] == 'Diproses' || notif['status_pengaduan'] == 'Selesai')
                .toList();

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
                          if (notif['category'] == 'Laporan Pengaduan') {
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