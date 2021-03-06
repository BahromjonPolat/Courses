import 'package:courses/components/size_config.dart';
import 'package:courses/constants/colors.dart';
import 'package:flutter/material.dart';

class SetTextWidget extends StatelessWidget {
  final String _text;
  final Color? textColor;
  FontWeight? weight;
  double? size;
  int? maxLines;

  SetTextWidget(
    this._text, {
    Key? key,
    this.textColor,
    this.weight,
    this.size,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        color: textColor ?? ConstColors.black,
        fontSize: size ?? getProportionateScreenWidth(14.0),
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}
