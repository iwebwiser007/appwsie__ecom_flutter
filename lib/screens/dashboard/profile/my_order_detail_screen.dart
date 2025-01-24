import 'package:appwise_ecom/widgets/product_item_tile_widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_spaces.dart';
import '../../../utils/text_utility.dart';
import '../../../widgets/profile/my_order_card.dart';

class MyOrderDetailScreen extends StatefulWidget {
  const MyOrderDetailScreen({super.key});

  @override
  State<MyOrderDetailScreen> createState() => _MyOrderDetailScreenState();
}

class _MyOrderDetailScreenState extends State<MyOrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const AppText(
          text: "Order Details",
          fontsize: 16,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appSpaces.spaceForHeight20,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: "Order №1947034",
                    fontsize: 16,
                  ),
                  AppText(
                    text: "05-12-2019",
                    fontsize: 12,
                    textColor: Color(0xff9B9B9B),
                  ),
                ],
              ),
              appSpaces.spaceForHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showItemInRow(title: "Tracking number: ", subtitle: "IW3475453455"),
                  const AppText(
                    text: 'Delivered',
                    textColor: Colors.green,
                    fontsize: 14,
                  )
                ],
              ),
              appSpaces.spaceForHeight10,
              const AppText(
                text: "3 items",
                fontsize: 14,
              ),
              appSpaces.spaceForHeight20,
              const ProductItemTileWidget(),
              const ProductItemTileWidget(),
              const ProductItemTileWidget(),
              appSpaces.spaceForHeight30,
              const AppText(
                text: "Order information",
                fontsize: 14,
              ),
              appSpaces.spaceForHeight20,
              showItemInRow(title: "Shipping Address: ", subtitle: "3 Newbridge Court ,Chino", mainAxisAlignment: MainAxisAlignment.spaceBetween),
              appSpaces.spaceForHeight25,
              showItemInRow(title: "Payment method: ", subtitle: "**** **** **** 3947", mainAxisAlignment: MainAxisAlignment.spaceBetween),
              appSpaces.spaceForHeight25,
              showItemInRow(title: "Delivery method: ", subtitle: "FedEx, 3 days, 15\$", mainAxisAlignment: MainAxisAlignment.spaceBetween),
              appSpaces.spaceForHeight25,
              showItemInRow(title: "Discount: ", subtitle: "10%, Personal promo code", mainAxisAlignment: MainAxisAlignment.spaceBetween),
              appSpaces.spaceForHeight25,
              showItemInRow(title: "Total Amount: ", subtitle: "133\$", mainAxisAlignment: MainAxisAlignment.spaceBetween),
              appSpaces.spaceForHeight25,
            ],
          ),
        ),
      ),
    );
  }
}
