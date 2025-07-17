import "package:banzai/pages/auth.dart";
import "package:banzai/routeGenerator.dart";
import "package:banzai/styles/appTheme.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Banzai",
      home: Auth(),
      theme: AppTheme.theme,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
  );
}