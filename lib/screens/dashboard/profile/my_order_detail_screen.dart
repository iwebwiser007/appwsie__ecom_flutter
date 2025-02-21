// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/customs/custom_confirmation_dialog_box.dart';
import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/orders/order_details_model.dart';
import 'package:appwise_ecom/riverpod/user_data_riverpod.dart';
import 'package:appwise_ecom/utils/common_utils.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:appwise_ecom/widgets/no_data_found_widget.dart';
import 'package:appwise_ecom/widgets/product_item_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';
import '../../../utils/app_spaces.dart';
import '../../../utils/text_utility.dart';
import '../../../widgets/profile/my_order_card.dart';
import '../../../widgets/profile/order_status_button.dart';

class MyOrderDetailScreen extends ConsumerStatefulWidget {
  final String orderId;

  const MyOrderDetailScreen({
    super.key,
    required this.orderId,
  });

  @override
  ConsumerState<MyOrderDetailScreen> createState() => _MyOrderDetailScreenState();
}

class _MyOrderDetailScreenState extends ConsumerState<MyOrderDetailScreen> {
  bool _isLoader = false;
  OrderDetailsModel? orderDetailsData;

  @override
  void initState() {
    getOrderDetails();
    super.initState();
  }

  double showTotalPrice(Iterable<double> prices) {
    return prices.isEmpty ? 0.0 : prices.reduce((sum, price) => sum + price);
  }

  void getOrderDetails() async {
    try {
      _isLoader = true;
      setState(() {});
      ApiResponse response = await RequestUtils().getRequest(
        url: "${ServiceUrl.getOrderDetailsUrl}?order_id=${widget.orderId}",
      );

      print(response.data);

      if (response.statusCode == 200) {
        orderDetailsData = OrderDetailsModel.fromJson(response.data['data']);
      }

      _isLoader = false;
      setState(() {});
    } catch (e) {
      _isLoader = false;
      setState(() {});
      AppConst.showConsoleLog(e);
    }
  }

  void returnOrderFunc() async {
    try {
      // _isLoader = true;
      // setState(() {});
      final userId = ref.read(userDataProvider)!.id;

      final productIds = orderDetailsData?.products?.map((e) {
        return e.id.toString();
      }).toList();

      final Map<String, dynamic> body = {
        "user_id": userId.toString(),
        "order_id": orderDetailsData?.id.toString(),
        "product_ids": productIds,
        "return_reason": "test",
        "tracking_number": orderDetailsData?.trackingNumber ?? "",
      };

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.returnOrderUrl,
        body: body,
      );

      if (response.statusCode == 200) {}

      Utils.snackBar(response.message.toString(), context);
      context.pop();
      // _isLoader = false;
      // setState(() {});
    } catch (e) {
      // _isLoader = false;
      // setState(() {});
      AppConst.showConsoleLog(e);
    }
  }

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
              if (_isLoader) ...[
                const Loader(),
              ] else if (orderDetailsData == null && !_isLoader) ...[
                const NoDataFoundWidget()
              ] else ...[
                appSpaces.spaceForHeight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Order No. ${orderDetailsData?.id}",
                      fontsize: 16,
                    ),
                    AppText(
                      text: safeString(orderDetailsData?.createdAt),
                      fontsize: 12,
                      textColor: const Color(0xff9B9B9B),
                    ),
                  ],
                ),
                appSpaces.spaceForHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showItemInRow(
                      context: context,
                      title: "Tracking number: ",
                      subtitle: safeString(orderDetailsData?.trackingNumber),
                    ),
                    AppText(
                      text: safeString(orderDetailsData?.orderStatus),
                      textColor: Colors.green,
                      fontsize: 14,
                    )
                  ],
                ),
                appSpaces.spaceForHeight10,
                AppText(
                  text: orderDetailsData!.products!.length.toString(),
                  fontsize: 14,
                ),
                appSpaces.spaceForHeight20,
                Column(
                  children: List.generate(
                    orderDetailsData!.products!.length,
                    (index) {
                      return OrderProductItemWidget(
                        product: orderDetailsData!.products![index],
                      );
                    },
                  ),
                ),
                // const ProductItemTileWidget(),
                // const ProductItemTileWidget(),
                // const ProductItemTileWidget(),
                appSpaces.spaceForHeight30,
                const AppText(
                  text: "Order information",
                  fontsize: 14,
                ),
                appSpaces.spaceForHeight20,
                showItemInRow(
                    context: context,
                    title: "Shipping Address: ",
                    subtitle: safeString(orderDetailsData?.address).capitalizeFirstLetter(),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween),
                appSpaces.spaceForHeight25,
                showItemInRow(
                    context: context,
                    title: "Payment method: ",
                    subtitle: safeString(orderDetailsData?.paymentMethod).capitalizeFirstLetter(),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween),
                appSpaces.spaceForHeight25,
                showItemInRow(
                    context: context,
                    title: "Delivery method: ",
                    subtitle: safeString(orderDetailsData?.deliveryOption).capitalizeFirstLetter(),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween),
                // appSpaces.spaceForHeight25,
                // showItemInRow(title: "Discount: ", subtitle: "10%, Personal promo code", mainAxisAlignment: MainAxisAlignment.spaceBetween),
                appSpaces.spaceForHeight25,
                showItemInRow(
                    context: context,
                    title: "Total Amount: ",
                    subtitle: showPrice(showTotalPrice(
                      orderDetailsData!.products!.map(
                        (e) => double.parse(e.productPrice.toString()),
                      ),
                    ).toStringAsFixed(2)),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween),
                appSpaces.spaceForHeight25,
              ],
              orderStatusButton(
                title: "Return Order",
                useInCard: true,
                isActive: false,
                onTap: () {
                  showConfirmDialogBox(
                    context,
                    () {
                      returnOrderFunc();
                    },
                    'Return Order',
                    'Are you sure you want to return this product?',
                    'Confirm',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
