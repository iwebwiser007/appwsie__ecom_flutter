// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/widgets/product_item_tile_widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/product_item_widget.dart';

class ProductsListShopScreen extends StatefulWidget {
  final String title;

  const ProductsListShopScreen({
    super.key,
    required this.title,
  });

  @override
  State<ProductsListShopScreen> createState() => _ProductsListShopScreenState();
}

class _ProductsListShopScreenState extends State<ProductsListShopScreen> {
  bool isListView = true;
  final List<String> arr = [
    'T-shirts',
    'Crop tops',
    'Sleeveless',
    'Blouses',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.amber,
      //   forceMaterialTransparency: true,
      //   centerTitle: true,
      //   title: const AppText(
      //     text: 'Womens top',
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      appBar: customAppBar(
        title: widget.title.capitalizeFirstLetter(),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                // BoxShadow(
                //   color: Color.fromARGB(255, 218, 212, 212),
                //   blurRadius: 4,
                //   offset: Offset(0, 2),
                //   blurStyle: BlurStyle.outer,
                // ),
                BoxShadow(
                  color: Color.fromARGB(255, 218, 212, 212),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    itemCount: arr.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xff222222),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          arr[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            // fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.greyBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.filter_list),
                          AppText(
                            text: 'Filter',
                            textAlign: TextAlign.center,
                            fontsize: 14,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          builder: (ctx) {
                            return const Text('data');
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.greyBgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.import_export),
                            AppText(
                              text: 'Price: High to low',
                              textAlign: TextAlign.center,
                              fontsize: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isListView) ...[
                      GestureDetector(
                        onTap: () {
                          isListView = !isListView;
                          setState(() {});
                        },
                        child: const Icon(Icons.view_list),
                      ),
                    ] else ...[
                      GestureDetector(
                        onTap: () {
                          isListView = !isListView;
                          setState(() {});
                        },
                        child: const Icon(Icons.view_module),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (isListView) ...[
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ProductItemTileWidget(
                      // isNew: false,
                      );
                },
              ),
            ),
          ] else ...[
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  return const ProductItemWidget(
                    isNew: false,
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
