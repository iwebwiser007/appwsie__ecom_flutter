import 'package:appwise_ecom/constants/image_constants.dart';
import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/widgets/dashboard_listing_widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/text_utility.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL'];
  final List<String> colors = ['Black', 'White', 'Red', 'Blue'];

  @override
  Widget build(BuildContext context) {
    String selectedSize = sizes[0];
    String selectedColor = colors[0];

    return Scaffold(
      appBar: customAppBar(
        title: 'Short dress',
        trailing: const Icon(Icons.share),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 400,
              child: PageView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Image.asset(
                    ImageConstant.add3,
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
                      Container(
                        width: 130,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          value: selectedSize,
                          // padding: const EdgeInsets.all(10),
                          icon: null,

                          dropdownColor: Colors.white,
                          items: sizes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            selectedSize = newValue!;
                          },
                        ),
                      ),
                      appSpaces.spaceForWidth10,
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
                          value: selectedColor,
                          items: colors.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  appSpaces.spaceForHeight20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: 'T-shirt',
                            fontWeight: FontWeight.w800,
                            fontsize: 24,
                          ),
                          SizedBox(height: 8),
                          AppText(
                            text: '12\$',
                            fontsize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const AppText(
                        text: 'LOST Ink',
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
                  const AppText(
                    text:
                        'Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication.',
                    fontsize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.w200,
                  ),
                  appSpaces.spaceForHeight20,
                  CustomButton(
                    text: 'ADD TO CART',
                    onPressed: () {},
                  ),
                  appSpaces.spaceForHeight10,
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: AppText(
                      text: 'Shipping info',
                      fontsize: 16,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Color(0xff9B9B9B),
                    ),
                  ),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: AppText(
                      text: 'Support',
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Color(0xff9B9B9B),
                    ),
                  ),
                  appSpaces.spaceForHeight20,
                  const AppText(
                    text: 'You can also like this',
                    fontWeight: FontWeight.w600,
                  ),
                  const ProductListWidget(
                    headerTitle: '',
                    headerSubtitle: '',
                    showHeader: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
