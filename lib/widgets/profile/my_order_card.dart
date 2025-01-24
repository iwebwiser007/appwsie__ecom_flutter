import 'package:flutter/material.dart';

import '../../../utils/text_utility.dart';
import '../../screens/dashboard/profile/my_order_detail_screen.dart';
import '../../utils/app_spaces.dart';
import 'order_status_button.dart';

Widget myOrderCard(BuildContext context) {
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
            appSpaces.spaceForHeight15,
            showItemInRow(title: "Tracking number: ", subtitle: "IW3475453455"),
            appSpaces.spaceForHeight5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showItemInRow(title: "Quantity: ", subtitle: "3"),
                showItemInRow(title: "Total Amount: ", subtitle: "112\$"),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderDetailScreen()));
                  },
                ),
                const AppText(
                  text: 'Delivered',
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
