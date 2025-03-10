import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/features/home/presentation/bloc/home_bloc.dart';

class CampingSitePage extends StatefulWidget {
  final int locationId;
  const CampingSitePage({super.key, required this.locationId});

  @override
  State<CampingSitePage> createState() => _CampingSitePageState();
}

class _CampingSitePageState extends State<CampingSitePage> {
  @override
  void initState() {
    super.initState();
    _fetchCampingSiteDetails();
  }

  void _fetchCampingSiteDetails() {
    context
        .read<HomeBloc>()
        .add(HomeEventGetCampingSite(locationId: widget.locationId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Camping Site")),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeStateError) {
            return Center(child: Text(state.message));
          } else if (state is HomeStateSuccessCampingSite) {
            final site = state.campingSite;
            print(site);
            return Text("HH");
          }
          return Center(child: Text("Data tidak ditemukan"));
        },
      ),
    );
  }
}
