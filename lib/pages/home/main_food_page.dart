import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    //print('width:' + MediaQuery.of(context).size.width.toString());
    return Scaffold(
        body: Column(
      children: [
        // show the header
        Container(
          // something
          child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height35, bottom: Dimensions.height10),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: 'Quang Nam', color: AppColors.mainColor),
                    Row(
                      children: [
                        SmallText(text: "Hoi An", color: Colors.black54),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    height: Dimensions.height45,
                    width: Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.iconSize24,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // show the body
        const Expanded(
          child: SingleChildScrollView(
            child: FoodPageBody(),
          ),
        )
      ],
    ));
  }
}
