import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailCampingSitePage extends StatefulWidget {
  final int campingSiteLocationId;
  final int campingSiteId;
  const DetailCampingSitePage(
      {super.key,
      required this.campingSiteLocationId,
      required this.campingSiteId});

  @override
  State<DetailCampingSitePage> createState() => _DetailCampingSitePageState();
}

class _DetailCampingSitePageState extends State<DetailCampingSitePage> {
  @override
  void initState() {
    // TODO: implement initState
    _fetchDataDetailSites();
    super.initState();
  }

  void _fetchDataDetailSites() {
    context.read<HomeBloc>().add(HomeEventGetDetailSites(
        campingLocationId: widget.campingSiteLocationId,
        campingSiteId: widget.campingSiteId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Grafik Hasil Sentimen",
          style: AppTextStyle.medium20,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>
              context.push('/camping-site/${widget.campingSiteLocationId}'),
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
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama: ${site.name}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Lokasi: ${site.location}"),
                  const SizedBox(height: 8),
                  Text("Rating: ${site.rating}"),
                  const SizedBox(height: 8),
                  Text("Review: ${site.total_reviews}"),
                  const SizedBox(height: 8),
                  Image.network(site.imageUrl),
                ],
              ),
            );
          }

          if (state is HomeStateError) {
            return Center(child: Text('Terjadi kesalahan: ${state.message}'));
          }

          return const Center(child: Text('Memuat data...'));
        },
      ),
    );
  }
}
