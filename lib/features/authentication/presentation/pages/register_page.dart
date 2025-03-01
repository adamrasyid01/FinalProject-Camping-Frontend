import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_button.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyColor myColor = MyColor();
    return Scaffold(
      resizeToAvoidBottomInset: false, // ✅ Menghindari overflow
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: Column(
          children: [
            Expanded(
              // ✅ Agar bisa di-scroll jika konten melebihi layar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bagian atas (Logo + Teks)
                  SvgPicture.asset('assets/images/adamCampiio.svg'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("REGISTER", style: AppTextStyle.bold20),
                        Text(
                          "Silakan masukkan data diri Anda untuk membuat akun. ",
                          style: AppTextStyle.regular12.copyWith(
                            color: myColor.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextfield(
                    inputController: TextEditingController(),
                    label: 'Nama',
                    hintText: 'Nama',
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    inputController: TextEditingController(),
                    label: 'Email',
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    inputController: TextEditingController(),
                    label: 'Password',
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    inputController: TextEditingController(),
                    label: 'Konfirmasi Password',
                    hintText: 'Konfirmasi Password',
                  ),
                ],
              ),
            ),

            // Bagian bawah (Tombol)
            CustomButton(
              btnText: "Buat Akun",
              onPressed: () {},
            ),
            const SizedBox(height: 4),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Sudah mempunyai akun? ",
                  style: AppTextStyle.regular14.copyWith(
                    color: myColor.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: AppTextStyle.bold14.copyWith(
                        color: myColor.greenCustom,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}
