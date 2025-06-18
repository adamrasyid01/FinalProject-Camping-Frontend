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
  // Definisikan instance MyColor di sini agar mudah diakses
  final MyColor myColor = MyColor();

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

  Future<void> _launchGoogleMaps(String placeName) async {
    if (placeName.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('URL Peta tidak tersedia.')),
        );
      }
      return;
    }
    final Uri url = Uri.parse(placeName);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Tidak dapat membuka URL: $placeName';
      }
    } catch (e) {
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
        backgroundColor: myColor.customWhite, // <-- Disesuaikan
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: myColor.customBlack), // <-- Disesuaikan
          onPressed: () => context.pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Divider(
            height: 1,
            thickness: 1,
            color: myColor.secondaryColor, // Sudah benar
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeStateLoading) {
            return Center(
                child: CircularProgressIndicator(
                    color: myColor.primaryColor)); // <-- Disesuaikan
          }

          if (state is HomeStateGetDetailSites) {
            final site = state.campingSite;
            final List<SentimentBarData> sentimen =
                site.total_sentimen.map((data) {
              // Lakukan casting yang aman dan beri nilai default jika null
              final criterionId = (data['criterion_id'] as num?)?.toInt() ?? 0;
              final positif =
                  (data['total_positif'] as num?)?.toDouble() ?? 0.0;
              final netral = (data['total_netral'] as num?)?.toDouble() ?? 0.0;
              final negatif =
                  (data['total_negatif'] as num?)?.toDouble() ?? 0.0;

              return SentimentBarData(
                criterionId: criterionId,
                positif: positif,
                netral: netral,
                negatif: negatif,
              );
            }).toList();

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildChart(sentimen),
                const SizedBox(height: 16),
                _buildLegend(),
                const SizedBox(height: 16),
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
              style: AppTextStyle.semiBold16
                  .copyWith(color: myColor.customBlack), // <-- Disesuaikan
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: BarChart(BarChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: myColor.customGrey,
                      strokeWidth: 3,
                    ),
                  ),
                  barGroups: _buildBarGroups(sentimen),
                  borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                          color: myColor.secondaryColor)), // <-- Disesuaikan
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
                          style: TextStyle(
                              color: myColor.darkGrey,
                              fontSize: 12), // <-- Disesuaikan
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
                              style: TextStyle(
                                  color: myColor.customBlack, // <-- Disesuaikan
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
                          TextStyle(
                              color: myColor.customWhite), // <-- Disesuaikan
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
              color: myColor.lightGreen, // <-- Disesuaikan
              width: 12,
              borderRadius: BorderRadius.circular(4)),
          BarChartRodData(
              toY: data.netral,
              color: myColor.lightGrey, // <-- Disesuaikan
              width: 12,
              borderRadius: BorderRadius.circular(4)),
          BarChartRodData(
              toY: data.negatif,
              color: myColor.customRed, // <-- Disesuaikan
              width: 12,
              borderRadius: BorderRadius.circular(4)),
        ],
        barsSpace: 3,
      );
    }).toList();
  }

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
                style: AppTextStyle.semiBold18
                    .copyWith(color: myColor.customBlack)), // <-- Disesuaikan
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _LegendItem(
                    color: myColor.lightGreen,
                    label: "Positif"), // <-- Disesuaikan
                _LegendItem(
                    color: myColor.lightGrey,
                    label: "Netral"), // <-- Disesuaikan
                _LegendItem(
                    color: myColor.customRed,
                    label: "Negatif"), // <-- Disesuaikan
              ],
            ),
            const Divider(height: 32, thickness: 1),
            Text("Keterangan Kriteria",
                style: AppTextStyle.semiBold16
                    .copyWith(color: myColor.customBlack)), // <-- Disesuaikan
            const SizedBox(height: 4),
            Text("A = Keamanan",
                style: AppTextStyle.regular15
                    .copyWith(color: myColor.customBlack)), // <-- Disesuaikan
            Text("N = Kenyamanan",
                style: AppTextStyle.regular15
                    .copyWith(color: myColor.customBlack)), // <-- Disesuaikan
            Text("B = Kebersihan",
                style: AppTextStyle.regular15
                    .copyWith(color: myColor.customBlack)), // <-- Disesuaikan
            Text("T = Kemudahan Transportasi",
                style: AppTextStyle.regular15
                    .copyWith(color: myColor.customBlack)), // <-- Disesuaikan
          ],
        ),
      ),
    );
  }

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
                style: AppTextStyle.semiBold18
                    .copyWith(color: myColor.customBlack)), // <-- Disesuaikan
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on, color: myColor.primaryColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(site.name, style: AppTextStyle.medium14),
                      Text('${site.location}, Jawa Timur',
                          style: AppTextStyle.regular14.copyWith(
                              color: myColor.darkGrey)), // <-- Disesuaikan
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.map_outlined,
                    color: myColor.customWhite), // <-- Disesuaikan
                label: Text('Buka di Google Maps',
                    style: AppTextStyle.medium14.copyWith(
                        color: myColor.customWhite)), // <-- Disesuaikan
                onPressed: () {
                  _launchGoogleMaps(site.link);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: myColor.primaryColor,
                  foregroundColor: myColor.customWhite,
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
    if (site.text_reviews.isEmpty) {
      return const SizedBox.shrink();
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
                style: AppTextStyle.semiBold18
                    .copyWith(color: myColor.customBlack)), // <-- Disesuaikan
            const SizedBox(height: 16),
            Column(
              children: site.text_reviews.map((review) {
                final reviewText = review['text'] ?? 'Review tidak valid';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: myColor.customGrey, // <-- Disesuaikan
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: myColor.secondaryColor)), // <-- Disesuaikan
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            color: myColor.darkGrey,
                            size: 20), // <-- Disesuaikan
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(reviewText,
                              style: AppTextStyle.regular14.copyWith(
                                  color: myColor.customBlack,
                                  height: 1.5)), // <-- Disesuaikan
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
        return 'K$id';
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
        Text(label,
            style: AppTextStyle.regular14
                .copyWith(color: Colors.black)), // <-- Disesuaikan
      ],
    );
  }
}
