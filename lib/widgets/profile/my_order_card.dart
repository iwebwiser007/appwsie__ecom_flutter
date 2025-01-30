import 'package:appwise_ecom/models/orders_list_model.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:flutter/material.dart';

import '../../../utils/text_utility.dart';
import '../../screens/dashboard/profile/my_order_detail_screen.dart';
import '../../utils/app_spaces.dart';
import 'order_status_button.dart';

Widget myOrderCard(BuildContext context, OrdersListItemModel orderItem) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 20),
    child: Card(
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: "Order ${safeString(orderItem.orderNumber.toString())}",
                  fontsize: 16,
                ),
                AppText(
                  text: safeString(orderItem.date),
                  fontsize: 12,
                  textColor: const Color(0xff9B9B9B),
                ),
              ],
            ),
            appSpaces.spaceForHeight15,
            showItemInRow(title: "Tracking number: ", subtitle: safeString(orderItem.trackingNumber)),
            appSpaces.spaceForHeight5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showItemInRow(title: "Quantity: ", subtitle: safeString(orderItem.quantity.toString())),
                showItemInRow(title: "Total Amount: ", subtitle: showPrice(orderItem.totalAmount.toString())),
              ],
            ),
            appSpaces.spaceForHeight15,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                orderStatusButton(
                  title: "Details",
                  useInCard: true,
                  isActive: false,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOrderDetailScreen()));
                  },
                ),
                AppText(
                  text: safeString(orderItem.status),
                  textColor: Colors.green,
                  fontsize: 14,
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget showItemInRow({
  required String title,
  required String subtitle,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
}) {
  return Row(
    // mainAxisAlignment: mainAxisAlignment,
    children: [
      AppText(
        text: title,
        fontsize: 14,
        textColor: const Color(0xff9B9B9B),
      ),
      appSpaces.spaceForWidth20,
      AppText(
        overflow: TextOverflow.ellipsis,
        text: subtitle,
        fontsize: 14,
        maxLines: 1,
      ),
    ],
  );
}
