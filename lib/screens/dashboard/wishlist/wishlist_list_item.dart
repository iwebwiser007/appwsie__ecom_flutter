// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/user_wishlist_items.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/text_utility.dart';

import '../products/product_details_screen.dart';

class WishlistListItem extends StatelessWidget {
  final bool isFavoriteScreen;
  final Widget? trailing;
  final UserWishlistItems? product;

  const WishlistListItem({
    super.key,
    this.isFavoriteScreen = false,
    this.trailing,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          ProductDetailsScreen(
            productId: product?.productDetails?.id.toString(),
            productName: product?.productDetails?.name,
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
                      child: CachedNetworkImage(
                        imageUrl: safeString(product?.productDetails?.imageUrl),
                        errorWidget: (context, url, error) => const Icon(Icons.error_outline),
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
                          text: safeString(product?.productDetails?.productName),
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 150,
                          child: AppText(
                            text: safeString(product?.productDetails?.description),
                            fontsize: 11,
                            textColor: Colors.grey,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < 4 ? Icons.star : Icons.star_outline,
                                color: index < 4 ? AppColor.startYellow : Colors.grey,
                                size: 16,
                              );
                            }),
                            const SizedBox(width: 4),
                            const AppText(
                              text: '(10)',
                              fontsize: 10,
                              textColor: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        AppText(
                          text: showPrice(product?.productDetails?.productPrice.toString()),
                          fontsize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
                if (trailing != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: trailing,
                  )
              ],
            ),
          ),
          Positioned(
            right: 15,
            bottom: 05,
            child: isFavoriteScreen
                ? Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
                : Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_outline,
                        // color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
