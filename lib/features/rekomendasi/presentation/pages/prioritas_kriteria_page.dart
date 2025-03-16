import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_button.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/rekomendasi_bloc.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/user_preference_criteria_model.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_camping_frontend/core/services/preference.dart';

class PrioritasKriteriaPage extends StatefulWidget {
  const PrioritasKriteriaPage({super.key});

  @override
  State<PrioritasKriteriaPage> createState() => _PrioritasKriteriaPageState();
}

class _PrioritasKriteriaPageState extends State<PrioritasKriteriaPage> {
  final UserPreferenceService userPreference = UserPreferenceService();

  /// Mapping ID ke Nama Kriteria
  final Map<String, int> criteriaMapping = {
    'Keamanan': 1,
    'Kenyamanan': 2,
    'Kebersihan': 3,
    'Kemudahan Transportasi': 4,
  };

  List<Map<String, dynamic>> myTiles = [
    {'name': 'Keamanan', 'weight': 9.0},
    {'name': 'Kenyamanan', 'weight': 7.0},
    {'name': 'Kebersihan', 'weight': 5.0},
    {'name': 'Kemudahan Transportasi', 'weight': 3.0},
  ];

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _savePreferences() async {
    final rekomendasiBloc = context.read<RekomendasiBloc>();

    print("myTiles setelah update weight: $myTiles");

    // Konversi ke Model UserPreferenceCriteriaModel sesuai urutan myTiles saat ini
    List<UserPreferenceCriteriaModel> preferences = myTiles
        .map((tile) => UserPreferenceCriteriaModel(
              criteria_id: criteriaMapping[tile['name']]!,
              weight: tile['weight'], // Menggunakan nilai yang ada
            ))
        .toList();

    print("Event dikirim ke Bloc dengan data: $preferences");

    // Simpan ke SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData =
        jsonEncode(preferences.map((e) => e.toJson()).toList());
    await prefs.setString("user_preferences", encodedData);

    // Kirim ke Bloc
    rekomendasiBloc
        .add(RekomendasiEventSaveUserPreferenceCriteria(preferences));

    context.pop();
  }

  Future<void> _loadUserPreferences() async {
    List<Map<String, dynamic>> preferences =
        await userPreference.getPreferences();
    setState(() {
      myTiles = preferences;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Prioritas Kriteria",
          style: AppTextStyle.medium20,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: MyColor().customOrange),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Divider(
            height: 1,
            thickness: 1,
            color: MyColor().secondaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
                    child: Text(
                      "Masukkan urutan prioritas kriteriamu",
                      style: AppTextStyle.bold24,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: MyColor().customGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Terdapat 4 kriteria terkait pemilihan lokasi camping. Silahkan isi seberapa penting kriteria berdasarkan preferensi Anda dengan menggeser perbandingan di bawah ini.",
                      style: AppTextStyle.regular12.copyWith(
                        color: MyColor().darkGrey,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 400,
                    child: ReorderableListView(
                      children: [
                        for (int i = 0; i < myTiles.length; i++)
                          ListTile(
                            key: Key('$i'),
                            title: Text(myTiles[i]['name']),
                          ),
                      ],
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final item = myTiles.removeAt(oldIndex);
                          myTiles.insert(newIndex, item);

                          // Update weight berdasarkan posisi baru
                          for (int i = 0; i < myTiles.length; i++) {
                            myTiles[i]['weight'] =
                                9.0 - (i * 2.0); // Misal, menyesuaikan skala
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<RekomendasiBloc, RekomendasiState>(
              builder: (context, state) {
                if (state is RekomendasiStateLoading) {
                  return CircularProgressIndicator();
                } else if (state is RekomendasiStateError) {
                  return Text(
                    "Error: ${state.message}",
                    style: TextStyle(color: Colors.red),
                  );
                }
                return CustomButton(
                  btnText: "Temukan Rekomendasi",
                  onPressed: _savePreferences,
                );
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
