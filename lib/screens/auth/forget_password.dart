import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/customs/custom_field.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/validation/basic_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_constant.dart';
import '../../routes/route_path.dart';
import '../../services/base_url.dart';
import '../../services/request.dart';
import '../../utils/common_utils.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ConsumerState<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void forgetPassword() async {
    try {
      if (_formKey.currentState!.validate()) {
        setLoader(ref, true);
        final Map<String, dynamic> body = {
          "name": emailController.text,
        };

        ApiResponse response = await RequestUtils().postRequest(
          url: ServiceUrl.forgetPasswordUrl,
          body: body,
        );

        if (response.statusCode == 200) {
          context.pushReplacementNamed(RoutePath.loginScreen);
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
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AppText(
                text: 'Forgot Password',
                fontsize: 34,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  customField(controller: emailController, labelText: 'Email', validator: validateEmail),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'SEND',
                    onPressed: () {
                      forgetPassword();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
