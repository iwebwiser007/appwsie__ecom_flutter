// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/product_item_model.dart';
import 'package:appwise_ecom/riverpod/user_data_riverpod.dart';
import 'package:appwise_ecom/screens/dashboard/products/product_filters_screen.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/widgets/no_data_found_widget.dart';
import 'package:appwise_ecom/widgets/product_item_tile_widget.dart';
import 'package:appwise_ecom/widgets/profile/change_password_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/text_utility.dart';
import '../../../widgets/product_item_widget.dart';

class ProductsListShopScreen extends ConsumerStatefulWidget {
  final String title;
  final String categoryId;

  const ProductsListShopScreen({
    super.key,
    required this.title,
    required this.categoryId,
  });

  @override
  ConsumerState<ProductsListShopScreen> createState() => _ProductsListShopScreenState();
}

class _ProductsListShopScreenState extends ConsumerState<ProductsListShopScreen> {
  List<ProductItemModel> productsList = [];

  @override
  void initState() {
    getProductsByCategory();

    super.initState();
  }

  bool _isLoader = false;

  final Map<String, String> sortMapping = {
    'Popular': 'popular',
    'Newest': 'newest',
    'Customer Review': 'customer_review',
    'Price: lowest to high': 'price_lowest',
    'Price: highest to low': 'price_highest',
  };

  String getSortKey(String selectedSort) {
    return sortMapping[selectedSort] ?? 'popular';
  }

  void getProductsByCategory({
    String color = '',
    String brand = '',
    String size = '',
    String min = '',
    String max = '',
  }) async {
    // color, brand, size, min_price, max_price

    try {
      final userId = ref.read(userDataProvider)?.id;
      _isLoader = true;
      setState(() {});
      ApiResponse response = await RequestUtils().getRequest(
        url:
            "${ServiceUrl.getProductsByCategoryIdUrl}?category_id=${widget.categoryId}&user_id=$userId&sort=${getSortKey(selectedSort)}&color=$color&brand=$brand&size=$size&min_price=$min&max_price=$max",
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responsData = ProductItemModel.fromList(List.from(response.data['data']));

        productsList = responsData;
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

  bool isListView = true;
  String selectedSort = 'Price: lowest to high';

  final List<String> sortArr = [
    'Popular',
    'Newest',
    'Customer Review',
    'Price: lowest to high',
    'Price: highest to low',
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
                // // SizedBox(
                // //   height: 45,
                // //   child: ListView.builder(
                // //     itemCount: arr.length,
                // //     scrollDirection: Axis.horizontal,
                // //     itemBuilder: (ctx, index) {
                // //       return Container(
                // //         margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                // //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                // //         alignment: Alignment.center,
                // //         decoration: BoxDecoration(
                // //           color: const Color(0xff222222),
                // //           borderRadius: BorderRadius.circular(20),
                // //         ),
                // //         child: Text(
                // //           arr[index],
                // //           textAlign: TextAlign.center,
                // //           style: const TextStyle(
                // //             color: Colors.white,
                // //             fontWeight: FontWeight.bold,
                // //             // fontSize: 12,
                // //           ),
                // //         ),
                // //       );
                // //     },
                // //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.push(
                            ProductFiltersScreen(
                              categoryId: widget.categoryId,
                              getProductsByCategory: getProductsByCategory,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 4,
                          ),
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
                      ),
                      GestureDetector(
                        onTap: () {
                          renderBottomSheet(
                            context,
                            Column(
                              children: [
                                const AppText(
                                  text: 'Sort By',
                                  fontWeight: FontWeight.bold,
                                  fontsize: 20,
                                ),
                                ListView.separated(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, index) {
                                    return ListTile(
                                      onTap: () {
                                        selectedSort = sortArr[index];
                                        setState(() {});
                                        getProductsByCategory();
                                        context.pop();
                                      },
                                      dense: true,
                                      title: AppText(text: sortArr[index]),
                                    );
                                  },
                                  separatorBuilder: (ctx, index) {
                                    return const Divider(
                                      color: Color(0xff9B9B9B),
                                      thickness: 0.3,
                                    );
                                  },
                                  itemCount: sortArr.length,
                                ),
                              ],
                            ),
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
                          child: Row(
                            children: [
                              const Icon(Icons.import_export),
                              AppText(
                                text: selectedSort,
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
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (_isLoader) ...[
            const Loader(),
          ] else if (!_isLoader && productsList.isEmpty) ...[
            const NoDataFoundWidget(),
          ] else ...[
            if (isListView) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: productsList.length,
                  itemBuilder: (context, index) {
                    return ProductItemTileWidget(
                      // isNew: false,
                      product: productsList[index],
                    );
                  },
                ),
              ),
            ] else ...[
              Expanded(
                child: GridView.builder(
                  itemCount: productsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 340,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItemWidget(
                      isNew: false,
                      product: productsList[index],
                    );
                  },
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
