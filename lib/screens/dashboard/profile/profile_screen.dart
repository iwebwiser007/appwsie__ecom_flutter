import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/riverpod/user_data_riverpod.dart';
import 'package:appwise_ecom/routes/route_path.dart';
import 'package:appwise_ecom/screens/dashboard/cart/shipping_addresses_screen.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:appwise_ecom/widgets/screen_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../riverpod/bottom_bar_index_provider.dart';
import '../../../utils/app_spaces.dart';
import '../../../utils/local_storage.dart';
import '../../../utils/text_utility.dart';
import '../../../widgets/profile/profile_detail_item.dart';
import 'my_order_screen.dart';
import 'settings_screen.dart';

class AppProfileScreen extends ConsumerStatefulWidget {
  const AppProfileScreen({super.key});

  @override
  ConsumerState<AppProfileScreen> createState() => _AppProfileScreenState();
}

class _AppProfileScreenState extends ConsumerState<AppProfileScreen> {
  final List<Map<String, dynamic>> items = [
    {
      "title": "My orders",
      "subtitle": "Tap to view",
      "key": "order",
    },
    {
      "title": "Shipping addresses",
      "subtitle": "Tap to view addresses",
      "key": "address",
    },
    // {
    //   "title": "Payment methods",
    //   "subtitle": "Visa  **34",
    // },
    // {
    //   "title": "Promocodes",
    //   "subtitle": "You have special promocodes",
    // },
    // {
    //   "title": "My reviews",
    //   "subtitle": "Reviews for 4 items",
    // },
    {
      "title": "Settings",
      "subtitle": "Notifications, password",
      "key": "settings",
    },
    {
      "title": "Logout",
      "subtitle": "",
      "key": "logout",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final userData = ref.read(userDataProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        ref.read(bottomBarIndexProvider.notifier).update(0);
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ScreenTitleWidget(title: "My profile"),
                  appSpaces.spaceForHeight15,
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 30,
                      child: AppText(
                        text: getInitials(
                          safeString(userData?.name).capitalizeFirstLetter(),
                        ),
                        textColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontsize: 22,
                      ),
                    ),
                    title: AppText(
                      text: safeString(userData?.name).capitalizeFirstLetter(),
                      fontsize: 16,
                    ),
                    subtitle: AppText(
                      text: safeString(userData?.email),
                      fontsize: 12,
                      textColor: const Color(0xff9B9B9B),
                    ),
                  ),
                  appSpaces.spaceForHeight20,
                  ...items.mapIndexed(
                    (index, item) {
                      return profileDetailItem(
                        title: item["title"],
                        subtitle: item["subtitle"],
                        onTap: () async {
                          if (item['key'] == 'order') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyOrderScreen(),
                              ),
                            );
                          }
                          if (item['key'] == 'address') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddressListScreen(),
                              ),
                            );
                          }

                          if (item['key'] == 'settings') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsScreen(),
                              ),
                            );
                          }

                          if (item['key'] == 'logout') {
                            // ref.read(bottomBarIndexProvider.notifier).update(0);
                            context.pushNamedAndRemoveUntil(RoutePath.loginScreen);
                            await LocalStorage.removeToken("access_token");
                            AppConst.setAccessToken(null);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
