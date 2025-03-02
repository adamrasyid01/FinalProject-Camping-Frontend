import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/routes/route.dart';
import 'package:flutter_camping_frontend/core/services/injection.dart';
import 'package:flutter_camping_frontend/core/services/observer.dart';
import 'package:flutter_camping_frontend/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_camping_frontend/features/splash/presentation/cubit/splash_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Bloc.observer = MyObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => myInjection<AuthenticationBloc>(),
        ),
        BlocProvider(create: (context) => myInjection<SplashCubit>()),
      ],
      child: Builder(builder: (context) {
        return SafeArea(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Camping App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerConfig: RouteCamping().router,
          ),
        );
      }),
    );
  }
}
