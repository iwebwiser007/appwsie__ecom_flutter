import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/customs/custom_field.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/screens/auth/forget_password.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/validation/basic_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_constant.dart';
import '../../services/base_url.dart';
import '../../services/request.dart';
import '../../utils/app_spaces.dart';
import '../../utils/common_utils.dart';
import '../../utils/text_utility.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailContorller = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  void changePassword() async {
    try {
      if (_formKey.currentState!.validate()) {
        setLoader(ref, true);
        final Map<String, dynamic> body = {
          "email": emailContorller.text,
          "oldPassword": oldPasswordController.text,
          "newPassword": newPasswordController.text,
          "confirmNewPassword": confirmNewPasswordController.text,
        };

        ApiResponse response = await RequestUtils().postRequest(
          url: ServiceUrl.changePasswordUrl,
          body: body,
          method: 'PUT',
        );

        if (response.statusCode == 200) {
          // context.pushReplacementNamed(RoutePath.loginScreen);
          context.pop();
        }

        Utils.snackBar(response.message!, context);
        setLoader(ref, false);
      }
    } catch (e) {
      print(e);
      setLoader(ref, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColor.appBgColor,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const AppText(
                text: 'Password Change',
                fontsize: 18,
              ),
              appSpaces.spaceForHeight20,
              customField(
                controller: emailContorller,
                hintText: 'Email',
                validator: validateEmail,
              ),
              appSpaces.spaceForHeight20,
              customField(
                controller: oldPasswordController,
                hintText: 'Old Password',
                validator: validatePassword,
              ),
              appSpaces.spaceForHeight15,
              customField(
                controller: newPasswordController,
                hintText: 'New Password',
                validator: validatePassword,
              ),
              appSpaces.spaceForHeight15,
              customField(
                controller: confirmNewPasswordController,
                hintText: 'Repeat New Password',
                validator: (value) {
                  if (newPasswordController.text.isNotEmpty) {
                    if (value == null || value.isEmpty) {
                      // confirmPasswordFocusNode.requestFocus();
                      return 'Please confirm your password';
                    }
                    if (value != newPasswordController.text) {
                      // confirmPasswordFocusNode.requestFocus();
                      return 'Password does not matched!';
                    }
                  }
                  return null;
                },
              ),
              CustomButton(
                text: 'SAVE PASSWORD',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    changePassword();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
