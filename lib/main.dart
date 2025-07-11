import "package:banzai/pages/auth.dart";
import "package:banzai/styles/appTheme.dart";
import "package:flutter/material.dart";

void main (){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Banzai",
      home: Auth(),
      theme: AppTheme.theme,
    ),
  );
}