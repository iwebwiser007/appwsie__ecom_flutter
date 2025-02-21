import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/user_cart_items.dart';
import 'package:appwise_ecom/riverpod/user_data_riverpod.dart';
import 'package:appwise_ecom/screens/dashboard/cart/checkout_screen.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/widgets/cart_item_widget.dart';
import 'package:appwise_ecom/widgets/no_data_found_widget.dart';
import 'package:appwise_ecom/widgets/screen_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../riverpod/bottom_bar_index_provider.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';
import '../../../utils/common_utils.dart';

class BagScreen extends ConsumerStatefulWidget {
  const BagScreen({super.key});

  @override
  ConsumerState<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends ConsumerState<BagScreen> {
  bool _isLoader = false;
  UserCartModel? cartData;
  double totalCartPrice = 0;

  void getAllCategories() async {
    final userId = ref.read(userDataProvider)?.id;

    try {
      _isLoader = true;
      setState(() {});
      ApiResponse response = await RequestUtils().getRequest(
        url: '${ServiceUrl.getAllCartItems}?user_id=$userId',
      );

      if (response.statusCode == 200) {
        final UserCartModel responseData = UserCartModel.fromJson(
          response.data['data'],
        );
        print(responseData);
        cartData = responseData;
        totalCartPrice = double.parse(cartData?.totalCartPrice.toString() ?? "0");
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

  List<String> getProductIdArray(List<CartItems> cartItems) {
    List<String> productIds = [];

    for (var item in cartItems) {
      productIds.addAll(
        List.filled(item.quantity ?? 0, item.productId.toString()),
      );
    }

    return productIds;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        ref.read(bottomBarIndexProvider.notifier).update(0);
      },
      child: Scaffold(
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
              if (_isLoader) ...[
                const Loader()
              ] else if (cartData!.cartItems!.isEmpty && !_isLoader) ...[
                const Expanded(
                  child: NoDataFoundWidget(),
                )
              ] else ...[
                Expanded(
                  child: ListView.builder(
                    itemCount: cartData?.cartItems?.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        currentIndex: index,
                        cartItems: cartData!.cartItems!,
                        cartItem: cartData!.cartItems![index],
                        updatetotalCartAmount: (increasedAmount, isIncreased) {
                          if (isIncreased) {
                            totalCartPrice = double.parse(
                              (totalCartPrice + increasedAmount).toString(),
                            );
                          } else {
                            totalCartPrice = double.parse(
                              (totalCartPrice - increasedAmount).toString(),
                            );
                          }
                          setState(() {});
                        },
                        trailing: const Icon(
                          Icons.close,
                          color: Color(0xFF9B9B9B),
                          size: 20,
                        ),
                      );
                    },
                  ),
                ),
                TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    hintText: "Enter your promo code",
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Handle promo code submission
                          // print("Promo Code: ${_controller.text}");
                        },
                      ),
                    ),
                  ),
                ),
                appSpaces.spaceForHeight30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(
                      text: 'Total Amount:',
                      textColor: AppColor.greyTextColor,
                    ),
                    AppText(
                      text: showPrice(totalCartPrice.toString()),
                      fontWeight: FontWeight.bold,
                      fontsize: 18,
                    ),
                  ],
                ),
              ],
              appSpaces.spaceForHeight20,
              CustomButton(
                text: 'Checkout',
                onPressed: () {
                  if (cartData!.cartItems!.isNotEmpty) {
                    context.push(
                      CheckoutScreen(
                        totalAmount: totalCartPrice,
                        productIds: getProductIdArray(cartData!.cartItems!),
                        productName: cartData?.cartItems?.first.productDetails?.productName,
                      ),
                    );
                  } else {
                    Utils.snackBar('Please add items to checkout', context);
                  }
                },
              ),
              appSpaces.spaceForHeight10,
            ],
          ),
        ),
      ),
    );
  }
}
