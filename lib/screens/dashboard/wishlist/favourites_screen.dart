import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:appwise_ecom/models/user_wishlist_items.dart';
import 'package:appwise_ecom/riverpod/user_data_riverpod.dart';
import 'package:appwise_ecom/screens/dashboard/wishlist/wishlist_grid_item.dart';
import 'package:appwise_ecom/screens/dashboard/wishlist/wishlist_list_item.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/widgets/no_data_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';
import '../../../utils/common_utils.dart';
import '../../../widgets/screen_title_widget.dart';

class FavouritesScreen extends ConsumerStatefulWidget {
  const FavouritesScreen({super.key});

  @override
  ConsumerState<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends ConsumerState<FavouritesScreen> {
  bool isListView = true;
  bool isLoading = true;

  final List<String> arr = [
    'T-shirts',
    'Crop tops',
    'Sleeveless',
    'Blouses',
  ];
  List<UserWishlistItems> userWishlistItems = [];

  void getWishListItems() async {
    final userId = ref.read(userDataProvider)?.id;

    try {
      isLoading = true;
      setState(() {});

      ApiResponse response = await RequestUtils().getRequest(
        url: "${ServiceUrl.getuserwishlist}?user_id=$userId",
      );

      if (response.statusCode == 200) {
        userWishlistItems = UserWishlistItems.fromList(
          List.from(response.data['data']),
        );
      }
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
      AppConst.showConsoleLog(e);
    }
  }

  void removeItemWishlist(String id, int index) async {
    try {
      final userId = ref.read(userDataProvider)?.id;

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.removeItemWishlist,
        body: {
          "user_id": userId,
          "product_id": id.toString(),
        },
        method: 'DELETE',
      );

      if (response.statusCode == 200) {
        userWishlistItems.removeAt(index);
        setState(() {});
        Utils.snackBar(response.message!, context);
      }

      print(response);
    } catch (e) {
      AppConst.showConsoleLog(e);
    }
  }

  @override
  void initState() {
    getWishListItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        forceMaterialTransparency: true,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTitleWidget(title: 'Favourites'),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 218, 212, 212),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     // Container(
                //     //   margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //     //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                //     //   alignment: Alignment.center,
                //     //   decoration: BoxDecoration(
                //     //     color: AppColor.greyBgColor,
                //     //     borderRadius: BorderRadius.circular(20),
                //     //   ),
                //     //   child: const Row(
                //     //     children: [
                //     //       Icon(Icons.filter_list),
                //     //       AppText(
                //     //         text: 'Filter',
                //     //         textAlign: TextAlign.center,
                //     //         fontsize: 14,
                //     //       ),
                //     //     ],
                //     //   ),
                //     // ),
                //     // GestureDetector(
                //     //   onTap: () {},
                //     //   child: Container(
                //     //     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //     //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                //     //     alignment: Alignment.center,
                //     //     decoration: BoxDecoration(
                //     //       color: AppColor.greyBgColor,
                //     //       borderRadius: BorderRadius.circular(20),
                //     //     ),
                //     //     child: const Row(
                //     //       children: [
                //     //         Icon(
                //     //           Icons.import_export,
                //     //         ),
                //     //         AppText(
                //     //           text: 'Price: High to low',
                //     //           textAlign: TextAlign.center,
                //     //           fontsize: 14,
                //     //         ),
                //     //       ],
                //     //     ),
                //     //   ),
                //     // ),

                //   ],
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (isLoading) ...[
            const Loader(),
          ] else if (!isLoading && userWishlistItems.isEmpty) ...[
            const NoDataFoundWidget(),
          ] else ...[
            if (isListView) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: userWishlistItems.length,
                  itemBuilder: (context, index) {
                    return WishlistListItem(
                      isFavoriteScreen: true,
                      product: userWishlistItems[index],
                      trailing: GestureDetector(
                        onTap: () {
                          removeItemWishlist(
                            userWishlistItems[index].productDetails!.id.toString(),
                            index,
                          );
                        },
                        child: const Icon(
                          Icons.close,
                          color: Color(0xFF9B9B9B),
                          size: 20,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ] else ...[
              Expanded(
                child: GridView.builder(
                  itemCount: userWishlistItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 340,
                  ),
                  itemBuilder: (context, index) {
                    return WishlistGridItem(
                      isNew: false,
                      product: userWishlistItems[index],
                      isFavoriteScreen: true,
                      trailing: GestureDetector(
                        onTap: () {
                          removeItemWishlist(
                            userWishlistItems[index].id.toString(),
                            index,
                          );
                        },
                        child: const Icon(
                          Icons.h_mobiledata,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
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
