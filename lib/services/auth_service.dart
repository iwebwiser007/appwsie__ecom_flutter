import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/services/base_url.dart';
import 'package:appwise_ecom/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_constant.dart';
import '../models/user_data_model.dart';
import '../riverpod/user_data_riverpod.dart';
import '../routes/route_path.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../utils/common_utils.dart';
import '../utils/local_storage.dart';

class AuthServiceProivider {
  final WidgetRef ref;
  final BuildContext context;

  AuthServiceProivider({required this.ref, required this.context});

  Future<void> loginFunc(String email, String password) async {
    try {
      setLoader(ref, true);
      final Map<String, dynamic> body = {
        "email": email,
        "password": password,
      };

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.loginUrl,
        body: body,
      );

      AppConst.showConsoleLog('Response from server: ${response.data}');

      if (response.statusCode == 200) {
        Utils.snackBar(response.data['message'], context);
        final token = response.data['data']["token"];
        final UserDataModel user = UserDataModel.fromJson(response.data['data']["user"]);
        AppConst.setAccessToken(token);

        ref.read(userDataProvider.notifier).setUserData(user);

        ref.read(userDataProvider.notifier);

        context.pushReplace(const DashboardScreen());
        await LocalStorage.saveToken(token: token, key: "access_token");
      } else {
        Utils.snackBar(
          response.error.toString(),
          context,
        );
      }
      setLoader(ref, false);
    } catch (e) {
      setLoader(ref, false);

      print(e);
    }
  }

  void signUpFunc(String name, String mobile, String email, String password) async {
    try {
      setLoader(ref, true);
      final Map<String, dynamic> body = {
        "name": name,
        "mobile": mobile,
        "email": email,
        "password": password,
      };

      ApiResponse response = await RequestUtils().postRequest(
        url: ServiceUrl.singupUrl,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        context.pushReplacementNamed(RoutePath.loginScreen);
      }

      Utils.snackBar(response.message!, context);
      setLoader(ref, false);
    } catch (e) {
      print(e);
      setLoader(ref, false);
    }
  }
}
