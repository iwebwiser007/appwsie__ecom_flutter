// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/product_details_model.dart';
import 'package:appwise_ecom/riverpod/loading_state_riverpod.dart';
import 'package:appwise_ecom/screens/dashboard/products/rating_review_screen.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:appwise_ecom/widgets/profile/change_password_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../riverpod/user_data_riverpod.dart';
import '../../../services/base_url.dart';
import '../../../services/product_service.dart';
import '../../../services/request.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/text_utility.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final String? productId;
  final String? productName;

  const ProductDetailsScreen({
    super.key,
    this.productId,
    this.productName,
  });

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  // final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL'];
  final List<String> colors = ['Black', 'White', 'Red', 'Blue'];
  String? selectedProductSize;
  bool isWhislisted = false;
  bool isAddedtoCart = false;
  late ProductService productService;
  ProductDetailsModel? productDetails;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productService = ProductService(ref: ref, context: context);
      getProductDetails(widget.productId.toString());
    });
    super.initState();
  }

  void addToCart() async {
    try {
      final userId = ref.read(userDataProvider)?.id;

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.addToCartUrl,
        body: {
          "user_id": userId,
          "product_id": widget.productId.toString(),
          "size": selectedProductSize ?? '',
          "quantity": "1",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {}
      Utils.snackBar(response.message!, context);

      print(response);
    } catch (e) {
      AppConst.showConsoleLog(e);
    }
  }

  // void addToWishlist() async {
  //   try {
  //     final userId = ref.read(userDataProvider)?.id;

  //     ApiResponse response = await RequestUtils().postRequest(
  //       url: ServiceUrl.addItemToWishlist,
  //       body: {
  //         "user_id": userId,
  //         "product_id": widget.productId.toString(),
  //       },
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       isWhislisted = true;
  //       setState(() {});
  //     }
  //     Utils.snackBar(response.message!, context);

  //     print(response);
  //   } catch (e) {
  //     AppConst.showConsoleLog(e);
  //   }
  // }

  void getProductDetails(String id) async {
    try {
      final userId = ref.read(userDataProvider)?.id.toString();
      setLoader(ref, true);

      ApiResponse response = await RequestUtils().getRequest(
        url: "${ServiceUrl.getProductsDetailsByIdUrl}?id=$id&user_id=$userId",
      );

      if (response.statusCode == 200) {
        productDetails = ProductDetailsModel.fromJson(response.data['data']);
        isWhislisted = productDetails!.isWishlisted!;
        isAddedtoCart = productDetails!.alreadyinCart!;
      }

      setState(() {});
      setLoader(ref, false);
    } catch (e) {
      setLoader(ref, false);

      Utils.snackBar(e.toString(), context);

      AppConst.showConsoleLog(e);
    }
  }

  // void removeItemWishlist(String id) async {
  //   try {
  //     final userId = ref.read(userDataProvider)?.id;

  //     ApiResponse response = await RequestUtils().postRequest(
  //       url: ServiceUrl.removeItemWishlist,
  //       body: {
  //         "user_id": userId,
  //         "product_id": id.toString(),
  //       },
  //       method: 'DELETE',
  //     );

  //     if (response.statusCode == 200) {
  //       isWhislisted = false;
  //       // userWishlistItems.removeAt(index);
  //       setState(() {});
  //       Utils.snackBar(response.message!, context);
  //     }

  //     print(response);
  //   } catch (e) {
  //     AppConst.showConsoleLog(e);
  //   }
  // }

  /// Handle add to wishlist
  void _handleAddToWishlist() async {
    bool added = await productService.addToWishlist(widget.productId!);
    if (added) {
      setState(() {
        isWhislisted = true;
      });
    }
  }

  /// Handle remove from wishlist
  void _handleRemoveFromWishlist() async {
    bool removed = await productService.removeItemWishlist(widget.productId!);
    if (removed) {
      setState(() {
        isWhislisted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedColor = colors[0];
    final loader = ref.watch(isLoadingProvider);

    return Scaffold(
      appBar: customAppBar(
        title: widget.productName,
        trailing: const Icon(Icons.share),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!loader) ...[
              SizedBox(
                height: 400,
                child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      // ImageConstant.add3,
                      imageUrl: safeString(productDetails?.productImage),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Container(
                        //   width: 130,
                        //   alignment: Alignment.center,
                        //   // padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.grey,
                        //     ),
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: DropdownButton<String>(
                        //     value: selectedSize,
                        //     // padding: const EdgeInsets.all(10),
                        //     icon: null,

                        //     dropdownColor: Colors.white,
                        //     items: sizes.map((String value) {
                        //       return DropdownMenuItem<String>(
                        //         value: value,
                        //         child: Text(value),
                        //       );
                        //     }).toList(),
                        //     onChanged: (String? newValue) {
                        //       selectedSize = newValue!;
                        //     },
                        //   ),
                        // ),
                        // appSpaces.spaceForWidth10,
                        Container(
                          width: 130,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            value: selectedColor,
                            items: colors.map(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newValue) {
                              selectedColor = newValue!;
                            },
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 36,
                          width: 36,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (isWhislisted) {
                                _handleRemoveFromWishlist();
                              } else {
                                _handleAddToWishlist();
                              }
                            },
                            icon: Icon(
                              isWhislisted ? Icons.favorite : Icons.favorite_border,
                              size: 20,
                              color: isWhislisted ? Colors.red : Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    appSpaces.spaceForHeight20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: safeString(productDetails?.productName),
                              fontWeight: FontWeight.w800,
                              fontsize: 24,
                            ),
                            const SizedBox(height: 8),
                            AppText(
                              text: showPrice(productDetails?.productPrice.toString()),
                              fontsize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        AppText(
                          text: safeString(productDetails?.description),
                          fontsize: 11,
                          textColor: Colors.grey,
                        ),
                        const SizedBox(height: 8),
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
                              fontsize: 10,
                              textColor: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                    appSpaces.spaceForHeight10,
                    AppText(
                      text: safeString(productDetails?.metaDescription),
                      fontsize: 14,
                      height: 1.3,
                      fontWeight: FontWeight.w200,
                    ),
                    appSpaces.spaceForHeight20,

                    if (productDetails!.alreadyinCart != null && productDetails!.alreadyinCart!)
                      CustomButton(
                        text: 'ADD TO CART',
                        onPressed: () {
                          if (productDetails!.attributes!.isNotEmpty) {
                            renderBottomSheet(
                              context,
                              StatefulBuilder(
                                builder: (context, setstate) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        appSpaces.spaceForHeight20,
                                        const AppText(
                                          text: 'Select Size',
                                          fontWeight: FontWeight.bold,
                                          fontsize: 20,
                                        ),
                                        appSpaces.spaceForHeight20,
                                        Center(
                                          child: Wrap(
                                            spacing: 20,
                                            runSpacing: 20,
                                            children: productDetails!.attributes!.map((size) {
                                              return ChoiceChip(
                                                padding: const EdgeInsets.all(15),
                                                label: Text(safeString(size.size)),
                                                selected: selectedProductSize == size.size,
                                                selectedColor: Colors.black,
                                                backgroundColor: Colors.white,
                                                labelStyle: TextStyle(
                                                  color: selectedProductSize == size.size ? Colors.white : Colors.black,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(color: Colors.black),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                onSelected: (bool isSelected) {
                                                  setstate(() {
                                                    selectedProductSize = isSelected ? size.size! : null;
                                                  });
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        const Spacer(),
                                        CustomButton(
                                          text: 'Add to cart',
                                          onPressed: () {
                                            addToCart();
                                            context.pop();
                                          },
                                        ),
                                        appSpaces.spaceForHeight20,
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            Utils.snackBar('Size not available!', context);
                          }
                        },
                      ),
                    appSpaces.spaceForHeight10,
                    // const ListTile(
                    //   contentPadding: EdgeInsets.zero,
                    //   dense: true,
                    //   title: AppText(
                    //     text: 'Shipping info',
                    //     fontsize: 16,
                    //   ),
                    //   trailing: Icon(
                    //     Icons.arrow_forward_ios_rounded,
                    //     size: 16,
                    //     color: Color(0xff9B9B9B),
                    //   ),
                    // ),
                    // const ListTile(
                    //   contentPadding: EdgeInsets.zero,
                    //   dense: true,
                    //   title: AppText(
                    //     text: 'Support',
                    //   ),
                    //   trailing: Icon(
                    //     Icons.arrow_forward_ios_rounded,
                    //     size: 16,
                    //     color: Color(0xff9B9B9B),
                    //   ),
                    // ),
                    ListTile(
                      onTap: () {
                        context.push(const RatingReviewScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const AppText(
                        text: 'Rate this product',
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Color(0xff9B9B9B),
                      ),
                    ),
                    appSpaces.spaceForHeight20,
                    // const AppText(
                    //   text: 'You can also like this',
                    //   fontWeight: FontWeight.w600,
                    // ),
                    // const ProductListWidget(
                    //   headerTitle: '',
                    //   headerSubtitle: '',
                    //   showHeader: false,
                    // ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
