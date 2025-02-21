import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/all_categories_list_model.dart';
import 'package:appwise_ecom/riverpod/bottom_bar_index_provider.dart';
import 'package:appwise_ecom/screens/dashboard/shop/products_shop_screen.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:appwise_ecom/widgets/catergories_list_tile.dart';
import 'package:appwise_ecom/widgets/no_data_found_widget.dart';
import 'package:appwise_ecom/widgets/screen_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';
import '../../../utils/common_utils.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> with SingleTickerProviderStateMixin {
  // TabController? _tabController;
  List<CategoriesItemModel> categories = [];
  List sections = [];
  bool _isLoader = false;
  int selectedSectionIndex = 0;

  void getAllCategoriesBySection(String id) async {
    try {
      _isLoader = true;
      setState(() {});
      ApiResponse response = await RequestUtils().getRequest(
        url: '${ServiceUrl.getProductCategoriesBySectionUrl}?section_id=$id',
      );

      print(response);

      if (response.statusCode == 200) {
        final List<CategoriesItemModel> responseData = CategoriesItemModel.fromList(
          List.from(response.data['data']),
        );

        categories = responseData;

        print(response.data);

        // Utils.snackBar(response.data['message'], context);
      } else {
        // Utils.snackBar(response.error.toString(), context);
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

  void getAllSection() async {
    try {
      _isLoader = true;
      setState(() {});
      ApiResponse response = await RequestUtils().getRequest(
        url: ServiceUrl.getAllSectionList,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        sections = response.data['data'];
        getAllCategoriesBySection(
          sections.isNotEmpty ? sections.first['id'].toString() : "",
        );

        // _tabController = TabController(length: sections.length, vsync: this);

        // Utils.snackBar(response.data['message'], context);
      } else {
        // Utils.snackBar(response.error.toString(), context);
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

  @override
  void initState() {
    getAllSection();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        ref.read(bottomBarIndexProvider.notifier).update(0);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          toolbarHeight: 30,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenTitleWidget(title: 'Shop'),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sections.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSectionIndex = index;
                      });
                      getAllCategoriesBySection(sections[index]['id'].toString());
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),
                        border: Border(
                          bottom: BorderSide(
                            color: selectedSectionIndex == index ? AppColor.primary : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          sections[index]['name'],
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // TabBar(
            //   splashFactory: NoSplash.splashFactory,
            //   unselectedLabelColor: Colors.black,
            //   tabs: const [
            //     Tab(
            //       icon: AppText(
            //         text: 'Women',
            //       ),
            //     ),
            //     Tab(
            //       icon: AppText(
            //         text: 'Men',
            //       ),
            //     ),
            //     Tab(
            //       icon: AppText(
            //         text: 'Kids',
            //       ),
            //     ),
            //   ],
            //   controller: _tabController,
            //   indicatorSize: TabBarIndicatorSize.tab,
            // ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   margin: const EdgeInsets.all(10),
                    //   height: 100,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     color: AppColor.primary,
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: const Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       AppText(
                    //         text: 'SUMMER SALES',
                    //         textColor: AppColor.white,
                    //         fontWeight: FontWeight.bold,
                    //         fontsize: 24,
                    //       ),
                    //       AppText(
                    //         text: 'Up to 50% off',
                    //         textColor: AppColor.white,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    if (_isLoader && categories.isEmpty) ...[
                      const Loader(),
                    ] else if (!_isLoader && categories.isEmpty) ...[
                      appSpaces.spaceForHeight30,
                      const NoDataFoundWidget()
                    ] else ...[
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              context.push(
                                ProductsListShopScreen(
                                  title: safeString(categories[index].categoryName),
                                  categoryId: safeString(categories[index].id.toString()),
                                ),
                              );
                            },
                            child: CatergoriesListTileWidget(
                              title: safeString(
                                categories[index].categoryName?.capitalizeFirstLetter(),
                              ),
                              image: categories[index].categoryImage?.capitalizeFirstLetter(),
                            ),
                          );
                        },
                      ),
                    ]
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
