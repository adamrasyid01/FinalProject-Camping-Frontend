import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_loading.dart';

import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';
import 'package:flutter_camping_frontend/features/home/presentation/bloc/home_bloc.dart';

import 'package:flutter_camping_frontend/models/sentiment_bar_data.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailCampingSitePage extends StatefulWidget {
  final int campingSiteLocationId;
  final int campingSiteId;
  const DetailCampingSitePage({
    super.key,
    required this.campingSiteLocationId,
    required this.campingSiteId,
  });

  @override
  State<DetailCampingSitePage> createState() => _DetailCampingSitePageState();
}

class _DetailCampingSitePageState extends State<DetailCampingSitePage> {
  @override
  void initState() {
    _fetchDataDetailSites();
    super.initState();
  }

  void _fetchDataDetailSites() {
    context.read<HomeBloc>().add(HomeEventGetDetailSites(
          campingLocationId: widget.campingSiteLocationId,
          campingSiteId: widget.campingSiteId,
        ));
  }

  // === Fungsi untuk membuka Google Maps ===
  Future<void> _launchGoogleMaps(String placeName) async {
    // 1. Cek apakah string URL tidak kosong
    if (placeName.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('URL Peta tidak tersedia.')),
        );
      }
      return;
    }

    // 2. Parse string URL menjadi objek Uri
    final Uri url = Uri.parse(placeName);

    // 3. Coba luncurkan URL
    try {
      if (await canLaunchUrl(url)) {
        // Buka di aplikasi eksternal (Google Maps atau Browser)
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Tidak dapat membuka URL: $placeName';
      }
    } catch (e) {
      // Tampilkan pesan error jika gagal
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Analisis Sentimen", style: AppTextStyle.medium20),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Divider(
            height: 1,
            thickness: 1,
            color: MyColor().secondaryColor,
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeStateGetDetailSites) {
            final site = state.campingSite;
            final List<SentimentBarData> sentimen =
                site.total_sentimen.map((data) {
              return SentimentBarData(
                criterionId: int.tryParse(data['criterion_id'] ?? '0') ?? 0,
                positif: double.tryParse(data['total_positif'] ?? '0') ?? 0.0,
                netral: double.tryParse(data['total_netral'] ?? '0') ?? 0.0,
                negatif: double.tryParse(data['total_negatif'] ?? '0') ?? 0.0,
              );
            }).toList();

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildChart(sentimen),
                const SizedBox(height: 16),
                _buildLegend(),
                const SizedBox(height: 16),
                // === [BARU] Memanggil widget untuk Card Google Maps ===
                _buildMapsCard(site),
                const SizedBox(height: 16),
                _buildReviewsCard(site),
              ],
            );
          }

          if (state is HomeStateError) {
            return Center(child: Text('Terjadi kesalahan: ${state.message}'));
          }

          return const Center(
              child: CustomLoading(
                  asset: 'assets/animations/loadingAnimation.json'));
        },
      ),
    );
  }

  // CHARTT
  Widget _buildChart(List<SentimentBarData> sentimen) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Grafik Sentimen Berdasarkan Kriteria",
              style: AppTextStyle.semiBold16.copyWith(color: Colors.black87),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                // color: Colors.red,
                child: BarChart(BarChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: MyColor().customGrey,
                      strokeWidth: 3,
                    ),
                  ),
                  barGroups: _buildBarGroups(sentimen),
                  borderData: FlBorderData(
                    show: true,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 6,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ),
                    rightTitles: AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= sentimen.length) return Container();
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              _getKriteriaLabel(sentimen[index].criterionId),
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final label =
                            ["Positif", "Netral", "Negatif"][rodIndex];
                        return BarTooltipItem(
                          '$label: ${rod.toY.toStringAsFixed(1)}',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<SentimentBarData> sentimenData) {
    return sentimenData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
              toY: data.positif,
              color: Colors.green,
              width: 12,
              borderRadius: BorderRadius.circular(4)),
          BarChartRodData(
              toY: data.netral,
              color: Colors.grey,
              width: 12,
              borderRadius: BorderRadius.circular(4)),
          BarChartRodData(
              toY: data.negatif,
              color: Colors.red,
              width: 12,
              borderRadius: BorderRadius.circular(4)),
        ],
        barsSpace: 3,
      );
    }).toList();
  }

  // LEGEND (KETERANGAN)
  Widget _buildLegend() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Legenda",
                style: AppTextStyle.semiBold18.copyWith(color: Colors.black87)),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _LegendItem(color: Color(0xFF4CAF50), label: "Positif"),
                _LegendItem(color: Color(0xFF9E9E9E), label: "Netral"),
                _LegendItem(color: Color(0xFFF44336), label: "Negatif"),
              ],
            ),
            const Divider(height: 32, thickness: 1),
            Text("Keterangan Kriteria",
                style: AppTextStyle.semiBold16.copyWith(color: Colors.black87)),
            const SizedBox(height: 4),
            // Membuat list keterangan kriteria secara dinamis
            Text("A = Keamanan",
                style: AppTextStyle.regular15.copyWith(color: Colors.black87)),
            Text("N = Kenyamanan",
                style: AppTextStyle.regular15.copyWith(color: Colors.black87)),
            Text("B = Kebersihan",
                style: AppTextStyle.regular15.copyWith(color: Colors.black87)),
            Text("T = Kemudahan Transportasi",
                style: AppTextStyle.regular15.copyWith(color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  // === [BARU] Widget untuk menampilkan Card Google Maps ===
  Widget _buildMapsCard(CampingSite site) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Lokasi di Peta",
                style: AppTextStyle.semiBold18.copyWith(color: Colors.black87)),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on,
                    color: MyColor().primaryColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(site.name, style: AppTextStyle.medium14),
                      Text('${site.location}, Jawa Timur',
                          style: AppTextStyle.regular14
                              .copyWith(color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.map_outlined,
                  color: Colors.white,
                ),
                label: const Text('Buka di Google Maps'),
                onPressed: () {
                  _launchGoogleMaps(site.link);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColor().primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsCard(CampingSite site) {
    // Cek jika review kosong atau null
    if (site.text_reviews.isEmpty) {
      return const SizedBox
          .shrink(); // Tidak menampilkan apa-apa jika tidak ada review
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Beberapa Ulasan Pengguna",
                style: AppTextStyle.semiBold18.copyWith(color: Colors.black87)),
            const SizedBox(height: 16),
            // Gunakan Column untuk menampilkan semua review
            // Ini lebih sederhana daripada ListView.builder di dalam ListView
            Column(
              children: site.text_reviews.map((review) {
                // Pastikan 'review' adalah Map dan ambil 'text'
                final reviewText = review['text'] ?? 'Review tidak valid';

                // Widget untuk setiap item review
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            color: Colors.grey[600], size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(reviewText,
                              style: AppTextStyle.regular14.copyWith(
                                  color: Colors.black87, height: 1.5)),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _getKriteriaLabel(int id) {
    switch (id) {
      case 1:
        return 'A';
      case 2:
        return 'N';
      case 3:
        return 'B';
      case 4:
        return 'T';
      default:
        return 'K$id'; // fallback jika id tidak dikenali
    }
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
