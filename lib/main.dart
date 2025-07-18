import "package:banzai/app/core/constants/appTheme.dart";
import "package:banzai/app/core/widgets/splash_page.dart";
import "package:banzai/app/features/auth/view_model/auth_view_model.dart";
import "package:banzai/routes/routeGenerator.dart";
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
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Banzai",
      home: SplashPage(),
      theme: AppTheme.theme,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
