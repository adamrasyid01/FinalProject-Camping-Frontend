import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/services/save_name_camp_location.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_sites.dart';
import 'package:flutter_camping_frontend/features/home/presentation/bloc/home_bloc.dart';

import 'package:go_router/go_router.dart';

class CampingSitePage extends StatefulWidget {
  final int locationId;
  const CampingSitePage({super.key, required this.locationId});

  @override
  State<CampingSitePage> createState() => _CampingSitePageState();
}

class _CampingSitePageState extends State<CampingSitePage> {
  String _campingLocationName = "Loading...";
  final SaveNameCampLocation saveNameCampLocation = SaveNameCampLocation();

  @override
  void initState() {
    super.initState();
    _fetchCampingLocationSites();
  }

  void _fetchCampingLocationSites() {
    context
        .read<HomeBloc>()
        .add(HomeEventGetCampingSite(locationId: widget.locationId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeStateSuccessCampingSite) {
              return FutureBuilder<String?>(
                future: saveNameCampLocation.getCampLocationName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      _campingLocationName,
                      style: AppTextStyle.medium20,
                    );
                  } else {
                    return Text(
                      snapshot.data ?? _campingLocationName,
                      style: AppTextStyle.medium20,
                    );
                  }
                },
              );
            }
            return Text(_campingLocationName, style: AppTextStyle.medium20);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/home'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5), // Ketebalan garis
          child: Divider(
            height: 1,
            thickness: 1,
            color: MyColor().secondaryColor, // Warna garis
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeStateError) {
            return Center(child: Text(state.message));
          } else if (state is HomeStateSuccessCampingSite) {
            final campingData = state.campingSite;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                itemCount: campingData.length,
                itemBuilder: (context, index) {
                  final site = campingData[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: CampingCard(
                      key: ValueKey(site.id),
                      imageUrl: site.imageUrl,
                      title: site.name,
                      location: '$_campingLocationName, Jawa Timur, Indonesia',
                      rating: site.rating,
                      onDetailPressed: () {
                        context.push('/camping-detail/${site.id}');
                      },
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: Text("Data tidak ditemukan"));
        },
      ),
    );
  }
}
