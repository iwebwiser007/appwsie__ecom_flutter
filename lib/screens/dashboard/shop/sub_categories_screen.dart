import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/screens/dashboard/shop/products_shop_screen.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({super.key});

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  final List<String> arr = [
    'Tops Shirts & Blouses',
    'Cardigans & Sweaters',
    'Knitwear',
    'Blazers',
    'Outerwear',
    'Pants',
    'Jeans',
    'Shorts',
    'Skirts',
    'Dresses',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(text: 'VIEW ALL ITEMS', onPressed: () {}),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText(
              text: 'Choose category',
              textColor: const Color(0xFF9B9B9B),
              fontsize: 14,
              height: 1.2,
              fontfamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          SizedBox(
            height: context.screenHeight * 0.75,
            child: ListView.separated(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return ListTile(
                  onTap: () {
                    context.push(const ProductsListShopScreen(
                      title: 'title',
                    ));
                  },
                  dense: true,
                  title: AppText(text: arr[index]),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider(
                  color: Color(0xff9B9B9B),
                  thickness: 0.3,
                );
              },
              itemCount: arr.length,
            ),
          ),
        ],
      ),
    );
  }
}
