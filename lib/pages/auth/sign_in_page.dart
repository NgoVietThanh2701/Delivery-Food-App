import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      //var authController = Get.find<AuthController>();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.screenHeight * 0.02),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.25,
                          child: const Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/image/logo part 1.png"),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            bottom: Dimensions.height35,
                          ),
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello!',
                                style: TextStyle(
                                  fontSize: Dimensions.font20 * 3 +
                                      Dimensions.font20 / 2,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Text(
                                'Sign into your account',
                                style: TextStyle(
                                    fontSize: Dimensions.font20,
                                    color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                        AppTextField(
                          textController: phoneController,
                          hintText: 'Phone',
                          icon: Icons.phone,
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          textController: passwordController,
                          hintText: 'Password',
                          icon: Icons.password,
                          isObscure: true,
                        ),
                        SizedBox(height: Dimensions.height15),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            RichText(
                              text: TextSpan(
                                // recognizer: TapGestureRecognizer()
                                //   ..onTap = () => Get.back(),
                                text: "Sign in to continues?",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20 * 0.8,
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.width20),
                          ],
                        ),
                        SizedBox(height: Dimensions.screenHeight * 0.04),
                        GestureDetector(
                          onTap: () {
                            _login(authController);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: Dimensions.height20),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width20 * 2.2,
                              vertical: Dimensions.height15 * 0.8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: AppColors.mainColor,
                            ),
                            child: BigText(
                              text: 'Sign In',
                              size: Dimensions.font26,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.screenHeight * 0.04),
                        RichText(
                          text: TextSpan(
                            text: "Don\'t an account?",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(
                                        () => const SignUpPage(),
                                        transition: Transition.cupertino,
                                        duration:
                                            const Duration(milliseconds: 1000),
                                      ),
                                text: ' Create',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.mainColor,
                                  fontSize: Dimensions.font20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const CustomLoader();
          },
        ));
  }
}
