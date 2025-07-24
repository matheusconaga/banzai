import 'package:banzai_novo/app/core/constants/appColors.dart';
import 'package:banzai_novo/app/core/constants/appText.dart';
import 'package:flutter/material.dart';

class AppLink extends StatefulWidget {
  const AppLink({
    required this.title,
    required this.func,
    super.key
  });

  final String title;
  final void Function() func;

  @override
  State<AppLink> createState() => _AppLinkState();
}

class _AppLinkState extends State<AppLink> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.func,
      child: Text(
        widget.title,
        style: AppText.Button1.copyWith(color: AppColors.primary),
      ),
    );
  }
}
