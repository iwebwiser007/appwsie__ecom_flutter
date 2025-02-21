// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/constants/app_constant.dart';
import 'package:appwise_ecom/customs/custom_cached_image.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/user_cart_items.dart';
import 'package:appwise_ecom/riverpod/user_data_riverpod.dart';
import 'package:appwise_ecom/services/base_url.dart';
import 'package:appwise_ecom/utils/common_utils.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/dashboard/products/product_details_screen.dart';
import '../services/request.dart';
import '../utils/text_utility.dart';

class CartItemWidget extends ConsumerStatefulWidget {
  final Widget? trailing;
  final CartItems cartItem;
  final List<CartItems> cartItems;
  final Function? updatetotalCartAmount;
  final int? currentIndex;

  const CartItemWidget({
    super.key,
    this.trailing,
    required this.cartItem,
    required this.cartItems,
    this.updatetotalCartAmount,
    this.currentIndex,
  });

  @override
  ConsumerState<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends ConsumerState<CartItemWidget> {
  int quantity = 0;

  @override
  void initState() {
    quantity = widget.cartItem.quantity ?? 0;
    super.initState();
  }

  void updateItemCount(
    String productId,
    String updatedQuantity,
    String size,
    bool isIncreasing,
  ) async {
    try {
      final userId = ref.read(userDataProvider)?.id;

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.cartItemsUpdateUrl,
        body: {
          "user_id": userId,
          "product_id": productId,
          "size": size,
          "quantity": updatedQuantity,
        },
        method: 'PUT',
      );

      if (response.statusCode == 200) {
        quantity = int.parse(updatedQuantity);

        if (isIncreasing) {
          widget.updatetotalCartAmount?.call(
            widget.cartItem.productDetails?.unitPrice,
            isIncreasing,
          );
        } else {
          widget.updatetotalCartAmount?.call(
            widget.cartItem.productDetails?.unitPrice,
            isIncreasing,
          );
        }
        setState(() {});
      } else {
        Utils.snackBar(response.message!, context);
      }

      print(response);
    } catch (e) {
      AppConst.showConsoleLog(e);
    }
  }

  void removeItemFromCart(
    String id,
    String size,
  ) async {
    try {
      final userId = ref.read(userDataProvider)?.id;

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.removeItemFromCart,
        body: {
          "user_id": userId,
          "product_id": id.toString(),
          "size": size,
        },
        method: 'DELETE',
      );

      if (response.statusCode == 200) {
        widget.cartItems.removeAt(widget.currentIndex!);
        widget.updatetotalCartAmount?.call(
          widget.cartItem.productDetails?.unitPrice * quantity,
          false,
        );
        setState(() {});
        Utils.snackBar(response.message!, context);
      }

      print(response);
    } catch (e) {
      AppConst.showConsoleLog(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          ProductDetailsScreen(
            productId: widget.cartItem.productDetails?.id.toString(),
            productName: widget.cartItem.productDetails?.productName,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: CustomCachedImage(
                    imageUrl: safeString(widget.cartItem.productDetails?.productImage),
                    fit: BoxFit.cover,
                    width: 130,
                    height: 120,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: safeString(widget.cartItem.productDetails?.productName),
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // AppText(
                        //   text: 'Color:',
                        //   fontsize: 12,
                        //   textColor: Colors.grey,
                        // ),
                        // AppText(
                        //   text: safeString(widget.cartItem.productDetails?.productCode),
                        //   fontsize: 12,
                        // ),
                        // SizedBox(
                        //   width: 20,
                        // ),
                        const AppText(
                          text: 'Size:',
                          fontsize: 12,
                          textColor: Color(0xFF9B9B9B),
                        ),
                        AppText(
                          text: safeString(widget.cartItem.size),
                          fontsize: 12,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            int updatedQuantity = quantity;
                            updatedQuantity--;

                            updateItemCount(
                              widget.cartItem.productDetails!.id.toString(),
                              updatedQuantity.toString(),
                              widget.cartItem.size.toString(),
                              false,
                            );
                          },
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        AppText(
                          text: safeString(quantity.toString()),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            int updatedQuantity = quantity;
                            updatedQuantity++;

                            updateItemCount(
                              widget.cartItem.productDetails!.id.toString(),
                              updatedQuantity.toString(),
                              widget.cartItem.size.toString(),
                              true,
                            );
                          },
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (widget.trailing != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      removeItemFromCart(
                        widget.cartItems[widget.currentIndex!].productDetails!.id.toString(),
                        widget.cartItems[widget.currentIndex!].size!,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.trailing,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  AppText(
                    text: showPrice(
                      "${widget.cartItem.productDetails?.unitPrice * quantity}",
                    ),
                    fontsize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
