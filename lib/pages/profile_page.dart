import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_button.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_dialog.dart';
import 'package:flutter_camping_frontend/pages/help_support_page.dart';
import 'package:flutter_camping_frontend/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_camping_frontend/core/services/save_user.dart'; // ⬅️ Tambahkan ini
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  final MyColor myColor = MyColor();
  final SaveUser saveUser = SaveUser(); // ⬅️ Tambahkan ini

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
            context.go('/login');
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                future: Future.wait([
                  saveUser.getUsername(),
                  saveUser.getEmail(),
                ]),
                builder: (context, AsyncSnapshot<List<String?>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  final username = snapshot.data?[0] ?? 'Pengguna';
                  final email = snapshot.data?[1] ?? 'Tidak ada email';

                  return Container(
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
                          username,
                          style:
                              AppTextStyle.bold24.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: AppTextStyle.regular14
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              CustomButton(
                btnText: "Pusat Bantuan",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpSupportPage()),
                  );
                },
                fontSize: 18,
                btnTextColor: myColor.customBlack,
                btnColor: myColor.customWhite,
              ),
              const SizedBox(height: 8),
              CustomButton(
                btnText: "Logout",
                onPressed: () {
                  showCustomDialog(
                    context: context,
                    onConfirm: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationEventLogout());
                    },
                    title: 'Logout',
                    content: 'Apakah Anda yakin ingin logout dari aplikasi?',
                    canceledText: 'Batal',
                    confirmedText: 'Logout',
                    icon: Icons.logout,
                    iconBackgroundColor: Colors.red,
                  );
                },
                btnColor: myColor.customRed,
              ),
              const SizedBox(height: 12),
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
