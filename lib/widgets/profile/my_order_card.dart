import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/orders/orders_list_model.dart';
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
            showItemInRow(
              title: "Tracking number: ",
              subtitle: safeString(orderItem.trackingNumber),
              context: context,
            ),
            appSpaces.spaceForHeight5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showItemInRow(
                  title: "Quantity: ",
                  context: context,
                  subtitle: safeString(orderItem.quantity.toString()),
                ),
                showItemInRow(
                  title: "Total Amount: ",
                  context: context,
                  subtitle: showPrice(orderItem.totalAmount.toString()),
                ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyOrderDetailScreen(
                          orderId: orderItem.orderNumber.toString(),
                        ),
                      ),
                    );
                  },
                ),
                AppText(
                  text: safeString(orderItem.status).capitalizeFirstLetter(),
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
  required BuildContext context,
  required String title,
  required String subtitle,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText(
        text: title.capitalizeFirstLetter(),
        fontsize: 14,
        textColor: const Color(0xff9B9B9B),
      ),
      appSpaces.spaceForWidth20,
      Flexible(
        child: AppText(
          overflow: TextOverflow.ellipsis,
          softwrap: true,
          text: subtitle.capitalizeFirstLetter(),
          fontsize: 14,
          maxLines: 3,
        ),
      ),
    ],
  );
}
