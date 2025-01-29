// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/customs/custom_cached_image.dart';
import 'package:appwise_ecom/models/user_cart_items.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:flutter/material.dart';

import '../utils/text_utility.dart';

class CartItemWidget extends StatelessWidget {
  final Widget? trailing;
  final CartItems cartItem;

  const CartItemWidget({
    super.key,
    this.trailing,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                  imageUrl: safeString(cartItem.productDetails?.productImage),
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
                    text: safeString(cartItem.productDetails?.productName),
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      AppText(
                        text: 'Color:',
                        fontsize: 12,
                        textColor: Colors.grey,
                      ),
                      AppText(
                        text: 'Black',
                        fontsize: 12,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      AppText(
                        text: 'Size:',
                        fontsize: 12,
                        textColor: Color(0xFF9B9B9B),
                      ),
                      AppText(
                        text: 'L',
                        fontsize: 12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Container(
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
                      const SizedBox(width: 15),
                      AppText(
                        text: safeString(cartItem.quantity.toString()),
                      ),
                      const SizedBox(width: 15),
                      Container(
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
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (trailing != null)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: trailing,
                ),
                AppText(
                  text: showPrice(cartItem.productDetails?.productPrice.toString()),
                  fontsize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
