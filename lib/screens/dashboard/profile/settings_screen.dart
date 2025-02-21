import 'package:appwise_ecom/customs/custom_field.dart';
import 'package:appwise_ecom/widgets/screen_title_widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_spaces.dart';
import '../../../utils/text_utility.dart';
import '../../../widgets/profile/change_password_bottom_sheet.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool sales = false;
  bool newArrival = false;
  bool delieveryStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenTitleWidget(title: "Settings"),
              appSpaces.spaceForHeight25,
              // const AppText(
              //   text: "Personal Information",
              //   fontsize: 16,
              // ),
              // appSpaces.spaceForHeight20,
              // customField(
              //   controller: TextEditingController(),
              //   hintText: "Full name",
              // ),
              // appSpaces.spaceForHeight20,
              // customField(
              //   controller: TextEditingController(),
              //   hintText: "Date of Birth",
              // ),
              appSpaces.spaceForHeight25,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(
                    text: "Password",
                    fontsize: 16,
                  ),
                  InkWell(
                    onTap: () {
                      changePasswordBottomSheet(context);
                    },
                    child: const AppText(
                      text: "Change",
                      fontsize: 14,
                      textColor: Color(0xff9B9B9B),
                    ),
                  ),
                ],
              ),
              appSpaces.spaceForHeight20,
              customField(
                controller: TextEditingController(),
                hintText: "Passwrd",
              ),
              appSpaces.spaceForHeight20,
              const AppText(
                text: "Notifications",
                fontsize: 16,
              ),
              appSpaces.spaceForHeight10,
              notificationUpdateButton(
                title: "Sales",
                isActive: sales,
                onTap: (value) {
                  setState(() {
                    sales = value;
                  });
                },
              ),
              appSpaces.spaceForHeight10,
              notificationUpdateButton(
                title: "New arrivals",
                isActive: newArrival,
                onTap: (value) {
                  setState(() {
                    newArrival = value;
                  });
                },
              ),
              appSpaces.spaceForHeight10,
              notificationUpdateButton(
                title: "Delivery status changes",
                isActive: delieveryStatus,
                onTap: (value) {
                  setState(() {
                    delieveryStatus = value;
                  });
                },
              ),
              appSpaces.spaceForHeight10,
            ],
          ),
        ),
      ),
    );
  }
}

Widget notificationUpdateButton({
  required String title,
  required bool isActive,
  required Function(bool value) onTap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      AppText(
        text: title,
        fontsize: 16,
        fontWeight: FontWeight.w500,
      ),
      Switch.adaptive(
        activeTrackColor: Colors.green,
        value: isActive,
        onChanged: onTap,
      ),
    ],
  );
}
