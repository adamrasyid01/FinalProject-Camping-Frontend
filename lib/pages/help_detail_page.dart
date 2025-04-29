import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';

class HelpDetailPage extends StatelessWidget {
  final String title;
  final MyColor myColor = MyColor();

  HelpDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pusat Bantuan", style: AppTextStyle.medium20),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Divider(
            height: 1,
            thickness: 1,
            color: myColor.secondaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildContent(title),
      ),
    );
  }

  Widget _buildContent(String title) {
    switch (title) {
      case "Cara Menambahkan Bookmark":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyle.bold20),
            const SizedBox(height: 16),
            Text(
              "Untuk menambahkan bookmark pada lokasi camping yang kamu suka:",
              style: AppTextStyle.medium14,
            ),
            const SizedBox(height: 8),
            _buildBullet("Buka halaman detail tempat camping."),
            _buildBullet("Klik ikon bookmark (simbol bintang atau hati)."),
            _buildBullet(
                "Tempat camping akan ditambahkan ke daftar favorit kamu."),
          ],
        );
      case "Cara Menghapus Bookmark":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyle.bold20),
            const SizedBox(height: 16),
            Text(
              "Untuk menghapus bookmark:",
              style: AppTextStyle.medium14,
            ),
            const SizedBox(height: 8),
            _buildBullet("Masuk ke halaman 'Bookmark' kamu."),
            _buildBullet("Pilih tempat yang ingin dihapus."),
            _buildBullet("Klik kembali ikon bookmark untuk menghapus."),
          ],
        );
      case "Laporkan Masalah":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyle.bold20),
            const SizedBox(height: 16),
            Text(
              "Jika kamu mengalami kendala atau bug, mohon laporkan ke tim kami melalui fitur kontak yang tersedia di aplikasi atau email ke adamrasxx@gmail.com.",
              style: AppTextStyle.medium14,
            ),
          ],
        );
      default:
        return Text("Konten bantuan tidak ditemukan.",
            style: AppTextStyle.medium14);
    }
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  ", style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: AppTextStyle.medium14)),
        ],
      ),
    );
  }
}
