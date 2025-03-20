import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_button.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_textfield.dart';
import 'package:flutter_camping_frontend/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MyColor myColor = MyColor();
    return Scaffold(
      resizeToAvoidBottomInset: false, // ✅ Menghindari overflow
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationStateSuccess) {
            context.go('/login');
          } else if (state is AuthenticationStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Something went wrong!"),
              ),
            );
          }
        },
        child: Padding(
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
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Warna latar belakang
                          borderRadius: BorderRadius.circular(
                              20), // Border radius sesuai gambar
                          border: Border.all(
                            color: myColor.customOrange, // Warna border
                            width: 1, // Ketebalan border
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "REGISTER",
                              style: AppTextStyle.bold14.copyWith(
                                color: myColor.customOrange, // Warna teks login
                              ),
                            ),
                            Text(
                              "Silakan masukkan data diri Anda untuk membuat akun. ",
                              style: AppTextStyle.regular12.copyWith(
                                color: myColor
                                    .customOrange, // Warna teks deskripsi
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomTextfield(
                      inputController: _namaController,
                      label: 'Nama',
                      hintText: 'Nama',
                    ),
                    const SizedBox(height: 8),
                    CustomTextfield(
                      inputController: _emailController,
                      label: 'Email',
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 8),
                    CustomTextfield(
                      inputController: _passwordController,
                      label: 'Password',
                      hintText: 'Password',
                    ),
                    const SizedBox(height: 12),
                    CustomTextfield(
                      inputController: _confirmPasswordController,
                      label: 'Konfirmasi Password',
                      hintText: 'Konfirmasi Password',
                    ),
                  ],
                ),
              ),

              // Bagian bawah (Tombol)
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return CustomButton(
                    btnText: "Buat Akun",
                    onPressed: () {
                      // Panggil event untuk registrasi
                      context.read<AuthenticationBloc>().add(
                          AuthenticationEventRegister(
                              name: _namaController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              passwordConfirmation:
                                  _confirmPasswordController.text));
                    },
                  );
                },
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // ✅ Pusatkan teks secara horizontal
                children: [
                  Text(
                    "Sudah mempunyai akun? ",
                    style: AppTextStyle.regular14.copyWith(
                      color: myColor.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go('/login');
                    },
                    child: Text(
                      "Login",
                      style: AppTextStyle.bold14.copyWith(
                        color: myColor.greenCustom,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8)
            ],
          ),
        ),
      ),
    );
  }
}
