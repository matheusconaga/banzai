import 'package:banzai/styles/appColors.dart';
import 'package:banzai/styles/responsive.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  const AppButton({super.key});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {


    double sizeButton = Responsive.isMobile(context) ? Responsive.width(context) * 0.3 : Responsive.width(context) * 0.4;

    return ElevatedButton(
        onPressed: (){
          print("OLHAE");
        },
        child: Text(
            "Button"
        ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        overlayColor: AppColors.darkPrimary,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: sizeButton ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}
