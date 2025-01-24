import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/screens/dashboard/shop/sub_categories_screen.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/widgets/catergories_list_tile.dart';
import 'package:appwise_ecom/widgets/screen_title_widget.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
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
                  GestureDetector(
                    onTap: () {
                      context.push(const SubCategoriesScreen());
                    },
                    child: const CatergoriesListTileWidget(title: 'New'),
                  ),
                  const CatergoriesListTileWidget(title: 'Clothes'),
                  const CatergoriesListTileWidget(title: 'Shoes'),
                  const CatergoriesListTileWidget(title: 'Accessories'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
