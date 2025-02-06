import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/riverpod/shipping_address_provider.dart';
import 'package:appwise_ecom/screens/dashboard/cart/add_address_screen.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/widgets/address_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_constant.dart';
import '../../../models/address_list_item_model.dart';
import '../../../riverpod/user_data_riverpod.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  final int? totalAmount;
  final String? productName;
  final List<String>? productIds;

  const CheckoutScreen({
    this.productName,
    this.productIds,
    this.totalAmount,
    super.key,
  });

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  bool isLoading = false;
  List<AddressListItemModel> addressList = [];
  int shippingCharges = 0;
  bool isOnlineSelected = true;

  void getShippingAddressesList() async {
    final userId = ref.read(userDataProvider)?.id;
    final addressData = ref.read(shippingAddressProvider);

    try {
      isLoading = true;
      setState(() {});

      ApiResponse response = await RequestUtils().getRequest(
        url: "${ServiceUrl.getShippingAddressesList}?user_id=$userId",
      );

      if (response.statusCode == 200) {
        addressList = AddressListItemModel.fromList(
          List.from(response.data['data']),
        );

        if (addressList.isNotEmpty && addressData == null) {
          ref.read(shippingAddressProvider.notifier).update(addressList.first);
        }
        getShippingCharges(addressData!.id.toString());
      }

      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
      AppConst.showConsoleLog(e);
    }
  }

  void getShippingCharges(String addressId) async {
    try {
      isLoading = true;
      setState(() {});

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.calculateShippingChargesUrl,
        body: {
          "company_Id": "1",
          "delivery_Id": addressId.toString(),
          "product_Id": widget.productIds,
        },
      );

      if (response.statusCode == 200) {
        shippingCharges = response.data['data']['rates'][0]['base_rate']['charge'];
      }

      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
      AppConst.showConsoleLog(e);
    }
  }

  @override
  void initState() {
    getShippingAddressesList();
    super.initState();
  }

  String generatePayFastUrl({
    required String merchantId,
    required String merchantKey,
    required double amount,
    required String itemName,
    required String returnUrl,
    required String cancelUrl,
    required String notifyUrl,
  }) {
    return Uri.https("sandbox.payfast.co.za", "/eng/process", {
      "merchant_id": merchantId,
      "merchant_key": merchantKey,
      "amount": amount.toStringAsFixed(2),
      "item_name": itemName,
      // "return_url": returnUrl,
      // "cancel_url": cancelUrl,
      // "notify_url": notifyUrl,
    }).toString();
  }

  void openPayFast(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedAddress = ref.watch(shippingAddressProvider);

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
                if (addressList.isNotEmpty) ...[
                  AddressTileWidget(
                    adress: selectedAddress,
                  ),
                ] else ...[
                  CustomButton(
                    text: 'Add Address',
                    onPressed: () {
                      context.push(
                        AddAddressScreen(() {}),
                      );
                    },
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'Payment',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: Checkbox(
                              side: const BorderSide(
                                color: AppColor.greyTextColor,
                              ),
                              checkColor: Colors.white,
                              activeColor: Colors.black,
                              fillColor: isOnlineSelected
                                  ? null
                                  : const WidgetStatePropertyAll(
                                      Colors.white,
                                    ),
                              value: isOnlineSelected,
                              onChanged: (bool? newValue) {
                                isOnlineSelected = newValue!;
                                setState(() {});
                              },
                            ),
                          ),

                          const SizedBox(width: 12),
                          // Card Number
                          const Text(
                            'Online Payment',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(
                      text: 'Order::',
                      textColor: AppColor.greyTextColor,
                      fontsize: 14,
                    ),
                    AppText(
                      text: '\$${widget.totalAmount}',
                      fontWeight: FontWeight.w600,
                      fontsize: 18,
                    ),
                  ],
                ),
                appSpaces.spaceForHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(
                      text: 'Delivery::',
                      textColor: AppColor.greyTextColor,
                      fontsize: 14,
                    ),
                    AppText(
                      text: '\$$shippingCharges',
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                appSpaces.spaceForHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(
                      text: 'Summary:',
                      textColor: AppColor.greyTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                    AppText(
                      text: '\$${widget.totalAmount! + shippingCharges}',
                      fontWeight: FontWeight.w700,
                      fontsize: 18,
                    ),
                  ],
                ),
                appSpaces.spaceForHeight20,
                CustomButton(
                  text: 'Submit Order',
                  onPressed: () {
                    // return;
                    openPayFast(
                      generatePayFastUrl(
                        merchantId: '10000100',
                        merchantKey: '46f0cd694581a',
                        amount: double.parse('${widget.totalAmount! + shippingCharges}'),
                        itemName: widget.productName ?? "",
                        returnUrl: 'https://www.example.com/payment-success',
                        cancelUrl: 'https://www.example.com/payment-cancel',
                        notifyUrl: 'https://webhook.site/your-custom-webhook-url',
                      ),
                    );
                    // context.push(const OrderSuccessScreen());
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
