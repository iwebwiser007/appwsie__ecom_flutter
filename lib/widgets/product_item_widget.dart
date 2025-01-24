// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/screens/dashboard/products/product_details_screen.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  final bool isNew;
  final bool isFavoriteScreen;
  final Widget? trailing;

  const ProductItemWidget({
    super.key,
    required this.isNew,
    this.isFavoriteScreen = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(ProductDetailsScreen());
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    'assets/images/product_img.png',
                    height: 184,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 15,
                  child: !isNew
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const AppText(
                            text: '-20%',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontsize: 12,
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const AppText(
                            text: 'New',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontsize: 12,
                          ),
                        ),
                ),
                if (trailing != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: trailing!,
                  ),
                Positioned(
                  bottom: 8,
                  right: 8,
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
                      : const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 16,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        fontsize: 12,
                        textColor: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const AppText(
                    text: 'Dorothy Perkins',
                    fontsize: 12,
                    textColor: Colors.grey,
                  ),
                  const SizedBox(height: 4),
                  const AppText(
                    text: 'Blouse',
                    fontsize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      AppText(
                        text: '\$21',
                        fontsize: 14,
                        textColor: Colors.grey,
                        textdecoration: TextDecoration.lineThrough,
                      ),
                      SizedBox(width: 8),
                      AppText(
                        text: '\$14',
                        fontsize: 14,
                        fontWeight: FontWeight.bold,
                        textColor: AppColor.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
