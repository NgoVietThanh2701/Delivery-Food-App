import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height20 * 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: CupertinoIcons.arrow_left,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24 * 0.8,
                  ),
                  GestureDetector(
                    onTap: (() {
                      Get.toNamed(RouteHelper.getInitial());
                    }),
                    child: AppIcon(
                      icon: CupertinoIcons.home,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24 * 0.9,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: Dimensions.height20 * 4,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (cartController) {
                        var _cartList = cartController.getItems;
                        return _cartList.length > 0
                            ? ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (() {
                                      var popularIndex =
                                          Get.find<PopularProductController>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product);
                                      if (popularIndex >= 0) {
                                        Get.toNamed(RouteHelper.getPopularFood(
                                            popularIndex, 'cart-page'));
                                      } else {
                                        var recommendedIndex = Get.find<
                                                RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product);
                                        if (recommendedIndex < 0) {
                                          Get.snackbar(
                                            "History product",
                                            "Product review is no available for history product!",
                                            backgroundColor:
                                                AppColors.mainColor,
                                            colorText: Colors.white,
                                            duration:
                                                const Duration(seconds: 1),
                                            icon: const Icon(
                                              CupertinoIcons.xmark,
                                              color: Colors.white,
                                            ),
                                          );
                                        } else {
                                          Get.toNamed(
                                              RouteHelper.getRecommendedFood(
                                                  recommendedIndex,
                                                  'cart-page'));
                                        }
                                      }
                                    }),
                                    child: SizedBox(
                                      height: Dimensions.height20 * 5,
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            // decoration: BoxDecoration(
                                            //   image: DecorationImage(
                                            //     fit: BoxFit.cover,
                                            //     image: NetworkImage(
                                            //       "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${cartController.getItems[index].img}",
                                            //     ),
                                            //   ),
                                            //   borderRadius:
                                            //       BorderRadius.circular(
                                            //     Dimensions.radius20,
                                            //   ),
                                            //   color: Colors.white,
                                            // ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${cartController.getItems[index].img}",
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: Dimensions.height20 * 5,
                                              margin: EdgeInsets.only(
                                                  left: Dimensions.width10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  BigText(
                                                      text:
                                                          "${_cartList[index].name}",
                                                      color: Colors.grey[700]),
                                                  SmallText(
                                                    text: "Spice",
                                                    size: 15,
                                                    color: AppColors.signColor,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          BigText(
                                                            text:
                                                                "${cartController.getItems[index].price}",
                                                            color: Colors
                                                                .grey[700],
                                                          ),
                                                          Icon(
                                                            CupertinoIcons
                                                                .money_dollar,
                                                            size: Dimensions
                                                                .iconSize16,
                                                            color: Colors
                                                                .grey[700],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          width: Dimensions
                                                                  .width20 *
                                                              4),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: Dimensions
                                                              .height10,
                                                          bottom: Dimensions
                                                              .height10,
                                                          left: Dimensions
                                                              .width10,
                                                          right: Dimensions
                                                              .width10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                          color: Colors.white,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: (() {
                                                                cartController
                                                                    .addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  -1,
                                                                );
                                                              }),
                                                              child: const Icon(
                                                                  Icons.remove,
                                                                  color: AppColors
                                                                      .signColor),
                                                            ),
                                                            SizedBox(
                                                                width: Dimensions
                                                                        .width10 /
                                                                    2),
                                                            BigText(
                                                              text:
                                                                  '${_cartList[index].quantity}',
                                                            ),
                                                            SizedBox(
                                                                width: Dimensions
                                                                        .width10 /
                                                                    2),
                                                            GestureDetector(
                                                              onTap: (() {
                                                                cartController
                                                                    .addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1,
                                                                );
                                                              }),
                                                              child: const Icon(
                                                                  Icons.add,
                                                                  color: AppColors
                                                                      .signColor),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          BigText(
                                                            text:
                                                                "${_cartList[index].price! * _cartList[index].quantity!}",
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          Icon(
                                                            CupertinoIcons
                                                                .money_dollar,
                                                            size: Dimensions
                                                                .iconSize16,
                                                            color: Colors.red,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const NoDataPage(text: 'Your cart is empty!');
                      },
                    )),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return cartController.getItems.length > 0
                ? Container(
                    height: Dimensions.bottomHeightBar,
                    padding: EdgeInsets.only(
                      top: Dimensions.height15 * 2,
                      bottom: Dimensions.height15 * 2,
                      left: Dimensions.width20,
                      right: Dimensions.radius20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        topRight: Radius.circular(Dimensions.radius20 * 2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                              top: Dimensions.height15,
                              bottom: Dimensions.height15,
                              left: Dimensions.width15,
                              right: Dimensions.width10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                              color: Colors.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BigText(text: 'Total Pay: '),
                                SizedBox(width: Dimensions.width10 / 2),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                      text: '${cartController.totalAmount}',
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w700,
                                      size: Dimensions.font26 * 1.2,
                                    ),
                                    Icon(
                                      CupertinoIcons.money_dollar,
                                      size: Dimensions.iconSize24,
                                      color: Colors.red,
                                    ),
                                  ],
                                )
                              ],
                            )),
                        GestureDetector(
                          onTap: () {
                            if (Get.find<AuthController>().userLoggedIn()) {
                              cartController.addToHistory();
                            } else {
                              Get.toNamed(RouteHelper.getSignInPage());
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: Dimensions.height15,
                              bottom: Dimensions.height15,
                              left: Dimensions.width10,
                              right: Dimensions.width10,
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                color: AppColors.mainColor),
                            child: BigText(
                              text: 'Check out',
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox();
          },
        ));
  }
}
