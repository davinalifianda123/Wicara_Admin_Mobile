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
      home: const MyHomePage(),
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

class PengaduanScreen extends StatelessWidget {
  const PengaduanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Ini adalah navbar atas
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF060A47),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Kurangi padding vertikal untuk mengurangi tinggi
            child: SafeArea(
              child: Row(
                children: [
                  // Icon Search di sebelah kiri
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Implement search functionality here
                    },
                  ),
                  // Expanded untuk menempatkan teks di tengah
                  const Expanded(
                    child: Text(
                      'Pengaduan',
                      textAlign: TextAlign.center, // Pastikan teks berada di tengah
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
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Mengurangi padding untuk lebih mendekatkan konten dengan navbar atas
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/Kalender.png',
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Terakhir Update : 1 September 2024',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Menambahkan sedikit jarak sebelum TabBarContainer
                  const TabBarContainerPengaduan(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5, // Misalnya ada 3 pengaduan
                      itemBuilder: (context, index) {
                        return const PengaduanCard();
                      },
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

class TabBarContainerPengaduan extends StatelessWidget {
  const TabBarContainerPengaduan({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Jumlah tab
      child: Column(
        children: [
          Container(
            color: Colors.grey[200],
            child: const TabBar(
              labelColor: Colors.orange, // Warna teks saat dipilih
              unselectedLabelColor: Colors.grey, // Warna teks saat tidak dipilih
              indicatorColor: Colors.orange, // Warna garis bawah saat dipilih
              indicatorWeight: 2.0, // Ketebalan garis bawah
              tabs: [
                Tab(text: 'Semua'),
                Tab(text: 'Diajukan'),
                Tab(text: 'Diproses'),
                Tab(text: 'Selesai'),
              ],
            ),
          ),
          // Content bisa diisi jika ingin memiliki konten berdasarkan tab
          // Expanded(
          //   child: TabBarView(
          //     children: [
          //       Container(), // Konten untuk "Semua"
          //       Container(), // Konten untuk "Diajukan"
          //       Container(), // Konten untuk "Diproses"
          //       Container(), // Konten untuk "Selesai"
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}


class PengaduanCard extends StatelessWidget {
  const PengaduanCard({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman detail pengaduan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailPengaduanPage(),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dibully sama teman',
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '15/9/2024 20:00',
                          style: TextStyle(
                            fontSize: 12, 
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Bullying',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2), // Gray background color
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Diajukan',
                      style: TextStyle(color: Colors.grey), // White text color
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Deskripsi : Aku dibilang wibu sama temen-temen. Saya hanya diam...',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPengaduanPage extends StatelessWidget {
  const DetailPengaduanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data default yang akan ditampilkan
    final idController = TextEditingController(text: 'A0056');
    final userController = TextEditingController(text: 'Miaauw@polines.ac.id');
    final instansiController = TextEditingController(text: 'Poliklinik');
    final ratingController = TextEditingController(text: '5');
    final tanggalController = TextEditingController(text: '01-09-2024');
    final deskripsiController = TextEditingController(
      text:
          'Kepada warga solinep, tolong laptop sya hilang disekitaran mdh. Bentuknya kayak digambar. Yang menemukan saya doakan masuk surga. Bisa hubungi ini ya : 098726177228819',
    );

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  TextField(
                    controller: idController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: userController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'User',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: instansiController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Instansi',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: ratingController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Skala Bintang',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: tanggalController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: deskripsiController, // Menggunakan controller
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
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red, // Red background
                          foregroundColor: Colors.white, // White text
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        onPressed: () {
                          // Tampilkan dialog konfirmasi
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Konfirmasi"),
                                content: const Text("Apakah Anda yakin ingin menolak pengaduan ini?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Tutup dialog
                                    },
                                    child: const Text("Batal"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Logika penghapusan review
                                      Navigator.of(context).pop(); // Tutup dialog
                                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Pengaduan berhasil ditolak')),
                                      );
                                    },
                                    child: const Text("Tolak"),
                                  ),
                                ],
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
                          // Aksi konfirmasi
                        },
                        child: const Text('Konfirmasi'),
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


class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  final List<Service> services = const [
    Service(
      name: 'Poliklinik',
      email: 'PIC@gmail.com',
      rating: 4,
      reviews: 273,
      imageUrl: 'images/poliklinik_image.png',
    ),
    Service(
      name: 'Radiologi',
      email: 'PIC@gmail.com',
      rating: 4,
      reviews: 273,
      imageUrl: 'images/poliklinik_image.png',
    ),
    Service(
      name: 'Makanan',
      email: 'PIC@gmail.com',
      rating: 4,
      reviews: 273,
      imageUrl: 'images/poliklinik_image.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Ini adalah navbar atas
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF060A47),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Kurangi padding vertikal untuk mengurangi tinggi
            child: SafeArea(
              child: Row(
                children: [
                  // Icon Search di sebelah kiri
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Implement search functionality here
                    },
                  ),
                  // Expanded untuk menempatkan teks di tengah
                  const Expanded(
                    child: Text(
                      'Rating',
                      textAlign: TextAlign.center, // Pastikan teks berada di tengah
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
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Mengurangi padding untuk lebih mendekatkan konten dengan navbar atas
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/Kalender.png',
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Terakhir Update : 1 September 2024',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Menambahkan sedikit jarak sebelum TabBarContainer
                  Expanded(
                    child: ListView.builder(
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        return ServiceCard(service: services[index]);
                      },
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

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section with Overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  service.imageUrl,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              // Overlay Gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Service name and email inside the image overlay
              Positioned(
                left: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      service.email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Rating and Reviews Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Rating stars and reviews
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${service.rating}/5',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Row(
                          children: List.generate(5, (index) {
                            if (index < service.rating) {
                              return const Icon(
                                Icons.star,
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
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${service.reviews} Reviews',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                // Detail Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceDetailPage(service: service),
                      ),
                    );
                  },
                  child: const Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
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
}

class Service {
  final String name;
  final String email;
  final int rating;
  final int reviews;
  final String imageUrl;

  const Service({
    required this.name,
    required this.email,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });
}

class ServiceDetailPage extends StatelessWidget {
  final Service service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Kurangi padding vertikal untuk mengurangi tinggi
            child: SafeArea(
              child: Row(
                children: [
                  // Icon Search di sebelah kiri
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Implement search functionality here
                    },
                  ),
                  // Expanded untuk menempatkan teks di tengah
                  const Expanded(
                    child: Text(
                      'Detail Review',
                      textAlign: TextAlign.center, // Pastikan teks berada di tengah
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
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
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
                            service.imageUrl,
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
                                service.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Terakhir Update : 1 September 2024',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Text(
                                    '${service.rating}/5',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Row(
                                    children: List.generate(5, (index) {
                                      if (index < service.rating) {
                                        return const Icon(
                                          Icons.star,
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
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${service.reviews} Reviews',
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
                  const SizedBox(height: 16),
                  // Daftar Review
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5, // Jumlah review yang ditampilkan, bisa diubah
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRatingPage(
                                reviewId: index, // Pass any data you want to `DetailRatingPage`
                              ),
                            ),
                          );
                        }, // Optional: hover color effect
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
                                const Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                        'images/avatar_placeholder.png',
                                      ), // Ganti dengan gambar avatar
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Melia Apriani', // Nama pengguna
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '15/04/23', // Tanggal ulasan
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: List.generate(5, (index) {
                                    return const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 16,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Ac nya dingin beuttt...serasa di kutub mungkin lain kali bisa diganti AC nya jadi Angin Cepoi Cepoi xixixixixi',
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '56 orang merasa ulasan ini berguna',
                                      style: TextStyle(
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
                  )
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
  const DetailRatingPage({super.key, required int reviewId});

  @override
  Widget build(BuildContext context) {
    // Data default yang akan ditampilkan
    final idController = TextEditingController(text: 'A0056');
    final userController = TextEditingController(text: 'Miaauw@polines.ac.id');
    final instansiController = TextEditingController(text: 'Poliklinik');
    final ratingController = TextEditingController(text: '5');
    final tanggalController = TextEditingController(text: '01-09-2024');
    final deskripsiController = TextEditingController(
      text:
          'Kepada warga solinep, tolong laptop sya hilang disekitaran mdh. Bentuknya kayak digambar. Yang menemukan saya doakan masuk surga. Bisa hubungi ini ya : 098726177228819',
    );

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: idController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: userController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'User',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: instansiController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Instansi',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: ratingController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Skala Bintang',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: tanggalController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: deskripsiController, // Menggunakan controller
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
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Warna tombol
                        ),
                        onPressed: () {
                          // Tampilkan dialog konfirmasi
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Konfirmasi"),
                                content: const Text("Apakah Anda yakin ingin menghapus review ini?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Tutup dialog
                                    },
                                    child: const Text("Batal"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Logika penghapusan review
                                      Navigator.of(context).pop(); // Tutup dialog
                                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Review berhasil dihapus')),
                                      );
                                    },
                                    child: const Text(
                                      "Hapus"
                                    ),
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
            _buildMenu(), // Grid menu
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
            height: 240, // Sesuaikan tinggi
            decoration: const BoxDecoration(
              color: Color(0xFF060A47), // Warna biru tua
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo di atas tulisan WICARA
                Image.asset(
                  'images/Logo.png', // Path ke logo PNG Anda
                  height: 56, // Sesuaikan ukuran
                ),
                const Text(
                  "WICARA",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                const SizedBox(
                  width: 200, // Sesuaikan dengan lebar maksimal teks
                  child: Text(
                    "Wadah Informasi Catatan Aspirasi & Rating Akademik.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    maxLines: 3, // Memaksa jadi 3 baris
                    softWrap: true, // Memungkinkan teks untuk membungkus
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            right: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'images/Pengaduan1.png', // Gambar karakter
                height: 210, // Kurangi ukuran jika perlu
                fit: BoxFit.cover, // Pastikan gambar tidak melampaui batas
              ),
            ),
          ),
          // Ikon Notifikasi
          Positioned(
            top: 10,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white, size: 36),
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
  Widget _buildMenu() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
          _buildMenuItem('Dosen/Tendik', Icons.person),
          _buildMenuItem('Mahasiswa', Icons.school),
          _buildMenuItem('Unit Layanan', Icons.business),
          _buildMenuItem('Jenis Pengaduan', Icons.category),
        ],
      ),
    );
  }

// Fungsi untuk membuat item grid menu
  Widget _buildMenuItem(String title, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Menghindari overflow dengan meminimalkan ukuran kolom
      children: [
        CircleAvatar(
          radius: 28, // Kurangi radius agar lebih sesuai dengan grid
          backgroundColor: const Color.fromARGB(255, 6, 10, 71),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center, // Pusatkan teks
            overflow: TextOverflow.ellipsis, // Hindari overflow pada teks
          ),
        ),
      ],
    );
  }

  // Fungsi _buildActivitySection untuk bagian aktivitas
  Widget _buildActivitySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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

class KehilanganScreen extends StatelessWidget {
  const KehilanganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Ini adalah navbar atas
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF060A47),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Kurangi padding vertikal untuk mengurangi tinggi
            child: SafeArea(
              child: Row(
                children: [
                  // Icon Search di sebelah kiri
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Implement search functionality here
                    },
                  ),
                  // Expanded untuk menempatkan teks di tengah
                  const Expanded(
                    child: Text(
                      'Kehilangan',
                      textAlign: TextAlign.center, // Pastikan teks berada di tengah
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
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Mengurangi padding untuk lebih mendekatkan konten dengan navbar atas
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/Kalender.png',
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Terakhir Update : 1 September 2024',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Menambahkan sedikit jarak sebelum TabBarContainer
                  const TabBarContainerKehilangan(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5, // Misalnya ada 3 pengaduan
                      itemBuilder: (context, index) {
                        return const KehilanganCard();
                      },
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

class TabBarContainerKehilangan extends StatelessWidget {
  const TabBarContainerKehilangan({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Jumlah tab
      child: Column(
        children: [
          Container(
            color: Colors.grey[200],
            child: const TabBar(
              labelColor: Colors.orange, // Warna teks saat dipilih
              unselectedLabelColor: Colors.grey, // Warna teks saat tidak dipilih
              indicatorColor: Colors.orange, // Warna garis bawah saat dipilih
              indicatorWeight: 2.0, // Ketebalan garis bawah
              tabs: [
                Tab(text: 'Semua'),
                Tab(text: 'Belum Ditemukan'),
                Tab(text: 'Ditemukan'),
                Tab(text: 'Hilang'),
              ],
            ),
          ),
          // Content bisa diisi jika ingin memiliki konten berdasarkan tab
          // Expanded(
          //   child: TabBarView(
          //     children: [
          //       Container(), // Konten untuk "Semua"
          //       Container(), // Konten untuk "Belum Ditemukan"
          //       Container(), // Konten untuk "Ditemukan"
          //       Container(), // Konten untuk "Hilang"
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}


class KehilanganCard extends StatelessWidget {
  const KehilanganCard({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman detail kehilangan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailKehilanganPage(),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hp Samsung Hilang',
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '15/9/2024 20:00',
                          style: TextStyle(
                            fontSize: 12, 
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2), // Gray background color
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Belum Ditemukan',
                      style: TextStyle(color: Colors.grey), // White text color
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Deskripsi : Hp ku hilang dikamar mandi saat aku lagi mandi...',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailKehilanganPage extends StatelessWidget {
  const DetailKehilanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data default yang akan ditampilkan
    final idController = TextEditingController(text: 'A0056');
    final userController = TextEditingController(text: 'Miaauw@polines.ac.id');
    final instansiController = TextEditingController(text: 'Poliklinik');
    final ratingController = TextEditingController(text: '5');
    final tanggalController = TextEditingController(text: '01-09-2024');
    final deskripsiController = TextEditingController(
      text:
          'Kepada warga solinep, tolong laptop sya hilang disekitaran mdh. Bentuknya kayak digambar. Yang menemukan saya doakan masuk surga. Bisa hubungi ini ya : 098726177228819',
    );

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  TextField(
                    controller: idController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: userController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'User',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: instansiController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Instansi',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: ratingController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Skala Bintang',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: tanggalController, // Menggunakan controller
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: deskripsiController, // Menggunakan controller
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
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red, // Warna tombol
                          foregroundColor: Colors.white, // Warna teks putih
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        onPressed: () {
                          // Tampilkan dialog konfirmasi
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Konfirmasi"),
                                content: const Text("Apakah Anda yakin ingin menghapus laporan ini?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Tutup dialog
                                    },
                                    child: const Text("Batal"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Logika penghapusan laporan
                                      Navigator.of(context).pop(); // Tutup dialog
                                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Laporan berhasil dihapus')),
                                      );
                                    },
                                    child: const Text("Hapus"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Hapus'),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
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
                          // Tambahkan aksi logout
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Logout ditekan!")),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'images/Kalender.png',
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '  Terakhir Update : 1 September 2024',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                      const poliklinikService = Service(
                        name: 'Poliklinik',
                        email: 'PIC@gmail.com',
                        rating: 4,
                        reviews: 273,
                        imageUrl: 'images/poliklinik_image.png',
                      );

                      // Navigasi ke halaman detail Service
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ServiceDetailPage(
                              service: poliklinikService),
                        ),
                      );
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
