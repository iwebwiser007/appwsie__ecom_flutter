import 'package:appwise_ecom/models/address_list_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shippingAddressProvider = StateNotifierProvider<ShippingAddress, AddressListItemModel?>((ref) {
  return ShippingAddress();
});

class ShippingAddress extends StateNotifier<AddressListItemModel?> {
  ShippingAddress() : super(null);

  void update(AddressListItemModel val) {
    state = val;
  }
}
