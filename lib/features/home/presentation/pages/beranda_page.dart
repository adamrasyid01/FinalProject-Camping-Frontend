import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/services/save_user.dart';
import 'package:flutter_camping_frontend/core/services/token_storage.dart';
import 'package:flutter_camping_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_camping_frontend/models/list_wisata_model.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_chip.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_wisata.dart';
import 'package:flutter_camping_frontend/core/widgets/search_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final SaveUser saveUser = SaveUser();
  final TokenStorage tokenStorage = TokenStorage();
  String? username;
  int selectedFilterIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUsername();
    _fetchDataCamping();
  }

  Future<void> _loadUsername() async {
    final user = await saveUser.getUsername();
    print("Username dari storage: $user");
    setState(() {
      username = user ?? "Guest HHH"; // Jika username null, tampilkan "Guest"
    });
  }

  void _fetchDataCamping() {
    context.read<HomeBloc>().add(HomeEventGetCampingLocations());
  }

  final List<String> filters = ['Semua', 'Terfavorit', 'Camping Terbanyak'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: SvgPicture.asset('assets/icons/campHome.svg'),
                      ),
                      Text("Halo $username",
                          style: AppTextStyle.semiBold16.copyWith(
                            color: Color(0xFF274F66),
                          )),
                    ],
                  ),
                  Text(
                    "Anda mau pergi camping di mana?",
                    style: AppTextStyle.bold24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SearchInput(
                      hintText: "Cari tempat camping",
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  // ElevatedButton(
                  //     onPressed: () async {
                  //       print(await tokenStorage.getToken());
                  //     },
                  //     child: Text("Cari Camping")),
                  Text("Eksplor Tempat Camping",
                      style: AppTextStyle.semiBold16),
                ],
              ),
            ),
            // Text("Filter") Biar bisa di scroll horizontal

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: buildFilterBeranda(),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 12,
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeStateLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeStateError) {
                  return Center(child: Text(state.message));
                } else if (state is HomeStateSuccess) {
                  final locations = state.campingLocation;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      final location = locations[index];
                      return CustomListWisata(
                        imageUrl: location.imageUrl,
                        name: location.name,
                        totalCamps: location.totalCamps,
                      );
                    },
                  );
                }
                return const Center(child: Text("Tidak ada data tersedia"));
              },
            ),
          ],
        ),
      ),
    );
  }

  Row buildFilterBeranda() {
    return Row(
      children: List.generate(filters.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: CustomChip(
            label: filters[index],
            isSelected: selectedFilterIndex == index,
            onTap: () {
              setState(() {
                selectedFilterIndex = index;
              });
            },
          ),
        );
      }),
    );
  }
}
