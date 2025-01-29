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
              // return Container(
              //   width: 200,
              //   margin: const EdgeInsets.symmetric(horizontal: 6),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Stack(
              //         children: [
              //           ClipRRect(
              //             borderRadius: const BorderRadius.only(
              //               topLeft: Radius.circular(16),
              //               topRight: Radius.circular(16),
              //             ),
              //             child: Image.asset(
              //               'assets/images/product_img.png',
              //               height: 184,
              //               width: double.infinity,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           Positioned(
              //             top: 8,
              //             left: 8,
              //             child: !isNew
              //                 ? Container(
              //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //                     decoration: BoxDecoration(
              //                       color: Colors.blue,
              //                       borderRadius: BorderRadius.circular(12),
              //                     ),
              //                     child: const Text(
              //                       '-20%',
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 12,
              //                       ),
              //                     ),
              //                   )
              //                 : Container(
              //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //                     decoration: BoxDecoration(
              //                       color: Colors.black,
              //                       borderRadius: BorderRadius.circular(12),
              //                     ),
              //                     child: const Text(
              //                       'New',
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 12,
              //                       ),
              //                     ),
              //                   ),
              //           ),
              //           const Positioned(
              //             top: 8,
              //             right: 8,
              //             child: CircleAvatar(
              //               backgroundColor: Colors.white,
              //               radius: 16,
              //               child: Icon(
              //                 Icons.favorite_border,
              //                 color: Colors.black,
              //                 size: 16,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       const Padding(
              //         padding: EdgeInsets.all(12.0),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 Icon(Icons.star, color: Colors.orange, size: 16),
              //                 Icon(Icons.star, color: Colors.orange, size: 16),
              //                 Icon(Icons.star, color: Colors.orange, size: 16),
              //                 Icon(Icons.star, color: Colors.orange, size: 16),
              //                 Icon(Icons.star_border, color: Colors.orange, size: 16),
              //                 SizedBox(width: 4),
              //                 Text(
              //                   '(10)',
              //                   style: TextStyle(
              //                     fontSize: 12,
              //                     color: Colors.grey,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 4),
              //             Text(
              //               'Dorothy Perkins',
              //               style: TextStyle(
              //                 fontSize: 12,
              //                 color: Colors.grey,
              //               ),
              //             ),
              //             SizedBox(height: 4),
              //             Text(
              //               'Blouse',
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.black,
              //               ),
              //             ),
              //             SizedBox(height: 4),
              //             Row(
              //               children: [
              //                 Text(
              //                   '\$21',
              //                   style: TextStyle(
              //                     fontSize: 14,
              //                     color: Colors.grey,
              //                     decoration: TextDecoration.lineThrough,
              //                   ),
              //                 ),
              //                 SizedBox(width: 8),
              //                 Text(
              //                   '\$14',
              //                   style: TextStyle(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.blue,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // );
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
