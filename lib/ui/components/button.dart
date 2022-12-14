import 'package:flutter/material.dart';
import 'package:mim_generator/styles.dart';

class Button extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color color;
  final Color splashColor;
  final VoidCallback? onPressed;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  final TextStyle defaultTextStyle = const TextStyle(
    color: Color(0xFF50494B),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  IconData? icon;

  Button({
    Key? key,
    this.onPressed,
    this.margin,
    this.padding,
    this.width,
    this.textColor,
    this.color = const Color(0xFFFFFFFF),
    this.splashColor = const Color(0x7D000000),
    this.text = "",
    this.textStyle,
    this.icon,
  }) : super(key: key);

  TextStyle _textStyle() {
    if (textStyle != null) {
      return textStyle!;
    }

    if (textColor != null) {
      return TextStyle(color: textColor);
    }

    return defaultTextStyle;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          padding: padding ??
              const EdgeInsets.only(
                top: 12,
                bottom: 12,
                left: 10,
                right: 10,
              ),
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.normal,
          ),
          primary: splashColor,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            if (icon != null)
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Icon(
                  icon,
                  color: _textStyle().color,
                  size: defaultTextStyle.fontSize! * 1.5,
                ),
              ),
            Expanded(
              child: Text(
                text,
                style: defaultTextStyle.merge(_textStyle()),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
