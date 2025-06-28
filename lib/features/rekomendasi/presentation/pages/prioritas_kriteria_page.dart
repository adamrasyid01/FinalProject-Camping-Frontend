import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_button.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_dialog.dart';
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
  final MyColor myColor = MyColor();

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
  }

  Future<void> _loadUserPreferences() async {
    List<Map<String, dynamic>> preferences =
        await userPreference.getPreferences();

    // print("Data dari SharedPreferences: $preferences");
    setState(() {
      myTiles = preferences;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RekomendasiBloc, RekomendasiState>(
      listener: (context, state) {
        if (state is RekomendasiStateSuccess) {
          context.pop(true); // Kembali ke halaman sebelumnya
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Prioritas Kriteria",
            style: AppTextStyle.medium20,
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.info_outline, color: MyColor().customOrange),
              onPressed: () {
                showCustomDialog(
                  context: context,
                  onConfirm: () {},
                  title: 'Rumus yang digunakan',
                  content:
                      '1. Sistem menetapkan nilai dari kriteriamu sebagai bobot.\n'
                      '2. Sistem akan menormalisasi bobot untuk mendapatkan bobot setiap kriteria.\n'
                      '3. Sistem akan menghitung bobot dari alternatif berdasarkan setiap kriteria.\n'
                      '4. Sistem akan mengalikan bobot kriteriamu dengan bobot alternatif untuk setiap kriteria, lalu jumlahkan hasilnya untuk mendapatkan skor total setiap alternatif.',
                  icon: Icons.info_outline,
                  titleStyle: AppTextStyle.bold18,
                  contentStyle: AppTextStyle.regular14,
                  alignContent: TextAlign.justify,
                  iconBackgroundColor: MyColor().customOrange,
                );
              },
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
              color: myColor.secondaryColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12.0, 16.0, 12.0),
                      child: Text(
                        "Masukkan urutan prioritas kriteriamu",
                        style: AppTextStyle.bold24,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: myColor.customOrange, // Warna latar solid
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: myColor.customOrange.withOpacity(0.3),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.touch_app, color: Colors.white),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Seret dan lepas kriteria untuk menyusun urutan prioritasmu. Posisi pertama menunjukkan kriteria paling penting.",
                              style: AppTextStyle.semiBold16.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 320,
                      child: ReorderableListView(
                        proxyDecorator: (Widget child, int index,
                            Animation<double> animation) {
                          return Material(
                            elevation: 4,
                            color: Colors.transparent,
                            child: child,
                          );
                        },
                        buildDefaultDragHandles:
                            false, // Matikan drag handle bawaan
                        children: [
                          for (int i = 0; i < myTiles.length; i++)
                            ReorderableDragStartListener(
                              key: ValueKey(i),
                              index: i,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                margin: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      myTiles[i]['name'],
                                      style: AppTextStyle.semiBold18,
                                    ),
                                    Text(
                                      _getSubtitle(myTiles[i]['name']),
                                      style: AppTextStyle.regular12,
                                    ),
                                  ],
                                ),
                              ),
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
                              myTiles[i]['weight'] = 9.0 - (i * 2.0);
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
      ),
    );
  }
}

String _getSubtitle(String name) {
  switch (name) {
    case 'Keamanan':
      return 'Tingkat keamanan pada wilayah camping';
    case 'Kenyamanan':
      return 'Kondisi fasilitas dan lingkungan sekitar';
    case 'Kebersihan':
      return 'Seberapa bersih area camping';
    case 'Kemudahan Transportasi':
      return 'Aksesibilitas menuju lokasi camping';
    default:
      return '';
  }
}
