// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/screens/dashboard/cart/edit_address_screen.dart';
import 'package:appwise_ecom/screens/dashboard/cart/shipping_addresses_screen.dart';

import '../models/address_list_item_model.dart';
import '../utils/app_spaces.dart';
import '../utils/colors.dart';
import '../utils/text_utility.dart';

class AddressTileWidget extends StatefulWidget {
  final AddressListItemModel? adress;

  final bool isEdit;

  const AddressTileWidget({
    super.key,
    this.adress,
    this.isEdit = false,
  });

  @override
  State<AddressTileWidget> createState() => _AddressTileWidgetState();
}

class _AddressTileWidgetState extends State<AddressTileWidget> {
  int? selectedAddressId;

  toggleRememberMe() {
    print(widget.adress?.id);
    setState(() {
      selectedAddressId = widget.adress?.id;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              GestureDetector(
                onTap: () {
                  if (widget.isEdit) {
                    context.push(const EditAddressScreen());
                  } else {
                    context.push(const AddressListScreen());
                  }
                },
                child: AppText(
                  text: widget.isEdit ? "Edit" : 'Change',
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
                      fillColor: selectedAddressId == widget.adress?.id
                          ? null
                          : const WidgetStatePropertyAll(
                              Colors.white,
                            ),
                      value: selectedAddressId == widget.adress?.id,
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
