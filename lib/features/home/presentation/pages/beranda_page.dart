import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/services/save_name_camp_location.dart';
import 'package:flutter_camping_frontend/core/services/save_user.dart';
import 'package:flutter_camping_frontend/core/services/token_storage.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_loading.dart';
import 'package:flutter_camping_frontend/core/widgets/empty_widget.dart';
import 'package:flutter_camping_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_chip.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_wisata.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  // Sebaiknya, instance ini didapatkan dari dependency injection (seperti get_it)
  // agar lebih mudah di-test, namun untuk saat ini kita biarkan dulu.
  final SaveUser saveUser = SaveUser();
  final TokenStorage tokenStorage = TokenStorage();
  final SaveNameCampLocation saveNameCampLocation = SaveNameCampLocation();

  String? username;
  int selectedFilterIndex = 0;
  final List<String> filters = ['Semua', 'Urutan Nama', 'Camping Terbanyak'];

  @override
  void initState() {
    super.initState();
    // Memanggil semua data yang dibutuhkan saat halaman pertama kali dimuat
    _loadInitialData();
  }

  void _loadInitialData() {
    _loadUsername();
    _fetchDataCamping();
  }

  Future<void> _loadUsername() async {
    final user = await saveUser.getUsername();
    // Pastikan widget masih ada sebelum memanggil setState
    if (mounted) {
      setState(() {
        username = user ?? "Guest";
      });
    }
  }

  void _fetchDataCamping() {
    // Menentukan filter berdasarkan index yang aktif
    String filterKeyword = _getFilterKeyword(selectedFilterIndex);
    context
        .read<HomeBloc>()
        .add(HomeEventGetCampingLocations(filter: filterKeyword));
  }

  String _getFilterKeyword(int index) {
    switch (filters[index].toLowerCase()) {
      case 'urutan nama':
        return 'nama';
      case 'camping terbanyak':
        return 'terbanyak';
      default:
        return 'semua';
    }
  }

  void _onFilterTapped(int index) {
    // 1. Update state untuk UI (mengubah chip yang aktif)
    setState(() {
      selectedFilterIndex = index;
    });
    // 2. Ambil data baru berdasarkan filter yang dipilih
    _fetchDataCamping();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset('assets/icons/homeCamp.svg'),
                      ),
                      Expanded(
                        child: Text(
                          // Menampilkan "Halo..." saat username masih dimuat
                          username == null ? "Halo..." : "Halo $username",
                          style: AppTextStyle.semiBold16.copyWith(
                            color: const Color(0xFF274F66),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 8),
                  Text(
                    "Anda mau pergi camping ke mana?",
                    style: AppTextStyle.bold24.copyWith(
                      color: MyColor().primaryColor,
                    ),
                  ),
                  // const SizedBox(height: 16),
                  Text(
                    "Eksplor Tempat Camping",
                    style: AppTextStyle.semiBold16,
                  ),
                ],
              ),
            ),

            // Bagian filter
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal:
                      12), // Mengurangi padding agar chip tidak terlalu mepet
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: buildFilterBeranda(),
              ),
            ),

            // const SizedBox(height: 12),

            // Bagian List Tempat Camping
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeStateLoading) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    alignment: Alignment.center,
                    child: const CustomLoading(
                      asset: 'assets/animations/loadingAnimation.json',
                    ),
                  );
                } else if (state is HomeStateError) {
                  return Center(child: Text(state.message));
                } else if (state is HomeStateSuccessLocations) {
                  if (state.campingLocations.isEmpty) {
                    return const EmptyCampingWidget(
                      message: "Data Camping Tidak Tersedia.",
                    );
                  }
                  // Menggunakan Column daripada ListView untuk menghindari masalah scroll-dalam-scroll
                  // Ini efisien jika jumlah item tidak terlalu banyak.
                  return Column(
                    children: state.campingLocations.map((location) {
                      return GestureDetector(
                        onTap: () async {
                          // Simpan nama lokasi sebelum pindah halaman
                          await saveNameCampLocation
                              .saveCampLocationName(location.name);

                          // AWAIT push. Kode di bawah ini akan jalan setelah halaman detail di-pop.
                          await context.push('/camping-site/${location.id}');

                          // PANGGIL KEMBALI method untuk refresh data setelah kembali ke halaman ini
                          print("Kembali ke Beranda, memuat ulang data...");
                          _loadInitialData();
                        },
                        child: CustomListWisata(
                          imageUrl: location.imageUrl,
                          name: location.name,
                          totalCamps: location.totalCamps,
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return const EmptyCampingWidget(
                    message: "Data Camping Tidak Ada, Mohon Hubungi Admin",
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // FILTER BERANDA (Sudah disederhanakan)
  Widget buildFilterBeranda() {
    return Row(
      children: List.generate(filters.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: CustomChip(
            label: filters[index],
            isSelected: selectedFilterIndex == index,
            onTap: () => _onFilterTapped(index), // Memanggil fungsi terpisah
          ),
        );
      }),
    );
  }
}
