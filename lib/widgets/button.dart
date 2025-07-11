import 'package:banzai/styles/appColors.dart';
import 'package:banzai/styles/appText.dart';
import 'package:banzai/styles/responsive.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    required this.title,
    required this.onPressed,
    this.primary = true,
    super.key

  });

  final String title;
  final void Function() onPressed;
  final bool primary;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {

    double sizeButton = Responsive.isMobile(context) ? Responsive.width(context) * 0.3 : Responsive.width(context) * 0.4;

    return SizedBox(
      width: Responsive.isMobile(context)
          ? Responsive.width(context) * 0.7
          : Responsive.width(context) * 0.8,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.primary ? AppColors.primary : AppColors.white,
          foregroundColor: widget.primary ? AppColors.white : AppColors.primary,
          overlayColor: AppColors.darkPrimary,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: widget.primary
                ? BorderSide.none
                : BorderSide(color: AppColors.primary, width: 1),
          ),
        ),
        child: Center(
          child: Text(
              widget.title,
            style: AppText.Button1,
          ),
        ),
      ),
    );

  }
}
