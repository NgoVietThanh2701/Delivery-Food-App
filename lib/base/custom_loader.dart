import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        'i am printing loadting state: ${Get.find<AuthController>().isLoading}');
    return Center(
      child: Container(
        height: Dimensions.height20 * 4,
        width: Dimensions.height20 * 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimensions.radius20 * 2,
          ),
          color: AppColors.mainColor,
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
