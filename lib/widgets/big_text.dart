import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow textOverflow;
  FontWeight fontWeight;
  BigText({
    Key? key,
    this.color = const Color(0xFF332D2B),
    required this.text,
    this.size = 0,
    this.textOverflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: fontWeight,
        fontFamily: 'Roboto',
      ),
    );
  }
}
