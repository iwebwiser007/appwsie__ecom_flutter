// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/riverpod/shipping_address_provider.dart';
import 'package:appwise_ecom/screens/dashboard/cart/shipping_addresses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/address_list_item_model.dart';
import '../utils/app_spaces.dart';
import '../utils/colors.dart';
import '../utils/text_utility.dart';

class AddressTileWidget extends ConsumerStatefulWidget {
  final AddressListItemModel? adress;
  final bool isEdit;

  const AddressTileWidget({
    super.key,
    this.adress,
    this.isEdit = false,
  });

  @override
  ConsumerState<AddressTileWidget> createState() => _AddressTileWidgetState();
}

class _AddressTileWidgetState extends ConsumerState<AddressTileWidget> {
  toggleRememberMe() {
    print(widget.adress?.id);
    setState(() {
      ref.read(shippingAddressProvider.notifier).update(widget.adress!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedAddress = ref.watch(shippingAddressProvider);

    return Container(
      // height: 115,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.screenWidth * 0.65,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: widget.adress?.name?.capitalizeFirstLetter() ?? 'Jane Doe',
                      fontWeight: FontWeight.w600,
                      fontsize: 14,
                    ),
                    appSpaces.spaceForHeight10,
                    AppText(
                      fontsize: 14,
                      height: 1.3,
                      text: widget.adress?.address ?? '3 Newbridge Court Chino Hills,\nCA 91709, United States',
                      softwrap: true,
                    ),
                  ],
                ),
              ),
              if (!widget.isEdit)
                GestureDetector(
                  onTap: () {
                    // if (widget.isEdit) {
                    //   context.push(
                    //     AddAddressScreen(() {}),
                    //   );
                    // } else {
                    context.push(const AddressListScreen());
                    // }
                  },
                  child: const AppText(
                    text: 'Change',
                    textColor: AppColor.primary,
                  ),
                ),
            ],
          ),
          appSpaces.spaceForHeight5,
          if (widget.isEdit)
            GestureDetector(
              onTap: toggleRememberMe,
              child: Row(
                children: [
                  SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                      side: const BorderSide(
                        color: AppColor.greyTextColor,
                      ),
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                      fillColor: selectedAddress?.id == widget.adress?.id
                          ? null
                          : const WidgetStatePropertyAll(
                              Colors.white,
                            ),
                      value: selectedAddress?.id == widget.adress?.id,
                      onChanged: (bool? newValue) {
                        toggleRememberMe();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const AppText(
                    text: "Use as the shipping address",
                    fontsize: 14,
                    // textColor: AppColor.blueTextColor,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
