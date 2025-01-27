import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/all_categories_list_model.dart';
import 'package:appwise_ecom/screens/dashboard/shop/products_shop_screen.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/widgets/catergories_list_tile.dart';
import 'package:appwise_ecom/widgets/screen_title_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_constant.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';
import '../../../utils/common_utils.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<CategoriesItemModel> categories = [];
  bool _isLoader = false;

  void getAllCategories() async {
    try {
      _isLoader = true;
      setState(() {});
      ApiResponse response = await RequestUtils().getRequest(
        url: ServiceUrl.getProductCategories,
      );

      if (response.statusCode == 200) {
        final List<CategoriesItemModel> responseData = CategoriesItemModel.fromList(
          List.from(response.data['data']),
        );

        categories = responseData;

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
    getAllCategories();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        toolbarHeight: 30,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTitleWidget(title: 'Shop'),
          TabBar(
            splashFactory: NoSplash.splashFactory,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(
                icon: AppText(
                  text: 'Women',
                ),
              ),
              Tab(
                icon: AppText(
                  text: 'Men',
                ),
              ),
              Tab(
                icon: AppText(
                  text: 'Kids',
                ),
              )
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: 'SUMMER SALES',
                          textColor: AppColor.white,
                          fontWeight: FontWeight.bold,
                          fontsize: 24,
                        ),
                        AppText(
                          text: 'Up to 50% off',
                          textColor: AppColor.white,
                        ),
                      ],
                    ),
                  ),
                  if (_isLoader && categories.isEmpty) ...[
                    const Loader(),
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
    );
  }
}
