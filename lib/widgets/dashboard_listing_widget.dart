// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:appwise_ecom/models/home_screen_products_model.dart';
import 'package:appwise_ecom/widgets/product_item_widget.dart';

import '../utils/text_utility.dart';

class ProductListWidget extends StatelessWidget {
  final String headerTitle;
  final String headerSubtitle;
  final bool isNew;
  final bool showHeader;
  final List<HomeScreenProduct> productsList;

  const ProductListWidget({
    super.key,
    required this.headerTitle,
    required this.headerSubtitle,
    this.isNew = false,
    this.showHeader = true,
    this.productsList = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: headerTitle,
                      fontsize: 34,
                      fontWeight: FontWeight.w700,
                      // height: 1.2,
                      fontfamily: GoogleFonts.poppins().fontFamily,
                    ),
                    // const SizedBox(
                    //   height: 4,
                    // ),
                    // AppText(
                    //   text: headerSubtitle,
                    //   textColor: const Color(0xFF9B9B9B),
                    //   fontsize: 12,
                    //   height: 1.2,
                    //   fontfamily: GoogleFonts.poppins().fontFamily,
                    // ),
                  ],
                ),
                AppText(
                  text: 'View all',
                  fontsize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  fontfamily: GoogleFonts.poppins().fontFamily,
                ),
              ],
            ),
          ),
        SizedBox(
          height: 330,
          child: ListView.builder(
            itemCount: productsList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductItemWidgetForHome(
                isNew: isNew,
                product: productsList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
