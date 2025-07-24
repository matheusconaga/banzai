import 'package:banzai_novo/app/core/constants/appColors.dart';
import 'package:banzai_novo/app/core/constants/appText.dart';
import 'package:banzai_novo/app/core/constants/responsive.dart';
import 'package:flutter/material.dart';


class FormInput extends StatefulWidget {
  const FormInput({
    required this.controller,
    required this.hint,
    required this.title,
    this.obscure = false,
    this.icon,
    this.type = TextInputType.text,
    this.maxLines = 1,
    this.validator,
    this.onSaved,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final String title;
  final bool obscure;
  final Icon? icon;
  final TextInputType type;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {

  bool _obscure = true;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscure;
    _controller = widget.controller;
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isMobile(context)
          ? Responsive.width(context) * 0.8
          : Responsive.width(context) * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppText.Button1.copyWith(color: AppColors.hoverPrimary),
          ),
          TextFormField(
            validator: widget.validator,
            obscureText: _obscure,
            controller: _controller,
            keyboardType: widget.type,
            maxLines: widget.obscure ? 1 : widget.maxLines,
            onSaved: widget.onSaved,
            style: AppText.Body1.copyWith(color: AppColors.grey),
            decoration: InputDecoration(
              errorStyle: AppText.Body2.copyWith(color: AppColors.red),
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hint,
              prefixIcon: widget.icon != null
                  ? Icon(
                widget.icon!.icon,
                color: AppColors.grey,
              )
                  : null,
              hintStyle: const TextStyle(color: AppColors.grey),
              contentPadding: const EdgeInsets.fromLTRB(12, 8,12,8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.lightGrey,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.red,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.red,
                  width: 2,
                ),
              ),
              suffixIcon: widget.obscure
                  ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primary,
                ),
              ) : null,
            ),
          ),
        ],
      ),
    );
  }
}
