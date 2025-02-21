import 'package:appwise_ecom/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_constant.dart';
import '../../models/user_data_model.dart';
import '../../riverpod/bottom_bar_index_provider.dart';
import '../../riverpod/user_data_riverpod.dart';
import '../../routes/app_route.dart';
import '../../services/base_url.dart';
import '../../services/request.dart';
import '../../utils/colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/local_storage.dart';
import '../auth/login_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  void getUserDetails() async {
    try {
      ApiResponse response = await RequestUtils().getRequest(
        url: ServiceUrl.getUserDetailsUrl,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppConst.getAccessToken()}',
        },
      );

      if (response.statusCode == 200) {
        final UserDataModel userData = UserDataModel.fromJson(response.data['data']['user']);
        print(response.data['data']);

        ref.read(userDataProvider.notifier).setUserData(userData);
      }

      if (response.statusCode == 400) {
        Utils.snackBar('Session Expired...Please login again!', context);

        AppConst.setAccessToken(null);
        AppConst.setRefreshToken(null);

        ref.read(userDataProvider.notifier).clearUserData();
        ref.read(bottomBarIndexProvider.notifier).update(0);

        await LocalStorage.removeToken("access_token");
        context.pushReplace(const LoginScreen());
      }
    } catch (e) {
      AppConst.showConsoleLog('e====$e');
    }
  }

  @override
  void initState() {
    getUserDetails();
    AppConst.setOuterContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomBarIndex = ref.watch(bottomBarIndexProvider);

    return Scaffold(
      body: bottomBarItems[bottomBarIndex].screen,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColor.greyTextColor,
              width: 0.3,
            ),
          ),
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: AppColor.primary,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            selectedLabelStyle: const TextStyle(
              color: AppColor.primary,
              fontSize: 12,
            ),
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomBarIndex,
            onTap: (value) {
              ref.read(bottomBarIndexProvider.notifier).update(value);
              setState(() {});
            },
            showUnselectedLabels: true,
            unselectedLabelStyle: const TextStyle(
              color: AppColor.primary,
              fontSize: 12,
            ),
            selectedFontSize: 0,
            unselectedFontSize: 0,
            enableFeedback: false,
            items: List.generate(
              bottomBarItems.length,
              (index) {
                return BottomNavigationBarItem(
                  icon: Container(
                    alignment: Alignment.center,
                    // width: 45,
                    // height: 45,
                    padding: const EdgeInsets.only(top: 10),
                    child: SvgPicture.asset(
                      bottomBarItems[index].svgIcon!,
                      height: 22,
                      width: 22,
                      color: index == bottomBarIndex ? AppColor.primary : null,
                    ),
                  ),
                  label: bottomBarItems[index].label,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
