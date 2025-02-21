import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../riverpod/selected_brand_provider.dart';
import '../../../utils/app_spaces.dart';

class BrandsListingScreen extends ConsumerStatefulWidget {
  final List<String>? brandsList;

  const BrandsListingScreen({
    super.key,
    this.brandsList,
  });

  @override
  ConsumerState<BrandsListingScreen> createState() => _BrandsListingScreenState();
}

class _BrandsListingScreenState extends ConsumerState<BrandsListingScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> selectedBrands = ref.watch(selectedBrandProvider);

    return Scaffold(
      appBar: customAppBar(title: 'Brands'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText(
              text: 'Choose Brand',
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
                    if (selectedBrands.contains(widget.brandsList?[index])) {
                      ref.read(selectedBrandProvider.notifier).removeBrand(
                            widget.brandsList?[index] ?? "",
                          );
                    } else {
                      ref.read(selectedBrandProvider.notifier).addBrand(
                            widget.brandsList?[index] ?? "",
                          );
                    }
                  },
                  dense: true,
                  title: AppText(text: widget.brandsList![index]),
                  trailing: Checkbox(
                    value: selectedBrands.contains(widget.brandsList?[index]),
                    onChanged: (val) {
                      if (val!) {
                        ref.read(selectedBrandProvider.notifier).addBrand(
                              widget.brandsList?[index] ?? "",
                            );
                      } else {
                        ref.read(selectedBrandProvider.notifier).removeBrand(
                              widget.brandsList?[index] ?? "",
                            );
                      }
                    },
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider(
                  color: Color(0xff9B9B9B),
                  thickness: 0.3,
                );
              },
              itemCount: widget.brandsList!.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ref.read(selectedBrandProvider.notifier).update([]);
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
    );
  }
}
