// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/product_filters_model.dart';
import 'package:appwise_ecom/screens/dashboard/products/brands_listing_screen.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/widgets/no_data_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../constants/app_constant.dart';
import '../../../riverpod/selected_brand_provider.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';
import '../../../utils/colors.dart';

class ProductFiltersScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final Function({
    String color,
    String brand,
    String size,
    String min,
    String max,
  }) getProductsByCategory;

  const ProductFiltersScreen({
    super.key,
    required this.getProductsByCategory,
    required this.categoryId,
  });

  @override
  ProductFiltersScreenState createState() => ProductFiltersScreenState();
}

class ProductFiltersScreenState extends ConsumerState<ProductFiltersScreen> {
  double _minPrice = 0;
  double _maxPrice = 20;
  List<Color> colors = [
    Colors.black,
    Colors.lightGreen,
    Colors.blue,
    Colors.grey,
    Colors.brown,
    Colors.indigo,
  ];
  Color? selectedColor;
  List<String> sizes = ['XS', 'S', 'M', 'L', 'XL'];
  List<String> selectedSizes = [];
  ProductFiltersModel? productFiltersData;
  bool _isLoader = false;

  void getFiltersByCategoryId() async {
    try {
      _isLoader = true;
      setState(() {});
      // final userId = ref.read(userDataProvider)?.id;
      ApiResponse response = await RequestUtils().getRequest(
        url: "${ServiceUrl.getProductFiltersByCategoryId}?categoryId=${widget.categoryId}=${widget.categoryId}",
      );

      if (response.statusCode == 200) {
        productFiltersData = ProductFiltersModel.fromJson(response.data['data']);
        if (productFiltersData!.priceRange!.min != null && productFiltersData!.priceRange!.max != null) {
          _minPrice = productFiltersData!.priceRange!.min!.toDouble();
          _maxPrice = productFiltersData!.priceRange!.max!.toDouble();
        }
      }

      _isLoader = false;
      setState(() {});
    } catch (e) {
      _isLoader = false;
      setState(() {});
      AppConst.showConsoleLog(e);
    }
  }

  @override
  void initState() {
    getFiltersByCategoryId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> selectedBrand = ref.watch(selectedBrandProvider);

    return Scaffold(
      appBar: customAppBar(title: 'Filters'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoader
              ? const Loader()
              : !_isLoader && productFiltersData == null
                  ? const NoDataFoundWidget()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                              text: 'Price range',
                              fontWeight: FontWeight.w700,
                            ),
                            appSpaces.spaceForHeight10,
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                              child: SfRangeSlider(
                                min: productFiltersData?.priceRange?.min,
                                max: productFiltersData?.priceRange?.max,
                                inactiveColor: Colors.grey,
                                values: SfRangeValues(_minPrice, _maxPrice),
                                onChanged: (SfRangeValues values) {
                                  setState(() {
                                    _minPrice = values.start;
                                    _maxPrice = values.end;
                                  });
                                },
                              ),
                            ),
                            appSpaces.spaceForHeight10,
                            AppText(
                              text: '${showPrice(_minPrice.toString())} - ${showPrice(_maxPrice.toString())}',
                              fontsize: 14,
                            ),
                            appSpaces.spaceForHeight30,
                            const Text(
                              'Colors',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            appSpaces.spaceForHeight10,
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              decoration: const BoxDecoration(
                                color: AppColor.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 218, 212, 212),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Wrap(
                                alignment: WrapAlignment.spaceAround,
                                spacing: 8,
                                children: colors.map(
                                  (color) {
                                    return GestureDetector(
                                      onTap: () => setState(() => selectedColor = color),
                                      child: CircleAvatar(
                                        backgroundColor: color,
                                        radius: 18,
                                        child: selectedColor == color ? const Icon(Icons.check, color: Colors.white) : null,
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            appSpaces.spaceForHeight30,
                            const Text(
                              'Sizes',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            appSpaces.spaceForHeight10,
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              decoration: const BoxDecoration(
                                color: AppColor.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 218, 212, 212),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Wrap(
                                runSpacing: 10,
                                spacing: 8,
                                children: productFiltersData!.sizes!.map((size) {
                                  return ChoiceChip(
                                    padding: const EdgeInsets.all(15),
                                    selectedColor: AppColor.primary,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    label: Text(size),
                                    selected: selectedSizes.contains(size),
                                    onSelected: (bool selected) {
                                      if (selected) {
                                        selectedSizes.add(selected ? size : '');
                                      } else {
                                        selectedSizes.remove(size);
                                      }
                                      setState(() {});
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            appSpaces.spaceForHeight30,
                            GestureDetector(
                              onTap: () {
                                context.push(
                                  BrandsListingScreen(
                                    brandsList: productFiltersData?.brands,
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                color: Colors.transparent,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Brands',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        AppText(
                                          text: 'Selec Brands',
                                          textColor: Colors.grey,
                                          fontsize: 12,
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     orderStatusButton(
                        //       title: "Discard",
                        //       useInCard: true,
                        //       isActive: false,
                        //       onTap: () {},
                        //     ),
                        //     CustomButton(
                        //       height: 40,
                        //       text: 'Apply',
                        //       onPressed: () {},
                        //     )
                        //   ],
                        // )
                        appSpaces.spaceForHeight30,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  context.pop();
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  side: const BorderSide(color: Colors.black),
                                ),
                                child: const AppText(text: 'Discard'),
                              ),
                            ),
                            appSpaces.spaceForWidth20,
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  widget.getProductsByCategory(
                                    size: selectedSizes.isNotEmpty ? selectedSizes.first : '',
                                    min: _minPrice.toString(),
                                    max: _maxPrice.toString(),
                                    brand: selectedBrand.isNotEmpty ? selectedBrand.first : "",
                                    color: '',
                                  );
                                  context.pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                                child: const AppText(
                                  text: 'Apply',
                                  textColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
