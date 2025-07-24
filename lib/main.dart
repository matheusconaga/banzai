import "package:banzai_novo/app/core/constants/appTheme.dart";
import "package:banzai_novo/app/core/widgets/splash_page.dart";
import "package:banzai_novo/app/features/auth/view_model/auth_view_model.dart";
import "package:banzai_novo/routes/routeGenerator.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Banzai",
      home: const SplashPage(),
      theme: AppTheme.theme,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
