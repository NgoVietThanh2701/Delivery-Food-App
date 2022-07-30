import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          Dimensions.radius15,
        ),
        boxShadow: [
          BoxShadow(
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 1,
              spreadRadius: 1)
        ],
      ),
      margin: EdgeInsets.only(
        left: Dimensions.width10,
        right: Dimensions.width10,
        bottom: Dimensions.height20,
      ),
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.width10,
        bottom: Dimensions.height10,
      ),
      child: Row(children: [
        appIcon,
        SizedBox(width: Dimensions.width20),
        bigText,
      ]),
    );
  }
}
