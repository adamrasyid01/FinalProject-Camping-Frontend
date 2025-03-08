import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_button.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/user_preference_criteria.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/rekomendasi_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_slider.dart';

class PrioritasKriteriaPage extends StatefulWidget {
  const PrioritasKriteriaPage({super.key});

  @override
  State<PrioritasKriteriaPage> createState() => _PrioritasKriteriaPageState();
}

class _PrioritasKriteriaPageState extends State<PrioritasKriteriaPage> {
  double keamanan = 0.5;
  double kenyamanan = 0.5;
  double kebersihan = 0.5;
  double kemudahanTransportasi = 0.5;

  void _savePreferences() {
    final rekomendasiBloc = context.read<RekomendasiBloc>();

    List<UserPreferenceCriteria> preferences = [
      UserPreferenceCriteria(criteria_id: 1, weight: keamanan),
      UserPreferenceCriteria(criteria_id: 2, weight: kenyamanan),
      UserPreferenceCriteria(criteria_id: 3, weight: kebersihan),
      UserPreferenceCriteria(criteria_id: 4, weight: kemudahanTransportasi),
    ];

    rekomendasiBloc
        .add(RekomendasiEventSaveUserPreferenceCriteria(preferences));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
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
                    CustomSlider(
                      title: "Keamanan",
                      value: keamanan,
                      onChanged: (value) => setState(() => keamanan = value),
                    ),
                    CustomSlider(
                      title: "Kenyamanan",
                      value: kenyamanan,
                      onChanged: (value) => setState(() => kenyamanan = value),
                    ),
                    CustomSlider(
                      title: "Kebersihan",
                      value: kebersihan,
                      onChanged: (value) => setState(() => kebersihan = value),
                    ),
                    CustomSlider(
                      title: "Kemudahan Transportasi",
                      value: kemudahanTransportasi,
                      onChanged: (value) =>
                          setState(() => kemudahanTransportasi = value),
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
                  } else if (state is RekomendasiStateSuccess) {
                    return Text(
                      "Data berhasil disimpan!",
                      style: TextStyle(color: Colors.green),
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
