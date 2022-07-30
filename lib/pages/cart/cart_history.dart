import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;
    var totalPayCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time.toString());
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm: a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(
        text: outputDate,
        size: Dimensions.font20,
        color: Colors.grey[800],
        fontWeight: FontWeight.w400,
      );
    }

    return Scaffold(
      backgroundColor:
          getCartHistoryList.length > 0 ? Colors.white10 : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: Center(
          child: BigText(
            text: "Cart History",
            size: Dimensions.font26 * 0.9,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: getCartHistoryList.length > 0
          ? Column(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height10,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemsPerOrder.length; i++)
                        Container(
                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          padding: EdgeInsets.only(
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2,
                            left: Dimensions.width10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCounter),
                              SizedBox(height: Dimensions.height10),
                              Wrap(
                                direction: Axis.vertical,
                                children: List.generate(
                                  itemsPerOrder[i],
                                  (index) {
                                    if (listCounter <
                                        getCartHistoryList.length) {
                                      listCounter++;
                                    }
                                    return SizedBox(
                                      height: Dimensions.height20 * 3,
                                      width: Dimensions.width20 * 18,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: Dimensions.height20 * 3.1,
                                            height: Dimensions.height20 * 3,
                                            margin: EdgeInsets.only(
                                                bottom:
                                                    Dimensions.height10 / 2),
                                            // decoration: BoxDecoration(
                                            //   image: DecorationImage(
                                            //     fit: BoxFit.cover,
                                            //     image: NetworkImage(AppConstants
                                            //             .BASE_URL +
                                            //         AppConstants.UPLOAD_URL +
                                            //         getCartHistoryList[
                                            //                 listCounter - 1]
                                            //             .img!),
                                            //   ),
                                            //   borderRadius:
                                            //       BorderRadius.circular(
                                            //     Dimensions.radius15 / 2,
                                            //   ),
                                            //   color: Colors.white,
                                            // ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 2),
                                              child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: AppConstants.BASE_URL +
                                                      AppConstants.UPLOAD_URL +
                                                      getCartHistoryList[
                                                              listCounter - 1]
                                                          .img!,
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Center(
                                                          child:
                                                              Icon(Icons.error))),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: Dimensions.height20 * 3,
                                              margin: EdgeInsets.only(
                                                left: Dimensions.width10,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  BigText(
                                                    text:
                                                        '${getCartHistoryList[listCounter - 1].name}',
                                                    color: Colors.grey[600],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      BigText(
                                                        size: 18,
                                                        text:
                                                            "${getCartHistoryList[listCounter - 1].price}",
                                                        color: Colors.grey[600],
                                                      ),
                                                      Icon(
                                                        CupertinoIcons
                                                            .money_dollar,
                                                        size: Dimensions
                                                            .iconSize16,
                                                        color: Colors.grey[600],
                                                      ),
                                                      BigText(
                                                        text:
                                                            "x ${getCartHistoryList[listCounter - 1].quantity}",
                                                        color: Colors.grey[600],
                                                        size: 18,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Dimensions.height10 /
                                                              2),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: Dimensions.height10 / 2),
                              const Divider(height: 1),
                              SizedBox(height: Dimensions.height10 / 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BigText(
                                      text:
                                          'Total Pay(${itemsPerOrder[i]} items):'),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (() {
                                        var totalPay = 0;
                                        for (int l = 0;
                                            l < itemsPerOrder[i];
                                            l++) {
                                          totalPay += getCartHistoryList[
                                                      totalPayCounter]
                                                  .price! *
                                              getCartHistoryList[
                                                      totalPayCounter]
                                                  .quantity!;
                                          totalPayCounter <
                                                  getCartHistoryList.length
                                              ? totalPayCounter++
                                              : 0;
                                        }
                                        return BigText(
                                          size: 20,
                                          fontWeight: FontWeight.w400,
                                          text: "$totalPay",
                                        );
                                      }()),
                                      Icon(
                                        CupertinoIcons.money_dollar,
                                        size: Dimensions.iconSize16,
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var orderTime = cartOrderTimeToList();
                                      Map<int, CartModel> moreOrder = {};
                                      for (int j = 0;
                                          j < getCartHistoryList.length;
                                          j++) {
                                        if (getCartHistoryList[j].time ==
                                            orderTime[i]) {
                                          moreOrder.putIfAbsent(
                                              getCartHistoryList[j].id!,
                                              () => CartModel.fromJson(
                                                  jsonDecode(jsonEncode(
                                                      getCartHistoryList[j]))));
                                        }
                                      }
                                      Get.find<CartController>().setItems =
                                          moreOrder;
                                      Get.snackbar(
                                        "Cart history",
                                        "Added to cart successfully!",
                                        backgroundColor: AppColors.mainColor,
                                        colorText: Colors.white,
                                        duration: const Duration(seconds: 1),
                                        icon: const Icon(
                                          CupertinoIcons.check_mark,
                                          color: Colors.white,
                                        ),
                                      );
                                      Get.toNamed(RouteHelper.getCartPage());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10,
                                        vertical: Dimensions.height10 / 1.5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15 / 2),
                                        border: Border.all(
                                            width: 1,
                                            color: AppColors.mainColor),
                                      ),
                                      child: BigText(
                                        text: 'One more',
                                        color: AppColors.mainColor,
                                        size: Dimensions.font16 * 0.9,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ))
              ],
            )
          : const NoDataPage(text: 'You didn\'t buy anything so far!'),
    );
  }
}
