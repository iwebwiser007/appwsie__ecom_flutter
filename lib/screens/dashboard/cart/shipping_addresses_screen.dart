// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:appwise_ecom/customs/custom_appbar.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/address_list_item_model.dart';
import 'package:appwise_ecom/riverpod/user_data_riverpod.dart';
import 'package:appwise_ecom/screens/dashboard/cart/add_address_screen.dart';
import 'package:appwise_ecom/widgets/address_tile_widget.dart';

import '../../../constants/app_constant.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';

class AddressListScreen extends ConsumerStatefulWidget {
  final Function? getShippingCharges;

  const AddressListScreen({
    super.key,
    this.getShippingCharges,
  });

  @override
  ConsumerState<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends ConsumerState<AddressListScreen> {
  bool isLoading = false;
  List<AddressListItemModel> addressList = [];

  void getShippingAddressesList() async {
    final userId = ref.read(userDataProvider)?.id;

    try {
      isLoading = true;
      setState(() {});

      ApiResponse response = await RequestUtils().getRequest(
        url: "${ServiceUrl.getShippingAddressesList}?user_id=$userId",
      );

      if (response.statusCode == 200) {
        addressList = AddressListItemModel.fromList(List.from(response.data['data']));
      }

      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
      AppConst.showConsoleLog(e);
    }
  }

  @override
  void initState() {
    getShippingAddressesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Shipping Adresses'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: addressList.map((e) {
              return AddressTileWidget(
                isEdit: true,
                adress: e,
                getShippingCharges: (id) {
                  widget.getShippingCharges?.call(id);
                },
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(
            AddAddressScreen(
              getShippingAddressesList,
            ),
          );
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
