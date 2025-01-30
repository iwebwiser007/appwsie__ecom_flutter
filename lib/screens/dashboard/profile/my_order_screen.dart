import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/orders_list_model.dart';
import 'package:appwise_ecom/widgets/screen_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../riverpod/user_data_riverpod.dart';
import '../../../services/base_url.dart';
import '../../../services/request.dart';
import '../../../utils/app_spaces.dart';
import '../../../widgets/profile/my_order_card.dart';
import '../../../widgets/profile/order_status_button.dart';

class MyOrderScreen extends ConsumerStatefulWidget {
  const MyOrderScreen({super.key});

  @override
  ConsumerState<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends ConsumerState<MyOrderScreen> {
  int _currentIndex = 0;
  String selectedTab = 'Delivered';
  List<OrdersListItemModel> orderList = [];
  bool _isLoader = false;

  void getOrderListItems() async {
    try {
      final userId = ref.read(userDataProvider)?.id;
      _isLoader = true;
      setState(() {});
      ApiResponse response = await RequestUtils().getRequest(
        url: "${ServiceUrl.getOrderListUrl}?user_id=$userId&status=$selectedTab",
      );

      print(response.data);

      if (response.statusCode == 200) {
        orderList = OrdersListItemModel.fromList(
          List.from(response.data['data']['orders']),
        );
      }
      _isLoader = false;
      setState(() {});
    } catch (e) {
      _isLoader = false;
      setState(() {});
      AppConst.showConsoleLog(e);
    }
  }

  @override
  void initState() {
    getOrderListItems();
    super.initState();
  }

  final items = ["Delivered", "Processing", "Canceled"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenTitleWidget(title: "My Orders"),
            appSpaces.spaceForHeight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items.mapIndexed(
                (index, item) {
                  return orderStatusButton(
                    title: item,
                    isActive: _currentIndex == index,
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                        selectedTab = item;

                        getOrderListItems();
                      });
                    },
                  );
                },
              ),
            ),
            appSpaces.spaceForHeight20,
            if (_isLoader) ...[
              appSpaces.spaceForHeight20,
              const Loader(),
            ] else ...[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: orderList.mapIndexed(
                      (index, order) {
                        return myOrderCard(
                          context,
                          order,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
