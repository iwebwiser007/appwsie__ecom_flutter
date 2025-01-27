import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/user_cart_items.dart';
import 'package:appwise_ecom/screens/dashboard/cart/checkout_screen.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/widgets/cart_item_widget.dart';
import 'package:appwise_ecom/widgets/screen_title_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_constant.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';
import '../../../utils/common_utils.dart';

class BagScreen extends StatefulWidget {
  const BagScreen({super.key});

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  bool _isLoader = false;
  List<UserCartItems> cartItems = [];

  void getAllCategories() async {
    try {
      _isLoader = true;
      setState(() {});
      ApiResponse response = await RequestUtils().getRequest(
        url: '${ServiceUrl.getAllCartItems}?user_id=48',
      );

      if (response.statusCode == 200) {
        final List<UserCartItems> responseData = UserCartItems.fromList(
          List.from(response.data['data']),
        );
        print(responseData);
        cartItems = responseData;

        // Utils.snackBar(response.data['message'], context);
      } else {
        // Utils.snackBar(response.error.toString(), context);
      }

      _isLoader = false;
      setState(() {});
    } catch (e) {
      _isLoader = false;
      setState(() {});

      Utils.snackBar(e.toString(), context);

      AppConst.showConsoleLog(e);
    }
  }

  @override
  void initState() {
    getAllCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        forceMaterialTransparency: true,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenTitleWidget(title: 'My Bag'),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return const CartItemWidget(
                    trailing: Icon(
                      Icons.more_vert,
                      color: Color(0xFF9B9B9B),
                      size: 20,
                    ),
                  );
                },
              ),
            ),
            appSpaces.spaceForHeight30,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: 'Total Amount:',
                  textColor: AppColor.greyTextColor,
                ),
                AppText(
                  text: '\$124',
                  fontWeight: FontWeight.bold,
                  fontsize: 18,
                ),
              ],
            ),
            appSpaces.spaceForHeight20,
            CustomButton(
              text: 'Checkout',
              onPressed: () {
                context.push(const CheckoutScreen());
              },
            ),
            appSpaces.spaceForHeight10,
          ],
        ),
      ),
    );
  }
}
