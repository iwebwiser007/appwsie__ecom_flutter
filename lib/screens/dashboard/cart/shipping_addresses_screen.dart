import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/screens/dashboard/cart/edit_address_screen.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/widgets/address_tile_widget.dart';
import 'package:flutter/material.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Shipping Adresses'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const AddressTileWidget(
              isEdit: true,
            ),
            appSpaces.spaceForHeight20,
            const AddressTileWidget(
              isEdit: true,
            ),
            appSpaces.spaceForHeight20,
            const AddressTileWidget(
              isEdit: true,
            ),
            appSpaces.spaceForHeight20,
            const AddressTileWidget(
              isEdit: true,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(const EditAddressScreen());
        },
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
