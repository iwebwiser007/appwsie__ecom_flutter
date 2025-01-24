import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:flutter/material.dart';

import '../../../customs/custom_appbar.dart';
import '../../../customs/custom_field.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Add Shipping Address'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            customField(
              controller: TextEditingController(),
              labelText: 'Full Name',
            ),
            customField(
              controller: TextEditingController(),
              labelText: 'Address',
            ),
            customField(
              controller: TextEditingController(),
              labelText: 'City',
            ),
            customField(
              controller: TextEditingController(),
              labelText: 'Zip Code (Postal Code)',
            ),
            customField(
              controller: TextEditingController(),
              labelText: 'Country',
            ),
            appSpaces.spaceForHeight30,
            CustomButton(
              text: 'Save Address',
              onPressed: () {
                context.pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
