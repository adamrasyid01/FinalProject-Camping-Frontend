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
  final SaveUser saveUser = SaveUser();
  final TokenStorage tokenStorage = TokenStorage();
  final SaveNameCampLocation saveNameCampLocation = SaveNameCampLocation();

  String? username;
  int selectedFilterIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _fetchDataCamping();
  }

  Future<void> _loadUsername() async {
    final user = await saveUser.getUsername();
    setState(() {
      username = user ?? "Guest";
    });
  }

  void _fetchDataCamping() {
    context.read<HomeBloc>().add(HomeEventGetCampingLocations(filter: 'semua'));
  }

  final List<String> filters = ['Semua', 'Urutan Nama', 'Camping Terbanyak'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset(
                          'assets/icons/homeCamp.svg',
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Halo $username",
                          style: AppTextStyle.semiBold16.copyWith(
                            color: Color(0xFF274F66),
                          ),
                          overflow: TextOverflow.ellipsis, // Hindari overflow
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Anda mau pergi camping di mana?",
                    style: AppTextStyle.bold24.copyWith(
                      color: MyColor().primaryColor,
                    ),
                  ),
                  Text(
                    "Eksplor Tempat Camping",
                    style: AppTextStyle.semiBold16,
                  ),
                ],
              ),
            ),

            // Bagian filter (pastikan bisa scroll horizontal)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: buildFilterBeranda(),
              ),
            ),

            const SizedBox(height: 12),

            // List tempat camping (hindari overflow dengan shrinkWrap)
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeStateLoading) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    alignment: Alignment.center,
                    child: const CustomLoading(
                      asset: 'assets/animations/loadingAnimation.json',
                    ),
                  );
                } else if (state is HomeStateError) {
                  return Center(child: Text(state.message));
                } else if (state is HomeStateSuccessLocations) {
                  final locations = state.campingLocations;
                  return ListView.builder(
                    shrinkWrap: true, // Hindari error overflow
                    physics:
                        const NeverScrollableScrollPhysics(), // Tidak scroll sendiri
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      final location = locations[index];
                      return GestureDetector(
                        onTap: () async {
                          await saveNameCampLocation
                              .saveCampLocationName(location.name);
                          context.push('/camping-site/${location.id}');
                        },
                        child: CustomListWisata(
                          imageUrl: location.imageUrl,
                          name: location.name,
                          totalCamps: location.totalCamps,
                        ),
                      );
                    },
                  );
                }
                return EmptyCampingWidget(
                  message: "Data Camping Tidak Ada, Mohon Hubungi Admin",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // FILTER BERANDA
  Widget buildFilterBeranda() {
    return StatefulBuilder(
      builder: (context, setStateFilter) {
        return Row(
          children: List.generate(filters.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: CustomChip(
                label: filters[index],
                isSelected: selectedFilterIndex == index,
                onTap: () {
                  setStateFilter(() {
                    selectedFilterIndex = index;
                  });
                  // Lakukan fetch ulang data berdasarkan filter
                  String selectedFilter = filters[index];

                  String filterKeyword;
                  switch (selectedFilter.toLowerCase()) {
                    case 'urutan nama':
                      filterKeyword = 'nama';
                      break;
                    case 'camping terbanyak':
                      filterKeyword = 'terbanyak';
                      break;
                    default:
                      filterKeyword = 'semua';
                  }

                  // Trigger event bloc
                  context.read<HomeBloc>().add(
                        HomeEventGetCampingLocations(filter: filterKeyword),
                      );
                },
              ),
            );
          }),
        );
      },
    );
  }
}
