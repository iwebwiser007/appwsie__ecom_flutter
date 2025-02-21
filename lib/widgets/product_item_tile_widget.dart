// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/orders/order_details_model.dart';
import '../models/product_item_model.dart';
import '../screens/dashboard/products/product_details_screen.dart';
import '../services/product_service.dart';

class ProductItemTileWidget extends ConsumerStatefulWidget {
  final bool isFavoriteScreen;
  final Widget? trailing;
  final ProductItemModel? product;

  const ProductItemTileWidget({
    super.key,
    this.isFavoriteScreen = false,
    this.trailing,
    this.product,
  });

  @override
  ConsumerState<ProductItemTileWidget> createState() => _ProductItemTileWidgetState();
}

class _ProductItemTileWidgetState extends ConsumerState<ProductItemTileWidget> {
  late ProductService productService;
  bool isWhislisted = false;

  @override
  void initState() {
    print(widget.product?.isWishlisted);
    isWhislisted = widget.product?.isWishlisted ?? false;
    productService = ProductService(ref: ref, context: context);

    super.initState();
  }

  void _handleAddToWishlist() async {
    bool added = await productService.addToWishlist(
      widget.product!.id!.toString(),
    );
    if (added) {
      setState(() {
        isWhislisted = true;
      });
    }
  }

  void _handleRemoveFromWishlist() async {
    bool removed = await productService.removeItemWishlist(
      widget.product!.id!.toString(),
    );
    if (removed) {
      setState(() {
        isWhislisted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          ProductDetailsScreen(
            productId: widget.product?.id.toString(),
            productName: widget.product?.productName,
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
                        imageUrl: safeString(widget.product?.productImage),
                        errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                        fit: BoxFit.contain,
                        width: 130,
                        height: 120,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: safeString(widget.product?.productName),
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 150,
                          child: AppText(
                            text: safeString(widget.product?.description),
                            fontsize: 11,
                            textColor: Colors.grey,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (widget.product != null && widget.product!.averageRating != null)
                          Row(
                            children: [
                              ...List.generate(5, (index) {
                                return Icon(
                                  index < widget.product!.averageRating! ? Icons.star : Icons.star_outline,
                                  color: index < widget.product!.averageRating! ? AppColor.startYellow : Colors.grey,
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
                          text: showPrice(widget.product?.productPrice.toString()),
                          fontsize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
                if (widget.trailing != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.trailing,
                  )
              ],
            ),
          ),
          Positioned(
            right: 15,
            bottom: 05,
            child: widget.isFavoriteScreen
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
                      onPressed: () {
                        if (isWhislisted) {
                          _handleRemoveFromWishlist();
                        } else {
                          _handleAddToWishlist();
                        }
                      },
                      icon: Icon(
                        isWhislisted ? Icons.favorite : Icons.favorite_outline,
                        color: isWhislisted ? Colors.red : Colors.black,
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

class OrderProductItemWidget extends ConsumerStatefulWidget {
  final Products? product;

  const OrderProductItemWidget({
    super.key,
    this.product,
  });

  @override
  ConsumerState<OrderProductItemWidget> createState() => _OrderProductItemWidgetState();
}

class _OrderProductItemWidgetState extends ConsumerState<OrderProductItemWidget> {
  @override
  void initState() {
    // print(widget.product?.is);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          ProductDetailsScreen(
            productId: widget.product?.id.toString(),
            productName: widget.product?.productName,
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
                        imageUrl: safeString(widget.product?.imageUrl),
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
                          text: safeString(widget.product?.productName),
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        // SizedBox(
                        //   width: 150,
                        //   child: AppText(
                        //     text: safeString(widget.product.),
                        //     fontsize: 11,
                        //     textColor: Colors.grey,
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                        Row(
                          children: [
                            AppText(
                              text: 'Color:',
                              fontsize: 12,
                              textColor: Colors.grey,
                            ),
                            AppText(
                              text: safeString(widget.product?.productColor).capitalizeFirstLetter(),
                              fontsize: 12,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            const AppText(
                              text: 'Size:',
                              fontsize: 12,
                              textColor: Color(0xFF9B9B9B),
                            ),
                            AppText(
                              text: safeString(widget.product?.productSize).capitalizeFirstLetter(),
                              fontsize: 12,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        const SizedBox(height: 8),
                        AppText(
                          text: showPrice(widget.product?.productPrice.toString()),
                          fontsize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
