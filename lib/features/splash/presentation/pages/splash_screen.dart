import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_loading.dart';
import 'package:flutter_camping_frontend/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SplashCubit>().checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) async {
        print('Current state: $state');
        await Future.delayed(
            const Duration(seconds: 2)); // <- kasih delay 2 detik
        if (state is SplashStateLoggedIn) {
          // ignore: use_build_context_synchronously
          context.go('/home');
        } else if (state is SplashStateNotLoggedIn) {
          // ignore: use_build_context_synchronously
          context.go('/login');
        }
      },
      child: const Scaffold(
        body: Center(
          child:
              CustomLoading(asset: 'assets/animations/welcomeAnimation.json'),
        ),
      ),
    );
  }
}
