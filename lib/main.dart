import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_camping_frontend/core/routes/route.dart';
import 'package:flutter_camping_frontend/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Camping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: RouteCamping().router,
    );
  }
}
