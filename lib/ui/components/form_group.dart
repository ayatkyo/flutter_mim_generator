import 'package:mim_generator/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FormGroup extends StatelessWidget {
  FormGroup({
    super.key,
    required this.label,
    required this.placeholder,
    this.ctrl,
    this.optional = false,
    this.multiline = false,
    this.maxLength,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
  });

  String label;
  String placeholder;
  TextEditingController? ctrl;

  bool optional;
  bool multiline;

  int? maxLength;
  TextInputType? keyboardType;
  Function(String)? onChanged;
  Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.formLabel,
              ),
              if (optional)
                Text(
                  "Opsional",
                  style: AppFonts.secondary(
                    fontSize: 11,
                    color: Colors.black.withOpacity(0.65),
                    fontWeight: FontWeight.w500,
                  ),
                )
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: ctrl,
            keyboardType: keyboardType,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              isDense: true,
              filled: true,
              fillColor: Colors.black.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: AppBorderRadius.normal,
                borderSide: BorderSide.none,
                gapPadding: 0,
              ),
              hintText: placeholder,
              hintStyle: AppFonts.secondary(
                color: Colors.black.withOpacity(0.35),
              ),
            ),
            maxLines: multiline ? null : 1,
            maxLength: maxLength,
            style: AppFonts.secondary(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
