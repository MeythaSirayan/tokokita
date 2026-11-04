import 'package:flutter/material.dart';

import 'wishlist_page.dart';
import 'order_history_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),

      body: ListView(
        children: [
          const SizedBox(height: 20),

          const Center(child: Icon(Icons.person, size: 80, color: Colors.teal)),

          const SizedBox(height: 10),

          const Center(
            child: Text('Profil Pengguna', style: TextStyle(fontSize: 20)),
          ),

          const SizedBox(height: 20),

          // MENU RIWAYAT PESANAN
          ListTile(
            leading: const Icon(Icons.receipt_long, color: Colors.teal),
            title: const Text('Riwayat Pesanan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderHistoryPage(),
                ),
              );
            },
          ),

          // MENU WISHLIST
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: const Text('Wishlist Saya'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishlistPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
