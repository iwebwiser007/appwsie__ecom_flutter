import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/customs/custom_field.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/validation/basic_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/auth_service.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthServiceProivider? authServiceProivider;

  @override
  void initState() {
    authServiceProivider = AuthServiceProivider(
      ref: ref,
      context: context,
    );
    super.initState();
  }

  // void signUpFunc() async {
  //   try {
  //     if (_formKey.currentState!.validate()) {
  //       setLoader(ref, true);
  //       final Map<String, dynamic> body = {
  //         "name": nameController.text,
  //         "mobile": contactController.text,
  //         "email": emailController.text,
  //         "password": passwordController.text,
  //       };

  //       ApiResponse response = await RequestUtils().postRequest(
  //         url: ServiceUrl.singupUrl,
  //         body: body,
  //       );

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         context.pushReplacementNamed(RoutePath.loginScreen);
  //       }

  //       Utils.snackBar(response.message!, context);
  //       setLoader(ref, false);
  //     }
  //   } catch (e) {
  //     print(e);
  //     setLoader(ref, false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AppText(
                  text: 'Sign up',
                  fontsize: 34,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    customField(
                      controller: nameController,
                      labelText: 'Name',
                      validator: (p0) {
                        return validateForNormalFeild(value: p0, props: 'Name');
                      },
                    ),
                    customField(
                      controller: emailController,
                      labelText: 'Email',
                      validator: validateEmail,
                    ),
                    customField(
                      controller: contactController,
                      labelText: 'Contact number',
                      validator: validateForMobileField,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    customField(
                      controller: passwordController,
                      labelText: 'Password',
                      validator: validatePassword,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: AppText(
                              text: 'Already have an account',
                              fontsize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_alt_outlined,
                            color: AppColor.red,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: 'SIGN UP',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authServiceProivider?.signUpFunc(
                            nameController.text,
                            contactController.text,
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
