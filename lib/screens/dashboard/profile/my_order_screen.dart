import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/widgets/screen_title_widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_spaces.dart';
import '../../../widgets/profile/my_order_card.dart';
import '../../../widgets/profile/order_status_button.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final items = ["Delivered", "Processing", "Cancelled"];
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenTitleWidget(title: "My Orders"),
            appSpaces.spaceForHeight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items.mapIndexed(
                (index, item) {
                  return orderStatusButton(
                    title: item,
                    isActive: _currentIndex == index,
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            appSpaces.spaceForHeight20,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [1, 2, 3, 4, 5].mapIndexed(
                    (p0, p1) {
                      return myOrderCard(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
