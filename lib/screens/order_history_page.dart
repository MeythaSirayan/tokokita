
import 'package:flutter/material.dart';
import '../services/order_database.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() =>
      _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final database = OrderDatabase.instance;

  List<Map<String, dynamic>> orders = [];

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    final result = await database.getAllOrders();

    if (!mounted) return;

    setState(() {
      orders = result;
    });
  }

  Future<void> searchOrders(String status) async {
    final result = status.trim().isEmpty
        ? await database.getAllOrders()
        : await database.searchOrders(status);

    if (!mounted) return;

    setState(() {
      orders = result;
    });
  }

  Future<void> updateStatus(int id, String status) async {
    await database.updateOrderStatus(id, status);
    await loadOrders();
  }

  Future<void> deleteOrder(int id) async {
    await database.deleteOrder(id);
    await loadOrders();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari berdasarkan status...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    searchOrders('');
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onChanged: searchOrders,
            ),
          ),

          Expanded(
            child: orders.isEmpty
                ? const Center(
                    child: Text('Belum ada riwayat pesanan'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];

                      final int id = order['id'] as int;
                      final String status =
                          order['status'] as String;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pesanan #$id',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text('Tanggal: ${order['tanggal']}'),

                              Text(
                                'Item: ${order['daftarItem']}',
                              ),

                              Text(
                                'Total: Rp ${order['totalHarga']}',
                              ),

                              Text('Status: $status'),

                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButton<String>(
                                      value: status,
                                      isExpanded: true,
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'Diproses',
                                          child: Text('Diproses'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Selesai',
                                          child: Text('Selesai'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        if (value != null) {
                                          updateStatus(id, value);
                                        }
                                      },
                                    ),
                                  ),

                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      deleteOrder(id);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
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
