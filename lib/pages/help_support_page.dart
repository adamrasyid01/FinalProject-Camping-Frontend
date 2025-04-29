import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';

import 'package:flutter_camping_frontend/pages/help_detail_page.dart'; // Sesuaikan path

class HelpSupportPage extends StatelessWidget {
  final MyColor myColor = MyColor();

  HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> helpItems = [
      {
        "id": 1,
        "title": "Cara Menambahkan Bookmark",
      },
      {
        "id": 2,
        "title": "Cara Menghapus Bookmark",
      },
      {
        "id": 3,
        "title": "Laporkan Masalah",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pusat Bantuan', style: AppTextStyle.medium20),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Divider(
            height: 1,
            thickness: 1,
            color: myColor.secondaryColor,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: helpItems.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final item = helpItems[index];
          return ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.blueGrey),
            title: Text(item['title']!, style: AppTextStyle.semiBold16),
            onTap: () => _navigateToHelpDetail(context, item['title']!),
          );
        },
      ),
    );
  }

  void _navigateToHelpDetail(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HelpDetailPage(
          title: title,
        ),
      ),
    );
  }
}
