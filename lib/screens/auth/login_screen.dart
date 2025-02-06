import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/customs/custom_field.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/user_data_model.dart';
import 'package:appwise_ecom/riverpod/user_data_riverpod.dart';
import 'package:appwise_ecom/routes/route_path.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/validation/basic_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_constant.dart';
import '../../services/base_url.dart';
import '../../services/request.dart';
import '../../utils/common_utils.dart';
import '../../utils/local_storage.dart';
import '../../widgets/screen_title_widget.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void loginFunc() async {
    if (_formKey.currentState!.validate()) {
      try {
        setLoader(ref, true);
        final Map<String, dynamic> body = {
          "email": emailController.text,
          "password": passwordController.text,
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
              const ScreenTitleWidget(title: 'Login'),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  customField(controller: emailController, labelText: 'Email', validator: validateEmail),
                  customField(
                    controller: passwordController,
                    labelText: 'Password',
                    validator: validatePassword,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(RoutePath.forgetPasswordScreen);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: AppText(
                            text: 'Forgot your password?',
                            fontsize: 14,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt_outlined,
                          color: AppColor.primary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'LOGIN',
                    onPressed: () {
                      loginFunc();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(
                        text: "Don't have an account?",
                        fontsize: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          context.pushNamed(RoutePath.signUpScreen);
                        },
                        child: const AppText(
                          text: 'Sign Up',
                          textColor: AppColor.primary,
                          fontsize: 14,
                        ),
                      ),
                    ],
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
