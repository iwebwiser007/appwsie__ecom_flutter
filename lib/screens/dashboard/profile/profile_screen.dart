import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/routes/route_path.dart';
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
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "title": "My orders",
        "subtitle": "Already have 12 orders",
        "key": "order",
      },
      {
        "title": "Shipping addresses",
        "subtitle": "3 ddresses",
      },
      {
        "title": "Payment methods",
        "subtitle": "Visa  **34",
      },
      {
        "title": "Promocodes",
        "subtitle": "You have special promocodes",
      },
      {
        "title": "My reviews",
        "subtitle": "Reviews for 4 items",
      },
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
    return Scaffold(
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
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 30,
                  ),
                  title: AppText(
                    text: "Matilda Brown",
                    fontsize: 16,
                  ),
                  subtitle: AppText(
                    text: "matildabrown@mail.com",
                    fontsize: 12,
                    textColor: Color(0xff9B9B9B),
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
                        if (item['key'] == 'settings') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        }

                        if (item['key'] == 'logout') {
                          AppConst.setAccessToken(null);

                          context.pushNamedAndRemoveUntil(RoutePath.loginScreen);
                          setLoader(ref, false);

                          ref.read(bottomBarIndexProvider.notifier).update(0);
                          await LocalStorage.removeToken("access_token");
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
    );
  }
}
