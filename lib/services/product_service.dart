import 'package:appwise_ecom/services/base_url.dart';
import 'package:appwise_ecom/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constant.dart';
import '../riverpod/user_data_riverpod.dart';
import '../utils/common_utils.dart';
import '../models/product_details_model.dart';

class ProductService {
  final WidgetRef ref;
  final BuildContext context;

  ProductService({required this.ref, required this.context});

  /// Get Product Details
  Future<ProductDetailsModel?> getProductDetails(String id) async {
    try {
      final userId = ref.read(userDataProvider)?.id.toString();
      setLoader(ref, true);

      ApiResponse response = await RequestUtils().getRequest(
        url: "${ServiceUrl.getProductsDetailsByIdUrl}?id=$id&user_id=$userId",
      );

      if (response.statusCode == 200) {
        setLoader(ref, false);
        return ProductDetailsModel.fromJson(response.data['data']);
      }

      setLoader(ref, false);
      return null;
    } catch (e) {
      setLoader(ref, false);
      Utils.snackBar(e.toString(), context);
      AppConst.showConsoleLog(e);
      return null;
    }
  }

  /// Add to Cart
  Future<void> addToCart(String productId, String selectedSize) async {
    try {
      final userId = ref.read(userDataProvider)?.id;

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.addToCartUrl,
        body: {
          "user_id": userId,
          "product_id": productId,
          "size": selectedSize.isNotEmpty ? selectedSize : '',
          "quantity": "1",
        },
      );

      Utils.snackBar(response.message ?? "Failed to add to cart", context);
    } catch (e) {
      AppConst.showConsoleLog(e);
    }
  }

  /// Add to Wishlist
  Future<bool> addToWishlist(String productId) async {
    try {
      final userId = ref.read(userDataProvider)?.id;

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.addItemToWishlist,
        body: {
          "user_id": userId,
          "product_id": productId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.snackBar(response.message ?? "Added to wishlist", context);
        return true;
      }
      return false;
    } catch (e) {
      AppConst.showConsoleLog(e);
      return false;
    }
  }

  /// Remove from Wishlist
  Future<bool> removeItemWishlist(String productId) async {
    try {
      final userId = ref.read(userDataProvider)?.id;

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.removeItemWishlist,
        body: {
          "user_id": userId,
          "product_id": productId,
        },
        method: 'DELETE',
      );

      if (response.statusCode == 200) {
        Utils.snackBar(response.message ?? "Removed from wishlist", context);
        return true;
      }
      return false;
    } catch (e) {
      AppConst.showConsoleLog(e);
      return false;
    }
  }
}
