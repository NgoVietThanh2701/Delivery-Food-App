import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import '../widgets/big_text.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;

  const NoDataPage(
      {Key? key,
      required this.text,
      this.imgPath = "assets/image/empty_cart.png"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.height45 * 2.5),
        Image.asset(
          imgPath,
          width: Dimensions.width20 * 13,
        ),
        Center(
          child: BigText(
            text: text,
            size: Dimensions.font26 * 0.7,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
