import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/screens/dashboard/cart/order_success_screen.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/widgets/address_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Checkout'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  text: 'Shipping Adress',
                  fontWeight: FontWeight.w600,
                ),
                appSpaces.spaceForHeight10,
                const AddressTileWidget(
                    // adress: ,
                    ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Payment',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle "Change" action
                            },
                            child: const Text(
                              'Change',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Card Information
                      Row(
                        children: [
                          // Card Logo
                          Container(
                            width: 50,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              // image: const DecorationImage(
                              //   image: AssetImage(''),
                              //   fit: BoxFit.contain,
                              // ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Card Number
                          const Text(
                            '**** **** **** 3947',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: 'Order::',
                      textColor: AppColor.greyTextColor,
                      fontsize: 14,
                    ),
                    AppText(
                      text: '\$124',
                      fontWeight: FontWeight.w600,
                      fontsize: 18,
                    ),
                  ],
                ),
                appSpaces.spaceForHeight10,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: 'Delivery::',
                      textColor: AppColor.greyTextColor,
                      fontsize: 14,
                    ),
                    AppText(
                      text: '\$124',
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                appSpaces.spaceForHeight10,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: 'Summary:',
                      textColor: AppColor.greyTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                    AppText(
                      text: '\$124',
                      fontWeight: FontWeight.w700,
                      fontsize: 18,
                    ),
                  ],
                ),
                appSpaces.spaceForHeight20,
                CustomButton(
                  text: 'Submit Order',
                  onPressed: () {
                    context.push(const OrderSuccessScreen());
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
