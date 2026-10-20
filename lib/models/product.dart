void main() {
  // Langkah 1
  const String namaToko = "TokoKita"; // konstan, tidak bisa di ubah
  final DateTime waktuAkses = DateTime.now(); // nilainya ngga bisa berubah
  var namaKasir = "Budi"; // nilainya bisa di ubah asal tipe datanya sama

  int stok = 10;
  double harga = 2500000;
  String namaProduk = 'Laptop';
  bool tersedia = true;

  print('Nama Toko: $namaToko');
  print('Waktu Akses: $waktuAkses');
  print('Stok: $stok');
  print('Harga: $harga');
  print('Nama Produk: $namaProduk');
  print('Tersedia: $tersedia');

  // List
  List<String> kategoriProduk = ['Elektronik', 'Fashion', 'Makanan'];

  // Map
  Map<String, dynamic> produk = {
    // dynamic biar tipe valuenya bisa sama
    'id': 1,
    'name': 'Laptop',
    'price': 2500000,
    'stock': 10,
    'available': true,
  };

  print('Kategori: $kategoriProduk');
  print('Data Produk: $produk');

  // LANGKAH 2 - OPERATOR
  print('\n OPERATOR ARITMATIKA');
  int jumlah = 2;

  double totalHarga = harga * jumlah;
  double hargaSetelahDiskon = harga - 500000;
  double hargaDibagiDua = harga / 2;
  int sisaStok = stok % jumlah;

  print('Total Harga: $totalHarga');
  print('Harga Setelah Diskon: $hargaSetelahDiskon');
  print('Harga Dibagi Dua: $hargaDibagiDua');
  print('Sisa Stok: $sisaStok');

  // Operator Perbandingan
  print('\n OPERATOR PERBANDINGAN');

  double hargaProduk1 = 2500000;
  double hargaProduk2 = 3000000;

  int stokProduk1 = 10;
  int stokProduk2 = 5;

  print('Harga produk 1 == produk 2: ${hargaProduk1 == hargaProduk2}');
  print('Harga produk 1 != produk 2: ${hargaProduk1 != hargaProduk2}');
  print('Harga produk 1 > produk 2: ${hargaProduk1 > hargaProduk2}');
  print('Harga produk 1 < produk 2: ${hargaProduk1 < hargaProduk2}');
  print('Harga produk 1 >= produk 2: ${hargaProduk1 >= hargaProduk2}');
  print('Harga produk 1 <= produk 2: ${hargaProduk1 <= hargaProduk2}');
  print('Stok produk 1 > produk 2: ${stokProduk1 > stokProduk2}');

  // Operator Logika
  print('\n OPERATOR LOGIKA');

  bool layakDitampilkan = stok > 0 && harga > 0;
  bool bisaDibeli = stok > 0 || harga > 0;
  bool tidakTersedia = !tersedia;

  print('Produk layak ditampilkan: $layakDitampilkan');
  print('Produk bisa dibeli: $bisaDibeli');
  print('Produk tidak tersedia: $tidakTersedia');

  //LANGKAH 3

  // 3.1 IF-ELSE
  print('\n STATUS STOK');

  print('Status stok 10: ${statusProduk(10)}');
  print('Status stok 3: ${statusProduk(3)}');
  print('Status stok 0: ${statusProduk(0)}');

  // 3.2 FOR
  print('\n TOTAL BELANJA DENGAN FOR');

  List<double> daftarHarga = [100000, 200000, 150000, 300000];

  double totalBelanjaFor = 0;

  for (double hargaItem in daftarHarga) {
    totalBelanjaFor += hargaItem;
  }

  print('Daftar Harga: $daftarHarga');
  print('Total Belanja: ${formatRupiah(totalBelanjaFor)}');

  // 3.3 WHILE
  print('\n WHILE STOK');

  int stokSekarang = 5;

  while (stokSekarang > 0) {
    print('Stok sebelum dibeli: $stokSekarang');
    stokSekarang--;
  }

  print('Stok sudah habis');

  // 3.4 SWITCH-CASE
  print('\n DISKON KATEGORI');

  print('Diskon Elektronik: ${diskonKategori('Elektronik')}%');
  print('Diskon Fashion: ${diskonKategori('Fashion')}%');
  print('Diskon Makanan: ${diskonKategori('Makanan')}%');

  // LANGKAH 4
  print('\n Harga Setelah Diskon');

  double hargaFinal = hitungHargaSetelahDiskon(2500000, persenDiskon: 10);

  print('Harga setelah diskon 10%: ${formatRupiah(hargaFinal)}');
  print('Format Rupiah: ${formatRupiah(2250000)}'); //Arrow Function

  //LANGKAH 5
  print('\n CLASS PRODUCT');

  Product produk1 = Product(
    id: 1,
    name: 'Laptop',
    price: 7500000,
    imageUrl: 'https://example.com/laptop.jpg',
    category: 'Elektronik',
    stock: 5,
    description: 'Laptop untuk kebutuhan kuliah',
  );

  Product produk2 = Product(
    id: 2,
    name: 'Kaos',
    price: 100000,
    imageUrl: 'https://example.com/kaos.jpg',
    category: 'Fashion',
    stock: 10,
  );

  print(produk1.getInfo());
  print('Status Stok: ${produk1.getStatusStok()}');
  print(produk2.getInfo());
  print('Status Stok: ${produk2.getStatusStok()}');

  print('\n DISCOUNTED PRODUCT');

  // Discounted Product
  DiscountedProduct produkDiskon = DiscountedProduct(
    id: 3,
    name: 'Smartphone',
    price: 5000000,
    imageUrl: 'https://example.com/smartphone.jpg',
    category: 'Elektronik',
    stock: 8,
    description: 'Smartphone dengan spesifikasi tinggi',
    discountPercent: 10,
  );

  print('Produk Diskon: ${produkDiskon.name}');
  print('Harga Awal: ${formatRupiah(produkDiskon.price)}');
  print('Diskon: ${produkDiskon.discountPercent}%');
  print(
    'Harga Setelah Diskon: '
    '${formatRupiah(produkDiskon.getHargaFinal())}',
  );

  print('\n Latihan Soal Nomor 2: DAFTAR 8 PRODUK');

  List<Product> daftarProduk = [
    Product(
      id: 1,
      name: 'Laptop',
      price: 7500000,
      imageUrl: 'https://example.com/laptop.jpg',
      category: 'Elektronik',
      stock: 5,
      description: 'Laptop untuk kebutuhan kuliah',
    ),
    Product(
      id: 2,
      name: 'Smartphone',
      price: 5000000,
      imageUrl: 'https://example.com/smartphone.jpg',
      category: 'Elektronik',
      stock: 8,
      description: 'Smartphone dengan spesifikasi tinggi',
    ),
    Product(
      id: 3,
      name: 'Headset',
      price: 350000,
      imageUrl: 'https://example.com/headset.jpg',
      category: 'Elektronik',
      stock: 12,
      description: 'Headset untuk mendengarkan musik',
    ),
    Product(
      id: 4,
      name: 'Kaos',
      price: 100000,
      imageUrl: 'https://example.com/kaos.jpg',
      category: 'Fashion',
      stock: 10,
      description: 'Kaos nyaman untuk sehari-hari',
    ),
    Product(
      id: 5,
      name: 'Jaket',
      price: 350000,
      imageUrl: 'https://example.com/jaket.jpg',
      category: 'Fashion',
      stock: 4,
      description: 'Jaket casual',
    ),
    Product(
      id: 6,
      name: 'Sepatu',
      price: 500000,
      imageUrl: 'https://example.com/sepatu.jpg',
      category: 'Fashion',
      stock: 7,
      description: 'Sepatu untuk aktivitas sehari-hari',
    ),
    Product(
      id: 7,
      name: 'Roti',
      price: 25000,
      imageUrl: 'https://example.com/roti.jpg',
      category: 'Makanan',
      stock: 20,
      description: 'Roti segar dan lezat',
    ),
    Product(
      id: 8,
      name: 'Keripik',
      price: 15000,
      imageUrl: 'https://example.com/keripik.jpg',
      category: 'Makanan',
      stock: 15,
      description: 'Keripik sebagai makanan ringan',
    ),
  ];

  //method getstatus
  for (Product produk in daftarProduk) {
    print(
      '${produk.id}. ${produk.name} - '
      '${formatRupiah(produk.price)} - '
      'Stok: ${produk.stock} - '
      '${produk.getStatusStok()}',
    );
  }

  // Tugas Mandiri 3; hitungTotalBelanja
  print('\n TOTAL BELANJA KERANJANG');

  List<Product> keranjang = [daftarProduk[0], daftarProduk[3], daftarProduk[6]];

  double totalKeranjang = hitungTotalBelanja(keranjang);

  print('Isi Keranjang:');

  for (Product produk in keranjang) {
    print('- ${produk.name}: ${formatRupiah(produk.price)}');
  }

  print('Total Belanja: ${formatRupiah(totalKeranjang)}');
} // end main

