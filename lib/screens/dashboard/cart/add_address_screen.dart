import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../customs/custom_appbar.dart';
import '../../../customs/custom_field.dart';
import '../../../riverpod/user_data_riverpod.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';
import '../../../utils/common_utils.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  final Function refreshAddressList;

  const AddAddressScreen(this.refreshAddressList, {super.key});

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void addAddressFunc() async {
    try {
      final userId = ref.read(userDataProvider)?.id;

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.addAddressUrl,
        body: {
          "user_id": userId,
          "name": nameController.text,
          "address": addressController.text,
          "city": cityController.text,
          "state": stateController.text,
          "country": countryController.text,
          "pincode": zipCodeController.text,
          "mobile": mobileController.text,
          "status": "1",
          "type": ""
        },
      );

      if (response.statusCode == 200) {
        widget.refreshAddressList.call();
        context.pop();
      } else {
        Utils.snackBar(response.message!, context);
      }

      print(response);
    } catch (e) {
      AppConst.showConsoleLog(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Add Shipping Address'),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              customField(
                controller: nameController,
                labelText: 'Full Name',
              ),
              customField(
                controller: addressController,
                labelText: 'Address',
              ),
              customField(
                controller: cityController,
                labelText: 'City',
              ),
              customField(
                controller: zipCodeController,
                labelText: 'Zip Code (Postal Code)',
              ),
              customField(
                controller: countryController,
                labelText: 'Country',
              ),
              appSpaces.spaceForHeight30,
              CustomButton(
                text: 'Save Address',
                onPressed: () {
                  addAddressFunc();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
