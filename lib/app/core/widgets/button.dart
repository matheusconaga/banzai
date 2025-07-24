import 'package:banzai_novo/app/core/constants/appColors.dart';
import 'package:banzai_novo/app/core/constants/appText.dart';
import 'package:banzai_novo/app/core/constants/responsive.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    required this.title,
    required this.onPressed,
    this.image,
    this.primary = true,
    super.key

  });

  final String title;
  final void Function() onPressed;
  final String? image;
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
          backgroundColor: widget.primary ? AppColors.primary : Colors.white,
          foregroundColor: widget.primary ? AppColors.white : AppColors.primary,
          overlayColor: AppColors.darkPrimary,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: widget.primary
                ? BorderSide.none
                : const BorderSide(color: AppColors.primary, width: 1),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.image != null) ...[
                Image.asset(
                  widget.image!,
                  width: 25,
                  height: 25,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.title,
                style: AppText.Button1,
              ),
            ],
          ),
        ),
      ),
    );

  }
}