// function if-else
String statusProduk(int stok) {
  if (stok == 0) {
    return 'Habis';
  } else if (stok <= 5) {
    return 'Stok Terbatas';
  } else {
    return 'Tersedia';
  }
}

// function switch case
double diskonKategori(String kategori) {
  switch (kategori) {
    case 'Elektronik':
      return 10;
    case 'Fashion':
      return 15;
    case 'Makanan':
      return 5;
    default:
      return 0;
  }
}

// function Langkah 4; nomor 1
double hitungHargaSetelahDiskon(double harga, {double persenDiskon = 0}) {
  // parameter
  return harga - (harga * persenDiskon / 100);
}

//Arrow function
String formatRupiah(double harga) => 'Rp ${harga.toStringAsFixed(0)}';

class Product {
  int id;
  String name;
  double price;
  String imageUrl;
  String category;
  int stock;
  String? description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.stock,
    this.description,
  });

  // Mengubah data JSON dari API menjadi object Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image'],
      category: json['category'],
      stock: json['stock'] ?? 0,
      description: json['description'],
    );
  }

  String getInfo() {
    return '$name - Rp ${price.toStringAsFixed(0)} - Stok: $stock';
  }

  // Tugas Mandiri 1
  String getStatusStok() {
    if (stock == 0) {
      return 'Habis';
    } else if (stock <= 5) {
      return 'Stok Terbatas';
    } else {
      return 'Tersedia';
    }
  }
}

class DiscountedProduct extends Product {
  double discountPercent;

  DiscountedProduct({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.category,
    required super.stock,
    super.description,
    required this.discountPercent,
  });

  double getHargaFinal() {
    return price - (price * discountPercent / 100);
  }
}

// FUNCTION HITUNG TOTAL BELANJA
double hitungTotalBelanja(List<Product> keranjang) {
  double total = 0;

  for (Product produk in keranjang) {
    total += produk.price;
  }

  return total;
}
