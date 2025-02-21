import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/riverpod/shipping_address_provider.dart';
import 'package:appwise_ecom/screens/dashboard/cart/add_address_screen.dart';
import 'package:appwise_ecom/screens/dashboard/cart/order_success_screen.dart';
import 'package:appwise_ecom/screens/dashboard/cart/payfast_webview.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/common_utils.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/widgets/address_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../models/address_list_item_model.dart';
import '../../../riverpod/user_data_riverpod.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  final double? totalAmount;
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
  String serviceLevelCode = '';
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

  void addOrderDetials(String grandTotal) async {
    try {
      isLoading = true;
      setState(() {});
      final userId = ref.read(userDataProvider)?.id;
      final addressData = ref.read(shippingAddressProvider);

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.addOrderUrl,
        body: {
          "user_id": userId,
          "shipping_id": 0,
          "delivery_id": addressData?.id.toString(),
          "delivery_option": "",
          "shipping_charges": shippingCharges.toString(),
          "coupon_code": "",
          "coupon_amount": 0,
          "order_status": "processing",
          "payment_method": "",
          "payment_gateway": "",
          "grand_total": grandTotal,
          "courier_name": "",
          "tracking_number": "",
          "is_pushed": "0"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        addTransactionDetials(grandTotal, response.data['data']['id'].toString());
        createShippingOrder(grandTotal, response.data['data']['id'].toString());
      } else {
        isLoading = false;
      }

      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
      AppConst.showConsoleLog(e);
    }
  }

  void addTransactionDetials(String grandTotal, String orderId) async {
    try {
      setState(() {});
      final userId = ref.read(userDataProvider)?.id;

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.addTransactionDetails,
        body: {
          "order_id": orderId,
          "user_id": userId.toString(),
          "amount": grandTotal,
          "payment_status": "paid",
          // "transaction_id": "PFOQMIYU1N2RAM",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
      }

      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
      AppConst.showConsoleLog(e);
    }
  }

  void createShippingOrder(String grandTotal, String orderId) async {
    try {
      setState(() {});
      final userId = ref.read(userDataProvider)?.id;
      final addressData = ref.read(shippingAddressProvider);

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.createShippingOrderUrl,
        body: {
          "company_Id": "1",
          "delivery_Id": addressData?.id.toString(),
          "product_Id": widget.productIds,
          "user_Id": userId.toString(),
          "order_Id": orderId,
          "service_level_code": serviceLevelCode,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        context.push(const OrderSuccessScreen());
        Utils.snackBar('Order Placed successfully!', context);
        isLoading = false;
      }

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
        if (response.data['data']['rates'] != null) {
          shippingCharges = response.data['data']['rates'][0]['base_rate']['charge'];
          serviceLevelCode = response.data['data']['rates'][0]['service_level']['code'];
        } else {
          shippingCharges = 0;
        }
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
      "return_url": returnUrl,
      "cancel_url": cancelUrl,
      "notify_url": notifyUrl,
    }).toString();
  }

  void openPayFast(String url) async {
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   throw "Could not launch $url";
    // }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PayFastWebView(
          url: url,
          onPaymentCompleted: (p0) {
            if (p0 == 'success') {
              addOrderDetials(widget.totalAmount.toString());
            }
          },
        ),
      ),
    );
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
            if (isLoading) ...[
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Loader(),
              ),
            ] else ...[
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
                      getShippingCharges: getShippingCharges,
                    ),
                  ] else ...[
                    CustomButton(
                      text: 'Add Address',
                      onPressed: () {
                        context.push(
                          AddAddressScreen(
                            getShippingAddressesList,
                          ),
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
                        text: showPrice('${widget.totalAmount}'),
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
                        text: showPrice('$shippingCharges'),
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
                        text: showPrice('${widget.totalAmount! + shippingCharges}'),
                        fontWeight: FontWeight.w700,
                        fontsize: 18,
                      ),
                    ],
                  ),
                  appSpaces.spaceForHeight20,
                  CustomButton(
                    text: 'Submit Order',
                    onPressed: () {
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
            ]
          ],
        ),
      ),
    );
  }
}
