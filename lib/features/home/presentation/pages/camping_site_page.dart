import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_sites.dart';
import 'package:flutter_camping_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location_with_sites.dart';
import 'package:go_router/go_router.dart';

class CampingSitePage extends StatefulWidget {
  final int locationId;
  const CampingSitePage({super.key, required this.locationId});

  @override
  State<CampingSitePage> createState() => _CampingSitePageState();
}

class _CampingSitePageState extends State<CampingSitePage> {
  String _campingLocationName = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchCampingLocationWithSites();
  }

  void _fetchCampingLocationWithSites() {
    context.read<HomeBloc>().add(
        HomeEventGetCampingLocationWithSites(locationId: widget.locationId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeStateSuccessCampingLocationWithSites) {
              return Text(
                state.campingLocationWithSites.locationName,
                style: AppTextStyle.medium20,
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
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeStateSuccessCampingLocationWithSites) {
            setState(() {
              _campingLocationName =
                  state.campingLocationWithSites.locationName;
            });
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeStateError) {
              return Center(child: Text(state.message));
            } else if (state is HomeStateSuccessCampingLocationWithSites) {
              final campingData = state.campingLocationWithSites;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListView.builder(
                  itemCount: campingData.campingSites.length,
                  itemBuilder: (context, index) {
                    final site = campingData.campingSites[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: CampingCard(
                        imageUrl: site.imageUrl,
                        title: site.name,
                        location:
                            '${campingData.locationName}, Jawa Timur, Indonesia',
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
      ),
    );
  }
}
