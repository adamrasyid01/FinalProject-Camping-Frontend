import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_camping_frontend/features/authentication/presentation/bloc/authentication_bloc.dart';

class ProfilePage extends StatelessWidget {
  final MyColor myColor = MyColor();
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: AppTextStyle.medium20,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Divider(
            height: 1,
            thickness: 1,
            color: myColor.secondaryColor,
          ),
        ),
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationStateInitial) {
            context.go('/login'); // Arahkan ke halaman login setelah logout
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize:
                MainAxisSize.min, // Tidak mengambil seluruh tinggi layar
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [myColor.lightGreen, myColor.darkGreen],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Adam Rasyid",
                      style: AppTextStyle.bold24.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "adamaya@gmail.com",
                      style:
                          AppTextStyle.regular14.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    CustomButton(
                      btnText: "Bantuan & Dukungan",
                      onPressed: () {},
                      fontSize: 18,
                      btnTextColor: myColor.customBlack,
                      btnColor: myColor.customWhite,
                    ),
                    const SizedBox(height: 8),
                    CustomButton(
                      btnText: "Logout",
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationEventLogout());
                      },
                      btnColor: myColor.customRed,
                    ),
                  ],
                ),
              ),
              Text(
                "Version: 1.0.0",
                style: AppTextStyle.medium14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
