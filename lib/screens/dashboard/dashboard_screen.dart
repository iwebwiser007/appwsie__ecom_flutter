import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_constant.dart';
import '../../riverpod/bottom_bar_index_provider.dart';
import '../../routes/app_route.dart';
import '../../utils/colors.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
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
